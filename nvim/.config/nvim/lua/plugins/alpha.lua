return {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-mini/mini.icons',
        'nvim-lua/plenary.nvim'
    },
    config = function ()
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')

        dashboard.section.header.val = {
                [[                                                     ]],
                [[                                                     ]],
                [[                                                     ]],
                [[                                                     ]],
                [[                                                     ]],
                [[                                                     ]],
                [[                                                     ]],
                [[                                   __                ]],
                [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
         }

        dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "󰍉  Find file", ":Telescope find_files<CR>"),
            dashboard.button("r", "󱝏  MRU files", ":Telescope oldfiles<CR>"),
            dashboard.button("o", "  Browse cwd", ":Oil<CR>"),
            dashboard.button("c", "  Browse .config", ":cd $XDG_CONFIG_HOME | e $XDG_CONFIG_HOME<CR>"),
            dashboard.button("d", "  Browse dotfiles", ":cd $HOME/dotfiles | e $HOME/dotfiles<CR>"),
            dashboard.button("s", "󰯂  Browse scripts", ":cd $XDG_CONFIG_HOME/scripts | e $XDG_CONFIG_HOME/scripts/<CR>"),
            dashboard.button("n", "  Browse nvim config", ":cd $XDG_CONFIG_HOME/nvim | e $XDG_CONFIG_HOME/nvim/<CR>"),
            dashboard.button("m", "  Keymaps", ":cd $XDG_CONFIG_HOME/nvim | e $XDG_CONFIG_HOME/nvim/lua/core/keymaps.lua<CR>"),
            dashboard.button("l", "  Plugins", ":Lazy<CR>"),
            dashboard.button("q", "󰅙  Quit", ":q!<CR>"),
        }

        dashboard.section.footer.val = function()
            return " 󰻀 "
        end

        dashboard.section.buttons.opts.hl = "Keyword"
        dashboard.config.opts.position = "center"
        dashboard.config.opts.noautocmd = true
        alpha.setup(dashboard.opts)
    end
};
