"
I decorate the output WriteStream and make sure that no Character nulls are ever written.
"
Class {
	#name : #GitFastImportGuardStream,
	#superclass : #Object,
	#instVars : [
		'writeStream'
	],
	#category : 'GitFastImport'
}

{ #category : #'instance creation' }
GitFastImportGuardStream class >> on: aStream [
	^ self new
		on: aStream;
		yourself
]

{ #category : #writing }
GitFastImportGuardStream >> << aCollection [
	self nextPutAll: aCollection
]

{ #category : #writing }
GitFastImportGuardStream >> lf [
	writeStream lf
]

{ #category : #writing }
GitFastImportGuardStream >> nextPutAll: aString [
	self
		assert: [ aString noneSatisfy: [ :each | each = Character null ] ]
		description: [ 'Cannot write null characters: ' , aString ].
	writeStream nextPutAll: aString
]

{ #category : #initialization }
GitFastImportGuardStream >> on: aStream [
	writeStream := aStream
]
