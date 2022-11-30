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

	<!--<msxsl:script language="C#" implements-prefix="csharp">
	</msxsl:script>-->

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Rules">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="{$Namespace}.Data"/>
			</imports>
			<types>
				<!-- class SharedBusinessRules -->
				<typeDeclaration name="SharedBusinessRules" isPartial="true">
					<baseTypes>
						<typeReference type="{$Namespace}.Data.BusinessRules"/>
					</baseTypes>
					<members>
						<constructor>
							<attributes public="true"/>
						</constructor>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>

</xsl:stylesheet>
