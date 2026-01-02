-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  vim.opt.rtp:prepend(lazypath)
end

-- Plugins
require("lazy").setup({
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
})

-- LSP setup
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.ts_ls.setup{ capabilities = capabilities }
lspconfig.tailwindcss.setup{ capabilities = capabilities }

lspconfig.ts_ls.setup{ capabilities = capabilities }
lspconfig.tailwindcss.setup{ capabilities = capabilities }
lspconfig.marksman.setup{ capabilities = capabilities }
lspconfig.dockerls.setup{ capabilities = capabilities }
lspconfig.terraformls.setup{ capabilities = capabilities }
lspconfig.lua_ls.setup{ capabilities = capabilities }
lspconfig.pyright.setup{ capabilities = capabilities }

-- Completion setup
local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },
  }
})
