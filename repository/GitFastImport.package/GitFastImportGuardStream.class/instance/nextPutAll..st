writing
nextPutAll: aString
	self
		assert: [ aString noneSatisfy: [ :each | each = Character null ] ]
		description: [ 'Cannot write null characters: ' , aString ].
	writeStream nextPutAll: aString