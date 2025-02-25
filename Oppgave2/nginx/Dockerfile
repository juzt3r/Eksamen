# Bruk offisiell Nginx-baseimage
FROM nginx:latest

# Kopier Nginx-konfigurasjonen til containeren
COPY nginx.conf /etc/nginx/nginx.conf

# Eksponer port 80 for trafikk
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]