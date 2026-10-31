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

## Project 04 — Website Health Monitoring & Incident Response

After deploying the website, I extended the same Azure and GitHub environment with monitoring and a controlled incident-response exercise.

- Built a [GitHub Actions health-check workflow](.github/workflows/website-health-check.yml) for HTTP status and homepage content checks.
- Configured manual invocation and a six-hourly schedule (scheduled execution not yet verified).
- Confirmed a manual `curl` HTTP 200 result (0.295582 seconds).
- Deliberately triggered a failing content check without interrupting the website; inspected the alert and workflow logs.
- Verified GitHub Inbox notifications and restored normal monitoring. The [final health check #5 passed](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41209550079).
- Investigated a real Azure Policy denial for West Europe and documented the subsequent permitted-region deployment.

**[Read Project 04 technical case study →](docs/project-04-monitoring.md)** · **[Read incident report →](docs/incident-report.md)**

## Project 05 — Azure IAM & RBAC Least-Privilege Security Lab

Extended the existing Azure Static Web App environment with an **intermediate-level identity and access management lab** using Azure CLI and Microsoft Entra ID.

- Audited inherited subscription-scope `Owner` assignments and determined two returned entries referenced one principal identity.
- Inspected the built-in `Monitoring Reader` role's actual permissions rather than relying on its name.
- Created an isolated test service principal and scoped `Monitoring Reader` access to the **individual Static Web App**.
- Verified an authorised read of the website using independent service-principal authentication.
- Verified the same identity was **denied** an out-of-scope read of the parent resource group.
- Revoked the temporary client secret and verified the RBAC assignment, test identities and isolated login cache were removed.

**[Read Project 05 IAM & RBAC Security Assessment →](docs/project-05-iam-rbac.md)**

> This was an isolated personal cloud security exercise. All temporary test access has been cleaned up; the existing website and Owner permissions were not intentionally altered.

## CV-ready description

**Azure Static Website Deployment (Personal Project)** — Deployed a static website to Azure Static Web Apps and connected GitHub Actions for automatic deployment. Validated live changes after repository commits and troubleshot an Azure regional provisioning restriction.

---

*Project status: Successfully deployed and tested. This is a beginner personal lab, not a production-scale service or paid-work engagement.*
