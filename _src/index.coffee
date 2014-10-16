cli = require('cli').enable('help', 'status', "version")
config = require( "./lib/config" )

_ = require( "lodash" )

monteur = require( "./lib/monteur" )

cli.setApp( "Monteur", config.version )

exports.run = ->
	cli.parse(
		source: [ "s", "Source folder with the template", "string" ]
		target: [ "t", "Target folder", "string" ]
	)
	cli.main ( args, options )->
		[ sourceFolder, targetFolder ] = args

		monteur
			.setSource( sourceFolder )
			.setTarget( targetFolder )
			.ask().then ->
				this.process ( err )=>
					cli.ok( "END" )
					return
				return
		return
	return

process.on "uncaughtException", ( _err )=>
	cli.error( _err )
	process.exit()
	return