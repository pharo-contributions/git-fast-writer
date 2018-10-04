Class {
	#name : #GitFastImportMemoryStoreTest,
	#superclass : #TestCase,
	#instVars : [
		'store'
	],
	#category : 'GitFastImport-Tests'
}

{ #category : #running }
GitFastImportMemoryStoreTest >> setUp [
	super setUp.
	store := GitFastImportMemoryStore new
]

{ #category : #running }
GitFastImportMemoryStoreTest >> testPathFromString [
	self assert: (store pathFromString: 'temp\folder') equals: Path * 'temp' / 'folder'
]

{ #category : #running }
GitFastImportMemoryStoreTest >> testPathFromSymbol [
	self assert: (store pathFromString: #'temp\folder') equals: Path * 'temp' / 'folder'
]
