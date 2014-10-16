prompt = require( "prompt" )

Config = require( "./config" )

class Prompt extends require( "mpbasic" )( Config )

	defaults: =>
		@extend super, {}

	initialize: =>
		return

	ask: ( questions )=>



	ERRORS: =>
		return @extend {}, super, 
			"EMISSINGSOURCE": [ 409, "Please set the source Path with `monteur.seetSource( 'mypath' )`" ]
			"EMISSINGTARGET": [ 409, "Please set the target Path with `monteur.setTarget( 'mypath' )`" ]


module.exports = new Prompt()