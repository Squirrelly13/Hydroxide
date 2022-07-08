local wak = {}

local ffi = require("ffi")
ffi.cdef[[
  void* fopen(const char* filename, const char* mode);
  size_t fwrite(void* ptr, size_t size, size_t count, void* stream);
  void fread(void* ptr, size_t size, size_t count, void* stream);
  int fseek(void* stream, long int offset, int origin);
  void fclose(void* stream);
]]

local INT_SIZE = ffi.sizeof("int")

local WAK_FUNCS = {}
local WAK_MT = {
  __index = WAK_FUNCS,
  __tostring = function(self)
    return "wak archive: " .. self.path
  end
}

local WAK_FILE_FUNCS = {}
local WAK_FILE_MT = {
  __index = WAK_FILE_FUNCS,
  __tostring = function(self)
    return "wak file: " .. self.path
  end
}

local function read_toc(wak, predicate)
  for i = wak._read_files, wak._num_files - 1 do
    local offs = ffi.new("int[1]")
    ffi.C.fread(offs, INT_SIZE, 1, wak._stream)
    offs = offs[0]
    wak._pos = wak._pos + INT_SIZE

    local length = ffi.new("int[1]")
    ffi.C.fread(length, INT_SIZE, 1, wak._stream)
    length = length[0]
    wak._pos = wak._pos + INT_SIZE

    local path_length = ffi.new("int[1]")
    ffi.C.fread(path_length, INT_SIZE, 1, wak._stream)
    path_length = path_length[0]
    wak._pos = wak._pos + INT_SIZE

    local path_bytes = ffi.new("char[?]", path_length)
    ffi.C.fread(path_bytes, ffi.sizeof("char"), path_length, wak._stream)
    wak._pos = wak._pos + path_length
    local path = ffi.string(path_bytes, path_length)

    local file = setmetatable({ _wak = wak, _offset = offs, length = length, path = path }, WAK_FILE_MT)
    wak._files[path] = file

    wak._read_files = wak._read_files + 1

    if predicate and predicate(file) then
      break
    end
  end

  return contents
end

function wak.open(path)
  local wak_f = ffi.C.fopen(path, "rb")
  if wak_f == nil then return nil end

  ffi.C.fseek(wak_f, INT_SIZE, 0)
  local num_files = ffi.new("int[1]")
  ffi.C.fread(num_files, INT_SIZE, 1, wak_f)
  num_files = num_files[0]
  local toc_size = ffi.new("int[1]")
  ffi.C.fread(toc_size, INT_SIZE, 1, wak_f)
  toc_size = toc_size[0]
  ffi.C.fseek(wak_f, 4, 1)

  local ar_table = setmetatable({
    path = path,
    _stream = wak_f,
    _num_files = num_files,
    _toc_size = toc_size,
    _pos = INT_SIZE * 4,
    _read_files = 0,
    _files = {}
  }, WAK_MT)

  local ar_proxy = newproxy(true)
  local ar_proxy_mt = getmetatable(ar_proxy)

  ar_proxy_mt.__gc = function(self)
    ar_table:dispose()
  end

  ar_proxy_mt.__index = ar_table
  ar_proxy_mt.__newindex = ar_table
  ar_proxy_mt.__tostring = function(self)
    return tostring(ar_table)
  end

  return ar_proxy
end

local function check_disposed(wak)
  if wak._disposed then error("cannot operate on disposed archive") end
end

function WAK_FUNCS:preload_all()
  check_disposed(self)
  read_toc(self)
end

function WAK_FUNCS:open(path)
  check_disposed(self)
  local existing_file = self._files[path]
  if existing_file ~= nil then return existing_file end
  read_toc(self, function(file) return file.path == path end)
  return self._files[path]
end

function WAK_FUNCS:extract(path, out_path)
  check_disposed(self)
  read_toc(function(file)
    if file.path == path then
      ffi.C.fseek(stream, offs, 0)
      local buf = ffi.new("char[?]", length)
      ffi.C.fread(buf, ffi.sizeof("char"), length, stream)

      local out_f = ffi.C.fopen(out_path, "w")
      ffi.C.fwrite(buf, ffi.sizeof("char"), length, out_f)

      ffi.C.fclose(out_f)

      return true
    end
  end)
end

function WAK_FUNCS:dispose()
  if not self._disposed then
    ffi.C.fclose(self._stream)
  end
  self._disposed = true
end

function WAK_FILE_FUNCS:read()
  check_disposed(self._wak)
  ffi.C.fseek(self._wak._stream, self._offset, 0)
  local buf = ffi.new("char[?]", self.length)
  ffi.C.fread(buf, ffi.sizeof("char"), self.length, self._wak._stream)
  return ffi.string(buf, self.length)
end

function WAK_FILE_FUNCS:write_to(out_path)
  check_disposed(self._wak)
  ffi.C.fseek(self._wak._stream, self._offset, 0)
  local buf = ffi.new("char[?]", self.length)
  ffi.C.fread(buf, ffi.sizeof("char"), self.length, self._wak._stream)

  local out_f = ffi.C.fopen(out_path, "w")
  ffi.C.fwrite(buf, ffi.sizeof("char"), self.length, out_f)

  ffi.C.fclose(out_f)
end

return wak