# Day2 : Triggers 

Repote Repos --> Create a develop Branch 

Step1 : Create a new Repos with readme and gitignore along with visualCode in Azure Devops 
Step2: Then create a develop branch 
Step3: Clone this repository inot local computer 
       Then Check it $git branch -r 
	                 $git switch -c develop origin/develop
					 $git branch -vv 
					 
					 
Step4: Create a simple ASP.NET Core Web App (Razor Pages) project with the project name GrowLandingPage.

Step 5: Create an Azure Pipeline
Use Azure Pipelines to automatically build your .NET application.
Create the Pipeline
Open your project in Azure DevOps.
Navigate to Pipelines.
Select Create Pipeline.

Choose Azure Repos Git.
Select the GrowDotnetProj repository.
Choose ASP.NET Core or the appropriate .NET pipeline template.
Review the generated YAML pipeline code.

Step6: Explain About Trigger 
trigger: 
  branches:
    include:
	  - main
	  - develop
	  - release-*
	exclude: 
	  - features 
	  - release-narendra 
	  
  paths:
    include: 
	  - GrowLP/GrowLP/Pages/*
	exclude:
	  - 

pr: 
  branches:
    include:
	  - develop
	  
	  
schedules: 
  - cron: "*/30***"
    displayname: "run for every 30 min "
	branches: 
	  include:
	     - main
	     - develop
	     - release-*
	
	
Azure devops default varialbes search in google 
build.artifactStagingDirectory : Agent server machines takes Azure repos code and build it and the save the output with in ths agent machines 
with different location 

build.Buildid 
pipeline.Workspace : workspace directory for a particuler pipeline 

		
And then Run the build 

## Pipeline code 
<img width="734" height="592" alt="image" src="https://github.com/user-attachments/assets/47e535ed-dc46-4179-8d3b-173adc8b0843" />
