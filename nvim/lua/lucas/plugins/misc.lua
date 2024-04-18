return {
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    }, -- Auto-pairing for quotes, parens, brackets, etc.
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                padding = true,
            })
        end,
    }, -- toggle comments
    {
        "fladson/vim-kitty",
        lazy = true,
        event = "VeryLazy",
    },
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({
                integration = {
                    ["nvim-tree"] = {
                        enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
                    },
                },
            })
        end,
    },
    "nvim-lua/plenary.nvim",          -- don't forget to add this one if you don't have it yet!
    "windwp/nvim-ts-autotag",         -- auto close html tags
    "tpope/vim-fugitive",             -- git
    "ThePrimeagen/git-worktree.nvim", -- git worktrees
}
