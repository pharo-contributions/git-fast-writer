writing
writeCommitPreambleFor: aCommitInfo
	writeStream
		nextPutAll:
			('commit refs/heads/master
mark :{commitMark}
author {authorName} <{authorEmail}> {authoredDate} +0000
committer {committerName} <{committerEmail}> {committedDate} +0000
{commitMessageSize}
{commitMessage}'
				format:
					{(#commitMark -> (self commitMarkFor: aCommitInfo)).
					(#authorName -> aCommitInfo authorName).
					(#authorEmail -> aCommitInfo authorEmail).
					(#authoredDate -> aCommitInfo authoredDate withoutOffset asUnixTime).
					(#committerName -> aCommitInfo committerName).
					(#committerEmail -> aCommitInfo committerEmail).
					(#committedDate -> aCommitInfo committedDate withoutOffset asUnixTime).
					(#commitMessageSize
						-> ('data ' , aCommitInfo commitMessage size asString)).
					(#commitMessage -> aCommitInfo commitMessage)} asDictionary).
	aCommitInfo parents
		ifNotEmpty: [ :parents | 
			writeStream cr.
			writeStream
				<< ('from :<1p>' expandMacrosWith: (self commitMarkFor: parents first));
				cr.
			parents allButFirst
				do: [ :each | 
					writeStream
						<< ('merge :<1p>' expandMacrosWith: (self commitMarkFor: each));
						cr ] ]