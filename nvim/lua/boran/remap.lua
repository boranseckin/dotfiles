vim.g.mapleader = " ";
vim.keymap.set("n", "<leader>ee", vim.cmd.Ex);
vim.keymap.set("n", "<leader>w", vim.cmd.w);
vim.keymap.set("n", "<leader> ", "<C-^>")

-- Escape insert mode
vim.keymap.set("i", "jj", "<ESC>");
vim.keymap.set("i", "kk", "<ESC>");
vim.keymap.set("i", "jk", "<ESC>");
vim.keymap.set("i", "kj", "<ESC>");

-- Escape terminal mode
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>");

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv");
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv");

-- Copy/Paste from/to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y');
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p');

-- Unbind arrow keys
vim.keymap.set({ "n", "v", "i" }, "<Up>", "<Nop>");
vim.keymap.set({ "n", "v", "i" }, "<Down>", "<Nop>");
vim.keymap.set({ "n", "v", "i" }, "<Left>", "<Nop>");
vim.keymap.set({ "n", "v", "i" }, "<Right>", "<Nop>");
