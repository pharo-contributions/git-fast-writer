writing
writeDeleteReference: aFileReference
	writeStream
		<< 'D ';
		<< (aFileReference fullName trimLeft: [ :c | c = self delimiter ]);
		lf