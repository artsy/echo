const envsub = require('envsub')

const repoDir = `${__dirname}/..`

const deploy = () => {
	// replace all `${Foo}` instances with values from env
	envsub({
		templateFile: `${repoDir}/Echo.json`,
		outputFile: `${repoDir}/build/Echo.json`,
		options: {
			system: true,
		},
	})

// replace $ with env

// modify updated_at

//  validate jso

//  minify json

//  upload to eigen/Echo.test.json
//  upload to eigen Echo-current_date-current_git_hash.json

// invalidate cloudflare
}

deploy()
