"
I am a baseline for github.com/peteruhnak/git-fast-writer
"
Class {
	#name : #BaselineOfGitFastWriter,
	#superclass : #BaselineOf,
	#category : 'BaselineOfGitFastWriter'
}

{ #category : #baselines }
BaselineOfGitFastWriter >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec package: 'GitFastImport'.
			spec group: 'default' with: #('GitFastImport') ]
]
