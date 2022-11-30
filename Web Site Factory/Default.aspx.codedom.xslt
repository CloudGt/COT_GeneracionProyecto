<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="Namespace"/>
	<xsl:param name="HomePage"/>

	<xsl:template match="/">

		<compileUnit>
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Web.Configuration"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.UI.HtmlControls"/>
				<namespaceImport name="System.Web.UI.WebControls"/>
				<namespaceImport name="System.Web.UI.WebControls.WebParts"/>
				<namespaceImport name="System.Xml.Linq"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Services"/>
			</imports>
			<types>
				<!-- class _Default -->
				<typeDeclaration name="_Default" isPartial="true">
					<baseTypes>
						<typeReference type="System.Web.UI.Page"/>
					</baseTypes>
					<members>

						<!-- 
                        UrlEncryptor enc = new UrlEncryptor();
            string[] permalink = enc.Decrypt(link.Split(',')[0]).Split('?');
            Page.ClientScript.RegisterStartupScript(GetType(), "Redirect", String.Format("location.replace(\'{0}?_link={1}\');\r\n", permalink[0], HttpUtility.UrlEncode(link)), true);
-->
						<!-- method Page_Load(object, EventArgs) -->
						<memberMethod name="Page_Load">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.Object" name="sender"/>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<!-- 
        if (Request.Params["_page"] == "_blank")
            return;                -->
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Params">
														<propertyReferenceExpression name="Request"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="_page"/>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="_blank"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.String" name="link">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Params">
													<propertyReferenceExpression name="Request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="_link"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="link"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="StringEncryptor" name="enc">
											<init>
												<objectCreateExpression type="StringEncryptor"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String[]" name="permalink">
											<init>
												<methodInvokeExpression methodName="Split">
													<target>
														<methodInvokeExpression methodName="Decrypt">
															<target>
																<variableReferenceExpression name="enc"/>
															</target>
															<parameters>
																<arrayIndexerExpression>
																	<target>
																		<methodInvokeExpression methodName="Split">
																			<target>
																				<variableReferenceExpression name="link"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="," convertTo="Char"/>
																			</parameters>
																		</methodInvokeExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="0"/>
																	</indices>
																</arrayIndexerExpression>
															</parameters>
														</methodInvokeExpression>
													</target>
													<parameters>
														<primitiveExpression value="?" convertTo="Char"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="RegisterStartupScript">
											<target>
												<propertyReferenceExpression name="ClientScript">
													<propertyReferenceExpression name="Page"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<methodInvokeExpression methodName="GetType"/>
												<primitiveExpression value="Redirect"/>
												<methodInvokeExpression methodName="Format">
													<target>
														<typeReferenceExpression type="String"/>
													</target>
													<parameters>
														<primitiveExpression value="location.replace('{{0}}?_link={{1}}');&#13;&#10;"/>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="permalink"/>
															</target>
															<indices>
																<primitiveExpression value="0"/>
															</indices>
														</arrayIndexerExpression>
														<methodInvokeExpression methodName="UrlEncode">
															<target>
																<typeReferenceExpression type="HttpUtility"/>
															</target>
															<parameters>
																<variableReferenceExpression name="link"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
												<primitiveExpression value="true"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="Redirect">
											<target>
												<propertyReferenceExpression name="Response"/>
											</target>
											<parameters>
												<xsl:choose>
													<xsl:when test="$HomePage!=''">
														<primitiveExpression value="{$HomePage}"/>
													</xsl:when>
													<xsl:otherwise>
														<propertyReferenceExpression name="HomePageUrl">
															<typeReferenceExpression type="ApplicationServices"/>
														</propertyReferenceExpression>
													</xsl:otherwise>
												</xsl:choose>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
