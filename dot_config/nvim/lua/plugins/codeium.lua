---@type LazySpec
return {
  "Exafunction/codeium.nvim",
  cmd = "Codeium",
  event = "InsertEnter",
  build = ":Codeium Auth",
  opts = {
    enable_cmp_source = false,
    quiet = true,
    virtual_text = {
      enabled = true,
      filetypes = {
        ["grug-far"] = false,
      },
      key_bindings = {
        accept = false, -- handled by completion engine
      },
    },
  },
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        options = {
          g = {
            -- set the ai_accept function
            ai_accept = function()
              if require("codeium.virtual_text").get_current_completion_item() then
                vim.api.nvim_input(require("codeium.virtual_text").accept())
                return true
              end
            end,
          },
        },
      },
    },
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {
        highlights = {
          init = {
            CodeiumSuggestion = { link = "Comment" },
          },
        },
      },
    },
  },
}
