Config = require( "./config" )

recruse = require( "./recruse" )

class Monteur extends require( "mpbasic" )( Config )

	defaults: =>
		@extend super, {}

	initialize: =>
		return

	process: ( cb )=>
		recruse.on "file", @processFile
		recruse.on "end", =>
			cb( null )
			return

		recruse.on "error", ( err )=>
			cb( err )
			return

		recruse.start( "" )

		return

	processFile: ( path, name, content )=>
		@debug "file", name
		return

module.exports = new Monteur()