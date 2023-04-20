vim.g.copilot_assume_mapped = true;
vim.g.copilot_no_tab_map = true;

-- Disable copilot in dap-repl
-- https://github.com/neovim/neovim/issues/17615#issuecomment-1176385988
vim.g.copilot_filetypes = { ['dap-repl'] = false };
