# Oppgave 1

## Beskrivelse
En mikrotjeneste bestående av API(Flash),Database(mysql), nginx(Reverse proxy)

API-server (Flask) er et python container som starter app.py med depenencies (requirements.txt)
proxy er en enkel nxinx som redirecter trafikk på port 80 til api-server port 8080.
databaseserveren har et startup-script som fyller på med noen produkter.

## Hvordan starte 

```bash
docker-compose up -d --build
```

## Verifisere at ting fungerer

``` 
curl http://localhost/api/health 
```
``` 
curl http://localhost/api/products 
```
``` 
curl http://localhost/api/products/2 
```


## Hovedkomponenter

### API
API (Flask)
En Python-basert container som kjører app.py.
Håndterer API-forespørsler og kommuniserer med databasen.



### nginx
Mottar innkommende forespørsler på port 80.
Videresender forespørsler til API-serveren på port 8080.

### DB
Inneholder produktdata.
Fylles med eksempeldata via et oppstartsskript.



## Hvordan samhandler de
Brukeren sender en forespørsel til:http://localhost/api/products
nginx videresender forespørselen til API-serveren på:http://api:8080/api/products
API-serveren (Flask) henter produktdata fra MySQL-databasen (products_db.products).
Dataen returneres til brukeren.