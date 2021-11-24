return require('packer').startup(function()
  use 'wbthomason/packer.nvim'  

  -- language support
  use {
    'ray-x/go.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('go').setup {}
    end
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {}
      -- require('telescope').load_extensions('fzf')
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require'nvim-tree'.setup {}
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    -- 'nvim-treesitter/nvim-treesitter-textobjects',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { 
          "bash",
          "dockerfile",
          "fish",
          "go",
          "gomod",
          "json",
          "lua",
          "python",
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
    config = function()
      require("lspconfig").gopls.setup {}
    end
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
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

end)
