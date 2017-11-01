baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec package: 'GitFastWriter'.
			spec group: 'default' with: #('GitFastWriter') ]