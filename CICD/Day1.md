# Azure Devops Pipelines 

CICD --> COntinues Integration and Continues Development /Deployment 

<img width="496" height="332" alt="image" src="https://github.com/user-attachments/assets/c0f7a848-ac52-4197-a56a-e03f828a4f89" />


### Build :
1. compile the source code 
2.Resolve the dependencies 
3.Package the application 
4.generate an executable file 


Step 1:  Create a Repo with .gitignore:VisualStudio 
Step2: Clone it 
       $git clone https://narendraponugoti3@dev.azure.com/narendraponugoti3/grow/_git/GrowDotnetProj
	   
	   Then Create a Simple Dotnet project : ASP.NET Core Web App (Razor Pages )and proejct name is GrowLanding Page 
	   and run it via command prompt 
	   $dotnet --version
	   $dotnet restore 
	   $dotnet build 
	   $dotnut run 
	   
Step3: once Create a donot project then modify the index.html page based on your requirment 
       Then Save the file and then run it in local 
	   Then Push the code into Azure repors 
	   $git status 
	   $git add . | $git commit -m "dotnet push" 
	   $git push 
	   
Step4: go to Azure pipelines  --> Create a Pipelines -->Azure Repos Git --> Select a Repos  
        Choose AP.Net --> generate the Pipeline YAML Code 
		Then Remove the test case and and then publish build artifact 
		Then Save and Run 


    <img width="916" height="591" alt="image" src="https://github.com/user-attachments/assets/8dad1877-7dc6-4934-bb3d-cd14105265fe" />
