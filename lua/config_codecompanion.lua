-- EXPERIMENTAL CLAUDE GENERATED CONTEXT INJECTION

-- optional additional files to inject at codecompanion chat startup
local CC_CONTEXT_FILENAME = ".cc_context.md"
-- Example .cc_context.md content:
--
-- # Context
-- - src/utils.py
-- - docs/api.md
-- - README.md

-- Returns the root of the current git repository, or nil if not in one.
local function get_git_root()
  local result = vim.fn.systemlist("git rev-parse --show-toplevel")
  if vim.v.shell_error ~= 0 or #result == 0 then
    return nil
  end
  return result[1]
end

-- Context file loader for CodeCompanion
-- Defaults to <git_root>/.cc_context.md when md_path is not provided.
-- Relative paths in the markdown are resolved against the git repo root.
local function parse_context_md(md_path)
  local base_dir = get_git_root()
  if not base_dir then
    vim.notify("CCContext: no git repo found, falling back to cwd", vim.log.levels.WARN)
    base_dir = vim.fn.getcwd()
  end
  local expanded = vim.fn.expand(md_path or (base_dir .. "/" .. CC_CONTEXT_FILENAME))
  local ok, lines = pcall(vim.fn.readfile, expanded)
  if not ok then
    vim.notify("CCContext: cannot read '" .. expanded .. "'", vim.log.levels.WARN)
    return {}
  end
  local files = {}
  for _, line in ipairs(lines) do
    local stripped = line:match("^%s*(.-)%s*$")
    if stripped ~= "" and not stripped:match("^#") then
      local path = stripped:match("^[-*]%s+(.+)$")
                or stripped:match("^`(.+)`$")
                or stripped
      path = vim.fn.expand(path)
      if not vim.startswith(path, "/") then
        path = base_dir .. "/" .. path
      end
      if vim.fn.filereadable(path) == 1 then
        table.insert(files, path)
      end
    end
  end
  return files
end

-- Injects .cc_context.md file contents into CodeCompanion chat context
-- by default looks for .cc_context.md in git root dir
function load_files_into_chat_context(chat)
  -- TODO: allow custom context file path
  local files = parse_context_md(nil)
  if #files == 0 then
    -- return
    return vim.notify("CCContext: No .cc_context.md file", vim.log.levels.WARN)
  end
  for _, filepath in ipairs(files) do
    if vim.fn.filereadable(filepath) ~= 1 then
      return vim.notify("CCContext: cannot read '" .. filepath .. "'", vim.log.levels.WARN)
    end
    local ok, lines = pcall(vim.fn.readfile, filepath)
    if not ok then
      return vim.notify("CCContext: failed to read '" .. filepath .. "'", vim.log.levels.WARN)
    end
    local content = table.concat(lines, "\n")
    local short_path = vim.fn.fnamemodify(filepath, ":~:.")
    chat:add_context(
      { role = "user", content = "File: `" .. short_path .. "`\n\n```\n" .. content .. "\n```" },
      "file",
      "<file:" .. short_path .. ">"
    )
    vim.notify("CCContext: added '" .. short_path .. "' to context", vim.log.levels.INFO)
  end
end


-- codecompanion.nvim config
--
require("codecompanion").setup({
  adapters = {
    -- extend copilot adapter
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            default = "claude-3.5-sonnet", -- pin a known streaming-capable model
          },
        },
      })
    end,
  },
  interactions = {
    chat = {
      adapter = "anthropic",
      model = "claude-haiku-4-5",
      -- adapter = "copilot",
      -- model = "claude-sonnet-4-6",
      slash_commands = {
        ['context_file'] = {
          description = "Load files in .cc_context.md into context",
          ---@param chat CodeCompanion.Chat
          callback = function(chat)
            load_files_into_chat_context(chat)
          end,
          opts = {
            contains_code = true,
          },
        },
        ["git_files"] = {
          description = "List git files",
          ---@param chat CodeCompanion.Chat
          callback = function(chat)
            local handle = io.popen("git ls-files")
            if handle ~= nil then
              local result = handle:read("*a")
              handle:close()
              chat:add_context({ role = "user", content = result }, "git", "<git_files>")
            else
              return vim.notify("No git files available", vim.log.levels.INFO, { title = "CodeCompanion" })
            end
          end,
          opts = {
            contains_code = false,
          },
        },
      },
    },
    inline = {
      adapter = "anthropic",
      model = "claude-haiku-4-5"
      -- model = "claude-sonnet-4-6"
      -- adapter = "copilot",
    },
    background = {
      adapter = "anthropic",
      model = "claude-haiku-4-5"
      -- adapter = "copilot",
    },
  },
  opts = {
    log_level = "ERROR",
  },
  extensions = {
    contextfiles = {
      -- callback = "contextfiles",
      opts = {
        -- by default looks for .cursor/rules in the repo root
        -- you can override the file path here, e.g.:
        -- rules_file = ".context"
      },
    },
    history = {
      enabled = true,
    },
--     vectorcode = {
--       opts = {
--         tool_opts = {
--         },
--       },
--     },
  },
})

-- codecompanion keymaps
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

-- Notes
--
-- Chat buffer keybinds:
-- The keymaps available to the user in normal mode are:
--     <CR>|<C-s> to send a message to the LLM
--     <C-c> to close the chat buffer
--     q to stop the current request
--     ga to change the adapter for the currentchat
--     gba to sync the entire buffer on every turn
--     gbd to sync only a buffers diff on every turn
--     gc to insert a codeblock in the chat buffer
--     gd to view/debug the chat buffer's contents
--     gf to fold any codeblocks in the chat buffer
--     gM to clear all rules from the chat buffer
--     gr to regenerate the last response
--     gR to go to the file under cursor. If the file is already opened, it'll jump to the existing window. Otherwise, it'll be opened in a new tab.
--     gs to toggle the system prompt on/off
--     gS to show copilot usage stats
--     gta to toggle auto tool mode
--     gx to clear the chat buffer's contents
--     gy to yank the last codeblock in the chat buffer
--     [[ to move to the previous header
--     ]] to move to the next header
--     { to move to the previous chat
--     } to move to the next chat

