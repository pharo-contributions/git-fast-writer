converting
pathFromString: aStringOrSymbol
	| normalized |
	"Normalize both / to \ to the current one (so it works both on Unix and Windows)"
	normalized := (aStringOrSymbol asString
		copyReplaceAll: WindowsStore delimiter asString
		with: self delimiter asString)
		copyReplaceAll: UnixStore delimiter asString
		with: self delimiter asString.
	^ super pathFromString: normalized