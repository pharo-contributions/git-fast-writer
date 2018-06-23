tests - writing - import file
testWriteMergesWithSingleParent
	| contents info |
	info := GitFastImportMockCommitInfoWithSingleParent new.
	writer writeCommitPreambleFor: info parents first.
	stream reset.
	writer writeMergesFor: info.
	contents := stream contents.
	self assertString: contents equals: 'from :1'