running
testPathFromString
	self assert: (store pathFromString: 'temp\folder') equals: Path * 'temp' / 'folder'