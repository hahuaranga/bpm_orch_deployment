# Usar una imagen base de Alpine
FROM alpine:latest

# Instalar dependencias necesarias
RUN apk add --no-cache openjdk17-jdk wget tar

# Descargar y extraer Tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.25/bin/apache-tomcat-10.1.25.tar.gz \
    && tar -xvf apache-tomcat-10.1.25.tar.gz \
    && mv apache-tomcat-10.1.25 /usr/local/tomcat

# Configurar variables de entorno
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Exponer el puerto 8080
EXPOSE 8080

# Iniciar Tomcat
CMD ["catalina.sh", "run"]