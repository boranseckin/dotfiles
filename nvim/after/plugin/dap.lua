local dap = require('dap');
local widgets = require('dap.ui.widgets')

-- Setup the debugger for rust
-- https://github.com/abzcoding/lvim/blob/155160da96b545a6c603f89ca6bd290845af8f8f/lua/user/dap.lua#L42
vim.g.dap_virtual_text = true;
dap.configurations.rust = {
  {
    type = "rt_lldb",
    request = "launch",
    name = "lldbrust",
    program = function()
      local metadata_json = vim.fn.system "cargo metadata --format-version 1 --no-deps";
      local metadata = vim.fn.json_decode(metadata_json);
      local targets = metadata.packages[1].targets;
      local index = 1;
      if #targets > 1 then
        local target_names = {"Launch targets:"};
        for target = 1, #targets do
          target_names[target + 1] = target .. ". " .. targets[target].name
        end
        local selected = vim.fn.inputlist(target_names);
        if selected ~= 0 then index = selected end;
      end
      local target_name = targets[index].name
      local target_dir = metadata.target_directory;
      return target_dir .. "/debug/" .. target_name;
    end,
    args = function()
      local inputstr = vim.fn.input("Params: ", "");
      local params = {};
      local sep = "%s";
      for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(params, str);
      end
      return params;
    end,
  },
};

vim.keymap.set('n', '<Leader>dx', function() dap.continue() end);
vim.keymap.set('n', '<Leader>do', function() dap.step_over() end);
vim.keymap.set('n', '<Leader>di', function() dap.step_into() end);
vim.keymap.set('n', '<Leader>du', function() dap.step_out() end);
vim.keymap.set('n', '<Leader>b',  function() dap.toggle_breakpoint() end);
vim.keymap.set('n', '<Leader>B',  function() dap.set_breakpoint() end);
vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end);
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end);
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end);
vim.keymap.set('n', '<Leader>dh', function() widgets.hover(); end);
vim.keymap.set('n', '<Leader>dp', function() widgets.preview(); end);
vim.keymap.set('n', '<Leader>df', function() widgets.centered_float(widgets.frames); end);
vim.keymap.set('n', '<Leader>ds', function() widgets.centered_float(widgets.scopes); end);
