-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim ...")
    vim.cmd([[packadd packer.nvim]])
end

-- Auto-command that reloads neovim whenever you save the plugins.lua file
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    command = "source <afile> | PackerSync",
    group = packer_group,
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("packer not found")
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- Package manager
    use("wbthomason/packer.nvim")

    -- Common plugin dependencies
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")

    -- "gc" to comment visual regions/lines
    use("numToStr/Comment.nvim")

    -- Better color scheme
    use("catppuccin/nvim")

    -- Better statusline
    use("nvim-lualine/lualine.nvim")

    -- Basic plugins to do surround code
    use("tpope/vim-surround")

    -- Fuzzy finder in almost everything
    use("nvim-telescope/telescope.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    -- Add indentation guides even on blank lines
    use("lukas-reineke/indent-blankline.nvim")

    -- Add git related info in the signs columns and popups
    use("lewis6991/gitsigns.nvim")

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    -- Additional textobjects for treesitter
    use("nvim-treesitter/nvim-treesitter-textobjects")

    -- Autocompletion plugins
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("saadparwaiz1/cmp_luasnip")

    -- Snippets plugins
    use("L3MON4D3/LuaSnip")

    -- Collection of configurations for built-in LSP client
    use("neovim/nvim-lspconfig")

    -- Collection of lsp installers
    use("williamboman/nvim-lsp-installer")

    -- Collection of configurations for linters and formatters
    use("jose-elias-alvarez/null-ls.nvim")

    -- Icons and file tree view
    use("kyazdani42/nvim-web-devicons")
    use("kyazdani42/nvim-tree.lua")

    -- Debug
    use("mfussenegger/nvim-dap")
    use("nvim-telescope/telescope-dap.nvim")

    -- Tag-bar with LSP
    use("liuchengxu/vista.vim")

    -- use 'rafcamlet/nvim-luapad'
    use("akinsho/toggleterm.nvim")

    -- Color on hex-codes
    use("norcalli/nvim-colorizer.lua")

    -- Haxe/Flixel related plugins
    use("jdonaldson/vaxe")
    use("quangnguyen30192/cmp-nvim-tags")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
