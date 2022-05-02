local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify('telescope not found')
  return
end

telescope.load_extension('fzf')
telescope.load_extension('dap')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { 'rg', '--ignore', '-L', '--hidden', '--files' }
    }
  }
}

-- nnoremap <leader>gc <cmd>Telescope git_commits<cr>
-- nnoremap <leader>gb <cmd>Telescope git_branches<cr>
-- nnoremap <leader>gs <cmd>Telescope git_status<cr>
-- nnoremap <leader>gp <cmd>Telescope git_bcommits<cr>
--
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>sf', function()
  require('telescope.builtin').find_files {previewer = false}
end)
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>st', require('telescope.builtin').tags)
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>so', function()
  require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)
