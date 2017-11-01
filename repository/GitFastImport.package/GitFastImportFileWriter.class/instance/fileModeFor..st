accessing
fileModeFor: aFileReference
	^ (fileModes at: aFileReference fullName ifAbsent: [ 8r100644 ]) printStringBase: 8