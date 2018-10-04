Extension { #name : #FileSystem }

{ #category : #'*GitFastImport' }
FileSystem class >> unicodeMemory [
	^ self store: GitFastImportMemoryStore new
]
