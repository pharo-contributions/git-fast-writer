tests - writing - import file
testWriteCommitPreambleWithSingleParent
	| contents info |
	info := GitFastImportMockCommitInfoWithSingleParent new.
	writer writeCommitPreambleFor: info parents first.
	stream reset.
	writer writeCommitPreambleFor: info.
	contents := stream contents.
	self
		assertString: contents
		equals:
			'commit refs/heads/master
mark :2
author An Author <author@example.com> 948345600 +0000
committer A Committer <committer@example.com> 948346200 +0000
data 14
commit message
from :1'