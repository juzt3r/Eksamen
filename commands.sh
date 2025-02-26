#/bin/bash

sudo su &&
apt-get update &&
mkdir docker &&
git clone https://github.com/juzt3r/Eksamen.git &&
cd Eksamen\Oppgave3\ &&
apt-get install docker.io docker-compose &&
docker-compose up -d --build &&
wait 30 &&
curl http://localhost/api/health &&
curl http://localhost/api/product &&
curl http://localhost/api/product/1 &&
echo "Does it work?"