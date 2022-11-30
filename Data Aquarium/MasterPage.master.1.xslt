<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:config="http://www.codeontime.com/2008/codedom-configuration"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  exclude-result-prefixes="msxsl"
>
  <xsl:param name="Namespace"/>
  <xsl:output method="text"/>
  <xsl:variable name="Provider" select="document('../_Config/CodeOnTime.CodeDom.xml')//config:provider[@name=parent::config:providers/@default]"/>

  <xsl:template match="/">
    <xsl:text>&lt;%@ Master Language="</xsl:text>
    <xsl:value-of select="$Provider/@language"/>
    <xsl:text>" AutoEventWireup="</xsl:text>
    <xsl:value-of select="$Provider/@autoEventWireup"/>
    <xsl:text>" CodeFile="MasterPage.master</xsl:text>
    <xsl:value-of select="$Provider/@extension"/>
    <xsl:text>" Inherits="MasterPage" %&gt;

&lt;%@ Register Namespace="</xsl:text>
    <xsl:value-of select="$Namespace"/>
    <xsl:text>.Web" TagPrefix="aquarium" %&gt;
&lt;%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;
</xsl:text>
  </xsl:template>
</xsl:stylesheet>
