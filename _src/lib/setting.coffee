fs = require( "fs" )

Config = require( "./config" )

class Setting extends require( "mpbasic" )( Config )

	defaults: =>
		@extend super, 
			filename: "monteur.json"

	initialize: =>
		return

	load: ( _path, cb )=>
		fs.readFile _path + "/" + @config.filename, ( err, content )=>
			if err 
				cb( err )
				return
			@info "setting", _path, content.toSting()
			return
		return

	ERRORS: =>
		return @extend {}, super, 
			"EMISSINGSOURCE": [ 409, "Please set the source Path with `monteur.seetSource( 'mypath' )`" ]
			"EMISSINGTARGET": [ 409, "Please set the target Path with `monteur.setTarget( 'mypath' )`" ]


module.exports = new Setting()