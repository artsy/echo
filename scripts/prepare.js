import fs from "fs"
import envsub from 'envsub'
import jsonminify from 'jsonminify'
import { exit }  from 'process'
import JSON5 from 'json5'
import jsonschema from 'jsonschema'
import { execa } from 'execa'


const __dirname = new URL('.', import.meta.url).pathname

const repoDir = `${__dirname}..`
const templateFile5 = `${repoDir}/Echo.json5`
const outputFile5 = `${repoDir}/build/Echo.json5`
const outputFile = `${repoDir}/build/Echo.json`
const outputFileMini = `${repoDir}/build/Echo.min.json`
const prettierCmd = `yarn prettier --parser json --write ${outputFile}` /// use outputfile

const schema = JSON.parse(fs.readFileSync(`${repoDir}/schema.json`))

const prepare = async () => {
  try {
    await envsub({
      templateFile: templateFile5,
      outputFile: outputFile5,
      options: {
        all: true, // substitute from system and envs
        system: true, // replace all `${Foo}` instances with values from env
        envs: [{ name: 'ECHO_CURRENT_TIME', value: new Date().toISOString() }], // modify updated_at
      },
    })

    // validate json
    const rawdata = fs.readFileSync(outputFile5)
    const json = JSON5.parse(rawdata)
    const validator = new jsonschema.Validator()
    const validation = validator.validate(json, schema)

    if (validation.errors.length) {
      console.log({ errors: validation.errors })
      throw (
        'Did not pass schema validation: ' + JSON.stringify(validation.errors)
      )
    }

    const regularJSON = JSON.stringify(json)
    fs.writeFileSync(outputFile, regularJSON)
    const [head, ...tail] = prettierCmd.split(' ')
    const { exitCode, stderr } = await execa(head, tail)
    if (exitCode !== 0) {
      console.error(stderr)
      exit(exitCode)
    }

    // minify json
    const miniJSON = jsonminify(JSON.stringify(json))
    fs.writeFileSync(outputFileMini, miniJSON)
  } catch (e) {
    console.error(e)
    exit(-1)
  }
}

prepare()
