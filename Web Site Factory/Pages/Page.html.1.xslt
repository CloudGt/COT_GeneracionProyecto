<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:config="http://www.codeontime.com/2008/codedom-configuration"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"
    exclude-result-prefixes="msxsl app"
>
  <xsl:param name="Namespace"/>
  <xsl:param name="Name"/>
  <xsl:param name="Host" select="''"/>
  <xsl:output method="text"/>

  <xsl:template match="app:page">
    <xsl:text>&lt;!doctype html&gt;
</xsl:text>
  </xsl:template>
</xsl:stylesheet>
