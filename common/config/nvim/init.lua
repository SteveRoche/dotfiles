vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.o.guifont = 'Berkeley Mono:h12'

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'

vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true

-- vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split'

vim.o.cursorline = true

vim.o.scrolloff = 10

vim.o.confirm = true

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.autoindent = true

vim.o.termguicolors = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>p', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to right window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to lower window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Supress spammy messages
local suppressed_phrases = {
  'position_encoding param is required',
  'symbols_to_items must be called with valid position encoding'
}
local notify = vim.notify
vim.notify = function(msg, ...)
  for _, phrase in ipairs(suppressed_phrases) do
    if msg:match(phrase) then
      return
    end
  end
  notify(msg, ...)
end

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup {
  { -- Theme
    'zenbones-theme/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme zenbones'
    end,
  },
  { -- Statusline
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox-material',
        },
      }
    end,
  },
  -- { -- Colored bracket pairs
  --   'hiphish/rainbow-delimiters.nvim'
  -- },
  { -- Git symbols in gutter
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      delay = 0,
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {},
      spec = {
        { '<leader>s', group = 'Search' },
        { '<leader>q', group = 'Sessions' },
      },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function ()
      require('toggleterm').setup{
        open_mapping = [[<c-\>]],
      }
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'lua', 'vim', 'vimdoc', 'zig', 'rust', 'query', 'markdown', 'markdown_inline' },
      auto_install = false,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },
  { -- Fuzzy search
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {}
      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
      vim.keymap.set('n', '<leader>sv', builtin.git_files, { desc = 'Search in version control' })
      vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = 'Search telescopes' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search current word' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep' })
      vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = 'Search in current file' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Resume search' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.live_grep { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search Neovim files' })
    end,
  },
  { -- Lua language server setup for editing Neovim config
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, 'Rename')
          map('gra', vim.lsp.buf.code_action, 'Goto code action', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, 'Goto references')
          map('gri', require('telescope.builtin').lsp_implementations, 'Goto implementation')
          map('grd', require('telescope.builtin').lsp_definitions, 'Goto definition')
          map('grt', require('telescope.builtin').lsp_type_definitions, 'Goto type definition')
          map('grD', vim.lsp.buf.declaration, 'Goto declaration')
          map('gO', function()
            require('telescope.builtin').lsp_document_symbols({
              ignore_symbols = { 'Field' }
            })
          end, 'Open document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
        end,
      })
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 10,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local servers = { -- Add to this array to enable LSPs
        -- Full list at https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        lua_ls = {},
        tinymist = {},
        zls = {},
        nil_ls = {},
        rust_analyzer = {},
      }

      for server_name, server_config in pairs(servers) do
        server_config.capabilities = capabilities
        vim.lsp.config(server_name, server_config)
        vim.lsp.enable(server_name)
      end
    end,
  },
  { -- Autocomplete
    'saghen/blink.cmp',
    build = 'nix run .#build-plugin',
    opts = {
      keymap = { preset = 'super-tab' },
      signature = { enabled = true },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      completion = {
        accept = { auto_brackets = { enabled = false } },
      },
      menu = { auto_show = false },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    },
  },
  { -- Highlight TODO comments
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup {
        indent = {
          char = '▏'
        },
      }
    end
  },
  { -- File explorer
    'stevearc/oil.nvim',
    dependencies = 'nvim-mini/mini.icons',
    lazy = false,
    opts = {},
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        columns = { 'icon', 'size' },
      }
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
  { -- Amazing code navigation and editing
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  {
    'nvim-telescope/telescope-project.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telescope').load_extension('project')
      vim.keymap.set('n', '<leader>sp', function() require('telescope').extensions.project.project{} end, { desc = 'Search projects' })
    end,
  }
}
