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


## Misc
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
