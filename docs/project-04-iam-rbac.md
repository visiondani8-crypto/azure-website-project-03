# Project 4 - Azure IAM & RBAC Least-Privilege Security

**Level:** Intermediate · **Date:** 31 October 2026 · **Type:** Personal cloud security lab · **Status:** Completed and cleaned up

> This lab used an existing Azure Static Web App from [Project 2 - Azure Static Website Deployment & CI/CD](project-02-deployment.md). No separate production tenant or live service was needed. The role-assignment and identity configuration were temporary and have been removed.

## Executive summary

I audited Azure role-based access control (RBAC), identified inherited Owner permissions, and built a resource-scoped least-privilege test using a dedicated Microsoft Entra service principal. I verified that the test principal **could read the intended Static Web App** but **could not read the parent resource group**. I then revoked the temporary client secret, removed the RBAC assignment, deleted the app and service principal, and removed the isolated Azure CLI authentication cache.

**Key outcome:** An authenticated service principal with the built-in **Monitoring Reader** role granted at **one Azure Static Web App** successfully read that resource and was denied an out-of-scope parent-resource-group read. This verifies the configured resource boundary in a controlled lab. It does *not* constitute a broad penetration test or a complete review of all subscription identities.

## Architecture and scope

```text
Azure subscription (pre-existing Owner access)
  |
  +-- Resource group: azure-website-project-03_group
        |
        +-- Static Web App: azure-website-project-03
                ^
                |
        Monitoring Reader (temporary Azure RBAC assignment)
                |
        Microsoft Entra service principal (temporary lab identity)
                |
        Isolated Azure CLI login for access tests
```

**Scope of test:** `Microsoft.Web/staticSites` resource `azure-website-project-03`, in `azure-website-project-03_group`. An application registration and service principal were created specifically for this lab. A short-lived client secret was used only for isolated authentication testing.

## Audit results

| Control | Observed result | Interpretation |
| --- | --- | --- |
| Azure subscription access | `Enabled` | Subscription active; this alone does not imply permissions |
| Resource-group RBAC audit | Two `Owner` entries, principal type `User` | Broad inherited management access exists |
| Identity/scope comparison | One distinct principal ID; both entries at subscription scope | Same identified principal, with two returned entries; exact reason for duplication not established |
| Built-in role inspection | `Monitoring Reader` actions included `*/read`, `Microsoft.OperationalInsights/workspaces/search/action`, `Microsoft.Support/*`; `dataActions=[]` | Role is broad for reads and includes support actions; not strictly read-only |
| Individual target lookup | Static Web App resolved via Azure CLI | Narrow RBAC scope identified |
| Separate principal | Microsoft Entra app registration + service principal created | Independent from Owner-user authentication |
| Role assignment | `Monitoring Reader` at the individual Static Web App | Scope-limited assignment confirmed via CLI |
| Positive authorisation test | Service-principal login succeeded; website ARM GET **ALLOWED** | Principal could read assigned resource |
| Negative authorisation test | Parent resource-group ARM GET **DENIED** | Scope boundary held for tested operation |
| Client credential cleanup | Secret revoked; removal verified | Credential no longer listed |
| RBAC cleanup | Temporary role assignment removed; removal verified | Temporary RBAC grant removed |
| Identity cleanup | Service principal deleted, app registration deleted; verification passed | Temporary identities removed from active lookup |
| CLI cache cleanup | Isolated temporary authentication directory removed; verified | Cached test login deleted |

**Evidence basis:** Interactive Azure Cloud Shell command output and screenshots collected during the lab. No credentials, object IDs, subscription IDs, user email addresses or tokens are reproduced in this public report.

## Test design: allow vs deny

The two tested requests were read-only Azure Resource Manager (ARM) GET operations performed under a **separate CLI configuration and service-principal sign-in** rather than the owner's usual CLI context.

| Operation | Intended policy | Observation | Result |
| --- | --- | --- | --- |
| ARM GET on `Microsoft.Web/staticSites/azure-website-project-03` | Allow | Resource name returned and command completed successfully | **PASS** |
| ARM GET on parent `azure-website-project-03_group` | Deny | CLI test detected an authorisation-related failure | **PASS** |

The negative-test script classified a 403/Forbidden/AuthorizationFailed-type error as denial, then deleted its temporary error file. Consequently, **the exact ARM error code and message were not retained** and should not be inferred from this report. A production-quality validation suite would capture a safely redacted error code, HTTP status, correlation ID, and timestamp.

### Why these controls matter

