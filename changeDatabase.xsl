<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ds="urn:jboss:domain:datasources:4.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="//ds:subsystem/ds:datasources/ds:datasource[@jndi-name='java:jboss/datasources/KeycloakDS']">
        <ds:datasource jndi-name="java:jboss/datasources/KeycloakDS" pool-name="KeycloakDS" enabled="true" use-java-context="true" use-ccm="true">
            <ds:connection-url>jdbc:oracle:thin:@${env.ORACLE_TCP_ADDR}:${env.ORACLE_TCP_PORT:1521}/${env.ORACLE_DATABASE:keycloak}</ds:connection-url>
            <ds:driver>oracle</ds:driver>
            <ds:security>
                <ds:user-name>${env.ORACLE_USERNAME:keycloak}</ds:user-name>
                <ds:password>${env.ORACLE_PASSWORD:password}</ds:password>
            </ds:security>
            <ds:validation>
                <ds:check-valid-connection-sql>SELECT 1 FROM DUAL</ds:check-valid-connection-sql>
                <ds:background-validation>true</ds:background-validation>
                <ds:background-validation-millis>60000</ds:background-validation-millis>
            </ds:validation>
            <ds:pool>
                <ds:flush-strategy>IdleConnections</ds:flush-strategy>
            </ds:pool>
        </ds:datasource>
    </xsl:template>

    <xsl:template match="//ds:subsystem/ds:datasources/ds:drivers">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
            <ds:driver name="oracle" module="com.oracle.ojdbc6">
                <ds:driver-class>oracle.jdbc.driver.OracleDriver</ds:driver-class>
            </ds:driver>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>

