return {
	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim" },  -- this is to have it recognise vim. as a global (since it works)
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
