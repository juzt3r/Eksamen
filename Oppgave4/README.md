# Oppgave 3

## Oppgavetekst
```bash
Oppgave 4: Migrering til AWS RDS (20%)
1. Opprett en MySQL RDS-instans i Free Tier innenfor samme VPC som EC2-instansen.
2. Konfigurer RDS med samme detaljer som i oppgave 1:
Databasenavn: product_db
Brukernavn: product-api
Passord: securepass
Tillat tilkobling fra EC2-instansens sikkerhetsgruppe
3. Modifiser docker-compose.yml på EC2-instansen:
Fjern MySQL-containeren
Endre APIet til å snakke med RDS-databasen; bruk RDS-endepunktet som hostnavn.
4. Sett opp den initielle Products tabellen i RDS. Hvordan den settes opp er opp til deg; om det gjøres
direkte i app-koden eller gjennom f.eks. mysql-CLI. Bootstrapping-script som kan brukes ligger vedlagt
i database_setup.sql.
5. Test API-et på nytt for å verifisere:
Tilkobling mot RDS fungerer
Data hentes korrekt fra RDS
6. Dokumenter:
RDS-oppsett og konfigurasjon
Endringer i docker-compose.yml
Sikkerhetsgruppe-konfigurasjoner
7. Utvid videoen fra Oppgave 3 (eller lag en ny) som viser:
Oppsett av RDS-instansen
Konfigurering av sikkerhetsgrupper
Testing av API mot RDS
```

## Opprette RDS (Amazon RDS)

Er en Database as a Service

Da oppretter vi en database ved å trykke på ```Create Database```
* Vi velger engine ```MySQL```
* Vi gir den et navn ```database-1```
* ```Template:``` ```Free Tier```
* ```Master username:``` ```product_api```
* Under ```Connecticity``` så velger vi ```Connect to an EC2 Computer Resource```
* Velger ```eksamen_server_emne8``` ```under EC2 instance``` som vi opprettet i oppgave 3
* Trykk ```Create Database```


## Konfigurasjon av docker-compose.yml

* Vi fjerner ```mysql``` containeren 
* Vi gjør noen endringer på ```api```containeren:
```yml
    environment:
      DB_USER: product_api
      DB_PASSWORD: securepass
      DB_HOST: database-1.c98cugqs6wgz.eu-north-1.rds.amazonaws.com #RDS ENDPOINT
      DB_NAME: product_db
``` 
Dette er enviroment-variabler til containere som brukes av ```app.py``` for å koble mot databasen. Hvis ```app.py``` ikke finner disse variablene så bruker den default-verdi. Men i dette tilfelle så vil ``` `DB_HOST``` endre seg. Der vil vi bruke host\endpoint til nye opprettet RDS'en vår.

## Konfigurasjon av Nginx
Ingen endring på konfigurasjon av Nginx

## Avslutte og rydde opp i gamle Docker-filer

Scriptet ```docker-cleanup.sh``` er ment til å bruke for å slette gamle builds og image. For å starte fra "scratch".
* Stopper alle containere
* Sletter alle containere
* Sletter alle image
* Sletter alle volums
* Rydder opp i nettverk.

Har valgt å gjøre det slik, så vi vet at det ikke henger igjen noen ressurser som kan skape problemer.

## Konfigurasjon av databasen

* Installere nødvendig verktøy: ```sudo apt-get update && sudo apt-get install mysql-client -y```
* Koble til database ```mysql -h <RDS-ENDPOINT> -u product-api -p```
* Kjør inneholdet i database_setup.sql løste ved å copy&past kode manuelt. Finnes sikkert cleanere måter å gjøre det på.

## Start docker containere
```docker-compose up -d --build```

## Verifisere tjenesten kjører
* Lokalt:
    ```curl http://localhost/api/health```
    ```curl http://localhost/api/products```
    ```curl http://localhost/api/products/2```
* Eksternt: 
    ```curl http://<EC2-IP>/api/health```
    ```curl http://<EC2-IP>/api/products```
    ```curl http://<EC2-IP>/api/products/2```


## Forbedringer

Den laveste hengende frukten her er å få fylt databasen med test-data på en bedre måte. Her kunne man hatt noe script som gjør dette eller om det finnes noen måter i RDS å starte med init.sql eller lignende

