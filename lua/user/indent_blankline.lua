local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

indent_blankline.setup({
    char = "┊",
    filetype_exclude = { "help", "packer" },
    buftype_exclude = { "terminal", "nofile" },
})
-- vim.g.indent_blankline_char_highlight = 'LineNr'
-- vim.g.indent_blankline_show_trailing_blankline_indent = false
