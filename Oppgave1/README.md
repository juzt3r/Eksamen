# Oppgave 1

## Beskrivelse
En mikrotjeneste bestående av API(Flash),Database(mysql), nginx(Reverse proxy)

API-server (Flask) er et python container som starter app.py med depenencies (requirements.txt)
proxy er en enkel nxinx som redirecter trafikk på port 80 til api-server port 8080.
databaseserveren har et startup-script som fyller på med noen produkter.

Verifisere at ting fungerer

``` curl http://localhost/api/health ```
``` curl http://localhost/api/products ```
``` curl http://localhost/api/products/2 ```


## Hvordan samhandler de
bruker prøver å gå inn på http://localhost/api/products
nginx redirecter requesten til api:8080/api/products
api snakker med db og henter ut data fra products_db.products