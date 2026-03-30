-- codecompanion.nvim config
--
require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = "anthropic",
      model = "claude-sonnet-4-6"
    },
    inline = {
      adapter = "anthropic",
      model = "claude-sonnet-4-6"
    },
    background = {
      adapter = "anthropic",
      model = "claude-haiku-4-5"
    },
  },
  opts = {
    log_level = "DEBUG",
  },
  extensions = {
    contextfiles = {
      callback = "contextfiles",
      opts = {
        -- by default looks for .cursor/rules in the repo root
        -- you can override the file path here, e.g.:
        -- rules_file = ".context"
      },
    },
    history = {
      enabled = true,
    },
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
