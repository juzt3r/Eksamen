#!/bin/bash

set -e  # Stopper skriptet hvis en kommando feiler

echo "Oppdaterer pakkeliste..."
sudo apt-get update -y

echo "Sjekker om Docker er installert..."
if ! command -v docker &> /dev/null; then
    echo "Installerer Docker..."
    sudo apt-get install -y docker.io
else
    echo "Docker er allerede installert."
fi

echo "Sjekker om Docker Compose er installert..."
if ! command -v docker-compose &> /dev/null; then
    echo "Installerer Docker Compose..."
    sudo apt-get install -y docker-compose
else
    echo "Docker Compose er allerede installert."
fi

echo "Kloner prosjektet fra GitHub..."
mkdir -p ~/docker  # Sikrer at katalogen finnes
cd ~/docker
git clone https://github.com/juzt3r/Eksamen.git 

echo "Bytter til riktig mappe..."
cd Eksamen/Oppgave3

echo "Starter Docker Compose..."
sudo docker-compose up -d --build

echo "Venter 30 sekunder for å sikre at containerne kjører..."
sleep 30

echo "Tester API-endepunkter... Response:200 is OK"
curl -s -o /dev/null -w "API Health Check: %{http_code}\n" http://localhost/api/health
curl -s -o /dev/null -w "All Products: %{http_code}\n" http://localhost/api/products
curl -s -o /dev/null -w "Product ID 1: %{http_code}\n" http://localhost/api/products/1
curl -s -o /dev/null -w "Invalid Product: %{http_code}\n" http://localhost/api/products/Bobby

echo "Ferdig! Virker det? "
echo "Da kan du teste fra ekstern adresse"

ekstern_ip=$(curl -s ifconfig.me)

# Skriv ut meldingen med riktig IP-adresse
echo "Prøv fra ekstern adresse:" 
echo "curl http://$ekstern_ip/api/health"
echo "curl http://$ekstern_ip/api/products"
echo "curl http://$ekstern_ip/api/products/1"


