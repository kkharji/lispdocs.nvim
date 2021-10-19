local _2afile_2a = "fnl/lispdocs/finder.fnl"
local _2amodule_name_2a = "telescope.__extensions.lispdocs"
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
local actions, actions_set, conf, db, entry_display, finders, pft, pickers, previewers, putils, state, telescope, util, utils = require("telescope.actions"), require("telescope.actions.set"), require("telescope.config"), require("lispdocs.db"), require("telescope.pickers.entry_display"), require("telescope.finders"), require("plenary.filetype"), require("telescope.pickers"), require("telescope.previewers"), require("telescope.previewers.utils"), require("telescope.state"), require("telescope"), require("lispdocs.util"), require("telescope.utils")
do end (_2amodule_locals_2a)["actions"] = actions
_2amodule_locals_2a["actions_set"] = actions_set
_2amodule_locals_2a["conf"] = conf
_2amodule_locals_2a["db"] = db
_2amodule_locals_2a["entry_display"] = entry_display
_2amodule_locals_2a["finders"] = finders
_2amodule_locals_2a["pft"] = pft
_2amodule_locals_2a["pickers"] = pickers
_2amodule_locals_2a["previewers"] = previewers
_2amodule_locals_2a["putils"] = putils
_2amodule_locals_2a["state"] = state
_2amodule_locals_2a["telescope"] = telescope
_2amodule_locals_2a["util"] = util
_2amodule_locals_2a["utils"] = utils
local function make_display(entry)
  local displayer = entry_display.create({separator = " ", hl_chars = {["|"] = "TelescopeResultsNumber"}, items = {{width = 30}, {remaining = true}, {remaining = true}}})
  return displayer({{entry.name, "TelescopeResultsNumber"}, {entry.ns, "TabLine"}})
end
_2amodule_locals_2a["make-display"] = make_display
local function entry_maker(entry)
  local _let_1_ = vim.split(entry.symbol, "/")
  local ns = _let_1_[1]
  local name = _let_1_[2]
  return {value = entry, name = name, ns = ns, preview = entry.preview, symbol = entry.symbol, display = make_display, ordinal = (ns .. " " .. name)}
end
_2amodule_locals_2a["entry-maker"] = entry_maker
local previewer
local function _2_(opts)
  local function _3_(_, entry)
    return entry.symbol
  end
  local function _4_(self, entry, status)
    if (entry.symbol ~= self.state.bufname) then
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(entry.preview, "||00||"))
      vim.api.nvim_win_set_option(self.state.preview_win, "wrap", true)
      return putils.highlighter(self.state.bufnr, "markdown")
    else
      return nil
    end
  end
  return previewers.new_buffer_previewer({keep_last_buf = true, get_buffer_by_name = _3_, define_preview = _4_})
end
previewer = utils.make_default_callable(_2_, {})
do end (_2amodule_locals_2a)["previewer"] = previewer
local function set_mappings(bufnr)
  local function _6_(_, direction)
    actions.close(bufnr)
    local last_bufnr = state.get_global_key("last_preview_bufnr")
    local cmd
    do
      local _7_ = direction
      if (_7_ == "default") then
        cmd = ":buffer"
      elseif (_7_ == "horizontal") then
        cmd = ":sbuffer"
      elseif (_7_ == "vertical") then
        cmd = ":vert sbuffer"
      elseif (_7_ == "tab") then
        cmd = ":tab sb"
      else
        cmd = nil
      end
    end
    return vim.cmd((cmd .. " " .. last_bufnr))
  end
  do end (actions_set.select):replace(_6_)
  return true
end
_2amodule_locals_2a["set-mappings"] = set_mappings
local function picker(opts)
  local config = {prompt_title = "Lispdocs", finder = finders.new_table({results = (opts.tbl):get({keys = {"symbol", "preview"}}), entry_maker = entry_maker}), previewer = previewer.new(opts), sorter = conf.values.generic_sorter(opts), attach_mappings = set_mappings}
  return pickers.new(opts, config):find()
end
_2amodule_locals_2a["picker"] = picker
local function find(opts)
  local opts0 = (opts or {})
  local ext = (opts0.ext or "clj")
  do end (opts0)["tbl"] = (db[ext] or {})
  if (util.supported(ext) and (opts0.tbl):empty()) then
    local function _9_()
      return picker(opts0)
    end
    return (opts0.tbl):seed(vim.schedule_wrap(_9_))
  else
    return picker(opts0)
  end
end
_2amodule_locals_2a["find"] = find
return {find = find}