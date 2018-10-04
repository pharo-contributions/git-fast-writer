Class {
	#name : #GitFastImportWriterTest,
	#superclass : #TestCase,
	#instVars : [
		'stream',
		'writer',
		'store'
	],
	#category : 'GitFastImport-Tests'
}

{ #category : #asserting }
GitFastImportWriterTest >> assertString: actual equals: expected [
	self assert: actual lines equals: expected lines
]

{ #category : #'instance creation' }
GitFastImportWriterTest >> newMemoryStore [
	^ FileSystem unicodeMemory root ensureCreateDirectory
]

{ #category : #running }
GitFastImportWriterTest >> setUp [
	super setUp.
	stream := String new writeStream.
	writer := GitFastImportFileWriter new on: stream.
	store := self newMemoryStore
]

{ #category : #'tests - writing - import file' }
GitFastImportWriterTest >> testCommitMark [
	| info |
	info := GitFastImportMockCommitInfoWithSingleParent new.
	self assert: (writer commitMarkFor: info parents first) equals: 1.
	self assert: (writer commitMarkFor: info) equals: 2.
	self assert: (writer commitMarkFor: info parents first) equals: 1
]

{ #category : #'tests - writing - import file' }
GitFastImportWriterTest >> testNullsAreGuarded [
	self should: [ writer writeLine: Character null asString ] raise: AssertionFailure
]

{ #category : #'tests - writing - import file' }
GitFastImportWriterTest >> testWriteCommitPreamble [
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
]

{ #category : #'tests - writing - import file' }
GitFastImportWriterTest >> testWriteDeleteReference [
	| contents |
	writer writeDeleteReference: store / 'repository' / 'Some-Location'.
	contents := stream contents.
	self assertString: contents equals: 'D repository/Some-Location'
]

{ #category : #'tests - writing - import file' }
GitFastImportWriterTest >> testWriteDirectoryTreeInline [
	| fs file1 file2 file3 |
	fs := self newMemoryStore.
	file1 := fs / 'folder' / 'top.txt'.
	file2 := fs / 'folder' / 'empty.txt'.
	file3 := fs / 'folder' / 'subfolder' / 'bottom.txt'.
	file3 parent ensureCreateDirectory.
	file1 writeStreamDo: [ :s | s << 'top content' ].
	file2 writeStreamDo: [ :s | s << '' ].
	file3 writeStreamDo: [ :s | s << 'bottom content' ].
	writer writeDirectoryTreeInlineFor: fs / 'folder'.
	self
		assertString: stream contents
		equals:
			'M 100644 inline folder/empty.txt
data 0

M 100644 inline folder/top.txt
data 11
top content
M 100644 inline folder/subfolder/bottom.txt
data 14
bottom content'
]

{ #category : #'tests - writing - import file' }
GitFastImportWriterTest >> testWriteFileModes [
	| contents |
	(store / 'special-files') ensureCreateDirectory.
	(store / 'special-files' / 'dir-link') ensureCreateFile.
	(store / 'special-files' / 'executable.sh') ensureCreateFile.
	(store / 'special-files' / 'file-link.txt') ensureCreateFile.
	(store / 'special-files' / 'regular.txt') ensureCreateFile.
	writer
		fileModes:
			{('/special-files/dir-link' -> 8r120000).
			('/special-files/executable.sh' -> 8r100755).
			('/special-files/file-link.txt' -> 8r120000).
			('/special-files/regular.txt' -> 8r100644)} asDictionary.
	writer writeDirectoryTreeInlineFor: store.
	contents := stream contents.
	self assert: (contents includesSubstring: 'M 120000 inline special-files/dir-link').
	self
		assert: (contents includesSubstring: 'M 100755 inline special-files/executable.sh').
	self assert: (contents includesSubstring: 'M 120000 inline special-files/file-link.txt').
	self assert: (contents includesSubstring: 'M 100644 inline special-files/regular.txt')
]

{ #category : #'tests - writing - import file' }
GitFastImportWriterTest >> testWriteFileModifyInline [
	| fs file |
	fs := self newMemoryStore.
	file := fs / 'folder' / 'subfolder' / 'file.txt'.
	file parent ensureCreateDirectory.
	file
		writeStreamDo: [ :aStream | 
			aStream
				<<
					'some
content' ].
	writer writeFileModifyInlineFor: file.
	self
		assertString: stream contents
		equals:
			'M 100644 inline folder/subfolder/file.txt
data 12
some
content'
]

{ #category : #'tests - writing - import file' }
GitFastImportWriterTest >> testWriteMergesWithSingleParent [
	| contents info |
	info := GitFastImportMockCommitInfoWithSingleParent new.
	writer writeCommitPreambleFor: info parents first.
	stream reset.
	writer writeMergesFor: info.
	contents := stream contents.
	self assertString: contents equals: 'from :1'
]

{ #category : #'tests - writing - import file' }
GitFastImportWriterTest >> testWriteMergesWithTwoParents [
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
]

{ #category : #'tests - writing - import file' }
GitFastImportWriterTest >> testWriteUnicodeInline [
	| file |
	file := store / 'file.txt'.
	file writeStreamDo: [ :aStream | aStream << '你好' ].
	writer writeFileModifyInlineFor: file.
	self
		assertString: stream contents
		equals:
			'M 100644 inline file.txt
data 6
你好'
]
