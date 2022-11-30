<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:config="http://www.codeontime.com/2008/codedom-configuration"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  exclude-result-prefixes="msxsl"
>
	<xsl:param name="Namespace"/>
	<xsl:param name="IsApplication" select="'false'"/>
	<xsl:output method="text"/>
	<xsl:variable name="Provider" select="document('../_Config/CodeOnTime.CodeDom.xml')//config:provider[@name=parent::config:providers/@default]"/>
	<xsl:variable name="MasterPageName">
		<xsl:choose>
			<xsl:when test="$IsApplication='true'">
				<xsl:text>Main</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>MasterPage</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:template match="/">
		<xsl:text>&lt;%@ Page Language="</xsl:text>
		<xsl:value-of select="$Provider/@language"/>
		<xsl:text>" MasterPageFile="~/</xsl:text>
		<xsl:value-of select="$MasterPageName"/>
		<xsl:text>.master" AutoEventWireup="</xsl:text>
		<xsl:value-of select="$Provider/@autoEventWireup"/>
		<xsl:text>" CodeFile="Details.aspx</xsl:text>
		<xsl:value-of select="$Provider/@extension"/>
		<xsl:text>" Inherits="</xsl:text>
		<xsl:value-of select="$Namespace"/>
		<xsl:text>.Handlers.Details" Title="Details"  %&gt;
</xsl:text>
	</xsl:template>
</xsl:stylesheet>
