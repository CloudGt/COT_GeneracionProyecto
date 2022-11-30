<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:config="http://www.codeontime.com/2008/codedom-configuration"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project" exclude-result-prefixes="msxsl"
>
  <xsl:output method="text"/>
    <xsl:param name="Namespace" select="'MyProject'"/>

  <xsl:template match="/">
    <xsl:text>&lt;%@ WebService Class="</xsl:text>
    <xsl:value-of select="$Namespace"/>
    <xsl:text>.Services.DataControllerService" %&gt;
</xsl:text>
  </xsl:template>
</xsl:stylesheet>
