PackageJSON = require( "../package.json" )

_ = require( "lodash" )
_.templateSettings =
  interpolate : /\{MAKE\{(.+?)\}MAKE\}/g

DEFAULT = 
	version: PackageJSON.version

# load the local config if the file exists
try
	_localconf = require( "../config.json" )
catch _err
	if _err?.code is "MODULE_NOT_FOUND"
		_localconf = {}
	else
		throw _err

# The config module
extend = require( "extend" )

class Config
	constructor: ( @severity = "info" )->
		return

	init: ( input )=>
		@config = extend( true, {}, DEFAULT, _localconf, input )
		@_inited = true
		return

	all: ( logging = false )=>
		if not @_inited
			@init( {} )

		_all = for _k, _v in @config
			@get( _k, logging )
		return _all

	get: ( name, logging = false )=>
		if not @_inited
			@init( {} )

		_cnf = @config?[ name ] or null
		if logging

			logging = 
				logging:
					severity: process.env[ "severity_#{name}"] or @severity
					severitys: "fatal,error,warning,info,debug".split( "," )
			return extend( true, {}, logging, _cnf )
		else
			return _cnf

module.exports = new Config( process.env.severity )