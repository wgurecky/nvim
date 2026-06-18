-- config_opencode.lua
--
-- This file is intentionally minimal; opencode's
-- model and provider are set outside Neovim in ~/.config/opencode/opencode.jsonc.
-- opencode theme is set in ~/.config/opencode/tui.jsonc.
--
-- Example ~/.config/opencode/opencode.jsonc:
--
--   {
--     "$schema": "https://opencode.ai/opencode.json",
--     "model": "anthropic/claude-sonnet-4-5"
--   }
--
-- vim.env.OPENCODE_CONFIG_DIR = "~/.config/nvim/.opencode/"

-- opencode.nvim config
-- require("opencode").setup({
-- })
local opencode_buf = nil

local function toggle_opencode()
  -- If buffer exists and is valid, check if it's visible in a window
  if opencode_buf and vim.api.nvim_buf_is_valid(opencode_buf) then
    local win = vim.fn.bufwinid(opencode_buf)
    if win ~= -1 then
      vim.api.nvim_win_close(win, true) -- Close it if open
    else
      vim.cmd("vsplit | b " .. opencode_buf) -- Open it if hidden
    end
  else
    -- Create a new terminal split running the server
    vim.cmd("vsplit | term opencode --port")
    opencode_buf = vim.api.nvim_get_current_buf()
  end
end

-- opencode.nvim keymaps
vim.keymap.set({ "n", "t" }, "<leader>a", toggle_opencode, { desc = "Toggle OpenCode" })
vim.keymap.set({ "n", "x", "v" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })

-- Custom commands for visual model selection
vim.api.nvim_create_user_command(
  'LLMdocument',
  function ()
    require("opencode").prompt("@build: Add a doc string to @this method.", { submit = true })
    -- require("opencode").command("prompt.submit")
    -- require("opencode").ask("Add a doc string to @this method.")
  end,
  {nargs = 0, range = true}
)

vim.api.nvim_create_user_command(
  'LLMexplain',
  function ()
    -- require("opencode").prompt("@plan: ")
    -- require("opencode").operator("@this ")
    -- require("opencode").prompt(" Explain this method.", { submit = true })
    require("opencode").operator("@plan: Explain @this method.", { submit = true })
    -- require("opencode").command("prompt.submit")
    -- require("opencode").ask("Explain @this method.")
  end,
  {nargs = 0, range = true}
)

vim.api.nvim_create_user_command(
  'LLMreview',
  function ()
    require("opencode").prompt("@plan: Provide a code review of @this", { submit = true })
    -- require("opencode").command("prompt.submit")
    -- require("opencode").ask("Plan Provide a code review of @this")
  end,
  {nargs = 0, range = true}
)

vim.api.nvim_create_user_command(
  'LLMimprove',
  function ()
    require("opencode").prompt("@plan: Given the context of the file @buffer , suggest improvement of @this", { submit = true })
    -- require("opencode").command("prompt.submit")
    -- require("opencode").ask("Plan Provide a code review of @this")
  end,
  {nargs = 0, range = true}
)

vim.api.nvim_create_user_command(
  'LLMoptimize',
  function ()
    require("opencode").prompt("@plan: Given the context of the file @buffer , suggest optimizations of @this method", { submit = true })
    -- require("opencode").command("prompt.submit")
    -- require("opencode").ask("Plan Provide a code review of @this")
  end,
  {nargs = 0, range = true}
)
