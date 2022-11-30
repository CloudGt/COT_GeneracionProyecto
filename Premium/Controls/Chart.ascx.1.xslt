<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:config="http://www.codeontime.com/2008/codedom-configuration"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:c="urn:schemas-codeontime-com:data-aquarium"
    xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"
    exclude-result-prefixes="msxsl app c"
>
	<xsl:param name="Namespace"/>
	<xsl:param name="Name" />
	<xsl:output method="text"/>
	<xsl:variable name="Provider" select="document('../../_Config/CodeOnTime.CodeDom.xml')//config:provider[@name=parent::config:providers/@default]"/>

	<xsl:template match="c:view">
		<xsl:text>&lt;%@ Control Language="</xsl:text>
		<xsl:value-of select="$Provider/@language"/>
		<xsl:text>" AutoEventWireup="</xsl:text>
		<xsl:value-of select="$Provider/@autoEventWireup"/>
		<xsl:text>" CodeFile="</xsl:text>
		<xsl:value-of select="$Name"/>
		<xsl:text>.ascx</xsl:text>
		<xsl:value-of select="$Provider/@extension"/>
		<xsl:text>" Inherits="Controls_</xsl:text>
		<xsl:value-of select="$Name"/>
		<xsl:text>"  %&gt;</xsl:text>
	</xsl:template>
</xsl:stylesheet>
