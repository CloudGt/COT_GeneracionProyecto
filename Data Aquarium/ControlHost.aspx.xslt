<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:config="http://www.codeontime.com/2008/codedom-configuration"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  exclude-result-prefixes="msxsl"
>
	<xsl:param name="Namespace"/>
	<xsl:output method="text"/>
	<xsl:variable name="Provider" select="document('../_Config/CodeOnTime.CodeDom.xml')//config:provider[@name=parent::config:providers/@default]"/>

	<xsl:template match="/">
		<xsl:text>&lt;%@ Page Inherits="</xsl:text>
		<xsl:value-of select="$Namespace"/>
		<xsl:text>.Web.ControlHost" Title="Control Host"  %&gt;
</xsl:text>
	</xsl:template>
</xsl:stylesheet>
