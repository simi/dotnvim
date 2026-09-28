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
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash",
        "c",
        "cpp",
        "typescript",
        "tsx",
        "javascript",
        "lua",
        "markdown",
        "markdown_inline",
        "sql",
        "python",
        "ruby",
        "rust",
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require('telescope.actions')
      local action_layout = require('telescope.actions.layout')
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<C-h>"] = action_layout.toggle_preview,
              ["<C-l>"] = action_layout.cycle_layout_next,
            },
            n = {
              ["<C-h>"] = action_layout.toggle_preview,
              ["<C-l>"] = action_layout.cycle_layout_next,
            },
          },
          cycle_layout_list = { "horizontal", "vertical", "center" },
        },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.config('clangd', {
        cmd = { "clangd", "--background-index" },
      })
      vim.lsp.enable('clangd')
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
  },
  { "neoclide/coc.nvim", branch='release', },
  { "beyondmarc/hlsl.vim" },
  {
    'mrcjkb/rustaceanvim',
    lazy = false,
    version = '^9',
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
