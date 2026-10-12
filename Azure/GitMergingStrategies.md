# Git Merging Strategies – Azure DevOps

## 1. Project Overview

This project demonstrates Git branching, merging strategies, Pull Requests (PRs), and branch policies using Azure DevOps.

The objective is to understand how developers create feature branches, submit code for review, and merge changes into the main branch.

## 2. Local and Remote Repository

A Git repository can contain multiple branches.

* **Main branch:** Contains the primary, stable code.
* **Feature branch:** Contains changes developed for a new feature.
* **Remote repository:** A shared repository hosted in Azure DevOps.
* **Pull Request (PR):** A request to review and merge changes from one branch into another.

Example:

```text
                 Local Repository
                       |
              -------------------
              |                 |
           main branch      payments branch
              |                 |
              |            New feature code
              |                 |
              ----------- PR ---
                       |
                Azure DevOps
                       |
               Review and approve
                       |
                  Merge into main
```

**Important:** A Pull Request is not a Git command. It is a collaboration and code-review process provided by platforms such as Azure DevOps.

## 3. Create a Repository in Azure DevOps

### Steps

1. Log in to Azure DevOps.
2. Open your project.
3. Navigate to **Repos**.
4. Create a new repository.
5. Add `file1.txt` and `file2.txt` to the main branch.
6. Create a new branch named `payments`.
7. Add two new files to the `payments` branch.
8. Push the changes to Azure DevOps.
9. Create a Pull Request from `payments` into `main`.

Example Git commands:

```bash
git clone <repository-url>
cd <repository-folder>

git switch -c payments

echo "Payment service" > payment.txt
echo "Payment configuration" > payment-config.txt

git add .
git commit -m "Add payment files"
git push -u origin payments
```

Create the Pull Request in Azure DevOps.

## 4. Four Pull Request Merge Strategies

Azure DevOps supports different ways to merge Pull Requests. Each strategy affects commit history differently.

### Strategy 1: Merge (No Fast-Forward)

**Purpose:** Preserve the source branch's commits and create a separate merge commit.

Characteristics:

* Non-linear commit history.
* Preserves individual feature commits.
* Creates a merge commit with two parents.
* Helps identify when a feature branch was integrated.
* Useful for enterprise teams that need detailed traceability.

Example:

```text
main:     A --- B ----------- M
               \             /
feature:        C --- D -----
```

`M` is the merge commit.

**How to use it:**

1. Open **Repos → Pull Requests**.
2. Select **New Pull Request**.
3. Set the source branch to `payments`.
4. Set the target branch to `main`.
5. Add a title and description.
6. Create the Pull Request.
7. Review and approve the changes as required.
8. Select **Complete**.
9. Choose **Merge (no fast-forward)**.
10. Complete the merge.

### Strategy 2: Squash Commit

**Purpose:** Combine all changes from the source branch into one commit on the target branch.

Characteristics:

* Produces a clean, linear history on `main`.
* Combines multiple feature commits into one.
* Does not preserve the individual source commits as separate commits on `main`.
* Useful when feature branches contain many small or temporary commits.

Example:

Before squash:

```text
main:     A --- B
               \
feature:        C --- D --- E
```

After squash:

```text
main:     A --- B --- S
```

`S` represents the single squashed commit.

**Example scenario:**

You create a `hotfix` branch and make several commits while fixing a production issue. When the fix is ready, you can squash the changes into one meaningful commit on `main`.

**How to practise:**

1. Create a branch named `hotfix`.
2. Create three files.
3. Commit the files separately.
4. Push the branch.
5. Create a Pull Request from `hotfix` into `main`.
6. Select **Squash commit** when completing the PR.
7. Optionally delete the source branch after merging.

Deleting the source branch is recommended when it is no longer needed, but it is not required for squash merging.

### Strategy 3: Rebase and Fast-Forward

**Purpose:** Replay source-branch commits on top of the target branch and move the target branch forward without a merge commit.

Characteristics:

* Linear history.
* No merge commit is created.
* Preserves the individual source commits.
* Useful for simple feature changes where a linear history is preferred.

Example:

Before rebase:

```text
main:     A --- B --- E --- F
               \
feature:        C --- D
```

