FROM bonita:latest

LABEL maintainer="Hector Huaranga <hahuaranga@indracompany.com>"
MAINTAINER Hector Huaranga <hahuaranga@indracompany.com>

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

# start patch for vulnerabilities
# Actualiza el índice de los paquetes y luego actualiza todos los paquetes instalados
RUN apk update && apk upgrade --no-cache

ENV BONITA_HOME=/opt/bonita
ENV SETUP_DIR="$BONITA_HOME/setup"

RUN rm $BONITA_HOME/server/lib/bonita/h2-1.4.199.jar
RUN rm $SETUP_DIR/lib/h2-1.4.199.jar
RUN rm $SETUP_DIR/lib/postgresql-42.4.3.jar
RUN rm $BONITA_HOME/server/webapps/bonita/WEB-INF/lib/spring-web-5.3.27.jar
RUN rm $BONITA_HOME/server/webapps/bonita/WEB-INF/lib/quartz-2.3.2.jar

COPY lib/h2-2.2.220.jar $BONITA_HOME/server/lib/bonita/h2-2.2.220.jar
COPY lib/h2-2.2.220.jar $SETUP_DIR/lib/h2-2.2.220.jar
COPY lib/postgresql-42.4.4.jar $SETUP_DIR/lib/postgresql-42.4.4.jar
COPY lib/spring-web-6.0.19.jar $BONITA_HOME/server/webapps/bonita/WEB-INF/lib/spring-web-6.0.19.jar
COPY lib/quartz-2.3.2.jar /opt/bonita/server/webapps/bonita/WEB-INF/lib/quartz-2.3.2.jar

# end patch for vulnerabilities

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