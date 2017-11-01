tests - writing - import file
testWriteCommitPreamble
	| contents |
	writer writeCommitPreambleFor: GitFastImportMockCommitInfo new.
	contents := stream contents.
	self
		assertString: contents
		equals:
			'commit refs/heads/master
mark :1
author An Author <author@example.com> 948345600 +0000
committer A Committer <committer@example.com> 948346200 +0000
data 14
commit message'