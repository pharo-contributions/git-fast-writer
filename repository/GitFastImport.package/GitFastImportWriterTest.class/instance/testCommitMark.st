tests - writing - import file
testCommitMark
	| info |
	info := GitFastImportMockCommitInfoWithSingleParent new.
	self assert: (writer commitMarkFor: info parents first) equals: 1.
	self assert: (writer commitMarkFor: info) equals: 2.
	self assert: (writer commitMarkFor: info parents first) equals: 1