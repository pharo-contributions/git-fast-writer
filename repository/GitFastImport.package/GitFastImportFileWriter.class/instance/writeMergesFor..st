writing
writeMergesFor: aCommitInfo
	aCommitInfo parents
		ifNotEmpty: [ :parents | 
			writeStream
				<< ('from :<1p>' expandMacrosWith: (self commitMarkFor: parents first));
				cr.
			parents allButFirst
				do: [ :each | 
					writeStream
						<< ('merge :<1p>' expandMacrosWith: (self commitMarkFor: each));
						cr ] ]