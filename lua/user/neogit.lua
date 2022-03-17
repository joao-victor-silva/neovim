local neogit_status_ok, neogit = pcall(require, "neogit")
if not neogit_status_ok then
  vim.notify('neogit not found')
  return
end

local diffview_status_ok, _ = pcall(require, "diffview")
if not diffview_status_ok then
  vim.notify('diffview not found')
  return
end

neogit.setup {
  integrations = { diffview = true }
}
