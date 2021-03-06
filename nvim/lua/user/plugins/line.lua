local M = {}

function M.config()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

 local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow = "#ecbe7b",
    yellow_1 = "#ff9640",
    grey = "#2c323c",
    white = "#bbc2cf",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
  }

  local icons = {
        linux = ' ',
        macos = ' ',
        windows = ' ',

        errs = ' ',
        warns = ' ',
        infos = ' ',
        hints = ' ',

        lsp = ' ',
        git = ''
    }
  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand "%:p:h"
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

 local function file_osinfo()
      local os = vim.bo.fileformat:upper()
      local icon
      if os == 'UNIX' then
          icon = icons.linux
      elseif os == 'MAC' then
          icon = icons.macos
      else
          icon = icons.windows
      end
      return icon
  end

    local config = {
      options = {
        disabled_filetypes = { "NvimTree", "neo-tree", "dashboard", "Outline" },
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      function()
        return "▊"
      end,
      color = { fg = colors.blue },
      padding = { left = 0, right = 0 },
    }

    ins_left({
      -- mode component
      function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }
        vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
        return ' '
      end,
      color = 'LualineMode',
      padding = { left = 2 },
    })

    ins_left {
      "branch",
      icon = "",
      color = { fg = colors.violet, gui = "bold" },
      padding = { left = 2, right = 1 },
    }

    ins_left {
      "filetype",
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = "bold" },
      padding = { left = 2, right = 1 },
    }

    ins_left {
      "diff",
      symbols = { added = " ", modified = "柳", removed = " " },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow_1 },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
      padding = { left = 2, right = 1 },
    }

    ins_left {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
      padding = { left = 2, right = 1 },
    }

    ins_left {
      function()
        return "%="
      end,
    }

    ins_left({
      -- Lsp server name .
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = '   LSP:',
      color = { fg = '#ffffff', gui = 'bold' },
    })

    ins_right({
      -- filesize component
      'filesize',
      icon = file_osinfo(),
      cond = conditions.buffer_not_empty,
    })

    ins_right {
      "location",
      padding = { left = 1, right = 1 },
    }

    ins_right {
      "progress",
      color = { gui = "none" },
      padding = { left = 0, right = 0 },
    }

  ins_right {
        function()
          local current_line = vim.fn.line "."
          local total_lines = vim.fn.line "$"
          local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
          local line_ratio = current_line / total_lines
          local index = math.ceil(line_ratio * #chars)
          return chars[index]
        end,
        padding = { left = 1, right = 1 },
        color = { fg = colors.yellow, bg = colors.grey },
        cond = nil,
      }

    ins_right {
      function()
        return "▊"
      end,
      color = { fg = colors.blue },
      padding = { left = 1, right = 0 },
    }

  lualine.setup(require("core.utils").user_plugin_opts("plugins.lualine", config))
end

return M
