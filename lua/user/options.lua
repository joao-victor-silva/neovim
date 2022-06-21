-- :help options
-- creates a backup file
vim.opt.backup = false

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menuone", "noselect" }

-- Help to use the relative line moves
vim.opt.number = true
vim.opt.relativenumber = true

-- Set the background to dark and fix the colors problem
-- set background=dark
-- set t_Co=256
vim.opt.termguicolors = true

-- Enable mouse
vim.opt.mouse = "a"

-- Show in bottom right conner the command that you use
vim.opt.showcmd = true

-- Chane the color of open and close brackets and other similar
vim.opt.showmatch = true

-- High light the current line to make easy to see
vim.opt.cursorline = true

-- Change the color of column 80, good to limit the width of code
vim.opt.colorcolumn = "80"

-- Change the visual of character like trim white spaces and tabs
vim.opt.list = true

-- Set zsh as default shell
vim.opt.shell = '/usr/bin/zsh'

vim.opt.tags = 'tags'

-- Code folding
-- Use za: Toggle code folding.
-- zR: Open all folds.
-- zM: Close all folds.
-- zo: Open current fold.
-- zc: Close current fold
-- zf: To mark a piece tex as foldable
vim.opt.foldmethod = "manual"
-- Keep all folds open when a file is opened
vim.api.nvim_exec(
    [[
  augroup OpenAllFoldsOnFileOpen
    autocmd!
    autocmd BufRead * normal zR
  augroup end
  ]],
    false
)

-- Make vim most like new editor, auto closing (), {} and []
-- inoremap ( ()<esc>li
-- inoremap { {}<esc>li
-- inoremap [ []<esc>li
vim.keymap.set("i", "(", "()<esc>i", { silent = true })
vim.keymap.set("i", "{", "{}<esc>i", { silent = true })
vim.keymap.set("i", "[", "[]<esc>i", { silent = true })

-- During a search and replace (:%s/something/new_something/g), show the result preview
-- set inccommand=split (default)

-- Neovide
--
-- To use the neovide as a GUI for neovim you need to download from
-- a Github Actions artifact (login required) or compile the source
-- code
--
-- Set font in GUI mode (neovide)
vim.opt.guifont = "Jetbrains Mono Nerd Font 12"

-- Copy and Paste to/from system clipboard
--
-- There is not has a easy way to copy and paste from system
-- clipboard using Ctrl-C and Ctrl-V that works fine in GUI
-- and terminal, so the best way to copy and paste from
-- clipboard is using the default shortcuts for this.
--
-- "+y: Copy to clipboard (normal and visual mode)
-- "+p: Paste from clipboard (normal mode)
--
-- Obs: Both commands require xclip to work properly
-- vim: ts=2 sts=2 sw=2 et
