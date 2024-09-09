return {
  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = function(_, opts)
      require('telekasten').setup({
        home = vim.fn.expand("~/zettelkasten"),
        template_new_note = vim.fn.stdpath('config') .. '/telekasten/templates/note-template',
        template_new_daily = vim.fn.stdpath('config') .. '/telekasten/templates/daily-template',
        template_new_weekly = vim.fn.stdpath('config') .. '/telekasten/templates/weekly-template',
        templates = vim.fn.stdpath('config') .. '/telekasten/templates/'
      })

      opts.template_new_weekly = vim.fn.stdpath('config') .. '/telekasten/weekly-template'
      -- Launch panel if nothing is typed after <leader>z
      vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

      -- Most used functions
      vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
      vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
      vim.keymap.set("n", "<leader>zt", "<cmd>Telekasten goto_today<CR>")
      vim.keymap.set("n", "<leader>zw", "<cmd>Telekasten goto_thisweek<CR>")
      vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten toggle_todo<CR>")
      vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
      vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
      vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")
      vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
      vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")

      vim.keymap.set("n", "<leader>zT", ':lua require("telescope.builtin").live_grep({default_text = "\\\\[ \\\\]", search_dirs = {"~/zettelkasten"}})<CR>')

      -- Call insert link automatically when we start typing a link
      vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")
    end,
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        -- default config:
        auto_load = true,         -- whether to automatically load preview when
                                  -- entering another markdown buffer
        close_on_bdelete = true,  -- close preview window on buffer delete

        syntax = true,            -- enable syntax highlighting, affects performance

        theme = 'dark',           -- 'dark' or 'light'

        update_on_change = true,

        app = 'webview',          -- 'webview', 'browser', string or a table of strings
                                  -- explained below

        filetype = { 'markdown', 'md' },-- list of filetypes to recognize as markdown

        -- relevant if update_on_change is true
        throttle_at = 200000,     -- start throttling when file exceeds this
                                  -- amount of bytes in size
        throttle_time = 'auto',   -- minimum amount of time in milliseconds
                                  -- that has to pass before starting new render
      })
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
      vim.keymap.set("n", "<leader>po", "<cmd>PeekOpen<CR>")
      vim.keymap.set("n", "<leader>pc", "<cmd>PeekClose<CR>")
    end,
  },
}
