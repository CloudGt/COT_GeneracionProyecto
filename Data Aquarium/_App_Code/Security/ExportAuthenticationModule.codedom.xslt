<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="Namespace" select="a:project/a:namespace"/>

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Security">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Configuration"/>
				<namespaceImport name="System.Security.Permissions"/>
				<namespaceImport name="System.Security.Principal"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="{$Namespace}.Services"/>
				<namespaceImport name="{$Namespace}.Services.Rest"/>
			</imports>
			<types>
				<!-- class ExportAuthenticationModule -->
				<typeDeclaration name="ExportAuthenticationModule" isPartial="true">
					<customAttributes>
						<customAttribute name="AspNetHostingPermission">
							<arguments>
								<propertyReferenceExpression name="LinkDemand">
									<typeReferenceExpression type="SecurityAction"/>
								</propertyReferenceExpression>
								<attributeArgument name="Level">
									<propertyReferenceExpression name="Minimal">
										<typeReferenceExpression type="AspNetHostingPermissionLevel"/>
									</propertyReferenceExpression>
								</attributeArgument>
							</arguments>
						</customAttribute>
					</customAttributes>
					<baseTypes>
						<typeReference type="ExportAuthenticationModuleBase"/>
					</baseTypes>
				</typeDeclaration>
				<!-- class ExportAuthenticationModule -->
				<typeDeclaration name="ExportAuthenticationModuleBase">
					<baseTypes>
						<typeReference type="System.Object"/>
						<typeReference type="IHttpModule"/>
					</baseTypes>
					<members>
						<!-- method IHttpModule.Init(HttpApplication)-->
						<memberMethod name="Init" privateImplementationType="IHttpModule">
							<attributes/>
							<parameters>
								<parameter type="HttpApplication" name="context"/>
							</parameters>
							<statements>
								<attachEventStatement>
									<event name="BeginRequest">
										<argumentReferenceExpression name="context"/>
									</event>
									<listener>
										<delegateCreateExpression type="EventHandler" methodName="contextBeginRequest"/>
									</listener>
								</attachEventStatement>
								<attachEventStatement>
									<event name="AuthenticateRequest">
										<argumentReferenceExpression name="context"/>
									</event>
									<listener>
										<delegateCreateExpression type="EventHandler" methodName="contextAuthenticateRequest"/>
									</listener>
								</attachEventStatement>
								<attachEventStatement>
									<event name="EndRequest">
										<argumentReferenceExpression name="context"/>
									</event>
									<listener>
										<delegateCreateExpression type="EventHandler" methodName="contextEndRequest"/>
									</listener>
								</attachEventStatement>
							</statements>
						</memberMethod>
						<!-- method IHttpModule.Disose()-->
						<memberMethod name="Dispose" privateImplementationType="IHttpModule">
							<attributes/>
						</memberMethod>
						<!-- method contextBeginRequest(object sender, EventArgs e)-->
						<memberMethod name="contextBeginRequest" >
							<attributes private="true"/>
							<parameters>
								<parameter type="System.Object" name="sender"/>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="HttpRequest" name="request">
									<init>
										<propertyReferenceExpression name="Request">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="HttpContext"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="origin">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="Origin"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="origin"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String" name="myOrigin">
											<init>
												<binaryOperatorExpression operator="Add">
													<propertyReferenceExpression name="Scheme">
														<propertyReferenceExpression name="Url">
															<variableReferenceExpression name="request"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<binaryOperatorExpression operator="Add">
														<propertyReferenceExpression name="SchemeDelimiter">
															<typeReferenceExpression type="Uri"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="Host">
															<propertyReferenceExpression name="Url">
																<variableReferenceExpression name="request"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="IsDefaultPort">
														<propertyReferenceExpression name="Url">
															<variableReferenceExpression name="request"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="myOrigin"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="myOrigin"/>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value=":"/>
															<convertExpression to="String">
																<propertyReferenceExpression name="Port">
																	<propertyReferenceExpression name="Url">
																		<variableReferenceExpression name="request"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</convertExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueInequality">
													<variableReferenceExpression name="origin"/>
													<variableReferenceExpression name="myOrigin"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.Boolean" name="allowed">
													<init>
														<primitiveExpression value="false"/>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="SortedDictionary" name="config">
													<typeArguments>
														<typeReference type="System.String"/>
														<typeReference type="System.String"/>
													</typeArguments>
													<init>
														<methodInvokeExpression methodName="CorsConfiguration">
															<target>
																<propertyReferenceExpression name="Current">
																	<typeReferenceExpression type="ApplicationServicesBase"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="request"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<variableReferenceExpression name="config"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<foreachStatement>
															<variable type="KeyValuePair" name="kvp">
																<typeArguments>
																	<typeReference type="System.String"/>
																	<typeReference type="System.String"/>
																</typeArguments>
															</variable>
															<target>
																<variableReferenceExpression name="config"/>
															</target>
															<statements>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Headers">
																				<propertyReferenceExpression name="Response">
																					<propertyReferenceExpression name="Current">
																						<typeReferenceExpression type="HttpContext"/>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<propertyReferenceExpression name="Key">
																				<variableReferenceExpression name="kvp"/>
																			</propertyReferenceExpression>
																		</indices>
																	</arrayIndexerExpression>
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="kvp"/>
																	</propertyReferenceExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<binaryOperatorExpression operator="ValueEquality">
																				<propertyReferenceExpression name="Key">
																					<variableReferenceExpression name="kvp"/>
																				</propertyReferenceExpression>
																				<primitiveExpression value="Access-Control-Allow-Origin"/>
																			</binaryOperatorExpression>
																			<binaryOperatorExpression operator="BooleanOr">
																				<binaryOperatorExpression operator="ValueEquality">
																					<propertyReferenceExpression name="Value">
																						<variableReferenceExpression name="kvp"/>
																					</propertyReferenceExpression>
																					<primitiveExpression value="*"/>
																				</binaryOperatorExpression>
																				<methodInvokeExpression methodName="Contains">
																					<target>
																						<methodInvokeExpression methodName="Split">
																							<target>
																								<propertyReferenceExpression name="Value">
																									<variableReferenceExpression name="kvp"/>
																								</propertyReferenceExpression>
																							</target>
																							<parameters>
																								<primitiveExpression value="," convertTo="Char"/>
																							</parameters>
																						</methodInvokeExpression>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="origin"/>
																					</parameters>
																				</methodInvokeExpression>
																			</binaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="allowed"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanOr">
															<unaryOperatorExpression operator="Not">
																<variableReferenceExpression name="allowed"/>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="ValueEquality">
																<propertyReferenceExpression name="HttpMethod">
																	<variableReferenceExpression name="request"/>
																</propertyReferenceExpression>
																<primitiveExpression value="OPTIONS"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="CompleteRequest">
															<target>
																<castExpression targetType="HttpApplication">
																	<argumentReferenceExpression name="sender"/>
																</castExpression>
															</target>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method contextAuthenticateRequest(object sender, EventArgs e)-->
						<memberMethod name="contextAuthenticateRequest" >
							<attributes private="true"/>
							<parameters>
								<parameter type="System.Object" name="sender"/>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="app">
									<init>
										<castExpression targetType="HttpApplication">
											<argumentReferenceExpression name="sender"/>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="appServices">
									<init>
										<objectCreateExpression type="ApplicationServices"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="authorization">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<propertyReferenceExpression name="Request">
														<variableReferenceExpression name="app"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="Authorization"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="authorization"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<comment>validate auth header</comment>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="StartsWith">
													<target>
														<variableReferenceExpression name="authorization"/>
													</target>
													<parameters>
														<primitiveExpression value="Basic"/>
														<propertyReferenceExpression name="CurrentCultureIgnoreCase">
															<typeReferenceExpression type="StringComparison"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="BasicAuthSupported">
															<typeReferenceExpression type="RESTfulResource"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement/>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="ValidateUserIdentity">
													<parameters>
														<variableReferenceExpression name="app"/>
														<variableReferenceExpression name="authorization"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="StartsWith">
															<target>
																<variableReferenceExpression name="authorization"/>
															</target>
															<parameters>
																<primitiveExpression value="Bearer "/>
																<propertyReferenceExpression name="CurrentCultureIgnoreCase">
																	<typeReferenceExpression type="StringComparison"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ValidateUserToken">
															<parameters>
																<variableReferenceExpression name="app"/>
																<methodInvokeExpression methodName="Substring">
																	<target>
																		<variableReferenceExpression name="authorization"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="7"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsRequested">
													<typeReferenceExpression type="RESTfulResource"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="ValidateRESTfulApiKey">
															<target>
																<variableReferenceExpression name="appServices"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="app"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement/>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="RequiresAuthentication">
														<target>
															<variableReferenceExpression name="appServices"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Request">
																<propertyReferenceExpression name="Context">
																	<variableReferenceExpression name="app"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="AuthenticateRequest">
													<target>
														<variableReferenceExpression name="appServices"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Context">
															<variableReferenceExpression name="app"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="RequestAuthentication">
											<parameters>
												<variableReferenceExpression name="app"/>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method contextEndRequest(object sender, EventArgs e)-->
						<memberMethod name="contextEndRequest">
							<attributes private="true"/>
							<parameters>
								<parameter type="System.Object" name="sender"/>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="HttpApplication" name="app">
									<init>
										<castExpression targetType="HttpApplication">
											<argumentReferenceExpression name="sender"/>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="StatusCode">
													<propertyReferenceExpression name="Response">
														<variableReferenceExpression name="app"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
												<primitiveExpression value="401"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="IdentityEquality">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Items">
															<propertyReferenceExpression name="Context">
																<variableReferenceExpression name="app"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="IgnoreBasicAuthenticationRequest"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="RequestAuthentication">
											<parameters>
												<variableReferenceExpression name="app"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method RequestAuthentication(HttpApplication) -->
						<memberMethod name="RequestAuthentication">
							<attributes private ="true"/>
							<parameters>
								<parameter type="HttpApplication" name="app"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ApplicationServices" name="appServices">
									<init>
										<objectCreateExpression type="ApplicationServices"/>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="AppendHeader">
									<target>
										<propertyReferenceExpression name="Response">
											<argumentReferenceExpression name="app"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="WWW-Authenticate"/>
										<!--<primitiveExpression value="Basic realm=&quot;{$Namespace} Data Export&quot;"/>-->
										<stringFormatExpression format="Basic realm=&quot;{{0}}&quot;">
											<propertyReferenceExpression name="Realm">
												<variableReferenceExpression name="appServices"/>
											</propertyReferenceExpression>
										</stringFormatExpression>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<propertyReferenceExpression name="StatusCode">
										<propertyReferenceExpression name="Response">
											<argumentReferenceExpression name="app"/>
										</propertyReferenceExpression>
									</propertyReferenceExpression>
									<primitiveExpression value="401"/>
								</assignStatement>
								<methodInvokeExpression methodName="CompleteRequest">
									<target>
										<argumentReferenceExpression name="app"/>
									</target>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ValidateUserIdentity(HttpApplication, string) -->
						<memberMethod name="ValidateUserIdentity">
							<attributes private ="true"/>
							<parameters>
								<parameter type="HttpApplication" name="app"/>
								<parameter type="System.String" name="authorization"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="login">
									<init>
										<methodInvokeExpression methodName="AuthorizationToLogin">
											<target>
												<typeReferenceExpression type="RESTfulResource"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="authorization"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="login"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<methodInvokeExpression methodName="ValidateUser">
												<target>
													<typeReferenceExpression type="Membership"/>
												</target>
												<parameters>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="login"/>
														</target>
														<indices>
															<primitiveExpression value="0"/>
														</indices>
													</arrayIndexerExpression>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="login"/>
														</target>
														<indices>
															<primitiveExpression value="1"/>
														</indices>
													</arrayIndexerExpression>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="User">
												<propertyReferenceExpression name="Context">
													<argumentReferenceExpression name="app"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<objectCreateExpression type="RolePrincipal">
												<parameters>
													<objectCreateExpression type="FormsIdentity">
														<parameters>
															<objectCreateExpression type="FormsAuthenticationTicket">
																<parameters>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="login"/>
																		</target>
																		<indices>
																			<primitiveExpression value="0"/>
																		</indices>
																	</arrayIndexerExpression>
																	<primitiveExpression value="false"/>
																	<primitiveExpression value="10"/>
																</parameters>
															</objectCreateExpression>
														</parameters>
													</objectCreateExpression>
												</parameters>
											</objectCreateExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<propertyReferenceExpression name="StatusCode">
												<propertyReferenceExpression name="Response">
													<argumentReferenceExpression name="app"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="401"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="StatusDescription">
												<propertyReferenceExpression name="Response">
													<argumentReferenceExpression name="app"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="Access Denied"/>
										</assignStatement>
										<methodInvokeExpression methodName="Write">
											<target>
												<propertyReferenceExpression name="Response">
													<argumentReferenceExpression name="app"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<primitiveExpression value="Access denied. Please enter a valid username and password."/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="CompleteRequest">
											<target>
												<argumentReferenceExpression name="app"/>
											</target>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ValidateUserToken(HttpApplication, string) -->
						<memberMethod name="ValidateUserToken">
							<attributes private="true"/>
							<parameters>
								<parameter type="HttpApplication" name="app"/>
								<parameter type="System.String" name="authorization"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="ValidateToken">
												<target>
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="authorization"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Items">
														<propertyReferenceExpression name="Context">
															<variableReferenceExpression name="app"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="IgnoreBasicAuthenticationRequest"/>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="true"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="StatusCode">
												<propertyReferenceExpression name="Response">
													<argumentReferenceExpression name="app"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="401"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="ContentType">
												<propertyReferenceExpression name="Response">
													<argumentReferenceExpression name="app"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="application/json"/>
										</assignStatement>
										<methodInvokeExpression methodName="AppendHeader">
											<target>
												<propertyReferenceExpression name="Response">
													<argumentReferenceExpression name="app"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<primitiveExpression value="WWW-Authenticate"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[Bearer error="invalid_token"]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Write">
											<target>
												<propertyReferenceExpression name="Response">
													<argumentReferenceExpression name="app"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<methodInvokeExpression methodName="ToString">
													<target>
														<methodInvokeExpression methodName="JsonError">
															<target>
																<methodInvokeExpression methodName="Create">
																	<target>
																		<propertyReferenceExpression name="ApplicationServicesBase"/>
																	</target>
																</methodInvokeExpression>
															</target>
															<parameters>
																<primitiveExpression value="invalid_token"/>
																<primitiveExpression value="The access token is invalid or expired."/>
															</parameters>
														</methodInvokeExpression>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="CompleteRequest">
											<target>
												<argumentReferenceExpression name="app"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
