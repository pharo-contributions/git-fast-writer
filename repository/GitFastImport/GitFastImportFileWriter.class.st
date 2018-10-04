"
I take a Memory Store and write the contents on a provided write stream in a git fast-import format.
"
Class {
	#name : #GitFastImportFileWriter,
	#superclass : #Object,
	#instVars : [
		'writeStream',
		'commitMarks',
		'fileModes'
	],
	#category : 'GitFastImport'
}

{ #category : #accessing }
GitFastImportFileWriter >> commitMarkFor: aCommitInfo [
	^ commitMarks at: aCommitInfo ifAbsentPut: [ commitMarks size + 1 ]
]

{ #category : #accessing }
GitFastImportFileWriter >> commitMarks [
	^ commitMarks
]

{ #category : #accessing }
GitFastImportFileWriter >> delimiter [
	^ GitFastImportMemoryStore delimiter
]

{ #category : #accessing }
GitFastImportFileWriter >> fileModeFor: aFileReference [
	^ (fileModes at: aFileReference fullName ifAbsent: [ 8r100644 ]) printStringBase: 8
]

{ #category : #accessing }
GitFastImportFileWriter >> fileModes: aDictionary [
	fileModes := aDictionary
]

{ #category : #initialization }
GitFastImportFileWriter >> initialize [
	super initialize.
	commitMarks := OrderedDictionary new.
	fileModes := Dictionary new
]

{ #category : #initialization }
GitFastImportFileWriter >> on: aStream [
	writeStream := GitFastImportGuardStream on: aStream
]

{ #category : #writing }
GitFastImportFileWriter >> writeCommitPreambleFor: aCommitInfo [
	writeStream
		nextPutAll:
			('commit refs/heads/master
mark :{commitMark}
author {authorName} <{authorEmail}> {authoredDate} +0000
committer {committerName} <{committerEmail}> {committedDate} +0000
{commitMessageSize}
{commitMessage}
' withUnixLineEndings
				format:
					{#commitMark -> (self commitMarkFor: aCommitInfo).
					#authorName -> aCommitInfo authorName.
					#authorEmail -> aCommitInfo authorEmail.
					#authoredDate -> aCommitInfo authoredDate withoutOffset asUnixTime.
					#committerName -> aCommitInfo committerName.
					#committerEmail -> aCommitInfo committerEmail.
					#committedDate -> aCommitInfo committedDate withoutOffset asUnixTime.
					#commitMessageSize -> ('data ' , aCommitInfo commitMessage utf8Encoded size asString).
					#commitMessage -> aCommitInfo commitMessage} asDictionary)
]

{ #category : #writing }
GitFastImportFileWriter >> writeDeleteReference: aFileReference [
	writeStream
		<< 'D ';
		<< (aFileReference fullName trimLeft: [ :c | c = self delimiter ]);
		lf
]

{ #category : #writing }
GitFastImportFileWriter >> writeDirectoryTreeInlineFor: aDirectory [
	aDirectory files do: [ :each | self writeFileModifyInlineFor: each ].
	aDirectory directories do: [ :each | self writeDirectoryTreeInlineFor: each ]
]

{ #category : #writing }
GitFastImportFileWriter >> writeFileModifyInlineFor: aFileReference [
	| contents |
	contents := aFileReference contents.
	writeStream
		nextPutAll: 'M ' , (self fileModeFor: aFileReference) , ' inline ';
		<< (aFileReference fullName trimLeft: [ :c | c = self delimiter ]);
		lf;
		<< 'data ';
		<< contents utf8Encoded size asString;
		lf;
		<< contents;
		lf
]

{ #category : #writing }
GitFastImportFileWriter >> writeLine: aLine [
	writeStream
		<< aLine;
		lf
]

{ #category : #writing }
GitFastImportFileWriter >> writeMergesFor: aCommitInfo [
	aCommitInfo parents
		ifNotEmpty: [ :parents | 
			writeStream
				<< ('from :<1p>' expandMacrosWith: (self commitMarkFor: parents first));
				lf.
			parents allButFirst
				do: [ :each | 
					writeStream
						<< ('merge :<1p>' expandMacrosWith: (self commitMarkFor: each));
						lf ] ]
]
