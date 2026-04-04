return {
  -- {
  --   "williamboman/mason.nvim",
  --   config = function()
  --     require("mason").setup()
  --   end,
  -- },
  {
    "sotte/presenting.nvim",
    cmd = { "Presenting" },
    config = function()
      require("presenting").setup({
        options = {
          width = 80,
        },
        separator = {
          markdown = "^# "
        }
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "bash",
          "typescript",
          "tsx",
          "javascript",
          "lua",
          "markdown",
          "markdown_inline",
          "sql",
          "python",
          "ruby"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false, -- disables slow legacy syntax
        },
      }
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'neovim/nvim-lspconfig',
  },
  {
    'lewis6991/gitsigns.nvim',
  },
  { "neoclide/coc.nvim", branch='release', },
  {
    'mrcjkb/rustaceanvim',
    lazy = false, -- This plugin is already lazy
    tag = 'v5.26.0'
  },
  {
    'nanotech/jellybeans.vim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("jellybeans")
      -- Override diff highlights to bg-only so syntax colours show through
      vim.api.nvim_set_hl(0, "DiffAdd",    { bg = "#1e3a1e" })
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3a1e1e" })
      vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1e1e3a" })
      vim.api.nvim_set_hl(0, "DiffText",   { bg = "#2e2e1e", bold = true })
      -- Workaround for neovim#9800: CursorLine in diff regions gets an unwanted
      -- underline when guifg is unset. Scoped to diff windows via winhighlight
      -- so normal editing CursorLine (bg-only) is unchanged.
      local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal",     link = false }).fg
      local cursor_bg = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false }).bg
      vim.api.nvim_set_hl(0, "DiffCursorLine", { fg = normal_fg, bg = cursor_bg })
    end,
  },
  { "preservim/nerdtree", },
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   version = "*",
  --   lazy = false,
  --   config = function()
  --     require("nvim-tree").setup({
  --       update_cwd          = true,
  --       update_focused_file = {
  --         enable      = true,
  --         update_cwd  = true,
  --         ignore_list = {}
  --       },
  --       renderer = {
  --         icons = {
  --           show = {
  --             file = false,
  --             folder = false,
  --           }
  --         }
  --       }
  --     })
  --   end,
  -- },
  {
    "preservim/tagbar",
  },
  -- {
  --   "kien/ctrlp.vim",
  -- },
  {
    "vimwiki/vimwiki",
  },
  {
    "easymotion/vim-easymotion",
  },
  {
    "vim-airline/vim-airline",
  },
  {
    "vim-ruby/vim-ruby",
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>", desc = "Diff vs default branch" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>",                         desc = "File history" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>",                                 desc = "Close diffview" },
    },
    opts = {
      use_icons = false,
      enhanced_diff_hl = true,
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
      hooks = {
        diff_buf_win_enter = function(_, winid, _ctx)
          vim.wo[winid].winhighlight = "CursorLine:DiffCursorLine"
        end,
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  }
}
