#!/bin/bash
#installing required tools to add docker repository
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common --assume-yes
#adding GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
#adding repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
#installing docker packages from the repository
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io --assume-yes
sudo service docker enable
sudo service docker start
#pulling elasticsearch image and running elasticsearch container
sudo docker pull docker.elastic.co/elasticsearch/elasticsearch:7.7.0
# containerid.txt file will have containerID that can be used in health check script
sudo docker run -itd -p 9200:9200 -p 9300:9300 --name elasticsearch -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.7.0 /bin/bash > containerid.txt
echo "\n\n"
echo "Successfully created container: `tail -1 containerid.txt`"

#Health check of the created container

cat containerid.txt | while read CONTAINERID
do
echo "\n\n********** Health report of Container : $CONTAINERID **********\n\n"
echo "Is Paused?"
sudo docker inspect --format="{{.State.Paused}}" $CONTAINERID
echo "Is restarting?"
sudo docker inspect --format="{{.State.Restarting}}" $CONTAINERID
echo "PID:"
sudo docker inspect --format="{{.State.Pid}}" $CONTAINERID
echo "Is running"
sudo docker inspect --format="{{.State.Running}}" $CONTAINERID 2> /dev/null
echo "Started at"
sudo docker inspect --format="{{.State.StartedAt}}" $CONTAINERID
echo "Network IP"
sudo docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $CONTAINERID
done
