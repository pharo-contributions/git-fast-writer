tests - writing - import file
testWriteFileModes
	| contents |
	(store / 'special-files') ensureCreateDirectory.
	(store / 'special-files' / 'dir-link') ensureCreateFile.
	(store / 'special-files' / 'executable.sh') ensureCreateFile.
	(store / 'special-files' / 'file-link.txt') ensureCreateFile.
	(store / 'special-files' / 'regular.txt') ensureCreateFile.
	writer
		fileModes:
			{('/special-files/dir-link' -> 8r120000).
			('/special-files/executable.sh' -> 8r100755).
			('/special-files/file-link.txt' -> 8r120000).
			('/special-files/regular.txt' -> 8r100644)} asDictionary.
	writer writeDirectoryTreeInlineFor: store.
	contents := stream contents.
	self assert: (contents includesSubstring: 'M 120000 inline special-files/dir-link').
	self
		assert: (contents includesSubstring: 'M 100755 inline special-files/executable.sh').
	self assert: (contents includesSubstring: 'M 120000 inline special-files/file-link.txt').
	self assert: (contents includesSubstring: 'M 100644 inline special-files/regular.txt')