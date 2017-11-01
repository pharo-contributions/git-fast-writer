tests - writing - import file
testWriteCommitPreambleWithTwoParents
	| contents info |
	info := GitFastImportMockCommitInfoWithTwoParents new.
	writer writeCommitPreambleFor: info parents first.
	writer writeCommitPreambleFor: info parents second.
	stream reset.
	writer writeCommitPreambleFor: info.
	contents := stream contents.
	self
		assertString: contents
		equals:
			'commit refs/heads/master
mark :3
author An Author <author@example.com> 948345600 +0000
committer A Committer <committer@example.com> 948346200 +0000
data 14
commit message
from :1
merge :2'