vim.opt.nu = true;

vim.opt.swapfile = false;
vim.opt.backup = false;
vim.opt.undodir = os.getenv("HOME") .. "/.local/nvim/undodir";
vim.opt.undofile = true;

vim.opt.tabstop = 2;
vim.opt.softtabstop = 2;
vim.opt.shiftwidth = 2;
vim.opt.expandtab = true;

vim.opt.smartindent = true;

vim.opt.wrap = false;

vim.opt.hlsearch = false;
vim.opt.incsearch = true;

vim.opt.showmode = false;

vim.opt.termguicolors = true;

vim.opt.scrolloff = 8;

vim.opt.colorcolumn = "100";

vim.opt.signcolumn = "yes";

vim.opt.list = true;
vim.opt.listchars = "trail:·,tab:  ";

vim.opt.ignorecase = true;
vim.opt.smartcase = true;

vim.g.netrw_keepdir = 0;
vim.g.netrw_banner = 0;

vim.g.mapleader = " ";
