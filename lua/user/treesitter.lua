local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

-- Parsers must be installed manually via :TSInstall
configs.setup({
    ensure_intalled = "all",
    ignore_istall = { "" },
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" },
    },
    autopairs = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = { "" },
    },
})
