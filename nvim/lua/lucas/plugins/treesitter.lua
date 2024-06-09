return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = {
                "markdown",
                "markdown_inline",
                "css",
                "javascript",
                "typescript",
                "svelte",
                "go",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "sql",
                "json",
                "bash",
                "gotmpl",
                "yaml",
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["ii"] = "@conditional.inner",
                        ["ai"] = "@conditional.outer",
                        ["il"] = "@loop.inner",
                        ["al"] = "@loop.outer",
                        ["at"] = "@comment.outer",
                    },
                },
            },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = false,

            highlight = {
                enable = true,
            },
            autotag = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        })
        local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
        parser_config["gotmpl"] = {
            install_info = {
                url = "https://github.com/ngalaiko/tree-sitter-go-template",
                files = { "src/parser.c" }
            },
            filetype = "gotmpl",
            used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" }
        }
    end,
}
