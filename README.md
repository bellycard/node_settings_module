node_settings_module
================

A module to handle application settings, note: under most circumstances you do not want to keep your settings under source control.  We share this between node projects.

### Installation

Add to your dependencies in package.json, with a reference to this repository

```JAVASCRIPT
"dependencies": {
  "node_settings_module": "git://github.com/bellycard/node_settings_module.git#v0.0.7"
}
```

### Usage

Make sure your environment variable NODE_ENV is set

Create a file called /settings/settings.json

```JSON
// settings.json
{
  "development": {
    "memcached": {
      "server": "localhost:11212"
    }
  }
}
```

```JAVASCRIPT
settings = require('node_settings_module')
memcache_server_address = settings.get("memcached").server
```

### Development

Source files are written in coffee, and compied into JavaScript.  To watch the src directory and compile js into the add directory
```
coffee -c -b -w -o app/ src/
```
