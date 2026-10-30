# Azure Cloud Portfolio — Project 03

**Deploy a static website to Microsoft Azure with automated GitHub Actions CI/CD.**

[🌐 Live website](https://polite-smoke-0e690c510.5.azurestaticapps.net) · [✅ Verified deployment run](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41139605946) · [⚙️ GitHub Actions](https://github.com/visiondani8-crypto/azure-website-project-03/actions)

## Project overview

This is a hands-on **personal cloud engineering lab**. I provisioned an Azure Static Web App on the **Free** plan, connected it to a GitHub repository, and used GitHub Actions to automatically deploy updates from the `main` branch. I then changed the homepage and verified the updated page appeared on the public Azure URL.

**Outcome:** Azure resource created successfully; automated deployment succeeded; updated website confirmed live on **30 October 2026**.

## Architecture

```text
Developer updates src/index.html
              │
              ▼
      GitHub repository
         main branch
              │  push
              ▼
        GitHub Actions
       Build + Deploy job
              │  authenticated deployment
              ▼
       Azure Static Web Apps
        Free hosting plan
              │
              ▼
        Public HTTPS website
```

## Tools and skills practised

| Area | Technology / task |
| --- | --- |
| Cloud hosting | Microsoft Azure Static Web Apps (Free plan) |
| Source control | GitHub repository and commits |
| CI/CD | GitHub Actions workflow triggered by a push |
| Web development | Basic HTML and CSS |
| Deployment configuration | App path `./src`, no API, output path `.` |
| Cloud organisation | Resource group and Project/Environment tags |
| Validation | Inspect workflow status and compare the live page with the committed HTML |
| Troubleshooting | Diagnose a regional restriction and select a supported deployment region |

## Deployment configuration

| Setting | Value |
| --- | --- |
| Azure resource | `azure-website-project-03` |
| Resource group | `azure-website-project-03_group` |
| Hosting SKU | Free |
| Functions/staging region | Central US |
| Static content distribution | Global |
| Repository | `visiondani8-crypto/azure-website-project-03` |
| Deployment branch | `main` |
| Build preset | Custom |
| App location | `./src` |
| API location | None |
| Output location | `.` |
| Deployment authorisation | Deployment token |

## What I did

1. Created a public GitHub repository from a basic static web application template.
2. Configured an Azure Static Web App with a Free hosting plan.
3. Connected Azure to GitHub and configured the GitHub Actions deployment workflow.
4. Resolved a deployment-blocking Azure regional restriction: West Europe rejected the new resource with `RequestDisallowedByAzure`; I selected Central US and successfully provisioned the resource.
5. Verified that the Azure resource was marked **Ready** and that the default website loaded over HTTPS.
6. Edited `src/index.html`, committed the updated content to `main`, and confirmed that the GitHub Actions **Build and Deploy Job** succeeded.
7. Opened the public site and verified that it displayed the new **Azure Cloud Portfolio** heading and project information.

## Proof of deployment

- [Azure website — live production URL](https://polite-smoke-0e690c510.5.azurestaticapps.net)
- [GitHub Actions run #2 — successful automated deployment](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41139605946)
- [Full GitHub Actions deployment history](https://github.com/visiondani8-crypto/azure-website-project-03/actions)

### Screenshots (downloadable evidence pack)

[**Download the Project 03 evidence ZIP**](./project03_evidence.zip). The ZIP contains:

- `azure_resource_overview.png` — shows the Azure Static Web App, Free plan and Ready status.
- `github_actions_success.png` — shows the successful CI/CD workflow run.
- `live_site_updated.png` — shows the deployed portfolio homepage.

> To display these screenshots **inline** in this README, extract the ZIP and commit its three PNG files into an `evidence/` directory. Then replace this section with Markdown image links to those files.

No subscription IDs, tokens or private keys should be committed to this repository.

## Repository structure

```text
.github/workflows/     # CI/CD workflow created during Azure setup
src/index.html         # Published web page
src/styles.css         # Website stylesheet
package.json           # Starter project metadata
readme.md              # Project documentation
```

## Reproduce the change/deployment workflow

1. Update the website content in `src/index.html`.
2. Commit the change to the `main` branch.
3. Open [GitHub Actions](https://github.com/visiondani8-crypto/azure-website-project-03/actions) and confirm the latest **Build and Deploy** job succeeds.
4. Refresh the [live website](https://polite-smoke-0e690c510.5.azurestaticapps.net) and verify the change appears.

> **Security note:** Deployment tokens and credentials belong in secured platform secrets, never in source code, screenshots or documentation.

## CV-ready description

**Azure Static Website Deployment (Personal Project)** — Deployed a static website to Azure Static Web Apps and connected GitHub Actions for automatic deployment. Validated live changes after repository commits and troubleshot an Azure regional provisioning restriction.

---

*Project status: Successfully deployed and tested. This is a beginner personal lab, not a production-scale service or paid-work engagement.*
