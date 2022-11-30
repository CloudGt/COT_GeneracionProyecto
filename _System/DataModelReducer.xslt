<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="foreignKey">
    <xsl:variable name="FkSignature">
      <xsl:text>|</xsl:text>
      <xsl:call-template name="CreateNodeSignature">
        <xsl:with-param name="Node" select="."/>
      </xsl:call-template>
      <xsl:text>|</xsl:text>
    </xsl:variable>


    <xsl:variable name="SiblingSignatures">
      <xsl:text>|</xsl:text>
      <xsl:for-each select="preceding-sibling::foreignKey[@parentTableSchema=current()/@parentTableSchema and @parentTableName=current()/@parentTableName]">
        <xsl:call-template name="CreateNodeSignature">
          <xsl:with-param name="Node" select="."/>
        </xsl:call-template>
        <xsl:text>|</xsl:text>
      </xsl:for-each>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="contains($SiblingSignatures, $FkSignature)">
        <xsl:comment>
          <xsl:text>Duplicate </xsl:text>
          <xsl:value-of select="@parentTableSchema"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="@parentTableName"/>
          <xsl:text> foreign key</xsl:text>
        </xsl:comment>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="current()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="CreateNodeSignature">
    <xsl:param name="Node"/>
    <xsl:value-of select="name()"/>
    <xsl:text>/</xsl:text>
    <xsl:for-each select="$Node/@*">
      <xsl:sort select="name()"/>
      <xsl:value-of select="name()"/>
      <xsl:text>:</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="$Node/node()">
      <xsl:sort select="name()"/>
      <xsl:call-template name="CreateNodeSignature">
        <xsl:with-param name="Node" select="."/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
