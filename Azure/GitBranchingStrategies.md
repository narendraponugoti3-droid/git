# Git Branching Strategies -- GitFlow

## 1. Overview

GitFlow is a branching model that separates day-to-day development,
release preparation, production code, and urgent production fixes. It is
useful when a team needs controlled releases, testing stages, approvals,
and a clear production history.

The diagram below adapts the supplied drawing into a README-friendly
Mermaid diagram. It shows the main long-lived branches and the usual
flow between them.

## 2. GitFlow diagram

> **Viewing tip:** GitHub and Azure DevOps Markdown viewers may render
> Mermaid diagrams. If your viewer does not render it, copy the Mermaid
> block into a Mermaid-compatible editor.

``` mermaid
flowchart LR
    F[Feature branch] -->|PR| D[Develop branch]
    D -->|CI/CD pipeline| DEV((Dev))
    DEV -->|Promote after tests| STG((Staging))

    D -->|Create release branch| R[Release branch]
    R -->|PR / approvals / gates| PRE((Pre-production))
    PRE -->|Release approval| PROD((Production))

    R -->|PR / merge| M[Main branch]
    M -->|Tagged release / deploy| GOLD((Production code<br/>versioned and tagged))

    H[Hotfix branch<br/>created from main] -->|PR / merge| M
    H -->|Back-merge fix| D
    H -.->|If a release is in progress| R

    classDef branch fill:#eaf2ff,stroke:#316ac5,color:#17365d,stroke-width:1.5px;
    classDef env fill:#e8f6ed,stroke:#27864b,color:#124b29,stroke-width:1.5px;
    class F,D,R,M,H branch;
    class DEV,STG,PRE,PROD,GOLD env;
```

## 3. What each branch is for

### `main` -- production-ready code

-   Represents the code approved for production.
-   Production releases are commonly tagged with a version, such as
    `v2.4.0`.
-   Restrict direct pushes; use Pull Requests and branch policies.
-   A hotfix is normally created from `main` when production needs an
    urgent correction.

### `develop` -- integration branch

-   Collects completed feature work for the next release.
-   Feature branches are normally created from `develop`.
-   Changes are merged back through Pull Requests.
-   Automated builds and tests can deploy this branch to a development
    environment.

### `feature/*` -- new functionality

-   Used for one feature or work item at a time.
-   Example: `feature/payment-validation`.
-   Developers commit and test their changes independently.
-   When ready, open a PR into `develop`; delete the feature branch
    after merging if it is no longer needed.

### `release/*` -- release preparation

-   Created from \`develop when the planned features are ready for
    release.
-   Used for final testing, bug fixes, version updates, and release
    preparation.
-   Deploy to pre-production/staging environments and complete required
    approvals.
-   Merge the release into `main` when approved, tag the release, and
    merge any release-only fixes back into `develop`.

### `hotfix/*` -- urgent production correction

-   Created from `main` so the fix starts from the currently released
    code.
-   Example: `hotfix/payment-timeout`.
-   Test the correction and merge it into `main` through the agreed PR
    process.
-   Also merge or back-merge the fix into `develop` (and an active
    release branch when appropriate), so the correction is not lost in
    future releases.

## 4. Typical release flow

1.  Create `feature/<name>` from `develop`.
2.  Implement and test the feature.
3.  Open a Pull Request from the feature branch into `develop`.
4.  Run CI checks and deploy `develop` to the development environment.
5.  When scope is ready, create `release/<version>` from `develop`.
6.  Deploy the release branch to pre-production; run regression tests
    and required approval gates.
7.  Merge the approved release into `main` and create a version tag.
8.  Deploy the tagged version to production.
9.  Merge release fixes back into `develop`.
10. For an urgent production issue, create a `hotfix/<name>` branch from
    `main`, test it, merge it into `main`, deploy, and back-merge it
    into `develop`.

## 5. Pull Requests, merge strategies, and approvals

A Pull Request (PR) asks reviewers to check changes before they are
merged. In Azure DevOps, branch policies can require reviewers, linked
work items, successful builds, and resolved comments.

Common merge strategies:

  -----------------------------------------------------------------------
  Strategy                Result                  Typical reason to use
                                                  it
  ----------------------- ----------------------- -----------------------
  Merge (no fast-forward) Preserves source        Clear integration
                          commits and creates a   history and
                          merge commit            traceability

  Squash                  Combines source changes A tidy target-branch
                          into one target-branch  history
                          commit                  

  Rebase and fast-forward Replays commits on the  Linear history
                          target and advances     
                          without a merge commit  

  Semi-linear merge       Requires the source to  Linearized source
                          be rebased, then        commits plus an
                          creates a merge commit  integration marker
  -----------------------------------------------------------------------

The exact options available depend on Azure DevOps repository settings
and branch policies. Agree on a team standard rather than choosing a
different strategy for every PR.

## 6. Branch policies for `main`

In Azure DevOps:

1.  Open **Repos → Branches**.
2.  Find `main` and open **Branch policies**.
3.  Configure minimum reviewers and any required build validation.
4.  Consider requiring linked work items and resolved PR comments.
5.  Restrict allowed merge types to the team's chosen strategy.
6.  Avoid direct pushes to `main` unless there is an explicitly approved
    exception.

**Locking a branch is different from applying branch policies.** A lock
temporarily prevents changes; policies are the usual way to enforce
review and validation requirements.

## 7. Important notes

-   GitFlow is a workflow, not a Git command or a CI/CD tool.
-   Environment names such as Dev, Staging, Pre-production, and
    Production are deployment environments; they are not Git branches.
-   Teams do not have to use a separate long-lived branch for every
    environment. Deployment pipelines can promote a tested commit or
    artifact between environments.
-   The classic GitFlow model has long-lived `main` and `develop`
    branches, short-lived feature/release/hotfix branches, and PRs or
    merges between them.
-   For teams deploying small changes continuously, a simpler
    trunk-based workflow may be more appropriate. GitFlow is especially
    useful when releases require coordination and formal gates.

## 8. Quick summary

  ------------------------------------------------------------------------
  Branch            Main purpose       Usually created   Usually merged
                                       from              into
  ----------------- ------------------ ----------------- -----------------
  `main`            Production-ready   ---               ---
                    versions                             

  `develop`         Integrate upcoming `main` initially  Receives feature
                    work                                 and back-merged
                                                         fixes

  `feature/*`       Build a feature    `develop`         `develop`

  `release/*`       Stabilize a        `develop`         `main` and back
                    release                              into `develop`

  `hotfix/*`        Urgent production  `main`            `main` and
                    fix                                  `develop` (plus
                                                         active release if
                                                         needed)
  ------------------------------------------------------------------------
