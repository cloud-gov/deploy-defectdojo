# cg-deploy-defectdojo
Deployment pipeline for DefectDojo

## Overview

The DefectDojo CI/CD pipeline is set up to deploy dev, staging, and production versions of DefectDojo using the DefectDojo bosh release at https://github.com/cloud-gov/defectdojo-boshrelease.

All sensitive materials are stored in Credhub.

## Tests

This repo contains two tests that are deployed as part of the CI/CD pipeline.

1. The `test-import` job submits an empty results file to DefectDojo any time the DefectDojo server is redeployed to confirm that the API is working correctly.

2. The `deduplication` job sends an api request to turn on deduplication. This runs hourly, and after every deploy, to ensure that deduplication is turned on, and alerts us if it is not.

## Updating DefectDojo Versions

The CI/CD pipeline is set up to automatically download new upstream DefectDojo releases and then kicks of the dev deployment of DefectDojo. If that succeeds then it will kick of the staging deployment. Production deployments must be manually triggered. This allows for testing of the newest version in dev and staging.

### Update Issues
If the pipeline fails after downloading a new upstream DefectDojo deployment then the VM logs should be examined to determine the error.

Sometimes the upstream DefectDojo updates the version of Python being used, which requires us to update the Python version in the DefectDojo Bosh Release to resolve the issue.
