local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    vim.notify("null-ls not found")
    return
end

null_ls.setup({
    debug = false,
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.luacheck,
    },
})
