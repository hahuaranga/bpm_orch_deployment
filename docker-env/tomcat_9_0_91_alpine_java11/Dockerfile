# Usar una imagen base de Alpine
FROM alpine:latest

LABEL maintainer="Hector Huaranga <hect.ahs@gmail.com>"
LABEL description="This example Dockerfile installs Tomcat 9.0.91 java 11 with enabled APR for SSL support."
MAINTAINER Hector Huaranga <hect.ahs@gmail.com>

# Instalar dependencias necesarias
RUN apk add --no-cache openjdk11-jdk wget tar

# Descargar y extraer Tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-10/v9.0.91/bin/apache-tomcat-9.0.91.tar.gz \
    && tar -xvf apache-tomcat-9.0.91.tar.gz \
    && mv apache-tomcat-9.0.91 /usr/local/tomcat

# Configurar variables de entorno
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Actualizar el índice de paquetes e instalar dependencias
RUN apk update && apk add --no-cache build-base wget

# Instalar las dependencias necesarias para compilar
RUN apk update && apk add --no-cache \
    build-base \
    apr-dev \
    openssl-dev \
    libtool \
    autoconf \
    automake \
    bash \
    tar
    
# Establecer JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk
ENV PATH $JAVA_HOME/bin:$PATH    
    
# Extraer y compilar libtcnative-1
RUN tar -xzvf /usr/local/tomcat/bin/tomcat-native.tar.gz -C /tmp \
    && cd /tmp/tomcat-native-* \
    && cd native \
    && ./configure --with-apr=/usr/bin/apr-1-config --with-java-home=$JAVA_HOME \
    && make \
    && make install

# Limpiar archivos temporales y paquetes innecesarios
RUN apk del build-base libtool autoconf automake bash tar \
    && rm -rf /var/cache/apk/* /tmp/*

ENV LD_LIBRARY_PATH /usr/local/apr/lib

# Exponer el puerto 8080
EXPOSE 8080

# Iniciar Tomcat
CMD ["catalina.sh", "run"]