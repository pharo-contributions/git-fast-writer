accessing
commitMarkFor: aCommitInfo
	^ commitMarks at: aCommitInfo ifAbsentPut: [ commitMarks size + 1 ]