# Overwrite files of the tomcat server configuration that comes with the original image for Icone teamnet needs

4.1	Habilita los CORS
Por defecto, Bonita se instala sin habilitar el uso de CORS. Es obligatorio proceder a activarlos para garantizar el funcionamiento. (Mas información en: Enable CORS in Tomcat bundle | Bonita Documentation (bonitasoft.com))

Para ello debe seguirse los siguientes pasos: 
1.	Editar el firchero web.xml de la aplicación para incluir los CORS
a.	Ir a la ruta  ./server/webapps/bonita/WEB-INF/
b.	Editar el fichero web.xml y añadir en la siguiente información, incluyendo en el campo ALLOWED_ORIGIN_LIST la lista de IPs permitidas (separadas por coma):

```xml
<filter>
  <filter-name>CorsFilter</filter-name>
  <filter-class>org.apache.catalina.filters.CorsFilter</filter-class>
  <init-param>
    <param-name>cors.allowed.origins</param-name>
    <param-value>ALLOWED_ORIGIN_LIST</param-value>
  </init-param>

  <init-param>
    <param-name>cors.support.credentials</param-name>
    <param-value>true</param-value>
  </init-param>

  <init-param>
    <param-name>cors.allowed.methods</param-name>
    <param-value>GET,HEAD,POST,PUT,DELETE,OPTIONS</param-value>
  </init-param>

  <init-param>
    <param-name>cors.exposed.headers</param-name>
    <param-value>Access-Control-Allow-Origin,Access-Control-Allow-Credentials,X-Bonita-API-Token</param-value>
  </init-param>

  <init-param>
    <param-name>cors.allowed.headers</param-name>
    <param-value>Content-Type,X-Requested-With,accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers,X-Bonita-API-Token</param-value>
  </init-param>

</filter>
```

Nota importante: Este filtro añadido, debe ser definido como primer filtro en el fichero web.xml
Asimismo, en el mismo fichero añadir el siguiente filtro al inicio de la sección <filter-mapping>:

```xml
<filter-mapping>
  <filter-name>CorsFilter</filter-name>
  <url-pattern>/*</url-pattern>
</filter-mapping>
```

2.	Habilitar las funciones POST/PUT/DELETE
Para poder ejectuar API REST POST/PU/DELETE, se requiere modificar la configuración de las políticas de uso de las cookies. Para ello, se debe:
a.	Editar el fichero ./server/conf/context.xml y modificar parámetro sameSiteCookies  de valor “lax” a valor “none”:

```xml
...
    <!-- default samesite cookies configuration, for CORS set sameSiteCookies to "none" and configure bundle for HTTPS  -->
    <CookieProcessor sameSiteCookies="none" />
    ...
```

b.	Para que tenga efecto el cambio, se debe cambiar la configuración del Catalina Server del Tomcat para habilitar SSL según se indica en la referencia documental: SSL configuration | Bonita Documentation (bonitasoft.com)
i.	Editar el fichero ./server/conf/server.xml y añadir la configuración del conector HTTPS. A continuación un ejemplo con certificado autofirmado:

```xml
<Connector port="8443"
    protocol="HTTP/1.1"
    SSLEnabled="true"
    maxThreads="150"
    scheme="https"
    secure="true"
    URIEncoding="UTF-8"
    SSLCertificateFile="${catalina.base}/conf/ssl/test.bonitasoft.net.pem"
    SSLCertificateKeyFile="${catalina.base}
    /conf/ssl/test.bonitasoft.net.key"
    SSLVerifyClient="optional"
    SSLProtocol="TLSv1.2">
</Connector>
```

ii.	Instalar la librería nativa de Tomcat para habilitar APR, ejecutando en línea de comandos: sudo apt install libtcnative-1
iii.	Volver a editar el fichero ./server/webapps/bonita/WEB-INF/web.xml y añadir la siguiente configuración en la etiqueta <web-app>:

```xml
<<web-app>
   ...
   <security-constraint>
      <web-resource-collection>
         <web-resource-name>Bonita Applications Secure URLs</web-resource-name>
         <url-pattern>/*</url-pattern>
      </web-resource-collection>
      <user-data-constraint>
         <transport-guarantee>CONFIDENTIAL</transport-guarantee>
      </user-data-constraint>
   </security-constraint>
</web-app>

```

iv.	Habilitar la protección CSRF de las cookies. Para ello, hay que seguir los siguientes pasos: CSRF security | Bonita Documentation (bonitasoft.com)
1.	Descargar la configuración actual de Bonita, para ello se hace uso de la aplicación “setup”:
a.	Ejecutar: bash ./setup/setup.sh pull
b.	Esta acción creará una carpeta con la configuración actual del sistema:  ./setup/platform_conf/current/
2.	Editar el fichero ./setup/platform_conf/current/platform_portal/security-config.properties
a.	Modificar el parámetro security.csrf.cookie.secure para fijarlo con valor “true”
3.	Subir la configuración a la base de datos, mediante la ejecución del comando: bash ./setup/setup.sh push
