fs = require 'fs'
path = require 'path'

# so we only need to load the data the first time the module is used
settings_cache = null

exports.get = (key, callback) ->
  settings_cache[key]

# load the settings specific to the current environment
exports.load_settings = (env) ->
  console.log "Loading and parsing application settings for env".info, env.help

  # Handle default environments
  if env in ['development', 'test', 'production']
    settings = require(path.join(process.cwd(), 'settings', 'settings.json'))
    settings_cache = settings[env]
    return
  else

    # Handle if the environment is a path (which is in dot syntax)
    # Example: my.custom.settings === my/custom/settings.coffee
    if '.' in env
      env = env.split('.')
      # Create a string to be used for the path
      settings_path = env.join '/'
      # Remember, `env` is originally a path.
      # The last part of the path is actually the name of the settings we need to load.
      env = env[env.length - 1]
    else
      # No dot path deteched so just alias env to build a path below
      settings_path = env

    try
      settings = require path.join(process.cwd(), 'settings', "#{settings_path}.coffee")
    catch e
      # Path doesn't exist and thus we shouldn't even bother continue.
      console.log e.toString().error
      process.exit 1

    try
      settings = JSON.parse(settings[env])
    catch e
      console.log "Settings must be in valid JSON format".error

    # Finally at the end of our journey.
    # Set settings_cache to our loaded settings so that it can be used
    # by the `get` method.
    settings_cache = settings
