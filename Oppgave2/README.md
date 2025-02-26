# Oppgave 2
```bash
1. Test løsningen lokalt for å sikre at den fungerer som forventet.
2. Opprett en konto på Docker Hub hvis du ikke allerede har en.
3. Bygg og tag Docker-images for API og Nginx.
4. Push de byggede Docker-images til din private eller offentlige Docker Hub repository.
5. Lag nye docker-compose.yml slik at den ikke bruker build-kommandoen, men isteden refererer til image-tagene fra Docker Hub.
6. Dokumenter stegene og inkluder link til dine Docker Hub-repositories.

```
## Fremgangsmåte

```
curl http://localhost/api/health  # Skal returnere "API OK"
curl http://localhost/api/products  # Skal returnere en liste med produkter
```
```
# Logg inn på Docker Hub
docker login
```


## Bygg Docker-images
```
# Bygg Flask API med tag
docker build -t juzt3r/eksamen-api:latest ./app

# Bygg Nginx med tag
docker build -t juzt3r/eksamen-nginx:latest ./nginx
```

## Push images opp til docker hub
```
# Api
docker push juzt3r/eksamen-api:latest
# nginx
docker push juzt3r/eksamen-nginx:latest
```

### Oppdater docker-compose.yml

``` build: ./app``` byttes til ``` image: juzt3r/eksamen-api:latest```

``` image: nginx:latest``` byttes til ``` image: juzt3r/eksamen-nginx:lates```

## Sletter gamle volumer og containere

```bash docker-compose down -v```  
##  Starter på nytt
```bash docker-compose up -d```  


### Verifisere at alt fungerer
``` 
curl http://localhost/api/health 
curl http://localhost/api/products 
curl http://localhost/api/products/2 
```


### Docker URL
```https://hub.docker.com/u/juzt3r```