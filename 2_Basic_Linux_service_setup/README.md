Exercise 2: Basic Linux service setup
Create a small linux machine (ubuntu) to perform the following tasks:
1 Get ElasticSearch running in a docker container
2 Check the health of ElasticSearch from the command line
Please deliver:
 A bash script we can execute on an empty Linux (ubuntu) machine
We will evaluate the output of the batch script with regards to the requirements stated.


Solution:

The script "elasticsearch_container.sh" will perform following tasks
	create docker repository 
	install & run docker engine from the repository
	pull elasticsearch image and run elasticsearch container and store containerID in containerid.txt file

	The health check will run and deliver the health status of the container by reading containerID from  containerid.txt


