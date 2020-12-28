local _0_0 = nil
do
  local name_0_ = "conjure.clojuredocs.display"
  local loaded_0_ = package.loaded[name_0_]
  local module_0_ = nil
  if ("table" == type(loaded_0_)) then
    module_0_ = loaded_0_
  else
    module_0_ = {}
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = (module_0_["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = (module_0_["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {require("conjure.aniseed.core"), require("conjure.aniseed.string")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", str = "conjure.aniseed.string"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local str = _local_0_[2]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "conjure.clojuredocs.display"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local api = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function _2_(_, k)
      return vim.api[("nvim_" .. k)]
    end
    v_0_0 = setmetatable({}, {__index = _2_})
    _0_0["api"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["api"] = v_0_
  api = v_0_
end
local draw_border = nil
do
  local v_0_ = nil
  local function draw_border0(opts, style)
    local style0 = (style or {"\226\148\128", "\226\148\130", "\226\149\173", "\226\149\174", "\226\149\176", "\226\149\175"})
    local top = (a.get(style0, 3) .. string.rep(a.get(style0, 1), (opts.width + 2)) .. a.get(style0, 4))
    local mid = (a.get(style0, 2) .. string.rep(" ", (opts.width + 2)) .. a.get(style0, 2))
    local bot = (a.get(style0, 5) .. string.rep(a.get(style0, 1), (opts.width + 2)) .. a.get(style0, 6))
    local lines = nil
    do
      local lines0 = {top}
      for _ = 2, (opts.height + 1), 1 do
        table.insert(lines0, mid)
      end
      table.insert(lines0, bot)
      lines = lines0
    end
    local winops = a.merge(opts, {col = (opts.col - 2), height = (opts.height + 2), row = (opts.row - 1), width = (opts.width + 4)})
    local bufnr = api.create_buf(false, true)
    local winid = api.open_win(bufnr, true, winops)
    api.buf_set_lines(bufnr, 0, -1, false, lines)
    api.buf_add_highlight(bufnr, 0, "ConjureBorder", 1, 0, -1)
    return winid
  end
  v_0_ = draw_border0
  _0_0["aniseed/locals"]["draw-border"] = v_0_
  draw_border = v_0_
end
local set_buf_opts = nil
do
  local v_0_ = nil
  local function set_buf_opts0(bufnr, content, opts)
    local opts0 = a.merge({bufhidden = "wipe", buflisted = false, buftype = "nofile", filetype = "markdown", swapfile = false}, opts)
    for k, v in pairs(opts0) do
      api.buf_set_option(bufnr, k, v)
    end
    api.buf_set_lines(bufnr, 0, 0, true, content)
    return api.win_set_cursor(0, {1, 0})
  end
  v_0_ = set_buf_opts0
  _0_0["aniseed/locals"]["set-buf-opts"] = v_0_
  set_buf_opts = v_0_
end
local set_win_opts = nil
do
  local v_0_ = nil
  local function set_win_opts0(opts)
    local winops = a.merge({conceallevel = 3, winblend = 5, winhl = "NormalFloat:Normal"}, opts.win)
    local _let_0_ = {opts["primary-winid"], opts["border-winid"]}
    local primary = _let_0_[1]
    local border = _let_0_[2]
    for _, win in ipairs({primary, border}) do
      for k, v in pairs(winops) do
        api.win_set_option(win, k, v)
      end
    end
    return vim.cmd(str.join(" ", {"au", "WinClosed,WinLeave", string.format("<buffer=%d>", opts.bufnr), ":bd!", "|", "call", string.format("nvim_win_close(%d,", border), "v:true)"}))
  end
  v_0_ = set_win_opts0
  _0_0["aniseed/locals"]["set-win-opts"] = v_0_
  set_win_opts = v_0_
end
local center_opts = nil
do
  local v_0_ = nil
  local function center_opts0(opts)
    local relative = (opts.relative or "editor")
    local style = (opts.style or "minimal")
    local fill = (opts.fill or 0.80000000000000004)
    local width = math.floor((vim.o.columns * fill))
    local height = math.floor((vim.o.lines * fill))
    local row = math.floor((((vim.o.lines - height) / 2) - 1))
    local col = math.floor(((vim.o.columns - width) / 2))
    return {col = col, height = height, relative = relative, row = row, style = style, width = width}
  end
  v_0_ = center_opts0
  _0_0["aniseed/locals"]["center-opts"] = v_0_
  center_opts = v_0_
end
local open_float = nil
do
  local v_0_ = nil
  local function open_float0(opts)
    local bufnr = api.create_buf(false, true)
    local winops = center_opts(opts)
    local border_winid = draw_border(winops, opts.border)
    local primary_winid = api.open_win(bufnr, true, winops)
    set_win_opts({["border-winid"] = border_winid, ["opts.win"] = opts.win, ["primary-winid"] = primary_winid, bufnr = bufnr})
    return set_buf_opts(bufnr, opts.content, opts.buf)
  end
  v_0_ = open_float0
  _0_0["aniseed/locals"]["open-float"] = v_0_
  open_float = v_0_
end
local open_split = nil
do
  local v_0_ = nil
  local function open_split0(cmd, opts)
    vim.cmd(cmd)
    return set_buf_opts(0, opts.content, opts.buf)
  end
  v_0_ = open_split0
  _0_0["aniseed/locals"]["open-split"] = v_0_
  open_split = v_0_
end
local open = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function open0(opts)
      if (opts and opts.content) then
        local _2_0 = opts.display
        if (_2_0 == "float") then
          return open_float(opts)
        elseif (_2_0 == "split") then
          return open_split("new", opts)
        elseif (_2_0 == "vsplit") then
          return open_split("vnew", opts)
        end
      end
    end
    v_0_0 = open0
    _0_0["open"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["open"] = v_0_
  open = v_0_
end
return nil