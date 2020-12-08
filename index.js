// @ts-check
const express = require('express')
const fetch = require('node-fetch').default

const PORT = process.env.PORT || 5000
const S3_URL = 'https://echo.artsy.net/Echo.json'

const fetchS3Echo = async () => {
  const s3ContentsResponse = await fetch(S3_URL)
  const s3ContentsJSON = await s3ContentsResponse.json()
  console.log(`Fetched S3 bucket JSON ${s3ContentsResponse.status}`)
  return { content: s3ContentsJSON }
}

express()
  .head('/accounts/1', async (req, res) => {
    console.log(`Receiving HEAD request '${req.path}' from ${req.ip}`)
    const { content: s3ContentsJSON } = await fetchS3Echo()
    res.set('Updated-At', s3ContentsJSON.updated_at)
    res.end()
  })
  .get('/accounts/1', async (req, res) => {
    console.log(`Receiving GET request '${req.path}' from ${req.ip}`)
    const { content: s3ContentsJSON } = await fetchS3Echo()
    res.json(s3ContentsJSON)
  })
  .get('/health', (_req, res) => {
    res.end()
  })
  .listen(PORT, () => console.log(`Listening on ${PORT}`))
