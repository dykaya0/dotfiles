return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            delete_to_trash = true,

            keymaps = {
                ["<CR>"] = "actions.select",
                ["<BS>"] = { "actions.parent", mode = "n" },
                ["`"] = {
                    callback = function()
                        require("oil").toggle_float()
                    end,
                    mode = "n",
                },
                ["gd"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        detail = not detail
                        if detail then
                            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,
                },
            },
            float = {
                padding = 4,
                max_width = 0.7,
                max_height = 0.7,
            },
            view_options = {
                show_hidden = true,
            },
        })
    end,
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
}
