tests - writing - import file
testWriteUnicodeInline
	| file |
	file := store / 'file.txt'.
	file writeStreamDo: [ :aStream | aStream << '你好' ].
	writer writeFileModifyInlineFor: file.
	self
		assertString: stream contents
		equals:
			'M 100644 inline file.txt
data 6
你好'