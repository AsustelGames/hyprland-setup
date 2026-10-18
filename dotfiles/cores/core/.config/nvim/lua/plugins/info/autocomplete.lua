return {
  {
    "neovim/nvim-lspconfig",
  },

  {
    "saghen/blink.cmp",

    version = "1.*",

    opts = {
      keymap = {
        preset = 'none',

        ["<Enter>"] = { "accept", "fallback" },
        ["<S-Tab>"] = { "accept", "fallback" },
        ["<M-k>"] = { "select_prev", "fallback" },
        ["<M-j>"] = { "select_next", "fallback" },
      },

      completion = {
        keyword = { range = 'prefix', },
        trigger = { show_on_backspace = true, },
        list = { max_items = 20, selection = { auto_insert = false }, },
        accept = { auto_brackets = { enabled = true, }, },
        menu = {
          max_height = 7,
          border = "rounded",
          auto_show = false,
          winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc', -- just set proper colors
          scrollbar = false,

          draw = {
            align_to = 'none',
            gap = 1,
            treesitter = { 'lsp', 'path', 'snippets', 'buffer' }, -- check this again

            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 0 } },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
                highlight = function(ctx) return { { group = ctx.kind_hl, priority = 20000 } } end,
              },

            kind = {
              ellipsis = true,
              width = { fill = true },
              text = function(ctx) return ctx.kind end,
              highlight = function(ctx) return ctx.kind_hl end,
            },

            label = {
              width = { fill = true, min = 5, max = 30 },
              text = function(ctx) return ctx.label .. ctx.label_detail end,
              highlight = function(ctx)
              -- label and label details
              local highlights = {
                { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
              }
              if ctx.label_detail then
                table.insert(highlights, { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' })
              end

              -- characters matched on the label by the fuzzy matcher
              for _, idx in ipairs(ctx.label_matched_indices) do
                table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
              end

              return highlights
            end,
          },

          label_description = {
            width = { max = 30 },
            text = function(ctx) return ctx.label_description end,
            highlight = 'BlinkCmpLabelDescription',
          },

          source_name = {
            width = { max = 30 },
            text = function(ctx) return ctx.source_name end,
            highlight = 'BlinkCmpSource',
          },

          source_id = {
            width = { max = 30 },
            text = function(ctx) return ctx.source_id end,
            highlight = 'BlinkCmpSource',
          },
        },
      },
    },

      documentation = {
      -- alt + j/k -> scroll the docs
        draw = function(opts) opts.default_implementation() end,
        window = {
          min_width = 10,
          max_width = 80,
          max_height = 20,
          border = "rounded",
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
        -- Note that the gutter will be disabled when border ~= 'none'
        -- Which directions to show the documentation window,
        -- for each of the possible menu window directions,
        -- falling back to the next direction when there's not enough space
          direction_priority = {
            menu_north = { 'e', 'w', 'n', 's' },
            menu_south = { 'e', 'w', 's', 'n' },
          },
        },
      },

      ghost_text = { enabled = true, },

      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      },
      cmdline = {
        keymap = { 
          preset = 'inherit',
          ["<Enter>"] = { "fallback" },
        },
        completion = { menu = { auto_show = true } },
      },
    },

    config = function(_, opts)
      require("blink.cmp").setup(opts)

      local count = 0
      local previous_length = 0

      local function showMenu()
        if count >= 3 then
          require("blink.cmp").show()
        else
          require("blink.cmp").hide()
        end
      end

      vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
          local line = vim.api.nvim_get_current_line()

          count = 0
          previous_length = #line
        end,
      })

      vim.api.nvim_create_autocmd("TextChangedI", {
        callback = function()
          local line = vim.api.nvim_get_current_line()
          local current_length = #line

          local col = vim.api.nvim_win_get_cursor(0)[2]
          local last_char = line:sub(col, col)

          if last_char == " " or last_char == "\t" then
            count = -1
          end


          if current_length > previous_length then
            count = count + 1
            showMenu()
          elseif current_length < previous_length then
            if count <= 0 then
              count = 0
            else
              count = count - 1
            end 
            showMenu()
          end

          previous_length = current_length
        end,
      })
    end,
    opts_extend = { "sources.default" },
  },
}