After rebase and fast-forward:

```text
main:     A --- B --- E --- F --- C' --- D'
```

`C'` and `D'` are rebased versions of the original commits.

**How to practise:**

1. Create a branch named `cart`.
2. Add three files and commit the changes on `cart`.
3. Add two files and commit changes on `main`.
4. Create a Pull Request from `cart` into `main`.
5. Select **Rebase and fast-forward**, if enabled by your repository settings.
6. Complete the Pull Request.

### Strategy 4: Semi-Linear Merge

**Purpose:** Rebase the source branch onto the latest target branch and then create a merge commit.

Characteristics:

* Keeps a visible merge commit.
* Preserves the source branch's individual commits.
* Requires the source branch to be rebased onto the target branch.
* Combines a linear source history with explicit integration history.

Example:

Before:

```text
main:     A --- B --- E
               \
feature:        C --- D
```

After rebase and merge:

```text
main:     A --- B --- E --- C' --- D' --- M
```

`M` is the merge commit, and `C'` and `D'` are the rebased commits.

**How to practise:**

1. Create a branch named `products`.
2. Add two files and commit them on `products`.
3. Add two files and commit them on `main`.
4. Push both branches.
5. Create a Pull Request from `products` into `main`.
6. Select **Semi-linear merge**, if enabled.
7. Complete the Pull Request.

## 5. Merge Strategy Comparison

| Strategy                | History    | Merge commit | Individual source commits on target | Best use                                         |
| ----------------------- | ---------- | ------------ | ----------------------------------- | ------------------------------------------------ |
| Merge (no fast-forward) | Non-linear | Yes          | Yes                                 | Enterprise traceability                          |
| Squash commit           | Linear     | No           | No; combined into one commit        | Clean feature history                            |
| Rebase and fast-forward | Linear     | No           | Yes, rewritten as needed            | Simple changes                                   |
| Semi-linear merge       | Non-linear | Yes          | Yes, rebased first                  | Linearized commits plus integration traceability |

**Note:** A Pull Request's visual representation can differ between tools. A visible PR or merge bubble depends on the platform's graph display, not just the strategy name.

## 6. Branch Policies in Azure DevOps

Branch policies help protect important branches such as `main`.

### Steps to configure branch policies

1. Open your Azure DevOps project.
2. Navigate to **Repos → Branches**.
3. Find the `main` branch.
4. Open the branch's **More options** menu.
5. Select **Branch policies**.
6. Configure the required policies.

Common policies include:

* **Minimum number of reviewers:** Require one or more reviewers.
* **Check for linked work items:** Ensure PRs are linked to work items.
* **Check for comment resolution:** Require review comments to be resolved.
* **Build validation:** Run a build or CI pipeline before allowing completion.
* **Limit merge types:** Allow only the merge strategies approved by your team.

### Locking the main branch

You can use the branch's **Lock** option to prevent changes while it is locked. However, locking is not a replacement for branch policies. Use policies to enforce Pull Request reviews and build validation during normal development.

## 7. Recommended Workflow

For a team project, use this workflow:

```text
Create feature branch
        |
Develop and commit changes
        |
Push branch to Azure DevOps
        |
Create Pull Request
        |
Review code and run validations
        |
Approve Pull Request
        |
Merge into main
        |
Delete source branch if no longer needed
```

## 8. Important Git Commands

```bash
# List local branches
git branch

# List remote branches
git branch -r

# Create and switch to a new branch
git switch -c payments

# Switch to main
git switch main

# Download remote changes and branch information
git fetch origin

# Push a new branch to the remote repository
git push -u origin payments

# View commit history
git log --oneline --graph --all

# View the working directory status
git status
```

## 9. Key Takeaways

* A branch isolates work from the main development line.
* A Pull Request enables review and controlled integration.
* Merge (no fast-forward) preserves individual commits and adds a merge commit.
* Squash merging combines the feature's changes into one commit.
* Rebase and fast-forward creates a linear history without a merge commit.
* Semi-linear merging rebases the source commits and then creates a merge commit.
* Branch policies protect `main` through reviews and automated checks.
* Always confirm the source and target branches before completing a Pull Request.
