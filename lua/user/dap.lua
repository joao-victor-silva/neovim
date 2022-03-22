local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  vim.notify('dap not found')
  return
end

local dap_go_status_ok, dap_go = pcall(require, "dap-go")
if not dap_go_status_ok then
  vim.notify('dap-go not found')
  return
end

dap_go.setup()


