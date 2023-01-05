require('auto-save').setup({
  enabled = true,
  execution_message = {
		message = function()
			return ("automatically saved at " .. vim.fn.strftime("%H:%M:%S"))
		end,
		dim = 0.18,
		cleaning_interval = 12500,
	},
  trigger_events = {"InsertLeave", "TextChanged"},
})

