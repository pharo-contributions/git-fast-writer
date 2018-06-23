tests - writing - import file
testWriteMergesWithTwoParents
	| contents info |
	info := GitFastImportMockCommitInfoWithTwoParents new.
	writer writeCommitPreambleFor: info parents first.
	writer writeCommitPreambleFor: info parents second.
	stream reset.
	writer writeMergesFor: info.
	contents := stream contents.
	self
		assertString: contents
		equals:
			'from :1
merge :2'