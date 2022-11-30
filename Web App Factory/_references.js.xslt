<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:config="http://www.codeontime.com/2008/codedom-configuration"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  exclude-result-prefixes="msxsl"
>
  <xsl:param name="Namespace"/>
  <xsl:param name="UI"/>
  <xsl:output method="text"/>
  
  <xsl:variable name="Scripts">
    <xsl:choose>
      <xsl:when test="$Namespace!=''">
        <xsl:text>..\..\</xsl:text>
        <xsl:value-of select="$Namespace"/>
        <xsl:text>\js\</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/" xml:space="preserve"><![CDATA[/// <reference path="sys\jquery-3.6.0.js"/>
/// <reference path="daf\touch-core.js"/>
/// <reference path="]]><xsl:value-of select="$Scripts"/><![CDATA[sys\MicrosoftAjax.min.js" />
/// <reference path="daf\daf.js"/>
]]><xsl:if test="$UI!='TouchUI'"><![CDATA[/// <reference path="daf\daf-menu.js"/>
]]></xsl:if><![CDATA[/// <reference path="daf\touch.js"/>
/// <reference path="daf\touch-charts.js"/>
]]></xsl:template>
</xsl:stylesheet>
