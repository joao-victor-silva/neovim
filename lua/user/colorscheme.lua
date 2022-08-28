local catppuccin_status_ok, _ = pcall(require, "catppuccin")
if not catppuccin_status_ok then
    vim.notify("catppuccin not found")
    return
end

local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
    vim.notify("lualine not found")
    return
end

local colorizer_status_ok, colorizer = pcall(require, "colorizer")
if not colorizer_status_ok then
    vim.notify("colorizer not found")
    return
end

vim.g.catppuccin_flavour = "mocha"

vim.cmd([[colorscheme catppuccin]])

lualine.setup({
    options = {
        theme = "catppuccin",
        icons_enabled = true,
        component_separators = "|",
        section_separators = "",
    },
})

colorizer.setup()
