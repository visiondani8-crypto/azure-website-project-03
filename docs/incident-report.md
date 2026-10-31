# Project 4 — Cloud Monitoring Incident Report

**Incident ID:** LAB-004-001  
**Date:** 31 October 2026  
**Service:** Azure Static Web Apps  
**Resource:** azure-website-project-03  
**Classification:** Controlled failure simulation  
**Production impact:** None demonstrated  
**Status:** Resolved — monitoring verified

## 1. Incident Summary

A controlled monitoring failure was simulated through GitHub Actions to test the website's automated health-checking system.

The monitoring workflow correctly detected an intentional homepage content mismatch and failed with exit code 1. A subsequent normal health check passed.

## 2. Detection

The issue was detected through the Azure Website Health Check GitHub Actions workflow.

- Failed run: [Health Check #2](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41207889532)
- Error: Homepage content check failed
- Workflow result: Failure

## 3. Root Cause

The simulation was enabled deliberately. The workflow checked the website for a text string that was not expected to exist.

This caused the content-validation step to fail. No actual website outage was introduced.

## 4. Resolution and Verification

A new workflow run was manually triggered with failure simulation disabled.

- Recovery verification: [Health Check #3](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41208079533)
- Workflow result: Success
- Total run duration: 7 seconds

## 5. Lessons Learned

- How to monitor a cloud-hosted website using HTTP requests.
- How to configure automated checks using GitHub Actions.
- How to inspect failed workflow results and error messages.
- How to distinguish a simulated monitoring failure from an actual service outage.
- How to verify normal operation after a controlled failure test.

## 6. Follow-up Actions

- Verify scheduled monitoring executions.
- Configure failure notifications.
- Document monitoring evidence in GitHub.
- Review the limitations of periodic checks and possible false alarms.
- Review the limitations of periodic checks and possible false alarms.
