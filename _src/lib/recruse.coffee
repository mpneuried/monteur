fs = require( "fs" )
path = require( "path" )

config = require( "./config" )

class Recruse extends require( "mpbasic" )( config )

	defaults: =>
		@extend super,
			excludeFolders: [ "node_modules", ".git" ]
			excludeFiles: [ ".DS_Store", "monteur.json" ]
			relevantExtensions: [ ".coffee", ".styl", ".html", ".md", ".json" ]

	initialize: =>
		@on "path", @checkpath
		@on "directory", @recruse
		@on "newfile", @processFile
		return

	start: ( _path )=>
		@count = 0
		@recruse( _path )
		return

	recruse: ( _path )=>
		@debug "recruse", _path
		fs.readdir _path, ( err, files )=>
			if err
				@error "readdir", err
				@emit "error", err
				return
			@debug "files", _path, files.length
			@count += files.length
			@emit( "path", _path + "/" + file, file ) for file in files
			return
		return

	checkpath: ( _path, name )=>
		@debug "checkpath", _path, name
		fs.stat _path, ( err, stat )=>
			if err
				@error "stats", err
				@emit "error", err
				return
			if stat.isDirectory()
				if name in @config.excludeFolders
					return
				@count--
				@emit "directory", _path, name
			else if stat.isFile()
				if name in @config.excludeFiles
					@count--
					return
				if path.extname( _path ) in @config.relevantExtensions
					@emit( "newfile", _path, name, stat )
				else
					@count--
			return
		return

	processFile: ( _path, name, stat )=>
		@debug "file", _path
		fs.readFile _path, ( err, content )=>
			if err
				@error "stats", err
				@emit "error", err
				return
			@count--
			@debug "content", _path, name, content.length, @count
			@emit "file", _path, name, content
			return
		return

	ERRORS: =>
		return @extend {}, super, 
			"ETARGETPATHNOEXIST": [ 409, "The target path does not exist!" ]

module.exports = new Recruse()