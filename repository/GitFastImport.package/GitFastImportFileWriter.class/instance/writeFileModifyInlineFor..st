writing
writeFileModifyInlineFor: aFileReference
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