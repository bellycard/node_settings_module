fs = require 'fs'
path = require 'path'

# so we only need to load the data the first time the module is used
settings_cache = null

env = process.env.NODE_ENV

console.log "Loading and parsing application settings for env: #{env}"

# Handle default environments
if env in ['development', 'test', 'production']
  settings = require(path.join(process.cwd(), 'settings', 'settings.json'))
  settings_cache = settings[env]
  return

else
  console.log "NODE_ENV not correctly set"


# helper method to get the settings
exports.get = (key, callback) ->
  settings_cache[key]

