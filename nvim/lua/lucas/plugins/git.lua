local function map(mode, l, r, opts)
    opts = { desc = opts.desc or "", noremap = opts.noremap or true, silent = opts.silent or true }
    vim.keymap.set(mode, l, r, opts)
end

return {
    "ThePrimeagen/git-worktree.nvim", -- git worktrees
    {
        "tpope/vim-fugitive",         -- git
        config = function()
            map("n", "<leader>gg", ":Git<CR>", { desc = "[G]it status" })
            map("n", "<leader>gb", ":Git blame<CR>", { desc = "[G]it [b]lame" })
            map("n", "<leader>gd", ":Gvdiffsplit<CR>", { desc = "[G]it [d]iff" })
        end
    },
    -- {
    --     "NeogitOrg/neogit",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",         -- required
    --         "sindrets/diffview.nvim",        -- optional - Diff integration
    --         "FabijanZulj/blame.nvim",        -- optional: adds git blame to neogit
    --         "nvim-telescope/telescope.nvim", -- optional
    --     },
    --     config = function()
    --         local neogit = require("neogit")
    --         neogit.setup({
    --             disable_line_numbers = false,
    --             kind = "split",
    --             signs = {
    --                 -- { CLOSED, OPENED }
    --                 hunk = { "", "" },
    --                 item = { "", "" },
    --                 section = { "", "" },
    --             },
    --             integrations = {
    --                 telescope = true,
    --             },
    --             commit_select_view = {
    --                 kind = "split",
    --             },
    --             log_view = {
    --                 kind = "split",
    --             },
    --             reflog_view = {
    --                 kind = "split",
    --             },
    --             mappings = {
    --                 status = {
    --                     ["q"] = "Close",
    --                     ["<c-q>"] = "Close",
    --                     ["I"] = false,
    --                     ["1"] = false,
    --                     ["2"] = false,
    --                     ["3"] = false,
    --                     ["4"] = false,
    --                     ["<tab>"] = false,
    --                     ["<backspace>"] = "Depth2",
    --                     ["o"] = "Toggle",
    --                     ["x"] = "Discard",
    --                     ["s"] = "Stage",
    --                     ["S"] = "StageUnstaged",
    --                     ["<c-s>"] = "StageAll",
    --                     ["u"] = "Unstage",
    --                     ["U"] = "UnstageStaged",
    --                     ["$"] = "CommandHistory",
    --                     ["#"] = "Console",
    --                     ["Y"] = "YankSelected",
    --                     ["<c-r>"] = "RefreshBuffer",
    --                     ["<enter>"] = "GoToFile",
    --                     ["<c-v>"] = "VSplitOpen",
    --                     ["<c-x>"] = "SplitOpen",
    --                     ["<c-t>"] = false,
    --                     ["{"] = "GoToPreviousHunkHeader",
    --                     ["}"] = "GoToNextHunkHeader",
    --                 },
    --             }
    --         })
    --         require("blame").setup()
    --         local actions = require("diffview.actions")
    --         require("diffview").setup({
    --             hooks = {
    --                 view_opened = function()
    --                     actions.toggle_files()
    --                 end,
    --             },
    --             keymaps = {
    --                 view = {
    --                     { "n", "<c-q>",      "<cmd>DiffviewClose<CR>",              { silent = true } },
    --                     { "n", "[x",         actions.prev_conflict,                 { desc = "Prev conflict" } },
    --                     { "n", "]x",         actions.next_conflict,                 { desc = "Next conflict" } },
    --                     { "n", "<leader>co", actions.conflict_choose("ours"),       { desc = "[C]onflict: choose [O]urs" } },
    --                     { "n", "<leader>ct", actions.conflict_choose("theirs"),     { desc = "[C]onflict: choose [T]heirs" } },
    --                     { "n", "<leader>cb", actions.conflict_choose("base"),       { desc = "[C]onflict: choose [B]ase" } },
    --                     { "n", "<leader>ca", actions.conflict_choose("all"),        { desc = "[C]onflict: choose [A]ll" } },
    --                     { "n", "<leader>cn", actions.conflict_choose("none"),       { desc = "[C]onflict: choose [N]one" } },
    --                     { "n", "<leader>cO", actions.conflict_choose_all("ours"),   { desc = "[C]onflict: always choose [O]urs" } },
    --                     { "n", "<leader>cT", actions.conflict_choose_all("theirs"), { desc = "[C]onflict: always choose [T]heirs" } },
    --                     { "n", "<leader>cB", actions.conflict_choose_all("base"),   { desc = "[C]onflict: always choose [B]ase" } },
    --                     { "n", "<leader>cA", actions.conflict_choose_all("all"),    { desc = "[C]onflict: always choose [A]ll" } },
    --                     { "n", "<leader>cN", actions.conflict_choose_all("none"),   { desc = "[C]onflict: always choose [N]one" } },
    --                 }
    --             }
    --         })
    --
    --         map({ "n", "v" }, "<leader>gg", ":Neogit<CR>", { desc = "[G]it status" })
    --         map({ "n", "v" }, "<leader>gb", ":BlameToggle window<CR>", { desc = "[G]it [b]lame" })
    --         map({ "n", "v" }, "<leader>gd", ":DiffviewOpen<CR>", { desc = "[G]it [d]iff" })
    --         map({ "c" }, "G", "!git", {})
    --     end
    -- },
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
    }
}
