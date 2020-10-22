const fs = require('fs')
const envsub = require('envsub')
const jsonminify = require('jsonminify')
const { exit } = require('process')
const jsonschema = require('jsonschema')

const repoDir = `${__dirname}/..`
const templateFile = `${repoDir}/Echo.json`
const outputFile = `${repoDir}/build/Echo.json`
const outputFileMini = `${repoDir}/build/Echo.min.json`

const schema = require('../schema.json')

const prepare = async () => {
  try {
    await envsub({
      templateFile,
      outputFile,
      options: {
        all: true, // substitute from system and envs
        system: true, // replace all `${Foo}` instances with values from env
        envs: [{ name: 'ECHO_CURRENT_TIME', value: new Date().toISOString() }], // modify updated_at
      },
    })

    // validate json
    const rawdata = fs.readFileSync(outputFile)
    const json = JSON.parse(rawdata)
    const validator = new jsonschema.Validator()
    const validation = validator.validate(json, schema)

    if (validation.errors.length) {
      console.log({errors: validation.errors})
      throw "Did not pass schema validation: " + JSON.stringify(validation.errors)
    }

    // minify json
    const minijson = jsonminify(JSON.stringify(json))
    fs.writeFileSync(outputFileMini, minijson)
  } catch (e) {
    console.error(e)
    exit(-1)
  }
}

prepare()