- **Separation of identities:** Tests run as a service principal rather than the user's broadly privileged account.
- **Least privilege:** A role is granted at the specific resource rather than at the subscription or resource-group level.
- **Negative testing:** A denied operation demonstrates the scope boundary, not merely that a role assignment exists.
- **Credential hygiene:** The test secret is short-lived and revoked after use.
- **Cleanup and auditability:** Temporary identities and assignments are removed; the expected cleanup results are recorded.

## Security findings and recommendations

| ID | Finding | Assessment | Recommendation |
| --- | --- | --- | --- |
| IAM-01 | Subscription-scope Owner access is inherited by the website resource group | **Review** — broad standing privilege; legitimate for a personal lab, higher risk in an organisation | Use narrowly scoped operational roles, Privileged Identity Management where applicable, MFA/conditional access, and periodic access reviews |
| IAM-02 | Two Owner assignment entries were returned for one principal at subscription scope | **Needs investigation** — not evidence of two users; assignment-level explanation unverified | In an enterprise audit, compare assignment IDs, provenance, and eligible/active role state before calling the entries redundant |
| IAM-03 | Built-in Monitoring Reader includes `Microsoft.Support/*` as well as reads | **Role-design caveat** — broader than its name suggests | Inspect `Actions`, `NotActions`, `DataActions`, `NotDataActions`, and scope before assigning; consider a custom role for stringent requirements |
| IAM-04 | Temporary service principal used a client secret for lab authentication | **Controlled** — credential revoked after testing | Prefer managed identity or workload identity federation in production; avoid long-lived client secrets |
| IAM-05 | Positive and negative access checks gave expected outcomes | **Passed for the two tested actions** | Expand testing to additional resources and write operations in an isolated, disposable environment |
| IAM-06 | Test principal, assignment and login cache removed | **Verified by CLI** | Keep this cleanup procedure in future experiments |

**Note:** This was not a real-world incident, compromise, or confirmed subscription misconfiguration. Findings are instructional observations and recommendations; they should not be portrayed as a third-party security audit.

## Representative read-only commands

These are illustrative commands, with no secrets or account-specific IDs embedded. They are not a standalone provisioning script.

```bash
# Check active subscription (without disclosing identifiers)
az account show --query "{Subscription:name,Status:state}" -o table

# Inspect all relevant role assignments, including inherited grants
az role assignment list \
  --resource-group azure-website-project-03_group \
  --include-inherited \
  --query "[].{Role:roleDefinitionName,Type:principalType}" -o table

# Inspect built-in role permissions
az role definition list --name "Monitoring Reader" \
  --query "[].{Role:roleName,Permissions:permissions}" -o json

# Locate the resource to scope a role assignment
az resource show \
  --resource-group azure-website-project-03_group \
  --name azure-website-project-03 \
  --resource-type Microsoft.Web/staticSites \
  --query id -o tsv
```

The live exercise also used `az ad app create`, `az ad sp create`, `az role assignment create`, isolated `az login --service-principal`, two `az rest --method get` requests, and the corresponding credential/RBAC/identity deletion commands.

## Evidence and confidentiality

The working Cloud Shell screenshots demonstrate:
1. Active subscription and inherited Owner-role audit.
2. One principal ID behind two subscription-scope Owner entries.
3. Monitoring Reader role-definition inspection.
4. Resource-level Monitoring Reader assignment and verification.
5. Service-principal login and **ALLOWED** resource read.
6. **DENIED** parent-resource-group read.
7. Credential revocation, role/identity deletion, and auth cache cleanup.

**Images have not been uploaded to this directory.** If publishing screenshots in a future `evidence/project-04/` directory, first crop/redact portal account email, subscription IDs, tenant IDs, resource IDs, client secrets, tokens, and any other private values. Never publish credential output or reusable tokens.

## Skills demonstrated

Azure CLI · Microsoft Entra ID · service principals · Azure RBAC · permission inheritance · least-privilege design · ARM REST API · isolated authentication context · positive and negative access testing · temporary-credential revocation · security documentation.

## CV-ready description

**Azure IAM & RBAC Least-Privilege Security Lab (Personal Project)** — Audited inherited Azure Owner access and reviewed built-in role permissions. Created a Microsoft Entra service principal with Monitoring Reader access scoped to a single Azure Static Web App, independently tested allowed resource reads and denied parent-resource-group access using Azure CLI/ARM, then verified revocation and complete cleanup of temporary credentials, assignments, identities, and authentication files.

---

*Completion status: All described CLI validation and cleanup checkpoints were observed during the interactive personal lab on 31 October 2026. Not a production security engagement or comprehensive audit.*
