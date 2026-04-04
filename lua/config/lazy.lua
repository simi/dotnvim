-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- vim
vim.g.mapleader = ","
vim.opt.compatible = false
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- disable animations
vim.g.neovide_position_animation_length = 0
vim.g.neovide_cursor_animation_length = 0.00
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0.00

-- Indentation and file handling
vim.opt.autoindent = true
vim.opt.history = 50
vim.opt.showcmd = true
vim.opt.incsearch = true
vim.opt.wildmode = { "list:full" }

-- Tabs and spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- GUI settings (if applicable)
if vim.g.neovide then
  vim.opt.guifont = "DejaVu Sans Mono:h12"
end

-- Security and backup
vim.opt.secure = true
vim.opt.backupdir = "/tmp"
vim.opt.directory = "/tmp"

-- UI settings
vim.opt.termguicolors = true
vim.opt.scrolloff = 2
vim.opt.laststatus = 1

-- Tags
vim.opt.tags:append({".git/tags", "gems.tags"})

-- Shortcuts
-- vim.api.nvim_set_keymap('n', '<Leader>d', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<F9>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-P>", ":Telescope<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F9>", ":NERDTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>d", ":NERDTreeFind<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>rt', function()
 vim.fn.system('git rev-parse --is-inside-work-tree')
 if vim.v.shell_error == 0 then
   vim.cmd('!git ls-files | ctags --extras=+f -L -')
 else
   vim.cmd('!ctags --exclude=node_modules --extras=+f -R *')
 end
end, { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>re', ':!ctags -f gems.tags -R --languages=ruby --exclude=node_modules --exclude=.git --exclude=log . $(rb x bundle list --paths)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : \"\\<CR>\"", { expr = true, silent = true })

-- Vimwiki settings
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_list = {
  {
    nested_syntaxes = { ruby = "ruby", bash = "sh", scala = "scala", sql = "sql", python ="python" },
    syntax = "markdown",
    ext = ".md",
    path = "~/vimwiki"
  }
}

-- -- CtrlP ignore
-- vim.g.ctrlp_custom_ignore = 'node_modules'

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})

vim.g.NERDTreeIgnore = { '__pycache__' }
