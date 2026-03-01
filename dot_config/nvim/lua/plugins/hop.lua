local hop = require "hop"
local directions = require("hop.hint").HintDirection

---@type LazySpec
return {
  {
    "smoka7/hop.nvim",
    opts = {},
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          [""] = {
            f = {
              function() hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true } end,
              desc = "Hop after char",
            },
            F = {
              function() hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true } end,
              desc = "Hop befor char",
            },
            t = {
              function()
                hop.hint_char1 {
                  direction = directions.AFTER_CURSOR,
                  current_line_only = true,
                  hint_offset = -1,
                }
              end,
              desc = "Hop till char",
            },
            T = {
              function()
                hop.hint_char1 {
                  direction = directions.BEFORE_CURSOR,
                  current_line_only = true,
                  hint_offset = -1,
                }
              end,
              desc = "Hop till char (inverse)",
            },
          },
        },
      },
    },
  },
}
