<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
    xmlns:c="urn:schemas-codeontime-com:data-aquarium" extension-element-prefixes="c"
>
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <ul>
      <xsl:for-each select="/c:dataControllerCollection/c:dataController">
        <xsl:sort select="@name"/>
        <li>
          <xsl:value-of select="@name"/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
</xsl:stylesheet>
