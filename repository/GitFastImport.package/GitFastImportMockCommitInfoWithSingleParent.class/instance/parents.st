accessing
parents
	^ parents ifNil: [ parents := {GitFastImportMockCommitInfo new} ]