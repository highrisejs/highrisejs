dirname = require('path').dirname
express = require('express')

module.exports = (opts = {}) ->
  opts.require ?= require
  project = express()

  ###
  Boot up all applications.
  ###
  project.boot = (apps) ->
    project.set 'apps', apps.map (x) ->
      if Array.isArray(x)
        x[0]
      else
        x

    for app, i in apps
      if Array.isArray(app)
        path = opts.require.resolve(app[0])
        app = opts.require(path).call(null, app[1..])
      else
        path = opts.require.resolve(app)
        app = opts.require(path)
      unless app.get('view engine')
        if app.set?
          app.set 'view engine', project.get('view engine')
      if app.set?
        app.set 'views', "#{dirname(path)}/views"
      project.use app

  project
