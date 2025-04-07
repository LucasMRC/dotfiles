return {
	cmd = { 'tailwindcss-language-server' },
	filetypes = { --[[  'html', 'css', 'scss', ]] 'svelte', 'htmlhugo', 'gohtmltmpl', 'markdown' },
	root_markers = { 'package.json' },
	settings = {
		experimental = {
			classRegex = {
				'tw-', -- 'tw-' prefix
			}
		},
	},
}
