{log} = require('util')

require 'colors'
sh = require('shelljs')
argv = require('minimist')(process.argv.slice(2))
command = argv._[0]

###
Fatal error which causes the cli to exit.
###
fail = (msg) ->
  log "#{'ERROR'.red} #{msg}"
  process.exit 1

###
Clone the starterkit to the given directory.
###
cloneLayout = (dir) ->
  state = sh.exec("git clone git@github.com:highrisejs/starterkit.git #{dir}")
  return fail('failed to clone starterkit') unless state.code is 0
  sh.rm '-rf', "#{dir}/.git"

argv.o = 'project' unless argv.o?
cloneLayout argv.o
