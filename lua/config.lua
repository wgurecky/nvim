-- lspconfig
local lspconfig = require('lspconfig')

-- nvim-tree setup
require'nvim-tree'.setup {}

-- telescope.nvim setup
local actions = require('telescope.actions')
require'telescope'.setup{}

--- lualine settings
require'lualine'.setup{
    options = {
        theme = 'solarized_light',
        icons_enabled = true,
        }
}

--- tabline settings
require("tabline").setup{
    enable = true,
    tabline_show_devicons = true,
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- python language server settings
lspconfig.jedi_language_server.setup{capabilities = capabilities}
-- lspconfig.pyright.setup{capabilities = capabilities}
-- fortran language server settings
lspconfig.fortls.setup{
    cmd = {
        'fortls',
        '--autocomplete_name_only',
        '--incrmental_sync'
    },
    settings = {
        ["fortran-ls"] = {
            variableHover = false
        },
    },
    root_dir = vim.fn.FindTopLevelProjectDir,
    capabilities = capabilities,
}
-- cpp language server settings
lspconfig.clangd.setup{
    cmd = {vim.fn.FindClangExe()},
    capabilities = capabilities,
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip/loaders/from_vscode").load(
    {paths={'~/.config/nvim/my_lsp_snips'}}
)

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}

-- disable all lsp diagnostic virtual text to reduce noise
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
    }
)
