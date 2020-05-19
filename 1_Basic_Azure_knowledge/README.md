Exercise 1: Basic Azure knowledge
Create an environment with 2 machines.
The machines need to be able to communicate with each other.
Create a script which outputs basic metrics of the machines.
? CPU usage
? Network usage
? Disk usage
Please deliver:
? An automation script creating the environment
? A 2nd script outputting the metrics



Solution:

1. Please find the code under directory "terraform" for Creating an environment with 2 machines

I have coded to create a VNET and two linux VMs in same subnet
Hence the VMs can communicate each other

Login creadential configured for the VMs are as below
Username/Password : srini/srini@123

As it is only an assessment, I have exposed credentials here, For production standard I would use vault and hash encrpted credentials



2. The health.sh BASH script can be run on the linux machines to get basic metrics
