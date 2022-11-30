<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsUnlimited"/>
	<xsl:param name="IsClassLibrary"/>
	<xsl:param name="AppVersion"/>
	<xsl:param name="jQueryMobileVersion"/>
	<xsl:param name="SiteContentTableName"/>

	<xsl:variable name="MembershipEnabled" select="a:project/a:membership/@enabled"/>
	<xsl:variable name="CustomSecurity" select="a:project/a:membership/@customSecurity"/>

	<xsl:template match="/">
		<xsl:variable name="Namespace" select="a:project/a:namespace"/>
		<compileUnit namespace="{$Namespace}.Services">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Collections.Specialized"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.IO.Compression"/>
				<namespaceImport name="System.Globalization"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Threading"/>
				<namespaceImport name="System.Xml"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.Routing"/>
				<namespaceImport name="System.Net"/>
				<namespaceImport name="System.Drawing"/>
				<namespaceImport name="System.Drawing.Imaging"/>
				<namespaceImport name="Newtonsoft.Json"/>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Handlers"/>
				<namespaceImport name="{$Namespace}.Security"/>
				<namespaceImport name="{$Namespace}.Web"/>
			</imports>
			<types>
				<!-- class UriRestConfig-->
				<typeDeclaration name="UriRestConfig">
					<members>
						<!-- field uri-->
						<memberField type="Regex" name="uri"/>
						<!-- field properties -->
						<memberField type="SortedDictionary" name="properties">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
						</memberField>
						<!-- constructor(string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="uri"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="uri"/>
									<objectCreateExpression type="Regex">
										<parameters>
											<argumentReferenceExpression name="uri"/>
											<propertyReferenceExpression name="IgnoreCase">
												<typeReferenceExpression type="RegexOptions"/>
											</propertyReferenceExpression>
										</parameters>
									</objectCreateExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="properties"/>
									<objectCreateExpression type="SortedDictionary">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="System.String"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
							</statements>
						</constructor>
						<!-- property this[string] -->
						<memberProperty type="System.String" name="Item">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="propertyName"/>
							</parameters>
							<getStatements>
								<variableDeclarationStatement type="System.String" name="result">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="TryGetValue">
									<target>
										<fieldReferenceExpression name="properties"/>
									</target>
									<parameters>
										<methodInvokeExpression methodName="ToLower">
											<target>
												<argumentReferenceExpression name="propertyName"/>
											</target>
										</methodInvokeExpression>
										<directionExpression direction="Out">
											<variableReferenceExpression name="result"/>
										</directionExpression>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<propertySetValueReferenceExpression/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertySetValueReferenceExpression/>
											<methodInvokeExpression methodName="Trim">
												<target>
													<propertySetValueReferenceExpression/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="properties"/>
										</target>
										<indices>
											<methodInvokeExpression methodName="ToLower">
												<target>
													<argumentReferenceExpression name="propertyName"/>
												</target>
											</methodInvokeExpression>
										</indices>
									</arrayIndexerExpression>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- method Enumerate(ControllerConfiguration) -->
						<memberMethod returnType="List" name="Enumerate">
							<typeArguments>
								<typeReference type="UriRestConfig"/>
							</typeArguments>
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="List" name="list">
									<typeArguments>
										<typeReference type="UriRestConfig"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="UriRestConfig"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="XPathNavigator" name="restConfigNode">
									<init>
										<methodInvokeExpression methodName="SelectSingleNode">
											<target>
												<argumentReferenceExpression name="config"/>
											</target>
											<parameters>
												<primitiveExpression value="/c:dataController/c:restConfig"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="restConfigNode"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="UriRestConfig" name="urc">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<comment>configuration regex: ^\s*(?'Property'\w+)\s*(:|=)\s*(?'Value'.+?)\s*$</comment>
										<variableDeclarationStatement type="Match" name="m">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Value">
															<variableReferenceExpression name="restConfigNode"/>
														</propertyReferenceExpression>
														<primitiveExpression value="^\s*(?'Property'\w+)\s*(:|=)\s*(?'Value'.+?)\s*$"/>
														<binaryOperatorExpression operator="BitwiseOr">
															<propertyReferenceExpression name="IgnoreCase">
																<typeReferenceExpression type="RegexOptions"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Multiline">
																<typeReferenceExpression type="RegexOptions"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<propertyReferenceExpression name="Success">
													<variableReferenceExpression name="m"/>
												</propertyReferenceExpression>
											</test>
											<statements>
												<variableDeclarationStatement type="System.String" name="propertyName">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Property"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="propertyValue">
													<init>
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
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Equals">
															<target>
																<variableReferenceExpression name="propertyName"/>
															</target>
															<parameters>
																<primitiveExpression value="Uri"/>
																<propertyReferenceExpression name="CurrentCultureIgnoreCase">
																	<typeReferenceExpression type="StringComparison"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<tryStatement>
															<statements>
																<assignStatement>
																	<variableReferenceExpression name="urc"/>
																	<objectCreateExpression type="UriRestConfig">
																		<parameters>
																			<variableReferenceExpression name="propertyValue"/>
																		</parameters>
																	</objectCreateExpression>
																</assignStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="list"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="urc"/>
																	</parameters>
																</methodInvokeExpression>
															</statements>
															<catch exceptionType="Exception"></catch>
														</tryStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="urc"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="urc"/>
																		</target>
																		<indices>
																			<variableReferenceExpression name="propertyName"/>
																		</indices>
																	</arrayIndexerExpression>
																	<variableReferenceExpression name="propertyValue"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="m"/>
													<methodInvokeExpression methodName="NextMatch">
														<target>
															<variableReferenceExpression name="m"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</statements>
										</whileStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="list"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IsMatch(HttpRequest) -->
						<memberMethod returnType="System.Boolean" name="IsMatch">
							<attributes public="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="IsMatch">
										<target>
											<fieldReferenceExpression name="uri"/>
										</target>
										<parameters>
											<propertyReferenceExpression name="Path">
												<argumentReferenceExpression name="request"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method RequiresAuthentication(HttpRequest, ControllerConfiguration) -->
						<memberMethod returnType="System.Boolean" name="RequiresAuthentication">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
								<parameter type="ControllerConfiguration" name="config"/>
							</parameters>
							<statements>
								<foreachStatement>
									<variable type="UriRestConfig" name="urc"/>
									<target>
										<methodInvokeExpression methodName="Enumerate">
											<parameters>
												<argumentReferenceExpression name="config"/>
											</parameters>
										</methodInvokeExpression>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<methodInvokeExpression methodName="IsMatch">
														<target>
															<variableReferenceExpression name="urc"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="request"/>
														</parameters>
													</methodInvokeExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="urc"/>
															</target>
															<indices>
																<primitiveExpression value="Users"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="?"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="false"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IsAuthorized(HttpRequest, ControllerConfiguration ) -->
						<memberMethod returnType="System.Boolean" name="IsAuthorized">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
								<parameter type="ControllerConfiguration" name="config"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<propertyReferenceExpression name="AcceptTypes">
												<argumentReferenceExpression name="request"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<foreachStatement>
									<variable type="UriRestConfig" name="urc"/>
									<target>
										<methodInvokeExpression methodName="Enumerate">
											<parameters>
												<argumentReferenceExpression name="config"/>
											</parameters>
										</methodInvokeExpression>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="IsMatch">
													<target>
														<variableReferenceExpression name="urc"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="request"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<comment>verify HTTP method</comment>
												<variableDeclarationStatement type="System.String" name="httpMethod">
													<init>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="urc"/>
															</target>
															<indices>
																<primitiveExpression value="Method"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="httpMethod"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.String[]"  name="methodList">
															<init>
																<methodInvokeExpression methodName="Split">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="httpMethod"/>
																		<primitiveExpression value="(\s*,\s*)"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="Contains">
																		<target>
																			<variableReferenceExpression name="methodList"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="HttpMethod">
																				<argumentReferenceExpression name="request"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodReturnStatement>
																	<primitiveExpression value="false"/>
																</methodReturnStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
												<comment>verify user identity</comment>
												<variableDeclarationStatement type="System.String" name="users">
													<init>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="urc"/>
															</target>
															<indices>
																<primitiveExpression value="Users"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="users"/>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="ValueInequality">
																<variableReferenceExpression name="users"/>
																<primitiveExpression value="?"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<propertyReferenceExpression name="IsAuthenticated">
																		<propertyReferenceExpression name="Identity">
																			<propertyReferenceExpression name="User">
																				<propertyReferenceExpression name="Current">
																					<typeReferenceExpression type="HttpContext"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodReturnStatement>
																	<primitiveExpression value="false"/>
																</methodReturnStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueInequality">
																	<variableReferenceExpression name="users"/>
																	<primitiveExpression value="*"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="System.String[]" name="userList">
																	<init>
																		<methodInvokeExpression methodName="Split">
																			<target>
																				<typeReferenceExpression type="Regex"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="users"/>
																				<primitiveExpression value="(\s*,\s*)"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="Contains">
																				<target>
																					<variableReferenceExpression name="userList"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="Name">
																						<propertyReferenceExpression name="Identity">
																							<propertyReferenceExpression name="User">
																								<propertyReferenceExpression name="Current">
																									<typeReferenceExpression type="HttpContext"/>
																								</propertyReferenceExpression>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodReturnStatement>
																			<primitiveExpression value="false"/>
																		</methodReturnStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
												<comment>verify user roles</comment>
												<variableDeclarationStatement type="System.String" name="roles">
													<init>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="urc"/>
															</target>
															<indices>
																<primitiveExpression value="Roles"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="roles"/>
															</unaryOperatorExpression>
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression methodName="UserIsInRole">
																	<target>
																		<typeReferenceExpression type="DataControllerBase"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="roles"/>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="false"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
												<comment>verify SSL, Xml, and JSON constrains</comment>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<methodInvokeExpression methodName="Equals">
																<target>
																	<methodInvokeExpression methodName="ToString">
																		<target>
																			<primitiveExpression value="true"/>
																		</target>
																	</methodInvokeExpression>
																</target>
																<parameters>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="urc"/>
																		</target>
																		<indices>
																			<primitiveExpression value="Ssl"/>
																		</indices>
																	</arrayIndexerExpression>
																	<propertyReferenceExpression name="OrdinalIgnoreCase">
																		<typeReferenceExpression type="StringComparison"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
															<unaryOperatorExpression operator="Not">
																<propertyReferenceExpression name="IsSecureConnection">
																	<argumentReferenceExpression name="request"/>
																</propertyReferenceExpression>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="false"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<methodInvokeExpression methodName="Equals">
																<target>
																	<methodInvokeExpression methodName="ToString">
																		<target>
																			<primitiveExpression value="false"/>
																		</target>
																	</methodInvokeExpression>
																</target>
																<parameters>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="urc"/>
																		</target>
																		<indices>
																			<primitiveExpression value="Xml"/>
																		</indices>
																	</arrayIndexerExpression>
																	<propertyReferenceExpression name="OrdinalIgnoreCase">
																		<typeReferenceExpression type="StringComparison"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression  methodName="IsJSONRequest">
																	<parameters>
																		<argumentReferenceExpression name="request"/>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="false"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<methodInvokeExpression methodName="Equals">
																<target>
																	<methodInvokeExpression methodName="ToString">
																		<target>
																			<primitiveExpression value="false"/>
																		</target>
																	</methodInvokeExpression>
																</target>
																<parameters>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="urc"/>
																		</target>
																		<indices>
																			<primitiveExpression value="Json"/>
																		</indices>
																	</arrayIndexerExpression>
																	<propertyReferenceExpression name="OrdinalIgnoreCase">
																		<typeReferenceExpression type="StringComparison"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression  methodName="IsJSONRequest">
																<parameters>
																	<argumentReferenceExpression name="request"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="false"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
												<methodReturnStatement>
													<primitiveExpression value="true"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- field SupportedJSONContentTypes -->
						<memberField type="System.String[]" name="SupportedJSONContentTypes">
							<attributes public="true" static="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<primitiveExpression value="application/json"/>
										<primitiveExpression value="text/javascript"/>
										<primitiveExpression value="application/javascript"/>
										<primitiveExpression value="application/ecmascript"/>
										<primitiveExpression value="application/x-ecmascript"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- method TypeOfJSONRequest(HttpRequest) -->
						<memberMethod returnType="System.String" name="TypeOfJSONRequest">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="BooleanOr">
												<binaryOperatorExpression operator="ValueEquality">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="QueryString">
																<argumentReferenceExpression name="request"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="_dataType"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="json"/>
												</binaryOperatorExpression>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="QueryString">
																<argumentReferenceExpression name="request"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="_instance"/>
														</indices>
													</arrayIndexerExpression>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<argumentReferenceExpression name="request"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="callback"/>
													</indices>
												</arrayIndexerExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="application/javascript"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="AcceptTypes">
												<argumentReferenceExpression name="request"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="System.String" name="t"/>
											<target>
												<propertyReferenceExpression name="AcceptTypes">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<variableDeclarationStatement type="System.Int32" name="typeIndex">
													<init>
														<methodInvokeExpression methodName="IndexOf">
															<target>
																<typeReferenceExpression type="Array"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="SupportedJSONContentTypes">
																	<typeReferenceExpression type="UriRestConfig"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="t"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueInequality">
															<variableReferenceExpression name="typeIndex"/>
															<primitiveExpression value="-1"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<variableReferenceExpression name="t"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IsJSONRequest(HttpRequest) -->
						<memberMethod returnType="System.Boolean" name="IsJSONRequest">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<unaryOperatorExpression operator="IsNotNullOrEmpty">
										<methodInvokeExpression methodName="TypeOfJSONRequest">
											<parameters>
												<argumentReferenceExpression name="request"/>
											</parameters>
										</methodInvokeExpression>
									</unaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IsJSONPRequest(HttpRequest) -->
						<memberMethod returnType="System.Boolean" name="IsJSONPRequest">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="t">
									<init>
										<methodInvokeExpression methodName="TypeOfJSONRequest">
											<parameters>
												<argumentReferenceExpression name="request"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanAnd">
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="t"/>
										</unaryOperatorExpression>
										<binaryOperatorExpression operator="ValueInequality">
											<variableReferenceExpression name="t"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="SupportedJSONContentTypes"/>
												</target>
												<indices>
													<primitiveExpression value="0"/>
												</indices>
											</arrayIndexerExpression>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class EnterpriseApplicationServices -->
				<typeDeclaration name="RepresentationalStateTransfer" isPartial="true">
					<baseTypes>
						<typeReference type="RepresentationalStateTransferBase"/>
					</baseTypes>
				</typeDeclaration>
				<!-- class EnterpriseApplicationServicesBase -->
				<typeDeclaration name="RepresentationalStateTransferBase">
					<baseTypes>
						<typeReference type="System.Object"/>
						<typeReference type="IHttpHandler"/>
						<typeReference type="System.Web.SessionState.IRequiresSessionState"/>
					</baseTypes>
					<members>
						<!-- field JsonDateRegex -->
						<memberField type="Regex" name="JsonDateRegex">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression>
											<!-- @"""\\/Date\((\-?\d+)\)\\/""" -->
											<xsl:attribute name="value"><![CDATA["\\/Date\((\-?\d+)\)\\/"]]></xsl:attribute>
										</primitiveExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<memberField type="Regex" name="ScriptResourceRegex">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression>
											<!-- ^(?'ScriptName'[\w\-]+?)(\-(?'Version'[\.\d]+))?(\.(?'Culture'[\w\-]+?))?\.js -->
											<xsl:attribute name="value"><![CDATA[^(?'ScriptName'[\w\-]+?)(\-(?'Version'[\.\d]+))?(\.(?'Culture'[\w\-]+?))?(\.(?'Accent'\w+))?\.(?'Extension'js|css)]]></xsl:attribute>
										</primitiveExpression>
										<propertyReferenceExpression name="IgnoreCase">
											<typeReferenceExpression type="RegexOptions"/>
										</propertyReferenceExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<memberField type="Regex" name="CultureJavaScriptRegex">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression>
											<!-- //<\!\[CDATA\[\s+(?'JavaScript'var __cultureInfo[\s\S]*?)//\]\]> -->
											<xsl:attribute name="value"><![CDATA[//<\!\[CDATA\[\s+(?'JavaScript'var __cultureInfo[\s\S]*?)//\]\]>]]></xsl:attribute>
										</primitiveExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- IHttpHandler.IsReusable -->
						<memberProperty type="System.Boolean" name="IsReusable" privateImplementationType="IHttpHandler">
							<attributes public="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- IHttpHandler.ProcessRequest(HttpContect) -->
						<memberMethod name="ProcessRequest" privateImplementationType="IHttpHandler">
							<attributes public="true" />
							<parameters>
								<parameter type="HttpContext" name="context"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="Initialize">
									<target>
										<typeReferenceExpression type="CultureManager"/>
									</target>
								</methodInvokeExpression>
								<variableDeclarationStatement type="RouteValueDictionary" name="routeValues">
									<init>
										<propertyReferenceExpression name="Values">
											<propertyReferenceExpression name="RouteData">
												<propertyReferenceExpression name="RequestContext">
													<propertyReferenceExpression name="Request">
														<argumentReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="controllerName">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="routeValues"/>
												</target>
												<indices>
													<primitiveExpression value="Controller"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="controllerName"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="controllerName"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="QueryString">
														<propertyReferenceExpression name="Request">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="_controller"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="Stream" name="output">
									<init>
										<propertyReferenceExpression name="OutputStream">
											<propertyReferenceExpression name="Response">
												<argumentReferenceExpression name="context"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="contentType">
									<init>
										<primitiveExpression value="text/xml"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Boolean" name="json">
									<init>
										<methodInvokeExpression methodName="IsJSONRequest">
											<target>
												<typeReferenceExpression type="UriRestConfig"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Request">
													<argumentReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<variableReferenceExpression name="json"/>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="contentType"/>
											<binaryOperatorExpression operator="Add">
												<methodInvokeExpression methodName="TypeOfJSONRequest">
													<target>
														<typeReferenceExpression type="UriRestConfig"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Request">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<primitiveExpression value="; charset=utf-8"/>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="ContentType">
										<propertyReferenceExpression name="Response">
											<argumentReferenceExpression name="context"/>
										</propertyReferenceExpression>
									</propertyReferenceExpression>
									<variableReferenceExpression name="contentType"/>
								</assignStatement>
								<tryStatement>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="controllerName"/>
													<primitiveExpression value="saas"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<xsl:choose>
													<xsl:when test="$MembershipEnabled='true' or $CustomSecurity='true'">
														<variableDeclarationStatement type="System.String" name="service">
															<init>
																<castExpression targetType="System.String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="routeValues"/>
																		</target>
																		<indices>
																			<primitiveExpression value="Segment1"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="OAuthHandler" name="handler">
															<init>
																<methodInvokeExpression methodName="Create">
																	<target>
																		<typeReferenceExpression type="OAuthHandlerFactory"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="service"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="handler"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="ProcessRequest">
																	<target>
																		<variableReferenceExpression name="handler"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="context"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</xsl:when>
													<xsl:otherwise>
														<assignStatement>
															<propertyReferenceExpression name="StatusCode">
																<propertyReferenceExpression name="Response">
																	<variableReferenceExpression name="context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<primitiveExpression value="404"/>
														</assignStatement>
													</xsl:otherwise>
												</xsl:choose>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="controllerName"/>
															<primitiveExpression value="_authenticate"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="AuthenticateSaaS">
															<parameters>
																<argumentReferenceExpression name="context"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<variableDeclarationStatement type="Match" name="script">
															<init>
																<methodInvokeExpression methodName="Match">
																	<target>
																		<propertyReferenceExpression name="ScriptResourceRegex"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="controllerName"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="scriptName">
															<init>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="script"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="ScriptName"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Boolean" name="isSaaS">
															<init>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="scriptName"/>
																	<primitiveExpression value="factory"/>
																</binaryOperatorExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Boolean" name="isCombinedScript">
															<init>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="scriptName"/>
																	<primitiveExpression value="combined"/>
																</binaryOperatorExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Boolean" name="isStylesheet">
															<init>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="scriptName"/>
																	<primitiveExpression value="stylesheet"/>
																</binaryOperatorExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="BooleanOr">
																		<variableReferenceExpression name="isStylesheet"/>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="scriptName"/>
																			<primitiveExpression value="touch-theme"/>
																		</binaryOperatorExpression>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="ValueEquality">
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="script"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="Extension"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																		<primitiveExpression value="css"/>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="ContentType">
																		<propertyReferenceExpression name="Response">
																			<variableReferenceExpression name="context"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																	<primitiveExpression value="text/css; charset=utf-8"/>
																</assignStatement>
																<variableDeclarationStatement name="cacheDuration">
																	<init>
																		<binaryOperatorExpression operator="Multiply">
																			<binaryOperatorExpression operator="Multiply">
																				<primitiveExpression value="60"/>
																				<primitiveExpression value="60"/>
																			</binaryOperatorExpression>
																			<primitiveExpression value="24"/>
																		</binaryOperatorExpression>
																	</init>
																</variableDeclarationStatement>
																<methodInvokeExpression methodName="SetMaxAge">
																	<target>
																		<propertyReferenceExpression name="Cache">
																			<propertyReferenceExpression name="Response">
																				<argumentReferenceExpression name="context"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="FromSeconds">
																			<target>
																				<typeReferenceExpression type="TimeSpan"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="cacheDuration"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
																<variableDeclarationStatement type="System.String" name="css">
																	<init>
																		<stringEmptyExpression/>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<variableReferenceExpression name="isStylesheet"/>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="css"/>
																			<methodInvokeExpression methodName="CombineTouchUIStylesheets">
																				<target>
																					<typeReferenceExpression type="ApplicationServices"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="context"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<variableReferenceExpression name="css"/>
																			<methodInvokeExpression methodName="Compile">
																				<target>
																					<typeReferenceExpression type="StylesheetGenerator"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="controllerName"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="CompressOutput">
																	<target>
																		<typeReferenceExpression type="ApplicationServices"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="context"/>
																		<variableReferenceExpression name="css"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<binaryOperatorExpression operator="BooleanOr">
																				<variableReferenceExpression name="isSaaS"/>
																				<variableReferenceExpression name="isCombinedScript"/>
																			</binaryOperatorExpression>
																			<binaryOperatorExpression operator="ValueEquality">
																				<propertyReferenceExpression name="HttpMethod"/>
																				<primitiveExpression value="GET"/>
																			</binaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="CombineScripts">
																			<parameters>
																				<argumentReferenceExpression name="context"/>
																				<variableReferenceExpression name="isSaaS"/>
																				<variableReferenceExpression name="scriptName"/>
																				<propertyReferenceExpression name="Value">
																					<arrayIndexerExpression>
																						<target>
																							<propertyReferenceExpression name="Groups">
																								<variableReferenceExpression name="script"/>
																							</propertyReferenceExpression>
																						</target>
																						<indices>
																							<primitiveExpression value="Culture"/>
																						</indices>
																					</arrayIndexerExpression>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="Value">
																					<arrayIndexerExpression>
																						<target>
																							<propertyReferenceExpression name="Groups">
																								<variableReferenceExpression name="script"/>
																							</propertyReferenceExpression>
																						</target>
																						<indices>
																							<primitiveExpression value="Version"/>
																						</indices>
																					</arrayIndexerExpression>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="IsMatch">
																					<target>
																						<typeReferenceExpression type="Regex"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="HttpMethod"/>
																						<primitiveExpression value="^(GET|POST|DELETE|PUT)$"/>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="PerformRequest">
																					<parameters>
																						<argumentReferenceExpression name="context"/>
																						<variableReferenceExpression name="output"/>
																						<variableReferenceExpression name="json"/>
																						<variableReferenceExpression name="controllerName"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																			<falseStatements>
																				<assignStatement>
																					<propertyReferenceExpression name="StatusCode">
																						<propertyReferenceExpression name="Response">
																							<argumentReferenceExpression name="context"/>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																					<primitiveExpression value="400"/>
																				</assignStatement>
																			</falseStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</statements>
									<catch exceptionType="Exception" localName="er">
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueInequality">
													<propertyReferenceExpression name="StatusCode">
														<propertyReferenceExpression name="Response">
															<variableReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="302"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="ContentType">
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="text/xml"/>
												</assignStatement>
												<methodInvokeExpression methodName="Clear">
													<target>
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</target>
												</methodInvokeExpression>
												<variableDeclarationStatement type="XmlWriter" name="writer">
													<init>
														<methodInvokeExpression methodName="CreateXmlWriter">
															<parameters>
																<variableReferenceExpression name="output"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="RenderException">
													<parameters>
														<argumentReferenceExpression name="context"/>
														<variableReferenceExpression name="er"/>
														<variableReferenceExpression name="writer"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Close">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
												</methodInvokeExpression>
												<assignStatement>
													<propertyReferenceExpression name="StatusCode">
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="400"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</catch>
								</tryStatement>
							</statements>
						</memberMethod>
						<!-- method CombineScripts(HttpContext, bool, string, string) -->
						<memberMethod name="CombineScripts">
							<attributes family="true"/>
							<parameters>
								<parameter type="HttpContext" name="context"/>
								<parameter type="System.Boolean" name="isSaaS"/>
								<parameter type="System.String" name="scriptName"/>
								<parameter type="System.String" name="culture"/>
								<parameter type="System.String" name="version"/>
							</parameters>
							<statements>
								<xsl:call-template name="DeclareRequestAndResponse"/>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<argumentReferenceExpression name="isSaaS"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>

										<variableDeclarationStatement type="HttpCachePolicy" name="cache">
											<init>
												<propertyReferenceExpression name="Cache">
													<variableReferenceExpression name="response"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="SetCacheability">
											<target>
												<variableReferenceExpression name="cache"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Public">
													<typeReferenceExpression type="HttpCacheability"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="VaryByParams">
														<variableReferenceExpression name="cache"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="_touch"/>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="true"/>
										</assignStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="VaryByHeaders">
														<variableReferenceExpression name="cache"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="User-Agent"/>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="true"/>
										</assignStatement>
										<methodInvokeExpression methodName="SetOmitVaryStar">
											<target>
												<variableReferenceExpression name="cache"/>
											</target>
											<parameters>
												<primitiveExpression value="true"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="SetExpires">
											<target>
												<variableReferenceExpression name="cache"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="AddDays">
													<target>
														<propertyReferenceExpression name="Now">
															<typeReferenceExpression type="DateTime"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="365"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="SetValidUntilExpires">
											<target>
												<variableReferenceExpression name="cache"/>
											</target>
											<parameters>
												<primitiveExpression value="true"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="SetLastModifiedFromFileDependencies">
											<target>
												<variableReferenceExpression name="cache"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<argumentReferenceExpression name="isSaaS"/>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<argumentReferenceExpression name="culture"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<tryStatement>
													<statements>
														<assignStatement>
															<propertyReferenceExpression name="CurrentCulture">
																<propertyReferenceExpression name="CurrentThread">
																	<typeReferenceExpression type="Thread"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<objectCreateExpression type="CultureInfo">
																<parameters>
																	<argumentReferenceExpression name="culture"/>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="CurrentUICulture">
																<propertyReferenceExpression name="CurrentThread">
																	<typeReferenceExpression type="Thread"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<objectCreateExpression type="CultureInfo">
																<parameters>
																	<argumentReferenceExpression name="culture"/>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
													</statements>
													<catch exceptionType="Exception"></catch>
												</tryStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="StringBuilder" name="sb">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="baseUrl">
									<init>
										<stringFormatExpression format="{{0}}://{{1}}{{2}}">
											<propertyReferenceExpression name="Scheme">
												<propertyReferenceExpression name="Url">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="Authority">
												<propertyReferenceExpression name="Url">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="ApplicationPath">
												<variableReferenceExpression name="request"/>
											</propertyReferenceExpression>
										</stringFormatExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="List" name="scripts">
									<typeArguments>
										<typeReference type="ScriptReference"/>
									</typeArguments>
									<init>
										<methodInvokeExpression methodName="StandardScripts">
											<target>
												<typeReferenceExpression type="AquariumExtenderBase"/>
											</target>
											<parameters>
												<primitiveExpression value="true"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="ScriptReference" name="sr"/>
									<target>
										<variableReferenceExpression name="scripts"/>
									</target>
									<statements>
										<variableDeclarationStatement type="System.Boolean" name="add">
											<init>
												<primitiveExpression value="true"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="path">
											<init>
												<propertyReferenceExpression name="Path">
													<variableReferenceExpression name="sr"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Int32" name="index">
											<init>
												<methodInvokeExpression methodName="IndexOf">
													<target>
														<variableReferenceExpression name="path"/>
													</target>
													<parameters>
														<primitiveExpression value="?"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<variableReferenceExpression name="index"/>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="path"/>
													<methodInvokeExpression methodName="Substring">
														<target>
															<variableReferenceExpression name="path"/>
														</target>
														<parameters>
															<primitiveExpression value="0"/>
															<variableReferenceExpression name="index"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="EndsWith">
															<target>
																<variableReferenceExpression name="path"/>
															</target>
															<parameters>
																<primitiveExpression value="_System.js"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="add"/>
															<binaryOperatorExpression operator="ValueInequality">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="QueryString">
																			<variableReferenceExpression name="request"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="jquery"/>
																	</indices>
																</arrayIndexerExpression>
																<primitiveExpression value="false" convertTo="String"/>
															</binaryOperatorExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<methodInvokeExpression methodName="Contains">
																		<target>
																			<variableReferenceExpression name="path"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="daf-membership"/>
																		</parameters>
																	</methodInvokeExpression>
																	<unaryOperatorExpression operator="Not">
																		<propertyReferenceExpression name="AuthorizationIsSupported">
																			<typeReferenceExpression type="ApplicationServicesBase"/>
																		</propertyReferenceExpression>
																	</unaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="add"/>
																	<primitiveExpression value="false"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<variableReferenceExpression name="add"/>
											</condition>
											<trueStatements>
												<tryStatement>
													<statements>
														<variableDeclarationStatement type="System.String" name="script"/>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="Equals">
																	<target>
																		<variableReferenceExpression name="path"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="~/js/daf/add.min.js"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="script"/>
																	<methodInvokeExpression methodName="AddScripts">
																		<target>
																			<propertyReferenceExpression name="Current">
																				<typeReferenceExpression type="ApplicationServices"/>
																			</propertyReferenceExpression>
																		</target>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNullOrEmpty">
																			<variableReferenceExpression name="path"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="script"/>
																			<methodInvokeExpression methodName="ReadToEnd">
																				<target>
																					<objectCreateExpression type="StreamReader">
																						<parameters>
																							<methodInvokeExpression methodName="GetManifestResourceStream">
																								<target>
																									<propertyReferenceExpression name="Assembly">
																										<methodInvokeExpression methodName="GetType"/>
																									</propertyReferenceExpression>
																								</target>
																								<parameters>
																									<propertyReferenceExpression name="Name">
																										<variableReferenceExpression name="sr"/>
																									</propertyReferenceExpression>
																								</parameters>
																							</methodInvokeExpression>
																						</parameters>
																					</objectCreateExpression>
																				</target>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<variableReferenceExpression name="script"/>
																			<methodInvokeExpression methodName="ReadAllText">
																				<target>
																					<typeReferenceExpression type="File"/>
																				</target>
																				<parameters>
																					<methodInvokeExpression methodName="MapPath">
																						<target>
																							<propertyReferenceExpression name="Server">
																								<argumentReferenceExpression name="context"/>
																							</propertyReferenceExpression>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="path"/>
																						</parameters>
																					</methodInvokeExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
														<assignStatement>
															<variableReferenceExpression name="script"/>
															<methodInvokeExpression methodName="Replace">
																<target>
																	<variableReferenceExpression name="script"/>
																</target>
																<parameters>
																	<primitiveExpression value=" sourceMappingURL="/>
																	<primitiveExpression value=" sourceMappingURL=../js/"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<methodInvokeExpression methodName="AppendLine">
															<target>
																<variableReferenceExpression name="sb"/>
															</target>
															<parameters>
																<variableReferenceExpression name="script"/>
															</parameters>
														</methodInvokeExpression>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="EndsWith">
																		<target>
																			<variableReferenceExpression name="script"/>
																		</target>
																		<parameters>
																			<primitiveExpression value=";"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Append">
																	<target>
																		<variableReferenceExpression name="sb"/>
																	</target>
																	<parameters>
																		<primitiveExpression value=";"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</statements>
													<catch exceptionType="Exception" localName="ex">
														<methodInvokeExpression methodName="AppendFormat">
															<target>
																<variableReferenceExpression name="sb"/>
															</target>
															<parameters>
																<primitiveExpression value="alert('{{0}}');"/>
																<methodInvokeExpression methodName="JavaScriptString">
																	<target>
																		<typeReferenceExpression type="BusinessRules"/>
																	</target>
																	<parameters>
																		<stringFormatExpression format="Unable to load {{0}}{{1}}:&#10;&#10;{{2}}">
																			<variableReferenceExpression name="path"/>
																			<propertyReferenceExpression name="Name">
																				<variableReferenceExpression name="sr"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="Message">
																				<variableReferenceExpression name="ex"/>
																			</propertyReferenceExpression>
																		</stringFormatExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</catch>
												</tryStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<argumentReferenceExpression name="isSaaS"/>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsTouchClient">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="AppendFormat">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<!--<primitiveExpression value="$('&lt;link>&lt;/link>').appendTo($('head')).attr({{{{ href: '{{0}}/mobile//jquery.mobile-{$jQueryMobileVersion}.min.css', type: 'text/css', rel: 'stylesheet' }}}});"/>-->
														<primitiveExpression value="$('&lt;link>&lt;/link>').appendTo($('head')).attr({{{{ href: '{{0}}/css//daf/touch-core.min.css', type: 'text/css', rel: 'stylesheet' }}}});"/>
														<variableReferenceExpression name="baseUrl"/>
														<!--<propertyReferenceExpression name="JqmVersion">
                              <typeReferenceExpression type="ApplicationServices"/>
                            </propertyReferenceExpression>-->
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="AppendFormat">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<stringFormatExpression format="$('&lt;link>&lt;/link>').appendTo($('head')).attr({{{{ href: '{{0}}/App_Themes/{$Namespace}/_Theme_{a:project/a:theme/@name}.css?{{0}}', type: 'text/css', rel: 'stylesheet' }}}});">
															<propertyReferenceExpression name="Version">
																<typeReferenceExpression type="ApplicationServices"/>
															</propertyReferenceExpression>
														</stringFormatExpression>
														<variableReferenceExpression name="baseUrl"/>
													</parameters>
												</methodInvokeExpression>
											</falseStatements>
										</conditionStatement>
										<tryStatement>
											<statements>
												<variableDeclarationStatement type="StringBuilder" name="blankPage">
													<init>
														<objectCreateExpression type="StringBuilder"/>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="StringWriter" name="sw">
													<init>
														<objectCreateExpression type="StringWriter">
															<parameters>
																<variableReferenceExpression name="blankPage"/>
															</parameters>
														</objectCreateExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="Execute">
													<target>
														<propertyReferenceExpression name="Server">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="~/default.aspx?_page=_blank"/>
														<variableReferenceExpression name="sw"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Flush">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Close">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
												</methodInvokeExpression>
												<variableDeclarationStatement type="Match" name="cultureJS">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<propertyReferenceExpression name="CultureJavaScriptRegex"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<variableReferenceExpression name="blankPage"/>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="Success">
															<variableReferenceExpression name="cultureJS"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="AppendLine">
															<target>
																<variableReferenceExpression name="sb"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="cultureJS"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="JavaScript"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="AppendLine">
															<target>
																<variableReferenceExpression name="sb"/>
															</target>
															<parameters>
																<primitiveExpression value="Sys.CultureInfo.CurrentCulture=__cultureInfo;"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
											<catch exceptionType="Exception">
											</catch>
										</tryStatement>
										<methodInvokeExpression methodName="AppendFormat">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression>
													<xsl:attribute name="value">
														<xsl:text>var __targetFramework='</xsl:text>
														<xsl:value-of select="a:project/@targetFramework"/>
														<xsl:text>';__tf=4.0;__cothost='appfactory';</xsl:text>
														<xsl:text>__appInfo='</xsl:text>
														<xsl:value-of select="a:project/@name"/>
														<xsl:text>|{0}';</xsl:text>
													</xsl:attribute>
												</primitiveExpression>
												<methodInvokeExpression methodName="JavaScriptString">
													<target>
														<typeReferenceExpression type="BusinessRules"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Name">
															<propertyReferenceExpression name="Identity">
																<propertyReferenceExpression name="User">
																	<variableReferenceExpression name="context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendFormat">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[Sys.Application.add_init(function() {{ Web.DataView._run('{0}','{0}/Services/DataControllerService.asmx', {1}) }});]]></xsl:attribute>
												</primitiveExpression>
												<variableReferenceExpression name="baseUrl"/>
												<methodInvokeExpression methodName="ToLower">
													<target>
														<methodInvokeExpression methodName="ToString">
															<target>
																<propertyReferenceExpression name="IsAuthenticated">
																	<propertyReferenceExpression name="Identity">
																		<propertyReferenceExpression name="User">
																			<argumentReferenceExpression name="context"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
														</methodInvokeExpression>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="ContentType">
										<propertyReferenceExpression name="Response">
											<argumentReferenceExpression name="context"/>
										</propertyReferenceExpression>
									</propertyReferenceExpression>
									<primitiveExpression value="application/javascript; charset=utf-8"/>
								</assignStatement>
								<methodInvokeExpression methodName="CompressOutput">
									<target>
										<typeReferenceExpression type="ApplicationServices"/>
									</target>
									<parameters>
										<argumentReferenceExpression name="context"/>
										<methodInvokeExpression methodName="ToString">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method AuthenticateSaaS(HttpContext) -->
						<memberMethod name="AuthenticateSaaS">
							<attributes family="true"/>
							<parameters>
								<parameter type="HttpContext" name="context"/>
							</parameters>
							<statements>
								<xsl:call-template name="DeclareRequestAndResponse"/>
								<variableDeclarationStatement type="System.String" name="args">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Params">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="args"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="StringBuilder" name="result">
									<init>
										<objectCreateExpression type="StringBuilder">
											<parameters>
												<stringFormatExpression format="{{0}}(">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="QueryString">
																<variableReferenceExpression name="request"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="callback"/>
														</indices>
													</arrayIndexerExpression>
												</stringFormatExpression>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Object" name="resultObject" var="false">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String[]" name="login">
									<init>
										<methodInvokeExpression methodName="DeserializeObject">
											<typeArguments>
												<typeReference type="System.String[]"/>
											</typeArguments>
											<target>
												<typeReferenceExpression type="JsonConvert"/>
											</target>
											<parameters>
												<variableReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<variableReferenceExpression name="resultObject"/>
									<methodInvokeExpression methodName="Login">
										<target>
											<typeReferenceExpression type="ApplicationServices"/>
										</target>
										<parameters>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="login"/>
													</target>
													<indices>
														<primitiveExpression value="0"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="login"/>
													</target>
													<indices>
														<primitiveExpression value="1"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
											<primitiveExpression value="false"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<methodInvokeExpression methodName="Append">
									<target>
										<variableReferenceExpression name="result"/>
									</target>
									<parameters>
										<methodInvokeExpression methodName="SerializeObject">
											<target>
												<typeReferenceExpression type="JsonConvert"/>
											</target>
											<parameters>
												<variableReferenceExpression name="resultObject"/>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Append">
									<target>
										<variableReferenceExpression name="result"/>
									</target>
									<parameters>
										<primitiveExpression value=")"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="System.String" name="jsonp">
									<init>
										<methodInvokeExpression methodName="ToString">
											<target>
												<variableReferenceExpression name="result"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Write">
									<target>
										<variableReferenceExpression name="response"/>
									</target>
									<parameters>
										<variableReferenceExpression name="jsonp"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method DoReplaceDateTicks(Match) -->
						<memberMethod returnType="System.String" name="DoReplaceDateTicks">
							<attributes final="true" private="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<stringFormatExpression format="new Date({{0}})">
										<propertyReferenceExpression name="Value">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Groups">
														<argumentReferenceExpression name="m"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="1"/>
												</indices>
											</arrayIndexerExpression>
										</propertyReferenceExpression>
									</stringFormatExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateXmlWriter(Stream) -->
						<memberMethod returnType="XmlWriter" name="CreateXmlWriter">
							<attributes assembly="true"/>
							<parameters>
								<parameter type="Stream" name="output"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="XmlWriterSettings" name="settings">
									<init>
										<objectCreateExpression type="XmlWriterSettings"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="CloseOutput">
										<variableReferenceExpression name="settings"/>
									</propertyReferenceExpression>
									<primitiveExpression value="false"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Indent">
										<variableReferenceExpression name="settings"/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<variableDeclarationStatement type="XmlWriter" name="writer">
									<init>
										<methodInvokeExpression methodName="Create">
											<target>
												<typeReferenceExpression type="XmlWriter"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="output"/>
												<variableReferenceExpression name="settings"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="writer"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method RenderException(HttpContext, Exception, XmlWriter -->
						<memberMethod name="RenderException">
							<attributes assembly="true"/>
							<parameters>
								<parameter type="HttpContext" name="context"/>
								<parameter type="Exception" name="er"/>
								<parameter type="XmlWriter" name="writer"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<argumentReferenceExpression name="er"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="error"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteElementString">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="message"/>
												<propertyReferenceExpression name="Message">
													<argumentReferenceExpression name="er"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteElementString">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="type"/>
												<methodInvokeExpression methodName="ToString">
													<target>
														<methodInvokeExpression methodName="GetType">
															<target>
																<argumentReferenceExpression name="er"/>
															</target>
														</methodInvokeExpression>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="UserHostName">
														<propertyReferenceExpression name="Request">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="::1"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="WriteStartElement">
													<target>
														<argumentReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value="stackTrace"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteCData">
													<target>
														<argumentReferenceExpression name="writer"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="StackTrace">
															<argumentReferenceExpression name="er"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteEndElement">
													<target>
														<argumentReferenceExpression name="writer"/>
													</target>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="RenderException">
													<parameters>
														<argumentReferenceExpression name="context"/>
														<propertyReferenceExpression name="InnerException">
															<argumentReferenceExpression name="er"/>
														</propertyReferenceExpression>
														<argumentReferenceExpression name="writer"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method SelectView(ControllerConfiguration, string) -->
						<memberMethod returnType="XPathNavigator" name="SelectView">
							<attributes final="true" family="true"/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
								<parameter type="System.String" name="viewId"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="SelectSingleNode">
										<target>
											<argumentReferenceExpression name="config"/>
										</target>
										<parameters>
											<primitiveExpression value="/c:dataController/c:views/c:view[@id='{{0}}']"/>
											<argumentReferenceExpression name="viewId"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SelectDataField(ControllerConfiguration, string, string) -->
						<memberMethod returnType="XPathNavigator" name="SelectDataField">
							<attributes final="true" family="true"/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
								<parameter type="System.String" name="viewId"/>
								<parameter type="System.String" name="fieldName"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="SelectSingleNode">
										<target>
											<argumentReferenceExpression name="config"/>
										</target>
										<parameters>
											<primitiveExpression value="/c:dataController/c:views/c:view[@id='{{0}}']/.//c:dataField[@fieldName='{{1}}' or @aliasFieldName='{{1}}']"/>
											<argumentReferenceExpression name="viewId"/>
											<argumentReferenceExpression name="fieldName"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SelectField(ControllerConfiguration, string) -->
						<memberMethod returnType="XPathNavigator" name="SelectField">
							<attributes final="true" family="true"/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="SelectSingleNode">
										<target>
											<argumentReferenceExpression name="config"/>
										</target>
										<parameters>
											<primitiveExpression value="/c:dataController/c:fields/c:field[@name='{{0}}']"/>
											<argumentReferenceExpression name="name"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SelectActionGroup(ControllerConfiguration, string) -->
						<memberMethod returnType="XPathNavigator" name="SelectActionGroup">
							<attributes final="true" family="true"/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
								<parameter type="System.String" name="actionGroupId"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="SelectSingleNode">
										<target>
											<argumentReferenceExpression name="config"/>
										</target>
										<parameters>
											<primitiveExpression value="/c:dataController/c:actions/c:actionGroup[@id='{{0}}']"/>
											<argumentReferenceExpression name="actionGroupId"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SelectAction(ControllerConfiguration, string, string) -->
						<memberMethod returnType="XPathNavigator" name="SelectAction">
							<attributes final="true" family="true"/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
								<parameter type="System.String" name="actionGroupId"/>
								<parameter type="System.String" name="actionId"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="SelectSingleNode">
										<target>
											<argumentReferenceExpression name="config"/>
										</target>
										<parameters>
											<primitiveExpression value="/c:dataController/c:actions/c:actionGroup[@id='{{0}}']/c:action[@id='{{1}}']"/>
											<argumentReferenceExpression name="actionGroupId"/>
											<argumentReferenceExpression name="actionId"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method VerifyActionSegments(ControllerConfiguration, string, string, bool) -->
						<memberMethod returnType="System.Boolean" name="VerifyActionSegments">
							<attributes private="true"/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
								<parameter type="System.String" name="actionGroupId"/>
								<parameter type="System.String" name="actionId"/>
								<parameter type="System.Boolean" name="keyIsAvailable"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Boolean" name="result">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<methodInvokeExpression methodName="SelectActionGroup">
												<parameters>
													<argumentReferenceExpression name="config"/>
													<argumentReferenceExpression name="actionGroupId"/>
												</parameters>
											</methodInvokeExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="XPathNavigator" name="actionNode">
											<init>
												<methodInvokeExpression methodName="SelectAction">
													<parameters>
														<argumentReferenceExpression name="config"/>
														<argumentReferenceExpression name="actionGroupId"/>
														<argumentReferenceExpression name="actionId"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="actionNode"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="result"/>
													<primitiveExpression value="false"/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="Not">
																<argumentReferenceExpression name="keyIsAvailable"/>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanOr">
																<binaryOperatorExpression operator="ValueEquality">
																	<methodInvokeExpression methodName="GetAttribute">
																		<target>
																			<variableReferenceExpression name="actionNode"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="whenKeySelected"/>
																			<stringEmptyExpression/>
																		</parameters>
																	</methodInvokeExpression>
																	<primitiveExpression value="true" convertTo="String"/>
																</binaryOperatorExpression>
																<methodInvokeExpression methodName="IsMatch">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="GetAttribute">
																			<target>
																				<variableReferenceExpression name="actionNode"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="commandName"/>
																				<stringEmptyExpression/>
																			</parameters>
																		</methodInvokeExpression>
																		<primitiveExpression value="^(Update|Delete)$"/>
																	</parameters>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="result"/>
															<primitiveExpression value="false"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<variableReferenceExpression name="result"/>
											<primitiveExpression value="false"/>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AnalyzeRouteValues(HttpRequest, HttpResponse, bool, ControllerConfiguration, out string, out strig, out string, out string, out string, out string) -->
						<memberMethod name="AnalyzeRouteValues">
							<attributes private="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
								<parameter type="HttpResponse" name="response"/>
								<parameter type="System.Boolean" name="isHttpGetMethod"/>
								<parameter type="ControllerConfiguration" name="config"/>
								<parameter type="System.String" name="view" direction="Out"/>
								<parameter type="System.String" name="key" direction="Out"/>
								<parameter type="System.String" name="fieldName" direction="Out"/>
								<parameter type="System.String" name="actionGroupId" direction="Out"/>
								<parameter type="System.String" name="actionId" direction="Out"/>
								<parameter type="System.String" name="commandName" direction="Out"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="RouteValueDictionary" name="routeValues">
									<init>
										<propertyReferenceExpression name="Values">
											<propertyReferenceExpression name="RouteData">
												<propertyReferenceExpression name="RequestContext">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="segment1">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="routeValues"/>
												</target>
												<indices>
													<primitiveExpression value="Segment1"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="segment2">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="routeValues"/>
												</target>
												<indices>
													<primitiveExpression value="Segment2"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="segment3">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="routeValues"/>
												</target>
												<indices>
													<primitiveExpression value="Segment3"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="segment4">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="routeValues"/>
												</target>
												<indices>
													<primitiveExpression value="Segment4"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<variableReferenceExpression name="view"/>
									<primitiveExpression value="null"/>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="key"/>
									<primitiveExpression value="null"/>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="fieldName"/>
									<primitiveExpression value="null"/>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="actionGroupId"/>
									<primitiveExpression value="null"/>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="actionId"/>
									<primitiveExpression value="null"/>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="commandName"/>
									<primitiveExpression value="null"/>
								</assignStatement>

								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="segment1"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<methodInvokeExpression methodName="SelectView">
														<parameters>
															<argumentReferenceExpression name="config"/>
															<variableReferenceExpression name="segment1"/>
														</parameters>
													</methodInvokeExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="view"/>
													<variableReferenceExpression name="segment1"/>
												</assignStatement>
												<conditionStatement>
													<condition>
														<argumentReferenceExpression name="isHttpGetMethod"/>
													</condition>
													<trueStatements>
														<assignStatement>
															<argumentReferenceExpression name="key"/>
															<variableReferenceExpression name="segment2"/>
														</assignStatement>
														<assignStatement>
															<argumentReferenceExpression name="fieldName"/>
															<variableReferenceExpression name="segment3"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="VerifyActionSegments">
																	<parameters>
																		<argumentReferenceExpression name="config"/>
																		<variableReferenceExpression name="segment2"/>
																		<variableReferenceExpression name="segment3"/>
																		<primitiveExpression value="false"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<argumentReferenceExpression name="actionGroupId"/>
																	<variableReferenceExpression name="segment2"/>
																</assignStatement>
																<assignStatement>
																	<argumentReferenceExpression name="actionId"/>
																	<variableReferenceExpression name="segment3"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNullOrEmpty">
																			<variableReferenceExpression name="segment2"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueInequality">
																					<propertyReferenceExpression name="HttpMethod"/>
																					<primitiveExpression value="POST"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<propertyReferenceExpression name="StatusCode">
																						<argumentReferenceExpression name="response"/>
																					</propertyReferenceExpression>
																					<primitiveExpression value="404"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<argumentReferenceExpression name="key"/>
																			<variableReferenceExpression name="segment2"/>
																		</assignStatement>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="VerifyActionSegments">
																					<parameters>
																						<argumentReferenceExpression name="config"/>
																						<variableReferenceExpression name="segment3"/>
																						<variableReferenceExpression name="segment4"/>
																						<primitiveExpression value="true"/>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<argumentReferenceExpression name="actionGroupId"/>
																					<variableReferenceExpression name="segment3"/>
																				</assignStatement>
																				<assignStatement>
																					<variableReferenceExpression name="actionId"/>
																					<variableReferenceExpression name="segment4"/>
																				</assignStatement>
																			</trueStatements>
																			<falseStatements>
																				<conditionStatement>
																					<condition>
																						<unaryOperatorExpression operator="Not">
																							<binaryOperatorExpression operator="BooleanOr">
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="HttpMethod"/>
																									<primitiveExpression value="PUT"/>
																								</binaryOperatorExpression>
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="HttpMethod"/>
																									<primitiveExpression value="DELETE"/>
																								</binaryOperatorExpression>
																							</binaryOperatorExpression>
																						</unaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<propertyReferenceExpression name="StatusCode">
																								<argumentReferenceExpression name="response"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="404"/>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																			</falseStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<argumentReferenceExpression name="isHttpGetMethod"/>
													</condition>
													<trueStatements>
														<assignStatement>
															<argumentReferenceExpression name="key"/>
															<variableReferenceExpression name="segment1"/>
														</assignStatement>
														<assignStatement>
															<argumentReferenceExpression name="fieldName"/>
															<variableReferenceExpression name="segment2"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="VerifyActionSegments">
																	<parameters>
																		<argumentReferenceExpression name="config"/>
																		<variableReferenceExpression name="segment1"/>
																		<variableReferenceExpression name="segment2"/>
																		<primitiveExpression value="false"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<argumentReferenceExpression name="actionGroupId"/>
																	<variableReferenceExpression name="segment1"/>
																</assignStatement>
																<assignStatement>
																	<argumentReferenceExpression name="actionId"/>
																	<variableReferenceExpression name="segment2"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNullOrEmpty">
																			<variableReferenceExpression name="segment1"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="StatusCode">
																				<argumentReferenceExpression name="response"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="404"/>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<argumentReferenceExpression name="key"/>
																			<variableReferenceExpression name="segment1"/>
																		</assignStatement>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="VerifyActionSegments">
																					<parameters>
																						<argumentReferenceExpression name="config"/>
																						<variableReferenceExpression name="segment2"/>
																						<variableReferenceExpression name="segment3"/>
																						<primitiveExpression value="true"/>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<argumentReferenceExpression name="actionGroupId"/>
																					<variableReferenceExpression name="segment2"/>
																				</assignStatement>
																				<assignStatement>
																					<argumentReferenceExpression name="actionId"/>
																					<variableReferenceExpression name="segment3"/>
																				</assignStatement>
																			</trueStatements>
																			<falseStatements>
																				<conditionStatement>
																					<condition>
																						<unaryOperatorExpression operator="Not">
																							<binaryOperatorExpression operator="BooleanOr">
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="HttpMethod"/>
																									<primitiveExpression value="PUT"/>
																								</binaryOperatorExpression>
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="HttpMethod"/>
																									<primitiveExpression value="DELETE"/>
																								</binaryOperatorExpression>
																							</binaryOperatorExpression>
																						</unaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<propertyReferenceExpression name="StatusCode">
																								<argumentReferenceExpression name="response"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="404"/>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																			</falseStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<argumentReferenceExpression name="view"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="QueryString">
														<argumentReferenceExpression name="request"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="_view"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
										<assignStatement>
											<argumentReferenceExpression name="key"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="QueryString">
														<argumentReferenceExpression name="request"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="_key"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
										<assignStatement>
											<argumentReferenceExpression name="fieldName"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="QueryString">
														<argumentReferenceExpression name="request"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="_fieldName"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression>
													<argumentReferenceExpression name="isHttpGetMethod"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="actionGroupId"/>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="QueryString">
																<argumentReferenceExpression name="request"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="_actionId"/>
														</indices>
													</arrayIndexerExpression>
													<assignStatement>
														<argumentReferenceExpression name="view"/>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="QueryString">
																	<argumentReferenceExpression name="request"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="_actionId"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<argumentReferenceExpression name="isHttpGetMethod"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="XPathNavigator" name="actionNode">
											<init>
												<methodInvokeExpression methodName="SelectAction">
													<parameters>
														<argumentReferenceExpression name="config"/>
														<argumentReferenceExpression name="actionGroupId"/>
														<argumentReferenceExpression name="actionId"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="actionNode"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="commandName"/>
													<methodInvokeExpression methodName="GetAttribute">
														<target>
															<variableReferenceExpression name="actionNode"/>
														</target>
														<parameters>
															<primitiveExpression value="commandName"/>
															<stringEmptyExpression/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="commandName"/>
													<methodInvokeExpression methodName="HttpMethodToCommandName">
														<parameters>
															<argumentReferenceExpression name="request"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method HttpMethodToCommandName(HttpRequest) -->
						<memberMethod returnType="System.String" name="HttpMethodToCommandName">
							<attributes private="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="HttpMethod"/>
											<primitiveExpression value="POST"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="Insert"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="HttpMethod"/>
											<primitiveExpression value="PUT"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="Update"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="HttpMethod"/>
											<primitiveExpression value="DELETE"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="Delete"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AuthorizeRequest(HttpRequest, ControllerConfiguration) -->
						<memberMethod returnType="System.Boolean" name="AuthorizeRequest">
							<attributes family="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
								<parameter type="ControllerConfiguration" name="config"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="IsAuthorized">
										<target>
											<typeReferenceExpression type="UriRestConfig"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="request"/>
											<argumentReferenceExpression name="config"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method PerformRequest(HttpContext, Stream, bool, string) -->
						<memberMethod name="PerformRequest">
							<attributes private="true"/>
							<parameters>
								<parameter type="HttpContext" name="context"/>
								<parameter type="Stream" name="output"/>
								<parameter type="System.Boolean" name="json"/>
								<parameter type="System.String" name="controllerName"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="HttpRequest" name="request">
									<init>
										<propertyReferenceExpression name="Request">
											<argumentReferenceExpression name="context"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="HttpResponse" name="response">
									<init>
										<propertyReferenceExpression name="Response">
											<argumentReferenceExpression name="context"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="ControllerConfiguration" name="config">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<tryStatement>
									<statements>
										<assignStatement>
											<variableReferenceExpression name="config"/>
											<methodInvokeExpression methodName="CreateConfigurationInstance">
												<target>
													<typeReferenceExpression type="DataControllerBase"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="GetType"/>
													<argumentReferenceExpression name="controllerName"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</statements>
									<catch exceptionType="Exception">
										<assignStatement>
											<propertyReferenceExpression name="StatusCode">
												<variableReferenceExpression name="response"/>
											</propertyReferenceExpression>
											<primitiveExpression value="404"/>
										</assignStatement>
										<methodReturnStatement/>
									</catch>
								</tryStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="AuthorizeRequest">
												<parameters>
													<variableReferenceExpression name="request"/>
													<variableReferenceExpression name="config"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="StatusCode">
												<argumentReferenceExpression name="response"/>
											</propertyReferenceExpression>
											<primitiveExpression value="404"/>
										</assignStatement>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<comment>analyze route segments</comment>
								<variableDeclarationStatement type="System.Boolean"  name="isHttpGetMethod">
									<init>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="HttpMethod"/>
											<primitiveExpression value="GET"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="view">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="key">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="fieldName">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="actionGroupId">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="actionId">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="commandName">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="AnalyzeRouteValues">
									<parameters>
										<variableReferenceExpression name="request"/>
										<variableReferenceExpression name="response"/>
										<variableReferenceExpression name="isHttpGetMethod"/>
										<variableReferenceExpression name="config"/>
										<directionExpression direction="Out">
											<variableReferenceExpression name="view"/>
										</directionExpression>
										<directionExpression direction="Out">
											<variableReferenceExpression name="key"/>
										</directionExpression>
										<directionExpression direction="Out">
											<variableReferenceExpression name="fieldName"/>
										</directionExpression>
										<directionExpression direction="Out">
											<variableReferenceExpression name="actionGroupId"/>
										</directionExpression>
										<directionExpression direction="Out">
											<variableReferenceExpression name="actionId"/>
										</directionExpression>
										<directionExpression direction="Out">
											<variableReferenceExpression name="commandName"/>
										</directionExpression>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="StatusCode">
												<variableReferenceExpression name="response"/>
											</propertyReferenceExpression>
											<primitiveExpression value="404"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.Boolean" name="keyIsAvailable">
									<init>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="key"/>
										</unaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="view"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<variableReferenceExpression name="isHttpGetMethod"/>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="view"/>
													<methodInvokeExpression methodName="GetSelectView">
														<target>
															<typeReferenceExpression type="Controller"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="controllerName"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="commandName"/>
															<primitiveExpression value="Insert"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="view"/>
															<methodInvokeExpression methodName="GetInsertView">
																<target>
																	<typeReferenceExpression type="Controller"/>
																</target>
																<parameters>
																	<argumentReferenceExpression name="controllerName"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="commandName"/>
																	<primitiveExpression value="Update"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="view"/>
																	<methodInvokeExpression methodName="GetUpdateView">
																		<target>
																			<typeReferenceExpression type="Controller"/>
																		</target>
																		<parameters>
																			<argumentReferenceExpression name="controllerName"/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="commandName"/>
																			<primitiveExpression value="Delete"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="view"/>
																			<methodInvokeExpression methodName="GetDeleteView">
																				<target>
																					<typeReferenceExpression type="Controller"/>
																				</target>
																				<parameters>
																					<argumentReferenceExpression name="controllerName"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<methodInvokeExpression methodName="SelectView">
												<parameters>
													<variableReferenceExpression name="config"/>
													<variableReferenceExpression name="view"/>
												</parameters>
											</methodInvokeExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="StatusCode">
												<variableReferenceExpression name="response"/>
											</propertyReferenceExpression>
											<primitiveExpression value="404"/>
										</assignStatement>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="XPathNavigator" name="dataFieldNode">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="XPathNavigator" name="fieldNode">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="fieldName"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="dataFieldNode"/>
											<methodInvokeExpression methodName="SelectDataField">
												<parameters>
													<variableReferenceExpression name="config"/>
													<variableReferenceExpression name="view"/>
													<variableReferenceExpression name="fieldName"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="fieldNode"/>
											<methodInvokeExpression methodName="SelectField">
												<parameters>
													<variableReferenceExpression name="config"/>
													<variableReferenceExpression name="fieldName"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="dataFieldNode"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="fieldNode"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="StatusCode">
														<variableReferenceExpression name="response"/>
													</propertyReferenceExpression>
													<primitiveExpression value="404"/>
												</assignStatement>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<comment>create a filter</comment>
								<variableDeclarationStatement type="List" name="filter">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<comment>process key fields</comment>
								<conditionStatement>
									<condition>
										<variableReferenceExpression name="keyIsAvailable"/>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String[]" name="values">
											<init>
												<methodInvokeExpression methodName="Split">
													<target>
														<variableReferenceExpression name="key"/>
													</target>
													<parameters>
														<arrayCreateExpression>
															<createType type="System.Char"/>
															<initializers>
																<primitiveExpression value="," convertTo="Char"/>
															</initializers>
														</arrayCreateExpression>
														<propertyReferenceExpression name="RemoveEmptyEntries">
															<typeReferenceExpression type="StringSplitOptions"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="XPathNodeIterator" name="keyIterator">
											<init>
												<methodInvokeExpression methodName="Select">
													<target>
														<variableReferenceExpression name="config"/>
													</target>
													<parameters>
														<primitiveExpression value="/c:dataController/c:fields/c:field[@isPrimaryKey='true']"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Int32" name="index">
											<init>
												<primitiveExpression value="0"/>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<methodInvokeExpression methodName="MoveNext">
													<target>
														<variableReferenceExpression name="keyIterator"/>
													</target>
												</methodInvokeExpression>
											</test>
											<statements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="filter"/>
													</target>
													<parameters>
														<stringFormatExpression format="{{0}}:={{1}}">
															<methodInvokeExpression methodName="GetAttribute">
																<target>
																	<propertyReferenceExpression name="Current">
																		<variableReferenceExpression name="keyIterator"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="name"/>
																	<stringEmptyExpression/>
																</parameters>
															</methodInvokeExpression>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="values"/>
																</target>
																<indices>
																	<variableReferenceExpression name="index"/>
																</indices>
															</arrayIndexerExpression>
														</stringFormatExpression>
													</parameters>
												</methodInvokeExpression>
												<assignStatement>
													<variableReferenceExpression name="index"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="index"/>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</assignStatement>
											</statements>
										</whileStatement>
									</trueStatements>
								</conditionStatement>
								<comment>process quick find</comment>
								<variableDeclarationStatement type="System.String" name="quickFind">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Params">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="_q"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="quickFind"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="filter"/>
											</target>
											<parameters>
												<stringFormatExpression format="{{0}}:~{{1}}">
													<propertyReferenceExpression name="Value">
														<methodInvokeExpression methodName="SelectSingleNode">
															<target>
																<variableReferenceExpression name="config"/>
															</target>
															<parameters>
																<primitiveExpression value="/c:dataController/c:views/c:view[@id='{{0}}']/.//c:dataField[1]/@fieldName"/>
																<variableReferenceExpression name="view"/>
															</parameters>
														</methodInvokeExpression>
													</propertyReferenceExpression>
													<variableReferenceExpression name="quickFind"/>
												</stringFormatExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<comment>process filter parameters</comment>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<variableReferenceExpression name="keyIsAvailable"/>
										</unaryOperatorExpression>"
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="System.String" name="filterName" var="false"/>
											<target>
												<propertyReferenceExpression name="Keys">
													<propertyReferenceExpression name="Params">
														<variableReferenceExpression name="request"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<methodInvokeExpression methodName="SelectDataField">
																<parameters>
																	<variableReferenceExpression name="config"/>
																	<variableReferenceExpression name="view"/>
																	<variableReferenceExpression name="filterName"/>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="filter"/>
															</target>
															<parameters>
																<stringFormatExpression format="{{0}}:={{1}}">
																	<variableReferenceExpression name="filterName"/>
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Params">
																				<variableReferenceExpression name="request"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<variableReferenceExpression name="filterName"/>
																		</indices>
																	</arrayIndexerExpression>
																</stringFormatExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<variableDeclarationStatement type="Match" name="m">
															<init>
																<methodInvokeExpression methodName="Match">
																	<target>
																		<propertyReferenceExpression name="SqlFieldFilterOperationRegex">
																			<typeReferenceExpression type="BusinessRules"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="filterName"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String"  name="filterFieldName">
															<init>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="m"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Name"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<propertyReferenceExpression name="Success">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																	<binaryOperatorExpression operator="IdentityInequality">
																		<methodInvokeExpression methodName="SelectDataField">
																			<parameters>
																				<variableReferenceExpression name="config"/>
																				<variableReferenceExpression name="view"/>
																				<variableReferenceExpression name="filterFieldName"/>
																			</parameters>
																		</methodInvokeExpression>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="System.String" name="operation">
																	<init>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="m"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="Operation"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="RowFilterOperation" name="filterOperation">
																	<init>
																		<castExpression targetType="RowFilterOperation">
																			<methodInvokeExpression methodName="ConvertFromString">
																				<target>
																					<methodInvokeExpression methodName="GetConverter">
																						<target>
																							<typeReferenceExpression type="TypeDescriptor"/>
																						</target>
																						<parameters>
																							<typeofExpression type="RowFilterOperation"/>
																						</parameters>
																					</methodInvokeExpression>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="operation"/>
																				</parameters>
																			</methodInvokeExpression>
																		</castExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="System.String" name="filterValue">
																	<init>
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Params">
																					<variableReferenceExpression name="request"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<variableReferenceExpression name="filterName"/>
																			</indices>
																		</arrayIndexerExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanOr">
																			<binaryOperatorExpression operator="ValueEquality">
																				<variableReferenceExpression name="filterOperation"/>
																				<propertyReferenceExpression name="Includes">
																					<typeReferenceExpression type="RowFilterOperation"/>
																				</propertyReferenceExpression>
																			</binaryOperatorExpression>
																			<binaryOperatorExpression operator="ValueEquality">
																				<variableReferenceExpression name="filterOperation"/>
																				<propertyReferenceExpression name="DoesNotInclude">
																					<typeReferenceExpression type="RowFilterOperation"/>
																				</propertyReferenceExpression>
																			</binaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="filterValue"/>
																			<methodInvokeExpression methodName="Replace">
																				<target>
																					<typeReferenceExpression type="Regex"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="filterValue"/>
																					<primitiveExpression value=","/>
																					<primitiveExpression value="$or$"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<variableReferenceExpression name="filterOperation"/>
																					<propertyReferenceExpression name="Between">
																						<typeReferenceExpression type="RowFilterOperation"/>
																					</propertyReferenceExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="filterValue"/>
																					<methodInvokeExpression methodName="Replace">
																						<target>
																							<typeReferenceExpression type="Regex"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="filterValue"/>
																							<primitiveExpression value=","/>
																							<primitiveExpression value="$and$"/>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="filter"/>
																	</target>
																	<parameters>
																		<stringFormatExpression format="{{0}}:{{1}}{{2}}">
																			<variableReferenceExpression name="filterFieldName"/>
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="ComparisonOperations">
																						<typeReferenceExpression type="RowFilterAttribute"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<convertExpression to="Int32">
																						<variableReferenceExpression name="filterOperation"/>
																					</convertExpression>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="filterValue"/>
																		</stringFormatExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<comment>execute request</comment>
								<conditionStatement>
									<condition>
										<variableReferenceExpression name="isHttpGetMethod"/>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="fieldNode"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String" name="style">
													<init>
														<primitiveExpression value="o"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="QueryString">
																		<variableReferenceExpression name="request"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="_style"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="Thumbnail"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="style"/>
															<primitiveExpression value="t"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement type="System.String" name="blobPath">
													<init>
														<stringFormatExpression format="~/Blob.ashx?{{0}}={{1}}|{{2}}">
															<methodInvokeExpression methodName="GetAttribute">
																<target>
																	<variableReferenceExpression name="fieldNode"/>
																</target>
																<parameters>
																	<primitiveExpression value="onDemandHandler"/>
																	<stringEmptyExpression/>
																</parameters>
															</methodInvokeExpression>
															<variableReferenceExpression name="style"/>
															<variableReferenceExpression name="key"/>
														</stringFormatExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="RewritePath">
													<target>
														<argumentReferenceExpression name="context"/>
													</target>
													<parameters>
														<variableReferenceExpression name="blobPath"/>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement type="Blob" name="blobHandler">
													<init>
														<objectCreateExpression type="Blob"/>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="ProcessRequest">
													<target>
														<castExpression targetType="IHttpHandler">
															<variableReferenceExpression name="blobHandler"/>
														</castExpression>
													</target>
													<parameters>
														<argumentReferenceExpression name="context"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="ExecuteHttpGetRequest">
													<parameters>
														<variableReferenceExpression name="request"/>
														<variableReferenceExpression name="response"/>
														<argumentReferenceExpression name="output"/>
														<argumentReferenceExpression name="json"/>
														<argumentReferenceExpression name="controllerName"/>
														<variableReferenceExpression name="view"/>
														<variableReferenceExpression name="filter"/>
														<variableReferenceExpression name="keyIsAvailable"/>
													</parameters>
												</methodInvokeExpression>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="ExecuteActionRequest">
											<parameters>
												<variableReferenceExpression name="request"/>
												<variableReferenceExpression name="response"/>
												<argumentReferenceExpression name="output"/>
												<argumentReferenceExpression name="json"/>
												<variableReferenceExpression name="config"/>
												<variableReferenceExpression name="controllerName"/>
												<variableReferenceExpression name="view"/>
												<variableReferenceExpression name="key"/>
												<variableReferenceExpression name="filter"/>
												<variableReferenceExpression name="actionGroupId"/>
												<variableReferenceExpression name="actionId"/>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- property NumericTypes -->
						<memberField type="System.String[]" name="NumericTypes">
							<attributes public="true" static="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<primitiveExpression value="SByte"/>
										<primitiveExpression value="Byte"/>
										<primitiveExpression value="Int16"/>
										<primitiveExpression value="Int32"/>
										<primitiveExpression value="UInt32"/>
										<primitiveExpression value="Int64"/>
										<primitiveExpression value="Single"/>
										<primitiveExpression value="Double"/>
										<primitiveExpression value="Decimal"/>
										<primitiveExpression value="Currency"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- method ExecuteActionRequest(HttpRequest, HttpResponse, Stream, bool, ControllerConfiguration, string, string, string, List<String>, string, string) -->
						<memberMethod name="ExecuteActionRequest">
							<attributes private="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
								<parameter type="HttpResponse" name="response"/>
								<parameter type="Stream" name="output"/>
								<parameter type="System.Boolean" name="json"/>
								<parameter type="ControllerConfiguration" name="config"/>
								<parameter type="System.String" name="controllerName"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="key"/>
								<parameter type="List" name="filter">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
								</parameter>
								<parameter type="System.String" name="actionGroupId"/>
								<parameter type="System.String" name="actionId"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="XPathNavigator" name="actionNode">
									<init>
										<methodInvokeExpression methodName="SelectAction">
											<parameters>
												<argumentReferenceExpression name="config"/>
												<argumentReferenceExpression name="actionGroupId"/>
												<argumentReferenceExpression name="actionId"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="commandName">
									<init>
										<methodInvokeExpression methodName="HttpMethodToCommandName">
											<parameters>
												<argumentReferenceExpression name="request"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="commandArgument">
									<init>
										<stringEmptyExpression/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="lastCommandName">
									<init>
										<stringEmptyExpression/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="actionNode"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="commandName"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="StatusCode">
														<argumentReferenceExpression name="response"/>
													</propertyReferenceExpression>
													<primitiveExpression value="404"/>
												</assignStatement>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<variableReferenceExpression name="commandName"/>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<variableReferenceExpression name="actionNode"/>
												</target>
												<parameters>
													<primitiveExpression value="commandName"/>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="commandArgument"/>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<variableReferenceExpression name="actionNode"/>
												</target>
												<parameters>
													<primitiveExpression value="commandArgument"/>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="lastCommandName"/>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<variableReferenceExpression name="actionNode"/>
												</target>
												<parameters>
													<primitiveExpression value="whenLastCommandName"/>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
								<comment>prepare action arguments</comment>
								<variableDeclarationStatement type="ActionArgs" name="args">
									<init>
										<objectCreateExpression type="ActionArgs"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Controller">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="controllerName"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="View">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="view"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="CommandName">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="commandName"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="CommandArgument">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="commandArgument"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="LastCommandName">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="lastCommandName"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Filter">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<argumentReferenceExpression name="filter"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="SortExpression">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="QueryString">
												<argumentReferenceExpression name="request"/>
											</propertyReferenceExpression>
										</target>
										<indices>
											<primitiveExpression value="_sortExpression"/>
										</indices>
									</arrayIndexerExpression>
								</assignStatement>
								<variableDeclarationStatement type="System.String" name="selectedValues">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Params">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="_selectedValues"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="selectedValues"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="SelectedValues">
												<variableReferenceExpression name="args"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="Split">
												<target>
													<variableReferenceExpression name="selectedValues"/>
												</target>
												<parameters>
													<arrayCreateExpression>
														<createType type="System.Char"/>
														<initializers>
															<primitiveExpression value="," convertTo="Char"/>
														</initializers>
													</arrayCreateExpression>
													<propertyReferenceExpression name="RemoveEmptyEntries">
														<typeReferenceExpression type="StringSplitOptions"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="Trigger">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Params">
												<variableReferenceExpression name="request"/>
											</propertyReferenceExpression>
										</target>
										<indices>
											<primitiveExpression value="_trigger"/>
										</indices>
									</arrayIndexerExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Path">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<stringFormatExpression format="{{0}}/{{1}}">
										<argumentReferenceExpression name="actionGroupId"/>
										<argumentReferenceExpression name="actionId"/>
									</stringFormatExpression>
								</assignStatement>
								<!-- 
            NameValueCollection form = request.Form;
            if (request.HttpMethod == "GET")
                form = request.QueryString;
                -->
								<variableDeclarationStatement type="NameValueCollection" name="form">
									<init>
										<propertyReferenceExpression name="Form">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="HttpMethod">
												<argumentReferenceExpression name="request"/>
											</propertyReferenceExpression>
											<primitiveExpression value="GET"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="form"/>
											<propertyReferenceExpression name="QueryString">
												<argumentReferenceExpression name="request"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="List" name="values">
									<typeArguments>
										<typeReference type="FieldValue"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="FieldValue"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="fieldName" var="false"/>
									<target>
										<propertyReferenceExpression name="Keys">
											<variableReferenceExpression name="form"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<variableDeclarationStatement type="XPathNavigator" name="field">
											<init>
												<methodInvokeExpression methodName="SelectField">
													<parameters>
														<argumentReferenceExpression name="config"/>
														<variableReferenceExpression name="fieldName"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="XPathNavigator" name="dataField">
											<init>
												<methodInvokeExpression methodName="SelectDataField">
													<parameters>
														<argumentReferenceExpression name="config"/>
														<argumentReferenceExpression name="view"/>
														<variableReferenceExpression name="fieldName"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="field"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.Object" name="oldValue" var="false">
													<init>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="form"/>
															</target>
															<indices>
																<binaryOperatorExpression operator="Add">
																	<variableReferenceExpression name="fieldName"/>
																	<primitiveExpression value="_OldValue"/>
																</binaryOperatorExpression>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.Object" name="value" var="false">
													<init>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="form"/>
															</target>
															<indices>
																<variableReferenceExpression name="fieldName"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<comment>try parsing the values</comment>
												<variableDeclarationStatement type="System.String" name="dataFormatString">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<variableReferenceExpression name="dataField"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="dataFormatString"/>
															<methodInvokeExpression methodName="GetAttribute">
																<target>
																	<variableReferenceExpression name="dataField"/>
																</target>
																<parameters>
																	<primitiveExpression value="dataFormatString"/>
																	<stringEmptyExpression/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="dataFormatString"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="dataFormatString"/>
															<methodInvokeExpression methodName="GetAttribute">
																<target>
																	<variableReferenceExpression name="field"/>
																</target>
																<parameters>
																	<primitiveExpression value="dataFormatString"/>
																	<stringEmptyExpression/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="dataFormatString"/>
															</unaryOperatorExpression>
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression methodName="StartsWith">
																	<target>
																		<variableReferenceExpression name="dataFormatString"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="{{"/>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="dataFormatString"/>
															<stringFormatExpression format="{{{{0:{{0}}}}}}">
																<variableReferenceExpression name="dataFormatString"/>
															</stringFormatExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement type="System.String" name="fieldType">
													<init>
														<methodInvokeExpression methodName="GetAttribute">
															<target>
																<variableReferenceExpression name="field"/>
															</target>
															<parameters>
																<primitiveExpression value="type"/>
																<stringEmptyExpression/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Contains">
															<target>
																<propertyReferenceExpression name="NumericTypes"/>
															</target>
															<parameters>
																<variableReferenceExpression name="fieldType"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.Double" name="d" var="false"/>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="TryParse">
																	<target>
																		<typeReferenceExpression type="Double"/>
																	</target>
																	<parameters>
																		<castExpression targetType="System.String">
																			<variableReferenceExpression name="value"/>
																		</castExpression>
																		<propertyReferenceExpression name="Any">
																			<typeReferenceExpression type="NumberStyles"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="CurrentUICulture">
																			<typeReferenceExpression type="CultureInfo"/>
																		</propertyReferenceExpression>
																		<directionExpression direction="Out">
																			<variableReferenceExpression name="d"/>
																		</directionExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="value"/>
																	<variableReferenceExpression name="d"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="TryParse">
																	<target>
																		<typeReferenceExpression type="Double"/>
																	</target>
																	<parameters>
																		<castExpression targetType="System.String">
																			<variableReferenceExpression name="oldValue"/>
																		</castExpression>
																		<propertyReferenceExpression name="Any">
																			<typeReferenceExpression type="NumberStyles"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="CurrentUICulture">
																			<typeReferenceExpression type="CultureInfo"/>
																		</propertyReferenceExpression>
																		<directionExpression direction="Out">
																			<variableReferenceExpression name="d"/>
																		</directionExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="oldValue"/>
																	<variableReferenceExpression name="d"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="fieldType"/>
																	<primitiveExpression value="DateTime"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="DateTime" name="dt"/>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="dataFormatString"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="TryParseExact">
																					<target>
																						<typeReferenceExpression type="DateTime"/>
																					</target>
																					<parameters>
																						<castExpression targetType="System.String">
																							<variableReferenceExpression name="value"/>
																						</castExpression>
																						<variableReferenceExpression name="dataFormatString"/>
																						<propertyReferenceExpression name="CurrentUICulture">
																							<typeReferenceExpression type="CultureInfo"/>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="None">
																							<typeReferenceExpression type="DateTimeStyles"/>
																						</propertyReferenceExpression>
																						<directionExpression direction="Out">
																							<variableReferenceExpression name="dt"/>
																						</directionExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="value"/>
																					<variableReferenceExpression name="dt"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="TryParseExact">
																					<target>
																						<typeReferenceExpression type="DateTime"/>
																					</target>
																					<parameters>
																						<castExpression targetType="System.String">
																							<variableReferenceExpression name="oldValue"/>
																						</castExpression>
																						<variableReferenceExpression name="dataFormatString"/>
																						<propertyReferenceExpression name="CurrentUICulture">
																							<typeReferenceExpression type="CultureInfo"/>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="None">
																							<typeReferenceExpression type="DateTimeStyles"/>
																						</propertyReferenceExpression>
																						<directionExpression direction="Out">
																							<variableReferenceExpression name="dt"/>
																						</directionExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="oldValue"/>
																					<variableReferenceExpression name="dt"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="TryParse">
																					<target>
																						<typeReferenceExpression type="DateTime"/>
																					</target>
																					<parameters>
																						<castExpression targetType="System.String">
																							<variableReferenceExpression name="value"/>
																						</castExpression>
																						<directionExpression direction="Out">
																							<variableReferenceExpression name="dt"/>
																						</directionExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="value"/>
																					<variableReferenceExpression name="dt"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="TryParse">
																					<target>
																						<typeReferenceExpression type="DateTime"/>
																					</target>
																					<parameters>
																						<castExpression targetType="System.String">
																							<variableReferenceExpression name="oldValue"/>
																						</castExpression>
																						<directionExpression direction="Out">
																							<variableReferenceExpression name="dt"/>
																						</directionExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="oldValue"/>
																					<variableReferenceExpression name="dt"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<comment>create a field value</comment>
												<variableDeclarationStatement type="FieldValue" name="fvo">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<variableReferenceExpression name="oldValue"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="fvo"/>
															<objectCreateExpression type="FieldValue">
																<parameters>
																	<variableReferenceExpression name="fieldName"/>
																	<variableReferenceExpression name="oldValue"/>
																	<variableReferenceExpression name="value"/>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<assignStatement>
															<variableReferenceExpression name="fvo"/>
															<objectCreateExpression type="FieldValue">
																<parameters>
																	<variableReferenceExpression name="fieldName"/>
																	<variableReferenceExpression name="value"/>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
												<comment>figure if the field is read-only</comment>
												<variableDeclarationStatement type="System.Boolean" name="isReadOnly">
													<init>
														<binaryOperatorExpression operator="ValueEquality">
															<methodInvokeExpression methodName="GetAttribute">
																<target>
																	<variableReferenceExpression name="field"/>
																</target>
																<parameters>
																	<primitiveExpression value="readOnly"/>
																	<stringEmptyExpression/>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression value="true" convertTo="String"/>
														</binaryOperatorExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="writeRoles">
													<init>
														<methodInvokeExpression methodName="GetAttribute">
															<target>
																<variableReferenceExpression name="field"/>
															</target>
															<parameters>
																<primitiveExpression value="writeRoles"/>
																<stringEmptyExpression/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="writeRoles"/>
															</unaryOperatorExpression>
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression methodName="UserIsInRole">
																	<target>
																		<typeReferenceExpression type="DataControllerBase"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="writeRoles"/>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="isReadOnly"/>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="dataField"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="isReadOnly"/>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<assignStatement>
													<propertyReferenceExpression name="ReadOnly">
														<variableReferenceExpression name="fvo"/>
													</propertyReferenceExpression>
													<variableReferenceExpression name="isReadOnly"/>
												</assignStatement>
												<comment>add field value to the list</comment>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="values"/>
													</target>
													<parameters>
														<variableReferenceExpression name="fvo"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<variableDeclarationStatement type="System.Int32" name="keyIndex">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="XPathNodeIterator" name="keyIterator">
									<init>
										<methodInvokeExpression methodName="Select">
											<target>
												<argumentReferenceExpression name="config"/>
											</target>
											<parameters>
												<primitiveExpression value="/c:dataController/c:fields/c:field[@isPrimaryKey='true']"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<methodInvokeExpression methodName="MoveNext">
											<target>
												<variableReferenceExpression name="keyIterator"/>
											</target>
										</methodInvokeExpression>
									</test>
									<statements>
										<variableDeclarationStatement type="System.String" name="fieldName">
											<init>
												<methodInvokeExpression methodName="GetAttribute">
													<target>
														<propertyReferenceExpression name="Current">
															<variableReferenceExpression name="keyIterator"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="name"/>
														<stringEmptyExpression/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="FieldValue" name="fvo"/>
											<target>
												<variableReferenceExpression name="values"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="fvo"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="fieldName"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="fieldName"/>
															<primitiveExpression value="null"/>
														</assignStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="IdentityEquality">
																		<propertyReferenceExpression name="OldValue">
																			<variableReferenceExpression name="fvo"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="BooleanOr">
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="commandName"/>
																			<primitiveExpression value="Update"/>
																		</binaryOperatorExpression>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="commandName"/>
																			<primitiveExpression value="Delete"/>
																		</binaryOperatorExpression>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="OldValue">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="NewValue">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																</assignStatement>
																<!--<assignStatement>
                                  <propertyReferenceExpression name="NewValue">
                                    <variableReferenceExpression name="fvo"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="null"/>
                                </assignStatement>-->
																<assignStatement>
																	<propertyReferenceExpression name="Modified">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="false"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<breakStatement/>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="fieldName"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String" name="oldValue">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<argumentReferenceExpression name="key"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.String[]" name="keyValues">
															<init>
																<methodInvokeExpression methodName="Split">
																	<target>
																		<argumentReferenceExpression name="key"/>
																	</target>
																	<parameters>
																		<arrayCreateExpression>
																			<createType type="System.Char"/>
																			<initializers>
																				<primitiveExpression value="," convertTo="Char"/>
																			</initializers>
																		</arrayCreateExpression>
																		<propertyReferenceExpression name="RemoveEmptyEntries">
																			<typeReferenceExpression type="StringSplitOptions"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="LessThan">
																	<variableReferenceExpression name="keyIndex"/>
																	<propertyReferenceExpression name="Length">
																		<variableReferenceExpression name="keyValues"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="oldValue"/>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="keyValues"/>
																		</target>
																		<indices>
																			<variableReferenceExpression name="keyIndex"/>
																		</indices>
																	</arrayIndexerExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="values"/>
													</target>
													<parameters>
														<objectCreateExpression type="FieldValue">
															<parameters>
																<variableReferenceExpression name="fieldName"/>
																<variableReferenceExpression name="oldValue"/>
																<variableReferenceExpression name="oldValue"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="keyIndex"/>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="keyIndex"/>
												<primitiveExpression value="1"/>
											</binaryOperatorExpression>
										</assignStatement>
									</statements>
								</whileStatement>
								<assignStatement>
									<propertyReferenceExpression name="Values">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="values"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
								<comment>execute action</comment>
								<variableDeclarationStatement type="IDataController" name="controllerInstance">
									<init>
										<methodInvokeExpression methodName="CreateDataController">
											<target>
												<typeReferenceExpression type="ControllerFactory"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="ActionResult" name="result">
									<init>
										<methodInvokeExpression methodName="Execute">
											<target>
												<variableReferenceExpression name="controllerInstance"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="controllerName"/>
												<argumentReferenceExpression name="view"/>
												<variableReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<comment>redirect response location if success or error url has been specified</comment>
								<variableDeclarationStatement type="System.String" name="successUrl">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Params">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="_successUrl"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="errorUrl">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Params">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="_errorUrl"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="Count">
													<propertyReferenceExpression name="Errors">
														<argumentReferenceExpression name="result"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="successUrl"/>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="RedirectLocation">
												<argumentReferenceExpression name="response"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="successUrl"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="StatusCode">
												<variableReferenceExpression name="response"/>
											</propertyReferenceExpression>
											<primitiveExpression value="301"/>
										</assignStatement>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="GreaterThan">
												<propertyReferenceExpression name="Count">
													<propertyReferenceExpression name="Errors">
														<variableReferenceExpression name="result"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="errorUrl"/>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Contains">
													<target>
														<variableReferenceExpression name="errorUrl"/>
													</target>
													<parameters>
														<primitiveExpression value="?"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="errorUrl"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="errorUrl"/>
														<primitiveExpression value="&amp;"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="errorUrl"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="errorUrl"/>
														<primitiveExpression value="?"/>
													</binaryOperatorExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="errorUrl"/>
											<stringFormatExpression format="{{0}}_error={{1}}">
												<variableReferenceExpression name="errorUrl"/>
												<methodInvokeExpression methodName="UrlEncode">
													<target>
														<typeReferenceExpression type="HttpUtility"/>
													</target>
													<parameters>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Errors">
																	<variableReferenceExpression name="result"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="0"/>
															</indices>
														</arrayIndexerExpression>
													</parameters>
												</methodInvokeExpression>
											</stringFormatExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="RedirectLocation">
												<argumentReferenceExpression name="response"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="errorUrl"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="StatusCode">
												<variableReferenceExpression name="response"/>
											</propertyReferenceExpression>
											<primitiveExpression value="301"/>
										</assignStatement>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<argumentReferenceExpression name="json"/>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="StreamWriter" name="sw">
											<init>
												<methodInvokeExpression methodName="CreateStreamWriter">
													<parameters>
														<argumentReferenceExpression name="request"/>
														<argumentReferenceExpression name="response"/>
														<argumentReferenceExpression name="output"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="BeginResponsePadding">
											<parameters>
												<argumentReferenceExpression name="request"/>
												<variableReferenceExpression name="sw"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Write">
											<target>
												<variableReferenceExpression name="sw"/>
											</target>
											<parameters>
												<primitiveExpression value="{{{{&quot;rowsAffected&quot;:{{0}}"/>
												<propertyReferenceExpression name="RowsAffected">
													<variableReferenceExpression name="result"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<propertyReferenceExpression name="Errors">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="Count">
															<propertyReferenceExpression name="Errors">
																<variableReferenceExpression name="result"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value=",&quot;errors&quot;:["/>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement type="System.Boolean" name="first">
													<init>
														<primitiveExpression value="true"/>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable type="System.String" name="er"/>
													<target>
														<propertyReferenceExpression name="Errors">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<variableReferenceExpression name="first"/>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="first"/>
																	<primitiveExpression value="false"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="Write">
																	<target>
																		<variableReferenceExpression name="sw"/>
																	</target>
																	<parameters>
																		<primitiveExpression value=","/>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="Write">
															<target>
																<variableReferenceExpression name="sw"/>
															</target>
															<parameters>
																<primitiveExpression value="{{{{&quot;message&quot;:&quot;{{0}}&quot;}}}}"/>
																<methodInvokeExpression methodName="JavaScriptString">
																	<target>
																		<typeReferenceExpression type="BusinessRules"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="er"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value="]"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<propertyReferenceExpression name="ClientScript">
														<variableReferenceExpression name="result"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value=",&quot;clientScript&quot;:&quot;{{0}}&quot;"/>
														<methodInvokeExpression methodName="JavaScriptString">
															<target>
																<typeReferenceExpression type="BusinessRules"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="ClientScript">
																	<variableReferenceExpression name="result"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<propertyReferenceExpression name="NavigateUrl">
														<variableReferenceExpression name="result"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value=",&quot;navigateUrl&quot;:&quot;{{0}}&quot;"/>
														<methodInvokeExpression methodName="JavaScriptString">
															<target>
																<typeReferenceExpression type="BusinessRules"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="NavigateUrl">
																	<variableReferenceExpression name="result"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="Values">
														<variableReferenceExpression name="result"/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable type="FieldValue" name="fvo"/>
													<target>
														<propertyReferenceExpression name="Values">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<methodInvokeExpression methodName="Write">
															<target>
																<variableReferenceExpression name="sw"/>
															</target>
															<parameters>
																<primitiveExpression value=",&quot;{{0}}&quot;:"/>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="fvo"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteJSONValue">
															<parameters>
																<variableReferenceExpression name="sw"/>
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="fvo"/>
																</propertyReferenceExpression>
																<primitiveExpression value="null"/>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="Write">
											<target>
												<variableReferenceExpression name="sw"/>
											</target>
											<parameters>
												<primitiveExpression value="}}"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="EndResponsePadding">
											<parameters>
												<argumentReferenceExpression name="request"/>
												<variableReferenceExpression name="sw"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Close">
											<target>
												<variableReferenceExpression name="sw"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<variableDeclarationStatement type="XmlWriter" name="writer">
											<init>
												<methodInvokeExpression methodName="CreateXmlWriter">
													<parameters>
														<argumentReferenceExpression name="output"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="WriteStartDocument">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="result"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="rowsAffected"/>
												<methodInvokeExpression methodName="ToString">
													<target>
														<propertyReferenceExpression name="RowsAffected">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<propertyReferenceExpression name="Errors">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="Count">
															<propertyReferenceExpression name="Errors">
																<variableReferenceExpression name="result"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="WriteStartElement">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value="errors"/>
													</parameters>
												</methodInvokeExpression>
												<foreachStatement>
													<variable type="System.String" name="er"/>
													<target>
														<propertyReferenceExpression name="Errors">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<methodInvokeExpression methodName="WriteStartElement">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="error"/>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteAttributeString">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="message"/>
																<variableReferenceExpression name="er"/>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteEndElement">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
												<methodInvokeExpression methodName="WriteEndElement">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<propertyReferenceExpression name="ClientScript">
														<variableReferenceExpression name="result"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value="clientScript"/>
														<propertyReferenceExpression name="ClientScript">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<propertyReferenceExpression name="NavigateUrl">
														<variableReferenceExpression name="result"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value="navigateUrl"/>
														<propertyReferenceExpression name="NavigateUrl">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="Values">
														<variableReferenceExpression name="result"/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable type="FieldValue" name="fvo"/>
													<target>
														<propertyReferenceExpression name="Values">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<methodInvokeExpression methodName="WriteElementString">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="fvo"/>
																</propertyReferenceExpression>
																<convertExpression to="String">
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																</convertExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndDocument">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Close">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method WriteJSONValue(StreamWriter, object, DataField) -->
						<memberMethod name="WriteJSONValue">
							<attributes family="true"/>
							<parameters>
								<parameter type="StreamWriter" name="writer"/>
								<parameter type="System.Object" name="v"/>
								<parameter type="DataField" name="field"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="dataFormatString">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<argumentReferenceExpression name="field"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="dataFormatString"/>
											<propertyReferenceExpression name="DataFormatString">
												<variableReferenceExpression name="field"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<argumentReferenceExpression name="v"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Write">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="null" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IsTypeOf">
													<variableReferenceExpression name="v"/>
													<typeReferenceExpression type="System.String"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Write">
													<target>
														<argumentReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value="&quot;{{0}}&quot;"/>
														<methodInvokeExpression methodName="JavaScriptString">
															<target>
																<typeReferenceExpression type="BusinessRules"/>
															</target>
															<parameters>
																<castExpression targetType="System.String">
																	<argumentReferenceExpression name="v"/>
																</castExpression>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IsTypeOf">
															<argumentReferenceExpression name="v"/>
															<typeReferenceExpression type="DateTime"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Write">
															<target>
																<argumentReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="&quot;{{0}}&quot;"/>
																<methodInvokeExpression methodName="ConvertDateToJSON">
																	<parameters>
																		<castExpression targetType="DateTime">
																			<argumentReferenceExpression name="v"/>
																		</castExpression>
																		<argumentReferenceExpression name="dataFormatString"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IsTypeOf">
																	<argumentReferenceExpression name="v"/>
																	<typeReferenceExpression type="Guid"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Write">
																	<target>
																		<argumentReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="&quot;{{0}}&quot;"/>
																		<methodInvokeExpression methodName="JavaScriptString">
																			<target>
																				<typeReferenceExpression type="BusinessRules"/>
																			</target>
																			<parameters>
																				<methodInvokeExpression methodName="ToString">
																					<target>
																						<variableReferenceExpression name="v"/>
																					</target>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IsTypeOf">
																			<argumentReferenceExpression name="v"/>
																			<typeReferenceExpression type="System.Boolean"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Write">
																			<target>
																				<argumentReferenceExpression name="writer"/>
																			</target>
																			<parameters>
																				<methodInvokeExpression methodName="ToLower">
																					<target>
																						<methodInvokeExpression methodName="ToString">
																							<target>
																								<argumentReferenceExpression name="v"/>
																							</target>
																						</methodInvokeExpression>
																					</target>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="IsNotNullOrEmpty">
																					<argumentReferenceExpression name="dataFormatString"/>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Write">
																					<target>
																						<argumentReferenceExpression name="writer"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="&quot;{{0}}&quot;"/>
																						<methodInvokeExpression methodName="ConvertValueToJSON">
																							<parameters>
																								<argumentReferenceExpression name="v"/>
																								<argumentReferenceExpression name="dataFormatString"/>
																							</parameters>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																			<falseStatements>
																				<methodInvokeExpression methodName="Write">
																					<target>
																						<argumentReferenceExpression name="writer"/>
																					</target>
																					<parameters>
																						<methodInvokeExpression methodName="ConvertValueToJSON">
																							<parameters>
																								<argumentReferenceExpression name="v"/>
																								<primitiveExpression value="null"/>
																							</parameters>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</falseStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ExecuteHttpGetRequest(HttpRequest, HttpResponse, Stream, bool, string string, List<string>, bool) -->
						<memberMethod name="ExecuteHttpGetRequest">
							<attributes family="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
								<parameter type="HttpResponse" name="response"/>
								<parameter type="Stream" name="output"/>
								<parameter type="System.Boolean" name="json"/>
								<parameter type="System.String" name="controllerName"/>
								<parameter type="System.String" name="view"/>
								<parameter type="List" name="filter">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
								</parameter>
								<parameter type="System.Boolean" name="keyIsAvailable"/>
							</parameters>
							<statements>
								<comment>prepare a page request</comment>
								<variableDeclarationStatement type="System.Int32" name="pageSize"/>
								<methodInvokeExpression methodName="TryParse">
									<target>
										<typeReferenceExpression type="System.Int32"/>
									</target>
									<parameters>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="QueryString">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="_pageSize"/>
											</indices>
										</arrayIndexerExpression>
										<directionExpression direction="Out">
											<variableReferenceExpression name="pageSize"/>
										</directionExpression>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="pageSize"/>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="pageSize"/>
											<primitiveExpression value="100"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.Int32" name="pageIndex"/>
								<methodInvokeExpression methodName="TryParse">
									<target>
										<typeReferenceExpression type="System.Int32"/>
									</target>
									<parameters>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="QueryString">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="_pageIndex"/>
											</indices>
										</arrayIndexerExpression>
										<directionExpression direction="Out">
											<variableReferenceExpression name="pageIndex"/>
										</directionExpression>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="PageRequest" name="r">
									<init>
										<objectCreateExpression type="PageRequest"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Controller">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="controllerName"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="View">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="view"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="RequiresMetaData">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="PageSize">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="pageSize"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="PageIndex">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="pageIndex"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Filter">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<argumentReferenceExpression name="filter"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="RequiresRowCount">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<binaryOperatorExpression operator="BooleanAnd">
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="pageIndex"/>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
										<unaryOperatorExpression operator="Not">
											<argumentReferenceExpression name="keyIsAvailable"/>
										</unaryOperatorExpression>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="SortExpression">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="QueryString">
												<argumentReferenceExpression name="request"/>
											</propertyReferenceExpression>
										</target>
										<indices>
											<primitiveExpression value="_sortExpression"/>
										</indices>
									</arrayIndexerExpression>
								</assignStatement>
								<comment>request the data</comment>
								<variableDeclarationStatement type="IDataController" name="controllerInstance">
									<init>
										<methodInvokeExpression methodName="CreateDataController">
											<target>
												<typeReferenceExpression type="ControllerFactory"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="ViewPage" name="page">
									<init>
										<methodInvokeExpression methodName="GetPage">
											<target>
												<variableReferenceExpression name="controllerInstance"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Controller">
													<variableReferenceExpression name="r"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="View">
													<variableReferenceExpression name="r"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="r"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<argumentReferenceExpression name="keyIsAvailable"/>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="Count">
													<propertyReferenceExpression name="Rows">
														<variableReferenceExpression name="page"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="StatusCode">
												<variableReferenceExpression name="response"/>
											</propertyReferenceExpression>
											<primitiveExpression value="404"/>
										</assignStatement>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<comment>stream out the data</comment>
								<variableDeclarationStatement type="XmlWriter" name="writer">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="StreamWriter" name="sw">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<argumentReferenceExpression name="json"/>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="sw"/>
											<methodInvokeExpression methodName="CreateStreamWriter">
												<parameters>
													<argumentReferenceExpression name="request"/>
													<argumentReferenceExpression name="response"/>
													<argumentReferenceExpression name="output"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<methodInvokeExpression methodName="BeginResponsePadding">
											<parameters>
												<argumentReferenceExpression name="request"/>
												<variableReferenceExpression name="sw"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<argumentReferenceExpression name="keyIsAvailable"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value="{{"/>
													</parameters>
												</methodInvokeExpression>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="RequiresRowCount">
															<variableReferenceExpression name="r"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Write">
															<target>
																<variableReferenceExpression name="sw"/>
															</target>
															<parameters>
																<primitiveExpression value="&quot;totalRowCount&quot;:{{0}},"/>
																<propertyReferenceExpression name="TotalRowCount">
																	<variableReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value="&quot;pageSize&quot;:{{0}},&quot;pageIndex&quot;:{{1}},&quot;rowCount&quot;:{{2}},"/>
														<propertyReferenceExpression name="PageSize">
															<variableReferenceExpression name="page"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="PageIndex">
															<variableReferenceExpression name="page"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="Count">
															<propertyReferenceExpression name="Rows">
																<variableReferenceExpression name="page"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value="&quot;{{0}}&quot;:["/>
														<argumentReferenceExpression name="controllerName"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<variableReferenceExpression name="writer"/>
											<methodInvokeExpression methodName="CreateXmlWriter">
												<parameters>
													<argumentReferenceExpression name="output"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<methodInvokeExpression methodName="WriteStartDocument">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="controllerName"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="RequiresRowCount">
													<variableReferenceExpression name="r"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value="totalRowCount"/>
														<methodInvokeExpression methodName="ToString">
															<target>
																<propertyReferenceExpression name="TotalRowCount">
																	<variableReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</target>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<argumentReferenceExpression name="keyIsAvailable"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value="pageSize"/>
														<methodInvokeExpression methodName="ToString">
															<target>
																<propertyReferenceExpression name="PageSize">
																	<variableReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</target>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value="pageIndex"/>
														<methodInvokeExpression methodName="ToString">
															<target>
																<propertyReferenceExpression name="PageIndex">
																	<variableReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</target>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value="rowCount"/>
														<methodInvokeExpression methodName="ToString">
															<target>
																<propertyReferenceExpression name="Count">
																	<propertyReferenceExpression name="Rows">
																		<variableReferenceExpression name="page"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteStartElement">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value="items"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.Boolean" name="firstRow">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="DataField" name="field"/>
									<target>
										<propertyReferenceExpression name="Fields">
											<variableReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<propertyReferenceExpression name="DataFormatString">
															<variableReferenceExpression name="field"/>
														</propertyReferenceExpression>
													</unaryOperatorExpression>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="StartsWith">
															<target>
																<propertyReferenceExpression name="DataFormatString">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<primitiveExpression value="{{"/>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="DataFormatString">
														<variableReferenceExpression name="field"/>
													</propertyReferenceExpression>
													<stringFormatExpression format="{{{{0:{{0}}}}}}">
														<propertyReferenceExpression name="DataFormatString">
															<variableReferenceExpression name="field"/>
														</propertyReferenceExpression>
													</stringFormatExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<foreachStatement>
									<variable type="System.Object[]" name="row"/>
									<target>
										<propertyReferenceExpression name="Rows">
											<variableReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<variableDeclarationStatement type="System.Int32" name="index">
											<init>
												<primitiveExpression value="0"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<argumentReferenceExpression name="json"/>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<variableReferenceExpression name="firstRow"/>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="firstRow"/>
															<primitiveExpression value="false"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<methodInvokeExpression methodName="Write">
															<target>
																<variableReferenceExpression name="sw"/>
															</target>
															<parameters>
																<primitiveExpression value=","/>
															</parameters>
														</methodInvokeExpression>
													</falseStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value="{{"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<argumentReferenceExpression name="keyIsAvailable"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="WriteStartElement">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="item"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
										<variableDeclarationStatement type="System.Boolean" name="firstField">
											<init>
												<primitiveExpression value="true"/>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="DataField" name="field"/>
											<target>
												<propertyReferenceExpression name="Fields">
													<variableReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<argumentReferenceExpression name="json"/>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<variableReferenceExpression name="firstField"/>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="firstField"/>
																	<primitiveExpression value="false"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="Write">
																	<target>
																		<variableReferenceExpression name="sw"/>
																	</target>
																	<parameters>
																		<primitiveExpression value=","/>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="Write">
															<target>
																<variableReferenceExpression name="sw"/>
															</target>
															<parameters>
																<primitiveExpression value="&quot;{{0}}&quot;:"/>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteJSONValue">
															<parameters>
																<variableReferenceExpression name="sw"/>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="row"/>
																	</target>
																	<indices>
																		<variableReferenceExpression name="index"/>
																	</indices>
																</arrayIndexerExpression>
																<variableReferenceExpression name="field"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<variableDeclarationStatement type="System.Object" name="v">
															<init>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="row"/>
																	</target>
																	<indices>
																		<variableReferenceExpression name="index"/>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="v"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="System.String" name="s">
																	<init>
																		<primitiveExpression value="null"/>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<propertyReferenceExpression name="DataFormatString">
																				<variableReferenceExpression name="field"/>
																			</propertyReferenceExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="s"/>
																			<stringFormatExpression>
																				<propertyReferenceExpression name="DataFormatString">
																					<variableReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																				<variableReferenceExpression name="v"/>
																			</stringFormatExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<variableReferenceExpression name="s"/>
																			<convertExpression to="String">
																				<variableReferenceExpression name="v"/>
																			</convertExpression>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="WriteAttributeString">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																		<variableReferenceExpression name="s"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="index"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="index"/>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</assignStatement>
											</statements>
										</foreachStatement>
										<conditionStatement>
											<condition>
												<argumentReferenceExpression name="json"/>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value="}}"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<argumentReferenceExpression name="keyIsAvailable"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="WriteEndElement">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<argumentReferenceExpression name="keyIsAvailable"/>
											</condition>
											<trueStatements>
												<breakStatement/>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<argumentReferenceExpression name="json"/>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<argumentReferenceExpression name="keyIsAvailable"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value="]}}"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="EndResponsePadding">
											<parameters>
												<argumentReferenceExpression name="request"/>
												<variableReferenceExpression name="sw"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Close">
											<target>
												<variableReferenceExpression name="sw"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<argumentReferenceExpression name="keyIsAvailable"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="WriteEndElement">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndDocument">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Close">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ConvertValueToJSON(object, string) -->
						<memberMethod returnType="System.String" name="ConvertValueToJSON">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.Object" name="v"/>
								<parameter type="System.String" name="dataFormatString"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<argumentReferenceExpression name="dataFormatString"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ToString">
												<target>
													<argumentReferenceExpression name="v"/>
												</target>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
									<falseStatements>
										<methodReturnStatement>
											<stringFormatExpression>
												<argumentReferenceExpression name="dataFormatString"/>
												<argumentReferenceExpression name="v"/>
											</stringFormatExpression>
										</methodReturnStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ConvertDateToJSON(DateTime, string) -->
						<memberMethod returnType="System.String" name="ConvertDateToJSON">
							<attributes family="true"/>
							<parameters>
								<parameter type="DateTime" name="dt"/>
								<parameter type="System.String" name="dataFormatString"/>
							</parameters>
							<statements>
								<assignStatement>
									<variableReferenceExpression name="dt"/>
									<methodInvokeExpression methodName="ToUniversalTime">
										<target>
											<argumentReferenceExpression name="dt"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<argumentReferenceExpression name="dataFormatString"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ToString">
												<target>
													<variableReferenceExpression name="dt"/>
												</target>
												<parameters>
													<primitiveExpression value="F"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
									<falseStatements>
										<methodReturnStatement>
											<stringFormatExpression>
												<variableReferenceExpression name="dataFormatString"/>
												<variableReferenceExpression name="dt"/>
											</stringFormatExpression>
										</methodReturnStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method BeginResponsePadding(HttpRequest, StreamWriter) -->
						<memberMethod name="BeginResponsePadding">
							<attributes family="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
								<parameter type="StreamWriter" name="sw"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="callback">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="QueryString">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="callback"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<argumentReferenceExpression name="callback"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Write">
											<target>
												<argumentReferenceExpression name="sw"/>
											</target>
											<parameters>
												<primitiveExpression value="{{0}}("/>
												<variableReferenceExpression name="callback"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="HttpMethod">
															<argumentReferenceExpression name="request"/>
														</propertyReferenceExpression>
														<primitiveExpression value="GET"/>
													</binaryOperatorExpression>
													<methodInvokeExpression methodName="IsJSONPRequest">
														<target>
															<typeReferenceExpression type="UriRestConfig"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="request"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String" name="instance">
													<init>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="QueryString">
																	<argumentReferenceExpression name="request"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="_instance"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="instance"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="instance"/>
															<castExpression targetType="System.String">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Values">
																			<propertyReferenceExpression name="RouteData">
																				<propertyReferenceExpression name="RequestContext">
																					<argumentReferenceExpression name="request"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="Controller"/>
																	</indices>
																</arrayIndexerExpression>
															</castExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="Write">
													<target>
														<argumentReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value="{$Namespace}=typeof {$Namespace}=='undefined'?{{{{}}}}:{$Namespace};{$Namespace}.{{0}}="/>
														<argumentReferenceExpression name="instance"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method EndResponsePadding(HttpRequest, StreamWriter) -->
						<memberMethod name="EndResponsePadding">
							<attributes family="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
								<parameter type="StreamWriter" name="sw"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="callback">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="QueryString">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="callback"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<argumentReferenceExpression name="callback"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Write">
											<target>
												<argumentReferenceExpression name="sw"/>
											</target>
											<parameters>
												<primitiveExpression value=")"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="HttpMethod">
															<argumentReferenceExpression name="request"/>
														</propertyReferenceExpression>
														<primitiveExpression value="GET"/>
													</binaryOperatorExpression>
													<methodInvokeExpression methodName="IsJSONPRequest">
														<target>
															<typeReferenceExpression type="UriRestConfig"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="request"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Write">
													<target>
														<argumentReferenceExpression name="sw"/>
													</target>
													<parameters>
														<primitiveExpression value=";"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method CreateStreamWriter(HttpRequest, HttpResponse, Stream output) -->
						<memberMethod returnType="StreamWriter" name="CreateStreamWriter">
							<attributes family="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
								<parameter type="HttpResponse" name="response"/>
								<parameter type="Stream" name="output"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="acceptEncoding">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="Accept-Encoding"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="acceptEncoding"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String[]" name="encodings">
											<init>
												<methodInvokeExpression methodName="Split">
													<target>
														<variableReferenceExpression name="acceptEncoding"/>
													</target>
													<parameters>
														<primitiveExpression value="," convertTo="Char"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Contains">
													<target>
														<variableReferenceExpression name="encodings"/>
													</target>
													<parameters>
														<primitiveExpression value="gzip"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="output"/>
													<objectCreateExpression type="GZipStream">
														<parameters>
															<argumentReferenceExpression name="output"/>
															<propertyReferenceExpression name="Compress">
																<typeReferenceExpression type="CompressionMode"/>
															</propertyReferenceExpression>
														</parameters>
													</objectCreateExpression>
												</assignStatement>
												<methodInvokeExpression methodName="AppendHeader">
													<target>
														<argumentReferenceExpression name="response"/>
													</target>
													<parameters>
														<primitiveExpression value="Content-Encoding"/>
														<primitiveExpression value="gzip"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Contains">
															<target>
																<variableReferenceExpression name="encodings"/>
															</target>
															<parameters>
																<primitiveExpression value="deflate"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<argumentReferenceExpression name="output"/>
															<objectCreateExpression type="DeflateStream">
																<parameters>
																	<argumentReferenceExpression name="output"/>
																	<propertyReferenceExpression name="Compress">
																		<typeReferenceExpression type="CompressionMode"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
														<methodInvokeExpression methodName="AppendHeader">
															<target>
																<argumentReferenceExpression name="response"/>
															</target>
															<parameters>
																<primitiveExpression value="Content-Encoding"/>
																<primitiveExpression value="deflate"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<objectCreateExpression type="StreamWriter">
										<parameters>
											<argumentReferenceExpression name="output"/>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property HttpMethod -->
						<memberProperty type="System.String" name="HttpMethod">
							<attributes family="true"/>
							<getStatements>
								<variableDeclarationStatement type="HttpRequest" name="request">
									<init>
										<propertyReferenceExpression name="Request">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="HttpContext"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="requestType">
									<init>
										<propertyReferenceExpression name="HttpMethod">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="ValueEquality">
												<variableReferenceExpression name="requestType"/>
												<primitiveExpression value="GET"/>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="request"/>
													</target>
													<indices>
														<primitiveExpression value="callback"/>
													</indices>
												</arrayIndexerExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String" name="t">
											<init>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<variableReferenceExpression name="request"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="_type"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="t"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="requestType"/>
													<variableReferenceExpression name="t"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="requestType"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
					</members>
				</typeDeclaration>
				<xsl:if test="$MembershipEnabled='true' or $CustomSecurity='true'">
					<!-- FacebookOAuthHandler-->
					<typeDeclaration isPartial="true" name="FacebookOAuthHandler">
						<baseTypes>
							<typeReference type="FacebookOAuthHandlerBase"/>
						</baseTypes>
					</typeDeclaration>
					<!-- FacebookOAuthHandlerBase-->
					<typeDeclaration isPartial="true" name="FacebookOAuthHandlerBase">
						<baseTypes>
							<typeReference type="OAuthHandler"/>
						</baseTypes>
						<members>
							<!-- JObject _userObj-->
							<memberField type="JObject" name="userObj"/>
							<!-- method GetVersion()-->
							<memberMethod returnType="System.String" name="GetVersion">
								<attributes family="true"/>
								<statements>
									<variableDeclarationStatement type="System.String" name="version">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Config"/>
												</target>
												<indices>
													<primitiveExpression value="Version"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<variableReferenceExpression name="version"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="version"/>
												<primitiveExpression value="v2.8"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="version"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetHandlerName()-->
							<memberMethod returnType="System.String" name="GetHandlerName">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="Facebook"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- property Scope-->
							<memberProperty type="System.String" name="Scope">
								<attributes override="true" family="true"/>
								<getStatements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Trim">
											<target>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="email"/>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Config"/>
														</target>
														<indices>
															<primitiveExpression value="Scope"/>
														</indices>
													</arrayIndexerExpression>
												</binaryOperatorExpression>
											</target>
										</methodInvokeExpression>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method GetAuthorizationUrl()-->
							<memberMethod name="GetAuthorizationUrl" returnType="System.String">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<stringFormatExpression format="https://www.facebook.com/{{0}}/dialog/oauth?response_type=code&amp;client_id={{1}}&amp;redirect_uri={{2}}&amp;scope={{3}}&amp;state={{4}}">
											<methodInvokeExpression methodName="GetVersion"/>
											<propertyReferenceExpression name="ClientId">
												<propertyReferenceExpression name="Config"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="RedirectUri">
												<propertyReferenceExpression name="Config"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Scope"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="GetState"/>
												</parameters>
											</methodInvokeExpression>
										</stringFormatExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAccessTokenRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetAccessTokenRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="code"/>
									<parameter type="System.Boolean" name="refresh"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Create">
											<target>
												<typeReferenceExpression type="WebRequest"/>
											</target>
											<parameters>
												<stringFormatExpression format="https://graph.facebook.com/{{0}}/oauth/access_token?client_id={{1}}&amp;redirect_uri={{2}}&amp;client_secret={{3}}&amp;code={{4}}">
													<methodInvokeExpression methodName="GetVersion"/>
													<propertyReferenceExpression name="ClientId">
														<propertyReferenceExpression name="Config"/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="RedirectUri">
														<propertyReferenceExpression name="Config"/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="ClientSecret">
														<propertyReferenceExpression name="Config"/>
													</propertyReferenceExpression>
													<variableReferenceExpression name="code"/>
												</stringFormatExpression>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetQueryRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetQueryRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.String" name="token"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Add">
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="https://graph.facebook.com/"/>
															<methodInvokeExpression methodName="GetVersion"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="/"/>
															<variableReferenceExpression name="method"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<propertyReferenceExpression name="Authorization">
													<typeReferenceExpression type="HttpRequestHeader"/>
												</propertyReferenceExpression>
											</indices>
										</arrayIndexerExpression>
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="Bearer "/>
											<argumentReferenceExpression name="token"/>
										</binaryOperatorExpression>
									</assignStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserName()-->
							<memberMethod returnType="System.String" name="GetUserName">
								<attributes public="true" override="true"/>
								<statements>
									<assignStatement>
										<fieldReferenceExpression name="userObj"/>
										<methodInvokeExpression methodName="Query">
											<parameters>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="me?fields="/>
													<methodInvokeExpression methodName="ProfileFieldList"/>
												</binaryOperatorExpression>
												<primitiveExpression value="false"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<fieldReferenceExpression name="userObj"/>
												</target>
												<indices>
													<primitiveExpression value="email"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserImageUrl(MembershipUser)-->
							<memberMethod returnType="System.String" name="GetUserImageUrl">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="https://graph.facebook.com/"/>
											<binaryOperatorExpression operator="Add">
												<methodInvokeExpression methodName="GetVersion"/>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="/"/>
													<binaryOperatorExpression operator="Add">
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<fieldReferenceExpression name="userObj"/>
																</target>
																<indices>
																	<primitiveExpression value="id"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
														<primitiveExpression value="/picture"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method HandleError(HttpContext)-->
							<memberMethod name="HandleError">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="HttpContext" name="context"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<propertyReferenceExpression name="Request">
																<variableReferenceExpression name="context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="error_reason"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="user_denied"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Redirect">
												<target>
													<propertyReferenceExpression name="Response">
														<variableReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<propertyReferenceExpression name="HomePageUrl">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="HandleError">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<variableReferenceExpression name="context"/>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method ProfileFieldList() -->
							<memberMethod returnType="System.String" name="ProfileFieldList">
								<attributes family="true"/>
								<statements>
									<variableDeclarationStatement type="List" name="fieldList">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
										<init>
											<objectCreateExpression type="List">
												<typeArguments>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="s">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Config"/>
												</target>
												<indices>
													<primitiveExpression value="Profile Field List"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="s"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="AddRange">
												<target>
													<variableReferenceExpression name="fieldList"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="Split">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<variableReferenceExpression name="s"/>
															<primitiveExpression value="\s*\,\s*"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="Contains">
													<target>
														<variableReferenceExpression name="fieldList"/>
													</target>
													<parameters>
														<primitiveExpression value="email"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Insert">
												<target>
													<variableReferenceExpression name="fieldList"/>
												</target>
												<parameters>
													<primitiveExpression value="0"/>
													<primitiveExpression value="email"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Join">
											<target>
												<typeReferenceExpression type="System.String"/>
											</target>
											<parameters>
												<primitiveExpression value=","/>
												<methodInvokeExpression methodName="ToArray">
													<target>
														<variableReferenceExpression name="fieldList"/>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- GoogleOAuthHandler-->
					<typeDeclaration isPartial="true" name="GoogleOAuthHandler">
						<baseTypes>
							<typeReference type="GoogleOAuthHandlerBase"/>
						</baseTypes>
					</typeDeclaration>
					<!-- GoogleOAuthHandlerBase-->
					<typeDeclaration isPartial="true" name="GoogleOAuthHandlerBase">
						<baseTypes>
							<typeReference type="OAuthHandler"/>
						</baseTypes>
						<members>
							<!-- field _userId-->
							<memberField type="JObject" name="userObj"/>
							<!-- method GetHandlerName()-->
							<memberMethod returnType="System.String" name="GetHandlerName">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="Google"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- property Scope-->
							<memberProperty type="System.String" name="Scope">
								<attributes override="true" family="true"/>
								<getStatements>
									<variableDeclarationStatement type="System.String" name="defaultScope">
										<init>
											<methodInvokeExpression methodName="Trim">
												<target>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="email "/>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Config"/>
															</target>
															<indices>
																<primitiveExpression value="Scope"/>
															</indices>
														</arrayIndexerExpression>
													</binaryOperatorExpression>
												</target>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="StoreToken"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="defaultScope"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="defaultScope"/>
													<primitiveExpression value=" https://www.googleapis.com/auth/admin.directory.group.readonly"/>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="defaultScope"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method GetAuthorizationUrl()-->
							<memberMethod name="GetAuthorizationUrl" returnType="System.String">
								<attributes public="true" override="true"/>
								<statements>
									<variableDeclarationStatement type="System.String" name="accessType">
										<init>
											<primitiveExpression value="online"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="StoreToken"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="accessType"/>
												<primitiveExpression value="offline"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="authUrl">
										<init>
											<stringFormatExpression format="https://accounts.google.com/o/oauth2/v2/auth?response_type=code&amp;client_id={{0}}&amp;redirect_uri={{1}}&amp;scope={{2}}&amp;state={{3}}&amp;access_type={{4}}&amp;prompt=select_account">
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="EscapeDataString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="RedirectUri">
															<propertyReferenceExpression name="Config"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="EscapeDataString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Scope"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="EscapeDataString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="GetState"/>
													</parameters>
												</methodInvokeExpression>
												<variableReferenceExpression name="accessType"/>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="authUrl"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAccessTokenRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetAccessTokenRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="code"/>
									<parameter type="System.Boolean" name="refresh"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<primitiveExpression value="https://www.googleapis.com/oauth2/v4/token"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Method">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="POST"/>
									</assignStatement>
									<variableDeclarationStatement type="System.String" name="codeType">
										<init>
											<primitiveExpression value="code"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<argumentReferenceExpression name="refresh"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="codeType"/>
												<primitiveExpression value="access_token"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="body">
										<init>
											<stringFormatExpression format="{{0}}={{1}}&amp;client_id={{2}}&amp;client_secret={{3}}&amp;redirect_uri={{4}}&amp;grant_type=authorization_code">
												<variableReferenceExpression name="codeType"/>
												<argumentReferenceExpression name="code"/>
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="ClientSecret">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="RedirectUri">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.Byte[]" name="bodyBytes">
										<init>
											<methodInvokeExpression methodName="GetBytes">
												<target>
													<propertyReferenceExpression name="UTF8">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="body"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentType">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="application/x-www-form-urlencoded"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentLength">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Length">
											<variableReferenceExpression name="bodyBytes"/>
										</propertyReferenceExpression>
									</assignStatement>
									<usingStatement>
										<variable type="Stream" name="stream">
											<init>
												<methodInvokeExpression methodName="GetRequestStream">
													<target>
														<variableReferenceExpression name="request"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variable>
										<statements>
											<methodInvokeExpression methodName="Write">
												<target>
													<variableReferenceExpression name="stream"/>
												</target>
												<parameters>
													<variableReferenceExpression name="bodyBytes"/>
													<primitiveExpression value="0"/>
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="bodyBytes"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</usingStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetQueryRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetQueryRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.String" name="token"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="https://www.googleapis.com/"/>
														<argumentReferenceExpression name="method"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<propertyReferenceExpression name="Authorization">
													<typeReferenceExpression type="HttpRequestHeader"/>
												</propertyReferenceExpression>
											</indices>
										</arrayIndexerExpression>
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="Bearer "/>
											<argumentReferenceExpression name="token"/>
										</binaryOperatorExpression>
									</assignStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserName()-->
							<memberMethod returnType="System.String" name="GetUserName">
								<attributes public="true" override="true"/>
								<statements>
									<assignStatement>
										<fieldReferenceExpression name="userObj"/>
										<methodInvokeExpression methodName="Query">
											<parameters>
												<primitiveExpression value="userinfo/v2/me"/>
												<primitiveExpression value="false"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<fieldReferenceExpression name="userObj"/>
												</target>
												<indices>
													<primitiveExpression value="email"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserRoles(MembershipUser)-->
							<memberMethod returnType="List" name="GetUserRoles">
								<typeArguments>
									<typeReference type="System.String"/>
								</typeArguments>
								<attributes override="true" public="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="List" name="roles">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
										<init>
											<methodInvokeExpression methodName="GetUserRoles">
												<target>
													<baseReferenceExpression/>
												</target>
												<parameters>
													<variableReferenceExpression name="user"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="JObject" name="result">
										<init>
											<methodInvokeExpression methodName="Query">
												<parameters>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="admin/directory/v1/groups?userKey="/>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<fieldReferenceExpression name="userObj"/>
																</target>
																<indices>
																	<primitiveExpression value="id"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
													</binaryOperatorExpression>
													<primitiveExpression value="true"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="result"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<foreachStatement>
												<variable type="JObject" name="group"/>
												<target>
													<castExpression targetType="JArray">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="result"/>
															</target>
															<indices>
																<primitiveExpression value="groups"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</target>
												<statements>
													<methodInvokeExpression methodName="Add">
														<target>
															<variableReferenceExpression name="roles"/>
														</target>
														<parameters>
															<castExpression targetType="System.String">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="group"/>
																	</target>
																	<indices>
																		<primitiveExpression value="name"/>
																	</indices>
																</arrayIndexerExpression>
															</castExpression>
														</parameters>
													</methodInvokeExpression>
												</statements>
											</foreachStatement>
										</trueStatements>
										<falseStatements>
											<throwExceptionStatement>
												<objectCreateExpression type="Exception">
													<parameters>
														<primitiveExpression value="Unable to get roles."/>
													</parameters>
												</objectCreateExpression>
											</throwExceptionStatement>
										</falseStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="roles"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- GetUserImageUrl(MembershipUser)-->
							<memberMethod returnType="System.String" name="GetUserImageUrl">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<fieldReferenceExpression name="userObj"/>
												</target>
												<indices>
													<primitiveExpression value="picture"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- MSGraphOAuthHandler-->
					<typeDeclaration isPartial="true" name="MSGraphOAuthHandler">
						<baseTypes>
							<typeReference type="MSGraphOAuthHandlerBase"/>
						</baseTypes>
					</typeDeclaration>
					<!-- MSGraphOAuthHandlerBase-->
					<typeDeclaration isPartial="true" name="MSGraphOAuthHandlerBase">
						<baseTypes>
							<typeReference type="OAuthHandler"/>
						</baseTypes>
						<members>
							<!-- field _userID-->
							<memberField type="System.String" name="userID">
								<attributes private="true"/>
								<init>
									<primitiveExpression value="null"/>
								</init>
							</memberField>
							<!-- property Scope-->
							<memberProperty type="System.String" name="Scope">
								<attributes family="true" override="true"/>
								<getStatements>
									<variableDeclarationStatement type="System.String" name="sc">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Config"/>
												</target>
												<indices>
													<primitiveExpression value="Scope"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="StoreToken"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="sc"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="sc"/>
													<primitiveExpression value=" https://graph.microsoft.com/.default"/>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
										<falseStatements>
											<assignStatement>
												<variableReferenceExpression name="sc"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="sc"/>
													<primitiveExpression value=" User.Read"/>
												</binaryOperatorExpression>
											</assignStatement>
										</falseStatements>
									</conditionStatement>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Trim">
											<target>
												<variableReferenceExpression name="sc"/>
											</target>
										</methodInvokeExpression>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- property TenantID-->
							<memberField type="System.String" name="tenantID">
								<attributes private="true"/>
							</memberField>
							<memberProperty type="System.String" name="TenantID">
								<attributes public="true"/>
								<getStatements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="tenantID"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="tenantID"/>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Config"/>
													</target>
													<indices>
														<primitiveExpression value="Tenant ID"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNullOrEmpty">
														<fieldReferenceExpression name="tenantID"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<fieldReferenceExpression name="tenantID"/>
														<primitiveExpression value="common"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<fieldReferenceExpression name="tenantID"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method GetHandlerName-->
							<memberMethod returnType="System.String" name="GetHandlerName">
								<attributes override="true" public="true"/>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="MSGraph"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAuthorizationUrl()-->
							<memberMethod name="GetAuthorizationUrl" returnType="System.String">
								<attributes public="true" override="true"/>
								<statements>
									<variableDeclarationStatement type="StringBuilder" name="sb">
										<init>
											<objectCreateExpression type="StringBuilder">
												<parameters>
													<primitiveExpression value="https://login.microsoftonline.com/"/>
												</parameters>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="Append">
										<target>
											<variableReferenceExpression name="sb"/>
										</target>
										<parameters>
											<variableReferenceExpression name="TenantID"/>
										</parameters>
									</methodInvokeExpression>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<propertyReferenceExpression name="StoreToken"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Append">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
												<parameters>
													<primitiveExpression value="/oauth2/v2.0/authorize"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
										<falseStatements>
											<methodInvokeExpression methodName="Append">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
												<parameters>
													<primitiveExpression value="/adminconsent"/>
												</parameters>
											</methodInvokeExpression>
										</falseStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="AppendFormat">
										<target>
											<variableReferenceExpression name="sb"/>
										</target>
										<parameters>
											<primitiveExpression value="?client_id={{0}}&amp;redirect_uri={{1}}&amp;state={{2}}"/>
											<propertyReferenceExpression name="ClientId">
												<propertyReferenceExpression name="Config"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="RedirectUri">
														<propertyReferenceExpression name="Config"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="GetState"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<propertyReferenceExpression name="StoreToken"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Append">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
												<parameters>
													<primitiveExpression value="&amp;response_type=code&amp;response_mode=query&amp;scope="/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="Append">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="EscapeDataString">
														<target>
															<typeReferenceExpression type="Uri"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Scope"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<methodInvokeExpression methodName="ToString">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAccessTokenRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetAccessTokenRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="code"/>
									<parameter type="System.Boolean" name="refresh"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<stringFormatExpression format="https://login.microsoftonline.com/{{0}}/oauth2/v2.0/token">
														<propertyReferenceExpression name="TenantID"/>
													</stringFormatExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Method">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="POST"/>
									</assignStatement>
									<variableDeclarationStatement type="System.String" name="body">
										<init>
											<stringFormatExpression format="client_id={{0}}&amp;redirect_uri={{1}}&amp;client_secret={{2}}&amp;scope={{3}}">
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="EscapeDataString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="RedirectUri">
															<propertyReferenceExpression name="Config"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<propertyReferenceExpression name="ClientSecret">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="EscapeDataString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Scope"/>
													</parameters>
												</methodInvokeExpression>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<variableReferenceExpression name="refresh"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="body"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="body"/>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="&amp;grant_type=refresh_token&amp;refresh_token="/>
														<variableReferenceExpression name="code"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
										<falseStatements>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="Not">
														<propertyReferenceExpression name="StoreToken"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="body"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="body"/>
															<binaryOperatorExpression operator="Add">
																<primitiveExpression value="&amp;grant_type=authorization_code&amp;code="/>
																<variableReferenceExpression name="code"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</assignStatement>
												</trueStatements>
												<falseStatements>
													<assignStatement>
														<variableReferenceExpression name="body"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="body"/>
															<primitiveExpression value="&amp;grant_type=client_credentials"/>
														</binaryOperatorExpression>
													</assignStatement>
												</falseStatements>
											</conditionStatement>
										</falseStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.Byte[]" name="bodyBytes">
										<init>
											<methodInvokeExpression methodName="GetBytes">
												<target>
													<propertyReferenceExpression name="UTF8">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="body"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentType">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="application/x-www-form-urlencoded"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentLength">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Length">
											<variableReferenceExpression name="bodyBytes"/>
										</propertyReferenceExpression>
									</assignStatement>
									<usingStatement>
										<variable type="Stream" name="stream">
											<init>
												<methodInvokeExpression methodName="GetRequestStream">
													<target>
														<variableReferenceExpression name="request"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variable>
										<statements>
											<methodInvokeExpression methodName="Write">
												<target>
													<variableReferenceExpression name="stream"/>
												</target>
												<parameters>
													<variableReferenceExpression name="bodyBytes"/>
													<primitiveExpression value="0"/>
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="bodyBytes"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</usingStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetQueryRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetQueryRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.String" name="token"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="https://graph.microsoft.com/v1.0/"/>
														<variableReferenceExpression name="method"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<propertyReferenceExpression name="Authorization">
													<typeReferenceExpression type="HttpRequestHeader"/>
												</propertyReferenceExpression>
											</indices>
										</arrayIndexerExpression>
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="Bearer "/>
											<variableReferenceExpression name="token"/>
										</binaryOperatorExpression>
									</assignStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method RefreshTokens(bool) -->
							<memberMethod returnType="System.Boolean" name="RefreshTokens">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.Boolean" name="useSystemToken"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<variableReferenceExpression name="useSystemToken"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<methodInvokeExpression methodName="RefreshTokens">
													<target>
														<baseReferenceExpression/>
													</target>
													<parameters>
														<variableReferenceExpression name="useSystemToken"/>
													</parameters>
												</methodInvokeExpression>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.Boolean" name="success">
										<init>
											<methodInvokeExpression methodName="GetAccessTokens">
												<parameters>
													<primitiveExpression value="True" convertTo="String"/>
													<primitiveExpression value="false"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<variableReferenceExpression name="success"/>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="StoreTokens">
												<parameters>
													<propertyReferenceExpression name="Tokens"/>
													<primitiveExpression value="true"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="success"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserName()-->
							<memberMethod returnType="System.String" name="GetUserName">
								<attributes public="true" override="true"/>
								<statements>
									<variableDeclarationStatement type="JObject" name="userObj">
										<init>
											<methodInvokeExpression methodName="Query">
												<parameters>
													<primitiveExpression value="me"/>
													<primitiveExpression value="false"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<fieldReferenceExpression name="userID"/>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="userObj"/>
												</target>
												<indices>
													<primitiveExpression value="id"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</assignStatement>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="userObj"/>
												</target>
												<indices>
													<primitiveExpression value="userPrincipalName"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserRoles(MembershipUser)-->
							<memberMethod returnType="List" name="GetUserRoles">
								<typeArguments>
									<typeReference type="System.String"/>
								</typeArguments>
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="List" name="roles">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
										<init>
											<methodInvokeExpression methodName="GetUserRoles">
												<target>
													<baseReferenceExpression/>
												</target>
												<parameters>
													<variableReferenceExpression name="user"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="JObject" name="roleObj">
										<init>
											<methodInvokeExpression methodName="Query">
												<parameters>
													<binaryOperatorExpression operator="Add">
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="users/"/>
															<fieldReferenceExpression name="userID"/>
														</binaryOperatorExpression>
														<primitiveExpression value="/memberOf"/>
													</binaryOperatorExpression>
													<primitiveExpression value="true"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="roleObj"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<foreachStatement>
												<variable type="JToken" name="role"/>
												<target>
													<castExpression targetType="JArray">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="roleObj"/>
															</target>
															<indices>
																<primitiveExpression value="value"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</target>
												<statements>
													<methodInvokeExpression methodName="Add">
														<target>
															<variableReferenceExpression name="roles"/>
														</target>
														<parameters>
															<castExpression targetType="System.String">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="role"/>
																	</target>
																	<indices>
																		<primitiveExpression value="displayName"/>
																	</indices>
																</arrayIndexerExpression>
															</castExpression>
														</parameters>
													</methodInvokeExpression>
												</statements>
											</foreachStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="roles"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAuthCode(HttpRequest)-->
							<memberMethod returnType="System.String" name="GetAuthCode">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="HttpRequest" name="request"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="StoreToken"/>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<variableReferenceExpression name="request"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="admin_consent"/>
													</indices>
												</arrayIndexerExpression>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<methodInvokeExpression methodName="GetAuthCode">
											<target>
												<baseReferenceExpression/>
											</target>
											<parameters>
												<variableReferenceExpression name="request"/>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method SetUserAvatar(MembershipUser)-->
							<memberMethod name="SetUserAvatar">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<xsl:if test="$SiteContentTableName!=''">
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsSiteContentEnabled">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<tryStatement>
													<statements>
														<variableDeclarationStatement type="WebRequest" name="request">
															<init>
																<methodInvokeExpression methodName="Create">
																	<target>
																		<typeReferenceExpression type="WebRequest"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="https://graph.microsoft.com/v2.0/me/photo/$value"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Headers">
																		<variableReferenceExpression name="request"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<propertyReferenceExpression name="Authorization">
																		<typeReferenceExpression type="HttpRequestHeader"/>
																	</propertyReferenceExpression>
																</indices>
															</arrayIndexerExpression>
															<binaryOperatorExpression operator="Add">
																<primitiveExpression value="Bearer "/>
																<castExpression targetType="System.String">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Tokens"/>
																		</target>
																		<indices>
																			<primitiveExpression value="access_token"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
															</binaryOperatorExpression>
														</assignStatement>
														<variableDeclarationStatement type="WebResponse" name="response">
															<init>
																<methodInvokeExpression methodName="GetResponse">
																	<target>
																		<variableReferenceExpression name="request"/>
																	</target>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<usingStatement>
															<variable type="Stream" name="s">
																<init>
																	<methodInvokeExpression methodName="GetResponseStream">
																		<target>
																			<variableReferenceExpression name="response"/>
																		</target>
																	</methodInvokeExpression>
																</init>
															</variable>
															<statements>
																<variableDeclarationStatement type="Bitmap" name="b">
																	<init>
																		<castExpression targetType="Bitmap">
																			<methodInvokeExpression methodName="FromStream">
																				<target>
																					<typeReferenceExpression type="Bitmap"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="s"/>
																				</parameters>
																			</methodInvokeExpression>
																		</castExpression>
																	</init>
																</variableDeclarationStatement>
																<usingStatement>
																	<variable type="MemoryStream" name="ms">
																		<init>
																			<objectCreateExpression type="MemoryStream"/>
																		</init>
																	</variable>
																	<statements>
																		<methodInvokeExpression methodName="Save">
																			<target>
																				<variableReferenceExpression name="b"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="ms"/>
																				<propertyReferenceExpression name="Png">
																					<typeReferenceExpression type="ImageFormat"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="WriteAllBytes">
																			<target>
																				<typeReferenceExpression type="SiteContentFile"/>
																			</target>
																			<parameters>
																				<stringFormatExpression format="sys/users/{{0}}.png">
																					<propertyReferenceExpression name="UserName">
																						<variableReferenceExpression name="user"/>
																					</propertyReferenceExpression>
																				</stringFormatExpression>
																				<primitiveExpression value="image/png"/>
																				<methodInvokeExpression methodName="ToArray">
																					<target>
																						<variableReferenceExpression name="ms"/>
																					</target>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</statements>
																</usingStatement>
															</statements>
														</usingStatement>
													</statements>
													<catch exceptionType="Exception"></catch>
												</tryStatement>
											</trueStatements>
										</conditionStatement>
									</xsl:if>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- LinkedInOAuthHandler-->
					<typeDeclaration isPartial="true" name="LinkedInOAuthHandler">
						<baseTypes>
							<typeReference type="LinkedInOAuthHandlerBase"/>
						</baseTypes>
					</typeDeclaration>
					<!-- LinkedInOAuthHandlerBase-->
					<typeDeclaration isPartial="true" name="LinkedInOAuthHandlerBase">
						<baseTypes>
							<typeReference type="OAuthHandler"/>
						</baseTypes>
						<members>
							<!-- field _userObj-->
							<memberField type="JObject" name="userObj"/>
							<!-- property Scope-->
							<memberProperty type="System.String" name="Scope">
								<attributes override="true" family="true"/>
								<getStatements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Trim">
											<target>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="r_liteprofile r_emailaddress "/>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Config"/>
														</target>
														<indices>
															<primitiveExpression value="Scope"/>
														</indices>
													</arrayIndexerExpression>
												</binaryOperatorExpression>
											</target>
										</methodInvokeExpression>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method GetHandlerName()-->
							<memberMethod returnType="System.String" name="GetHandlerName">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="LinkedIn"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAuthorizationUrl()-->
							<memberMethod name="GetAuthorizationUrl" returnType="System.String">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<stringFormatExpression>
											<xsl:attribute name="format"><![CDATA[https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id={0}&redirect_uri={1}&state={2}&scope={3}]]></xsl:attribute>
											<propertyReferenceExpression name="ClientId">
												<propertyReferenceExpression name="Config"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="RedirectUri">
												<propertyReferenceExpression name="Config"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="GetState"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Scope"/>
												</parameters>
											</methodInvokeExpression>
										</stringFormatExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserName()-->
							<memberMethod returnType="System.String" name="GetUserName">
								<attributes public="true" override="true"/>
								<statements>
									<variableDeclarationStatement name="obj" type="JObject">
										<init>
											<methodInvokeExpression methodName="Query">
												<parameters>
													<primitiveExpression value="emailAddress?q=members&amp;projection=(elements*(handle~))"/>
													<primitiveExpression value="false"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<fieldReferenceExpression name="userObj"/>
										<methodInvokeExpression methodName="Query">
											<parameters>
												<primitiveExpression value="me?projection=(id,firstName,lastName,profilePicture(displayImage~:playableStreams))"/>
												<primitiveExpression value="false"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<arrayIndexerExpression>
														<target>
															<arrayIndexerExpression>
																<target>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="obj"/>
																		</target>
																		<indices>
																			<primitiveExpression value="elements"/>
																		</indices>
																	</arrayIndexerExpression>
																</target>
																<indices>
																	<primitiveExpression value="0"/>
																</indices>
															</arrayIndexerExpression>
														</target>
														<indices>
															<primitiveExpression value="handle~"/>
														</indices>
													</arrayIndexerExpression>
												</target>
												<indices>
													<primitiveExpression value="emailAddress"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- GetUserImageUrl(MembershipUser)-->
							<memberMethod returnType="System.String" name="GetUserImageUrl">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<arrayIndexerExpression>
														<target>
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Last">
																		<arrayIndexerExpression>
																			<target>
																				<arrayIndexerExpression>
																					<target>
																						<arrayIndexerExpression>
																							<target>
																								<fieldReferenceExpression name="userObj"/>
																							</target>
																							<indices>
																								<primitiveExpression value="profilePicture"/>
																							</indices>
																						</arrayIndexerExpression>
																					</target>
																					<indices>
																						<primitiveExpression value="displayImage~"/>
																					</indices>
																				</arrayIndexerExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="elements"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="identifiers"/>
																</indices>
															</arrayIndexerExpression>
														</target>
														<indices>
															<primitiveExpression value="0"/>
														</indices>
													</arrayIndexerExpression>
												</target>
												<indices>
													<primitiveExpression value="identifier"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAccessTokenRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetAccessTokenRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="code"/>
									<parameter type="System.Boolean" name="refresh"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<primitiveExpression value="https://www.linkedin.com/oauth/v2/accessToken"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Method">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="POST"/>
									</assignStatement>
									<variableDeclarationStatement type="System.String" name="codeType">
										<init>
											<primitiveExpression value="code"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<argumentReferenceExpression name="refresh"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="codeType"/>
												<primitiveExpression value="access_token"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="body">
										<init>
											<stringFormatExpression format="{{0}}={{1}}&amp;client_id={{2}}&amp;client_secret={{3}}&amp;redirect_uri={{4}}&amp;grant_type=authorization_code">
												<variableReferenceExpression name="codeType"/>
												<argumentReferenceExpression name="code"/>
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="ClientSecret">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="RedirectUri">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.Byte[]" name="bodyBytes">
										<init>
											<methodInvokeExpression methodName="GetBytes">
												<target>
													<propertyReferenceExpression name="UTF8">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="body"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentType">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="application/x-www-form-urlencoded"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentLength">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Length">
											<variableReferenceExpression name="bodyBytes"/>
										</propertyReferenceExpression>
									</assignStatement>
									<usingStatement>
										<variable type="Stream" name="stream">
											<init>
												<methodInvokeExpression methodName="GetRequestStream">
													<target>
														<variableReferenceExpression name="request"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variable>
										<statements>
											<methodInvokeExpression methodName="Write">
												<target>
													<variableReferenceExpression name="stream"/>
												</target>
												<parameters>
													<variableReferenceExpression name="bodyBytes"/>
													<primitiveExpression value="0"/>
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="bodyBytes"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</usingStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetQueryRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetQueryRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.String" name="token"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="https://api.linkedin.com/v2/"/>
														<argumentReferenceExpression name="method"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<propertyReferenceExpression name="Authorization">
													<typeReferenceExpression type="HttpRequestHeader"/>
												</propertyReferenceExpression>
											</indices>
										</arrayIndexerExpression>
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="Bearer "/>
											<argumentReferenceExpression name="token"/>
										</binaryOperatorExpression>
									</assignStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- SharePointOAuthHandler-->
					<typeDeclaration isPartial="true" name="SharePointOAuthHandler">
						<baseTypes>
							<typeReference type="SharePointOAuthHandlerBase"/>
						</baseTypes>
					</typeDeclaration>
					<!-- SharePointOAuthHandlerBase-->
					<typeDeclaration name="SharePointOAuthHandlerBase">
						<baseTypes>
							<typeReference type="OAuthHandler"/>
						</baseTypes>
						<members>
							<!-- field _realm-->
							<memberField type="System.String" name="realm"/>
							<!-- field _showNavigation-->
							<memberField type="System.String" name="showNavigation"/>
							<!-- field _userObj-->
							<memberField type="JObject" name="userObj"/>
							<!-- method GetHandlerName-->
							<memberMethod returnType="System.String" name="GetHandlerName">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="SharePoint"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- property Scope-->
							<memberProperty type="System.String" name="Scope">
								<attributes override="true" family="true"/>
								<getStatements>
									<variableDeclarationStatement type="System.String" name="sc">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Config"/>
												</target>
												<indices>
													<primitiveExpression value="Scope"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="StoreToken"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="sc"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="sc"/>
													<primitiveExpression value=" Web.Read AllProfiles.Read"/>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Trim">
											<target>
												<variableReferenceExpression name="sc"/>
											</target>
										</methodInvokeExpression>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method GetAuthorizationUrl-->
							<memberMethod name="GetAuthorizationUrl" returnType="System.String">
								<attributes public="true" override="true"/>
								<statements>
									<variableDeclarationStatement type="System.String" name="version">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Config"/>
												</target>
												<indices>
													<primitiveExpression value="Version"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<variableReferenceExpression name="version"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="version"/>
												<primitiveExpression value="15" convertTo="String"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="authUrl">
										<init>
											<stringFormatExpression format="{{0}}/_layouts/{{1}}/OAuthAuthorize.aspx?client_id={{2}}&amp;scope={{3}}&amp;response_type=code&amp;redirect_uri={{4}}&amp;state={{5}}">
												<propertyReferenceExpression name="ClientUri"/>
												<variableReferenceExpression name="version"/>
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="EscapeDataString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Scope"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="EscapeDataString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="RedirectUri">
															<propertyReferenceExpression name="Config"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="EscapeDataString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="GetState"/>
													</parameters>
												</methodInvokeExpression>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="authUrl"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAccessTokenRequest-->
							<memberMethod returnType="WebRequest" name="GetAccessTokenRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="code"/>
									<parameter type="System.Boolean" name="refresh"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="realm"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="WebRequest" name="getRealm">
												<init>
													<methodInvokeExpression methodName="Create">
														<target>
															<typeReferenceExpression type="WebRequest"/>
														</target>
														<parameters>
															<binaryOperatorExpression operator="Add">
																<propertyReferenceExpression name="ClientUri"/>
																<primitiveExpression value="/_vti_bin/client.svc"/>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<methodInvokeExpression methodName="Add">
												<target>
													<propertyReferenceExpression name="Headers">
														<variableReferenceExpression name="getRealm"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<propertyReferenceExpression name="Authorization">
														<typeReferenceExpression type="HttpRequestHeader"/>
													</propertyReferenceExpression>
													<primitiveExpression value="Bearer"/>
												</parameters>
											</methodInvokeExpression>
											<variableDeclarationStatement type="WebResponse" name="response"/>
											<tryStatement>
												<statements>
													<assignStatement>
														<variableReferenceExpression name="response"/>
														<methodInvokeExpression methodName="GetResponse">
															<target>
																<variableReferenceExpression name="getRealm"/>
															</target>
														</methodInvokeExpression>
													</assignStatement>
												</statements>
												<catch exceptionType="WebException" localName="ex">
													<assignStatement>
														<variableReferenceExpression name="response"/>
														<propertyReferenceExpression name="Response">
															<variableReferenceExpression name="ex"/>
														</propertyReferenceExpression>
													</assignStatement>
												</catch>
											</tryStatement>
											<variableDeclarationStatement type="System.String" name="wwwAuthentication">
												<init>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Headers">
																<variableReferenceExpression name="response"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="WWW-Authenticate"/>
														</indices>
													</arrayIndexerExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="Match" name="realmMatch">
												<init>
													<methodInvokeExpression methodName="Match">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<variableReferenceExpression name="wwwAuthentication"/>
															<primitiveExpression value="Bearer realm=&quot;(.+?)&quot;"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<fieldReferenceExpression name="realm"/>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<variableReferenceExpression name="realmMatch"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="1"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Add">
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="https://accounts.accesscontrol.windows.net/"/>
															<fieldReferenceExpression name="realm"/>
														</binaryOperatorExpression>
														<primitiveExpression value="/tokens/OAuth/2"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Method">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="POST"/>
									</assignStatement>
									<variableDeclarationStatement type="System.String" name="grantType">
										<init>
											<primitiveExpression value="authorization_code"/>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="codeName">
										<init>
											<primitiveExpression value="code"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<argumentReferenceExpression name="refresh"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="grantType"/>
												<primitiveExpression value="refresh_token"/>
											</assignStatement>
											<assignStatement>
												<variableReferenceExpression name="codeName"/>
												<variableReferenceExpression name="grantType"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="body">
										<init>
											<stringFormatExpression>
												<xsl:attribute name="format"><![CDATA[grant_type={0}&client_id={1}%40{2}&client_secret={3}&{4}={5}&redirect_uri={6}&resource=00000003-0000-0ff1-ce00-000000000000%2F{7}%40{2}]]></xsl:attribute>
												<variableReferenceExpression name="grantType"/>
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<fieldReferenceExpression name="realm"/>
												<methodInvokeExpression methodName="EscapeDataString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="ClientSecret">
															<propertyReferenceExpression name="Config"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<variableReferenceExpression name="codeName"/>
												<argumentReferenceExpression name="code"/>
												<propertyReferenceExpression name="RedirectUri">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="Substring">
													<target>
														<propertyReferenceExpression name="ClientUri"/>
													</target>
													<parameters>
														<primitiveExpression value="8"/>
													</parameters>
												</methodInvokeExpression>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.Byte[]" name="bodyBytes">
										<init>
											<methodInvokeExpression methodName="GetBytes">
												<target>
													<propertyReferenceExpression name="UTF8">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="body"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentType">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="application/x-www-form-urlencoded"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentLength">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Length">
											<variableReferenceExpression name="bodyBytes"/>
										</propertyReferenceExpression>
									</assignStatement>
									<usingStatement>
										<variable type="Stream" name="stream">
											<init>
												<methodInvokeExpression methodName="GetRequestStream">
													<target>
														<variableReferenceExpression name="request"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variable>
										<statements>
											<methodInvokeExpression methodName="Write">
												<target>
													<variableReferenceExpression name="stream"/>
												</target>
												<parameters>
													<variableReferenceExpression name="bodyBytes"/>
													<primitiveExpression value="0"/>
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="bodyBytes"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</usingStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetQueryRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetQueryRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.String" name="token"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<stringFormatExpression format="{{0}}/_api/{{1}}">
														<propertyReferenceExpression name="ClientUri"/>
														<argumentReferenceExpression name="method"/>
													</stringFormatExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Accept">
											<castExpression targetType="HttpWebRequest">
												<variableReferenceExpression name="request"/>
											</castExpression>
										</propertyReferenceExpression>
										<primitiveExpression value="application/json;odata=verbose"/>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<propertyReferenceExpression name="Authorization">
													<typeReferenceExpression type="HttpRequestHeader"/>
												</propertyReferenceExpression>
											</indices>
										</arrayIndexerExpression>
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="Bearer "/>
											<variableReferenceExpression name="token"/>
										</binaryOperatorExpression>
									</assignStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method Query(string)-->
							<memberMethod returnType="JObject" name="Query">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.Boolean" name="useSystemToken"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="JObject" name="result">
										<init>
											<methodInvokeExpression methodName="Query">
												<target>
													<baseReferenceExpression/>
												</target>
												<parameters>
													<variableReferenceExpression name="method"/>
													<variableReferenceExpression name="useSystemToken"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanOr">
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="result"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="IdentityEquality">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="result"/>
														</target>
														<indices>
															<primitiveExpression value="d"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<variableReferenceExpression name="result"/>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<castExpression targetType="JObject">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="result"/>
												</target>
												<indices>
													<primitiveExpression value="d"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetState()-->
							<memberMethod returnType="System.String" name="GetState">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<binaryOperatorExpression operator="Add">
											<binaryOperatorExpression operator="Add">
												<methodInvokeExpression methodName="GetState">
													<target>
														<baseReferenceExpression/>
													</target>
												</methodInvokeExpression>
												<primitiveExpression value="|showNavigation="/>
											</binaryOperatorExpression>
											<fieldReferenceExpression name="showNavigation"/>
										</binaryOperatorExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method SetState(string)-->
							<memberMethod name="SetState">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="state"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="SetState">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<variableReferenceExpression name="state"/>
										</parameters>
									</methodInvokeExpression>
									<foreachStatement>
										<variable type="System.String" name="part"/>
										<target>
											<methodInvokeExpression methodName="Split">
												<target>
													<variableReferenceExpression name="state"/>
												</target>
												<parameters>
													<primitiveExpression value="|" convertTo="Char"/>
												</parameters>
											</methodInvokeExpression>
										</target>
										<statements>
											<variableDeclarationStatement type="System.String[]" name="ps">
												<init>
													<methodInvokeExpression methodName="Split">
														<target>
															<variableReferenceExpression name="part"/>
														</target>
														<parameters>
															<primitiveExpression value="=" convertTo="Char"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="ps"/>
															</target>
															<indices>
																<primitiveExpression value="0"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="showNavigation"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<fieldReferenceExpression name="showNavigation"/>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="ps"/>
															</target>
															<indices>
																<primitiveExpression value="1"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserName()-->
							<memberMethod returnType="System.String" name="GetUserName">
								<attributes public="true" override="true"/>
								<statements>
									<assignStatement>
										<fieldReferenceExpression name="userObj"/>
										<methodInvokeExpression methodName="Query">
											<parameters>
												<primitiveExpression value="Web/CurrentUser"/>
												<primitiveExpression value="false"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Last">
											<target>
												<methodInvokeExpression methodName="Split">
													<target>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<fieldReferenceExpression name="userObj"/>
																</target>
																<indices>
																	<primitiveExpression value="LoginName"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
													</target>
													<parameters>
														<primitiveExpression value="|" convertTo="Char"/>
													</parameters>
												</methodInvokeExpression>
											</target>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserRoles()-->
							<memberMethod returnType="List" name="GetUserRoles">
								<typeArguments>
									<typeReference type="System.String"/>
								</typeArguments>
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="List" name="roles">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
										<init>
											<methodInvokeExpression methodName="GetUserRoles">
												<target>
													<baseReferenceExpression/>
												</target>
												<parameters>
													<variableReferenceExpression name="user"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="JObject" name="groups">
										<init>
											<methodInvokeExpression methodName="Query">
												<parameters>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="Web/GetUserById("/>
														<binaryOperatorExpression operator="Add">
															<castExpression targetType="System.String">
																<arrayIndexerExpression>
																	<target>
																		<fieldReferenceExpression name="userObj"/>
																	</target>
																	<indices>
																		<primitiveExpression value="Id"/>
																	</indices>
																</arrayIndexerExpression>
															</castExpression>
															<primitiveExpression value=")/Groups"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
													<unaryOperatorExpression operator="Not">
														<propertyReferenceExpression name="StoreToken"/>
													</unaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="groups"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<throwExceptionStatement>
												<objectCreateExpression type="Exception">
													<parameters>
														<primitiveExpression value="Unable to get roles."/>
													</parameters>
												</objectCreateExpression>
											</throwExceptionStatement>
										</trueStatements>
									</conditionStatement>
									<foreachStatement>
										<variable type="JToken" name="group"/>
										<target>
											<methodInvokeExpression methodName="Children">
												<target>
													<castExpression targetType="JArray">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="groups"/>
															</target>
															<indices>
																<primitiveExpression value="results"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</target>
											</methodInvokeExpression>
										</target>
										<statements>
											<variableDeclarationStatement type="System.String" name="name">
												<init>
													<castExpression targetType="System.String">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="group"/>
															</target>
															<indices>
																<primitiveExpression value="LoginName"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="StartsWith">
															<target>
																<variableReferenceExpression name="name"/>
															</target>
															<parameters>
																<primitiveExpression value="SharingLinks."/>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="Add">
														<target>
															<variableReferenceExpression name="roles"/>
														</target>
														<parameters>
															<variableReferenceExpression name="name"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="roles"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method RestoreSession()-->
							<memberMethod name="RestoreSession">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="HttpContext" name="context"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="showNavigation"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="showNavigation"/>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<propertyReferenceExpression name="Request">
																<variableReferenceExpression name="context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="showNavigation"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="session">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="QueryString">
														<propertyReferenceExpression name="Request">
															<variableReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="session"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="session"/>
												</unaryOperatorExpression>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="session"/>
													<primitiveExpression value="new"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="UserLogout">
												<target>
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</target>
											</methodInvokeExpression>
										</trueStatements>
										<falseStatements>
											<methodInvokeExpression methodName="RestoreSession">
												<target>
													<baseReferenceExpression/>
												</target>
												<parameters>
													<variableReferenceExpression name="context"/>
												</parameters>
											</methodInvokeExpression>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<unaryOperatorExpression operator="Not">
															<propertyReferenceExpression name="StoreToken"/>
														</unaryOperatorExpression>
														<propertyReferenceExpression name="IsAuthenticated">
															<propertyReferenceExpression name="Identity">
																<propertyReferenceExpression name="User">
																	<variableReferenceExpression name="context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="RedirectToStartPage">
														<parameters>
															<variableReferenceExpression name="context"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</falseStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method RedirectToStartPage-->
							<memberMethod name="RedirectToStartPage">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="HttpContext" name="context"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="System.String" name="connector">
										<init>
											<primitiveExpression value="?"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="Contains">
												<target>
													<variableReferenceExpression name="StartPage"/>
												</target>
												<parameters>
													<primitiveExpression value="?"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="connector"/>
												<primitiveExpression value="&amp;"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<propertyReferenceExpression name="StartPage"/>
										<binaryOperatorExpression operator="Add">
											<binaryOperatorExpression operator="Add">
												<propertyReferenceExpression name="StartPage"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="connector"/>
													<primitiveExpression value="_showNavigation="/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
											<fieldReferenceExpression name="showNavigation"/>
										</binaryOperatorExpression>
									</assignStatement>
									<methodInvokeExpression methodName="RedirectToStartPage">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<variableReferenceExpression name="context"/>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method GetUserImageUrl(Membershipuser)-->
							<memberMethod returnType="System.String" name="GetUserImageUrl">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="JObject" name="info">
										<init>
											<methodInvokeExpression methodName="Query">
												<parameters>
													<stringFormatExpression>
														<xsl:attribute name="format"><![CDATA[SP.UserProfiles.PeopleManager/GetPropertiesFor(accountName=@v)?@v='{0}'&$select=PictureUrl]]></xsl:attribute>
														<methodInvokeExpression methodName="UrlEncode">
															<target>
																<typeReferenceExpression type="HttpUtility"/>
															</target>
															<parameters>
																<castExpression targetType="System.String">
																	<arrayIndexerExpression>
																		<target>
																			<fieldReferenceExpression name="userObj"/>
																		</target>
																		<indices>
																			<primitiveExpression value="LoginName"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
															</parameters>
														</methodInvokeExpression>
													</stringFormatExpression>
													<primitiveExpression value="true"/>
												</parameters>
											</methodInvokeExpression>

										</init>
									</variableDeclarationStatement>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="info"/>
												</target>
												<indices>
													<primitiveExpression value="PictureUrl"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- WindowsLiveOAuthHandler-->
					<typeDeclaration isPartial="true" name="WindowsLiveOAuthHandler">
						<baseTypes>
							<typeReference type="WindowsLiveOAuthHandlerBase"/>
						</baseTypes>
					</typeDeclaration>
					<!-- WindowsLiveOAuthHandlerBase-->
					<typeDeclaration isPartial="true" name="WindowsLiveOAuthHandlerBase">
						<baseTypes>
							<typeReference type="OAuthHandler"/>
						</baseTypes>
						<members>
							<!-- method GetHandlerName()-->
							<memberMethod returnType="System.String" name="GetHandlerName">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="WindowsLive"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- property Scope-->
							<memberProperty type="System.String" name="Scope">
								<attributes override="true" family="true"/>
								<getStatements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Trim">
											<target>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="wl.emails "/>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Config"/>
														</target>
														<indices>
															<primitiveExpression value="Scope"/>
														</indices>
													</arrayIndexerExpression>
												</binaryOperatorExpression>
											</target>
										</methodInvokeExpression>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method GetAuthorizationUrl()-->
							<memberMethod name="GetAuthorizationUrl" returnType="System.String">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<stringFormatExpression format="https://login.live.com/oauth20_authorize.srf?client_id={{0}}&amp;scope={{1}}&amp;response_type=code&amp;redirect_uri={{2}}&amp;state={{3}}">
											<propertyReferenceExpression name="ClientId">
												<propertyReferenceExpression name="Config"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Scope"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="RedirectUri">
														<propertyReferenceExpression name="Config"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="GetState"/>
												</parameters>
											</methodInvokeExpression>
										</stringFormatExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAccessTokenRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetAccessTokenRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="code"/>
									<parameter type="System.Boolean" name="refresh"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<primitiveExpression value="https://login.live.com/oauth20_token.srf"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Method">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="POST"/>
									</assignStatement>
									<variableDeclarationStatement type="System.String" name="codeName">
										<init>
											<primitiveExpression value="code"/>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="grantType">
										<init>
											<primitiveExpression value="authorization_code"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<argumentReferenceExpression name="refresh"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="codeName"/>
												<primitiveExpression value="refresh_token"/>
											</assignStatement>
											<assignStatement>
												<variableReferenceExpression name="grantType"/>
												<variableReferenceExpression name="codeName"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="body">
										<init>
											<stringFormatExpression format="client_id={{0}}&amp;redirect_uri={{1}}&amp;client_secret={{2}}&amp;{{3}}={{4}}&amp;grant_type={{5}}">
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="RedirectUri">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="ClientSecret">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="codeName"/>
												<variableReferenceExpression name="code"/>
												<variableReferenceExpression name="grantType"/>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.Byte[]" name="bodyBytes">
										<init>
											<methodInvokeExpression methodName="GetBytes">
												<target>
													<propertyReferenceExpression name="UTF8">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="body"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentType">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="application/x-www-form-urlencoded"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentLength">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Length">
											<variableReferenceExpression name="bodyBytes"/>
										</propertyReferenceExpression>
									</assignStatement>
									<usingStatement>
										<variable type="Stream" name="stream">
											<init>
												<methodInvokeExpression methodName="GetRequestStream">
													<target>
														<variableReferenceExpression name="request"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variable>
										<statements>
											<methodInvokeExpression methodName="Write">
												<target>
													<variableReferenceExpression name="stream"/>
												</target>
												<parameters>
													<variableReferenceExpression name="bodyBytes"/>
													<primitiveExpression value="0"/>
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="bodyBytes"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</usingStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetQueryRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetQueryRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.String" name="token"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="System.String" name="version">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Config"/>
												</target>
												<indices>
													<primitiveExpression value="Version"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<variableReferenceExpression name="version"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="version"/>
												<primitiveExpression value="v5.0"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Create">
											<target>
												<typeReferenceExpression type="WebRequest"/>
											</target>
											<parameters>
												<stringFormatExpression format="https://apis.live.net/{{0}}/{{1}}?access_token={{2}}">
													<variableReferenceExpression name="version"/>
													<variableReferenceExpression name="method"/>
													<variableReferenceExpression name="token"/>
												</stringFormatExpression>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserName()-->
							<memberMethod returnType="System.String" name="GetUserName">
								<attributes public="true" override="true"/>
								<statements>
									<variableDeclarationStatement type="JObject" name="userObj">
										<init>
											<methodInvokeExpression methodName="Query">
												<parameters>
													<primitiveExpression value="me"/>
													<primitiveExpression value="false"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="userObj"/>
														</target>
														<indices>
															<primitiveExpression value="emails"/>
														</indices>
													</arrayIndexerExpression>
												</target>
												<indices>
													<primitiveExpression value="account"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- IdentityServerOAuthHandler-->
					<typeDeclaration isPartial="true" name="IdentityServerOAuthHandler">
						<baseTypes>
							<typeReference type="IdentityServerOAuthHandlerBase"/>
						</baseTypes>
					</typeDeclaration>
					<!-- IdentityServerOAuthHandlerBase-->
					<typeDeclaration isPartial="true" name="IdentityServerOAuthHandlerBase">
						<baseTypes>
							<typeReference type="OAuthHandler"/>
						</baseTypes>
						<members>
							<!-- property Scope-->
							<memberProperty type="System.String" name="Scope">
								<attributes family="true" override="true"/>
								<getStatements>
									<variableDeclarationStatement type="System.String" name="configScope">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Config"/>
												</target>
												<indices>
													<primitiveExpression value="Scope"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="configScope"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<variableReferenceExpression name="configScope"/>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<primitiveExpression value="openid email"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method GetHandlerName-->
							<memberMethod returnType="System.String" name="GetHandlerName">
								<attributes override="true" public="true"/>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="IdentityServer"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAuthorizationUrl()-->
							<memberMethod name="GetAuthorizationUrl" returnType="System.String">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<stringFormatExpression format="{{0}}/connect/authorize?response_type=code&amp;client_id={{1}}&amp;redirect_uri={{2}}&amp;scope={{3}}&amp;state={{4}}">
											<propertyReferenceExpression name="ClientUri"/>
											<propertyReferenceExpression name="ClientId">
												<propertyReferenceExpression name="Config"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="RedirectUri">
												<propertyReferenceExpression name="Config"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Scope"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="GetState"/>
												</parameters>
											</methodInvokeExpression>
										</stringFormatExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAccessTokenRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetAccessTokenRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="code"/>
									<parameter type="System.Boolean" name="refresh"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Add">
														<propertyReferenceExpression name="ClientUri"/>
														<primitiveExpression value="/connect/token"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Method">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="POST"/>
									</assignStatement>
									<variableDeclarationStatement type="System.String" name="codeName">
										<init>
											<primitiveExpression value="code"/>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="grantType">
										<init>
											<primitiveExpression value="authorization_code"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<argumentReferenceExpression name="refresh"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="codeName"/>
												<primitiveExpression value="refresh_token"/>
											</assignStatement>
											<assignStatement>
												<variableReferenceExpression name="grantType"/>
												<variableReferenceExpression name="codeName"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="body">
										<init>
											<stringFormatExpression format="client_id={{0}}&amp;redirect_uri={{1}}&amp;client_secret={{2}}&amp;{{3}}={{4}}&amp;grant_type={{5}}">
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="RedirectUri">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="ClientSecret">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="codeName"/>
												<variableReferenceExpression name="code"/>
												<variableReferenceExpression name="grantType"/>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.Byte[]" name="bodyBytes">
										<init>
											<methodInvokeExpression methodName="GetBytes">
												<target>
													<propertyReferenceExpression name="UTF8">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="body"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentType">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="application/x-www-form-urlencoded"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentLength">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Length">
											<variableReferenceExpression name="bodyBytes"/>
										</propertyReferenceExpression>
									</assignStatement>
									<usingStatement>
										<variable type="Stream" name="stream">
											<init>
												<methodInvokeExpression methodName="GetRequestStream">
													<target>
														<variableReferenceExpression name="request"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variable>
										<statements>
											<methodInvokeExpression methodName="Write">
												<target>
													<variableReferenceExpression name="stream"/>
												</target>
												<parameters>
													<variableReferenceExpression name="bodyBytes"/>
													<primitiveExpression value="0"/>
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="bodyBytes"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</usingStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetQueryRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetQueryRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.String" name="token"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<stringFormatExpression format="{{0}}/connect/{{1}}">
														<propertyReferenceExpression name="ClientUri"/>
														<argumentReferenceExpression name="method"/>
													</stringFormatExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<propertyReferenceExpression name="Authorization">
													<typeReferenceExpression type="HttpRequestHeader"/>
												</propertyReferenceExpression>
											</indices>
										</arrayIndexerExpression>
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="Bearer "/>
											<variableReferenceExpression name="token"/>
										</binaryOperatorExpression>
									</assignStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserName()-->
							<memberMethod returnType="System.String" name="GetUserName">
								<attributes public="true" override="true"/>
								<statements>
									<variableDeclarationStatement type="JObject" name="userObj">
										<init>
											<methodInvokeExpression methodName="Query">
												<parameters>
													<primitiveExpression value="userinfo"/>
													<primitiveExpression value="false"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="userObj"/>
												</target>
												<indices>
													<primitiveExpression value="email"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
				</xsl:if>
			</types>
		</compileUnit>
	</xsl:template>
	<xsl:template name="DeclareRequestAndResponse">
		<variableDeclarationStatement type="HttpRequest" name="request">
			<init>
				<propertyReferenceExpression name="Request">
					<argumentReferenceExpression name="context"/>
				</propertyReferenceExpression>
			</init>
		</variableDeclarationStatement>
		<variableDeclarationStatement type="HttpResponse" name="response">
			<init>
				<propertyReferenceExpression name="Response">
					<argumentReferenceExpression name="context"/>
				</propertyReferenceExpression>
			</init>
		</variableDeclarationStatement>
	</xsl:template>
</xsl:stylesheet>
