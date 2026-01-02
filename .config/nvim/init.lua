-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = { "typescript", "tsx", "markdown", "markdown_inline", "lua", "python", "dockerfile", "terraform" },
        highlight = { enable = true },
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
})

-- Basic settings
vim.opt.number = true
vim.opt.expandtab = true          -- spaces instead of tabs
vim.opt.shiftwidth = 2            -- 2 spaces for indent
vim.opt.tabstop = 2               -- 2 spaces per tab
vim.opt.smartindent = true
vim.opt.wrap = false              -- no line wrapping
vim.opt.ignorecase = true         -- case insensitive search
vim.opt.smartcase = true          -- unless you use caps
vim.opt.termguicolors = true      -- better colors
vim.opt.signcolumn = "yes"        -- always show sign column (for LSP errors)
vim.opt.updatetime = 250          -- faster completion
vim.opt.guifont = "Cascadia Code:h13"

-- File type detection
vim.filetype.add({
  extension = {
    mdx = "markdown",
  },
})

-- LSP setup with new vim.lsp.config syntax
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('ts_ls', { capabilities = capabilities })
vim.lsp.config('tailwindcss', { capabilities = capabilities })
vim.lsp.config('marksman', { capabilities = capabilities })
vim.lsp.config('dockerls', { capabilities = capabilities })
vim.lsp.config('terraformls', { capabilities = capabilities })
vim.lsp.config('lua_ls', { capabilities = capabilities })
vim.lsp.config('pyright', { capabilities = capabilities })

vim.lsp.enable({'ts_ls', 'tailwindcss', 'marksman', 'dockerls', 'terraformls', 'lua_ls', 'pyright'})

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "mdx" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    -- Make arrows move by visual lines
    vim.keymap.set('n', '<Down>', 'gj', { buffer = true })
    vim.keymap.set('n', '<Up>', 'gk', { buffer = true })
  end,
})
