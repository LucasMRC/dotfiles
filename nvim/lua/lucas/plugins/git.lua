local function map(mode, l, r, opts)
    opts = { desc = opts.desc or "", noremap = opts.noremap or true, silent = opts.silent or true }
    vim.keymap.set(mode, l, r, opts)
end

return {
    "ThePrimeagen/git-worktree.nvim", -- git worktrees
    -- {
        -- "tpope/vim-fugitive",             -- git
    --     config = function()
    --         map("n", "<leader>gg", ":Git<CR>", { desc = "[G]it status" })
    --         map("n", "<leader>gb", ":Git blame<CR>", { desc = "[G]it [b]lame" })
    --         map("n", "<leader>gd", ":Gvdiffsplit<CR>", { desc = "[G]it [d]iff" })
    --     end
    -- },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "FabijanZulj/blame.nvim", -- optional: adds git blame to neogit
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = function()
            local neogit = require("neogit")
            neogit.setup({
                disable_line_numbers = false,
                kind = "auto",
                signs = {
                    -- { CLOSED, OPENED }
                    hunk = { "", "" },
                    item = { "", "" },
                    section = { "", "" },
                },
                integrations = {
                    telescope = true,
                    diffview = false,
                },
                commit_select_view = {
                    kind = "auto",
                },
                log_view = {
                    kind = "auto",
                },
                reflog_view = {
                    kind = "auto",
                },
                mappings = {
                    status = {
                        ["q"] = "Close",
                        ["<c-q>"] = "Close",
                        ["I"] = false,
                        ["1"] = false,
                        ["2"] = false,
                        ["3"] = false,
                        ["4"] = false,
                        ["<tab>"] = false,
                        ["<backspace>"] = "Depth2",
                        ["o"] = "Toggle",
                        ["x"] = "Discard",
                        ["s"] = "Stage",
                        ["S"] = "StageUnstaged",
                        ["<c-s>"] = "StageAll",
                        ["u"] = "Unstage",
                        ["U"] = "UnstageStaged",
                        ["$"] = "CommandHistory",
                        ["#"] = "Console",
                        ["Y"] = "YankSelected",
                        ["<c-r>"] = "RefreshBuffer",
                        ["<enter>"] = "GoToFile",
                        ["<c-v>"] = "VSplitOpen",
                        ["<c-x>"] = "SplitOpen",
                        ["<c-t>"] = false,
                        ["{"] = "GoToPreviousHunkHeader",
                        ["}"] = "GoToNextHunkHeader",
                    },
                }
            })
            require("blame").setup()
            require("diffview").setup({
                hooks = {
                    view_opened = function()
                        require("diffview.actions").toggle_files()
                    end,
                },
                keymaps = {
                    view = {
                        { "n", "<c-q", "<cmd>DiffviewClose<CR>", { silent = true }},
                    }
                }
            })

            map({ "n", "v" }, "<leader>gg", ":Neogit<CR>", { desc = "[G]it status" })
            map({ "n", "v" }, "<leader>gb", ":BlameToggle window<CR>", { desc = "[G]it [b]lame" })
            map({ "n", "v" }, "<leader>gd", ":DiffviewOpen<CR>", { desc = "[G]it [d]iff" })
            map({ "c" }, "G", "!git", {})
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                    change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                    delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                    topdelete = {
                        hl = "GitSignsDelete",
                        text = "‾",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    changedelete = {
                        hl = "GitSignsChange",
                        text = "~",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                },
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text_pos = "eol",
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function mapbf(mode, l, r, opts)
                        opts = { desc = opts.desc or "", noremap = opts.noremap or true, silent = opts.silent or true }
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    mapbf("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    mapbf("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    -- Actions
                    mapbf("n", "<leader>hs", gs.stage_hunk, { desc = "[H]unk [S]tage" })
                    mapbf("n", "<leader>hr", gs.reset_hunk, { desc = "[H]unk [R]eset" })
                    mapbf("v", "<leader>hs", function()
                        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "[H]unk [S]tage" })
                    mapbf("v", "<leader>hr", function()
                        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "[H]unk [R]eset" })
                    mapbf("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[H]unk [U]nstage" })
                    mapbf("n", "<leader>hp", gs.preview_hunk, { desc = "[H]unk [P]review" })
                    mapbf("n", "<leader>hb", function()
                        gs.blame_line({ full = true })
                    end, { desc = "[H]unk [B]lame" })
                    mapbf("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "[H]unk: [T]oggle [B]lame" })
                    mapbf("n", "<leader>htd", gs.toggle_deleted, { desc = "[H]unk: [T]oggle [D]eleted" })

                    -- Text object
                    mapbf({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {})
                end,
            })
        end,
    },
    {
        'akinsho/git-conflict.nvim',
        version = "*",
        config = function()
            require('git-conflict').setup({
                default_mappings = false, -- disable buffer local mapping created by this plugin
                default_commands = true, -- disable commands created by this plugin
                disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
                list_opener = 'copen', -- command or function to open the conflicts list
                highlights = { -- They must have background color, otherwise the default color will be used
                    incoming = 'DiffAdd',
                    current = 'DiffText',
                }
            })

            map('n', '<leader>co', '<Plug>(git-conflict-ours)', { desc = "[C]onflict: Use [O]urs" })
            map('n', '<leader>ct', '<Plug>(git-conflict-theirs)', { desc = "[C]onflict: Use [T]heirs" })
            map('n', '<leader>cb', '<Plug>(git-conflict-both)', { desc = "[C]onflict: Use [B]oth" })
            map('n', '<leader>cn', '<Plug>(git-conflict-none)', { desc = "[C]onflict: Use [N]either" })
            map('n', ']x', '<Plug>(git-conflict-prev-conflict)', {})
            map('n', '[x', '<plug>(git-conflict-next-conflict)', {})
        end,
    }
}
