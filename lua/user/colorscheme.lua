local material_status_ok, _ = pcall(require, "material")
if not material_status_ok then
    vim.notify("material not found")
    return
end

local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
    vim.notify("lualine not found")
    return
end

vim.g.material_style = "deep ocean"

vim.cmd([[
try
  colorscheme material
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])

lualine.setup({
    options = {
        icons_enabled = false,
        theme = "material",
        component_separators = "|",
        section_separators = "",
    },
})
