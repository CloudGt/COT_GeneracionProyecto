<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="MembershipEnabled" select="'false'"/>

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
				<typeDeclaration name="MasterPage" isPartial="true">
					<baseTypes>
						<typeReference type="System.Web.UI.MasterPage"/>
					</baseTypes>
					<members>
						<!-- method Page_Load(object, EventArgs) -->
						<memberMethod name="Page_Load">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.Object" name="sender"/>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<!-- 
            sm1.CombineScripts = !Request.PhysicalPath.EndsWith("ScriptHost.ashx", StringComparison.OrdinalIgnoreCase);
							-->
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="CombineScripts">
										<propertyReferenceExpression name="sm"/>
									</propertyReferenceExpression>
									<unaryOperatorExpression operator="Not">
										<methodInvokeExpression methodName="EndsWith">
											<target>
												<propertyReferenceExpression name="PhysicalPath">
													<propertyReferenceExpression name="Request"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<primitiveExpression value="ScriptHost.ashx"/>
												<propertyReferenceExpression name="OrdinalIgnoreCase">
													<typeReferenceExpression type="StringComparison"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</unaryOperatorExpression>
								</assignStatement>
								<xsl:if test="$MembershipEnabled='true'">
									<assignStatement>
										<propertyReferenceExpression name="Visible">
											<propertyReferenceExpression name="BodyPlaceholderDiv"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="IsAuthenticated">
											<propertyReferenceExpression name="Identity">
												<propertyReferenceExpression name="User">
													<propertyReferenceExpression name="Page"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</assignStatement>
								</xsl:if>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
