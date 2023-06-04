local builtin = require('telescope.builtin');
require('telescope').load_extension('fzf');

require('telescope').setup({
  pickers = {
    find_files = { theme = "ivy" },
    git_files = { theme = "ivy" },
  },
})

vim.keymap.set('n', '<leader>ff', builtin.find_files, {});
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {});
vim.keymap.set('n', '<leader>fb', builtin.buffers, {});
vim.keymap.set('n', '<leader>gf', builtin.git_files, {});
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {});
vim.keymap.set('n', '<leader>gb', builtin.git_bcommits, {});
vim.keymap.set('n', '<leader>gs', builtin.git_status, {});
vim.keymap.set('n', '<leader>gr', builtin.git_branches, {});
