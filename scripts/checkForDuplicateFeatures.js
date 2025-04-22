import fs from 'fs'
import json5 from 'json5'

export function checkForDuplicateFeatures(filePath) {
  const fileContent = fs.readFileSync(filePath, 'utf8')
  const { features } = json5.parse(fileContent)
  const rawLines = fileContent.split('\n')

  const featureNames = new Map()

  features.map((feature) => {
    if (featureNames.has(feature.name)) {
      const firstOccurrence = featureNames.get(feature.name)
      const currentOccurrence =
        rawLines.findIndex((line, lineNumber) => {
          return (
            lineNumber > firstOccurrence &&
            line.includes(`name: '${feature.name}'`)
          )
        }) + 1

      throw new Error(
        `Duplicate feature name "${feature.name}" found.\n` +
          `First occurrence: line ${firstOccurrence}\n` +
          `Duplicate occurrence: line ${currentOccurrence}`,
      )
    }

    const firstOccurrence =
      rawLines.findIndex((line) => line.includes(`name: '${feature.name}'`)) + 1
    featureNames.set(feature.name, firstOccurrence)
  })
}
