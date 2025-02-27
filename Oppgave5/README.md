# Oppgave 5

## Oppgavetekst
```
Oppgave 5: AWS CloudWatch Monitorering (20%)
1. Installer og konfigurer CloudWatch Agent på EC2-instansen:
Last ned og installer CloudWatch Agent
Konfigurer nødvendige IAM-roller for EC2-instansen
Verifiser at agenten kjører korrekt
2. Implementer en custom CloudWatch metric i API-et:
Lag en mekanisme for å telle antall API-kall
Send denne informasjonen til CloudWatch som en custom metric
Metrikken skal ha navnet ApiCallCount
Bruk namespace ProductApi
3. Konfigurer CloudWatch Dashboard:
Opprett et Cloudwatch dashboard
Legg til graf som visualiserer antall API-kall som gjøres per tid ved å bruke metrikken ApiCallCount i
en Cloudwatch Dashboard Widget.
4. Dokumenter:
IAM-rolle konfigurasjon
CloudWatch Agent oppsett
Dashboard konfigurasjon
Kodeendringer i API-et for metrikk-logging
5. Utvid videoen fra tidligere oppgaver (eller lag en ny) som viser:
Installasjon av CloudWatch Agent
Konfigurasjon av custom metrics
Demonstrasjon av Cloudwatch dashboard med metrikkdata
```


## Endring i docker-compose.yml
Endring på Nginx-konfigurasjonen, den tar nå med ```- ./nginx/logs:/var/log/nginx ``` under ```volumes```i nginx. Dette er for at log-filer skal være tilgjengelig for cloudwatch.

## Endring API
Ingen endring i API

## Endring Nginx
Vi har lagt inn logging på alle request som kommer til nginx
```conf 
http {
    log_format cloudwatch_json escape=json
    '{'
    '"time_local":"$time_local",'
    '"remote_addr":"$remote_addr",'
    '"request":"$request",'
    '"status":"$status",'
    '"body_bytes_sent":"$body_bytes_sent",'
    '"request_time":"$request_time",'
    '"http_referer":"$http_referer",'
    '"http_user_agent":"$http_user_agent"'
    '}';

    access_log /var/log/nginx/access.log cloudwatch_json;
```

## Endringer RDS
Ingen endring gjort i RDS

## Hent ned cloudwatch-agent

```bash
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
```

## Installer cloudwatch-agent
```bash
sudo dpkg -i amazon-cloudwatch-agent.deb
```
## Sjekk status
```bash
amazon-cloudwatch-agent-ctl -a status
```


## Lage config-fil for cloudwatch til å hente logfil
```bash
echo '{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/home/ubuntu/Eksamen/nginx/logs/access.log",
            "log_group_name": "ProductApiLogs",
            "log_stream_name": "{instance_id}",
            "timestamp_format": "%d/%b/%Y:%H:%M:%S %z"
          }
        ]
      }
    }
  },
  "metrics": {
    "metrics_collected": {
      "cpu": {
        "measurement": ["cpu_usage_idle", "cpu_usage_user", "cpu_usage_system"],
        "metrics_collection_interval": 60
      },
      "disk": {
        "measurement": ["disk_used_percent"],
        "metrics_collection_interval": 60
      },
      "mem": {
        "measurement": ["mem_used_percent"],
        "metrics_collection_interval": 60
      }
    }
  }
}' | sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json > /dev/null
```


## sette rettigheter på config og restarte cloudwatch-agent
```bash
sudo chmod 644 /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
sudo systemctl restart amazon-cloudwatch-agent
sudo systemctl status amazon-cloudwatch-agent
```


