DB instance identifier: product-db
Master username: product_api 
master password: securepass





## Commands

sudo apt-get update && sudo apt-get install mysql-client -y
mysql -h <RDS-ENDPOINT> -u product-api -p
chmox +x docker-cleanup.sh
./docker-cleanup.sh
endre <RDS-ENDPOINT> i docker-compose.yml
docker-compose up -d --build
