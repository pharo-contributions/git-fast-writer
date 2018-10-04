Class {
	#name : #GitFastImportMockCommitInfoWithTwoParents,
	#superclass : #GitFastImportMockCommitInfo,
	#instVars : [
		'parents'
	],
	#category : 'GitFastImport-Tests'
}

{ #category : #accessing }
GitFastImportMockCommitInfoWithTwoParents >> parents [
	^ parents
		ifNil: [ parents := {GitFastImportMockCommitInfo new.
			GitFastImportMockCommitInfo new} ]
]
