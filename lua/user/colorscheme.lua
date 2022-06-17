vim.cmd([[
try
  colorscheme dracula
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    vim.notify("lualine not found")
    return
end

lualine.setup({
    options = {
        icons_enabled = false,
        theme = "dracula",
        component_separators = "|",
        section_separators = "",
    },
})
