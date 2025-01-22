============================READ ME====================================	 
									 
to run this app pre-requisites are node.js, json-server			 
									  
============= Install Node js =========================================		
									  
Download the Windows Installer : https://nodejs.org/en/download		 
									
Run Installer								
									
Finish Setup and Install Node.js and NPM				 
									
Verify the Installation							 
	Type node -v and press Enter to check the Node.js version.	 
	Type npm -v and press Enter to check the npm version.		 
									
In CMD run npm install npm --global					
									
=========== Set up json-server =======================================	
									
create a new directory for your project (optional, but recommended):	
Open Command Prompt or PowerShell.					
Create a new directory and navigate into it:				
	my-json-server							
	cd my-json-server					
	npm init -y							
									
Install JSON Server							
	npm install json-server --save-dev				
Alternatively, to install it globally 					
(useful if you want to use it across multiple projects)			
	npm install -g json-server					
									
Create the db.json File							
JSON Server uses a file (usually called db.json) to 			
serve as a mock database. 						
This file will contain your mock data and the API endpoints.		
									
In your project folder, create a new file called db.json.		
									
running the following command in your terminal:				
	type nul > db.json						
									
Start JSON Server							
run the following command in your terminal 				
	(ensure you're in the project folder where db.json is located):	
	npx json-server --watch db.json --port 3000			
									
Note: If you installed JSON Server globally, you can simply use:	
	json-server --watch db.json --port 3000				
	\{^_^}/ hi!							
									
	Local: http://localhost:3000					
									
Test the API								
Here are some endpoints you can test:					
http://localhost:3000/users – View all users				
http://localhost:3000/users/1 – View user with ID 1			
http://localhost:3000/accounts – View all accounts			
http://localhost:3000/accounts/1 – View accounts with ID 1		
									


============================= Download Source Code =========================================

DB.JSON : refer to email link
	note : make sure download DB.JSON and put it to folder where json-server is installed.
	for installed in global, can put any desired folder

============================ UNIT TEST ======================================================

Open the project folder in your IDE (e.g., Android Studio).
Navigate to the test folder, open the unit test class file, right-click, and select Run.


================================ References ==================================================

FIGMA LINK : refer to email link
