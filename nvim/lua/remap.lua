vim.g.mapleader = " ";

vim.keymap.set("n", "<leader>ee", vim.cmd.Ex);
vim.keymap.set("n", "<leader>w", vim.cmd.w);
vim.keymap.set("n", "<leader> ", "<C-^>")

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv");
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv");

-- Copy/Paste from/to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y');
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p');
