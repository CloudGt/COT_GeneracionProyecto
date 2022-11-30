<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:c="urn:schemas-codeontime-com:data-aquarium"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:csharp="urn:codeontime-customcode"
    exclude-result-prefixes="msxsl a c csharp"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="Namespace"/>
	<xsl:param name="SharedBusinessRules" select="'false'"/>

	<msxsl:script language="C#" implements-prefix="csharp">
		public string ExtractNamespace(string name){
		return Regex.Match(name, @"^(.+)(\.\w+)$", RegexOptions.Compiled).Groups[1].Value;
		}
		public string ExtractClassName(string name) {
		return Regex.Match(name, @".(\w+)$", RegexOptions.Compiled).Groups[1].Value;
		}
	</msxsl:script>

	<xsl:template match="c:dataController">

		<xsl:variable name="QualifiedNamespace">
			<xsl:choose>
				<xsl:when test="contains(@handler,'.')">
					<xsl:value-of select="csharp:ExtractNamespace(@handler)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$Namespace"/>
					<xsl:text>.Rules</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="QualifiedClassName">
			<xsl:choose>
				<xsl:when test="contains(@handler, '.')">
					<xsl:value-of select="csharp:ExtractClassName(@handler)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@handler"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="BusinessRulesBase">
			<xsl:choose>
				<xsl:when test="$SharedBusinessRules='true'">
					<xsl:text>Rules.SharedBusinessRules</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Data.BusinessRules</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<compileUnit namespace="{$QualifiedNamespace}">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="{$Namespace}.Data"/>
			</imports>
			<types>
				<!-- class BusinessObject -->
				<typeDeclaration name="{$QualifiedClassName}" isPartial="true">
					<baseTypes>
						<typeReference type="{$Namespace}.{$BusinessRulesBase}"/>
					</baseTypes>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>

</xsl:stylesheet>
