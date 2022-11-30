<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:ontime="urn:schemas-codeontime-com:xslt"
 	  exclude-result-prefixes="msxsl a ontime a"
>
  <xsl:output method="text" indent="yes"/>
  <xsl:param name="TargetFramework" select="a:project/@targetFramework"/>
  <xsl:param name="ProjectName"/>
  <xsl:param name="AppFolder"/>
  <xsl:param name="VisualStudio2012"/>
  <xsl:param name="VisualStudio2013"/>
  <xsl:param name="VisualStudio2015"/>
  <xsl:param name="VisualStudio2017"/>
  <xsl:param name="VisualStudio2019"/>
  <xsl:param name="VisualStudio2022"/>
  <xsl:param name="ProjectId"/>

  <msxsl:script language="CSharp" implements-prefix="ontime">
    <![CDATA[
				public string Guid() {
					return System.Guid.NewGuid().ToString().ToUpper();
        }
		]]>
  </msxsl:script>

  <xsl:variable name="SolutionGuid" select="ontime:Guid()"/>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="$TargetFramework='3.5'">
        <xsl:text>
Microsoft Visual Studio Solution File, Format Version 10.00
# Visual Studio 2008
</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$VisualStudio2022 != ''">
            <xsl:text>
Microsoft Visual Studio Solution File, Format Version 12.00
# Visual Studio 17
</xsl:text>
          </xsl:when>
			<xsl:when test="$VisualStudio2019 != ''">
				<xsl:text>
Microsoft Visual Studio Solution File, Format Version 12.00
# Visual Studio 16
</xsl:text>
			</xsl:when>
			<xsl:when test="$VisualStudio2017 != ''">
            <xsl:text>
Microsoft Visual Studio Solution File, Format Version 12.00
# Visual Studio 15
</xsl:text>
          </xsl:when>
          <xsl:when test="$VisualStudio2015 != ''">
            <xsl:text>
Microsoft Visual Studio Solution File, Format Version 12.00
# Visual Studio 14
</xsl:text>
          </xsl:when>
          <xsl:when test="$VisualStudio2013 != ''">
            <xsl:text>
Microsoft Visual Studio Solution File, Format Version 12.00
# Visual Studio 2013
</xsl:text>
          </xsl:when>
          <xsl:when test="$VisualStudio2012 != ''">
            <xsl:text>
Microsoft Visual Studio Solution File, Format Version 12.00
# Visual Studio 2012
</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>
Microsoft Visual Studio Solution File, Format Version 11.00
# Visual Studio 2010
</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>
Project("{E24C65DC-7377-472B-9ABA-BC803B73C61A}") = "</xsl:text>
    <xsl:value-of select="$ProjectName"/>
    <xsl:text>", "</xsl:text>
    <xsl:value-of select="$AppFolder"/>
    <xsl:text>\", "</xsl:text>
    <xsl:value-of select="ontime:Guid()"/>
    <xsl:text>"
EndProject
</xsl:text>
  </xsl:template>

</xsl:stylesheet>
