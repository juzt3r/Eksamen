# Bruk en lett Python-image
FROM python:3.9

# Sett arbeidskatalog
WORKDIR /app

# Kopier filer
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Kopier hele appen
COPY . .

# Eksponer port 8080
EXPOSE 8080

# Kjør applikasjonen
CMD ["python", "app.py"]