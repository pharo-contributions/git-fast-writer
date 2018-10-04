tests - writing - import file
testNullsAreGuarded
	self should: [ writer writeLine: Character null asString ] raise: AssertionFailure