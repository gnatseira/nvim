vim.cmd([[packadd sqlite.lua]])
vim.cmd([[packadd telescope-fzy-native.nvim]])
vim.cmd([[packadd telescope-project.nvim]])
vim.cmd([[packadd telescope-frecency.nvim]])
vim.cmd([[packadd telescope-zoxide]])

local telescope_actions = require("telescope.actions.set")
local fixfolds = {
    hidden = true,
    attach_mappings = function(_)
        telescope_actions.select:enhance({
            post = function()
                vim.cmd(":normal! zx")
            end,
        })
        return true
    end,
}

require("telescope").setup({
    defaults = {
        initial_mode = "insert",
        prompt_prefix = "  ",
        selection_caret = " ",
        entry_prefix = " ",
        scroll_strategy = "limit",
        results_title = false,
        --borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        layout_strategy = "horizontal",
        path_display = { "absolute" },
        file_ignore_patterns = {},
        layout_config = {
            prompt_position = "bottom",
            horizontal = {
                preview_width = 0.5,
            },
        },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        frecency = {
            show_scores = true,
            show_unindexed = true,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
        },
    },
    pickers = {
        buffers = fixfolds,
        find_files = fixfolds,
        git_files = fixfolds,
        grep_string = fixfolds,
        live_grep = fixfolds,
        oldfiles = fixfolds,
    },
})

require('telescope').load_extension('fzy_native')
require("telescope").load_extension("project")
require("telescope").load_extension("zoxide")
require("telescope").load_extension("frecency")
