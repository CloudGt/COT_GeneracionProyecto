<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsClassLibrary" select="'false'"/>
	<xsl:param name="IsUnlimited"/>
	<xsl:param name="UrlHashing" select="'false'"/>
	<xsl:param name="Host" />

	<xsl:variable name="PageImplementation" select="a:project/@pageImplementation"/>

	<xsl:template match="/">
		<compileUnit namespace="{a:project/a:namespace}.Web">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Threading"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.UI.HtmlControls"/>
				<namespaceImport name="{a:project/a:namespace}.Data"/>
				<namespaceImport name="{a:project/a:namespace}.Services"/>
			</imports>
			<types>
				<!-- class PageBase -->
				<typeDeclaration name="PageBase" isPartial="true">
					<baseTypes>
						<typeReference type="PageBaseCore"/>
					</baseTypes>
				</typeDeclaration>
				<!-- class PageBaseCore -->
				<typeDeclaration name="PageBaseCore">
					<baseTypes>
						<typeReference type="System.Web.UI.Page"/>
					</baseTypes>
					<members>
						<!-- method InitializeCulture() -->
						<memberMethod name="InitializeCulture">
							<attributes override="true" family="true"/>
							<statements>
								<methodInvokeExpression methodName="Initialize">
									<target>
										<typeReferenceExpression type="CultureManager"/>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="InitializeCulture">
									<target>
										<baseReferenceExpression/>
									</target>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- OnInit(EventArgs) -->
						<memberMethod name="OnInit">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="OnInit">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<argumentReferenceExpression name="e"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="ValidateUrlParameters"/>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsRightToLeft">
											<propertyReferenceExpression name="TextInfo">
												<propertyReferenceExpression name="CurrentUICulture">
													<propertyReferenceExpression name="CurrentThread">
														<typeReferenceExpression type="Thread"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="Control" name="c" var="false"/>
											<target>
												<propertyReferenceExpression name="Controls"/>
											</target>
											<statements>
												<methodInvokeExpression methodName="ChangeCurrentCultureTextFlowDirection">
													<parameters>
														<variableReferenceExpression name="c"/>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.String" name="mobileSwitch">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Params">
													<propertyReferenceExpression name="Request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="_mobile"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="mobileSwitch"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="mobileSwitch"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Params">
														<propertyReferenceExpression name="Request"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="_touch"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="mobileSwitch"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="HttpCookie" name="cookie">
											<init>
												<objectCreateExpression type="HttpCookie">
													<parameters>
														<primitiveExpression value="appfactorytouchui"/>
														<methodInvokeExpression methodName="ToLower">
															<target>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="mobileSwitch"/>
																			<primitiveExpression value="true" convertTo="String"/>
																		</binaryOperatorExpression>
																	</target>
																</methodInvokeExpression>
															</target>
														</methodInvokeExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<!--<assignStatement>
                      <propertyReferenceExpression name="Path">
                        <variableReferenceExpression name="cookie"/>
                      </propertyReferenceExpression>
                      <propertyReferenceExpression name="ApplicationPath">
                        <propertyReferenceExpression name="Request"/>
                      </propertyReferenceExpression>
                    </assignStatement>-->
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="mobileSwitch"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Expires">
														<variableReferenceExpression name="cookie"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="AddDays">
														<target>
															<propertyReferenceExpression name="Today">
																<typeReferenceExpression type="DateTime"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="-1"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<propertyReferenceExpression name="Expires">
														<variableReferenceExpression name="cookie"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="AddDays">
														<target>
															<propertyReferenceExpression name="Now">
																<typeReferenceExpression type="DateTime"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="30"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="AppendCookie">
											<target>
												<typeReferenceExpression type="ApplicationServices"/>
											</target>
											<parameters>
												<variableReferenceExpression name="cookie"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Redirect">
											<target>
												<propertyReferenceExpression name="Response"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="CurrentExecutionFilePath">
													<propertyReferenceExpression name="Request"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<xsl:if test="$Host=''">
									<variableDeclarationStatement type="System.Boolean" name="isTouchUI">
										<init>
											<propertyReferenceExpression name="IsTouchClient">
												<typeReferenceExpression type="ApplicationServices"/>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanOr">
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="Device"/>
														<primitiveExpression value="touch"/>
													</binaryOperatorExpression>
													<unaryOperatorExpression operator="Not">
														<variableReferenceExpression name="isTouchUI"/>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="Device"/>
														<primitiveExpression value="desktop"/>
													</binaryOperatorExpression>
													<variableReferenceExpression name="isTouchUI"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Redirect">
												<target>
													<propertyReferenceExpression name="Response"/>
												</target>
												<parameters>
													<primitiveExpression value="~/"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<xsl:if test="$Host=''">
									<methodInvokeExpression methodName="VerifyUrl">
										<target>
											<typeReferenceExpression type="ApplicationServices"/>
										</target>
									</methodInvokeExpression>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- property Device -->
						<memberProperty type="System.String" name="Device">
							<attributes public="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method ChangeCurrentCultureTextFlowDirection(Control) -->
						<memberMethod returnType="System.Boolean" name="ChangeCurrentCultureTextFlowDirection">
							<attributes private="true"/>
							<parameters>
								<parameter type="Control" name="c"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IsTypeOf">
											<argumentReferenceExpression name="c"/>
											<typeReferenceExpression type="HtmlGenericControl"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="HtmlGenericControl" name="gc">
											<init>
												<castExpression targetType="HtmlGenericControl">
													<variableReferenceExpression name="c"/>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="TagName">
														<variableReferenceExpression name="gc"/>
													</propertyReferenceExpression>
													<primitiveExpression value="body"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Attributes">
																<variableReferenceExpression name="gc"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="dir"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="rtl"/>
												</assignStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Attributes">
																<variableReferenceExpression name="gc"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="class"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="RTL"/>
												</assignStatement>
												<methodReturnStatement>
													<primitiveExpression value="true"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<foreachStatement>
											<variable type="Control" name="child" var="false"/>
											<target>
												<propertyReferenceExpression name="Controls">
													<argumentReferenceExpression name="c"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<variableDeclarationStatement type="System.Boolean" name="result">
													<init>
														<methodInvokeExpression methodName="ChangeCurrentCultureTextFlowDirection">
															<parameters>
																<variableReferenceExpression name="child"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<variableReferenceExpression name="result"/>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="true"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method HideUnauthorizedDataView(string) -->
						<memberMethod returnType="System.String" name="HideUnauthorizedDataViews">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="content"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Boolean" name="tryRoles">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<variableReferenceExpression name="tryRoles"/>
									</test>
									<statements>
										<variableDeclarationStatement type="Match" name="m">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="content"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[\s*\bdata-roles\s*=\s*"([\S\s]*?)"]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="tryRoles"/>
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="m"/>
											</propertyReferenceExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<variableReferenceExpression name="tryRoles"/>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String" name="stringAfter">
													<init>
														<methodInvokeExpression methodName="Substring">
															<target>
																<argumentReferenceExpression name="content"/>
															</target>
															<parameters>
																<binaryOperatorExpression operator="Add">
																	<propertyReferenceExpression name="Index">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="Length">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="UserIsInRole">
															<target>
																<typeReferenceExpression type="DataControllerBase"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="m"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="1"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<argumentReferenceExpression name="content"/>
															<binaryOperatorExpression operator="Add">
																<methodInvokeExpression methodName="Substring">
																	<target>
																		<argumentReferenceExpression name="content"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="0"/>
																		<propertyReferenceExpression name="Index">
																			<variableReferenceExpression name="m"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
																<variableReferenceExpression name="stringAfter"/>
															</binaryOperatorExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<variableDeclarationStatement type="System.Int32" name="startPos">
															<init>
																<methodInvokeExpression methodName="LastIndexOf">
																	<target>
																		<methodInvokeExpression methodName="Substring">
																			<target>
																				<argumentReferenceExpression name="content"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="0"/>
																				<propertyReferenceExpression name="Index">
																					<variableReferenceExpression name="m"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="&lt;div"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="Match" name="closingDiv">
															<init>
																<methodInvokeExpression methodName="Match">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="stringAfter"/>
																		<primitiveExpression value="&lt;/div>"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<argumentReferenceExpression name="content"/>
															<binaryOperatorExpression operator="Add">
																<methodInvokeExpression methodName="Substring">
																	<target>
																		<argumentReferenceExpression name="content"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="0"/>
																		<variableReferenceExpression name="startPos"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Substring">
																	<target>
																		<variableReferenceExpression name="stringAfter"/>
																	</target>
																	<parameters>
																		<binaryOperatorExpression operator="Add">
																			<propertyReferenceExpression name="Index">
																				<variableReferenceExpression name="closingDiv"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="Length">
																				<variableReferenceExpression name="closingDiv"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</parameters>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</whileStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="content"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Render(HtmlTextWriter)-->
						<memberMethod name="Render">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="HtmlTextWriter" name="writer"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="StringBuilder" name="sb">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="HtmlTextWriter" name="tempWriter">
									<init>
										<objectCreateExpression type="HtmlTextWriter">
											<parameters>
												<objectCreateExpression type="StringWriter">
													<parameters>
														<variableReferenceExpression name="sb"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Render">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<variableReferenceExpression name="tempWriter"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Flush">
									<target>
										<variableReferenceExpression name="tempWriter"/>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Close">
									<target>
										<variableReferenceExpression name="tempWriter"/>
									</target>
								</methodInvokeExpression>
								<variableDeclarationStatement type="System.String" name="page">
									<init>
										<methodInvokeExpression methodName="Replace">
											<target>
												<typeReferenceExpression type="{a:project/a:namespace}.Data.Localizer"/>
											</target>
											<parameters>
												<primitiveExpression value="Pages"/>
												<methodInvokeExpression methodName="GetFileName">
													<target>
														<typeReferenceExpression type="Path"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="PhysicalPath">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="ToString">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<xsl:if test="$Host=''">
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="Contains">
												<target>
													<variableReferenceExpression name="page"/>
												</target>
												<parameters>
													<primitiveExpression value="data-content-framework=&quot;bootstrap&quot;"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<propertyReferenceExpression name="EnableCombinedCss">
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</propertyReferenceExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="page"/>
														<methodInvokeExpression methodName="Replace">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="page"/>
																<primitiveExpression value="_cf=&quot;"/>
																<primitiveExpression value="_cf=bootstrap&quot;"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
												<falseStatements>
													<xsl:choose>
														<xsl:when test="$IsUnlimited='true'">
															<conditionStatement>
																<condition>
																	<propertyReferenceExpression name="IsTouchClient">
																		<typeReferenceExpression type="ApplicationServicesBase"/>
																	</propertyReferenceExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<variableReferenceExpression name="page"/>
																		<methodInvokeExpression methodName="Replace">
																			<target>
																				<typeReferenceExpression type="Regex"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="page"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[(<link\s+href="[.\w\/]+?touch\-theme\..+?".+?/>)]]></xsl:attribute>
																				</primitiveExpression>
																				<binaryOperatorExpression operator="Add">
																					<binaryOperatorExpression operator="Add">
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[<link href="]]></xsl:attribute>
																						</primitiveExpression>
																						<methodInvokeExpression methodName="ResolveClientUrl">
																							<parameters>
																								<binaryOperatorExpression operator="Add">
																									<primitiveExpression value="~/css/sys/bootstrap.css?"/>
																									<propertyReferenceExpression name="Version">
																										<typeReferenceExpression type="ApplicationServices"/>
																									</propertyReferenceExpression>
																								</binaryOperatorExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</binaryOperatorExpression>
																					<primitiveExpression>
																						<xsl:attribute name="value"><![CDATA[" type="text/css" rel="stylesheet" />$1]]></xsl:attribute>
																					</primitiveExpression>
																				</binaryOperatorExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																</trueStatements>
																<falseStatements>
																	<assignStatement>
																		<variableReferenceExpression name="page"/>
																		<methodInvokeExpression methodName="Replace">
																			<target>
																				<typeReferenceExpression type="Regex"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="page"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[\/>\s*<title>]]></xsl:attribute>
																				</primitiveExpression>
																				<binaryOperatorExpression operator="Add">
																					<binaryOperatorExpression operator="Add">
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[/><link href="]]></xsl:attribute>
																						</primitiveExpression>
																						<methodInvokeExpression methodName="ResolveClientUrl">
																							<parameters>
																								<binaryOperatorExpression operator="Add">
																									<primitiveExpression value="~/css/sys/bootstrap.css?"/>
																									<propertyReferenceExpression name="Version">
																										<typeReferenceExpression type="ApplicationServices"/>
																									</propertyReferenceExpression>
																								</binaryOperatorExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</binaryOperatorExpression>
																					<primitiveExpression>
																						<xsl:attribute name="value"><![CDATA[" type="text/css" rel="stylesheet" /><title>]]></xsl:attribute>
																					</primitiveExpression>
																				</binaryOperatorExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																</falseStatements>
															</conditionStatement>
														</xsl:when>
														<xsl:otherwise>
															<assignStatement>
																<variableReferenceExpression name="page"/>
																<methodInvokeExpression methodName="Replace">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="page"/>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[\/>\s*<title>]]></xsl:attribute>
																		</primitiveExpression>
																		<binaryOperatorExpression operator="Add">
																			<binaryOperatorExpression operator="Add">
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[/><link href="]]></xsl:attribute>
																				</primitiveExpression>
																				<methodInvokeExpression methodName="ResolveClientUrl">
																					<parameters>
																						<binaryOperatorExpression operator="Add">
																							<primitiveExpression value="~/css/sys/bootstrap.css?"/>
																							<propertyReferenceExpression name="Version">
																								<typeReferenceExpression type="ApplicationServices"/>
																							</propertyReferenceExpression>
																						</binaryOperatorExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</binaryOperatorExpression>
																			<primitiveExpression>
																				<xsl:attribute name="value"><![CDATA[" type="text/css" rel="stylesheet" /><title>]]></xsl:attribute>
																			</primitiveExpression>
																		</binaryOperatorExpression>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
														</xsl:otherwise>
													</xsl:choose>
												</falseStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<propertyReferenceExpression name="EnableCombinedScript">
														<typeReferenceExpression type="AquariumExtenderBase"/>
													</propertyReferenceExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="page"/>
														<methodInvokeExpression methodName="Replace">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="page"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[(<script.+?/appservices/combined.+?)"]]></xsl:attribute>
																</primitiveExpression>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[$1&_cf=bootstrap"]]></xsl:attribute>
																</primitiveExpression>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
										<falseStatements>
											<assignStatement>
												<variableReferenceExpression name="page"/>
												<methodInvokeExpression methodName="Replace">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="page"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[<script.+?bootstrap.min.js.+?</script>\s+]]></xsl:attribute>
														</primitiveExpression>
														<stringEmptyExpression/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</falseStatements>
									</conditionStatement>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="$Host='' and $PageImplementation!='html'">
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsTouchClient">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="page"/>
													<methodInvokeExpression methodName="Replace">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<variableReferenceExpression name="page"/>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[<form(.+?)>]]></xsl:attribute>
															</primitiveExpression>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[<form$1 style="display:none">]]></xsl:attribute>
															</primitiveExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="CompressOutput">
											<target>
												<typeReferenceExpression type="ApplicationServices"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Context"/>
												<methodInvokeExpression methodName="HideUnauthorizedDataViews">
													<parameters>
														<variableReferenceExpression name="page"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</xsl:when>
									<xsl:otherwise>
										<methodInvokeExpression methodName="Write">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="HideUnauthorizedDataViews">
													<parameters>
														<variableReferenceExpression name="page"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</xsl:otherwise>
								</xsl:choose>
							</statements>
						</memberMethod>
						<!-- method ValidateUrlParameters() -->
						<xsl:if test="$IsUnlimited='true' and $UrlHashing='true'">
							<memberField type="System.String[]" name="AllowedUrlParameters">
								<attributes public="true"/>
								<init>
									<arrayCreateExpression>
										<createType type="System.String"/>
										<initializers>
											<primitiveExpression value="ReturnUrl"/>
											<primitiveExpression value="_link"/>
											<primitiveExpression value="_mobile"/>
											<primitiveExpression value="_touch"/>
											<primitiveExpression value="_accMan"/>
											<primitiveExpression value="l"/>
										</initializers>
									</arrayCreateExpression>
								</init>
							</memberField>
						</xsl:if>
						<memberMethod name="ValidateUrlParameters">
							<attributes family="true"/>
							<statements>
								<variableDeclarationStatement type="System.Boolean" name="success">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<xsl:if test="$IsUnlimited='true' and $UrlHashing='true'">
									<foreachStatement>
										<variable type="System.String" name="s"/>
										<target>
											<propertyReferenceExpression name="Keys">
												<propertyReferenceExpression name="QueryString">
													<propertyReferenceExpression name="Request"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</target>
										<statements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<methodInvokeExpression methodName="IndexOf">
															<target>
																<typeReferenceExpression type="Array"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="AllowedUrlParameters"/>
																<variableReferenceExpression name="s"/>
															</parameters>
														</methodInvokeExpression>
														<primitiveExpression value="-1"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="success"/>
														<primitiveExpression value="false"/>
													</assignStatement>
													<breakStatement/>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
								</xsl:if>
								<variableDeclarationStatement type="System.String" name="link">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Request">
													<propertyReferenceExpression name="Page"/>
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
										<tryStatement>
											<statements>
												<assignStatement>
													<variableReferenceExpression name="link"/>
													<methodInvokeExpression methodName="FromString">
														<target>
															<typeReferenceExpression type="StringEncryptor"/>
														</target>
														<parameters>
															<arrayIndexerExpression>
																<target>
																	<methodInvokeExpression methodName="Split">
																		<target>
																			<methodInvokeExpression methodName="Replace">
																				<target>
																					<variableReferenceExpression name="link"/>
																				</target>
																				<parameters>
																					<primitiveExpression value=" "/>
																					<primitiveExpression value="+"/>
																				</parameters>
																			</methodInvokeExpression>
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
												</assignStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Contains">
																<target>
																	<variableReferenceExpression name="link"/>
																</target>
																<parameters>
																	<primitiveExpression value="?" convertTo="Char"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="link"/>
															<binaryOperatorExpression operator="Add">
																<primitiveExpression value="?" convertTo="Char"/>
																<variableReferenceExpression name="link"/>
															</binaryOperatorExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement type="System.String[]" name="permalink">
													<init>
														<methodInvokeExpression methodName="Split">
															<target>
																<variableReferenceExpression name="link"/>
															</target>
															<parameters>
																<primitiveExpression value="?" convertTo="Char"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="RegisterClientScriptBlock">
													<target>
														<propertyReferenceExpression name="ClientScript"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="GetType"/>
														<primitiveExpression value="CommandLine"/>
														<stringFormatExpression format="var __dacl='{{0}}?{{1}}';">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="permalink"/>
																</target>
																<indices>
																	<primitiveExpression value="0"/>
																</indices>
															</arrayIndexerExpression>
															<methodInvokeExpression methodName="JavaScriptString">
																<target>
																	<typeReferenceExpression type="BusinessRules"/>
																</target>
																<parameters>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="permalink"/>
																		</target>
																		<indices>
																			<primitiveExpression value="1"/>
																		</indices>
																	</arrayIndexerExpression>
																</parameters>
															</methodInvokeExpression>
														</stringFormatExpression>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</statements>
											<catch exceptionType="Exception">
												<assignStatement>
													<variableReferenceExpression name="success"/>
													<primitiveExpression value="false"/>
												</assignStatement>
											</catch>
										</tryStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<variableReferenceExpression name="success"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="StatusCode">
												<propertyReferenceExpression name="Response"/>
											</propertyReferenceExpression>
											<primitiveExpression value="403"/>
										</assignStatement>
										<methodInvokeExpression methodName="End">
											<target>
												<propertyReferenceExpression name="Response"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<xsl:if test="$IsUnlimited='true' and $UrlHashing='true'">
									<methodInvokeExpression methodName="RegisterClientScriptBlock">
										<target>
											<propertyReferenceExpression name="ClientScript"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="GetType"/>
											<primitiveExpression value="ValidateUrlParameters"/>
											<primitiveExpression value="var __dauh=1;"/>
											<primitiveExpression value="true"/>
										</parameters>
									</methodInvokeExpression>
								</xsl:if>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class ControlBase -->
				<typeDeclaration name="ControlBase" isPartial="true">
					<baseTypes>
						<typeReference type="ControlBaseCore"/>
					</baseTypes>
				</typeDeclaration>
				<!-- class ControlBaseCore -->
				<typeDeclaration name="ControlBaseCore" >
					<baseTypes>
						<typeReference type="System.Web.UI.UserControl"/>
					</baseTypes>
					<members>
						<!-- OnInit(EventArgs) -->
						<memberMethod name="OnInit">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="OnInit">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<argumentReferenceExpression name="e"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method Render(HtmlTextWriter)-->
						<memberMethod name="Render">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="HtmlTextWriter" name="writer"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="StringBuilder" name="sb">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="HtmlTextWriter" name="tempWriter">
									<init>
										<objectCreateExpression type="HtmlTextWriter">
											<parameters>
												<objectCreateExpression type="StringWriter">
													<parameters>
														<variableReferenceExpression name="sb"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Render">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<variableReferenceExpression name="tempWriter"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Flush">
									<target>
										<variableReferenceExpression name="tempWriter"/>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Close">
									<target>
										<variableReferenceExpression name="tempWriter"/>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Write">
									<target>
										<argumentReferenceExpression name="writer"/>
									</target>
									<parameters>
										<methodInvokeExpression methodName="Replace">
											<target>
												<typeReferenceExpression type="{a:project/a:namespace}.Data.Localizer"/>
											</target>
											<parameters>
												<primitiveExpression value="Pages"/>
												<methodInvokeExpression methodName="GetFileName">
													<target>
														<typeReferenceExpression type="Path"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="PhysicalPath">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="ToString">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method LoadPageControl(System.Web.UI.Control, string) -->
						<memberMethod returnType="System.Web.UI.Control" name="LoadPageControl">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Web.UI.Control" name="placeholder"/>
								<parameter type="System.String" name="pageName"/>
								<xsl:choose>
									<xsl:when test="$Host='SharePoint'">
										<parameter type="System.Web.UI.Control" name="control"/>
									</xsl:when>
									<xsl:otherwise>
										<parameter type="System.Boolean" name="developmentMode"/>
									</xsl:otherwise>
								</xsl:choose>
							</parameters>
							<statements>
								<tryStatement>
									<statements>
										<variableDeclarationStatement type="System.Web.UI.Page" name="page">
											<init>
												<propertyReferenceExpression name="Page">
													<argumentReferenceExpression name="placeholder"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<xsl:choose>
											<xsl:when test="$Host = 'SharePoint'">
												<variableDeclarationStatement type="System.Web.UI.Control" name="c">
													<init>
														<argumentReferenceExpression name="control"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="c"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.String" name="controlPath">
															<init>
																<stringFormatExpression format="~/Pages/{{0}}.ascx">
																	<argumentReferenceExpression name="pageName"/>
																</stringFormatExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<variableReferenceExpression name="c"/>
															<methodInvokeExpression methodName="LoadControl">
																<target>
																	<variableReferenceExpression name="page"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="controlPath"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</xsl:when>
											<xsl:otherwise>
												<variableDeclarationStatement type="System.String" name="basePath">
													<init>
														<primitiveExpression value="~"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<argumentReferenceExpression name="developmentMode"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="basePath"/>
															<primitiveExpression value="~/DesktopModules/{a:project/a:namespace}"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement type="System.String" name="controlPath">
													<init>
														<stringFormatExpression format="{{0}}/Pages/{{1}}.ascx">
															<variableReferenceExpression name="basePath"/>
															<argumentReferenceExpression name="pageName"/>
														</stringFormatExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.Web.UI.Control" name="c">
													<init>
														<methodInvokeExpression methodName="LoadControl">
															<target>
																<variableReferenceExpression name="page"/>
															</target>
															<parameters>
																<variableReferenceExpression name="controlPath"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
											</xsl:otherwise>
										</xsl:choose>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="c"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Clear">
													<target>
														<propertyReferenceExpression name="Controls">
															<argumentReferenceExpression name="placeholder"/>
														</propertyReferenceExpression>
													</target>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Add">
													<target>
														<propertyReferenceExpression name="Controls">
															<argumentReferenceExpression name="placeholder"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<objectCreateExpression type="LiteralControl">
															<parameters>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[<table style="width:100%" id="PageBody" class="Hosted"><tr><td valign="top" id="PageContent">]]></xsl:attribute>
																</primitiveExpression>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Add">
													<target>
														<propertyReferenceExpression name="Controls">
															<argumentReferenceExpression name="placeholder"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="c"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Add">
													<target>
														<propertyReferenceExpression name="Controls">
															<argumentReferenceExpression name="placeholder"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<objectCreateExpression type="LiteralControl">
															<parameters>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[</td></tr></table>]]></xsl:attribute>
																</primitiveExpression>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
												<methodReturnStatement>
													<variableReferenceExpression name="c"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
									<catch exceptionType="Exception"></catch>
								</tryStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
