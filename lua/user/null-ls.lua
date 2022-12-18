local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    return
end

local DIAGNOSTICS = os.getenv("DIAGNOSTICS") or ""
local FORMATTING = os.getenv("FORMATTING") or ""

local split = function(text, sep)
    local separator, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", separator)
    text:gsub(pattern, function(c)
        fields[#fields + 1] = c
    end)
    return fields
end

local sources = {}
for _, tool in ipairs(split(DIAGNOSTICS)) do
    if tool == "gitlint" then
        table.insert(sources, null_ls.builtins.diagnostics.gitlint.with({ extra_args = { "--contrib=CT1" } }))
    else
        table.insert(sources, null_ls.builtins.diagnostics[tool])
    end
end

for _, tool in ipairs(split(FORMATTING)) do
    table.insert(sources, null_ls.builtins.formatting[tool])
end

null_ls.setup({
    debug = false,
    sources = sources,
})

-- Recommendations
--
-- Lua
-- FORMATTING=stylua
-- DIAGNOSTICS=luacheck:gitlint:cspell:codespell
--
-- Python
-- FORMATTING=black or blue
-- DIAGNOSTICS=mypy:flake8:gitlint:cspell:codespell
--
-- Nix
-- FORMATTING=alejandra
-- DIAGNOSTICS=gitlint:cspell:codespell
