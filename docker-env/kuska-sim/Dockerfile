FROM hhuaranga/tomcat:10.1.26-Alpine-java11

ENV JAVA_OPTS="-Djavax.xml.xpath.XPathFactory:http://java.sun.com/jaxp/xpath/dom=net.sf.saxon.xpath.XPathFactoryImpl" \
	CATALINA_OPTS="-Xmx512m -Dspring.config.location=classpath:/application.properties,/opt/kuska/cfg/application.properties -Dlogging.config=/opt/kuska/cfg/logback-spring.xml" \
    TOMCAT_HOME=/usr/local/tomcat

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
