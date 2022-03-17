" Help to use the relative line moves
set number relativenumber

" Set the background to dark and fix the colors problem
" set background=dark
" set t_Co=256

" Enable mouse
set mouse=a

" Show in bottom right conner the command that you use
set showcmd

" Chane the color of open and close brackets and other similar
set showmatch

" High light the current line to make easy to see
set cursorline

" Configure specific for git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" Add dictionary to complete if spell is active
" set complete+=kspell
" set omnifunc=syntaxcomplete#Complete
" set completeopt=menu,menuone,preview,noselect,noinsert

" Change the color of column 80, good to limit the width of code
set colorcolumn=80

" Change the visual of character like trim white spaces and tabs
set list

"
" Vim configures that make use of other plugins unnecessary
"

" With this, the :find can search files recursively
set path+=**

" Create a tag file. You can create a .ctagsignore to ignore files and folders

command! MakeTags !ctags -R --exclude=@.ctagsignore .

" Make the nerd tree unnecessary, just ':edit .' to open file browser
" you can use <CR>, v or t to open in current buffer, open in vertical split
" or in other tab respectively
" disable annoying banner
let g:netrw_banner=0
" open in prior window
let g:netrw_browser_split=4
" open splits to the right
let g:netrw_altv=1
" tree view
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

" Code folding
" Use za: Toggle code folding.
" zR: Open all folds.
" zM: Close all folds.
" zo: Open current fold.
" zc: Close current fold
" zf: To mark a piece tex as foldable
set foldmethod=manual
" Keep all folds open when a file is opened
augroup OpenAllFoldsOnFileOpen
    autocmd!
    autocmd BufRead * normal zR
augroup END

" Make vim most like new editor, auto closing (), {} and []
inoremap ( ()<esc>li
inoremap { {}<esc>li
inoremap [ []<esc>li

" Make more easy go to normal mode, using jk and kj instead of ESC
inoremap jk <esc>
inoremap kj <esc>

function! RepeatDotDown(lines)
	let previous_position = getpos(".")
	for line in range(0, a:lines)
		normal mm.`mj<cr>
	endfor
	call setpos('.', previous_position)
endfunction

function! RepeatMacroDown(lines)
	let previous_position = getpos(".")
	for line in range(0, a:lines)
		normal mm@@`mj<cr>
	endfor
	call setpos('.', previous_position)
endfunction

" TODO: add mark suports

for position in range(0, 9)
	execute 'nnoremap g.'. position .'j :call RepeatDotDown('. position .')<cr>'
endfor
nnoremap g.. :call RepeatDotDown(0)<cr>

for position in range(0, 9)
	execute 'nnoremap g@'. position .'j :call RepeatMacroDown('. position .')<cr>'
endfor
nnoremap g@@ :call RepeatMacroDown(0)<cr>

"
" Neovim feature, during a search and replace (:%s/something/new_something/g)
"
" is possible see a preview of the result of command
if has("nvim")
	set inccommand=split
endif

call plug#begin('$HOME/.local/share/nvim/plugged')
	" Better color scheme
	Plug 'joshdick/onedark.vim'

	" Better status bar
	Plug 'itchyny/lightline.vim'

	" Help to get muscle memory of vim commands
	" Plug 'takac/vim-hardtime'

	" Basic plugins to do commentary and surround code
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'

	" A git tool kit for vim
	Plug 'tpope/vim-fugitive'

	" Github in fugitive
	Plug 'tpope/vim-rhubarb'

	" Configure the editor to use the standard of project
	" if file_readable("./.editorconfig")
	" 	Plug 'editorconfig/editorconfig-vim'
	" endif
	"
	
	" Neovim Lsp
	Plug 'neovim/nvim-lspconfig'
	" Autocompletion
	Plug 'hrsh7th/nvim-compe'
	
	" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	" Plug 'junegunn/fzf.vim'

	" Fuzzy finder in almost everything
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'

	" Modification in files are showed related to the version in git
	" Requirements: plenary.nvim
	Plug 'lewis6991/gitsigns.nvim'

	" Requirements: plenary.nvim
	" Plug 'akinsho/flutter-tools.nvim'

	" Good to seed the time spend in project
	" Plug 'git-time-metric/gtm-vim-plugin'
	
	" Wakatime integration
	" Plug 'wakatime/vim-wakatime'

	" Multi language pack
	Plug 'sheerun/vim-polyglot'

	" Scala specific
	Plug 'scalameta/nvim-metals'

	" A plugin to asynchronous linting that supports language server protocol
	" Plug 'w0rp/ale'

	" Plug 'godlygeek/tabular'
	" Plug 'plasticboy/vim-markdown'

	" Godot GDScript syntax highlight
	" Plug 'calviken/vim-gdscript3'
"
	" C# language server
	" Plug 'OmniSharp/omnisharp-vim'
	" let g:OmniSharp_server_use_mono = 1
	" After use the command below to download OmniSharp
	" :OmniSharpInstall
	"
	" Tagbar with LSP
	Plug 'liuchengxu/vista.vim'
call plug#end()

" Set the colortheme
" Default, if not installed the onedark via plug
" colorscheme darkblue
colorscheme onedark

" If you are using the lightline status bar, uncomment the lines below
let g:lightline = {
	\ 'colorscheme': 'onedark',
	\ }


" Gitsigns setup
lua require('gitsigns').setup()

" Scala metals
lua << EOF
metals_config = require("metals").bare_config
metals_config.settings = {
	showImplicitArguments = true,
	excludePackages = {
		"akka.actor.typed.javadsl",
		"com.github.swagger.akka.javadsl"
	}
}
EOF
augroup lsp
  au!
  au FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)
augroup end


" Font config for neovide, remenber to put neovim in the PATH
" Requirements: install Jetbrains Mono font, see the instructions in the site
set guifont=Jetbrains\ Mono:13

" Config the editorconfig plugin to work with fugitive and ssh
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Telescope config
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader><space> <cmd>Telescope buffers<cr>
nnoremap <leader>l <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>? <cmd>Telescope oldfiles<cr>
nnoremap <leader>sd <cmd>Telescope grep_string<cr>
nnoremap <leader>sp <cmd>Telescope live_grep<cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>gp <cmd>Telescope git_bcommits<cr>

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Flutter-tools config
lua << EOF
  -- require("flutter-tools").setup{} -- use defaults
	-- if you are using Telescope.nvim
	-- require("telescope").load_extension("flutter")
EOF

lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  -- require'completion'.on_attach()

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "tsserver", "gdscript", "cmake", "clangd" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

nvim_lsp["hls"].setup {
	on_attach = on_attach,
	root_dir = vim.loop.cwd
}
EOF

lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
		nvim_lua = true;
		buffer = true;
		calc = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

