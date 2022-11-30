<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:a="urn:schemas-codeontime-com:data-aquarium"
    xmlns="urn:schemas-codeontime-com:data-aquarium-application" xmlns:m="urn:codeontime:data-map"
                xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"
    exclude-result-prefixes="msxsl a app"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="app:container">
    <xsl:if test="ancestor::app:page[.//app:dataView[@container=current()/@id] or .//app:control[@container=current()/@id] ]">
      <xsl:copy-of select="current()"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="node() | @*">
    <xsl:copy xml:space="default">
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
