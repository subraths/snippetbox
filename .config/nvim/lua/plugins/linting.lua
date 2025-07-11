-- Code formatting and linting
return {
  -- Formatting
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    init = function()
      -- Install conform on VeryLazy
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          require("conform").setup({
            -- Map of filetype to formatters
            formatters_by_ft = {
              go = { "goimports", "gofumpt" },
              lua = { "stylua" },
              fish = { "fish_indent" },
              sh = { "shfmt" },
              javascript = { { "prettierd", "prettier" } },
              typescript = { { "prettierd", "prettier" } },
              javascriptreact = { { "prettierd", "prettier" } },
              typescriptreact = { { "prettierd", "prettier" } },
              html = { { "prettierd", "prettier" } },
              css = { { "prettierd", "prettier" } },
              scss = { { "prettierd", "prettier" } },
              json = { { "prettierd", "prettier" } },
              yaml = { { "prettierd", "prettier" } },
              markdown = { { "prettierd", "prettier" } },
              sql = { "sqlfluff" },
            },
            -- Set up format-on-save
            format_on_save = function(bufnr)
              -- Disable with a global or buffer-local variable
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              return { timeout_ms = 500, lsp_fallback = true }
            end,
            -- Customize formatters
            formatters = {
              shfmt = {
                prepend_args = { "-i", "2" },
              },
              sqlfluff = {
                args = { "format", "--dialect=postgres", "-" },
              },
            },
          })
        end,
      })
    end,
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        go = { "golangcilint" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "pylint" },
        dockerfile = { "hadolint" },
        yaml = { "yamllint" },
        json = { "jsonlint" },
        sql = { "sqlfluff" },
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },

  -- Trouble for displaying diagnostics and more
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
}