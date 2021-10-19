local _2afile_2a = "fnl/lispdocs/display.fnl"
local _2amodule_name_2a = "lispdocs.display"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local a, str = require("conjure.aniseed.core"), require("conjure.aniseed.string")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["str"] = str
local function draw_border(opts, style)
  local style0 = (style or {"\226\148\128", "\226\148\130", "\226\149\173", "\226\149\174", "\226\149\176", "\226\149\175"})
  local top = (a.get(style0, 3) .. string.rep(a.get(style0, 1), (opts.width + 2)) .. a.get(style0, 4))
  local mid = (a.get(style0, 2) .. string.rep(" ", (opts.width + 2)) .. a.get(style0, 2))
  local bot = (a.get(style0, 5) .. string.rep(a.get(style0, 1), (opts.width + 2)) .. a.get(style0, 6))
  local lines
  do
    local lines0 = {top}
    for _ = 2, (opts.height + 1), 1 do
      table.insert(lines0, mid)
    end
    table.insert(lines0, bot)
    lines = lines0
  end
  local winops = a.merge(opts, {row = (opts.row - 1), height = (opts.height + 2), col = (opts.col - 2), width = (opts.width + 4)})
  local bufnr = vim.api.nvim_create_buf(false, true)
  local winid = vim.api.nvim_open_win(bufnr, true, winops)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.api.nvim_buf_add_highlight(bufnr, 0, "ConjureBorder", 1, 0, -1)
  return winid
end
_2amodule_locals_2a["draw-border"] = draw_border
local function set_buffer(bufnr, content, opts)
  local opts0 = a.merge({filetype = "markdown", buflisted = false, buftype = "nofile", bufhidden = "wipe", swapfile = false}, opts)
  for k, v in pairs(opts0) do
    vim.api.nvim_buf_set_option(bufnr, k, v)
  end
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, content)
  return vim.api.nvim_win_set_cursor(0, {1, 0})
end
_2amodule_locals_2a["set-buffer"] = set_buffer
local function set_float(opts)
  local winops = a.merge({winblend = 5, winhl = "NormalFloat:Normal"}, opts.win)
  local _let_1_ = {opts["primary-winid"], opts["border-winid"]}
  local primary = _let_1_[1]
  local border = _let_1_[2]
  local cursorline
  if a["nil?"](winops.cursorline) then
    cursorline = true
  else
    cursorline = false
  end
  for _, win in ipairs({primary, border}) do
    for k, v in pairs(winops) do
      if (k ~= "cursorline") then
        vim.api.nvim_win_set_option(win, k, v)
      else
      end
    end
  end
  if cursorline then
    vim.api.nvim_win_set_option(primary, "cursorline", true)
  else
  end
  return vim.cmd(str.join(" ", {"au", "WinClosed,WinLeave", string.format("<buffer=%d>", opts.bufnr), ":bd!", "|", "call", string.format("nvim_win_close(%d,", border), "v:true)"}))
end
_2amodule_locals_2a["set-float"] = set_float
local function get_float_opts(opts)
  local relative = (opts.relative or "editor")
  local style = (opts.style or "minimal")
  local fill = (opts.fill or 0.8)
  local width = math.floor((vim.o.columns * fill))
  local height = math.floor((vim.o.lines * fill))
  local row = math.floor((((vim.o.lines - height) / 2) - 1))
  local col = math.floor(((vim.o.columns - width) / 2))
  return {relative = relative, style = style, width = width, height = height, row = row, col = col}
end
_2amodule_locals_2a["get-float-opts"] = get_float_opts
local function open_float(opts)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local winops = get_float_opts(opts)
  local border_winid = draw_border(winops, opts.border)
  local primary_winid = vim.api.nvim_open_win(bufnr, true, winops)
  set_float({win = opts.win, ["primary-winid"] = primary_winid, ["border-winid"] = border_winid, bufnr = bufnr})
  return set_buffer(bufnr, opts.content, opts.buf)
end
_2amodule_locals_2a["open-float"] = open_float
local function open_normal(cmd, opts)
  vim.cmd(cmd)
  return set_buffer(0, opts.content, opts.buf)
end
_2amodule_locals_2a["open-normal"] = open_normal
local function open(opts)
  if (opts and opts.content) then
    local _5_ = opts.display
    if (_5_ == "float") then
      return open_float(opts)
    elseif (_5_ == "split") then
      return open_normal("new", opts)
    elseif (_5_ == "vsplit") then
      return open_normal("vnew", opts)
    elseif (_5_ == "normal") then
      return open_normal("enew", opts)
    else
      return nil
    end
  else
    return nil
  end
end
_2amodule_2a["open"] = open