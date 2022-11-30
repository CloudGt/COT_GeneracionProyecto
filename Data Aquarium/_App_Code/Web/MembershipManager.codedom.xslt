<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsClassLibrary" select="'false'"/>
	<xsl:param name="Namespace" select="a:project/a:namespace"/>

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Web">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.Configuration"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.UI.HtmlControls"/>
				<namespaceImport name="System.Web.UI.WebControls"/>
				<namespaceImport name="System.Web.UI.WebControls.WebParts"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<!--<namespaceImport name="AjaxControlToolkit"/>-->
			</imports>
			<types>
				<!-- class MembershipManager -->
				<typeDeclaration name="MembershipManager">
					<baseTypes>
						<typeReference type="Control"/>
						<typeReference type="INamingContainer"/>
					</baseTypes>
					<members>
						<!-- property ServicePath -->
						<memberField type="System.String" name="servicePath"/>
						<memberProperty type="System.String" name="ServicePath">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="A path to a data controller web service."/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<xsl:choose>
											<xsl:when test="$IsClassLibrary='true'">
												<primitiveExpression value="~/DAF/Service.asmx"/>
											</xsl:when>
											<xsl:otherwise>
												<primitiveExpression value="~/Services/DataControllerService.asmx"/>
											</xsl:otherwise>
										</xsl:choose>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<fieldReferenceExpression name="servicePath"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<xsl:choose>
												<xsl:when test="$IsClassLibrary='true'">
													<primitiveExpression value="~/DAF/Service.asmx"/>
												</xsl:when>
												<xsl:otherwise>
													<primitiveExpression value="~/Services/DataControllerService.asmx"/>
												</xsl:otherwise>
											</xsl:choose>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="servicePath"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="servicePath"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- constructor MembershipManager() -->
						<constructor>
							<attributes public="true"/>
						</constructor>
						<!-- method CreateChildControls() -->
						<memberMethod name="CreateChildControls">
							<attributes override="true" family="true"/>
							<statements>
								<methodInvokeExpression methodName="CreateChildControls">
									<target>
										<baseReferenceExpression/>
									</target>
								</methodInvokeExpression>
								<variableDeclarationStatement type="HtmlGenericControl" name="div">
									<init>
										<objectCreateExpression type="HtmlGenericControl">
											<parameters>
												<primitiveExpression value="div"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="ID">
										<variableReferenceExpression name="div"/>
									</propertyReferenceExpression>
									<primitiveExpression value="d"/>
								</assignStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls"/>
									</target>
									<parameters>
										<variableReferenceExpression name="div"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="MembershipManagerExtender" name="manager">
									<init>
										<objectCreateExpression type="MembershipManagerExtender"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="ID">
										<variableReferenceExpression name="manager"/>
									</propertyReferenceExpression>
									<primitiveExpression value="b"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="TargetControlID">
										<variableReferenceExpression name="manager"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="ID">
										<variableReferenceExpression name="div"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="ServicePath">
										<variableReferenceExpression name="manager"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="ServicePath"/>
								</assignStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls"/>
									</target>
									<parameters>
										<variableReferenceExpression name="manager"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
