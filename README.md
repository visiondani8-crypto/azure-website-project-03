# Automated Web Deployment with Azure Static Web Apps & GitHub Actions

**Cloud engineering portfolio | Microsoft Azure | Guided deployment lab**

## Objective

Publish a basic static website using Azure Static Web Apps and connect its source repository to a GitHub Actions-based deployment process. The objective is to practise cloud hosting, deployment configuration, and diagnosing Azure subscription/deployment constraints.

**Project type:** Personal guided technical lab, not a client or production deployment.

## Repository contents

- `src/index.html` — minimal HTML website describing the Azure hosting demonstration.
- `src/styles.css` — page styling.
- `package.json` — local project metadata and a static file server command.
- `.github/workflows/` — GitHub Actions workflow directory for the Azure deployment.

## Implementation summary

1. Prepared a simple static website.
2. Created/configured an Azure Static Web App linked with this GitHub repository.
3. Configured the deployment integration using GitHub Actions.
4. Investigated Azure deployment validation, region and policy constraints encountered during setup.
5. Completed the guided deployment exercise.

## What this demonstrates

- Azure Static Web Apps as a managed static hosting service
- GitHub source-control integration
- Continuous delivery workflow concepts
- Diagnosing Azure resource deployment errors
- Separating application files from Azure hosting configuration

## Evidence and limitations

This repository provides the website source and deployment workflow configuration. The initial deployment was completed during the guided lab, but the current production URL, most recent workflow result and uptime have **not been independently reverified** for this case study. A successful workflow run, Azure resource screenshot and live site URL should be added once available.

This was a **small static website**, not a production multi-tier application; it does not demonstrate Kubernetes, backend scaling, database deployment, or advanced release strategies.

## Next improvements

- Record a redacted successful GitHub Actions run.
- Add the verified Azure Static Web Apps URL.
- Explain the deployment-region/policy error and its resolution with exact redacted evidence.
- Add a short architecture diagram and cleanup/cost notes.

## Security

Do not commit Azure deployment tokens, secrets, personal account details, or subscription credentials. Store deployment secrets in appropriate encrypted GitHub Actions secrets or provider-managed credentials.
