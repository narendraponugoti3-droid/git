# Azure Devops Pipelines 

CICD --> COntinues Integration and Continues Development /Deployment 

<img width="496" height="332" alt="image" src="https://github.com/user-attachments/assets/c0f7a848-ac52-4197-a56a-e03f828a4f89" />


# .NET Application Build and Azure DevOps Pipeline

## 1. What Is a Build?

A **build** is the process of preparing source code so that an application can run or be deployed.

The main steps involved in a build are:

1. **Compile the source code** – Convert source code into executable intermediate code.
2. **Resolve dependencies** – Download and configure the required libraries and packages.
3. **Package the application** – Collect the application files and dependencies required for deployment.
4. **Generate executable output** – Produce the compiled application output that can be run or deployed.

---

## 2. Step 1: Create an Azure Repository

1. Log in to Azure DevOps.
2. Create a new project or open an existing project.
3. Create a repository named `GrowDotnetProj`.
4. Add a `.gitignore` file and select the **VisualStudio** template.

The `.gitignore` file prevents unnecessary files, such as build outputs and IDE-specific files, from being committed to Git.

---

## 3. Step 2: Clone the Repository

Clone the Azure Repos Git repository to your local machine.

```bash
git clone https://narendraponugoti3@dev.azure.com/narendraponugoti3/grow/_git/GrowDotnetProj
```

Navigate to the cloned repository:

```bash
cd GrowDotnetProj
```

### Create a .NET Project

Create a simple **ASP.NET Core Web App (Razor Pages)** project with the project name `GrowLandingPage`.

You can create it using Visual Studio or the .NET CLI.

To create it using the command line:

```bash
dotnet new webapp -n GrowLandingPage
cd GrowLandingPage
```

### Verify the .NET SDK Version

```bash
dotnet --version
```

This command displays the installed .NET SDK version.

### Restore Dependencies

```bash
dotnet restore
```

Downloads the NuGet packages required by the project.

### Build the Application

```bash
dotnet build
```

Compiles the source code and checks for build errors.

### Run the Application

```bash
dotnet run
```

Starts the application locally. Open the local URL displayed in the terminal, usually something like `http://localhost:5000` or another configured port.

---

## 4. Step 3: Modify the Application and Push Code

### Modify the Web Page

1. Open the `GrowLandingPage` project.
2. Modify the page according to your requirements.
3. In a Razor Pages application, the main page is usually located at:

   ```text
   Pages/Index.cshtml
   ```

4. Update the HTML and CSS as needed.
5. Save the changes and run the application locally to verify them.

**Note:** In an ASP.NET Core Razor Pages project, `Pages/Index.cshtml` is generally the main page, rather than `index.html`.

### Check Git Status

```bash
git status
```

Displays modified, new, and untracked files.

### Stage the Changes

```bash
git add .
```

Stages all changes in the current repository directory.

### Commit the Changes

```bash
git commit -m "Add .NET landing page"
```

Creates a commit containing the staged changes.

### Push the Changes to Azure Repos

```bash
git push
```

Uploads the committed changes to the remote Azure Repos repository.

---

## 5. Step 4: Create an Azure Pipeline

Use Azure Pipelines to automatically build your .NET application.

### Create the Pipeline

1. Open your project in Azure DevOps.
2. Navigate to **Pipelines**.
3. Select **Create Pipeline**.
4. Choose **Azure Repos Git**.
5. Select the `GrowDotnetProj` repository.
6. Choose **ASP.NET Core** or the appropriate .NET pipeline template.
7. Review the generated YAML pipeline code.

### Configure the YAML Pipeline

Review the generated YAML file and ensure it includes these steps:

1. Install or select the required .NET SDK.
2. Restore NuGet dependencies.
3. Build the application.
4. Publish the application output.
5. Publish the build artifact.

Remove the test task only if testing is not required for your current learning exercise. In a production pipeline, keeping automated tests is recommended.

### Example Azure Pipeline YAML

Save the following file as `azure-pipelines.yml` in the root of your repository.

```yaml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

steps:
  - task: UseDotNet@2
    displayName: 'Install .NET SDK'
    inputs:
      packageType: 'sdk'
      version: '8.x'

  - script: dotnet restore GrowLandingPage/GrowLandingPage.csproj
    displayName: 'Restore Dependencies'

  - script: dotnet build GrowLandingPage/GrowLandingPage.csproj --configuration Release --no-restore
    displayName: 'Build Application'

  - script: dotnet publish GrowLandingPage/GrowLandingPage.csproj --configuration Release --output $(Build.ArtifactStagingDirectory) --no-build
    displayName: 'Publish Application'

  - task: PublishBuildArtifacts@1
    displayName: 'Publish Build Artifact'
    inputs:
      PathtoPublish: '$(Build.ArtifactStagingDirectory)'
      ArtifactName: 'drop'
      publishLocation: 'Container'
```

**Important:** This example assumes that your project targets .NET 8 and your default branch is named `main`. Adjust the SDK version and branch name to match your project. If your project targets a different .NET version, use the appropriate SDK.

### Save and Run the Pipeline

1. Save the `azure-pipelines.yml` file.
2. Commit and push it to Azure Repos.
3. Open **Pipelines** in Azure DevOps.
4. Run the pipeline.
5. Monitor the execution logs.
6. Confirm that the restore, build, publish, and artifact steps succeed.
7. Open the completed pipeline run and check the **Artifacts** section for the `drop` artifact.

---

## 6. Build Process Summary

```text
Developer
    |
    v
Write / Modify Source Code
    |
    v
Push Code to Azure Repos
    |
    v
Azure Pipeline Triggered
    |
    v
Restore Dependencies
    |
    v
Build Application
    |
    v
Publish Application
    |
    v
Publish Build Artifact
    |
    v
Artifact Ready for Deployment
```

---

## 7. Important .NET Commands

| Command | Purpose |
|---|---|
| `dotnet --version` | Displays the installed .NET SDK version |
| `dotnet restore` | Restores NuGet dependencies |
| `dotnet build` | Compiles the application |
| `dotnet run` | Runs the application locally |
| `dotnet publish` | Prepares application output for deployment |
| `git status` | Displays the current Git working-tree status |
| `git add .` | Stages changes |
| `git commit -m "message"` | Commits staged changes |
| `git push` | Pushes commits to the remote repository |

## 8. Key Takeaway

- **Git** stores and tracks your source code.
- **Azure Repos** hosts your Git repository.
- **.NET CLI** helps you create, build, and run the application.
- **Azure Pipelines** automates the build process.
- **Build artifacts** contain the published application output, ready for a deployment stage.

**Build and deployment are different:** building prepares the application, while deployment releases it to an environment such as a development, testing, or production server.

<img width="916" height="591" alt="image" src="https://github.com/user-attachments/assets/8dad1877-7dc6-4934-bb3d-cd14105265fe" />
