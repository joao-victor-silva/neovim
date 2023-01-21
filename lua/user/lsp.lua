local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
    return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
    return
end

local flutter_status_ok, flutter_tools = pcall(require, "flutter-tools")
if not flutter_status_ok then
    return
end

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

local disable_format = {}
disable_format["sumneko_lua"] = true
disable_format["pylsp"] = true

local on_attach = function(client, bufnr)
    if disable_format[client.name] then
        client.server_capabilities.documentFormattingProvider = false
    end

    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
        vim.inspect(vim.lsp.buf.list_workspace_folders())
    end)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, opts)
    vim.keymap.set("n", "<leader>so", require("telescope.builtin").lsp_document_symbols, opts)
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, opts)

    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- nvim-cmp supports additional completion capabilities
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Enable the following language servers
local LANGUAGE_SERVER = os.getenv("LANGUAGE_SERVER") or ""
local split = function(text, sep)
    local separator, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", separator)
    text:gsub(pattern, function(c)
        fields[#fields + 1] = c
    end)
    return fields
end

local servers = {}
for _, server in ipairs(split(LANGUAGE_SERVER)) do
    table.insert(servers, server)
end

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local globals = { "vim", "use" }
local library = vim.api.nvim_get_runtime_file("", true)

-- AwesomeWM specific
table.insert(library, "/usr/share/awesome/lib")
table.insert(globals, "awesome")
table.insert(globals, "client")
table.insert(globals, "root")
table.insert(globals, "screen")

lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = globals,
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = library,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

local util = require("lspconfig.util")

lspconfig.haxe_language_server.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "node", os.getenv("HOME") .. "/Tools/haxe-language-server/bin/server.js" },
    root_dir = util.root_pattern("*.hxml", "*.xml"),
    init_options = {
        displayArguments = {
            "Project.xml",
            "--cwd " .. os.getenv("HOME") .. "/Projects/breakout",
            "build.xml",
        },
    },
})

flutter_tools.setup({
    lsp = {
        on_attach = on_attach,
        capabilities = capabilities,
    },
})
