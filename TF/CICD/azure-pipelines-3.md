# Starter pipeline
# Start with a minimal pipeline that you can customize to build and deploy your code.
# Add steps that build, run tests, deploy, and more:
# https://aka.ms/yaml

trigger:
- develop

variables:
  solution: '**/*.slnx'
  buildPlatform: 'Any CPU'
  buildConfiguration: 'Release'

stages:
- stage: Build
  displayName: BuildStage
  jobs:
  - job: Build
    displayName: BuildJob
    pool:
      vmImage: 'windows-latest'
    steps:
    - task: NuGetToolInstaller@1

    - task: NuGetCommand@2
      inputs:
        restoreSolution: '$(solution)'

    - task: VSBuild@1
      inputs:
        solution: '$(solution)'
        msbuildArgs: '/p:DeployOnBuild=true /p:WebPublishMethod=Package /p:PackageAsSingleFile=true /p:SkipInvalidConfigurations=true /p:PackageLocation="$(build.artifactStagingDirectory)"'
        platform: '$(buildPlatform)'
        configuration: '$(buildConfiguration)'

    - task: PublishBuildArtifacts@1
      inputs:
        PathtoPublish: '$(Build.ArtifactStagingDirectory)'
        ArtifactName: 'drop'
        publishLocation: 'Container'

# ==================== DEV ENVIRONMENT ====================

- stage: TerraformDev
  displayName: Terraform Dev Infra
  dependsOn: Build
  jobs:
  - deployment: CreateDevInfraJob
    displayName: Create Dev Infra
    pool:
      vmImage: 'windows-latest'
    environment: Dev
    strategy:
      runOnce:
        deploy:
          steps:
          - checkout: self

          - task: TerraformInstaller@1
            inputs:
              terraformVersion: 'latest'

          - task: AzureCLI@3
            displayName: Terraform Init (Dev)
            inputs:
              connectionType: 'azureRM'
              azureSubscription: 'growsc-manual'
              scriptType: 'bash'
              scriptLocation: 'inlineScript'
              inlineScript: |
                cd Terraform
                terraform init -reconfigure -backend-config="backend-dev.conf"

          - task: AzureCLI@3
            displayName: Terraform Apply (Dev)
            inputs:
              connectionType: 'azureRM'
              azureSubscription: 'growsc-manual'
              scriptType: 'bash'
              scriptLocation: 'inlineScript'
              inlineScript: |
                cd Terraform
                terraform apply -var-file="dev.tfvars" -auto-approve

- stage: DeploytoDev
  displayName: Deploy to Dev Infra
  dependsOn: TerraformDev
  jobs:
  - deployment: DeployToDevJob
    displayName: Deploy to dev Web App
    pool:
      vmImage: 'windows-latest'
    environment: Dev
    strategy:
      runOnce:
        deploy:
          steps:
          - download: current
            artifact: drop

          - task: AzureRmWebAppDeployment@5
            inputs:
              ConnectionType: 'AzureRM'
              azureSubscription: 'growsc-manual'
              appType: 'webApp'
              WebAppName: 'growwwebappdev001'
              packageForLinux: '$(pipeline.workspace)/drop/**/*.zip'

# ==================== QA ENVIRONMENT ====================

- stage: TerraformQA
  displayName: Terraform QA Infra
  dependsOn: Build
  jobs:
  - deployment: CreateQAInfraJob
    displayName: Create QA Infra
    pool:
      vmImage: 'windows-latest'
    environment: QA
    strategy:
      runOnce:
        deploy:
          steps:
          - checkout: self

          - task: TerraformInstaller@1
            inputs:
              terraformVersion: 'latest'

          - task: AzureCLI@3
            displayName: Terraform Init (QA)
            inputs:
              connectionType: 'azureRM'
              azureSubscription: 'growsc-manual'
              scriptType: 'bash'
              scriptLocation: 'inlineScript'
              inlineScript: |
                cd Terraform
                terraform init -reconfigure -backend-config="backend-qa.conf"

          - task: AzureCLI@3
            displayName: Terraform Apply (QA)
            inputs:
              connectionType: 'azureRM'
              azureSubscription: 'growsc-manual'
              scriptType: 'bash'
              scriptLocation: 'inlineScript'
              inlineScript: |
                cd Terraform
                terraform apply -var-file="qa.tfvars" -auto-approve

- stage: DeploytoQA
  displayName: Deploy to QA Infra
  dependsOn: TerraformQA
  jobs:
  - deployment: DeployToQAJob
    displayName: Deploy to QA Web App
    pool:
      vmImage: 'windows-latest'
    environment: QA
    strategy:
      runOnce:
        deploy:
          steps:
          - download: current
            artifact: drop

          - task: AzureRmWebAppDeployment@5
            inputs:
              ConnectionType: 'AzureRM'
              azureSubscription: 'growsc-manual'
              appType: 'webApp'
              WebAppName: 'growwwebappqa001'
              packageForLinux: '$(pipeline.workspace)/drop/**/*.zip'
