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
  <xsl:variable name="Provider" select="document('../../_Config/CodeOnTime.CodeDom.xml')//config:provider[@name=parent::config:providers/@default]"/>

  <xsl:template match="app:page">
    <xsl:text>&lt;%@ </xsl:text>
    <xsl:choose>
      <xsl:when test="$Host='DotNetNuke'">
        <xsl:text>Control</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>Page</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> Language="</xsl:text>
    <xsl:value-of select="$Provider/@language"/>
    <xsl:if test="$Host!='DotNetNuke'">
      <xsl:variable name="MasterPage">
        <xsl:choose>
          <xsl:when test="@master!='' and (contains(@master, '.Master') or contains(@master, '.master'))">
            <xsl:value-of select="@master"/>
          </xsl:when>
          <xsl:when test="@master!='' and not(contains(@master, '.Master'))">
            <xsl:value-of select="@master"/>
            <xsl:text>.Master</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>Main.Master</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:text>" MasterPageFile="</xsl:text>
      <xsl:if test="not(contains($MasterPage, '~'))">
        <xsl:text>~/</xsl:text>
      </xsl:if>
      <xsl:value-of select="$MasterPage"/>
    </xsl:if>
    <xsl:text>" AutoEventWireup="</xsl:text>
    <xsl:value-of select="$Provider/@autoEventWireup"/>
    <xsl:text>" CodeFile="</xsl:text>
    <xsl:value-of select="$Name"/>
    <xsl:choose>
      <xsl:when test="$Host='DotNetNuke'">
        <xsl:text>.ascx</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>.aspx</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$Provider/@extension"/>
    <xsl:text>" Inherits="Pages_</xsl:text>
    <xsl:value-of select="$Name"/>
    <xsl:if test="$Host!='DotNetNuke'">
      <xsl:text>"  Title="</xsl:text>
      <xsl:choose>
        <xsl:when test="@title!=''">
          <xsl:value-of select="@title"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:text>" %&gt;
</xsl:text>
    <!-- <%@ Register Assembly="MyCompany.DnnNorthwind" Namespace="MyCompany.DnnNorthwind.Web" TagPrefix="aquarium" %> -->
    <xsl:if test="$Host = 'DotNetNuke'">
      <xsl:text>&lt;%@ Register Assembly="</xsl:text>
      <xsl:value-of select="$Namespace"/>
      <xsl:text>" Namespace="</xsl:text>
      <xsl:value-of select="$Namespace"/>
      <xsl:text>.Web"  TagPrefix="aquarium" %&gt;
</xsl:text>
    </xsl:if>
    <!--<%@ Register src="../Controls/TableOfContents.ascx" tagname="TableOfContents" tagprefix="uc1" %>-->
    <xsl:for-each select="app:controls/app:control[not(@name=preceding-sibling::app:control/@name)]">
      <xsl:text>&lt;%@ Register Src="../Controls/</xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text>.ascx" TagName="</xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text>"  TagPrefix="</xsl:text>
      <xsl:value-of select="//app:userControl[@name=current()/@name]/@prefix"/>
      <xsl:text>" %&gt;
</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
