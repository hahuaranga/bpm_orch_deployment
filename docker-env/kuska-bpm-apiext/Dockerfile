FROM tomcat:jre17-temurin

ENV JAVA_OPTS="-Djavax.xml.xpath.XPathFactory:http://java.sun.com/jaxp/xpath/dom=net.sf.saxon.xpath.XPathFactoryImpl"

ENV CATALINA_OPTS="-Xmx512m -Dspring.config.location=classpath:/application.properties,/opt/kuska/cfg/application.properties -Dlogging.config=/opt/kuska/cfg/logback-spring.xml" \
    TOMCAT_HOME=/usr/local/tomcat

# add certificate
#COPY certificates/ /cert

#RUN keytool -import -trustcacerts -alias CAIndra -file /cert/certificadoRaiz.crt -keystore /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts -storepass changeit -noprompt

# Copy Deploys
COPY deployments/*.war $TOMCAT_HOME/webapps/

# Copy properties
COPY properties/* /opt/kuska/cfg/

#Copy Config
COPY tomcat/tomcat-users.xml $TOMCAT_HOME/conf/tomcat-users.xml
COPY tomcat/context.xml $TOMCAT_HOME/conf/context.xml
COPY tomcat/server.xml $TOMCAT_HOME/conf/server.xml
COPY tomcat/webappscontext/context.xml $TOMCAT_HOME/webapps/manager/META-INF
COPY tomcat/webappscontext/context.xml $TOMCAT_HOME/webapps/host-manager/META-INF

EXPOSE 8080 8443

CMD ["catalina.sh", "run"]
