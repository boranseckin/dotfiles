vim.g.mapleader = " ";
vim.keymap.set("n", "<leader>ee", vim.cmd.Ex);
vim.keymap.set("n", "<leader>w", vim.cmd.w);
vim.keymap.set("n", "<leader> ", "<C-^>")

-- Escape insert mode
vim.keymap.set("i", "jj", "<ESC>");
vim.keymap.set("i", "kk", "<ESC>");

-- Escape terminal mode
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>");

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv");
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv");

-- Copy/Paste from/to system clipboard
vim.keymap.set("n", "<leader>y", '"+y');
vim.keymap.set("v", "<leader>y", '"+y');
vim.keymap.set("n", "<leader>p", '"+p');
vim.keymap.set("v", "<leader>p", '"+p');
