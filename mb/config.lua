--- Config helper
---@class Config
local Config = {
  DIR = "/etc"
}

--- Checks whether given config exists.
---@param name string Name of config to check.
---@return boolean exists True if given config exists, false otherwise.
function Config.exists(name)
  return fs.exists("/" .. fs.combine(Config.DIR, name))
end

--- Loads given config or returns nil.
---@param name string Name of config to load.
---@return table? config Loaded config or nil on failure.
function Config.load(name)
  local file = "/" .. fs.combine(Config.DIR, name)
  local f = fs.open(file, "r")
  if not f then
    return nil
  end

  local config = textutils.unserialise(f:readAll())
  f:close()
  return config
end

--- Saves given config.
---@param config table Config to save.
---@param name string Name of config to save.
---@return boolean success True if save successfully, false otherwise.
function Config.save(config, name)
  fs.makeDir(Config.DIR)
  local file = "/" .. fs.combine(Config.DIR, name)
  local f = fs.open(file, "w")
  if not f then
    return false
  end

  f:write(textutils.serialise(config))
  f:close()

  return true
end

return Config
