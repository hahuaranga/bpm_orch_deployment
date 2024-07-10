FROM tomcat:jre17-temurin

#ENV JAVA_OPTS="-Djavax.xml.xpath.XPathFactory:http://java.sun.com/jaxp/xpath/dom=net.sf.saxon.xpath.XPathFactoryImpl"

#ENV CATALINA_OPTS="-Xmx512m -Dspring.config.location=classpath:/application.properties,/opt/srom/cfg/application.properties -Dlogging.config=/opt/srom/cfg/logback-spring.xml"
ENV TOMCAT_HOME=/usr/local/tomcat

# Copy properties
COPY properties/* /opt/kuska/cfg/

# Copy Deploys
COPY deployments/*.war $TOMCAT_HOME/webapps/

#Copy Config
COPY tomcat/tomcat-users.xml $TOMCAT_HOME/conf/tomcat-users.xml
COPY tomcat/context.xml $TOMCAT_HOME/conf/context.xml
COPY tomcat/server.xml $TOMCAT_HOME/conf/server.xml
COPY tomcat/webappscontext/context.xml $TOMCAT_HOME/webapps/manager/META-INF
COPY tomcat/webappscontext/context.xml $TOMCAT_HOME/webapps/host-manager/META-INF

EXPOSE 8080 8443

CMD ["catalina.sh", "run"]
