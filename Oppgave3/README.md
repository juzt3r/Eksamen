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

Vi flytter oss til sky. Når oppsettet er satt opp i AWS er det bare å logge inn på server og kjøre følgende scriptet ```commands.sh``` så skal den koble opp alt du trenger.
Video presentasjon viser hvordan man setter opp i AWS.