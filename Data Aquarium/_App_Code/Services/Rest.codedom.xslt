<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:codeontime="urn:schemas-codeontime-com:ease"  exclude-result-prefixes="msxsl a codeontime"
>

	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="TargetFramework" select="a:project/@targetFramework"/>
	<xsl:param name="TargetFramework45Plus"/>
	<xsl:param name="ScriptOnly" select="a:project/a:features/a:framework/@scriptOnly"/>
	<xsl:param name="PageImplementation" select="a:project/@pageImplementation"/>
	<xsl:param name="IsUnlimited"/>
	<xsl:param name="IsPremium"/>
	<xsl:param name="Mobile"/>
	<xsl:param name="ProjectId"/>

	<xsl:variable name="Theme" select="a:project/a:theme/@name"/>
	<xsl:variable name="MembershipEnabled" select="a:project/a:membership/@enabled"/>
	<xsl:variable name="CustomSecurity" select="a:project/a:membership/@customSecurity"/>

	<xsl:variable name="Namespace" select="a:project/a:namespace"/>

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Services.Rest">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
			</imports>
			<types>
				<xsl:if test="$MembershipEnabled='true' or $CustomSecurity='true'">
					<!-- class SaasConfiguration-->
					<typeDeclaration name="SaasConfiguration">
						<attributes public="true"/>
						<members>
							<!-- field _config-->
							<memberField type="System.String" name="config"/>
							<!-- field _clientId-->
							<memberField type="System.String" name="clientId"/>
							<!-- field _clientSecret-->
							<memberField type="System.String" name="clientSecret"/>
							<!-- field _redirectUri-->
							<memberField type="System.String" name="redirectUri"/>
							<!-- field _accessToken-->
							<memberField type="System.String" name="accessToken"/>
							<!-- field _refreshToken-->
							<memberField type="System.String" name="refreshToken"/>
							<!-- property ClientId-->
							<memberProperty type="System.String" name="ClientId">
								<attributes public="true"/>
								<getStatements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="clientId"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="clientId"/>
												<arrayIndexerExpression>
													<target>
														<thisReferenceExpression/>
													</target>
													<indices>
														<primitiveExpression value="Client Id"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<fieldReferenceExpression name="clientId"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- property ClientSecret-->
							<memberProperty type="System.String" name="ClientSecret">
								<attributes public="true"/>
								<getStatements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="clientSecret"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="clientSecret"/>
												<arrayIndexerExpression>
													<target>
														<thisReferenceExpression/>
													</target>
													<indices>
														<primitiveExpression value="Client Secret"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<fieldReferenceExpression name="clientSecret"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- property RedirectUri-->
							<memberProperty type="System.String" name="RedirectUri">
								<attributes public="true"/>
								<getStatements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="redirectUri"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="IdentityInequality">
															<propertyReferenceExpression name="Instance">
																<typeReferenceExpression type="SaasConfigManager"/>
															</propertyReferenceExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<propertyReferenceExpression name="IsLocalRequest">
															<propertyReferenceExpression name="Instance">
																<typeReferenceExpression type="SaasConfigManager"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<fieldReferenceExpression name="redirectUri"/>
														<arrayIndexerExpression>
															<target>
																<thisReferenceExpression/>
															</target>
															<indices>
																<primitiveExpression value="Local Redirect Uri"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="redirectUri"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="redirectUri"/>
												<arrayIndexerExpression>
													<target>
														<thisReferenceExpression/>
													</target>
													<indices>
														<primitiveExpression value="Redirect Uri"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<fieldReferenceExpression name="redirectUri"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- property AccessToken-->
							<memberProperty type="System.String" name="AccessToken">
								<attributes public="true"/>
								<getStatements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="accessToken"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="accessToken"/>
												<arrayIndexerExpression>
													<target>
														<thisReferenceExpression/>
													</target>
													<indices>
														<primitiveExpression value="Access Token"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<fieldReferenceExpression name="accessToken"/>
									</methodReturnStatement>
								</getStatements>
								<setStatements>
									<assignStatement>
										<fieldReferenceExpression name="accessToken"/>
										<variableReferenceExpression name="value"/>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<thisReferenceExpression/>
											</target>
											<indices>
												<primitiveExpression value="Access Token"/>
											</indices>
										</arrayIndexerExpression>
										<variableReferenceExpression name="value"/>
									</assignStatement>
								</setStatements>
							</memberProperty>
							<!-- property RefreshToken-->
							<memberProperty type="System.String" name="RefreshToken">
								<attributes public="true"/>
								<getStatements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="refreshToken"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="refreshToken"/>
												<arrayIndexerExpression>
													<target>
														<thisReferenceExpression/>
													</target>
													<indices>
														<primitiveExpression value="Refresh Token"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<fieldReferenceExpression name="refreshToken"/>
									</methodReturnStatement>
								</getStatements>
								<setStatements>
									<assignStatement>
										<fieldReferenceExpression name="refreshToken"/>
										<variableReferenceExpression name="value"/>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<thisReferenceExpression/>
											</target>
											<indices>
												<primitiveExpression value="Refresh Token"/>
											</indices>
										</arrayIndexerExpression>
										<variableReferenceExpression name="value"/>
									</assignStatement>
								</setStatements>
							</memberProperty>
							<!-- SaasConfiguration(string)-->
							<constructor>
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="config"/>
								</parameters>
								<statements>
									<assignStatement>
										<fieldReferenceExpression name="config"/>
										<binaryOperatorExpression operator="Add">
											<binaryOperatorExpression operator="Add">
												<primitiveExpression value="&#10;"/>
												<argumentReferenceExpression name="config"/>
											</binaryOperatorExpression>
											<primitiveExpression value="&#10;"/>
										</binaryOperatorExpression>
									</assignStatement>
								</statements>
							</constructor>
							<!-- this[string]-->
							<memberProperty type="System.String" name="Item">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="property"/>
								</parameters>
								<getStatements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="config"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<stringEmptyExpression/>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="Match" name="m">
										<init>
											<methodInvokeExpression methodName="Match">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<fieldReferenceExpression name="config"/>
													<binaryOperatorExpression operator="Add">
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="\n("/>
															<argumentReferenceExpression name="property"/>
														</binaryOperatorExpression>
														<primitiveExpression value=")\:\s*?\n?(?'Value'[^\s\n].+?)\n"/>
													</binaryOperatorExpression>
													<propertyReferenceExpression name="IgnoreCase">
														<typeReferenceExpression type="RegexOptions"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="m"/>
											</propertyReferenceExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<methodInvokeExpression methodName="Trim">
													<target>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Value"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</target>
												</methodInvokeExpression>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<stringEmptyExpression/>
									</methodReturnStatement>
								</getStatements>
								<setStatements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<fieldReferenceExpression name="config"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="re">
												<init>
													<objectCreateExpression type="Regex">
														<parameters>
															<binaryOperatorExpression operator="Add">
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[(^|\n)(?'Name']]></xsl:attribute>
																</primitiveExpression>
																<binaryOperatorExpression operator="Add">
																	<methodInvokeExpression methodName="Escape">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<argumentReferenceExpression name="property"/>
																		</parameters>
																	</methodInvokeExpression>
																	<primitiveExpression>
																		<xsl:attribute name="value"><![CDATA[)\s*\:\s*(?'Value'.*?)(\r?\n|$)]]></xsl:attribute>
																	</primitiveExpression>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="BitwiseOr">
																<propertyReferenceExpression name="Multiline">
																	<typeReferenceExpression type="RegexOptions"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="IgnoreCase">
																	<typeReferenceExpression type="RegexOptions"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</parameters>
													</objectCreateExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="test">
												<init>
													<methodInvokeExpression methodName="Match">
														<target>
															<variableReferenceExpression name="re"/>
														</target>
														<parameters>
															<fieldReferenceExpression name="config"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNullOrEmpty">
														<propertySetValueReferenceExpression/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<conditionStatement>
														<condition>
															<propertyReferenceExpression name="Success">
																<variableReferenceExpression name="test"/>
															</propertyReferenceExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<fieldReferenceExpression name="config"/>
																<binaryOperatorExpression operator="Add">
																	<methodInvokeExpression methodName="Substring">
																		<target>
																			<fieldReferenceExpression name="config"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="0"/>
																			<propertyReferenceExpression name="Index">
																				<arrayIndexerExpression>
																					<target>
																						<propertyReferenceExpression name="Groups">
																							<variableReferenceExpression name="test"/>
																						</propertyReferenceExpression>
																					</target>
																					<indices>
																						<primitiveExpression value="Name"/>
																					</indices>
																				</arrayIndexerExpression>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="Substring">
																		<target>
																			<fieldReferenceExpression name="config"/>
																		</target>
																		<parameters>
																			<binaryOperatorExpression operator="Add">
																				<propertyReferenceExpression name="Index">
																					<variableReferenceExpression name="test"/>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="Length">
																					<variableReferenceExpression name="test"/>
																				</propertyReferenceExpression>
																			</binaryOperatorExpression>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
												</trueStatements>
												<falseStatements>
													<conditionStatement>
														<condition>
															<propertyReferenceExpression name="Success">
																<variableReferenceExpression name="test"/>
															</propertyReferenceExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<fieldReferenceExpression name="config"/>
																<binaryOperatorExpression operator="Add">
																	<methodInvokeExpression methodName="Substring">
																		<target>
																			<fieldReferenceExpression name="config"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="0"/>
																			<propertyReferenceExpression name="Index">
																				<arrayIndexerExpression>
																					<target>
																						<propertyReferenceExpression name="Groups">
																							<variableReferenceExpression name="test"/>
																						</propertyReferenceExpression>
																					</target>
																					<indices>
																						<primitiveExpression value="Value"/>
																					</indices>
																				</arrayIndexerExpression>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																	<binaryOperatorExpression operator="Add">
																		<propertySetValueReferenceExpression/>
																		<methodInvokeExpression methodName="Substring">
																			<target>
																				<fieldReferenceExpression name="config"/>
																			</target>
																			<parameters>
																				<binaryOperatorExpression operator="Add">
																					<propertyReferenceExpression name="Index">
																						<arrayIndexerExpression>
																							<target>
																								<propertyReferenceExpression name="Groups">
																									<variableReferenceExpression name="test"/>
																								</propertyReferenceExpression>
																							</target>
																							<indices>
																								<primitiveExpression value="Value"/>
																							</indices>
																						</arrayIndexerExpression>
																					</propertyReferenceExpression>
																					<propertyReferenceExpression name="Length">
																						<arrayIndexerExpression>
																							<target>
																								<propertyReferenceExpression name="Groups">
																									<variableReferenceExpression name="test"/>
																								</propertyReferenceExpression>
																							</target>
																							<indices>
																								<primitiveExpression value="Value"/>
																							</indices>
																						</arrayIndexerExpression>
																					</propertyReferenceExpression>
																				</binaryOperatorExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</assignStatement>
														</trueStatements>
														<falseStatements>
															<assignStatement>
																<fieldReferenceExpression name="config"/>
																<stringFormatExpression format="{{0}}&#10;{{1}}: {{2}}">
																	<methodInvokeExpression methodName="Trim">
																		<target>
																			<fieldReferenceExpression name="config"/>
																		</target>
																	</methodInvokeExpression>
																	<argumentReferenceExpression name="property"/>
																	<propertySetValueReferenceExpression/>
																</stringFormatExpression>
															</assignStatement>
														</falseStatements>
													</conditionStatement>
												</falseStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
								</setStatements>
							</memberProperty>
							<memberMethod name="UpdateTokens">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="data"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="aToken">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="data"/>
													</target>
													<indices>
														<primitiveExpression value="access_token"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="aToken"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="AccessToken"/>
												<variableReferenceExpression name="aToken"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement name="rToken">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="data"/>
													</target>
													<indices>
														<primitiveExpression value="refresh_token"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="rToken"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="RefreshToken"/>
												<variableReferenceExpression name="rToken"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ToString()-->
							<memberMethod returnType="System.String" name="ToString">
								<attributes override="true" public="true"/>
								<statements>
									<methodReturnStatement>
										<fieldReferenceExpression name="config"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- class SaasConfigManager -->
					<typeDeclaration name="SaasConfigManager">
						<members>
							<!-- field configLock -->
							<memberField type="System.Object" name="configLock">
								<init>
									<objectCreateExpression type="System.Object"/>
								</init>
							</memberField>
							<!-- field Location -->
							<memberField type="System.String" name="Location">
								<attributes public="true" static="true"/>
								<init>
									<primitiveExpression value="null"/>
								</init>
							</memberField>
							<!-- field Instance -->
							<memberField type="SaasConfigManager" name="Instance">
								<attributes public="true" static="true"/>
								<init>
									<objectCreateExpression type="SaasConfigManager"/>
								</init>
							</memberField>
							<!-- property Config -->
							<memberField type="SaasConfiguration" name="config"/>
							<memberProperty type="SaasConfiguration" name="Config">
								<attributes public="true" final="true"/>
								<getStatements>
									<lockStatement>
										<object>
											<fieldReferenceExpression name="configLock"/>
										</object>
										<statements>
											<methodReturnStatement>
												<fieldReferenceExpression name="config"/>
											</methodReturnStatement>
										</statements>
									</lockStatement>
								</getStatements>
							</memberProperty>
							<!-- constructor() -->
							<constructor>
								<attributes public="true"/>
							</constructor>
							<!-- constructor(string) -->
							<constructor>
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="config"/>
								</parameters>
								<statements>
									<lockStatement>
										<object>
											<fieldReferenceExpression name="configLock"/>
										</object>
										<statements>
											<assignStatement>
												<fieldReferenceExpression name="config"/>
												<objectCreateExpression type="SaasConfiguration">
													<parameters>
														<argumentReferenceExpression name="config"/>
													</parameters>
												</objectCreateExpression>
											</assignStatement>
										</statements>
									</lockStatement>
								</statements>
							</constructor>
							<!-- method Read(RestApiClient) -->
							<memberMethod returnType="SaasConfiguration" name="Read">
								<attributes public="true"/>
								<parameters>
									<parameter type="RestApiClient" name="instance"/>
								</parameters>
								<statements>
									<lockStatement>
										<object>
											<fieldReferenceExpression name="configLock"/>
										</object>
										<statements>
											<variableDeclarationStatement name="config">
												<init>
													<stringEmptyExpression/>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<propertyReferenceExpression name="Location"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="config"/>
														<methodInvokeExpression methodName="ReadAllText">
															<target>
																<typeReferenceExpression type="File"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ToConfigFileName">
																	<parameters>
																		<argumentReferenceExpression name="instance"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityEquality">
														<fieldReferenceExpression name="config"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<fieldReferenceExpression name="config"/>
														<objectCreateExpression type="SaasConfiguration">
															<parameters>
																<variableReferenceExpression name="config"/>
															</parameters>
														</objectCreateExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<methodReturnStatement>
												<fieldReferenceExpression name="config"/>
											</methodReturnStatement>
										</statements>
									</lockStatement>
								</statements>
							</memberMethod>
							<!-- method Write(RestApiClient, JObject) -->
							<memberMethod name="Write">
								<attributes public="true"/>
								<parameters>
									<parameter type="RestApiClient" name="instance"/>
									<parameter type="JObject" name="data"/>
								</parameters>
								<statements>
									<lockStatement>
										<object>
											<fieldReferenceExpression name="configLock"/>
										</object>
										<statements>
											<methodInvokeExpression methodName="UpdateTokens">
												<target>
													<fieldReferenceExpression name="config"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="data"/>
												</parameters>
											</methodInvokeExpression>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<propertyReferenceExpression name="Location"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="WriteAllText">
														<target>
															<typeReferenceExpression type="File"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="ToConfigFileName">
																<parameters>
																	<argumentReferenceExpression name="instance"/>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="ToString">
																<target>
																	<fieldReferenceExpression name="config"/>
																</target>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</statements>
									</lockStatement>
								</statements>
							</memberMethod>
							<!-- property IsLocalRequest -->
							<memberProperty type="System.Boolean" name="IsLocalRequest">
								<attributes public="true"/>
								<getStatements>
									<methodReturnStatement>
										<primitiveExpression value="false"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method ToConfigFileName(RestApiClient) -->
							<memberMethod returnType="System.String" name="ToConfigFileName">
								<attributes family="true"/>
								<parameters>
									<parameter type="RestApiClient" name="instance"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Combine">
											<target>
												<typeReferenceExpression type="Path"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Location"/>
												<binaryOperatorExpression operator="Add">
													<propertyReferenceExpression name="Name">
														<argumentReferenceExpression name="instance"/>
													</propertyReferenceExpression>
													<primitiveExpression value=".Cofig.txt"/>
												</binaryOperatorExpression>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- RestApiClient -->
					<typeDeclaration name="RestApiClient" isPartial="true">
						<attributes public="true"/>
						<members>
							<!-- property Name -->
							<memberProperty type="System.String" name="Name">
								<attributes public="true"/>
								<getStatements>
									<variableDeclarationStatement name="n">
										<init>
											<propertyReferenceExpression name="Name">
												<methodInvokeExpression methodName="GetType"/>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="EndsWith">
												<target>
													<variableReferenceExpression name="n"/>
												</target>
												<parameters>
													<primitiveExpression value="Api"/>
													<propertyReferenceExpression name="CurrentCulture">
														<typeReferenceExpression type="StringComparison"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="n"/>
												<methodInvokeExpression methodName="Substring">
													<target>
														<variableReferenceExpression name="n"/>
													</target>
													<parameters>
														<primitiveExpression value="0"/>
														<binaryOperatorExpression operator="Subtract">
															<propertyReferenceExpression name="Length">
																<variableReferenceExpression name="n"/>
															</propertyReferenceExpression>
															<primitiveExpression value="-3"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="n"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
						</members>
					</typeDeclaration>
				</xsl:if>
				<!-- class RESTfulResourceException -->
				<typeDeclaration name="RESTfulResourceException">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="Exception"/>
					</baseTypes>
					<members>
						<!-- property Error -->
						<memberProperty type="System.String" name="Error">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property HttpCode  -->
						<memberProperty type="System.Int32" name="HttpCode">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property SchemaHint -->
						<memberProperty type="System.Boolean" name="SchemaHint">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Related -->
						<memberField type="List" name="related">
							<typeArguments>
								<typeReference type="RESTfulResourceException"/>
							</typeArguments>
							<attributes private="true"/>
						</memberField>
						<memberProperty type="List" name="Related">
							<typeArguments>
								<typeReference type="RESTfulResourceException"/>
							</typeArguments>
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="related"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- constructor (string, string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="error"/>
								<parameter type="System.String" name="description"/>
							</parameters>
							<chainedConstructorArgs>
								<primitiveExpression value="-1"/>
								<primitiveExpression value="false"/>
								<argumentReferenceExpression name="error"/>
								<argumentReferenceExpression name="description"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor (int, string, string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.Int32" name="httpCode"/>
								<parameter type="System.String" name="error"/>
								<parameter type="System.String" name="description"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="httpCode"/>
								<primitiveExpression value="false"/>
								<argumentReferenceExpression name="error"/>
								<argumentReferenceExpression name="description"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor (int, bool, string, string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.Int32" name="httpCode"/>
								<parameter type="System.Boolean" name="schemaHint"/>
								<parameter type="System.String" name="error"/>
								<parameter type="System.String" name="description"/>
							</parameters>
							<baseConstructorArgs>
								<argumentReferenceExpression name="description"/>
							</baseConstructorArgs>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="HttpCode">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="httpCode"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="SchemaHint">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="schemaHint"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Error">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="error"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="related"/>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="RESTfulResourceException"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
							</statements>
						</constructor>
						<!-- constructor (List<RESTfulResourceException>) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="List" name="errors">
									<typeArguments>
										<typeReference type="RESTfulResourceException"/>
									</typeArguments>
								</parameter>
							</parameters>
							<chainedConstructorArgs>
								<propertyReferenceExpression name="HttpCode">
									<arrayIndexerExpression>
										<target>
											<argumentReferenceExpression name="errors"/>
										</target>
										<indices>
											<primitiveExpression value="0"/>
										</indices>
									</arrayIndexerExpression>
								</propertyReferenceExpression>
								<propertyReferenceExpression name="SchemaHint">
									<arrayIndexerExpression>
										<target>
											<argumentReferenceExpression name="errors"/>
										</target>
										<indices>
											<primitiveExpression value="0"/>
										</indices>
									</arrayIndexerExpression>
								</propertyReferenceExpression>
								<propertyReferenceExpression name="Error">
									<arrayIndexerExpression>
										<target>
											<argumentReferenceExpression name="errors"/>
										</target>
										<indices>
											<primitiveExpression value="0"/>
										</indices>
									</arrayIndexerExpression>
								</propertyReferenceExpression>
								<propertyReferenceExpression name="Message">
									<arrayIndexerExpression>
										<target>
											<argumentReferenceExpression name="errors"/>
										</target>
										<indices>
											<primitiveExpression value="0"/>
										</indices>
									</arrayIndexerExpression>
								</propertyReferenceExpression>
							</chainedConstructorArgs>
							<statements>
								<forStatement>
									<variable name="i">
										<init>
											<primitiveExpression value="1"/>
										</init>
									</variable>
									<test>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="i"/>
											<propertyReferenceExpression name="Count">
												<argumentReferenceExpression name="errors"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="i"/>
									</increment>
									<statements>
										<methodInvokeExpression methodName="Add">
											<target>
												<fieldReferenceExpression name="related"/>
											</target>
											<parameters>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="errors"/>
													</target>
													<indices>
														<variableReferenceExpression name="i"/>
													</indices>
												</arrayIndexerExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</forStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
