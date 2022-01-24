return require('packer').startup(function()
  use 'wbthomason/packer.nvim'  

  -- language support
  use 'https://tildegit.org/sloum/gemini-vim-syntax' -- gemini
  use 'lervag/vimtex' -- LaTeX

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }

  use {
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
          }
        }
      }
      require('telescope').load_extensions('fzf', 'ui-select')
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require("nvim-tree").setup {}
    end
  }

  use {
    "folke/which-key.nvim",
    "b0o/mapx.nvim",
    config = function()
      require("which-key").setup {}
      require("mapx").setup { global = true, whichkey = true }
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    -- 'nvim-treesitter/nvim-treesitter-textobjects',
    run = ':TSUpdate',
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { 
          "bash",
          "dockerfile",
          "fish",
          "go",
          "gomod",
          "json",
          "lua",
          "python",
          "svelte",
          "toml",
          "yaml",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      }
    end
  }

  use 'folke/tokyonight.nvim'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {}
    end
  }

  use {
    'akinsho/bufferline.nvim',
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("bufferline").setup {}
    end
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        char = '▏',
        space_char_blankline = " ",
        -- show_first_indent_level = false,
        show_current_context = true,
        show_current_context_start = true,
      }
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require("lualine").setup {
        options = {
          theme = 'tokyonight'
        }
      }
    end
  }

  use {
    'nvim-lua/popup.nvim'
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("gitsigns").setup {
        signs = {
          add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
          change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
          delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
      }
    end
  }

  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/nvim-cmp',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'onsails/lspkind-nvim',
  }

  use {
    "folke/trouble.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("trouble").setup {}
    end
  }

  use {
    'ray-x/go.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('go').setup {}
    end
  }

  use {
    'simrat39/rust-tools.nvim',
    config = function()
      local nvim_lsp = require'lspconfig'

      local opts = {
        tools = { -- rust-tools options
          autoSetHints = true,
          hover_with_actions = true,
          inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
          },
        },

        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
        server = {
          -- on_attach is a callback called when the language server attachs to the buffer
          -- on_attach = on_attach,
          settings = {
            -- to enable rust-analyzer settings visit:
            -- https:/github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
              -- enable clippy on save
              checkOnSave = {
                command = "clippy"
              },
            }
          }
        },
      }

      require('rust-tools').setup(opts)

    end
  }
end)
