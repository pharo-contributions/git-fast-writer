writing
writeFileModifyInlineFor: aFileReference
	| contents reader rawContents |
	rawContents := aFileReference contents.
	reader := MultiByteBinaryOrTextStream with: rawContents encoding: #UTF8.
	contents := reader reset contents.
	writeStream
		nextPutAll: 'M ' , (self fileModeFor: aFileReference) , ' inline ';
		<< (aFileReference fullName trimLeft: [ :c | c = self delimiter ]);
		cr;
		<< 'data ';
		<< rawContents size;
		cr;
		<< contents;
		cr