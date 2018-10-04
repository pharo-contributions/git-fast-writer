Class {
	#name : #GitFastImportMockCommitInfoWithSingleParent,
	#superclass : #GitFastImportMockCommitInfo,
	#instVars : [
		'parents'
	],
	#category : 'GitFastImport-Tests'
}

{ #category : #accessing }
GitFastImportMockCommitInfoWithSingleParent >> parents [
	^ parents ifNil: [ parents := {GitFastImportMockCommitInfo new} ]
]
