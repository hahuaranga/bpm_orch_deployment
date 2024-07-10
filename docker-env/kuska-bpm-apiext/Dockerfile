FROM tomcat:jre17-temurin

ENV JAVA_OPTS="-Djavax.xml.xpath.XPathFactory:http://java.sun.com/jaxp/xpath/dom=net.sf.saxon.xpath.XPathFactoryImpl" \
	CATALINA_OPTS="-Xmx512m -Dspring.config.location=classpath:/application.properties,/opt/kuska/cfg/application.properties -Dlogging.config=/opt/kuska/cfg/logback-spring.xml" \
    TOMCAT_HOME=/usr/local/tomcat

# Instala las bibliotecas necesarias para APR y OpenSSL
RUN apt-get update && apt-get install -y \
    libapr1 \
    libapr1-dev \
    libtcnative-1 \
    && apt-get clean

# Establecer LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH /usr/lib:/usr/lib/x86_64-linux-gnu

# add certificate
COPY cert/ /cert

# Copy properties
COPY properties/* /opt/kuska/cfg/

# Copy Deploys
COPY deployments/*.war $TOMCAT_HOME/webapps/

#Copy Config
COPY tomcat/tomcat-users.xml $TOMCAT_HOME/conf/tomcat-users.xml
COPY tomcat/context.xml $TOMCAT_HOME/conf/context.xml
COPY tomcat/server.xml $TOMCAT_HOME/conf/server.xml

EXPOSE 8080 8443

CMD ["catalina.sh", "run"]
