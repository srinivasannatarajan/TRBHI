Exercise 4: Windows problem solving
Please connect with a ssh client to the following machine as mentioned in the intro using you
SSH key you provided to us
We have an issue with the web application installed. When browsing to http://localhost/ we
get a 503 exception. Please diagnose and solve the issue



SOLUTION:

Afer conforming http://localhost was not working and throwed 503 exception error, I checked the Error details in Event Viewer

Application pool DefaultAppPool had been disabled. So I checked the correcponding user account for the Application Pool and noticed the account was not configured with Password Never Expires. 
So I reset password of the account "AppPoolServiceUser" with "IIS@123" and started manually the DefaultAppPool

So Now http://localhost/ is working