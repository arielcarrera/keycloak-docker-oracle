FROM jboss/keycloak:latest

ENV JAVA_OPTS="-Djava.security.egd=file:/dev/urandom"

ADD changeDatabase.xsl /opt/jboss/keycloak/
RUN java -jar /usr/share/java/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone.xml -xsl:/opt/jboss/keycloak/changeDatabase.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone.xml; java -jar /usr/share/java/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml -xsl:/opt/jboss/keycloak/changeDatabase.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml; rm /opt/jboss/keycloak/changeDatabase.xsl
RUN mkdir -p /opt/jboss/keycloak/modules/system/layers/base/com/oracle/ojdbc6/main
ADD ojdbc6.jar /opt/jboss/keycloak/modules/system/layers/base/com/oracle/ojdbc6/main/
ADD module.xml /opt/jboss/keycloak/modules/system/layers/base/com/oracle/ojdbc6/main/
