<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
  <xsl:param name="Namespace"/>

	<xsl:template match="/">

		<compileUnit>
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Web.Configuration"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.UI.HtmlControls"/>
				<namespaceImport name="System.Web.UI.WebControls"/>
				<namespaceImport name="System.Web.UI.WebControls.WebParts"/>
				<namespaceImport name="System.Xml.Linq"/>
			</imports>
			<types>
				<!-- class _Default -->
				<typeDeclaration name="Login" isPartial="true">
					<baseTypes>
						<typeReference type="{$Namespace}.Web.PageBase"/>
					</baseTypes>
					<members>
						<!-- property CssClass -->
						<memberProperty type="System.String" name="CssClass">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="HomePage Wide Tall"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method Page_Load(object, EventArgs) -->
						<memberMethod name="Page_Load">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.Object" name="sender"/>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
