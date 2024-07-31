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

# Updates the package index and then updates all installed packages
RUN apk update && apk upgrade --no-cache

# Set necessary environment variables
ENV BONITA_HOME=/opt/bonita

# Copy external libs
COPY lib/ $BONITA_HOME/server/lib/bonita
RUN chown -R bonita:bonita $BONITA_HOME/server/lib/bonita/common.jar && chmod -R 664 $BONITA_HOME/server/lib/bonita/common.jar
RUN chown -R bonita:bonita $BONITA_HOME/server/lib/bonita/jackson-datatype-jsr310-2.14.2.jar && chmod -R 664 $BONITA_HOME/server/lib/bonita/jackson-datatype-jsr310-2.14.2.jar

# Custom configurations (Ej. for enable CORS)
#COPY tomcat/web.xml $BONITA_HOME/server/webapps/bonita/WEB-INF/web.xml
COPY tomcat/server.xml $BONITA_HOME/server/conf/server.xml

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