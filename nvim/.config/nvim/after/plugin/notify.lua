local notify = require("notify")

notify.setup({
	fps = 1,
	level = vim.log.levels.WARN,
	render = "minimal",
	stages = "static",
	timeout = 2000,
})
