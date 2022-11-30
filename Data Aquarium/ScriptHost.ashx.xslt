<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:config="http://www.codeontime.com/2008/codedom-configuration"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
		xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
		exclude-result-prefixes="msxsl a"
>
	<xsl:param name="Namespace" select="/a:project/a:namespace"/>
	<xsl:output method="text"/>
	<xsl:variable name="Provider" select="document('../_Config/CodeOnTime.CodeDom.xml')//config:provider[@name=parent::config:providers/@default]"/>

	<xsl:template match="/">
		<xsl:text>&lt;%@ WebHandler Language="</xsl:text>
		<xsl:value-of select="$Provider/@language"/>
		<xsl:text>" Class="</xsl:text>
		<xsl:value-of select="$Namespace"/>
		<xsl:text>.Handlers.ScriptHost" %&gt;

</xsl:text>
	</xsl:template>
</xsl:stylesheet>
