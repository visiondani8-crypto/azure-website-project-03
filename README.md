# Azure Cloud Engineering Portfolio - Projects 1 to 4

**Four completed personal cloud engineering labs · Microsoft Azure · GitHub Actions · Azure CLI · Microsoft Entra ID**

The Azure virtual machine lab originally numbered Project 2 was **skipped because of Azure VM quota restrictions**. The four completed projects are now numbered consecutively.

## Completed projects

| Project | Practical skills | Documentation |
| --- | --- | --- |
| **Project 1 - Azure Secure Blob Storage, Access Control & Data Recovery** | Private Azure Blob Storage, firewall troubleshooting, RBAC and soft-delete recovery | [Project 1 repository](https://github.com/visiondani8-crypto/azure-secure-blob-storage-lab) |
| **Project 2 - Azure Static Website Deployment & CI/CD** | Azure Static Web Apps, GitHub Actions CI/CD, deployment troubleshooting | [Project 2 case study](docs/project-02-deployment.md) |
| **Project 3 - Azure Website Monitoring & Incident Response** | Azure Activity Logs, automated monitoring, simulated incident response, GitHub notifications, scheduled health checks | [Project 3 case study](docs/project-03-monitoring.md) · [five screenshots](evidence/project-03/) |
| **Project 4 - Azure IAM & RBAC Least-Privilege Security** | Azure CLI, Microsoft Entra service principals, scoped RBAC, allowed/denied ARM tests, credential and identity cleanup | [Project 4 assessment](docs/project-04-iam-rbac.md) |

## Architecture — Projects 2, 3 and 4

```text
GitHub repository --> GitHub Actions CI/CD --> Azure Static Web Apps
                                                    |
                                                    v
                                              Public HTTPS site
                                                    ^
                                                    |
                            GitHub Actions website health monitoring
                                |                |
                              Pass        Simulated check failure
                                                 |
                                                 v
                                          GitHub notification

Project 4 lab: temporary Entra service principal
    + Monitoring Reader at individual website scope
    + Resource GET allowed
    + Parent resource-group GET denied
    + Role, app, secret and authentication cache removed
```

## Verified Project 3 monitoring

- A manual `curl` check returned HTTP 200 in 0.295582 seconds (one request).
- [Health Check #2](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41207889532) correctly detected a simulated homepage content mismatch.
- GitHub Inbox notifications were verified; email alert delivery was not tested.
- [Health Check #5](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41209550079) succeeded after normal monitoring was restored.
- **Scheduled** runs [#6](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41243815468), [#7](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41278837027), and [#8](https://github.com/visiondani8-crypto/azure-website-project-03/actions/runs/41310403454) succeeded (31 October–1 November 2026).

### Simulated failure detected

![Project 3 simulated health-check failure](evidence/project-03/03_simulated_failure.png)

### Normal monitoring restored

![Project 3 successful normal health-check workflow](evidence/project-03/05_final_monitoring_success.png)

[View all five Project 3 screenshots](docs/project-03-monitoring.md#screenshots-and-evidence) · [Read simulated incident report](docs/incident-report.md)

## Historical technical identifiers

The GitHub repository, Azure resource and resource group retain names such as `azure-website-project-03`. These were created before renumbering and are **technical identifiers, not the current project number**. The website-deployment project is now **Project 2**. Keeping infrastructure identifiers unchanged avoids disrupting the existing Azure–GitHub deployment connection.

Older documentation and evidence URLs are retained where possible for compatibility, while the updated case studies use the new numbering.

## Limitations and security

These are personal hands-on labs, not paid-work engagements or production-scale services. Individual HTTP checks do not prove continuous uptime. The simulated monitoring failure did not take the website offline. Temporary Project 4 security credentials and assignments were revoked and removed.

Do not publish Azure keys, tokens, secret values or account identifiers in screenshots or documentation.

---

**Projects:** [Project 1 - Azure Secure Blob Storage, Access Control & Data Recovery](https://github.com/visiondani8-crypto/azure-secure-blob-storage-lab) · [Project 2 - Azure Static Website Deployment & CI/CD](docs/project-02-deployment.md) · [Project 3 - Azure Website Monitoring & Incident Response](docs/project-03-monitoring.md) · [Project 4 - Azure IAM & RBAC Least-Privilege Security](docs/project-04-iam-rbac.md)
