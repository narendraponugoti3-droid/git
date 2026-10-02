# git
# Git Practical Use Cases & Command Reference

This repository contains practical Git commands, use cases, and examples learned through hands-on Git practice.

The purpose is to understand Git not only as a list of commands, but as a **real-world developer workflow**.

---

## 📚 Topics Covered

* Git configuration
* Git repository initialization
* Working Directory
* Staging Area
* Local Repository
* Remote Repository
* GitHub
* Branching
* Branch merging
* Branch deletion
* `.gitignore`
* Git Cherry-Pick
* Git Stash
* `stash apply` vs `stash pop`
* Remote branches
* Practical developer workflow
* Git interview questions

---

# 1. Git Configuration

Configure your Git username and email.

```bash
git config --global user.name "Your Name"

git config --global user.email "your-email@example.com"
```

Check the installed Git version:

```bash
git --version
```

---

# 2. Git Repository

Initialize a Git repository:

```bash
git init
```

Check the current Git status:

```bash
git status
```

Git tracks files through the following workflow:

```text
Working Directory
       |
       | git add
       v
Staging Area
       |
       | git commit
       v
Local Repository
       |
       | git push
       v
Remote Repository
```

---

# 3. First Git Commit

Add files to the staging area:

```bash
git add .
```

Create a commit:

```bash
git commit -m "Initial commit"
```

View commit history:

```bash
git log --oneline
```

---

# 4. Connect Local Repository to GitHub

Add a remote repository:

```bash
git remote add origin https://github.com/<username>/<repository>.git
```

Check configured remotes:

```bash
git remote -v
```

Push the `main` branch:

```bash
git push -u origin main
```

### What is `origin`?

`origin` is a conventional alias/name given to a remote repository.

Example:

```text
Local Repository
       |
       | origin
       v
GitHub Remote Repository
```

A local repository can also have more than one remote repository.

---

# 5. Git Branches

List branches:

```bash
git branch
```

Create a new branch:

```bash
git branch mutual
```

Switch to the branch:

```bash
git switch mutual
```

Modern alternative for creating and switching:

```bash
git switch -c mutual
```

---

# 6. Merge Branch

### Use Case

Suppose the `mutual` branch contains a completed feature.

Switch to `main`:

```bash
git switch main
```

Merge the feature:

```bash
git merge mutual
```

Delete the branch after merging:

```bash
git branch -d mutual
```

Workflow:

```text
             +---- mutual ----+
             |                |
main --------+                +---- merge ---> main
```

---

# 7. Force Delete a Branch

Sometimes a branch contains changes that have not been merged.

Example:

```bash
git switch -c upi
```

Create or modify files.

Switch back to main:

```bash
git switch main
```

Force-delete the branch:

```bash
git branch -D upi
```

> ⚠️ Use `-D` carefully because it force-deletes the branch even if the changes have not been merged.

---

# 8. Push a New Branch to GitHub

Create and switch to a branch:

```bash
git switch -c stocks
```

Create or modify files.

Stage the changes:

```bash
git add .
```

Commit:

```bash
git commit -m "Add stocks feature"
```

Push the branch:

```bash
git push -u origin stocks
```

The branch will now be available in the remote repository.

---

# 9. `.gitignore`

`.gitignore` is used to tell Git which files or folders should normally not be tracked.

Example:

```text
target/
*.log
.idea/
*.iml
.classpath
.project
local.properties
```

For a Java/Spring Boot project, generated files such as `target/` generally should not be committed.

Example:

```bash
git status
git add .
git commit -m "Add project files"
```

Git will normally ignore files matching the patterns in `.gitignore`.

---

# 10. Git Cherry-Pick

## What is Cherry-Pick?

`git cherry-pick` is used when you want to apply the changes from a **specific commit** to another branch.

### Example

Suppose we have:

```text
payments branch

C1 → C2 → C3 → C4
```

But the `main` branch needs only `C3`.

Instead of merging the complete `payments` branch, cherry-pick the required commit.

Switch to main:

```bash
git switch main
```

Cherry-pick the commit:

```bash
git cherry-pick <commit-id>
```

Check the history:

```bash
git log --oneline
```

---

# 11. Cherry-Pick Practical Use Case

### Scenario

You are working on a Payments feature.

The branch contains:

```text
C1 → C2 → C3 → C4
```

`C3` contains an important bug fix.

Another branch called `mobiles` also requires the same fix.

Switch to the mobile branch:

```bash
git switch mobiles
```

Cherry-pick the required commit:

```bash
git cherry-pick <C3-commit-id>
```

