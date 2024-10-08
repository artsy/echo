#!/usr/bin/env bash
set -euxo pipefail

echo "Running Eigen tests"

PIPELINE_ID=$(curl --request POST \
              --url https://circleci.com/api/v2/project/github/artsy/eigen/pipeline \
              --header "Circle-Token: ${EIGEN_ECHO_API_TOKEN}" \
              --header 'content-type: application/json' \
              --data '{"parameters":{"run_workflow_build-run-tests-for-echo":true, "run_workflow_test-build-deploy":false}}' \
              | jq -r '.id')

echo "Triggered eigen pipeline: $PIPELINE_ID"

# wait for pipeline to finish
STATUS="running"
WORKFLOW_ID=""
while [ "$STATUS" == "running" ] || [ -z "$WORKFLOW_ID" ]; do
  echo "Checking eigen workflow status..."
  # Fetch the workflows associated with the pipeline
  RESPONSE=$(curl --request GET \
              --url https://circleci.com/api/v2/pipeline/$PIPELINE_ID/workflow \
              --header "Circle-Token: ${EIGEN_ECHO_API_TOKEN}")

  WORKFLOW_ID=$(echo $RESPONSE | jq -r '.items[0].id')

  if [ -z "$WORKFLOW_ID" ] || [ "$WORKFLOW_ID" == "null" ]; then
    echo "Workflow not yet created, waiting for 1 minute before retrying..."
    sleep 30  # Wait for 30s before checking again
    continue
  fi

  STATUS=$(echo $RESPONSE | jq -r '.items[0].status')

  echo "Current status: $STATUS"

  if [ "$STATUS" == "success" ]; then
    echo "Eigen workflow succeeded."
    exit 0
   elif [ "$STATUS" == "failed" ]; then
    echo "Eigen workflow failed."
    exit 1
  fi

  echo "Workflow still running, waiting for 30s before checking again..."
  sleep 30  # Wait for 5 minutes before checking again
done