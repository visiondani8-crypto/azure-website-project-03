# Project 04 — Azure Website Health Monitoring & Incident Response

**Project type:** Personal cloud engineering lab · **Date:** 31 October 2026 · **Result:** Manual health checks, automated monitoring, simulated failure detection, GitHub notification and normal monitoring verification completed.

> This project builds on [Project 03 (Azure Static Web Apps CI/CD)](../readme.md). It demonstrates monitoring and investigation skills; it is not evidence of 24/7 uptime or a real production outage.

## Objective

Monitor an existing Azure-hosted static website, investigate Azure Activity Log events, detect a controlled failure, validate GitHub notification delivery and document the findings.

**Target URL:** [Azure Cloud Portfolio](https://polite-smoke-0e690c510.5.azurestaticapps.net)

## Architecture

```text
GitHub Actions (manual dispatch or schedule)
                |
                v
curl -> Azure Static Web App (HTTPS)
                |
                v
HTTP status + homepage text validation
          /                \
  Normal check         Simulation mode
   200 + expected      200 + deliberately
   content             missing text string
      |                      |
   PASS                    FAIL
      |                      |
 Workflow success     Workflow error (exit 1)
                             |
                             v
                  GitHub Inbox notification

Azure Activity Log (management plane) -> policy denial analysis
```

## Verified observations

| Test / observation | Evidence | Outcome |
| --- | --- | --- |
| Azure Activity Log | Azure portal, resource `azure-website-project-03` | Successful Static Web App operation; two denied policy events |
| Regional restriction | Policy event JSON, 30 Oct 2026 22:18:25 UTC | `sys.blockwesteurope` enforced a `deny` policy for West Europe |
| Manual HTTP test | Mac Terminal `curl`, 31 Oct 2026 | HTTP 200, 0.295582 seconds (single request) |
| First automated check | [Run #1](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41207541890) | Success |
| Simulated content failure | [Run #2](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41207889532) | Expected failure: homepage content check |
| Normal check after simulation | [Run #3](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41208079533) | Success |
| Notification test | [Run #4](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41208814640), GitHub Inbox | Expected failure produced GitHub notification |
| Final normal health check | [Run #5](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41209550079) | Success, HTTP 200, 0.101846 seconds, expected content present |

**Monitoring checks:** HTTP 200, successful network request, and homepage containing `Azure Cloud Portfolio`.

**Failure simulation:** Manual `simulate_failure` input changes the expected text to a deliberately missing string. It does **not** modify or shut down the website. Run #4 verified HTTP 200 while the simulated content check failed.

## Implementation

- **Website:** Azure Static Web Apps Free.
- **Monitoring:** [`.github/workflows/website-health-check.yml`](../.github/workflows/website-health-check.yml).
- **GitHub Actions:** `workflow_dispatch` for manual checks; cron `17 */6 * * *` for scheduled checks (UTC). A scheduled execution has **not yet been confirmed**.
- **Runner:** GitHub-hosted Ubuntu; job timeout set to three minutes.
- **Network resilience:** curl with a five-second connection timeout, a 20-second maximum transfer duration, and two retries.
- **Access:** Workflow uses `contents: read` only; no Azure account keys are required to check a public website.
- **Alerts:** GitHub Inbox notifications observed following failed workflow runs. **Email alert delivery was not tested.**

## Investigation: Azure Policy deployment denial

An Azure Activity Log entry showed a policy event with:
- Operation: `Microsoft.Authorization/policies/deny/action`
- Category: `Policy`; severity `Error`; status `Failed`
- Region: `westeurope`
- Assignment: `sys.blockwesteurope`
- Policy display name: `Resources should not be created in West Europe`

**Root cause:** An Azure policy blocked a deployment in West Europe. Provisioning the Static Web App in a permitted region (Central US) later succeeded. The denial was a resource-management restriction, not a demonstrated website outage.

Avoid publishing complete Azure Activity Log JSON or token/claim payloads. Those may expose account identifiers, IP addresses or authentication metadata.

## Simulated incident report

[Read the controlled incident report](incident-report.md). It documents what the monitoring detected, why the test failed, and how normal monitoring was verified afterward.

## Screenshots and evidence

**[Download the Project 4 screenshot evidence pack](../project04_evidence.zip)** — the ZIP archive was uploaded to this repository and contains the selected cropped/annotated monitoring screenshots. The GitHub Actions run links above also provide independently verifiable proof.

The screenshots currently live inside the ZIP. To make them viewable directly in this case study, extract the archive, upload the individual PNGs to `evidence/project-04/`, and then add Markdown image links. Do not embed image links until the actual PNG paths exist.

Included evidence (avoid browser tabs and personal details when adding future screenshots):
1. Azure Activity Log showing successful and denied management events.
2. Terminal HTTP 200 and measured response time.
3. Failed simulated health check showing `Homepage content check failed`.
4. GitHub Inbox notification for the failed check.
5. Successful final health check #5.

## Limitations and next improvements

- A successful HTTP response at one moment is **not proof of high availability over time**.
- One page and one expected string provide only basic content validation, not full application monitoring.
- Scheduled checks may be delayed or disabled due to repository inactivity; confirm that a schedule actually executes.
- GitHub Inbox notification is not guaranteed instant incident paging.
- Monitoring currently does not persist response-time history, define an SLO, or perform checks from multiple locations.
- Next improvements: alert thresholds/repeated-failure logic, response-time logging and a dedicated monitoring endpoint.

## What I learned

- Interpret Azure Activity Logs and policy-denial events to identify deployment failures.
- Use `curl` to examine status codes and response times.
- Build a manually triggered and scheduled GitHub Actions health-check workflow.
- Test both passing and intentionally failing scenarios.
- Read workflow logs, distinguish false alarms from real outages and verify recovery.
- Document a technical investigation without exposing credentials.

## CV-ready description

**Azure Website Monitoring & Incident Response — Personal Project (Oct 2026):** Implemented GitHub Actions health checks for an Azure Static Web App, validating HTTP responses and expected page content. Tested simulated failure detection, verified GitHub notifications and successful recovery checks, and investigated an Azure Policy regional deployment restriction using Activity Logs.
