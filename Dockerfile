# Usamos la imagen oficial de Nginx sin privilegios
FROM nginxinc/nginx-unprivileged:alpine

# Cambiamos temporalmente a root para configurar carpetas y permisos
USER root

# Limpiamos el contenido por defecto de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copiamos la configuración de nuestro proxy inverso
COPY default.conf /etc/nginx/conf.d/default.conf

# Copiamos nuestro dashboard (nota: ya no copiamos app.js porque lo integramos al HTML)
COPY index.html /usr/share/nginx/html/

# Le damos la propiedad de los archivos al usuario seguro "nginx"
RUN chown -R nginx:nginx /usr/share/nginx/html

# Volvemos al usuario no root para la ejecución
USER nginx

# Exponemos el puerto 8080 (el puerto por defecto del unprivileged)
EXPOSE 8080