Now the changes from that commit are applied to the `mobiles` branch.

### Why use Cherry-Pick?

It is useful when:

* You need only one specific fix.
* You don't want to merge the entire feature branch.
* The same bug fix is required in multiple branches.
* You need to backport a fix to another release branch.

---

# 12. Git Stash

## What is Git Stash?

`git stash` is a temporary storage mechanism for work that is not ready to be committed.

### Real-World Scenario

You are working on a Payments feature:

```text
Payments Feature
    |
    +-- File 1
    +-- File 2
    +-- File 3
    +-- File 4
```

Suddenly, a production incident occurs.

Your current changes are incomplete, so you don't want to create a commit.

You can temporarily save your work using:

```bash
git stash push -m "Payments work temporarily saved"
```

Now you can work on the urgent issue.

---

# 13. Git Stash Production Support Use Case

### Step 1 – Work on Feature

```bash
git switch payments
```

Create or modify files:

```text
S1.txt
S2.txt
S3.txt
S4.txt
```

Stage the changes:

```bash
git add .
```

### Step 2 – Stash the Work

```bash
git stash push -m "Payments feature work"
```

Your working directory is now clean.

### Step 3 – Fix the Urgent Issue

Work on the production bug.

```bash
git add .
git commit -m "Fix production bug"
```

### Step 4 – Return to Feature Work

Check available stashes:

```bash
git stash list
```

Example:

```text
stash@{0}: On payments: Payments feature work
```

Restore the work:

```bash
git stash pop
```

Your unfinished feature work is back in the working directory.

---

# 14. Multiple Stashes

You can have multiple stash entries.

Example:

```bash
git add T1.java
git stash push -m "T1 changes"
```

Then:

```bash
git add T2.java
git stash push -m "T2 changes"
```

Then:

```bash
git add T3.java
git stash push -m "T3 changes"
```

View all stashes:

```bash
git stash list
```

Example:

```text
stash@{0}: On payments: T3 changes
stash@{1}: On payments: T2 changes
stash@{2}: On payments: T1 changes
```

The newest stash is normally `stash@{0}`.

---

# 15. View Stash Details

View a summary:

```bash
git stash show "stash@{1}"
```

View detailed changes:

```bash
git stash show -p "stash@{1}"
```

The `-p` option displays the actual patch/diff.

---

# 16. Git Stash Apply

Apply a stash:

```bash
git stash apply "stash@{0}"
```

This restores the changes but **keeps the stash entry**.

Example:

```text
Before:

stash@{0}
stash@{1}
stash@{2}

git stash apply stash@{0}

After:

stash@{0}   ← still exists
stash@{1}
stash@{2}
```

---

# 17. Git Stash Pop

Pop a stash:

```bash
git stash pop "stash@{0}"
```

This restores the changes and normally removes the stash entry if the application succeeds.

### Easy way to remember

```text
APPLY
  ↓
Restore changes
  ↓
Keep stash
```

```text
POP
  ↓
Restore changes
  ↓
Remove stash
```

---

# 18. Delete One Stash

Delete a specific stash:

```bash
git stash drop "stash@{1}"
```

---

# 19. Delete All Stashes

Delete all stash entries:

```bash
git stash clear
```

> ⚠️ Use `git stash clear` carefully because it removes all stash entries.

---

# 20. Complete Real-World Developer Workflow

The following workflow represents a typical developer scenario.

### Step 1 – Start from Main

```bash
git switch main
```

### Step 2 – Create Feature Branch

```bash
git switch -c payments
```

### Step 3 – Develop Feature

Modify application files.

```bash
git status
git add .
git commit -m "Add payment functionality"
```

### Step 4 – Push Feature Branch

```bash
git push -u origin payments
```

### Step 5 – Production Issue Arrives

You have unfinished work.

```bash
git stash push -m "Payments unfinished work"
```

### Step 6 – Fix Production Issue

Make the required changes.

```bash
git add .
git commit -m "Fix production issue"
```

### Step 7 – Return to Feature

```bash
git switch payments
```

### Step 8 – Restore Work

```bash
git stash pop
```

### Step 9 – Continue Development

```bash
git add .
git commit -m "Complete payment functionality"
```

### Step 10 – Merge

```bash
git switch main
git merge payments
```

### Step 11 – Delete Local Branch

```bash
git branch -d payments
```

---

# 21. Git Command Cheat Sheet

| Command                         | Purpose            |
| ------------------------------- | ------------------ |
| `git --version`                 | Check Git version  |
| `git config --global user.name` | Configure username |
| `git con                        |                    |
