path = require( "path" )

Config = require( "./config" )

setting = require( "./setting" )
recruse = require( "./recruse" )

class Monteur extends require( "mpbasic" )( Config )

	defaults: =>
		@extend super, {}

	initialize: =>
		return

	ask: ( cb )=>
		return if @_check( cb )

		setting.load @sourcePath, ( err, @settings )=>
			cb.apply( @, arguments )
			return
		return

	process: ( cb )=>
		recruse.on "file", @processFile
		recruse.on "end", =>
			cb( null )
			return

		recruse.on "error", ( err )=>
			cb( err )
			return

		return if @_check( false )

		recruse.start( @sourcePath )

		return @

	setSource: ( _path )=>
		@sourcePath = path.resolve( _path )
		@debug "source", @sourcePath
		return @

	setTarget: ( _path )=>
		@targetPath = path.resolve( _path )
		@debug "target", @targetPath
		return @

	processFile: ( path, name, content )=>
		@info "file", path, name
		return

	_check: ( cb = false )=>
		if not @sourcePath?.length
			@_handleError( cb, "EMISSINGSOURCE" )
			return true

		if not @targetPath?.length
			@_handleError( cb, "EMISSINGTARGET" )
			return true

		return false

	ERRORS: =>
		return @extend {}, super, 
			"EMISSINGSOURCE": [ 409, "Please set the source Path with `monteur.seetSource( 'mypath' )`" ]
			"EMISSINGTARGET": [ 409, "Please set the target Path with `monteur.setTarget( 'mypath' )`" ]


module.exports = new Monteur()