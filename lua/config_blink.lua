-- utility functions
-- from: https://www.reddit.com/r/neovim/comments/1hfotru/nvimcmp_super_tab_in_blink/
local send_tab_key = function()
  local tab_key = vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
  vim.api.nvim_feedkeys(tab_key, "n", true)
end
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local has_words_before_short = function()
  local ln = vim.api.nvim_get_current_line()
  if ln:match("^%s*$") then
    return false
  else
    return true
  end
end

-- blink.nvim setup
require('blink.cmp').setup({
    completion = {
      menu = {
        auto_show = true,
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      ghost_text = {
        enabled = false,
        show_without_selection = false,
      },
      accept = {
        auto_brackets = {
          enabled = false,
          kind_resolution = {
            enabled = false,
          },
        },
      },
      trigger = {
          show_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
          show_on_accept_on_trigger_character = true,
          show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
--           prefetch_on_insert = true,
--           show_in_snippet = true,
--           show_on_keyword = true,
--           -- You can also block per filetype with a function:
--           -- show_on_blocked_trigger_characters = function(ctx)
--           --   if vim.bo.filetype == 'markdown' then return { ' ', '\n', '\t', '.', '/', '(', '[' } end
--           --   return { ' ', '\n', '\t' }
--           -- end,
--           show_on_x_blocked_trigger_characters = { "'", '"', '(' },
      },
    },
    -- custom tab to cycle config

    keymap = {
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then return cmp.accept()
          elseif has_words_before() and not cmp.is_visible() then return cmp.show()
          elseif cmp.is_visible() then return cmp.select_next()
          else return send_tab_key() end
        end,
        'snippet_forward',
        'fallback'
      },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      -- press Enter to accept suggestion
      ['<CR>'] = { 'accept', 'snippet_forward', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    signature = { enabled = true },
    fuzzy = { implementation = "prefer_rust_with_warning" }
    -- fuzzy = { implementation = "lua" }
})
