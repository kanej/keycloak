<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xpath-default-namespace="urn:jboss:domain:2.2">

    <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/*/*/*[local-name(.) = 'security-realms']">
        <xsl:copy>

              <security-realm xmlns="urn:jboss:domain:2.2" name="UndertowRealm">
                  <server-identities>
                      <ssl>
                          <keystore path="security/keystore.jks" relative-to="jboss.server.config.dir" keystore-password="KEYSTORE_PASSWORD" />
                       </ssl>
                  </server-identities>
              </security-realm>

              <xsl:apply-templates select="node()|@*"/>

        </xsl:copy>
    </xsl:template>

  <xsl:template match="/*/*/*/*[local-name(.) = 'server']">
        <xsl:copy>

            <xsl:apply-templates select="node()|@*"/>
            <https-listener xmlns="urn:jboss:domain:undertow:1.2" name="https" socket-binding="https" security-realm="UndertowRealm"/>

        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
