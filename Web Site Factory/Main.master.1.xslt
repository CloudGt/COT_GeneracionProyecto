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
		<xsl:text>" CodeFile="Main.master</xsl:text>
		<xsl:value-of select="$Provider/@extension"/>
		<xsl:text>" Inherits="Main" %&gt;

&lt;!DOCTYPE html &gt;
</xsl:text>
	</xsl:template>
</xsl:stylesheet>
