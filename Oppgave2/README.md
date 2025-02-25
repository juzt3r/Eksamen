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
docker-compose down -v  
docker-compose up -d --build  
```

```
curl http://localhost/api/health  # Skal returnere "API OK"
curl http://localhost/api/products  # Skal returnere en liste med produkter
```
```
docker login
```

```
# Bygg Flask API
docker build -t juzt3r/eksamen-api:latest ./app

# Bygg Nginx
docker build -t juzt3r/eksamen-nginx:latest ./nginx
```

```
# push images opp til docker hub
# Api
docker push juzt3r/eksamen-api:latest
# nginx
docker push juzt3r/eksamen-nginx:latest
```

```
# Sletter gamle volumer og containere
docker-compose down -v  
# Starter på nytt
docker-compose up -d  
```


### Verifisere at alt fungerer
``` curl http://localhost/api/health ```
``` curl http://localhost/api/products ```
``` curl http://localhost/api/products/2 ```


### Docker URL
```https://hub.docker.com/u/juzt3r```