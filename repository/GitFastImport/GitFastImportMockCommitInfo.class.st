"
I am a mock object for testing writing commit preamble.
"
Class {
	#name : #GitFastImportMockCommitInfo,
	#superclass : #Object,
	#category : 'GitFastImport-Tests'
}

{ #category : #accessing }
GitFastImportMockCommitInfo >> authorEmail [
	^ 'author@example.com'
]

{ #category : #accessing }
GitFastImportMockCommitInfo >> authorName [
	^ 'An Author'
]

{ #category : #accessing }
GitFastImportMockCommitInfo >> authoredDate [
	^ DateAndTime
		year: 2000
		month: 1
		day: 20
		hour: 7
		minute: 20
		offset: 2 hours
]

{ #category : #accessing }
GitFastImportMockCommitInfo >> commitMessage [
	^ 'commit message'
]

{ #category : #accessing }
GitFastImportMockCommitInfo >> committedDate [
	^ DateAndTime
		year: 2000
		month: 1
		day: 20
		hour: 7
		minute: 30
		offset: 2 hours
]

{ #category : #accessing }
GitFastImportMockCommitInfo >> committerEmail [
	^ 'committer@example.com'
]

{ #category : #accessing }
GitFastImportMockCommitInfo >> committerName [
	^ 'A Committer'
]

{ #category : #accessing }
GitFastImportMockCommitInfo >> parents [
	^ #()
]
