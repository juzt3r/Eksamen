# Oppgave 3

## Oppgavetekst
```bash
✔Oppgave 3: Deploy API til AWS EC2 med Nginx (20%)
1. Opprett en egen VPC i AWS.
2. Opprett en EC2-instans i Free Tier (Amazon Linux eller Ubuntu) og sørg for at EC2-instansen er
opprettet innenfor denne VPC-en.
3. Installer og konfigurer Docker og Docker Compose.
4. Konfigurer docker-compose.yml for å trekke ned API og Nginx-images fra Docker Hub.
5. Eksponer API-et via Nginx på port 80 slik at det er offentlig tilgjengelig.
6. For testing: Tillatt testing direkte på API på port 8080
7. Test API-et med curl, 'swagger', 'scalar' eller 'Postman'. Testene skal kjøres mot public IP'en til EC2-
instansen.
8. Dokumenter stegene og IP-adressen til den kjørende tjenesten.
9. Lag en video (5-10 minutter) som viser hele prosessen, inkludert:
Opprettelse av EC2-instans i den opprettede VPC-en.
Hvordan man kobler til EC2-instansen med SSH.
Overføring av 'docker-compose.yml' til serveren med scp.
Hvordan .pem-filen brukes for sikker tilkobling.
Installasjon av Docker
Start docker-compose.yml (docker-compose up -d)
Test av API-et som nå kjører på en EC2 maskin med en public addresse
``` 


## Oppsett av infrastruktur

* Vi oppretter en VPC (Virtual Private Cloud) og gir den navn ```eksamen_vpc``` og gir den et nettverk. ```10.0.0.0/16```

* Deretter oppretter vi et subnet som vi kaller ```eksamen_subnet``` og forteller hvilke ip-adresser som skal være tilgjengelig der. Her bruker vi ```10.0.0.0/24``` for vi trenger ikke så mye pr. nå. Vi kobler dette subnettet til ```eksamen_vpc```

* Neste steg blir å opprette en Public Gateway som vi kaller ```eksamen_gw``` så vi kan koble til mot internett. Vi tilkobler denne gatewayen til vår VPC ```eksamen_vpc```.  

* Vi oppretter en ny route table som vi kaller ```eksamen_route``` denne kobler vi til ```eksamen_vpc``` og lager en ny regel som sier at trafikk fra ```0.0.0.0/0``` går til ```eksamen_gw```  

* Når vi har gjort det tar vi ```subnet association``` på ```eksamen_route``` som forteller subnettet hvilken route den skal bruke

Vi flytter oss til sky. Når oppsettet er satt opp i AWS er det bare å logge inn på server og kjøre følgende scriptet ```commands.sh``` så skal den koble opp alt du trenger.
Video presentasjon viser hvordan man setter opp i AWS.