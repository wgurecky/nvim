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

-- opencode.nvim keymaps
vim.keymap.set({ "n", "t" }, "<leader>a", function() require("opencode").toggle() end)
