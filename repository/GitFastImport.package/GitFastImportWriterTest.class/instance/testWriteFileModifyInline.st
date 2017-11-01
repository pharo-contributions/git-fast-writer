tests - writing - import file
testWriteFileModifyInline
	| fs file |
	fs := self newMemoryStore.
	file := fs / 'folder' / 'subfolder' / 'file.txt'.
	file parent ensureCreateDirectory.
	file
		writeStreamDo: [ :aStream | 
			aStream
				<<
					'some
content' ].
	writer writeFileModifyInlineFor: file.
	self
		assertString: stream contents
		equals:
			'M 100644 inline folder/subfolder/file.txt
data 12
some
content'