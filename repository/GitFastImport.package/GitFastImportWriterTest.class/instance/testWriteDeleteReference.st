tests - writing - import file
testWriteDeleteReference
	| contents |
	writer writeDeleteReference: store / 'repository' / 'Some-Location'.
	contents := stream contents.
	self assertString: contents equals: 'D repository/Some-Location'