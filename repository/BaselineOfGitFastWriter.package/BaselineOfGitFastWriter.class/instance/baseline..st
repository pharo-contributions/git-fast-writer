baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec package: 'GitFastImport'.
			spec group: 'default' with: #('GitFastImport') ]