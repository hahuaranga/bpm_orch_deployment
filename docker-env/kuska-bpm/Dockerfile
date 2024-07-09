FROM bonita

ENV DB_VENDOR=postgres
ENV DB_HOST=postgres
ENV DB_PORT=5432
ENV DB_NAME=bonita
ENV DB_USER=bonita
ENV DB_PASS=bpm
ENV BIZ_DB_NAME=business_data
ENV BIZ_DB_USER=business_data
ENV BIZ_DB_PASS=bpm
ENV TENANT_LOGIN=tech_user
ENV TENANT_PASSWORD=secret
ENV PLATFORM_LOGIN=pfadmin
ENV PLATFORM_PASSWORD=pfsecret

# add certificate
#COPY certificates/ /cert

# keystore = /usr/lib/jvm/java-11-openjdk/lib/security/cacerts
#RUN keytool -import -trustcacerts -alias <mi_alias> -file /cert/<mi-certificado> -keystore /usr/lib/jvm/java-11-openjdk/lib/security/cacerts -storepass changeit -noprompt

########### Start Customization

#Copy BPM TeamNet Config
COPY tomcat/context.xml $TOMCAT_HOME/conf/context.xml
COPY tomcat/server.xml $TOMCAT_HOME/conf/server.xml
COPY tomcat/web.xml $TOMCAT_HOME/webapps/bonita/WEB-INF/web.xml

#Instalar la librería nativa libtcnative-1 de Tomcat para habilitar APR 
RUN apk update && \
    apk add --no-cache \
    build-base \
    apr-dev \
    apr-util-dev \
    openssl-dev \
    libressl-dev \
    wget \
    tar

RUN wget http://archive.apache.org/dist/tomcat/tomcat-connectors/native/1.2.30/source/tomcat-native-1.2.30-src.tar.gz && \
    tar xzf tomcat-native-1.2.30-src.tar.gz && \
    cd tomcat-native-1.2.30-src/native && \
    ./configure --with-apr=/usr/bin/apr-1-config --with-java-home=/usr/lib/jvm/java-11-openjdk && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf tomcat-native-1.2.30-src && \
    rm tomcat-native-1.2.30-src.tar.gz

RUN apk del build-base wget tar

# Establece variables de entorno necesarias
ENV BONITA_HOME=/opt/bonita

# Copia el script de configuración en el contenedor
COPY config-bonita.sh /config-bonita.sh

# Fix Dos2Unix
RUN /bin/sed -i 's/\r$//' /config-bonita.sh

# Da permisos de ejecución al script
RUN chmod +x /config-bonita.sh

# Ejecuta el script de configuración
#RUN /config-bonita.sh

########### End Customization

# Copy the startup script into the container
COPY wait-for-postgres.sh /usr/local/bin/wait-for-postgres.sh

# Fix Dos2Unix
RUN /bin/sed -i 's/\r$//' /usr/local/bin/wait-for-postgres.sh

# Make the script executable
RUN chmod +x /usr/local/bin/wait-for-postgres.sh

# Set the entrypoint to the script
ENTRYPOINT ["/bin/bash","/usr/local/bin/wait-for-postgres.sh"]

# Use the original command for Bonita
CMD ["/opt/files/startup.sh", "/opt/bonita/server/bin/catalina.sh", "run"]