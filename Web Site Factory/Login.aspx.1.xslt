<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:config="http://www.codeontime.com/2008/codedom-configuration"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  exclude-result-prefixes="msxsl"
>
	<xsl:param name="Namespace"/>
	<xsl:output method="text"/>
	<xsl:variable name="Provider" select="document('../_Config/CodeOnTime.CodeDom.xml')//config:provider[@name=parent::config:providers/@default]"/>

	<xsl:template match="/">
		<xsl:text>&lt;%@ Page Language="</xsl:text>
		<xsl:value-of select="$Provider/@language"/>
		<xsl:text>" MasterPageFile="~/Main.master" AutoEventWireup="</xsl:text>
		<xsl:value-of select="$Provider/@autoEventWireup"/>
		<xsl:text>" CodeFile="Login.aspx</xsl:text>
		<xsl:value-of select="$Provider/@extension"/>
		<xsl:text>" Inherits="Login" Title="Login"  %&gt;</xsl:text>
	</xsl:template>
</xsl:stylesheet>
