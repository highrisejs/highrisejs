test = require('tape')
sinon = require('sinon')
highrise = require('../src')

test 'project', (t) ->
  t.plan 1

  inst = highrise()
  t.ok (typeof inst.boot is 'function'), 'boot method exists'
  t.end()

test 'project#boot()', (t) ->
  t.plan 3

  fn = ->
  fn.get = -> null
  fn.set = sinon.spy()
  _require = sinon.spy (args ...) ->
    fn

  _require.resolve = ->
    '/myapp/mypath/index.coffee'

  inst = highrise(require: _require)
  inst.boot [
    'myapp'
  ]

  t.ok _require.calledWith('/myapp/mypath/index.coffee'), 'require was called'
  t.ok fn.set.calledWith('view engine', undefined), 'view engine was set'
  t.ok fn.set.calledWith('views', '/myapp/mypath/views'), 'views path was set'
  t.end()
