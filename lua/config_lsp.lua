-- LSP configs

-- Add additional capabilities supported by nvim-cmp
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
local nvim_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('blink.cmp').get_lsp_capabilities(nvim_capabilities)

-- lspconfig
local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
--
-- python language server settings
-- vim.lsp.config('jedi_language_server', {capabilities=capabilities})
-- vim.lsp.enable('jedi_language_server')
vim.lsp.config('ty', {capabilities=capabilities})
vim.lsp.enable('ty')

-- python linting language server
-- lspconfig.ruff.setup{
vim.lsp.config('ruff',
{
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  },
  capabilities = capabilities,
})
vim.lsp.enable('ruff')

-- lspconfig.pyright.setup{capabilities = capabilities}
-- fortran language server settings
vim.lsp.config('fortls',
{
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
})
vim.lsp.enable('fortls')

-- cpp language server settings
vim.lsp.config('clangd',
{
    cmd = {vim.fn.FindClangExe()},
    capabilities = capabilities,
})
vim.lsp.enable('clangd')

-- rust
vim.lsp.config('rust_analyzer',
{
    capabilities = capabilities,
})
vim.lsp.enable('rust_analyzer')

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.pumheight = 15

-- null-ls for adapting lang linters into language servers
local null_ls = require("null-ls")
local null_ls_sources = {
}
null_ls.setup({sources = null_ls_sources})
