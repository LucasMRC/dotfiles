require('obsidian').setup({
    workspaces = {
        {
            name = "personal",
            path = "~/Notes/Personal",
        },
        {
            name = "work",
            path = "~/Notes/Work",
        },
    },
    completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
    },
    note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
            end
        end
        return tostring(os.time()) .. "-" .. suffix
    end,
    new_notes_location = "notes_subdir",
    picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        mappings = {
            -- Create a new note from your query.
            new = "<C-x>",
            -- Insert a link to the selected note.
            insert_link = "<C-l>",
        },
    },
    attachments = {
        img_folder = "assets/imgs",
    }
})
