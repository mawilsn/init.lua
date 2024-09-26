return{
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    event = "User LazyDir",
    cmd = "Neotree",
    keys = {
      { "<Leader>e", "<Cmd>Neotree<CR>", desc = "Flie Explorer" },
      { "<Leader>be", "<Cmd>Neotree buffers<CR>", desc = "Buffer Explorer" },
      { "<Leader>ge", "<Cmd>Neotree git_status<CR>", desc = "Git Explorer" },
    },
    opts = {
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      source_selector = {
        winbar = true,
        show_scrolled_off_parent_node = true,
        sources = {
          { source = "filesystem" },
          { source = "git_status" },
          { source = "document_symbols" },
        },
      },
      open_files_do_not_replace_types = { "help", "quickfix", "terminal", "prompt" },
--      default_component_configs = {
--        indent = {
--          with_expanders = true,
--        },
--        modified = {
--         symbol = icons.file.modified,
--        },
--        git_status = {
--          symbols = {
--            added = icons.diff.added,
--            deleted = icons.diff.deleted,
--            modified = icons.diff.modified,
--            renamed = icons.diff.renamed,
--          },
--        },
--      },
      window = {
        mappings = {
          ["<Space>"] = "noop",
          ["<"] = "noop",
          [">"] = "noop",
          ["H"] = "prev_source",
          ["L"] = "next_source",
          ["C"] = "noop",
          ["h"] = "close_node",
          ["l"] = "open",
          ["<Tab>"] = {
            function()
              local Preview = require("neo-tree.sources.common.preview")
              if Preview.is_active() then
                Preview.focus()
              else
                vim.fn.win_gotoid(vim.g.last_normal_win)
              end
            end,
            desc = "focus_preview",
          },
        },
      },
      filesystem = {
        group_empty_dirs = true,
        bind_to_cwd = true,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ["<CR>"] = "set_root",
            ["."] = "toggle_hidden",
            ["i"] = "noop",
            ["K"] = "show_file_details",
            ["c"] = {
              function(state)
                local node = state.tree:get_node()
                vim.fn.setreg("+", node.path)
              end,
              desc = "copy_path",
            },
            ["o"] = {
              function(state)
                local path = state.tree:get_node().path
                if vim.fn.isdirectory(path) == 0 then
                  path = vim.fs.dirname(path)
                end
                if utils.is_windows() then
                  os.execute("start " .. path)
                elseif utils.is_linux() then
                  os.execute("xdg-open " .. path)
                elseif utils.is_macos() then
                  os.execute("open " .. path)
                else
                  vim.notify("Unsupported System")
                end
              end,
              desc = "open_by_system",
            },
          },
        },
      },
    },
  },
}
