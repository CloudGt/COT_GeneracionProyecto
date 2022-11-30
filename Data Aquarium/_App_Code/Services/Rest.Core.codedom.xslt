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
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.IO.Compression"/>
				<namespaceImport name="System.Net"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Threading"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Caching"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Handlers"/>
			</imports>
			<types>
				<!-- class SimpleConfigDictionary -->
				<typeDeclaration name="SimpleConfigDictionary">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="SortedDictionary">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="XPathNavigator"/>
							</typeArguments>
						</typeReference>
					</baseTypes>
				</typeDeclaration>
				<!-- class ConfigDictionary-->
				<typeDeclaration name="ConfigDictionary">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="SimpleConfigDictionary"/>
					</baseTypes>
					<members>
						<!-- property this[string] -->
						<memberProperty type="XPathNavigator" name="Item">
							<attributes public="true" final="true" new="true"/>
							<parameters>
								<parameter type="System.String" name="key"/>
							</parameters>
							<getStatements>
								<methodReturnStatement>
									<arrayIndexerExpression>
										<target>
											<baseReferenceExpression/>
										</target>
										<indices>
											<methodInvokeExpression methodName="NormalizeKey">
												<parameters>
													<argumentReferenceExpression name="key"/>
												</parameters>
											</methodInvokeExpression>
										</indices>
									</arrayIndexerExpression>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<baseReferenceExpression/>
										</target>
										<indices>
											<methodInvokeExpression methodName="NormalizeKey">
												<parameters>
													<argumentReferenceExpression name="key"/>
												</parameters>
											</methodInvokeExpression>
										</indices>
									</arrayIndexerExpression>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- method ContainsKey(string) -->
						<memberMethod returnType="System.Boolean" name="ContainsKey">
							<attributes public="true" final="true" new="true"/>
							<parameters>
								<parameter type="System.String" name="key"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ContainsKey">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="NormalizeKey">
												<parameters>
													<argumentReferenceExpression name="key"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method TryGetValue(string, out XPathNavigator) -->
						<memberMethod returnType="System.Boolean" name="TryGetValue">
							<attributes public="true" final="true" new="true"/>
							<parameters>
								<parameter type="System.String" name="key"/>
								<parameter type="XPathNavigator" name="value" direction="Out"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="TryGetValue">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="NormalizeKey">
												<parameters>
													<argumentReferenceExpression name="key"/>
												</parameters>
											</methodInvokeExpression>
											<directionExpression direction="Out">
												<argumentReferenceExpression name="value"/>
											</directionExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Add(string, XPathNavigator)  -->
						<memberMethod name="Add">
							<attributes public="true" final="true" new="true"/>
							<parameters>
								<parameter type="System.String" name="key"/>
								<parameter type="XPathNavigator" name="value"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="Add">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<methodInvokeExpression methodName="NormalizeKey">
											<parameters>
												<argumentReferenceExpression name="key"/>
											</parameters>
										</methodInvokeExpression>
										<argumentReferenceExpression name="value"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method NormalizeKey(string) -->
						<memberMethod returnType="System.String" name="NormalizeKey">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="key"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Replace">
										<target>
											<methodInvokeExpression methodName="Replace">
												<target>
													<methodInvokeExpression methodName="ToLower">
														<target>
															<argumentReferenceExpression name="key"/>
														</target>
													</methodInvokeExpression>
												</target>
												<parameters>
													<primitiveExpression value="-"/>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
										</target>
										<parameters>
											<primitiveExpression value="_"/>
											<stringEmptyExpression/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class RESTfulResourceConfiguration -->
				<typeDeclaration name="RESTfulResourceConfiguration">
					<attributes public="true"/>
					<members>
						<!-- field controllerResource -->
						<memberField type="System.String" name="controllerResource"/>
						<!-- field controllerName -->
						<memberField type="System.String" name="controllerName"/>
						<!-- public AccessTokenSize -->
						<memberField type="System.Int32" name="AccessTokenSize">
							<attributes public="true" static="true"/>
							<init>
								<primitiveExpression value="80"/>
							</init>
						</memberField>
						<!-- public RefreshTokensize -->
						<memberField type="System.Int32" name="RefreshTokenSize">
							<attributes public="true" static="true"/>
							<init>
								<primitiveExpression value="64"/>
							</init>
						</memberField>
						<!-- public AuthorizationRequestLifespan -->
						<memberField type="System.Int32" name="AuthorizationRequestLifespan">
							<attributes public="true" static="true"/>
							<init>
								<primitiveExpression value="15"/>
							</init>
						</memberField>
						<!-- public AuthorizationCodeLifespan -->
						<memberField type="System.Int32" name="AuthorizationCodeLifespan">
							<attributes public="true" static="true"/>
							<init>
								<primitiveExpression value="2"/>
							</init>
						</memberField>
						<!-- public MaximumPictureLifespan -->
						<memberField type="System.Int32" name="MaximumPictureLifespan">
							<attributes public="true" static="true"/>
							<init>
								<binaryOperatorExpression operator="Multiply">
									<primitiveExpression value="24"/>
									<primitiveExpression value="60"/>
								</binaryOperatorExpression>
							</init>
						</memberField>
						<!-- property App -->
						<memberProperty type="ApplicationServices" name="App">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<propertyReferenceExpression name="Current">
										<typeReferenceExpression type="ApplicationServicesBase"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property ReplaceEmbedded -->
						<memberProperty type="System.Boolean" name="ReplaceEmbedded">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property RemoveLinks -->
						<memberProperty type="System.Boolean" name="RemoveLinks">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property OutputContentType -->
						<memberProperty type="System.String" name="OutputContentType">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ControllerName -->
						<memberProperty type="System.String" name="ControllerName">
							<attributes public="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="controllerName"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="controllerName"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<fieldReferenceExpression name="controllerName"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="controllerResource"/>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<fieldReferenceExpression name="controllerResource"/>
											<methodInvokeExpression methodName="ToPathName">
												<parameters>
													<propertySetValueReferenceExpression/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="limit"/>
											<convertExpression to="Int32">
												<methodInvokeExpression methodName="SettingsProperty">
													<target>
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</target>
													<parameters>
														<primitiveExpression value="server.rest.output.limit.default"/>
														<primitiveExpression value="100"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="pageSize"/>
											<convertExpression to="Int32">
												<methodInvokeExpression methodName="SettingsProperty">
													<target>
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</target>
													<parameters>
														<primitiveExpression value="server.rest.output.pageSize.default"/>
														<primitiveExpression value="10"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="limit"/>
											<convertExpression to="Int32">
												<methodInvokeExpression methodName="SettingsProperty">
													<target>
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</target>
													<parameters>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="server.rest.output.limit."/>
															<propertyReferenceExpression name="ControllerResource"/>
														</binaryOperatorExpression>
														<fieldReferenceExpression name="limit"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="pageSize"/>
											<convertExpression to="Int32">
												<methodInvokeExpression methodName="SettingsProperty">
													<target>
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</target>
													<parameters>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="server.rest.output.pageSize."/>
															<propertyReferenceExpression name="ControllerResource"/>
														</binaryOperatorExpression>
														<fieldReferenceExpression name="pageSize"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
							</setStatements>
						</memberProperty>
						<!-- property ControllerResource -->
						<memberProperty type="System.String" name="ControllerResource">
							<attributes public="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="controllerResource"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property PathView -->
						<memberProperty type="System.String" name="PathView">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property PathAction -->
						<memberField type="System.String" name="pathAction"/>
						<memberProperty type="System.String" name="PathAction">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="pathAction"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="pathAction"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="pathField"/>
									<primitiveExpression value="null"/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property PathCollectionView -->
						<memberProperty type="System.String" name="PathCollectionView">
							<attributes public="true" final="true"/>
							<getStatements>
								<variableDeclarationStatement name="result">
									<init>
										<propertyReferenceExpression name="PathView"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<variableReferenceExpression name="result"/>
											</unaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<variableReferenceExpression name="result"/>
												<methodInvokeExpression methodName="DefaultView">
													<parameters>
														<primitiveExpression value="collection"/>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<stringEmptyExpression/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="Add">
										<primitiveExpression value="/"/>
										<methodInvokeExpression methodName="ToPathName">
											<parameters>
												<variableReferenceExpression name="result"/>
											</parameters>
										</methodInvokeExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property PathObjectView -->
						<memberProperty type="System.String" name="PathObjectView">
							<attributes public="true" final="true"/>
							<getStatements>
								<variableDeclarationStatement name="result">
									<init>
										<propertyReferenceExpression name="PathView"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="result"/>
											<methodInvokeExpression methodName="DefaultView">
												<parameters>
													<primitiveExpression value="singleton"/>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<stringEmptyExpression/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="Add">
										<primitiveExpression value="/"/>
										<variableReferenceExpression name="result"/>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property PathKey -->
						<memberProperty type="System.String" name="PathKey">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property LastEntity -->
						<memberProperty type="System.String" name="LastEntity">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property PathField -->
						<memberField type="System.String" name="pathField"/>
						<memberProperty type="System.String" name="PathField">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="pathField"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="pathField"/>
									<methodInvokeExpression methodName="ToApiFieldName">
										<parameters>
											<propertySetValueReferenceExpression/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property Hypermedia -->
						<memberProperty type="System.Boolean" name="Hypermedia">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property OutputStyle -->
						<memberProperty type="System.String" name="OutputStyle">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property LinkStyle -->
						<memberProperty type="System.String" name="LinkStyle">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property LinkMethod -->
						<memberProperty type="System.Boolean" name="LinkMethod">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property LinksPosition -->
						<memberProperty type="System.String" name="LinksPosition">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property AllowsSchema -->
						<memberProperty type="System.Boolean" name="AllowsSchema">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property RequiresSchema -->
						<memberProperty type="System.Boolean" name="RequiresSchema">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property RequiresSchemaOnly -->
						<memberProperty type="System.Boolean" name="RequiresSchemaOnly">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanAnd">
										><binaryOperatorExpression operator="ValueInequality">
											<propertyReferenceExpression name="HttpMethod"/>
											<primitiveExpression value="GET"/>
										</binaryOperatorExpression>
										<binaryOperatorExpression operator="BooleanAnd">
											<propertyReferenceExpression name="RequiresSchema"/>
											<unaryOperatorExpression operator="Not">
												<propertyReferenceExpression name="RequiresData"/>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property RequiresData -->
						<memberProperty type="System.Boolean" name="RequiresData">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property EmbedParam -->
						<memberProperty type="System.String" name="EmbedParam">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property FilterParam -->
						<memberProperty type="System.String" name="FilterParam">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property LinksKey -->
						<memberProperty type="System.String" name="LinksKey">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property SchemaKey -->
						<memberProperty type="System.String" name="SchemaKey">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property EmbeddedKey -->
						<memberProperty type="System.String" name="EmbeddedKey">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property EmbeddableKey -->
						<memberProperty type="System.String" name="EmbeddableKey">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property XmlRoot -->
						<memberField type="System.String" name="xmlRoot"/>
						<memberProperty type="System.String" name="XmlRoot">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<fieldReferenceExpression name="xmlRoot"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="xmlRoot"/>
											<methodInvokeExpression methodName="ToApiNameTemplate">
												<parameters>
													<primitiveExpression value="xmlRoot"/>
													<propertyReferenceExpression name="ControllerName"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="xmlRoot"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property XmlItem -->
						<memberField type="System.String" name="xmlItem"/>
						<memberProperty type="System.String" name="XmlItem">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="xmlItem"/>
											</unaryOperatorExpression>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<propertyReferenceExpression name="XmlRoot"/>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="xmlItem"/>
											<methodInvokeExpression methodName="ToApiNameTemplate">
												<parameters>
													<primitiveExpression value="xmlItem"/>
													<propertyReferenceExpression name="ControllerName"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="xmlItem"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property CollectionKey -->
						<memberField type="System.String" name="collectionKey"/>
						<memberProperty type="System.String" name="CollectionKey">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<fieldReferenceExpression name="collectionKey"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="collectionKey"/>
											<methodInvokeExpression methodName="ToApiNameTemplate">
												<parameters>
													<primitiveExpression value="collection"/>
													<propertyReferenceExpression name="ControllerName"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="collectionKey"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property ParametersKey -->
						<memberProperty type="System.String" name="ParametersKey">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ChildrenKey -->
						<memberProperty type="System.String" name="ChildrenKey">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property RootKey -->
						<memberProperty type="System.String" name="RootKey">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property LatestVersionLink -->
						<memberProperty type="System.String" name="LatestVersionLink">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Config -->
						<memberField type="ControllerConfiguration" name="config"/>
						<memberProperty type="ControllerConfiguration" name="Config">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="config"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="config"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="ControllerName"/>
									<propertyReferenceExpression name="ControllerName">
										<fieldReferenceExpression name="config"/>
									</propertyReferenceExpression>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property RawUrl -->
						<memberProperty type="System.String" name="RawUrl">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property HttpMethod -->
						<memberProperty type="System.String" name="HttpMethod">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property IsImmutable -->
						<memberProperty type="System.Boolean" name="IsImmutable">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="ValueEquality">
										<propertyReferenceExpression name="HttpMethod"/>
										<primitiveExpression value="GET"/>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Parameters -->
						<memberProperty type="Dictionary" name="Parameters">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.Object"/>
							</typeArguments>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- field configList-->
						<memberField type="SortedDictionary" name="configList">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="ControllerConfiguration"/>
							</typeArguments>
						</memberField>
						<!-- field names-->
						<memberField type="SortedDictionary" name="names">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
						</memberField>
						<!-- property Limit -->
						<memberField type="System.Int32" name="limit"/>
						<memberProperty type="System.Int32" name="Limit">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="limit"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property PageSize -->
						<memberField type="System.Int32" name="pageSize"/>
						<memberProperty type="System.Int32" name="PageSize">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="pageSize"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property IdTokenDuration -->
						<memberProperty type="System.Int32" name="IdTokenDuration">
							<attributes public="true"/>
							<getStatements>
								<methodReturnStatement>
									<convertExpression to="Int32">
										<methodInvokeExpression methodName="SettingsProperty">
											<target>
												<typeReferenceExpression type="ApplicationServices"/>
											</target>
											<parameters>
												<primitiveExpression value="server.rest.authorization.oauth2.idTokenDuration"/>
												<methodInvokeExpression methodName="GetAccessTokenDuration">
													<target>
														<propertyReferenceExpression name="App"/>
													</target>
													<parameters>
														<primitiveExpression value="server.rest.authorization.oauth2.accessTokenDuration"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</convertExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property PictureLifespan -->
						<memberProperty type="System.Int32" name="PictureLifespan">
							<attributes public="true"/>
							<getStatements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Max">
										<target>
											<typeReferenceExpression type="Math"/>
										</target>
										<parameters>
											<propertyReferenceExpression name="MaximumPictureLifespan"/>
											<propertyReferenceExpression name="IdTokenDuration"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property EndpointValidator -->
						<memberField type="Regex" name="endpointValidator"/>
						<memberProperty type="Regex" name="EndpointValidator">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="endpointValidator"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property LastAclRole -->
						<memberField type="JProperty" name="lastAclRole"/>
						<memberProperty type="JProperty" name="LastAclRole">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="lastAclRole"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property IdClaims -->
						<memberProperty type="JObject" name="IdClaims">
							<attributes public="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property UserScopes -->
						<memberField type="List" name="userScopes">
							<typeArguments>
								<typeReference type="System.String"/>
							</typeArguments>
						</memberField>
						<memberProperty type="List" name="UserScopes">
							<typeArguments>
								<typeReference type="System.String"/>
							</typeArguments>
							<attributes public="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="userScopes"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="userScopes"/>
											<propertyReferenceExpression name="Scopes">
												<typeReferenceExpression type="RESTfulResource"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="userScopes"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method ToPathName(string) -->
						<memberMethod returnType="System.String" name="ToPathName">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToLower">
										<target>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="name"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[(\p{Ll})(\p{Lu})]]></xsl:attribute>
													</primitiveExpression>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[$1-$2]]></xsl:attribute>
													</primitiveExpression>
												</parameters>
											</methodInvokeExpression>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToApiName(string, string) -->
						<memberMethod returnType="System.String" name="ToApiName">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="baseName"/>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<assignStatement>
									<argumentReferenceExpression name="name"/>
									<methodInvokeExpression methodName="ToApiName">
										<parameters>
											<argumentReferenceExpression name="name"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="Add">
										<methodInvokeExpression methodName="ToPathName">
											<parameters>
												<argumentReferenceExpression name="baseName"/>
											</parameters>
										</methodInvokeExpression>
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="-"/>
											<methodInvokeExpression methodName="ToApiName">
												<parameters>
													<argumentReferenceExpression name="name"/>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToApiName(string) -->
						<memberMethod returnType="System.String" name="ToApiName">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="newName">
									<init>
										<stringEmptyExpression/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="TryGetValue">
											<target>
												<fieldReferenceExpression name="names"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="name"/>
												<directionExpression direction="Out">
													<variableReferenceExpression name="newName"/>
												</directionExpression>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="name"/>
											<variableReferenceExpression name="newName"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="name"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToApiFieldName(string) -->
						<memberMethod returnType="System.String" name="ToApiFieldName">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="OutputStyle"/>
											<primitiveExpression value="CamelCase"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<argumentReferenceExpression name="name"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<variableReferenceExpression name="name"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="name"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[^(ID|PK|FK)]]></xsl:attribute>
											</primitiveExpression>
											<addressOfExpression>
												<methodReferenceExpression methodName="ReplaceIdWithLowerAndLower"/>
											</addressOfExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="name"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="name"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[(\p{Ll})(ID|PK|FK|NO)]]></xsl:attribute>
											</primitiveExpression>
											<addressOfExpression>
												<methodReferenceExpression methodName="ReplaceIdWithUpperAndLower"/>
											</addressOfExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="OutputStyle"/>
											<primitiveExpression value="snake"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="name"/>
											<methodInvokeExpression methodName="ToLower">
												<target>
													<methodInvokeExpression methodName="Replace">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="name"/>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[(\p{Ll})(\p{Lu})]]></xsl:attribute>
															</primitiveExpression>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[$1_$2]]></xsl:attribute>
															</primitiveExpression>
														</parameters>
													</methodInvokeExpression>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="OutputStyle"/>
													<primitiveExpression value="lowercase"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="name"/>
													<methodInvokeExpression methodName="ToLower">
														<target>
															<argumentReferenceExpression name="name"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="name"/>
													<methodInvokeExpression methodName="Replace">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="name"/>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[^((\p{Lu})(\p{Ll}+))(\p{Lu}|$)]]></xsl:attribute>
															</primitiveExpression>
															<addressOfExpression>
																<methodReferenceExpression methodName="ReplaceIdWithLeadingLower"/>
															</addressOfExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="name"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToApiNameTemplate(string, string) -->
						<memberMethod returnType="System.String" name="ToApiNameTemplate">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="template"/>
								<parameter type="System.String" name="replaceWith"/>
							</parameters>
							<statements>
								<assignStatement>
									<argumentReferenceExpression name="template"/>
									<methodInvokeExpression methodName="ToApiName">
										<parameters>
											<argumentReferenceExpression name="template"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<argumentReferenceExpression name="template"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<argumentReferenceExpression name="template"/>
										</target>
										<parameters>
											<primitiveExpression value="{{name}}"/>
											<argumentReferenceExpression name="replaceWith"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToApiFieldName">
										<parameters>
											<argumentReferenceExpression name="template"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ReplaceIdWithUpperAndLower(Match) -->
						<memberMethod returnType="System.String" name="ReplaceIdWithUpperAndLower">
							<attributes private="true" static="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="id">
									<init>
										<propertyReferenceExpression name="Value">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Groups">
														<argumentReferenceExpression name="m"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="2"/>
												</indices>
											</arrayIndexerExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="Add">
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
										<binaryOperatorExpression operator="Add">
											<methodInvokeExpression methodName="Substring">
												<target>
													<variableReferenceExpression name="id"/>
												</target>
												<parameters>
													<primitiveExpression value="0"/>
													<primitiveExpression value="1"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="ToLower">
												<target>
													<methodInvokeExpression methodName="Substring">
														<target>
															<variableReferenceExpression name="id"/>
														</target>
														<parameters>
															<primitiveExpression value="1"/>
														</parameters>
													</methodInvokeExpression>
												</target>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ReplaceIdWithLowerAndLower(Match) -->
						<memberMethod returnType="System.String" name="ReplaceIdWithLowerAndLower">
							<attributes private="true" static="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToLower">
										<target>
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
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ReplaceIdWithLeadingLower(Match) -->
						<memberMethod returnType="System.String" name="ReplaceIdWithLeadingLower">
							<attributes private="true" static="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="Add">
										<methodInvokeExpression methodName="ToLower">
											<target>
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
												</propertyReferenceExpression>"
											</target>
										</methodInvokeExpression>
										<propertyReferenceExpression name="Value">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Groups">
														<argumentReferenceExpression name="m"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="4"/>
												</indices>
											</arrayIndexerExpression>
										</propertyReferenceExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToDataFieldName(string) -->
						<memberMethod returnType="System.String" name="ToDataFieldName">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="name"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[(_|^)(.)]]></xsl:attribute>
											</primitiveExpression>
											<addressOfExpression>
												<methodReferenceExpression methodName="ReplaceWithUpper"/>
											</addressOfExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ReplaceWithUpper(Match) -->
						<memberMethod returnType="System.String" name="ReplaceWithUpper">
							<attributes private="true" static="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToUpper">
										<target>
											<propertyReferenceExpression name="Value">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Groups">
															<argumentReferenceExpression name="m"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="2"/>
													</indices>
												</arrayIndexerExpression>
											</propertyReferenceExpression>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToFieldDictionary(string, string) -->
						<memberMethod returnType="Dictionary" name="ToFieldDictionary">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="DataField"/>
							</typeArguments>
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="controllerName"/>
								<parameter type="System.String" name="view"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="r">
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
									<propertyReferenceExpression name="DoesNotRequireData">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="DoesNotRequireAggregates">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<variableDeclarationStatement name="p">
									<init>
										<methodInvokeExpression methodName="GetPage">
											<target>
												<methodInvokeExpression methodName="CreateDataController">
													<target>
														<typeReferenceExpression type="ControllerFactory"/>
													</target>
												</methodInvokeExpression>
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
								<variableDeclarationStatement name="dictionary">
									<init>
										<objectCreateExpression type="Dictionary">
											<typeArguments>
												<typeReference type="System.String"/>
												<typeReference type="DataField"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="apiNone">
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="DataField"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable name="field"/>
									<target>
										<propertyReferenceExpression name="Fields">
											<variableReferenceExpression name="p"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="IsTagged">
													<target>
														<variableReferenceExpression name="field"/>
													</target>
													<parameters>
														<primitiveExpression value="rest-api-none"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="apiNone"/>
													</target>
													<parameters>
														<variableReferenceExpression name="field"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<foreachStatement>
									<variable name="field"/>
									<target>
										<propertyReferenceExpression name="Fields">
											<variableReferenceExpression name="p"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="apiNone"/>
														</target>
														<parameters>
															<variableReferenceExpression name="field"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="dictionary"/>
														</target>
														<indices>
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="field"/>
															</propertyReferenceExpression>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="field"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="dictionary"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToSchemaField(string, string) -->
						<memberMethod returnType="List" name="ToSchemaFields">
							<typeArguments>
								<typeReference type="DataField"/>
							</typeArguments>
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="controllerName"/>
								<parameter type="System.String" name="view"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="dictionary">
									<init>
										<methodInvokeExpression methodName="ToFieldDictionary">
											<parameters>
												<argumentReferenceExpression name="controllerName"/>
												<argumentReferenceExpression name="view"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="fieldList">
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="DataField"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable name="fieldDef"/>
									<target>
										<variableReferenceExpression name="dictionary"/>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsPrimaryKey">
													<propertyReferenceExpression name="Value">
														<variableReferenceExpression name="fieldDef"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="fieldList"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Value">
															<variableReferenceExpression name="fieldDef"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<foreachStatement>
									<variable name="fieldDef"/>
									<target>
										<variableReferenceExpression name="dictionary"/>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="fieldList"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="fieldDef"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="fieldList"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Value">
															<variableReferenceExpression name="fieldDef"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement name="aliasFieldName">
													<init>
														<propertyReferenceExpression name="AliasName">
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="fieldDef"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="aliasFieldName"/>
															</unaryOperatorExpression>
															<methodInvokeExpression methodName="ContainsKey">
																<target>
																	<variableReferenceExpression name="dictionary"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="aliasFieldName"/>
																</parameters>
															</methodInvokeExpression>>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="aliasField">
															<init>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="dictionary"/>
																	</target>
																	<indices>
																		<variableReferenceExpression name="aliasFieldName"/>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="Contains">
																		<target>
																			<variableReferenceExpression name="fieldList"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="aliasField"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="fieldList"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="aliasField"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="fieldList"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AddFieldsToSchema(JObject, List<DataField>) -->
						<memberMethod name="AddFieldsToSchema">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="JObject" name="schema"/>
								<parameter type="List" name="fieldList">
									<typeArguments>
										<typeReference type="DataField"/>
									</typeArguments>
								</parameter>
							</parameters>
							<statements>
								<foreachStatement>
									<variable name="field"/>
									<target>
										<argumentReferenceExpression name="fieldList"/>
									</target>
									<statements>
										<variableDeclarationStatement name="f">
											<init>
												<objectCreateExpression type="JObject"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="f"/>
												</target>
												<indices>
													<primitiveExpression value="type"/>
												</indices>
											</arrayIndexerExpression>
											<propertyReferenceExpression name="Type">
												<variableReferenceExpression name="field"/>
											</propertyReferenceExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Len">
														<variableReferenceExpression name="field"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="f"/>
														</target>
														<indices>
															<primitiveExpression value="length"/>
														</indices>
													</arrayIndexerExpression>
													<propertyReferenceExpression name="Len">
														<variableReferenceExpression name="field"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="HasDefaultValue">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="f"/>
														</target>
														<indices>
															<primitiveExpression value="default"/>
														</indices>
													</arrayIndexerExpression>
													<propertyReferenceExpression name="DefaultValue">
														<variableReferenceExpression name="field"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="AllowNulls">
														<variableReferenceExpression name="field"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="f"/>
														</target>
														<indices>
															<primitiveExpression value="required"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsPrimaryKey">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="f"/>
														</target>
														<indices>
															<primitiveExpression value="key"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="ReadOnly">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="f"/>
														</target>
														<indices>
															<primitiveExpression value="readOnly"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="headerText">
											<init>
												<propertyReferenceExpression name="HeaderText">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="headerText"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="headerText"/>
													<propertyReferenceExpression name="Label">
														<variableReferenceExpression name="field"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<propertyReferenceExpression name="ItemsDataController">
														<variableReferenceExpression name="field"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="f"/>
														</target>
														<indices>
															<primitiveExpression value="lookup"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="ItemsDataController">
														<variableReferenceExpression name="field"/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="ControllerName"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="f"/>
														</target>
														<indices>
															<primitiveExpression value="child"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="OnDemand">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="f"/>
														</target>
														<indices>
															<primitiveExpression value="blob"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="f"/>
												</target>
												<indices>
													<primitiveExpression value="label"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="headerText"/>
										</assignStatement>
										<variableDeclarationStatement name="watermark">
											<init>
												<propertyReferenceExpression name="Watermark">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="watermark"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="f"/>
														</target>
														<indices>
															<primitiveExpression value="hint"/>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="watermark"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="footerText">
											<init>
												<propertyReferenceExpression name="FooterText">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="footerText"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="f"/>
														</target>
														<indices>
															<primitiveExpression value="footer"/>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="footerText"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<argumentReferenceExpression name="schema"/>
											</target>
											<parameters>
												<objectCreateExpression type="JProperty">
													<parameters>
														<methodInvokeExpression methodName="ToApiFieldName">
															<parameters>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<variableReferenceExpression name="f"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
						<!-- method ExtendLinkWith(string, bool, JToken) -->
						<memberMethod name="ExtendLinkWith">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="key"/>
								<parameter type="System.Boolean" name="value"/>
								<parameter type="JToken" name="link"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<argumentReferenceExpression name="link"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IsTypeOf">
													<argumentReferenceExpression name="link"/>
													<typeReferenceExpression type="JProperty"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="link"/>
													<propertyReferenceExpression name="Value">
														<castExpression targetType="JProperty">
															<argumentReferenceExpression name="link"/>
														</castExpression>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<binaryOperatorExpression operator="IsTypeOf">
														<argumentReferenceExpression name="link"/>
														<typeReferenceExpression type="JValue"/>
													</binaryOperatorExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="link"/>
														</target>
														<indices>
															<methodInvokeExpression methodName="ToApiName">
																<parameters>
																	<argumentReferenceExpression name="key"/>
																</parameters>
															</methodInvokeExpression>
														</indices>
													</arrayIndexerExpression>
													<argumentReferenceExpression name="value"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- constructor() -->
						<constructor>
							<attributes public="true"/>
							<statements>
								<variableDeclarationStatement name="request">
									<init>
										<propertyReferenceExpression name="Request">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="HttpContext"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="HttpMethod"/>
									<propertyReferenceExpression name="HttpMethod">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="RawUrl"/>
									<propertyReferenceExpression name="RawUrl">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="configList"/>
									<objectCreateExpression type="SortedDictionary">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="ControllerConfiguration"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="LinkStyle"/>
									<convertExpression to="String">
										<methodInvokeExpression methodName="SettingsProperty">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.rest.hypermedia.links.style"/>
												<primitiveExpression value="object"/>
											</parameters>
										</methodInvokeExpression>
									</convertExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="LinkMethod"/>
									<convertExpression to="Boolean">
										<methodInvokeExpression methodName="SettingsProperty">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.rest.hypermedia.links.method"/>
												<primitiveExpression value="false"/>
											</parameters>
										</methodInvokeExpression>
									</convertExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="LinksPosition"/>
									<convertExpression to="String">
										<methodInvokeExpression methodName="SettingsProperty">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.rest.hypermedia.links.position"/>
												<primitiveExpression value="first"/>
											</parameters>
										</methodInvokeExpression>
									</convertExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="OutputStyle"/>
									<convertExpression to="String">
										<methodInvokeExpression methodName="SettingsProperty">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.rest.output.style"/>
												<primitiveExpression value="camelCase"/>
											</parameters>
										</methodInvokeExpression>
									</convertExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="ReplaceEmbedded"/>
									<binaryOperatorExpression operator="BooleanOr">
										<convertExpression to="Boolean">
											<methodInvokeExpression methodName="SettingsProperty">
												<target>
													<typeReferenceExpression type="ApplicationServicesBase"/>
												</target>
												<parameters>
													<primitiveExpression value="server.rest.hypermedia.embedded.replace"/>
													<primitiveExpression value="false"/>
												</parameters>
											</methodInvokeExpression>
										</convertExpression>
										<binaryOperatorExpression operator="ValueEquality">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Headers">
														<variableReferenceExpression name="request"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="X-Restful-HypermediaEmbeddedReplace"/>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="true" convertTo="String"/>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="OutputContentType"/>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Headers">
												<variableReferenceExpression name="request"/>
											</propertyReferenceExpression>
										</target>
										<indices>
											<primitiveExpression value="X-Restful-OutputContentType"/>
										</indices>
									</arrayIndexerExpression>
								</assignStatement>
								<comment>init the output key map for parameters that are not named after the logical names, e.g firstLink=first</comment>
								<assignStatement>
									<fieldReferenceExpression name="names"/>
									<objectCreateExpression type="SortedDictionary">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="System.String"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="embeddable"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="embeddable"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="embedParam"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="_embed"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="_embedded"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="_embedded"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="selfLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="self"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="latestVersionLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="latest-version"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="upLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="up"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="firstLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="first"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="prevLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="prev"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="nextLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="next"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="lastLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="last"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="filterParam"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="filter"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="newLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="newLink"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="createLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="create"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="editLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="edit"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="replaceLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="replace"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="deleteLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="delete"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="schemaLink"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="schema"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="xmlItem"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="item"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="xmlRoot"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="data"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="valueKey"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="value"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="childrenKey"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="children"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="rootKey"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="root"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="resultKey"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="result"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="names"/>
										</target>
										<indices>
											<primitiveExpression value="resultSetKey"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="collection"/>
								</assignStatement>
								<variableDeclarationStatement name="halKeys">
									<init>
										<methodInvokeExpression methodName="SettingsProperty">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.rest.output.names"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IsTypeOf">
											<variableReferenceExpression name="halKeys"/>
											<typeReferenceExpression type="JObject"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable name="p"/>
											<target>
												<castExpression targetType="JObject">
													<variableReferenceExpression name="halKeys"/>
												</castExpression>
											</target>
											<statements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<fieldReferenceExpression name="names"/>
														</target>
														<indices>
															<propertyReferenceExpression name="Key">
																<variableReferenceExpression name="p"/>
															</propertyReferenceExpression>
														</indices>
													</arrayIndexerExpression>
													<convertExpression to="String">
														<propertyReferenceExpression name="Value">
															<variableReferenceExpression name="p"/>
														</propertyReferenceExpression>
													</convertExpression>
												</assignStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<fieldReferenceExpression name="linksKey"/>
									<methodInvokeExpression methodName="ToApiName">
										<parameters>
											<primitiveExpression value="_links"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="_embeddedKey"/>
									<methodInvokeExpression methodName="ToApiName">
										<parameters>
											<primitiveExpression value="_embedded"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="embeddableKey"/>
									<methodInvokeExpression methodName="ToApiName">
										<parameters>
											<primitiveExpression value="embeddable"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="schemaKey"/>
									<methodInvokeExpression methodName="ToApiName">
										<parameters>
											<primitiveExpression value="_schema"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="embedParam"/>
									<methodInvokeExpression methodName="ToApiName">
										<parameters>
											<primitiveExpression value="embedParam"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="filterParam"/>
									<methodInvokeExpression methodName="ToApiName">
										<parameters>
											<primitiveExpression value="filterParam"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="childrenKey"/>
									<methodInvokeExpression methodName="ToApiName">
										<parameters>
											<primitiveExpression value="childrenKey"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="rootKey"/>
									<methodInvokeExpression methodName="ToApiName">
										<parameters>
											<primitiveExpression value="rootKey"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="latestVersionLink"/>
									<methodInvokeExpression methodName="ToApiName">
										<parameters>
											<primitiveExpression value="latestVersionLink"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement name="schemaParameter">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="QueryString">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<propertyReferenceExpression name="SchemaKey"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="schemaParameter"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="schemaParameter"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Headers">
														<variableReferenceExpression name="request"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="X-Restful-Schema"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="AllowsSchema"/>
									<convertExpression to="Boolean">
										<methodInvokeExpression methodName="SettingsProperty">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.rest.schema.enabled"/>
												<primitiveExpression value="true"/>
											</parameters>
										</methodInvokeExpression>
									</convertExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="RequiresSchema"/>
									<binaryOperatorExpression operator="BooleanAnd">
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="ValueEquality">
												<variableReferenceExpression name="schemaParameter"/>
												<primitiveExpression value="true" convertTo="String"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<variableReferenceExpression name="schemaParameter"/>
												<primitiveExpression value="only"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
										<propertyReferenceExpression name="AllowsSchema"/>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="RequiresData"/>
									<binaryOperatorExpression operator="ValueInequality">
										<variableReferenceExpression name="schemaParameter"/>
										<primitiveExpression value="only"/>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="RemoveLinks"/>
									<binaryOperatorExpression operator="BooleanOr">
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="ValueEquality">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<variableReferenceExpression name="request"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<propertyReferenceExpression name="LinksKey"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="false" convertTo="String"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Headers">
															<variableReferenceExpression name="request"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="X-Restful-Hypermedia"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="false" convertTo="String"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
										<unaryOperatorExpression operator="Not">
											<convertExpression to="Boolean">
												<methodInvokeExpression methodName="SettingsProperty">
													<target>
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</target>
													<parameters>
														<primitiveExpression value="server.rest.output.links"/>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</unaryOperatorExpression>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Hypermedia"/>
									<convertExpression to="Boolean">
										<methodInvokeExpression methodName="SettingsProperty">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.rest.hypermedia.enabled"/>
												<primitiveExpression value="true"/>
											</parameters>
										</methodInvokeExpression>
									</convertExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<propertyReferenceExpression name="RemoveLinks"/>
											<propertyReferenceExpression name="Hypermedia"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="ReplaceEmbedded"/>
											<primitiveExpression value="true"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<fieldReferenceExpression name="parameters"/>
									<objectCreateExpression type="Dictionary">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="System.Object"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="parametersKey"/>
									<primitiveExpression value="parameters"/>
								</assignStatement>
								<variableDeclarationStatement name="endpoint">
									<init>
										<castExpression targetType="System.String">
											<methodInvokeExpression methodName="SettingsProperty">
												<target>
													<typeReferenceExpression type="ApplicationServicesBase"/>
												</target>
												<parameters>
													<primitiveExpression value="server.rest.endpoint"/>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="endpoint"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="endpointValidator"/>
											<objectCreateExpression type="Regex">
												<parameters>
													<variableReferenceExpression name="endpoint"/>
													<propertyReferenceExpression name="IgnoreCase">
														<typeReferenceExpression type="RegexOptions"/>
													</propertyReferenceExpression>
												</parameters>
											</objectCreateExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</constructor>
						<!-- property DefaultView(string) -->
						<memberMethod returnType="System.String" name="DefaultView">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="type"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="DefaultView">
										<parameters>
											<argumentReferenceExpression name="type"/>
											<fieldReferenceExpression name="controllerName"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property DefaultView(string, string) -->
						<memberMethod returnType="System.String" name="DefaultView">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="type"/>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<statements>
								<assignStatement>
									<argumentReferenceExpression name="type"/>
									<methodInvokeExpression methodName="ToLower">
										<target>
											<argumentReferenceExpression name="type"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="type"/>
											<primitiveExpression value="root"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<stringEmptyExpression/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="type"/>
											<primitiveExpression value="collection"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="grid1"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="ValueEquality">
												<argumentReferenceExpression name="type"/>
												<primitiveExpression value="post"/>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<propertyReferenceExpression name="PathAction"/>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="createForm1"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<comment>"singleton" or any other type (DELETE, PUT, PATCH, etc.)</comment>
								<methodReturnStatement>
									<primitiveExpression value="editForm1"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IsViewOfType(string, string) -->
						<memberMethod returnType="System.Boolean" name="IsViewOfType">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="type"/>
							</parameters>
							<statements>
								<foreachStatement>
									<variable name="viewId"/>
									<target>
										<methodInvokeExpression methodName="EnumerateViews">
											<parameters>
												<argumentReferenceExpression name="type"/>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Equals">
													<target>
														<variableReferenceExpression name="viewId"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="NormalizeKey">
															<target>
																<typeReferenceExpression type="ConfigDictionary"/>
															</target>
															<parameters>
																<variableReferenceExpression name="view"/>
															</parameters>
														</methodInvokeExpression>
														<propertyReferenceExpression name="OrdinalIgnoreCase">
															<typeReferenceExpression type="StringComparison"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
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
						<!-- method EnumerateViews(string, string) -->
						<memberMethod returnType="System.String[]" name="EnumerateViews">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="type"/>
								<parameter type="System.String" name="exclude"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="EnumerateViews">
										<parameters>
											<fieldReferenceExpression name="controllerName"/>
											<argumentReferenceExpression name="type"/>
											<argumentReferenceExpression name="exclude"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method EnumerateViews(string controllerName, string, string) -->
						<memberMethod returnType="System.String[]" name="EnumerateViews">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="controllerName"/>
								<parameter type="System.String" name="type"/>
								<parameter type="System.String" name="exclude"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<argumentReferenceExpression name="type"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<propertyReferenceExpression name="PathKey"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="type"/>
													<primitiveExpression value="collection"/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<argumentReferenceExpression name="type"/>
													<primitiveExpression value="singleton"/>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<argumentReferenceExpression name="type"/>
									<methodInvokeExpression methodName="ToLower">
										<target>
											<argumentReferenceExpression name="type"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement name="list">
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="viewIterator">
									<init>
										<methodInvokeExpression methodName="Select">
											<target>
												<methodInvokeExpression methodName="GetConfig">
													<parameters>
														<argumentReferenceExpression name="controllerName"/>
													</parameters>
												</methodInvokeExpression>
											</target>
											<parameters>
												<primitiveExpression value="/c:dataController/c:views/c:view"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<methodInvokeExpression methodName="MoveNext">
											<target>
												<variableReferenceExpression name="viewIterator"/>
											</target>
										</methodInvokeExpression>
									</test>
									<statements>
										<variableDeclarationStatement name="viewId">
											<init>
												<methodInvokeExpression methodName="GetAttribute">
													<target>
														<propertyReferenceExpression name="Current">
															<variableReferenceExpression name="viewIterator"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="id"/>
														<stringEmptyExpression/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="ValueInequality">
															<argumentReferenceExpression name="exclude"/>
															<variableReferenceExpression name="viewId"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="ValueEquality">
															<methodInvokeExpression methodName="DefaultView">
																<parameters>
																	<argumentReferenceExpression name="type"/>
																</parameters>
															</methodInvokeExpression>
															<variableReferenceExpression name="viewId"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
													<methodInvokeExpression methodName="IsTagged">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Current">
																<variableReferenceExpression name="viewIterator"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="Add">
																<primitiveExpression value="rest-api-"/>
																<variableReferenceExpression name="type"/>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="list"/>
													</target>
													<parameters>
														<variableReferenceExpression name="viewId"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</whileStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="list"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ExtendRawUrlWith(string, params object[]) -->
						<memberMethod returnType="System.String" name="ExtendRawUrlWith">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="path"/>
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ReplaceRawUrlWith">
										<parameters>
											<stringEmptyExpression/>
											<primitiveExpression value="false"/>
											<argumentReferenceExpression name="path"/>
											<argumentReferenceExpression name="args"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ExtendRawUrlWith(bool, string, param object[] args) -->
						<memberMethod returnType="System.String" name="ExtendRawUrlWith">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.Boolean" name="duplicateQueryParams"/>
								<parameter type="System.String" name="path"/>
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ReplaceRawUrlWith">
										<parameters>
											<stringEmptyExpression/>
											<argumentReferenceExpression name="duplicateQueryParams"/>
											<argumentReferenceExpression name="path"/>
											<argumentReferenceExpression name="args"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ReplaceRawUrlWith(string, bool, path, args) -->
						<memberMethod returnType="System.String" name="ReplaceRawUrlWith">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="startWith"/>
								<parameter type="System.Boolean" name="duplicateQueryParams"/>
								<parameter type="System.String" name="path"/>
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Length">
												<argumentReferenceExpression name="args"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="path"/>
											<methodInvokeExpression methodName="Format">
												<target>
													<typeReferenceExpression type="System.String"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="path"/>
													<argumentReferenceExpression name="args"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="url">
									<init>
										<propertyReferenceExpression name="RawUrl"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="pathQueryParams">
									<init>
										<methodInvokeExpression methodName="ToQueryParams">
											<parameters>
												<argumentReferenceExpression name="path"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<argumentReferenceExpression name="duplicateQueryParams"/>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable name="queryParam"/>
											<target>
												<methodInvokeExpression methodName="ToQueryParams">
													<parameters>
														<argumentReferenceExpression name="url"/>
													</parameters>
												</methodInvokeExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression methodName="ContainsKey">
																	<target>
																		<variableReferenceExpression name="pathQueryParams"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Key">
																			<variableReferenceExpression name="queryParam"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanOr">
																<binaryOperatorExpression operator="ValueInequality">
																	<propertyReferenceExpression name="Key">
																		<variableReferenceExpression name="queryParam"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="count"/>
																</binaryOperatorExpression>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="ContainsKey">
																		<target>
																			<variableReferenceExpression name="pathQueryParams"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="page"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="pathQueryParams"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Key">
																	<variableReferenceExpression name="queryParam"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="queryParam"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<comment>strip down the query params from 'url' and 'path'</comment>
								<variableDeclarationStatement name="questionMarkIndexInUrl">
									<init>
										<methodInvokeExpression methodName="IndexOf">
											<target>
												<variableReferenceExpression name="url"/>
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
											<variableReferenceExpression name="questionMarkIndexInUrl"/>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="url"/>
											<methodInvokeExpression methodName="Substring">
												<target>
													<variableReferenceExpression name="url"/>
												</target>
												<parameters>
													<primitiveExpression value="0"/>
													<variableReferenceExpression name="questionMarkIndexInUrl"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="isLatestVersion">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="EndsWith">
											<target>
												<variableReferenceExpression name="url"/>
											</target>
											<parameters>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="/"/>
													<propertyReferenceExpression name="LatestVersionLink"/>
												</binaryOperatorExpression>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="url"/>
											<methodInvokeExpression methodName="Substring">
												<target>
													<variableReferenceExpression name="url"/>
												</target>
												<parameters>
													<primitiveExpression value="0"/>
													<binaryOperatorExpression operator="Subtract">
														<binaryOperatorExpression operator="Subtract">
															<propertyReferenceExpression name="Length">
																<variableReferenceExpression name="url"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Length">
																<propertyReferenceExpression name="LatestVersionLink"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="isLatestVersion"/>
											<primitiveExpression value="true"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="startWith"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="StartsWith">
														<target>
															<variableReferenceExpression name="startWith"/>
														</target>
														<parameters>
															<primitiveExpression value="/"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="startWith"/>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="/"/>
														<variableReferenceExpression name="startWith"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="lastIndex">
											<init>
												<methodInvokeExpression methodName="LastIndexOf">
													<target>
														<variableReferenceExpression name="url"/>
													</target>
													<parameters>
														<variableReferenceExpression name="startWith"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<variableReferenceExpression name="lastIndex"/>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="url"/>
													<methodInvokeExpression methodName="Substring">
														<target>
															<variableReferenceExpression name="url"/>
														</target>
														<parameters>
															<primitiveExpression value="0"/>
															<variableReferenceExpression name="lastIndex"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="questionMarkIndex">
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
										<binaryOperatorExpression operator="GreaterThanOrEqual">
											<variableReferenceExpression name="questionMarkIndex"/>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="path"/>
											<methodInvokeExpression methodName="Substring">
												<target>
													<argumentReferenceExpression name="path"/>
												</target>
												<parameters>
													<primitiveExpression value="0"/>
													<variableReferenceExpression name="questionMarkIndex"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<argumentReferenceExpression name="path"/>
											</unaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="StartsWith">
													<target>
														<argumentReferenceExpression name="path"/>
													</target>
													<parameters>
														<primitiveExpression value="/"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="path"/>
											<binaryOperatorExpression operator="Add">
												<primitiveExpression value="/"/>
												<variableReferenceExpression name="path"/>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<variableReferenceExpression name="url"/>
									<binaryOperatorExpression operator="Add">
										<variableReferenceExpression name="url"/>
										<argumentReferenceExpression name="path"/>
									</binaryOperatorExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<variableReferenceExpression name="isLatestVersion"/>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="url"/>
											<binaryOperatorExpression operator="Add">
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="url"/>
													<primitiveExpression value="/"/>
												</binaryOperatorExpression>
												<propertyReferenceExpression name="LatestVersionLink"/>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="separator">
									<init>
										<primitiveExpression value="?"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable name="queryParam"/>
									<target>
										<variableReferenceExpression name="pathQueryParams"/>
									</target>
									<statements>
										<assignStatement>
											<variableReferenceExpression name="url"/>
											<stringFormatExpression>
												<xsl:attribute name="format"><![CDATA[{0}{1}{2}={3}]]></xsl:attribute>
												<variableReferenceExpression name="url"/>
												<variableReferenceExpression name="separator"/>
												<propertyReferenceExpression name="Key">
													<variableReferenceExpression name="queryParam"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="Value">
													<variableReferenceExpression name="queryParam"/>
												</propertyReferenceExpression>
											</stringFormatExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="separator"/>
											<primitiveExpression value="&amp;"/>
										</assignStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="url"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToQueryParams(string) -->
						<memberMethod returnType="Dictionary" name="ToQueryParams">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="url"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="queryParams">
									<init>
										<objectCreateExpression type="Dictionary">
											<typeArguments>
												<typeReference type="System.String"/>
												<typeReference type="System.String"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="Match" name="m" var="false"/>
									<target>
										<methodInvokeExpression methodName="Matches">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="url"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[(\?|\&)([^=]+)\=([^&]+)]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</target>
									<statements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="queryParams"/>
												</target>
												<indices>
													<propertyReferenceExpression name="Value">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<variableReferenceExpression name="m"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="2"/>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
												</indices>
											</arrayIndexerExpression>
											<propertyReferenceExpression name="Value">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Groups">
															<variableReferenceExpression name="m"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="3"/>
													</indices>
												</arrayIndexerExpression>
											</propertyReferenceExpression>
										</assignStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="queryParams"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetConfig(string) -->
						<memberMethod returnType="ControllerConfiguration" name="GetConfig">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="controllerName"/>
							</parameters>
							<statements>
								<assignStatement>
									<argumentReferenceExpression name="controllerName"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<methodInvokeExpression methodName="Replace">
												<target>
													<argumentReferenceExpression name="controllerName"/>
												</target>
												<parameters>
													<primitiveExpression value="-"/>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
										</target>
										<parameters>
											<primitiveExpression value="_"/>
											<stringEmptyExpression/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement type="ControllerConfiguration" name="config" var="false">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<fieldReferenceExpression name="configList"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="controllerName"/>
													<directionExpression direction="Out">
														<variableReferenceExpression name="config"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
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
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<fieldReferenceExpression name="configList"/>
														</target>
														<indices>
															<argumentReferenceExpression name="controllerName"/>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="config"/>
												</assignStatement>
											</statements>
											<catch exceptionType="Exception">
												<methodInvokeExpression methodName="ThrowError">
													<target>
														<typeReferenceExpression type="RESTfulResource"/>
													</target>
													<parameters>
														<primitiveExpression value="404"/>
														<primitiveExpression value="invalid_path"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[Controller '{0}' is not available.]]></xsl:attribute>
														</primitiveExpression>
														<argumentReferenceExpression name="controllerName"/>
													</parameters>
												</methodInvokeExpression>
											</catch>
										</tryStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="config"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateLinks(JObject) -->
						<memberMethod returnType="JProperty" name="CreateLinks">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="JObject" name="result"/>
								<parameter type="System.Boolean" name="requiresHypermedia"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="links">
									<init>
										<methodInvokeExpression methodName="CreateLinks">
											<parameters>
												<argumentReferenceExpression name="result"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="links"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<argumentReferenceExpression name="requiresHypermedia"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ThrowError">
											<target>
												<typeReferenceExpression type="RESTfulResource"/>
											</target>
											<parameters>
												<primitiveExpression value="invalid_settings"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[Hypermedia is disabled. Set 'server.rest.hypermedia.enabled' to 'true' to use this resource.]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="links"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateLinks(JObject) -->
						<memberMethod returnType="JProperty" name="CreateLinks">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="JObject" name="result"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Hypermedia"/>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="links">
											<init>
												<castExpression targetType="JProperty">
													<methodInvokeExpression methodName="Property">
														<target>
															<argumentReferenceExpression name="result"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="LinksKey"/>
														</parameters>
													</methodInvokeExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Object" name="linksDef" var="false">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="links"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="LinkStyle"/>
															<primitiveExpression value="array"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="linksDef"/>
															<objectCreateExpression type="JArray"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<assignStatement>
															<variableReferenceExpression name="linksDef"/>
															<objectCreateExpression type="JObject"/>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="links"/>
													<objectCreateExpression type="JProperty">
														<parameters>
															<propertyReferenceExpression name="LinksKey"/>
															<variableReferenceExpression name="linksDef"/>
														</parameters>
													</objectCreateExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="Remove">
													<target>
														<variableReferenceExpression name="result"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="LinksKey"/>
													</parameters>
												</methodInvokeExpression>
											</falseStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="LinksPosition"/>
													<primitiveExpression value="first"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Equals">
																<target>
																	<variableReferenceExpression name="links"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="First">
																		<argumentReferenceExpression name="result"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityEquality">
																	<variableReferenceExpression name="linksDef"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Remove">
																	<target>
																		<argumentReferenceExpression name="result"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="LinksKey"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="AddFirst">
															<target>
																<argumentReferenceExpression name="result"/>
															</target>
															<parameters>
																<variableReferenceExpression name="links"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Equals">
																<target>
																	<variableReferenceExpression name="links"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Last">
																		<argumentReferenceExpression name="result"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityEquality">
																	<variableReferenceExpression name="linksDef"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Remove">
																	<target>
																		<argumentReferenceExpression name="result"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="LinksKey"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<argumentReferenceExpression name="result"/>
															</target>
															<parameters>
																<variableReferenceExpression name="links"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
										<methodReturnStatement>
											<variableReferenceExpression name="links"/>
										</methodReturnStatement>
									</trueStatements>
									<falseStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method EscapeLink(string) -->
						<memberMethod returnType="System.String" name="EscapeLink">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="hyperlink"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="questionMarkIndex">
									<init>
										<methodInvokeExpression methodName="IndexOf">
											<target>
												<argumentReferenceExpression name="hyperlink"/>
											</target>
											<parameters>
												<primitiveExpression value="?"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="questionMarkIndex"/>
											<primitiveExpression value="-1"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="hyperlink"/>
											<methodInvokeExpression methodName="EscapeUriString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="hyperlink"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<argumentReferenceExpression name="hyperlink"/>
											<binaryOperatorExpression operator="Add">
												<methodInvokeExpression methodName="EscapeUriString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="Substring">
															<target>
																<argumentReferenceExpression name="hyperlink"/>
															</target>
															<parameters>
																<primitiveExpression value="0"/>
																<variableReferenceExpression name="questionMarkIndex"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Substring">
													<target>
														<argumentReferenceExpression name="hyperlink"/>
													</target>
													<parameters>
														<variableReferenceExpression name="questionMarkIndex"/>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="hyperlink"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToServiceUrl(string, params object[]) -->
						<memberMethod returnType="System.String" name="ToServiceUrl">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="url"/>
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Length">
												<variableReferenceExpression name="args"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="url"/>
											<methodInvokeExpression methodName="Format">
												<target>
													<typeReferenceExpression type="System.String"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="url"/>
													<argumentReferenceExpression name="args"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="IsMatch">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="url"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[^(http|https)://]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<argumentReferenceExpression name="url"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<argumentReferenceExpression name="url"/>
											</target>
											<parameters>
												<primitiveExpression value="_self:"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="Substring">
												<target>
													<argumentReferenceExpression name="url"/>
												</target>
												<parameters>
													<primitiveExpression value="6"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="serviceUrl">
									<init>
										<propertyReferenceExpression name="ApplicationPath">
											<propertyReferenceExpression name="Request">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<argumentReferenceExpression name="url"/>
											</target>
											<parameters>
												<primitiveExpression value="/v2"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="serviceUrl"/>
													</propertyReferenceExpression>
													<primitiveExpression value="1"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="serviceUrl"/>
													<stringEmptyExpression/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="serviceUrl"/>
												<argumentReferenceExpression name="url"/>
											</binaryOperatorExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<argumentReferenceExpression name="url"/>
											</target>
											<parameters>
												<primitiveExpression value="~/"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="serviceUrl"/>
												<methodInvokeExpression methodName="Substring">
													<target>
														<argumentReferenceExpression name="url"/>
													</target>
													<parameters>
														<primitiveExpression value="2"/>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="urlBuilder">
									<init>
										<objectCreateExpression type="StringBuilder">
											<parameters>
												<variableReferenceExpression name="serviceUrl"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="EndsWith">
												<target>
													<variableReferenceExpression name="serviceUrl"/>
												</target>
												<parameters>
													<primitiveExpression value="/"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Append">
											<target>
												<variableReferenceExpression name="urlBuilder"/>
											</target>
											<parameters>
												<primitiveExpression value="/"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="Append">
									<target>
										<variableReferenceExpression name="urlBuilder"/>
									</target>
									<parameters>
										<primitiveExpression value="v2"/>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="StartsWith">
												<target>
													<argumentReferenceExpression name="url"/>
												</target>
												<parameters>
													<primitiveExpression value="/"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Append">
											<target>
												<variableReferenceExpression name="urlBuilder"/>
											</target>
											<parameters>
												<primitiveExpression value="/"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="Append">
									<target>
										<variableReferenceExpression name="urlBuilder"/>
									</target>
									<parameters>
										<argumentReferenceExpression name="url"/>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToString">
										<target>
											<variableReferenceExpression name="urlBuilder"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method EnsurePublicApiKeyUrl(string) -->
						<memberMethod returnType="System.String" name="EnsurePublicApiKeyInUrl">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="url"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="publicApiKey">
									<init>
										<propertyReferenceExpression name="PublicApiKey">
											<typeReferenceExpression type="RESTfulResource"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="publicApiKey"/>
											</unaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="IsMatch">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="url"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[(/oauth2|/v2/js/)]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="apiKeyInUrl">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="RawUrl"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[(\?|&)(x-api-key|api_key)=.+(&|$)]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="Success">
													<variableReferenceExpression name="apiKeyInUrl"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="apiKeyQueryParam">
													<init>
														<stringFormatExpression format="{{0}}={{1}}">
															<propertyReferenceExpression name="Value">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Groups">
																			<variableReferenceExpression name="apiKeyInUrl"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="2"/>
																	</indices>
																</arrayIndexerExpression>
															</propertyReferenceExpression>
															<variableReferenceExpression name="publicApiKey"/>
														</stringFormatExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Contains">
																<target>
																	<argumentReferenceExpression name="url"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="apiKeyQueryParam"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="Contains">
																		<target>
																			<argumentReferenceExpression name="url"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="?"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<argumentReferenceExpression name="url"/>
																	<binaryOperatorExpression operator="Add">
																		<argumentReferenceExpression name="url"/>
																		<primitiveExpression value="?"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<assignStatement>
																	<argumentReferenceExpression name="url"/>
																	<binaryOperatorExpression operator="Add">
																		<argumentReferenceExpression name="url"/>
																		<primitiveExpression value="&amp;"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
														<assignStatement>
															<argumentReferenceExpression name="url"/>
															<binaryOperatorExpression operator="Add">
																<argumentReferenceExpression name="url"/>
																<variableReferenceExpression name="apiKeyQueryParam"/>
															</binaryOperatorExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="url"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AddLinkProperty(JToken, string, string) -->
						<memberMethod returnType="JToken" name="AddLinkProperty">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="JToken" name="link"/>
								<parameter type="System.String" name="propName"/>
								<parameter type="System.Object" name="propValue"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="JToken" name="result" var="false">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IsTypeOf">
											<argumentReferenceExpression name="link"/>
											<typeReferenceExpression type="JProperty"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="link"/>
											<propertyReferenceExpression name="Value">
												<castExpression targetType="JProperty">
													<argumentReferenceExpression name="link"/>
												</castExpression>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IsTypeOf">
											<argumentReferenceExpression name="link"/>
											<typeReferenceExpression type="JObject"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="result"/>
											<objectCreateExpression type="JProperty">
												<parameters>
													<argumentReferenceExpression name="propName"/>
													<argumentReferenceExpression name="propValue"/>/>
												</parameters>
											</objectCreateExpression>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<castExpression targetType="JObject">
													<argumentReferenceExpression name="link"/>
												</castExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="result"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AddLink(string, string, JProperty, href, params object[]) -->
						<memberMethod returnType="JToken" name="AddLink">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
								<parameter type="System.String" name="method"/>
								<parameter type="JProperty" name="links"/>
								<parameter type="System.String" name="href" />
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="AddLink">
										<parameters>
											<argumentReferenceExpression name="name"/>
											<stringEmptyExpression/>
											<argumentReferenceExpression name="method"/>
											<argumentReferenceExpression name="links"/>
											<argumentReferenceExpression name="href"/>
											<argumentReferenceExpression name="args"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AddLink(string, string, string, JProperty, string, params object[]) -->
						<memberMethod returnType="JToken" name="AddLink">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
								<parameter type="System.String" name="suffix"/>
								<parameter type="System.String" name="method"/>
								<parameter type="JProperty" name="links"/>
								<parameter type="System.String" name="href"/>
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="hyperlink">
									<init>
										<methodInvokeExpression methodName="EscapeLink">
											<parameters>
												<methodInvokeExpression methodName="ToServiceUrl">
													<parameters>
														<argumentReferenceExpression name="href"/>
														<argumentReferenceExpression name="args"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<argumentReferenceExpression name="name"/>
									<methodInvokeExpression methodName="ToApiFieldName">
										<parameters>
											<methodInvokeExpression methodName="ToApiName">
												<parameters>
													<argumentReferenceExpression name="name"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<argumentReferenceExpression name="suffix"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="name"/>
											<binaryOperatorExpression operator="Add">
												<binaryOperatorExpression operator="Add">
													<argumentReferenceExpression name="name"/>
													<primitiveExpression value="-"/>
												</binaryOperatorExpression>
												<methodInvokeExpression methodName="ToApiName">
													<parameters>
														<argumentReferenceExpression name="suffix"/>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="schemaRegex">
									<init>
										<objectCreateExpression type="Regex">
											<parameters>
												<stringFormatExpression>
													<xsl:attribute name="format"><![CDATA[\b{0}=\w+\b]]></xsl:attribute>
													<fieldReferenceExpression name="schemaKey"/>
												</stringFormatExpression>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<propertyReferenceExpression name="RequiresSchema"/>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="IsMatch">
													<target>
														<variableReferenceExpression name="schemaRegex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="hyperlink"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="hyperlink"/>
														</target>
														<parameters>
															<primitiveExpression value="?"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="hyperlink"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="hyperlink"/>
														<primitiveExpression value="?"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="hyperlink"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="hyperlink"/>
														<primitiveExpression value="&amp;"/>
													</binaryOperatorExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="hyperlink"/>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="hyperlink"/>
												<fieldReferenceExpression name="schemaKey"/>
											</binaryOperatorExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="RequiresData"/>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="hyperlink"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="hyperlink"/>
														<primitiveExpression value="=true"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="hyperlink"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="hyperlink"/>
														<primitiveExpression value="=only"/>
													</binaryOperatorExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<variableReferenceExpression name="hyperlink"/>
									<methodInvokeExpression methodName="EnsurePublicApiKeyInUrl">
										<parameters>
											<variableReferenceExpression name="hyperlink"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement name="nameProp">
									<init>
										<castExpression targetType="JToken">
											<objectCreateExpression type="JObject"/>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="LinkStyle"/>
											<primitiveExpression value="array"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<castExpression targetType="JObject">
													<variableReferenceExpression name="nameProp"/>
												</castExpression>
											</target>
											<parameters>
												<objectCreateExpression type="JProperty">
													<parameters>
														<primitiveExpression value="href"/>
														<variableReferenceExpression name="hyperlink"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Add">
											<target>
												<castExpression targetType="JObject">
													<variableReferenceExpression name="nameProp"/>
												</castExpression>
											</target>
											<parameters>
												<objectCreateExpression type="JProperty">
													<parameters>
														<primitiveExpression value="rel"/>
														<argumentReferenceExpression name="name"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<propertyReferenceExpression name="LinkMethod"/>
													<binaryOperatorExpression operator="ValueInequality">
														<argumentReferenceExpression name="method"/>
														<primitiveExpression value="GET"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<castExpression targetType="JObject">
															<variableReferenceExpression name="nameProp"/>
														</castExpression>
													</target>
													<parameters>
														<objectCreateExpression type="JProperty">
															<parameters>
																<primitiveExpression value="method"/>
																<argumentReferenceExpression name="method"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<variableReferenceExpression name="nameProp"/>
											<objectCreateExpression type="JProperty">
												<parameters>
													<argumentReferenceExpression name="name"/>
													<variableReferenceExpression name="nameProp"/>
												</parameters>
											</objectCreateExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="LinkStyle"/>
													<primitiveExpression value="string"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Value">
														<castExpression targetType="JProperty">
															<variableReferenceExpression name="nameProp"/>
														</castExpression>
													</propertyReferenceExpression>
													<variableReferenceExpression name="hyperlink"/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<castExpression targetType="JObject">
															<propertyReferenceExpression name="Value">
																<castExpression targetType="JProperty">
																	<variableReferenceExpression name="nameProp"/>
																</castExpression>
															</propertyReferenceExpression>
														</castExpression>/>
													</target>
													<parameters>
														<objectCreateExpression type="JProperty">
															<parameters>
																<primitiveExpression value="href"/>
																<argumentReferenceExpression name="hyperlink"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanOr">
															<propertyReferenceExpression name="LinkMethod"/>
															<binaryOperatorExpression operator="ValueInequality">
																<argumentReferenceExpression name="method"/>
																<primitiveExpression value="GET"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<castExpression targetType="JObject">
																	<propertyReferenceExpression name="Value">
																		<castExpression targetType="JProperty">
																			<variableReferenceExpression name="nameProp"/>
																		</castExpression>
																	</propertyReferenceExpression>
																</castExpression>/>
															</target>
															<parameters>
																<objectCreateExpression type="JProperty">
																	<parameters>
																		<primitiveExpression value="method"/>
																		<argumentReferenceExpression name="method"/>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="name"/>
											<methodInvokeExpression methodName="ToApiName">
												<parameters>
													<primitiveExpression value="selfLink"/>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<propertyReferenceExpression name="PathKey"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IsTypeOf">
															<propertyReferenceExpression name="Value">
																<argumentReferenceExpression name="links"/>
															</propertyReferenceExpression>
															<typeReferenceExpression type="JArray"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="AddFirst">
															<target>
																<castExpression targetType="JArray">
																	<propertyReferenceExpression name="Value">
																		<argumentReferenceExpression name="links"/>
																	</propertyReferenceExpression>
																</castExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="nameProp"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<methodInvokeExpression methodName="AddFirst">
															<target>
																<castExpression targetType="JObject">
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="links"/>
																	</propertyReferenceExpression>
																</castExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="nameProp"/>
															</parameters>
														</methodInvokeExpression>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IsTypeOf">
															<propertyReferenceExpression name="Value">
																<argumentReferenceExpression name="links"/>
															</propertyReferenceExpression>
															<typeReferenceExpression type="JArray"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<castExpression targetType="JArray">
																	<propertyReferenceExpression name="Value">
																		<argumentReferenceExpression name="links"/>
																	</propertyReferenceExpression>
																</castExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="nameProp"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<castExpression targetType="JObject">
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="links"/>
																	</propertyReferenceExpression>
																</castExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="nameProp"/>
															</parameters>
														</methodInvokeExpression>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IsTypeOf">
													<propertyReferenceExpression name="Value">
														<argumentReferenceExpression name="links"/>
													</propertyReferenceExpression>
													<typeReferenceExpression type="JArray"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<castExpression targetType="JArray">
															<propertyReferenceExpression name="Value">
																<argumentReferenceExpression name="links"/>
															</propertyReferenceExpression>
														</castExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="nameProp"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<castExpression targetType="JObject">
															<propertyReferenceExpression name="Value">
																<argumentReferenceExpression name="links"/>
															</propertyReferenceExpression>
														</castExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="nameProp"/>
													</parameters>
												</methodInvokeExpression>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="nameProp"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AllowEndpoint(string) -->
						<memberMethod returnType="System.Boolean" name="AllowEndpoint">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="endpoint"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanOr">
										<binaryOperatorExpression operator="IdentityEquality">
											<propertyReferenceExpression name="EndpointValidator"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
										<methodInvokeExpression methodName="IsMatch">
											<target>
												<propertyReferenceExpression name="EndpointValidator"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="endpoint"/>
											</parameters>
										</methodInvokeExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AllowController(string) -->
						<memberMethod returnType="System.Boolean" name="AllowController">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controllerName"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="lastAclRole"/>
									<primitiveExpression value="null"/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<methodInvokeExpression methodName="IsSystemController">
												<target>
													<methodInvokeExpression methodName="Create">
														<target>
															<typeReferenceExpression type="ApplicationServices"/>
														</target>
													</methodInvokeExpression>
												</target>
												<parameters>
													<argumentReferenceExpression name="controllerName"/>
												</parameters>
											</methodInvokeExpression>
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
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="allow">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="acl">
									<init>
										<castExpression targetType="JObject">
											<methodInvokeExpression methodName="SettingsProperty">
												<target>
													<typeReferenceExpression type="ApplicationServicesBase"/>
												</target>
												<parameters>
													<primitiveExpression value="server.rest.acl"/>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="acl"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="GreaterThan">
												<propertyReferenceExpression name="Count">
													<variableReferenceExpression name="acl"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="allow"/>
											<primitiveExpression value="false"/>
										</assignStatement>
										<foreachStatement>
											<variable name="rule"/>
											<target>
												<methodInvokeExpression methodName="Properties">
													<target>
														<variableReferenceExpression name="acl"/>
													</target>
												</methodInvokeExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="Type">
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="rule"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Object">
																<typeReferenceExpression type="JTokenType"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="Regex" name="re" var="false">
															<init>
																<primitiveExpression value="null"/>
															</init>
														</variableDeclarationStatement>
														<tryStatement>
															<statements>
																<assignStatement>
																	<variableReferenceExpression name="re"/>
																	<objectCreateExpression type="Regex">
																		<parameters>
																			<propertyReferenceExpression name="Name">
																				<variableReferenceExpression name="rule"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="IgnoreCase">
																				<typeReferenceExpression type="RegexOptions"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</objectCreateExpression>
																</assignStatement>
															</statements>
															<catch exceptionType="Exception" localName="ex">
																<methodInvokeExpression methodName="ThrowError">
																	<target>
																		<typeReferenceExpression type="RESTfulResource"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="500"/>
																		<primitiveExpression value="invalid_config"/>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[Rule 'server.rest.acl."{0}"' specified in touch-settings.json is not a valid regular expression. Error: {1}]]></xsl:attribute>
																		</primitiveExpression>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="rule"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Message">
																			<variableReferenceExpression name="ex"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</catch>
														</tryStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="IsMatch">
																	<target>
																		<variableReferenceExpression name="re"/>
																	</target>
																	<parameters>
																		<argumentReferenceExpression name="controllerName"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<comment>test user roles and scopes</comment>
																<foreachStatement>
																	<variable name="role"/>
																	<target>
																		<methodInvokeExpression methodName="Properties">
																			<target>
																				<castExpression targetType="JObject">
																					<propertyReferenceExpression name="Value">
																						<variableReferenceExpression name="rule"/>
																					</propertyReferenceExpression>
																				</castExpression>
																			</target>
																		</methodInvokeExpression>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanOr">
																					<methodInvokeExpression methodName="Contains">
																						<target>
																							<propertyReferenceExpression name="UserScopes"/>
																						</target>
																						<parameters>
																							<propertyReferenceExpression name="Name">
																								<variableReferenceExpression name="role"/>
																							</propertyReferenceExpression>
																						</parameters>
																					</methodInvokeExpression>
																					<methodInvokeExpression methodName="IsInRole">
																						<target>
																							<propertyReferenceExpression name="User">
																								<propertyReferenceExpression name="Current">
																									<typeReferenceExpression type="HttpContext"/>
																								</propertyReferenceExpression>
																							</propertyReferenceExpression>
																						</target>
																						<parameters>
																							<propertyReferenceExpression name="Name">
																								<variableReferenceExpression name="role"/>
																							</propertyReferenceExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="allow"/>
																					<primitiveExpression value="true"/>
																				</assignStatement>
																				<assignStatement>
																					<fieldReferenceExpression name="lastAclRole"/>
																					<variableReferenceExpression name="role"/>
																				</assignStatement>
																				<breakStatement/>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
																<conditionStatement>
																	<condition>
																		<variableReferenceExpression name="allow"/>
																	</condition>
																	<trueStatements>
																		<breakStatement/>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="allow"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OAuth2FileName -->
						<memberMethod returnType="System.String" name="OAuth2FileName">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="type"/>
								<parameter type="System.Object" name="id"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<stringFormatExpression>
										<xsl:attribute name="format"><![CDATA[sys/oauth2/{0}/{1}.json]]></xsl:attribute>
										<argumentReferenceExpression name="type"/>
										<argumentReferenceExpression name="id"/>
									</stringFormatExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method StandardScopes() -->
						<memberMethod returnType="JObject" name="StandardScopes">
							<attributes public="true"/>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ParseYamlOrJson">
										<target>
											<typeReferenceExpression type="TextUtility"/>
										</target>
										<parameters>
											<primitiveExpression>
												<xsl:attribute name="value" xml:space="preserve"><![CDATA[
openid:
  hint: View the unique user id, client app id, API endpoint, token issue and expiration date.
profile: 
  hint: View the user's last and first name, birthdate, gender, picture, and preferred language.
address:
  hint: View the user's preferred postal address.
email:
  hint: View the user's email address.
phone: 
  hint: View the user's phone number.
offline_access:
  hint: Access your data anytime.
]]></xsl:attribute>
											</primitiveExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ApplicationScopes()-->
						<memberMethod returnType="JObject" name="ApplicationScopes">
							<attributes public="true"/>
							<statements>
								<methodReturnStatement>
									<castExpression targetType="JObject">
										<methodInvokeExpression methodName="SettingsProperty">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.rest.scopes"/>
												<objectCreateExpression type="JObject"/>
											</parameters>
										</methodInvokeExpression>
									</castExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method PathArrayToString(List<string>, int) -->
						<memberMethod returnType="System.String" name="PathArrayToString">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="List" name="localPath">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
								</parameter>
								<parameter type="System.Int32" name="startIndex"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Join">
										<target>
											<typeReferenceExpression type="System.String"/>
										</target>
										<parameters>
											<primitiveExpression value="/"/>
											<methodInvokeExpression methodName="GetRange">
												<target>
													<argumentReferenceExpression name="localPath"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="startIndex"/>
													<binaryOperatorExpression operator="Subtract">
														<propertyReferenceExpression name="Count">
															<argumentReferenceExpression name="localPath"/>
														</propertyReferenceExpression>
														<variableReferenceExpression name="startIndex"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- enum NameSetToken -->
				<typeDeclaration name="NameSetToken" isEnum="true">
					<attributes public="true"/>
					<members>
						<memberField name="Unknown">
							<attributes public="true"/>
						</memberField>
						<memberField name="Name">
							<attributes public="true"/>
						</memberField>
						<memberField name="LeftBracket">
							<attributes public="true"/>
						</memberField>
						<memberField name="RightBracket">
							<attributes public="true"/>
						</memberField>
						<memberField name="Comma">
							<attributes public="true"/>
						</memberField>
						<memberField name="Eof">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- class NameSetParser -->
				<typeDeclaration name="NameSetParser">
					<attributes public="true"/>
					<members>
						<!-- field parameter -->
						<memberField type="System.String" name="parameter"/>
						<!-- field list -->
						<memberField type="List" name="list">
							<typeArguments>
								<typeReference type="System.String"/>
							</typeArguments>
						</memberField>
						<!-- field nameSet -->
						<memberField type="System.String" name="nameSet"/>
						<!-- field index-->
						<memberField type="System.Int32" name="index"/>
						<!-- field token -->
						<memberField type="NameSetToken" name="token"/>
						<!-- field tokenValue -->
						<memberField type="System.String" name="tokenValue"/>
						<!-- field tokenIndex -->
						<memberField type="System.Int32" name="tokenIndex"/>
						<!-- field name -->
						<memberField type="System.String" name="name"/>
						<!-- field re -->
						<memberField type="Regex" name="re">
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression>
											<xsl:attribute name="value"><![CDATA[\s*(?'Token'[\w\.\-]+|\{|\}|\,|\S)]]></xsl:attribute>
										</primitiveExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- field names-->
						<memberField type="Stack" name="names">
							<typeArguments>
								<typeReference type="System.String"/>
							</typeArguments>
						</memberField>
						<!-- constructor(string, JObject) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="parameter"/>
								<parameter type="JObject" name="obj"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="parameter"/>
								<convertExpression to="String">
									<arrayIndexerExpression>
										<target>
											<argumentReferenceExpression name="obj"/>
										</target>
										<indices>
											<argumentReferenceExpression name="parameter"/>
										</indices>
									</arrayIndexerExpression>
								</convertExpression>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor(string, string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="parameter"/>
								<parameter type="System.String" name="nameSet"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="parameter"/>
									<argumentReferenceExpression name="parameter"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="nameSet"/>
									<argumentReferenceExpression name="nameSet"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="index"/>
									<primitiveExpression value="0"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="tokenIndex"/>
									<primitiveExpression value="0"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="list"/>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="names"/>
									<objectCreateExpression type="Stack">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
							</statements>
						</constructor>
						<!-- method NextToken() -->
						<memberMethod returnType="NameSetToken" name="NextToken">
							<attributes public="true" final="true"/>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="token"/>
									<propertyReferenceExpression name="Unknown">
										<typeReferenceExpression type="NameSetToken"/>
									</propertyReferenceExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThanOrEqual">
											<fieldReferenceExpression name="index"/>
											<propertyReferenceExpression name="Length">
												<fieldReferenceExpression name="nameSet"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="token"/>
											<propertyReferenceExpression name="Eof">
												<typeReferenceExpression type="NameSetToken"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<variableDeclarationStatement name="m">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<fieldReferenceExpression name="re"/>
													</target>
													<parameters>
														<fieldReferenceExpression name="nameSet"/>
														<fieldReferenceExpression name="index"/>
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
												<variableDeclarationStatement name="token">
													<init>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<variableReferenceExpression name="m"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Token"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<assignStatement>
													<fieldReferenceExpression name="tokenValue"/>
													<propertyReferenceExpression name="Value">
														<variableReferenceExpression name="token"/>
													</propertyReferenceExpression>
												</assignStatement>
												<assignStatement>
													<fieldReferenceExpression name="tokenIndex"/>
													<propertyReferenceExpression name="Index">
														<variableReferenceExpression name="token"/>
													</propertyReferenceExpression>
												</assignStatement>
												<assignStatement>
													<fieldReferenceExpression name="index"/>
													<binaryOperatorExpression operator="Add">
														<fieldReferenceExpression name="index"/>
														<propertyReferenceExpression name="Length">
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="m"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<fieldReferenceExpression name="tokenValue"/>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[{]]></xsl:attribute>
															</primitiveExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<fieldReferenceExpression name="token"/>
															<propertyReferenceExpression name="LeftBracket">
																<typeReferenceExpression type="NameSetToken"/>
															</propertyReferenceExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<fieldReferenceExpression name="tokenValue"/>
																	<primitiveExpression>
																		<xsl:attribute name="value"><![CDATA[}]]></xsl:attribute>
																	</primitiveExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<fieldReferenceExpression name="token"/>
																	<propertyReferenceExpression name="RightBracket">
																		<typeReferenceExpression type="NameSetToken"/>
																	</propertyReferenceExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<fieldReferenceExpression name="tokenValue"/>
																			<primitiveExpression>
																				<xsl:attribute name="value"><![CDATA[,]]></xsl:attribute>
																			</primitiveExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<fieldReferenceExpression name="token"/>
																			<propertyReferenceExpression name="Comma">
																				<typeReferenceExpression type="NameSetToken"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="IsMatch">
																					<target>
																						<typeReferenceExpression type="Regex"/>
																					</target>
																					<parameters>
																						<fieldReferenceExpression name="tokenValue"/>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[^\w[\w\.\-]*$]]></xsl:attribute>
																						</primitiveExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<fieldReferenceExpression name="token"/>
																					<propertyReferenceExpression name="Name">
																						<typeReferenceExpression type="NameSetToken"/>
																					</propertyReferenceExpression>
																				</assignStatement>
																			</trueStatements>
																			<falseStatements>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="BooleanAnd">
																							<unaryOperatorExpression operator="IsNullOrWhiteSpace">
																								<fieldReferenceExpression name="tokenValue"/>
																							</unaryOperatorExpression>
																							<binaryOperatorExpression operator="GreaterThanOrEqual">
																								<fieldReferenceExpression name="index"/>
																								<propertyReferenceExpression name="Length">
																									<fieldReferenceExpression name="nameSet"/>
																								</propertyReferenceExpression>
																							</binaryOperatorExpression>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<fieldReferenceExpression name="token"/>
																							<propertyReferenceExpression name="Eof">
																								<typeReferenceExpression type="NameSetToken"/>
																							</propertyReferenceExpression>
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
														<unaryOperatorExpression operator="IsNullOrWhiteSpace">
															<methodInvokeExpression methodName="Substring">
																<target>
																	<fieldReferenceExpression name="nameSet"/>
																</target>
																<parameters>
																	<fieldReferenceExpression name="index"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<fieldReferenceExpression name="token"/>
															<propertyReferenceExpression name="Eof">
																<typeReferenceExpression type="NameSetToken"/>
															</propertyReferenceExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="token"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Execute() -->
						<memberMethod returnType="List" name="Execute">
							<comment>
								<![CDATA[ goal ::= name-list | { name-list }
name-list ::= name-def | name-def name-list | name-def , name-list
name-def ::= name | name { name-list }]]>
							</comment>
							<typeArguments>
								<typeReference type="System.String"/>
							</typeArguments>
							<attributes public="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<fieldReferenceExpression name="nameSet"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="Goal"/>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="NameList"/>
											</unaryOperatorExpression>
											<binaryOperatorExpression operator="ValueInequality">
												<fieldReferenceExpression name="token"/>
												<propertyReferenceExpression name="Eof">
													<typeReferenceExpression type="NameSetToken"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ThrowError">
											<parameters>
												<stringEmptyExpression/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="list"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Goal() -->
						<memberMethod returnType="System.Boolean" name="Goal">
							<attributes family="true" final="true"/>
							<statements>
								<methodInvokeExpression methodName="NextToken"/>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<fieldReferenceExpression name="token"/>
											<propertyReferenceExpression name="LeftBracket">
												<typeReferenceExpression type="NameSetToken"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="NextToken"/>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="NameList"/>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<fieldReferenceExpression name="token"/>
															<propertyReferenceExpression name="RightBracket">
																<typeReferenceExpression type="NameSetToken"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="NextToken"/>
														<methodReturnStatement>
															<primitiveExpression value="true"/>
														</methodReturnStatement>
													</trueStatements>
													<falseStatements>
														<methodInvokeExpression methodName="ThrowError">
															<parameters>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[Symbol '}' is expected.]]></xsl:attribute>
																</primitiveExpression>
															</parameters>
														</methodInvokeExpression>
														<methodReturnStatement>
															<primitiveExpression value="false"/>
														</methodReturnStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="ThrowError">
													<parameters>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[A list of names is expected.]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
												<methodReturnStatement>
													<primitiveExpression value="false"/>
												</methodReturnStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="NameList"/>
										</methodReturnStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method NameList() -->
						<memberMethod returnType="System.Boolean" name="NameList">
							<attributes family="true" final="true"/>
							<statements>
								<variableDeclarationStatement name="first">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="comma">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<primitiveExpression value="true"/>
									</test>
									<statements>
										<conditionStatement>
											<condition>
												<variableReferenceExpression name="first"/>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="NameDef"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<breakStatement/>
													</trueStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="first"/>
													<primitiveExpression value="false"/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<fieldReferenceExpression name="token"/>
															<propertyReferenceExpression name="Comma">
																<typeReferenceExpression type="NameSetToken"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="NextToken"/>
														<assignStatement>
															<variableReferenceExpression name="comma"/>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="NameDef"/>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="comma"/>
															<primitiveExpression value="false"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<breakStatement/>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</statements>
								</whileStatement>
								<conditionStatement>
									<condition>
										<variableReferenceExpression name="comma"/>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="tokenValue"/>
											<primitiveExpression value=","/>
										</assignStatement>
										<methodInvokeExpression methodName="ThrowError">
											<parameters>
												<primitiveExpression value="The name is expected."/>
											</parameters>
										</methodInvokeExpression>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<unaryOperatorExpression operator="Not">
										<variableReferenceExpression name="first"/>
									</unaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method NameDef() -->
						<memberMethod returnType="System.Boolean" name="NameDef">
							<attributes family="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Name"/>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<fieldReferenceExpression name="token"/>
													<propertyReferenceExpression name="LeftBracket">
														<typeReferenceExpression type="NameSetToken"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Push">
													<target>
														<fieldReferenceExpression name="names"/>
													</target>
													<parameters>
														<fieldReferenceExpression name="name"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="NextToken"/>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="NameList"/>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<fieldReferenceExpression name="token"/>
																	<propertyReferenceExpression name="RightBracket">
																		<typeReferenceExpression type="NameSetToken"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Pop">
																	<target>
																		<fieldReferenceExpression name="names"/>
																	</target>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="NextToken"/>
																<methodReturnStatement>
																	<primitiveExpression value="true"/>
																</methodReturnStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="ThrowError">
																	<parameters>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[Symbol '}' is expected.]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodReturnStatement>
																	<primitiveExpression value="false"/>
																</methodReturnStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<fieldReferenceExpression name="token"/>
																	<propertyReferenceExpression name="RightBracket">
																		<typeReferenceExpression type="NameSetToken"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Pop">
																	<target>
																		<fieldReferenceExpression name="names"/>
																	</target>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="NextToken"/>
																<methodReturnStatement>
																	<primitiveExpression value="true"/>
																</methodReturnStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="ThrowError">
																	<parameters>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[A list of names or '}' is expected.]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodReturnStatement>
																	<primitiveExpression value="false"/>
																</methodReturnStatement>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<methodReturnStatement>
													<primitiveExpression value="true"/>
												</methodReturnStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method Name() -->
						<memberMethod returnType="System.Boolean" name="Name">
							<attributes family="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<fieldReferenceExpression name="token"/>
											<propertyReferenceExpression name="Name">
												<typeReferenceExpression type="NameSetToken"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="name"/>
											<fieldReferenceExpression name="tokenValue"/>
										</assignStatement>
										<comment>save the name</comment>
										<variableDeclarationStatement name="qualifiedName">
											<init>
												<stringEmptyExpression/>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable name="n"/>
											<target>
												<fieldReferenceExpression name="names"/>
											</target>
											<statements>
												<assignStatement>
													<variableReferenceExpression name="qualifiedName"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="n"/>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="."/>
															<variableReferenceExpression name="qualifiedName"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</assignStatement>
											</statements>
										</foreachStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="qualifiedName"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="qualifiedName"/>
													<fieldReferenceExpression name="name"/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="qualifiedName"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="qualifiedName"/>
														<fieldReferenceExpression name="name"/>
													</binaryOperatorExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<fieldReferenceExpression name="list"/>
											</target>
											<parameters>
												<variableReferenceExpression name="qualifiedName"/>
											</parameters>
										</methodInvokeExpression>
										<comment>continue parsing</comment>
										<methodInvokeExpression methodName="NextToken"/>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
									<falseStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ThrowError(string, params object[]) -->
						<memberMethod name="ThrowError">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="error"/>
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="index">
									<init>
										<fieldReferenceExpression name="tokenIndex"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="s">
									<init>
										<fieldReferenceExpression name="nameSet"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<fieldReferenceExpression name="token"/>
											<propertyReferenceExpression name="Eof">
												<typeReferenceExpression type="NameSetToken"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="index"/>
											<propertyReferenceExpression name="Length">
												<variableReferenceExpression name="s"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="tokenValue"/>
											<primitiveExpression value="EOF"/>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="s"/>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="s"/>
												<fieldReferenceExpression name="tokenValue"/>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<comment>create an error message</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Length">
												<argumentReferenceExpression name="args"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="error"/>
											<methodInvokeExpression methodName="Format">
												<target>
													<typeReferenceExpression type="System.String"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="error"/>
													<argumentReferenceExpression name="args"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<argumentReferenceExpression name="error"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="error"/>
											<binaryOperatorExpression operator="Add">
												<argumentReferenceExpression name="error"/>
												<primitiveExpression value=" "/>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="contextLength">
									<init>
										<primitiveExpression value="100"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="prefix">
									<init>
										<methodInvokeExpression methodName="Substring">
											<target>
												<variableReferenceExpression name="s"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Max">
													<target>
														<typeReferenceExpression type="Math"/>
													</target>
													<parameters>
														<primitiveExpression value="0"/>
														<binaryOperatorExpression operator="Subtract">
															<variableReferenceExpression name="index"/>
															<variableReferenceExpression name="contextLength"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Min">
													<target>
														<typeReferenceExpression type="Math"/>
													</target>
													<parameters>
														<variableReferenceExpression name="contextLength"/>
														<variableReferenceExpression name="index"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="GreaterThanOrEqual">
												<propertyReferenceExpression name="Length">
													<variableReferenceExpression name="prefix"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="contextLength"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="GreaterThanOrEqual">
												<variableReferenceExpression name="index"/>
												<binaryOperatorExpression operator="Subtract">
													<variableReferenceExpression name="contextLength"/>
													<primitiveExpression value="1"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="prefix"/>
											<binaryOperatorExpression operator="Add">
												<primitiveExpression value="..."/>
												<methodInvokeExpression methodName="TrimStart">
													<target>
														<variableReferenceExpression name="prefix"/>
													</target>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<variableReferenceExpression name="prefix"/>
											<methodInvokeExpression methodName="TrimStart">
												<target>
													<variableReferenceExpression name="prefix"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
								<variableDeclarationStatement name="suffix">
									<init>
										<methodInvokeExpression methodName="TrimEnd">
											<target>
												<methodInvokeExpression methodName="Substring">
													<target>
														<variableReferenceExpression name="s"/>
													</target>
													<parameters>
														<variableReferenceExpression name="index"/>
														<methodInvokeExpression methodName="Min">
															<target>
																<typeReferenceExpression type="Math"/>
															</target>
															<parameters>
																<binaryOperatorExpression operator="Subtract">
																	<propertyReferenceExpression name="Length">
																		<variableReferenceExpression name="s"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="index"/>
																</binaryOperatorExpression>
																<variableReferenceExpression name="contextLength"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThanOrEqual">
											<propertyReferenceExpression name="Length">
												<variableReferenceExpression name="suffix"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="contextLength"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="suffix"/>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="suffix"/>
												<primitiveExpression value="..."/>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="sample">
									<init>
										<binaryOperatorExpression operator="Add">
											<variableReferenceExpression name="prefix"/>
											<binaryOperatorExpression operator="Add">
												<primitiveExpression value=">>>>>>>"/>
												<variableReferenceExpression name="suffix"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="precedingText">
									<init>
										<methodInvokeExpression methodName="Substring">
											<target>
												<variableReferenceExpression name="s"/>
											</target>
											<parameters>
												<primitiveExpression value="0"/>
												<variableReferenceExpression name="index"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="row">
									<init>
										<propertyReferenceExpression name="Length">
											<methodInvokeExpression methodName="Split">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="precedingText"/>
													<primitiveExpression value="&#10;"/>
												</parameters>
											</methodInvokeExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="col">
									<init>
										<binaryOperatorExpression operator="Add">
											<binaryOperatorExpression operator="Subtract">
												<variableReferenceExpression name="index"/>
												<methodInvokeExpression methodName="Max">
													<target>
														<typeReferenceExpression type="Math"/>
													</target>
													<parameters>
														<primitiveExpression value="0"/>
														<methodInvokeExpression methodName="LastIndexOf">
															<target>
																<variableReferenceExpression name="precedingText"/>
															</target>
															<parameters>
																<primitiveExpression value="&#10;"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
											<primitiveExpression value="1"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="ThrowError">
									<target>
										<typeReferenceExpression type="RESTfulResource"/>
									</target>
									<parameters>
										<primitiveExpression value="invalid_argument"/>
										<primitiveExpression>
											<xsl:attribute name="value"><![CDATA[Invalid definition of the '{1}' parameter. {0}Unexpected token '{2}' (Ln {3}, Col {4}): {5}]]></xsl:attribute>
										</primitiveExpression>
										<argumentReferenceExpression name="error"/>
										<fieldReferenceExpression name="parameter"/>
										<fieldReferenceExpression name="tokenValue"/>
										<variableReferenceExpression name="row"/>
										<variableReferenceExpression name="col"/>
										<variableReferenceExpression name="sample"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class V2ServiceRequestHandler -->
				<typeDeclaration name="V2ServiceRequestHandler" isPartial="true">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="V2ServiceRequestHandlerBase"/>
					</baseTypes>
					<members>

					</members>
				</typeDeclaration>
				<!-- class OpConstraint-->
				<typeDeclaration name="OpConstraint">
					<attributes public="true"/>
					<members>
						<!-- property Name -->
						<memberField type="System.String" name="name"/>
						<memberProperty type="System.String" name="Name">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="name"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<foreachStatement>
									<variable name="o"/>
									<target>
										<methodInvokeExpression methodName="Split">
											<target>
												<propertySetValueReferenceExpression/>
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
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<fieldReferenceExpression name="name"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<fieldReferenceExpression name="name"/>
													<variableReferenceExpression name="o"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Operations">
														<typeReferenceExpression type="RESTfulResourceBase"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<variableReferenceExpression name="o"/>
												</indices>
											</arrayIndexerExpression>
											<thisReferenceExpression/>
										</assignStatement>
									</statements>
								</foreachStatement>
							</setStatements>
						</memberProperty>
						<!-- property Op -->
						<memberProperty type="System.String" name="Op">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property MinValCount -->
						<memberProperty type="System.Int32" name="MinValCount">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property MaxValCount -->
						<memberProperty type="System.Int32" name="MaxValCount">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Join -->
						<memberProperty type="System.String" name="Join">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property NegativeOp -->
						<memberProperty type="System.String" name="NegativeOp">
							<comment>false</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ArrayOp -->
						<memberProperty type="System.String" name="ArrayOp">
							<comment>[1, 2, 3]</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property UrlArrays -->
						<memberProperty type="System.Boolean" name="UrlArrays">
							<attributes public="true" final="true"/>
						</memberProperty>
					</members>
				</typeDeclaration>
				<!-- class FilterBuilder -->
				<typeDeclaration name="FilterBuilder">
					<attributes public="true"/>
					<members>
						<!-- property Keywords -->
						<memberField type="System.String[]" name="Keywords">
							<attributes public="true" static="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<primitiveExpression value="and"/>
										<primitiveExpression value="not"/>
										<primitiveExpression value="or"/>
										<primitiveExpression value="contains"/>
										<primitiveExpression value="startswith"/>
										<primitiveExpression value="endswith"/>
										<primitiveExpression value="has"/>
										<primitiveExpression value="in"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- field options -->
						<memberField type="RESTfulResourceConfiguration" name="options"/>
						<!-- field fieldMap -->
						<memberField type="ConfigDictionary" name="fieldMap"/>
						<!-- field filterExpression -->
						<memberField type="System.String" name="filterExpression"/>
						<!-- method Initialize(string, RESTfulResource) -->
						<memberMethod returnType="FilterBuilder" name="Initialize">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="filterExpression"/>
								<parameter type="RESTfulResource" name="options"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="filterExpression"/>
									<argumentReferenceExpression name="filterExpression"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="options"/>
									<argumentReferenceExpression name="options"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="fieldMap"/>
									<propertyReferenceExpression name="FieldMap">
										<variableReferenceExpression name="options"/>
									</propertyReferenceExpression>

								</assignStatement>
								<methodReturnStatement>
									<thisReferenceExpression/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Create() -->
						<memberMethod returnType="FilterBuilder" name="Create">
							<attributes public="true" static="true"/>
							<statements>
								<methodReturnStatement>
									<objectCreateExpression type="FilterBuilder"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Execute() -->
						<memberMethod name="Execute">
							<attributes public="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<fieldReferenceExpression name="filterExpression"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<comment>set the original filter and parameters</comment>
								<assignStatement>
									<fieldReferenceExpression name="filterExpression"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<fieldReferenceExpression name="filterExpression"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[(\')(.*?)((?<!\\)\'|$)]]></xsl:attribute>
											</primitiveExpression>
											<addressOfExpression>
												<methodReferenceExpression methodName="ReplaceStringConstants"/>
											</addressOfExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="filterExpression"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<fieldReferenceExpression name="filterExpression"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[(@FltrExpParam\d+|[a-zA-Z_]\w*)]]></xsl:attribute>
											</primitiveExpression>
											<addressOfExpression>
												<methodReferenceExpression methodName="CheckNames"/>
											</addressOfExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="filterExpression"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<fieldReferenceExpression name="filterExpression"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[(?<!@)(\w+)]]></xsl:attribute>
											</primitiveExpression>
											<addressOfExpression>
												<methodReferenceExpression methodName="ReplaceBooleans"/>
											</addressOfExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="filterExpression"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<fieldReferenceExpression name="filterExpression"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[(\w+)\s+(contains|endsWith|startsWith)\s+(\S+)]]></xsl:attribute>
											</primitiveExpression>
											<addressOfExpression>
												<methodReferenceExpression methodName="ReplaceContains"/>
											</addressOfExpression>
											<propertyReferenceExpression name="IgnoreCase">
												<typeReferenceExpression type="RegexOptions"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<comment>set the new filter for further processing</comment>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Items">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</target>
										<indices>
											<binaryOperatorExpression operator="Add">
												<propertyReferenceExpression name="ControllerName">
													<fieldReferenceExpression name="options"/>
												</propertyReferenceExpression>
												<primitiveExpression value="_FilterExpression"/>
											</binaryOperatorExpression>
										</indices>
									</arrayIndexerExpression>
									<fieldReferenceExpression name="filterExpression"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Items">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</target>
										<indices>
											<binaryOperatorExpression operator="Add">
												<propertyReferenceExpression name="ControllerName">
													<fieldReferenceExpression name="options"/>
												</propertyReferenceExpression>
												<primitiveExpression value="_FilterParameters"/>
											</binaryOperatorExpression>
										</indices>
									</arrayIndexerExpression>
									<propertyReferenceExpression name="Parameters">
										<fieldReferenceExpression name="options"/>
									</propertyReferenceExpression>
								</assignStatement>
							</statements>
						</memberMethod>
						<!-- method AddFilterExpressionParameter(object) -->
						<memberMethod returnType="System.String" name="AddFilterExpressionParameter">
							<attributes private="true"/>
							<parameters>
								<parameter type="System.Object" name="value"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="parameters">
									<init>
										<propertyReferenceExpression name="Parameters">
											<fieldReferenceExpression name="options"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="name">
									<init>
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="@FltrExpParam"/>
											<methodInvokeExpression methodName="ToString">
												<target>
													<propertyReferenceExpression name="Count">
														<variableReferenceExpression name="parameters"/>
													</propertyReferenceExpression>
												</target>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<variableReferenceExpression name="parameters"/>
									</target>
									<parameters>
										<variableReferenceExpression name="name"/>
										<variableReferenceExpression name="value"/>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<variableReferenceExpression name="name"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ReplaceStringConstants(Match) -->
						<memberMethod returnType="System.String" name="ReplaceStringConstants">
							<attributes private="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<propertyReferenceExpression name="Value">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Groups">
															<argumentReferenceExpression name="m"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="3"/>
													</indices>
												</arrayIndexerExpression>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ThrowError">
											<target>
												<typeReferenceExpression type="RESTfulResource"/>
											</target>
											<parameters>
												<primitiveExpression value="invalid_argument"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[Unclosed single quote in the '{0}' parameter.]]></xsl:attribute>
												</primitiveExpression>
												<propertyReferenceExpression name="FilterParam">
													<fieldReferenceExpression name="options"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="Add">
										<primitiveExpression value=" "/>
										<binaryOperatorExpression operator="Add">
											<methodInvokeExpression methodName="AddFilterExpressionParameter">
												<parameters>
													<methodInvokeExpression methodName="Replace">
														<target>
															<propertyReferenceExpression name="Value">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Groups">
																			<argumentReferenceExpression name="m"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="2"/>
																	</indices>
																</arrayIndexerExpression>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="\"/>
															<stringEmptyExpression/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
											<primitiveExpression value=" "/>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ReplaceBooleans(Match) -->
						<memberMethod returnType="System.String" name="ReplaceBooleans">
							<attributes private="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="fieldName">
									<init>
										<propertyReferenceExpression name="Value">
											<argumentReferenceExpression name="m"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="XPathNavigator" name="fieldNav" var="false">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="TryGetValue">
											<target>
												<fieldReferenceExpression name="fieldMap"/>
											</target>
											<parameters>
												<variableReferenceExpression name="fieldName"/>
												<directionExpression direction="Out">
													<variableReferenceExpression name="fieldNav"/>
												</directionExpression>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<methodInvokeExpression methodName="GetAttribute">
														<target>
															<variableReferenceExpression name="fieldNav"/>
														</target>
														<parameters>
															<primitiveExpression value="type"/>
															<stringEmptyExpression/>
														</parameters>
													</methodInvokeExpression>
													<primitiveExpression value="Boolean"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<stringFormatExpression>
														<xsl:attribute name="format"><![CDATA[({0}={1})]]></xsl:attribute>
														<variableReferenceExpression name="fieldName"/>
														<methodInvokeExpression methodName="AddFilterExpressionParameter">
															<parameters>
																<primitiveExpression value="true"/>
															</parameters>
														</methodInvokeExpression>
													</stringFormatExpression>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="fieldName"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ReplaceContains(Match) -->
						<memberMethod returnType="System.String" name="ReplaceContains">
							<attributes private="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="fieldName">
									<init>
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
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="op">
									<init>
										<methodInvokeExpression methodName="ToLower">
											<target>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<argumentReferenceExpression name="m"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="2"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="value">
									<init>
										<propertyReferenceExpression name="Value">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Groups">
														<argumentReferenceExpression name="m"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="3"/>
												</indices>
											</arrayIndexerExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="sb">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="ContainsKey">
												<target>
													<fieldReferenceExpression name="fieldMap"/>
												</target>
												<parameters>
													<variableReferenceExpression name="fieldName"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ThrowError">
											<target>
												<typeReferenceExpression type="RESTfulResource"/>
											</target>
											<parameters>
												<primitiveExpression value="400"/>
												<primitiveExpression value="true"/>
												<primitiveExpression value="invalid_argument"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[Unexpected field '{0}' is specified in the '{1}' parameter.]]></xsl:attribute>
												</primitiveExpression>
												<variableReferenceExpression name="fieldName"/>
												<propertyReferenceExpression name="FilterParam">
													<fieldReferenceExpression name="options"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.Object" name="paramValue" var="false">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="TryGetValue">
											<target>
												<propertyReferenceExpression name="Parameters">
													<fieldReferenceExpression name="options"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="value"/>
												<directionExpression direction="Out">
													<variableReferenceExpression name="paramValue"/>
												</directionExpression>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="valueString">
											<init>
												<methodInvokeExpression methodName="ToString">
													<target>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Parameters">
																	<fieldReferenceExpression name="options"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<variableReferenceExpression name="value"/>
															</indices>
														</arrayIndexerExpression>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="valueString"/>
														</target>
														<parameters>
															<primitiveExpression value="%"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="op"/>
															<primitiveExpression value="contains"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="valueString"/>
															<stringFormatExpression format="%{{0}}%">
																<variableReferenceExpression name="valueString"/>
															</stringFormatExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="op"/>
																	<primitiveExpression value="startswith"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="valueString"/>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="valueString"/>
																		<primitiveExpression value="%"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<assignStatement>
																	<variableReferenceExpression name="valueString"/>
																	<binaryOperatorExpression operator="Add">
																		<primitiveExpression value="%"/>
																		<variableReferenceExpression name="valueString"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Parameters">
																<fieldReferenceExpression name="options"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<variableReferenceExpression name="value"/>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="valueString"/>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="paramValue"/>
													<variableReferenceExpression name="value"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="value"/>
														</target>
														<parameters>
															<primitiveExpression value="%"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="op"/>
															<primitiveExpression value="contains"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="value"/>
															<stringFormatExpression format="%{{0}}%">
																<variableReferenceExpression name="value"/>
															</stringFormatExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="op"/>
																	<primitiveExpression value="startswith"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="value"/>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="value"/>
																		<primitiveExpression value="%"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<assignStatement>
																	<variableReferenceExpression name="value"/>
																	<binaryOperatorExpression operator="Add">
																		<primitiveExpression value="%"/>
																		<variableReferenceExpression name="value"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="paramValue"/>
											<methodInvokeExpression methodName="AddFilterExpressionParameter">
												<parameters>
													<variableReferenceExpression name="value"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<stringFormatExpression>
										<xsl:attribute name="format"><![CDATA[({0} like {1})]]></xsl:attribute>
										<variableReferenceExpression name="fieldName"/>
										<variableReferenceExpression name="paramValue"/>
									</stringFormatExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CheckNames(Match) -->
						<memberMethod returnType="System.String" name="CheckNames">
							<attributes private="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="name">
									<init>
										<propertyReferenceExpression name="Value">
											<argumentReferenceExpression name="m"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<variableReferenceExpression name="name"/>
											</target>
											<parameters>
												<primitiveExpression value="@"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="ContainsKey">
														<target>
															<propertyReferenceExpression name="Parameters">
																<fieldReferenceExpression name="options"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<variableReferenceExpression name="name"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ThrowError">
													<target>
														<typeReferenceExpression type="RESTfulResource"/>
													</target>
													<parameters>
														<primitiveExpression value="invalid_argument"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[Symbol '@' is not allowed in the '{0}' parameter.]]></xsl:attribute>
														</primitiveExpression>
														<propertyReferenceExpression name="FilterParam">
															<fieldReferenceExpression name="options"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<methodReturnStatement>
													<propertyReferenceExpression name="Value">
														<argumentReferenceExpression name="m"/>
													</propertyReferenceExpression>
												</methodReturnStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="ContainsKey">
												<target>
													<fieldReferenceExpression name="fieldMap"/>
												</target>
												<parameters>
													<variableReferenceExpression name="name"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<methodInvokeExpression methodName="IndexOf">
														<target>
															<typeReferenceExpression type="Array"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Keywords"/>
															<methodInvokeExpression methodName="ToLower">
																<target>
																	<argumentReferenceExpression name="name"/>
																</target>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
													<primitiveExpression value="-1"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ThrowError">
													<target>
														<typeReferenceExpression type="RESTfulResource"/>
													</target>
													<parameters>
														<primitiveExpression value="400"/>
														<primitiveExpression value="true"/>
														<primitiveExpression value="invalid_argument"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[Unexpected field '{0}' is specified in the '{1}' parameter.]]></xsl:attribute>
														</primitiveExpression>
														<variableReferenceExpression name="name"/>
														<propertyReferenceExpression name="FilterParam">
															<fieldReferenceExpression name="options"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<methodReturnStatement>
													<propertyReferenceExpression name="Value">
														<argumentReferenceExpression name="m"/>
													</propertyReferenceExpression>
												</methodReturnStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<propertyReferenceExpression name="Value">
										<argumentReferenceExpression name="m"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class EmbeddedLink -->
				<typeDeclaration name="EmbeddedLink">
					<attributes public="true"/>
					<members>
						<!-- property Rel -->
						<memberProperty type="System.String" name="Rel">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Href -->
						<memberProperty type="System.String" name="Href">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Target -->
						<memberProperty type="JObject" name="Target">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Response -->
						<memberProperty type="JObject" name="Response">
							<attributes public="true" final="true"/>
						</memberProperty>
					</members>
				</typeDeclaration>
				<!-- class EmbeddingEngine -->
				<typeDeclaration name="EmbeddingEngine">
					<attributes public="true"/>
					<members>
						<!-- field links -->
						<memberField type="List" name="links">
							<typeArguments>
								<typeReference type="EmbeddedLink"/>
							</typeArguments>
						</memberField>
						<!-- field embed -->
						<memberField type="List" name="embed">
							<typeArguments>
								<typeReference type="System.String"/>
							</typeArguments>
						</memberField>
						<!-- field options -->
						<memberField type="RESTfulResourceConfiguration" name="options"/>
						<!-- field target -->
						<memberField type="JObject" name="target"/>
						<!-- constructor(JObject, List<string>, RESTfulResourceConfiguration) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="JObject" name="target"/>
								<parameter type="List" name="embed">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
								</parameter>
								<parameter type="RESTfulResourceConfiguration" name="options"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="options"/>
									<argumentReferenceExpression name="options"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="links"/>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="EmbeddedLink"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="target"/>
									<argumentReferenceExpression name="target"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="embed"/>
									<argumentReferenceExpression name="embed"/>
								</assignStatement>
								<forStatement>
									<variable name="i">
										<init>
											<primitiveExpression value="0"/>
										</init>
									</variable>
									<test>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="i"/>
											<propertyReferenceExpression name="Count">
												<argumentReferenceExpression name="embed"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="i"/>
									</increment>
									<statements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<fieldReferenceExpression name="embed"/>
												</target>
												<indices>
													<variableReferenceExpression name="i"/>
												</indices>
											</arrayIndexerExpression>
											<methodInvokeExpression methodName="NormalizeKey">
												<target>
													<typeReferenceExpression type="ConfigDictionary"/>
												</target>
												<parameters>
													<arrayIndexerExpression>
														<target>
															<fieldReferenceExpression name="embed"/>
														</target>
														<indices>
															<variableReferenceExpression name="i"/>
														</indices>
													</arrayIndexerExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</statements>
								</forStatement>
								<methodInvokeExpression methodName="EmbedLinks">
									<parameters>
										<fieldReferenceExpression name="target"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</constructor>
						<!-- method Execute(string, RESTfulResourceConfiguration) -->
						<memberMethod returnType="System.String" name="Execute">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="href"/>
								<parameter type="RESTfulResourceConfiguration" name="options"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="currentRequest">
									<init>
										<propertyReferenceExpression name="Request">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="HttpContext"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="server">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="ToString">
													<target>
														<propertyReferenceExpression name="Url">
															<variableReferenceExpression name="currentRequest"/>
														</propertyReferenceExpression>
													</target>
												</methodInvokeExpression>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[^(.+?)/v2(\/)]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="headers">
									<init>
										<propertyReferenceExpression name="Headers">
											<variableReferenceExpression name="currentRequest"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="url">
									<init>
										<binaryOperatorExpression operator="Add">
											<propertyReferenceExpression name="Value">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Groups">
															<variableReferenceExpression name="server"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="1"/>
													</indices>
												</arrayIndexerExpression>
											</propertyReferenceExpression>
											<argumentReferenceExpression name="href"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="cachedResult">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Cache">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<variableReferenceExpression name="url"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="cachedResult"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<variableReferenceExpression name="cachedResult"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="request">
									<init>
										<castExpression targetType="HttpWebRequest">
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<variableReferenceExpression name="url"/>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="key" var="false"/>
									<target>
										<variableReferenceExpression name="headers"/>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="IsRestricted">
														<target>
															<typeReferenceExpression type="WebHeaderCollection"/>
														</target>
														<parameters>
															<variableReferenceExpression name="key"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Headers">
																<variableReferenceExpression name="request"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<variableReferenceExpression name="key"/>
														</indices>
													</arrayIndexerExpression>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="headers"/>
														</target>
														<indices>
															<variableReferenceExpression name="key"/>
														</indices>
													</arrayIndexerExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="options"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="RemoveLinks">
													<argumentReferenceExpression name="options"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Headers">
																<variableReferenceExpression name="request"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="X-Restful-HypermediaEmbeddedReplace"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="true" convertTo="String"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Headers">
														<variableReferenceExpression name="request"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="X-Restful-OutputContentType"/>
												</indices>
											</arrayIndexerExpression>
											<propertyReferenceExpression name="OutputContentType">
												<argumentReferenceExpression name="options"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="Method">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<primitiveExpression value="GET"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Accept">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<primitiveExpression value="*/*"/>
								</assignStatement>
								<usingStatement>
									<variable name="response">
										<init>
											<methodInvokeExpression methodName="GetResponse">
												<target>
													<variableReferenceExpression name="request"/>
												</target>
											</methodInvokeExpression>
										</init>
									</variable>
									<statements>
										<usingStatement>
											<variable name="responseStream">
												<init>
													<methodInvokeExpression methodName="GetResponseStream">
														<target>
															<variableReferenceExpression name="response"/>
														</target>
													</methodInvokeExpression>
												</init>
											</variable>
											<statements>
												<variableDeclarationStatement name="stream">
													<init>
														<variableReferenceExpression name="responseStream"/>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="contentEncoding">
													<init>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Headers">
																	<variableReferenceExpression name="response"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Content-Encoding"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="cacheControl">
													<init>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Headers">
																	<variableReferenceExpression name="response"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Cache-Control"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="contentEncoding"/>
															<primitiveExpression value="gzip"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="stream"/>
															<objectCreateExpression type="GZipStream">
																<parameters>
																	<variableReferenceExpression name="stream"/>
																	<propertyReferenceExpression name="Decompress">
																		<typeReferenceExpression type="CompressionMode"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="contentEncoding"/>
																	<primitiveExpression value="deflate"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="stream"/>
																	<objectCreateExpression type="DeflateStream">
																		<parameters>
																			<variableReferenceExpression name="stream"/>
																			<propertyReferenceExpression name="Decompress">
																				<typeReferenceExpression type="CompressionMode"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</objectCreateExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<variableDeclarationStatement name="result">
													<init>
														<methodInvokeExpression methodName="ReadToEnd">
															<target>
																<objectCreateExpression type="StreamReader">
																	<parameters>
																		<variableReferenceExpression name="stream"/>
																	</parameters>
																</objectCreateExpression>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="cacheControl"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="maxAge">
															<init>
																<methodInvokeExpression methodName="Match">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="cacheControl"/>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[max-age=(\d+)]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<propertyReferenceExpression name="Success">
																	<variableReferenceExpression name="maxAge"/>
																</propertyReferenceExpression>
															</condition>
															<trueStatements>
																<tryStatement>
																	<statements>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<propertyReferenceExpression name="Cache">
																					<propertyReferenceExpression name="Current">
																						<typeReferenceExpression type="HttpContext"/>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="url"/>
																				<variableReferenceExpression name="result"/>
																				<primitiveExpression value="null"/>
																				<methodInvokeExpression methodName="AddSeconds">
																					<target>
																						<propertyReferenceExpression name="Now">
																							<typeReferenceExpression type="DateTime"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<convertExpression to="Int32">
																							<propertyReferenceExpression name="Value">
																								<arrayIndexerExpression>
																									<target>
																										<propertyReferenceExpression name="Groups">
																											<variableReferenceExpression name="maxAge"/>
																										</propertyReferenceExpression>
																									</target>
																									<indices>
																										<primitiveExpression value="1"/>
																									</indices>
																								</arrayIndexerExpression>
																							</propertyReferenceExpression>
																						</convertExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<propertyReferenceExpression name="NoSlidingExpiration">
																					<typeReferenceExpression type="Cache"/>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="Normal">
																					<typeReferenceExpression type="CacheItemPriority"/>
																				</propertyReferenceExpression>
																				<primitiveExpression value="null"/>
																			</parameters>
																		</methodInvokeExpression>
																	</statements>
																	<catch exceptionType="Exception"></catch>
																</tryStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
												<methodReturnStatement>
													<variableReferenceExpression name="result"/>
												</methodReturnStatement>
											</statements>
										</usingStatement>
									</statements>
								</usingStatement>
							</statements>
						</memberMethod>
						<!-- method Execute() -->
						<memberMethod name="Execute">
							<attributes public="true" final="true"/>
							<statements>
								<variableDeclarationStatement name="index">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="index"/>
											<propertyReferenceExpression name="Count">
												<fieldReferenceExpression name="links"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</test>
									<statements>
										<variableDeclarationStatement name="link">
											<init>
												<arrayIndexerExpression>
													<target>
														<fieldReferenceExpression name="links"/>
													</target>
													<indices>
														<variableReferenceExpression name="index"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="JObject" name="result" var="false">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<tryStatement>
											<statements>
												<comment>prepare new _embed instruction</comment>
												<variableDeclarationStatement name="embedList">
													<init>
														<objectCreateExpression type="List">
															<typeArguments>
																<typeReference type="System.String"/>
															</typeArguments>
														</objectCreateExpression>
													</init>
												</variableDeclarationStatement>
												<comment>prepare the field filter</comment>
												<variableDeclarationStatement name="href">
													<init>
														<propertyReferenceExpression name="Href">
															<variableReferenceExpression name="link"/>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="linkNamePrefix">
													<init>
														<binaryOperatorExpression operator="Add">
															<methodInvokeExpression methodName="NormalizeKey">
																<target>
																	<typeReferenceExpression type="ConfigDictionary"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Rel">
																		<variableReferenceExpression name="link"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression value="."/>
														</binaryOperatorExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="fieldFilter">
													<init>
														<objectCreateExpression type="List">
															<typeArguments>
																<typeReference type="System.String"/>
															</typeArguments>
														</objectCreateExpression>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable name="name"/>
													<target>
														<fieldReferenceExpression name="embed"/>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="StartsWith">
																	<target>
																		<variableReferenceExpression name="name"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="linkNamePrefix"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="field">
																	<init>
																		<methodInvokeExpression methodName="Substring">
																			<target>
																				<variableReferenceExpression name="name"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Length">
																					<variableReferenceExpression name="linkNamePrefix"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="Contains">
																			<target>
																				<variableReferenceExpression name="field"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="*"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement name="periodStarIndex">
																			<init>
																				<methodInvokeExpression methodName="IndexOf">
																					<target>
																						<variableReferenceExpression name="field"/>
																					</target>
																					<parameters>
																						<primitiveExpression value=".*"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="GreaterThanOrEqual">
																					<variableReferenceExpression name="periodStarIndex"/>
																					<primitiveExpression value="0"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="embedList"/>
																					</target>
																					<parameters>
																						<methodInvokeExpression methodName="Substring">
																							<target>
																								<variableReferenceExpression name="field"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="0"/>
																								<variableReferenceExpression name="periodStarIndex"/>
																							</parameters>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																	<falseStatements>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<variableReferenceExpression name="fieldFilter"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="field"/>
																			</parameters>
																		</methodInvokeExpression>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="GreaterThan">
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="fieldFilter"/>
															</propertyReferenceExpression>
															<primitiveExpression value="0"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="m">
															<init>
																<methodInvokeExpression methodName="Match">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="href"/>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[(\?|\&)fields=(.+?)(\&|$)]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="linkFieldFilter">
															<init>
																<methodInvokeExpression methodName="Execute">
																	<target>
																		<objectCreateExpression type="NameSetParser">
																			<parameters>
																				<primitiveExpression value="fields"/>
																				<propertyReferenceExpression name="Value">
																					<arrayIndexerExpression>
																						<target>
																							<propertyReferenceExpression name="Groups">
																								<variableReferenceExpression name="m"/>
																							</propertyReferenceExpression>
																						</target>
																						<indices>
																							<primitiveExpression value="2"/>
																						</indices>
																					</arrayIndexerExpression>
																				</propertyReferenceExpression>
																			</parameters>
																		</objectCreateExpression>
																	</target>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="linkFieldFilter"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<foreachStatement>
																	<variable name="name"/>
																	<target>
																		<variableReferenceExpression name="fieldFilter"/>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<methodInvokeExpression methodName="Contains">
																						<target>
																							<variableReferenceExpression name="linkFieldFilter"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="name"/>
																						</parameters>
																					</methodInvokeExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="linkFieldFilter"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="name"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
																<assignStatement>
																	<variableReferenceExpression name="fieldFilter"/>
																	<variableReferenceExpression name="linkFieldFilter"/>
																</assignStatement>
																<assignStatement>
																	<variableReferenceExpression name="href"/>
																	<binaryOperatorExpression operator="Add">
																		<methodInvokeExpression methodName="Substring">
																			<target>
																				<variableReferenceExpression name="href"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="0"/>
																				<propertyReferenceExpression name="Index">
																					<arrayIndexerExpression>
																						<target>
																							<propertyReferenceExpression name="Groups">
																								<variableReferenceExpression name="m"/>
																							</propertyReferenceExpression>
																						</target>
																						<indices>
																							<primitiveExpression value="2"/>
																						</indices>
																					</arrayIndexerExpression>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="Substring">
																			<target>
																				<variableReferenceExpression name="href"/>
																			</target>
																			<parameters>
																				<binaryOperatorExpression operator="Add">
																					<propertyReferenceExpression name="Index">
																						<arrayIndexerExpression>
																							<target>
																								<propertyReferenceExpression name="Groups">
																									<variableReferenceExpression name="m"/>
																								</propertyReferenceExpression>
																							</target>
																							<indices>
																								<primitiveExpression value="3"/>
																							</indices>
																						</arrayIndexerExpression>
																					</propertyReferenceExpression>
																					<primitiveExpression value="1"/>
																				</binaryOperatorExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="Contains">
																		<target>
																			<variableReferenceExpression name="href"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="?"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="href"/>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="href"/>
																		<primitiveExpression value="?"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="EndsWith">
																				<target>
																					<variableReferenceExpression name="href"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="&amp;"/>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="href"/>
																			<binaryOperatorExpression operator="Add">
																				<variableReferenceExpression name="href"/>
																				<primitiveExpression value="&amp;"/>
																			</binaryOperatorExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
														<assignStatement>
															<variableReferenceExpression name="href"/>
															<binaryOperatorExpression operator="Add">
																<binaryOperatorExpression operator="Add">
																	<variableReferenceExpression name="href"/>
																	<primitiveExpression value="fields="/>
																</binaryOperatorExpression>
																<methodInvokeExpression methodName="Join">
																	<target>
																		<typeReferenceExpression type="System.String"/>
																	</target>
																	<parameters>
																		<primitiveExpression value=","/>
																		<variableReferenceExpression name="fieldFilter"/>
																	</parameters>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="GreaterThan">
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="embedList"/>
															</propertyReferenceExpression>
															<primitiveExpression value="0"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="Contains">
																		<target>
																			<variableReferenceExpression name="href"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="?"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="href"/>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="href"/>
																		<primitiveExpression value="?"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="EndsWith">
																				<target>
																					<variableReferenceExpression name="href"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="&amp;"/>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="href"/>
																			<binaryOperatorExpression operator="Add">
																				<variableReferenceExpression name="href"/>
																				<primitiveExpression value="&amp;"/>
																			</binaryOperatorExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
														<assignStatement>
															<variableReferenceExpression name="href"/>
															<stringFormatExpression>
																<xsl:attribute name="format"><![CDATA[{0}{1}={2}]]></xsl:attribute>
																<variableReferenceExpression name="href"/>
																<propertyReferenceExpression name="EmbedParam">
																	<fieldReferenceExpression name="options"/>
																</propertyReferenceExpression>
																<methodInvokeExpression methodName="Join">
																	<target>
																		<typeReferenceExpression type="System.String"/>
																	</target>
																	<parameters>
																		<primitiveExpression value=","/>
																		<variableReferenceExpression name="embedList"/>
																	</parameters>
																</methodInvokeExpression>
															</stringFormatExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="result"/>
													<methodInvokeExpression methodName="Parse">
														<target>
															<typeReferenceExpression type="JObject"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="Execute">
																<target>
																	<typeReferenceExpression type="EmbeddingEngine"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="href"/>
																	<fieldReferenceExpression name="options"/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</statements>
											<catch exceptionType="WebException" localName="ex">
												<variableDeclarationStatement name="response">
													<init>
														<propertyReferenceExpression name="Response">
															<variableReferenceExpression name="ex"/>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="stream">
													<init>
														<methodInvokeExpression methodName="GetResponseStream">
															<target>
																<variableReferenceExpression name="response"/>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="contentEncoding">
													<init>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Headers">
																	<variableReferenceExpression name="response"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Content-Encoding"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="contentEncoding"/>
															<primitiveExpression value="gzip"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="stream"/>
															<objectCreateExpression type="GZipStream">
																<parameters>
																	<variableReferenceExpression name="stream"/>
																	<propertyReferenceExpression name="Decompress">
																		<typeReferenceExpression type="CompressionMode"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement name="body">
													<init>
														<methodInvokeExpression methodName="ReadToEnd">
															<target>
																<objectCreateExpression type="StreamReader">
																	<parameters>
																		<variableReferenceExpression name="stream"/>
																	</parameters>
																</objectCreateExpression>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="StartsWith">
															<target>
																<propertyReferenceExpression name="ContentType">
																	<variableReferenceExpression name="response"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<primitiveExpression value="application/json"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="result"/>
															<methodInvokeExpression methodName="Parse">
																<target>
																	<typeReferenceExpression type="JObject"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="body"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<assignStatement>
															<variableReferenceExpression name="result"/>
															<objectCreateExpression type="JObject">
																<parameters>
																	<objectCreateExpression type="JProperty">
																		<parameters>
																			<primitiveExpression value="href"/>
																			<propertyReferenceExpression name="Href">
																				<variableReferenceExpression name="link"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</objectCreateExpression>
																	<objectCreateExpression type="JProperty">
																		<parameters>
																			<primitiveExpression value="status"/>
																			<methodInvokeExpression methodName="ToString">
																				<target>
																					<propertyReferenceExpression name="Status">
																						<argumentReferenceExpression name="ex"/>
																					</propertyReferenceExpression>
																				</target>
																			</methodInvokeExpression>
																		</parameters>
																	</objectCreateExpression>
																	<objectCreateExpression type="JProperty">
																		<parameters>
																			<primitiveExpression value="error"/>
																			<propertyReferenceExpression name="Message">
																				<variableReferenceExpression name="ex"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</objectCreateExpression>
																	<objectCreateExpression type="JProperty">
																		<parameters>
																			<primitiveExpression value="body"/>
																			<variableReferenceExpression name="body"/>
																		</parameters>
																	</objectCreateExpression>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
											</catch>
											<catch exceptionType="Exception" localName="ex">
												<comment>handle the "bad" link</comment>
												<assignStatement>
													<variableReferenceExpression name="result"/>
													<objectCreateExpression type="JObject">
														<parameters>
															<objectCreateExpression type="JProperty">
																<parameters>
																	<primitiveExpression value="href"/>
																	<propertyReferenceExpression name="Href">
																		<variableReferenceExpression name="link"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
															<objectCreateExpression type="JProperty">
																<parameters>
																	<primitiveExpression value="error"/>
																	<propertyReferenceExpression name="Message">
																		<variableReferenceExpression name="ex"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</parameters>
													</objectCreateExpression>
												</assignStatement>
											</catch>
										</tryStatement>
										<comment>add the result to the link target</comment>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="ReplaceEmbedded">
													<fieldReferenceExpression name="options"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Target">
																<variableReferenceExpression name="link"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<propertyReferenceExpression name="Rel">
																<variableReferenceExpression name="link"/>
															</propertyReferenceExpression>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="result"/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<variableDeclarationStatement name="embedded">
													<init>
														<castExpression targetType="JObject">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Target">
																		<variableReferenceExpression name="link"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<propertyReferenceExpression name="EmbeddedKey">
																		<fieldReferenceExpression name="options"/>
																	</propertyReferenceExpression>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="embedded"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="embedded"/>
															<objectCreateExpression type="JObject"/>
														</assignStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<propertyReferenceExpression name="Target">
																	<variableReferenceExpression name="link"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<objectCreateExpression type="JProperty">
																	<parameters>
																		<propertyReferenceExpression name="EmbeddedKey">
																			<fieldReferenceExpression name="options"/>
																		</propertyReferenceExpression>
																		<variableReferenceExpression name="embedded"/>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="embedded"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Rel">
															<variableReferenceExpression name="link"/>
														</propertyReferenceExpression>
														<variableReferenceExpression name="result"/>
													</parameters>
												</methodInvokeExpression>
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
								</whileStatement>
							</statements>
						</memberMethod>
						<!-- method EmbedLinks(JObject) -->
						<memberMethod name="EmbedLinks">
							<attributes public="true"/>
							<parameters>
								<parameter type="JObject" name="target"/>
							</parameters>
							<statements>
								<foreachStatement>
									<variable name="p"/>
									<target>
										<methodInvokeExpression methodName="Properties">
											<target>
												<variableReferenceExpression name="target"/>
											</target>
										</methodInvokeExpression>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Name">
														<variableReferenceExpression name="p"/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="LinksKey">
														<fieldReferenceExpression name="options"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="Type">
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="p"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Object">
																<typeReferenceExpression type="JTokenType"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<foreachStatement>
															<variable name="l"/>
															<target>
																<methodInvokeExpression methodName="Properties">
																	<target>
																		<castExpression targetType="JObject">
																			<propertyReferenceExpression name="Value">
																				<variableReferenceExpression name="p"/>
																			</propertyReferenceExpression>
																		</castExpression>
																	</target>
																</methodInvokeExpression>
															</target>
															<statements>
																<variableDeclarationStatement name="normalName">
																	<init>
																		<methodInvokeExpression methodName="NormalizeKey">
																			<target>
																				<typeReferenceExpression type="ConfigDictionary"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="l"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueInequality">
																			<propertyReferenceExpression name="Type">
																				<propertyReferenceExpression name="Value">
																					<variableReferenceExpression name="l"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="Object">
																				<typeReferenceExpression type="JTokenType"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanOr">
																					<methodInvokeExpression methodName="Contains">
																						<target>
																							<fieldReferenceExpression name="embed"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="normalName"/>
																						</parameters>
																					</methodInvokeExpression>
																					<methodInvokeExpression methodName="Contains">
																						<target>
																							<fieldReferenceExpression name="embed"/>
																						</target>
																						<parameters>
																							<binaryOperatorExpression operator="Add">
																								<variableReferenceExpression name="normalName"/>
																								<primitiveExpression value=".*"/>
																							</binaryOperatorExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement name="el">
																					<init>
																						<objectCreateExpression type="EmbeddedLink"/>
																					</init>
																				</variableDeclarationStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="Rel">
																						<variableReferenceExpression name="el"/>
																					</propertyReferenceExpression>
																					<propertyReferenceExpression name="Name">
																						<variableReferenceExpression name="l"/>
																					</propertyReferenceExpression>
																				</assignStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="Href">
																						<variableReferenceExpression name="el"/>
																					</propertyReferenceExpression>
																					<convertExpression to="String">
																						<propertyReferenceExpression name="Value">
																							<variableReferenceExpression name="l"/>
																						</propertyReferenceExpression>
																					</convertExpression>
																				</assignStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="Target">
																						<variableReferenceExpression name="el"/>
																					</propertyReferenceExpression>
																					<variableReferenceExpression name="target"/>
																				</assignStatement>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<fieldReferenceExpression name="links"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="el"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanAnd">
																					<convertExpression to="Boolean">
																						<arrayIndexerExpression>
																							<target>
																								<propertyReferenceExpression name="Value">
																									<variableReferenceExpression name="l"/>
																								</propertyReferenceExpression>
																							</target>
																							<indices>
																								<propertyReferenceExpression name="EmbeddableKey">
																									<fieldReferenceExpression name="options"/>
																								</propertyReferenceExpression>
																							</indices>
																						</arrayIndexerExpression>
																					</convertExpression>
																					<binaryOperatorExpression operator="BooleanOr">
																						<methodInvokeExpression methodName="Contains">
																							<target>
																								<fieldReferenceExpression name="embed"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="normalName"/>
																							</parameters>
																						</methodInvokeExpression>
																						<methodInvokeExpression methodName="Contains">
																							<target>
																								<fieldReferenceExpression name="embed"/>
																							</target>
																							<parameters>
																								<binaryOperatorExpression operator="Add">
																									<variableReferenceExpression name="normalName"/>
																									<primitiveExpression value=".*"/>
																								</binaryOperatorExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement name="el">
																					<init>
																						<objectCreateExpression type="EmbeddedLink"/>
																					</init>
																				</variableDeclarationStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="Rel">
																						<variableReferenceExpression name="el"/>
																					</propertyReferenceExpression>
																					<propertyReferenceExpression name="Name">
																						<variableReferenceExpression name="l"/>
																					</propertyReferenceExpression>
																				</assignStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="Href">
																						<variableReferenceExpression name="el"/>
																					</propertyReferenceExpression>
																					<convertExpression to="String">
																						<arrayIndexerExpression>
																							<target>
																								<propertyReferenceExpression name="Value">
																									<variableReferenceExpression name="l"/>
																								</propertyReferenceExpression>
																							</target>
																							<indices>
																								<primitiveExpression value="href"/>
																							</indices>
																						</arrayIndexerExpression>
																					</convertExpression>
																				</assignStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="Target">
																						<variableReferenceExpression name="el"/>
																					</propertyReferenceExpression>
																					<variableReferenceExpression name="target"/>
																				</assignStatement>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<fieldReferenceExpression name="links"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="el"/>
																					</parameters>
																				</methodInvokeExpression>

																			</trueStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Type">
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="p"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="Array">
																		<typeReferenceExpression type="JTokenType"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<foreachStatement>
																	<variable type="JObject" name="l" var="false"/>
																	<target>
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="p"/>
																		</propertyReferenceExpression>
																	</target>
																	<statements>
																		<variableDeclarationStatement name="rel">
																			<init>
																				<convertExpression to="String">
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="l"/>
																						</target>
																						<indices>
																							<primitiveExpression value="rel"/>
																						</indices>
																					</arrayIndexerExpression>
																				</convertExpression>
																			</init>
																		</variableDeclarationStatement>
																		<variableDeclarationStatement name="normalRel">
																			<init>
																				<methodInvokeExpression methodName="NormalizeKey">
																					<target>
																						<typeReferenceExpression type="ConfigDictionary"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="rel"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanOr">
																					<binaryOperatorExpression operator="BooleanAnd">
																						<convertExpression to="Boolean">
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="l"/>
																								</target>
																								<indices>
																									<propertyReferenceExpression name="EmbeddableKey">
																										<fieldReferenceExpression name="options"/>
																									</propertyReferenceExpression>
																								</indices>
																							</arrayIndexerExpression>
																						</convertExpression>
																						<methodInvokeExpression methodName="Contains">
																							<target>
																								<fieldReferenceExpression name="embed"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="normalRel"/>
																							</parameters>
																						</methodInvokeExpression>
																					</binaryOperatorExpression>
																					<methodInvokeExpression methodName="Contains">
																						<target>
																							<fieldReferenceExpression name="embed"/>
																						</target>
																						<parameters>
																							<binaryOperatorExpression operator="Add">
																								<variableReferenceExpression name="normalRel"/>
																								<primitiveExpression value=".*"/>
																							</binaryOperatorExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement name="el">
																					<init>
																						<objectCreateExpression type="EmbeddedLink"/>
																					</init>
																				</variableDeclarationStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="Rel">
																						<variableReferenceExpression name="el"/>
																					</propertyReferenceExpression>
																					<variableReferenceExpression name="rel"/>
																				</assignStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="Href">
																						<variableReferenceExpression name="el"/>
																					</propertyReferenceExpression>
																					<convertExpression to="String">
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="l"/>
																							</target>
																							<indices>
																								<primitiveExpression value="href"/>
																							</indices>
																						</arrayIndexerExpression>
																					</convertExpression>
																				</assignStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="Target">
																						<variableReferenceExpression name="el"/>
																					</propertyReferenceExpression>
																					<variableReferenceExpression name="target"/>
																				</assignStatement>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<fieldReferenceExpression name="links"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="el"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="Type">
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="p"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Object">
																<typeReferenceExpression type="JTokenType"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="EmbedLinks">
															<parameters>
																<castExpression targetType="JObject">
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																</castExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Type">
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="p"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="Array">
																		<typeReferenceExpression type="JTokenType"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<foreachStatement>
																	<variable name="elem"/>
																	<target>
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="p"/>
																		</propertyReferenceExpression>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<propertyReferenceExpression name="Type">
																						<variableReferenceExpression name="elem"/>
																					</propertyReferenceExpression>
																					<propertyReferenceExpression name="Object">
																						<typeReferenceExpression type="JTokenType"/>
																					</propertyReferenceExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="EmbedLinks">
																					<parameters>
																						<castExpression targetType="JObject">
																							<variableReferenceExpression name="elem"/>
																						</castExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class V2ServiceRequestHandlerBase -->
				<typeDeclaration name="V2ServiceRequestHandlerBase">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="ServiceRequestHandler"/>
					</baseTypes>
					<members>
						<!-- property SupportedMethods -->
						<memberField type="System.String[]" name="SupportedMethods">
							<attributes public="true" static="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<primitiveExpression value="GET"/>
										<primitiveExpression value="POST"/>
										<primitiveExpression value="PATCH"/>
										<primitiveExpression value="PUT"/>
										<primitiveExpression value="DELETE"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- property SupportedParameters -->
						<memberField type="System.String[]" name="SupportedParameters">
							<attributes public="true" static="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<primitiveExpression value="controller"/>
										<primitiveExpression value="view"/>
										<primitiveExpression value="sort"/>
										<primitiveExpression value="limit"/>
										<primitiveExpression value="page"/>
										<primitiveExpression value="fields"/>
										<primitiveExpression value="count"/>
										<primitiveExpression value="aggregates"/>
										<primitiveExpression value="format"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- constructor() -->
						<constructor>
							<attributes public="true"/>
						</constructor>
						<!-- property AllowedMethods -->
						<memberProperty type="System.String[]" name="AllowedMethods">
							<attributes override="true" public="true"/>
							<getStatements>
								<methodReturnStatement>
									<propertyReferenceExpression name="SupportedMethods"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property RequiresAuthentication -->
						<memberProperty type="System.Boolean" name="RequiresAuthentication">
							<attributes public="true" override="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property WrapOutput -->
						<memberProperty type="System.Boolean" name="WrapOutput">
							<attributes public="true" override="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property MaxLimit -->
						<memberProperty type="System.Int32" name="MaxLimit">
							<attributes public="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="1000"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method ClearHeaders() -->
						<memberMethod name="ClearHeaders">
							<attributes public="true" override="true"/>
							<statements>
								<variableDeclarationStatement name="response">
									<init>
										<propertyReferenceExpression name="Response">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="HttpContext"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Clear">
									<target>
										<propertyReferenceExpression name="Cookies">
											<variableReferenceExpression name="response"/>
										</propertyReferenceExpression>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Remove">
									<target>
										<propertyReferenceExpression name="Headers">
											<variableReferenceExpression name="response"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="Set-Cookie"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method HandleException(JObject, Exception) -->
						<memberMethod returnType="System.Object" name="HandleException">
							<attributes override="true" public="true"/>
							<parameters>
								<parameter type="JObject" name="args"/>
								<parameter type="Exception" name="ex"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="err">
									<init>
										<primitiveExpression value="unauthorized"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="statusCode">
									<init>
										<primitiveExpression value="-1"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IsTypeOf">
												<variableReferenceExpression name="ex"/>
												<typeReferenceExpression type="HttpException"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<methodInvokeExpression methodName="GetHttpCode">
													<target>
														<castExpression targetType="HttpException">
															<argumentReferenceExpression name="ex"/>
														</castExpression>
													</target>
												</methodInvokeExpression>
												<primitiveExpression value="405"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="err"/>
											<primitiveExpression value="invalid_method"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IsTypeOf">
											<variableReferenceExpression name="ex"/>
											<typeReferenceExpression type="RESTfulResourceException"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="err"/>
											<propertyReferenceExpression name="Error">
												<castExpression targetType="RESTfulResourceException">
													<argumentReferenceExpression name="ex"/>
												</castExpression>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="statusCode"/>
											<propertyReferenceExpression name="HttpCode">
												<castExpression targetType="RESTfulResourceException">
													<argumentReferenceExpression name="ex"/>
												</castExpression>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<variableReferenceExpression name="statusCode"/>
											<primitiveExpression value="-1"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="StatusCode">
												<propertyReferenceExpression name="Response">
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="HttpContext"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<variableReferenceExpression name="statusCode"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="JsonError">
										<target>
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<variableReferenceExpression name="err"/>
											<propertyReferenceExpression name="Message">
												<argumentReferenceExpression name="ex"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Validate(DataControllerService, JObject) -->
						<memberMethod returnType="System.Object" name="Validate">
							<attributes public="true" override="true"/>
							<parameters>
								<parameter type="DataControllerService" name="service"/>
								<parameter type="JObject" name="args"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<convertExpression to="Boolean">
												<methodInvokeExpression methodName="SettingsProperty">
													<target>
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</target>
													<parameters>
														<primitiveExpression value="server.rest.enabled"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ThrowError">
											<target>
												<typeReferenceExpression type="RESTfulResource"/>
											</target>
											<parameters>
												<primitiveExpression value="403"/>
												<primitiveExpression value="unavailable"/>
												<primitiveExpression value="REST API is not enabled."/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsOAuth">
											<typeReferenceExpression type="RESTfulResource"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<convertExpression to="Boolean">
														<methodInvokeExpression methodName="SettingsProperty">
															<target>
																<typeReferenceExpression type="ApplicationServicesBase"/>
															</target>
															<parameters>
																<primitiveExpression value="server.rest.authorization.oauth2.enabled"/>
																<primitiveExpression value="true"/>
															</parameters>
														</methodInvokeExpression>
													</convertExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ThrowError">
													<target>
														<typeReferenceExpression type="RESTfulResource"/>
													</target>
													<parameters>
														<primitiveExpression value="403"/>
														<primitiveExpression value="unavailable"/>
														<primitiveExpression value="Authentication with the bearer token is not enabled."/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="context">
									<init>
										<propertyReferenceExpression name="Current">
											<typeReferenceExpression type="HttpContext"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="IsAuthenticated">
												<propertyReferenceExpression name="Identity">
													<propertyReferenceExpression name="User">
														<variableReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="AnonymousAccessSupported">
													<typeReferenceExpression type="RESTfulResource"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="null"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<unaryOperatorExpression operator="IsNullOrEmpty">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Headers">
																	<propertyReferenceExpression name="Request">
																		<variableReferenceExpression name="context"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="x-api-key"/>
															</indices>
														</arrayIndexerExpression>
													</unaryOperatorExpression>
													<binaryOperatorExpression operator="BooleanAnd">
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="QueryString">
																		<propertyReferenceExpression name="Request">
																			<variableReferenceExpression name="context"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="api_key"/>
																</indices>
															</arrayIndexerExpression>
														</unaryOperatorExpression>
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="QueryString">
																		<propertyReferenceExpression name="Request">
																			<variableReferenceExpression name="context"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="x-api-key"/>
																</indices>
															</arrayIndexerExpression>
														</unaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>"
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ThrowError">
													<target>
														<typeReferenceExpression type="RESTfulResource"/>
													</target>
													<parameters>
														<primitiveExpression value="403"/>
														<primitiveExpression value="missing_api_key"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[RESTful API engine requires an API key or an access token for '{0}' resource.]]></xsl:attribute>
														</primitiveExpression>
														<propertyReferenceExpression name="Path">
															<propertyReferenceExpression name="Request">
																<variableReferenceExpression name="context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="ThrowError">
													<target>
														<typeReferenceExpression type="RESTfulResource"/>
													</target>
													<parameters>
														<primitiveExpression value="403"/>
														<primitiveExpression value="invalid_api_key"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[RESTful API engine requires a valid API key or an access token for '{0}' resource.]]></xsl:attribute>
														</primitiveExpression>
														<propertyReferenceExpression name="Path">
															<propertyReferenceExpression name="Request">
																<variableReferenceExpression name="context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Validate">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<argumentReferenceExpression name="service"/>
											<argumentReferenceExpression name="args"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetDataControllerList() -->
						<memberMethod returnType="System.String[]" name="GetDataControllerList">
							<attributes public="true"/>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetDataControllerList">
										<target>
											<typeReferenceExpression type="ControllerConfigurationUtility"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method HandleRequest(DataControllerService, JObject) -->
						<memberMethod returnType="System.Object" name="HandleRequest">
							<attributes public="true" override="true"/>
							<parameters>
								<parameter type="DataControllerService" name="service"/>
								<parameter type="JObject" name="args"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="context">
									<init>
										<propertyReferenceExpression name="Current">
											<typeReferenceExpression type="HttpContext"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="HttpMethod">
												<propertyReferenceExpression name="Request">
													<variableReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="GET"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="args"/>
											<objectCreateExpression type="JObject"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="result">
									<init>
										<methodInvokeExpression methodName="GraphQLExecute">
											<parameters>
												<argumentReferenceExpression name="service"/>
												<argumentReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="result"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="result"/>
											<methodInvokeExpression methodName="RESTfulExecute">
												<parameters>
													<argumentReferenceExpression name="service"/>
													<argumentReferenceExpression name="args"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method PropToStringArray(JToken, bool) -->
						<memberMethod returnType="System.String[]" name="PropToStringArray">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="JToken" name="prop"/>
								<parameter type="System.Boolean" name="allowSpaceSeparator"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<argumentReferenceExpression name="prop"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IsTypeOf">
													<argumentReferenceExpression name="prop"/>
													<typeReferenceExpression type="JArray"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<methodInvokeExpression methodName="ToObject">
														<typeArguments>
															<typeReference type="System.String[]"/>
														</typeArguments>
														<target>
															<argumentReferenceExpression name="prop"/>
														</target>
													</methodInvokeExpression>
												</methodReturnStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<binaryOperatorExpression operator="IsTypeOf">
																<argumentReferenceExpression name="prop"/>
																<typeReferenceExpression type="JValue"/>
															</binaryOperatorExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ThrowError">
															<target>
																<typeReferenceExpression type="RESTfulResource"/>
															</target>
															<parameters>
																<primitiveExpression value="invalid_parameter"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[Parmeter '{0}' must be a value or an array.]]></xsl:attribute>
																</primitiveExpression>
																<propertyReferenceExpression name="Name">
																	<castExpression targetType="JProperty">
																		<propertyReferenceExpression name="Parent">
																			<argumentReferenceExpression name="prop"/>
																		</propertyReferenceExpression>
																	</castExpression>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
										<variableDeclarationStatement name="list">
											<init>
												<methodInvokeExpression methodName="Trim">
													<target>
														<convertExpression to="String">
															<argumentReferenceExpression name="prop"/>
														</convertExpression>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="list"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<arrayCreateExpression>
														<createType type="System.String"/>
													</arrayCreateExpression>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<variableReferenceExpression name="allowSpaceSeparator"/>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="list"/>
													<methodInvokeExpression methodName="Replace">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<variableReferenceExpression name="list"/>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[\s*,\s*]]></xsl:attribute>
															</primitiveExpression>
															<primitiveExpression value=" "/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<methodReturnStatement>
													<methodInvokeExpression methodName="Split">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<variableReferenceExpression name="list"/>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[\s+]]></xsl:attribute>
															</primitiveExpression>
														</parameters>
													</methodInvokeExpression>
												</methodReturnStatement>
											</trueStatements>
											<falseStatements>
												<methodReturnStatement>
													<methodInvokeExpression methodName="Split">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<variableReferenceExpression name="list"/>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[\s*,\s*]]></xsl:attribute>
															</primitiveExpression>
														</parameters>
													</methodInvokeExpression>
												</methodReturnStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToApiEndpoint(RESTfulResourceConfiguration) -->
						<memberMethod returnType="JObject" name="ToApiEndpoint">
							<attributes public="true"/>
							<parameters>
								<parameter type="RESTfulResourceConfiguration" name="options"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="schema">
									<init>
										<primitiveExpression value="only"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<convertExpression to="Boolean">
											<methodInvokeExpression methodName="SettingsProperty">
												<target>
													<typeReferenceExpression type="ApplicationServicesBase"/>
												</target>
												<parameters>
													<primitiveExpression value="server.rest.schema.data"/>
													<primitiveExpression value="false"/>
												</parameters>
											</methodInvokeExpression>
										</convertExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="schema"/>
											<primitiveExpression value="true" convertTo="String"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="result">
									<init>
										<objectCreateExpression type="JObject"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="links">
									<init>
										<methodInvokeExpression methodName="CreateLinks">
											<target>
												<argumentReferenceExpression name="options"/>
											</target>
											<parameters>
												<variableReferenceExpression name="result"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<xsl:if test="$IsUnlimited='true'">
									<conditionStatement>
										<condition>
											<convertExpression to="Boolean">
												<methodInvokeExpression methodName="SettingsProperty">
													<target>
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</target>
													<parameters>
														<primitiveExpression value="server.rest.authorization.oauth2.enabled"/>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="links"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<conditionStatement>
														<condition>
															<propertyReferenceExpression name="IsOAuth">
																<typeReferenceExpression type="RESTfulResource"/>
															</propertyReferenceExpression>
														</condition>
														<trueStatements>
															<variableDeclarationStatement name="appScopes">
																<init>
																	<castExpression targetType="JObject">
																		<methodInvokeExpression methodName="SettingsProperty">
																			<target>
																				<typeReferenceExpression type="ApplicationServicesBase"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="server.rest.scopes"/>
																				<objectCreateExpression type="JObject"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement name="standardScopes">
																<init>
																	<methodInvokeExpression methodName="StandardScopes">
																		<target>
																			<argumentReferenceExpression name="options"/>
																		</target>
																	</methodInvokeExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement name="standardScopeList">
																<init>
																	<objectCreateExpression type="List">
																		<typeArguments>
																			<typeReference type="JProperty"/>
																		</typeArguments>
																		<parameters>
																			<methodInvokeExpression methodName="Properties">
																				<target>
																					<variableReferenceExpression name="standardScopes"/>
																				</target>
																			</methodInvokeExpression>
																		</parameters>
																	</objectCreateExpression>
																</init>
															</variableDeclarationStatement>
															<methodInvokeExpression methodName="Reverse">
																<target>
																	<variableReferenceExpression name="standardScopeList"/>
																</target>
															</methodInvokeExpression>
															<foreachStatement>
																<variable name="scopeProp"/>
																<target>
																	<variableReferenceExpression name="standardScopeList"/>
																</target>
																<statements>
																	<conditionStatement>
																		<condition>
																			<binaryOperatorExpression operator="IdentityEquality">
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="appScopes"/>
																					</target>
																					<indices>
																						<propertyReferenceExpression name="Name">
																							<variableReferenceExpression name="scopeProp"/>
																						</propertyReferenceExpression>
																					</indices>
																				</arrayIndexerExpression>
																				<primitiveExpression value="null"/>
																			</binaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<methodInvokeExpression methodName="AddFirst">
																				<target>
																					<variableReferenceExpression name="appScopes"/>
																				</target>
																				<parameters>
																					<objectCreateExpression type="JProperty">
																						<parameters>
																							<propertyReferenceExpression name="Name">
																								<variableReferenceExpression name="scopeProp"/>
																							</propertyReferenceExpression>
																							<castExpression targetType="JObject">
																								<propertyReferenceExpression name="Value">
																									<variableReferenceExpression name="scopeProp"/>
																								</propertyReferenceExpression>
																							</castExpression>
																						</parameters>
																					</objectCreateExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</trueStatements>
																	</conditionStatement>
																</statements>
															</foreachStatement>
															<assignStatement>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="result"/>
																	</target>
																	<indices>
																		<primitiveExpression value="scopes"/>
																	</indices>
																</arrayIndexerExpression>
																<variableReferenceExpression name="appScopes"/>
															</assignStatement>
															<conditionStatement>
																<condition>
																	<methodInvokeExpression methodName="IsAuthorized">
																		<target>
																			<typeReferenceExpression type="RESTfulResource"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="post/apps"/>
																			<propertyReferenceExpression name="OAuth2Schema">
																				<typeReferenceExpression type="RESTfulResource"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</condition>
																<trueStatements>
																	<methodInvokeExpression methodName="AddLink">
																		<target>
																			<argumentReferenceExpression name="options"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="apps"/>
																			<primitiveExpression value="GET"/>
																			<variableReferenceExpression name="links"/>
																			<primitiveExpression value="~/oauth2/v2/apps"/>
																		</parameters>
																	</methodInvokeExpression>
																</trueStatements>
															</conditionStatement>
															<methodInvokeExpression methodName="AddLink">
																<target>
																	<argumentReferenceExpression name="options"/>
																</target>
																<parameters>
																	<primitiveExpression value="authorize"/>
																	<primitiveExpression value="GET"/>
																	<variableReferenceExpression name="links"/>
																	<primitiveExpression value="~/oauth2/v2/auth"/>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="AddLink">
																<target>
																	<argumentReferenceExpression name="options"/>
																</target>
																<parameters>
																	<primitiveExpression value="token"/>
																	<primitiveExpression value="POST"/>
																	<variableReferenceExpression name="links"/>
																	<primitiveExpression value="~/oauth2/v2/token"/>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="AddLink">
																<target>
																	<argumentReferenceExpression name="options"/>
																</target>
																<parameters>
																	<primitiveExpression value="tokeninfo"/>
																	<primitiveExpression value="GET"/>
																	<variableReferenceExpression name="links"/>
																	<primitiveExpression value="~/oauth2/v2/tokeninfo"/>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="AddLink">
																<target>
																	<argumentReferenceExpression name="options"/>
																</target>
																<parameters>
																	<primitiveExpression value="userinfo"/>
																	<primitiveExpression value="POST"/>
																	<variableReferenceExpression name="links"/>
																	<primitiveExpression value="~/oauth2/v2/userinfo"/>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="AddLink">
																<target>
																	<argumentReferenceExpression name="options"/>
																</target>
																<parameters>
																	<primitiveExpression value="revoke"/>
																	<primitiveExpression value="POST"/>
																	<variableReferenceExpression name="links"/>
																	<primitiveExpression value="~/oauth2/v2/revoke"/>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="AddLink">
																<target>
																	<argumentReferenceExpression name="options"/>
																</target>
																<parameters>
																	<primitiveExpression value="authorize-client-native"/>
																	<primitiveExpression value="POST"/>
																	<variableReferenceExpression name="links"/>
																	<primitiveExpression value="~/oauth2/v2/auth/pkce"/>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="AddLink">
																<target>
																	<argumentReferenceExpression name="options"/>
																</target>
																<parameters>
																	<primitiveExpression value="authorize-client-spa"/>
																	<primitiveExpression value="POST"/>
																	<variableReferenceExpression name="links"/>
																	<primitiveExpression value="~/oauth2/v2/auth/spa"/>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="AddLink">
																<target>
																	<argumentReferenceExpression name="options"/>
																</target>
																<parameters>
																	<primitiveExpression value="authorize-server"/>
																	<primitiveExpression value="POST"/>
																	<variableReferenceExpression name="links"/>
																	<primitiveExpression value="~/oauth2/v2/auth/server"/>
																</parameters>
															</methodInvokeExpression>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="Not">
																		<propertyReferenceExpression name="RequiresSchema">
																			<argumentReferenceExpression name="options"/>
																		</propertyReferenceExpression>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<methodInvokeExpression methodName="AddLink">
																		<target>
																			<argumentReferenceExpression name="options"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="schema"/>
																			<primitiveExpression value="GET"/>
																			<variableReferenceExpression name="links"/>
																			<stringFormatExpression>
																				<xsl:attribute name="format"><![CDATA[~/oauth2/v2?{0}=true]]></xsl:attribute>
																				<propertyReferenceExpression name="SchemaKey">
																					<argumentReferenceExpression name="options"/>
																				</propertyReferenceExpression>
																			</stringFormatExpression>
																		</parameters>
																	</methodInvokeExpression>
																</trueStatements>
															</conditionStatement>
														</trueStatements>
														<falseStatements>
															<methodInvokeExpression methodName="AddLink">
																<target>
																	<argumentReferenceExpression name="options"/>
																</target>
																<parameters>
																	<primitiveExpression value="oauth2"/>
																	<primitiveExpression value="GET"/>
																	<variableReferenceExpression name="links"/>
																	<primitiveExpression value="~/oauth2/v2"/>
																</parameters>
															</methodInvokeExpression>
														</falseStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="IsOAuth">
												<typeReferenceExpression type="RESTfulResource"/>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<xsl:if test="$IsUnlimited='true'">
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="links"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="AddLink">
														<target>
															<argumentReferenceExpression name="options"/>
														</target>
														<parameters>
															<primitiveExpression value="restful.js"/>
															<primitiveExpression value="GET"/>
															<variableReferenceExpression name="links"/>
															<primitiveExpression value="~/v2/js/restful-2.0.1.js"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</xsl:if>
										<variableDeclarationStatement name="publicApiKey">
											<init>
												<convertExpression to="String">
													<propertyReferenceExpression name="PublicApiKeyInPath">
														<typeReferenceExpression type="RESTfulResource"/>
													</propertyReferenceExpression>
												</convertExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="publicApiKey"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="publicApiKey"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="publicApiKey"/>
														<primitiveExpression value="/"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<foreachStatement>
											<variable name="controllerName"/>
											<target>
												<methodInvokeExpression methodName="GetDataControllerList"/>
											</target>
											<statements>
												<assignStatement>
													<propertyReferenceExpression name="ControllerName">
														<argumentReferenceExpression name="options"/>
													</propertyReferenceExpression>
													<variableReferenceExpression name="controllerName"/>
												</assignStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<methodInvokeExpression methodName="AllowEndpoint">
																<target>
																	<argumentReferenceExpression name="options"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="ControllerResource">
																		<argumentReferenceExpression name="options"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="AllowController">
																<target>
																	<argumentReferenceExpression name="options"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="controllerName"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="controllerObject">
															<init>
																<objectCreateExpression type="JObject"/>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="controllerLinks">
															<init>
																<methodInvokeExpression methodName="CreateLinks">
																	<target>
																		<argumentReferenceExpression name="options"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="controllerObject"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="controllerLinks"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="selfControl">
																	<init>
																		<methodInvokeExpression methodName="AddLink">
																			<target>
																				<argumentReferenceExpression name="options"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="selfLink"/>
																				<primitiveExpression value="GET"/>
																				<variableReferenceExpression name="controllerLinks"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[{0}{1}?count=true]]></xsl:attribute>
																				</primitiveExpression>
																				<variableReferenceExpression name="publicApiKey"/>
																				<propertyReferenceExpression name="ControllerResource">
																					<argumentReferenceExpression name="options"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="cacheItem">
																	<init>
																		<objectCreateExpression type="DataCacheItem">
																			<parameters>
																				<propertyReferenceExpression name="ControllerName">
																					<argumentReferenceExpression name="options"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</objectCreateExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<propertyReferenceExpression name="IsMatch">
																			<variableReferenceExpression name="cacheItem"/>
																		</propertyReferenceExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="AddLink">
																			<target>
																				<argumentReferenceExpression name="options"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="latestVersionLink"/>
																				<primitiveExpression value="GET"/>
																				<variableReferenceExpression name="controllerLinks"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[{0}{1}/{2}?count=true]]></xsl:attribute>
																				</primitiveExpression>
																				<variableReferenceExpression name="publicApiKey"/>
																				<propertyReferenceExpression name="ControllerResource">
																					<argumentReferenceExpression name="options"/>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="LatestVersionLink">
																					<argumentReferenceExpression name="options"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="AddLinkProperty">
																			<target>
																				<argumentReferenceExpression name="options"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="selfControl"/>
																				<primitiveExpression value="max-age"/>
																				<propertyReferenceExpression name="Duration">
																					<variableReferenceExpression name="cacheItem"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="AddLink">
																	<target>
																		<argumentReferenceExpression name="options"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="firstLink"/>
																		<primitiveExpression value="GET"/>
																		<variableReferenceExpression name="controllerLinks"/>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[{0}{1}?page=0&limit={2}]]></xsl:attribute>
																		</primitiveExpression>
																		<variableReferenceExpression name="publicApiKey"/>
																		<propertyReferenceExpression name="ControllerResource">
																			<argumentReferenceExpression name="options"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="PageSize">
																			<argumentReferenceExpression name="options"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
																<conditionStatement>
																	<condition>
																		<propertyReferenceExpression name="AllowsSchema">
																			<argumentReferenceExpression name="options"/>
																		</propertyReferenceExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="AddLink">
																			<target>
																				<argumentReferenceExpression name="options"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="schemaLink"/>
																				<primitiveExpression value="GET"/>
																				<variableReferenceExpression name="controllerLinks"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[{0}{1}?count=true&{2}={3}]]></xsl:attribute>
																				</primitiveExpression>
																				<variableReferenceExpression name="publicApiKey"/>
																				<propertyReferenceExpression name="ControllerResource">
																					<argumentReferenceExpression name="options"/>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="SchemaKey">
																					<argumentReferenceExpression name="options"/>
																				</propertyReferenceExpression>
																				<variableReferenceExpression name="schema"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="result"/>
															</target>
															<parameters>
																<objectCreateExpression type="JProperty">
																	<parameters>
																		<methodInvokeExpression methodName="ToPathName">
																			<target>
																				<argumentReferenceExpression name="options"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="controllerName"/>
																			</parameters>
																		</methodInvokeExpression>
																		<variableReferenceExpression name="controllerObject"/>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<assignStatement>
											<propertyReferenceExpression name="ControllerName">
												<argumentReferenceExpression name="options"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method RESTfulExecute(DataControllerService, args) -->
						<memberMethod returnType="System.Object" name="RESTfulExecute">
							<attributes public="true"/>
							<parameters>
								<parameter type="DataControllerService" name="service"/>
								<parameter type="JObject" name="args"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="RESTfulResource" name="resource" var="false">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="DataCacheItem" name="cacheItem" var="false">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="payload">
									<init>
										<argumentReferenceExpression name="args"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="result">
									<init>
										<objectCreateExpression type="JObject"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="request">
									<init>
										<propertyReferenceExpression name="Request">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="HttpContext"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="response">
									<init>
										<propertyReferenceExpression name="Response">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="HttpContext"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<tryStatement>
									<statements>
										<assignStatement>
											<variableReferenceExpression name="resource"/>
											<objectCreateExpression type="RESTfulResource"/>
										</assignStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="IsImmutable">
														<variableReferenceExpression name="resource"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="args"/>
													<objectCreateExpression type="JObject"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<propertyReferenceExpression name="OutputContentType">
														<variableReferenceExpression name="resource"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="OutputContentType">
														<variableReferenceExpression name="resource"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="OutputContentType">
														<target>
															<thisReferenceExpression/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="Navigate">
											<target>
												<variableReferenceExpression name="resource"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsImmutable">
													<variableReferenceExpression name="resource"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="cacheItem"/>
													<objectCreateExpression type="DataCacheItem">
														<parameters>
															<propertyReferenceExpression name="Controller">
																<variableReferenceExpression name="resource"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="RawUrl">
																<variableReferenceExpression name="request"/>
															</propertyReferenceExpression>
														</parameters>
													</objectCreateExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="HasValue">
															<variableReferenceExpression name="cacheItem"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="SetMaxAge">
															<target>
																<variableReferenceExpression name="cacheItem"/>
															</target>
														</methodInvokeExpression>
														<methodReturnStatement>
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="cacheItem"/>
															</propertyReferenceExpression>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="ExecuteWithSchema">
													<target>
														<variableReferenceExpression name="resource"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="CustomSchema">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
														<variableReferenceExpression name="payload"/>
														<variableReferenceExpression name="result"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<variableReferenceExpression name="result"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsReport">
													<variableReferenceExpression name="resource"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="args"/>
													<objectCreateExpression type="JObject"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="supportedGetParameters">
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="System.String"/>
													</typeArguments>
													<parameters>
														<propertyReferenceExpression name="SupportedParameters"/>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable name="s"/>
											<target>
												<arrayCreateExpression>
													<createType type="System.String"/>
													<initializers>
														<propertyReferenceExpression name="LinksKey">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="SchemaKey">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="EmbedParam">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
														<primitiveExpression value="x-api-key"/>
														<primitiveExpression value="api_key"/>
													</initializers>
												</arrayCreateExpression>
											</target>
											<statements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="supportedGetParameters"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="ToApiName">
															<target>
																<variableReferenceExpression name="resource"/>
															</target>
															<parameters>
																<variableReferenceExpression name="s"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</foreachStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="supportedGetParameters"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="FilterParam">
													<variableReferenceExpression name="resource"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<propertyReferenceExpression name="Controller">
														<variableReferenceExpression name="resource"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="IsImmutable">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<convertExpression to="Boolean">
																	<methodInvokeExpression methodName="SettingsProperty">
																		<target>
																			<typeReferenceExpression type="ApplicationServicesBase"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="server.rest.schema.enabled"/>
																			<primitiveExpression value="true"/>
																		</parameters>
																	</methodInvokeExpression>
																</convertExpression>
															</condition>
															<trueStatements>
																<methodReturnStatement>
																	<methodInvokeExpression methodName="ToApiEndpoint">
																		<parameters>
																			<variableReferenceExpression name="resource"/>
																		</parameters>
																	</methodInvokeExpression>
																</methodReturnStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="ThrowError">
																	<target>
																		<typeReferenceExpression type="RESTfulResource"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="introspection_error"/>
																		<primitiveExpression value="API introspection is disabled."/>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<methodInvokeExpression methodName="ThrowError">
															<target>
																<typeReferenceExpression type="RESTfulResource"/>
															</target>
															<parameters>
																<primitiveExpression value="invalid_path"/>
																<primitiveExpression value="Specify the name of the controller in the path."/>
															</parameters>
														</methodInvokeExpression>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="filterExpression">
											<init>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<variableReferenceExpression name="request"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<propertyReferenceExpression name="FilterParam">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="filterExpression"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Execute">
													<target>
														<methodInvokeExpression methodName="Initialize">
															<target>
																<methodInvokeExpression methodName="Create">
																	<target>
																		<typeReferenceExpression type="FilterBuilder"/>
																	</target>
																</methodInvokeExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="filterExpression"/>
																<variableReferenceExpression name="resource"/>
															</parameters>
														</methodInvokeExpression>
													</target>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="filter">
											<init>
												<objectCreateExpression type="JObject"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Count">
														<propertyReferenceExpression name="Filter">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<argumentReferenceExpression name="args"/>
													</target>
													<parameters>
														<objectCreateExpression type="JProperty">
															<parameters>
																<primitiveExpression value="filter"/>
																<variableReferenceExpression name="filter"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
												<foreachStatement>
													<variable name="filterField"/>
													<target>
														<propertyReferenceExpression name="Filter">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="filter"/>
															</target>
															<parameters>
																<objectCreateExpression type="JProperty">
																	<parameters>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="filterField"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="filterField"/>
																		</propertyReferenceExpression>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
										<comment>analyze the query string parameters</comment>
										<foreachStatement>
											<variable type="System.String" name="p" var="false"/>
											<target>
												<propertyReferenceExpression name="QueryString">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<variableReferenceExpression name="p"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="XPathNavigator" name="fieldNav" var="false">
															<init>
																<primitiveExpression value="null"/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="TryGetValue">
																	<target>
																		<propertyReferenceExpression name="FieldMap">
																			<variableReferenceExpression name="resource"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="p"/>
																		<directionExpression direction="Out">
																			<variableReferenceExpression name="fieldNav"/>
																		</directionExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="fieldName">
																	<init>
																		<methodInvokeExpression methodName="GetAttribute">
																			<target>
																				<variableReferenceExpression name="fieldNav"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="name"/>
																				<stringEmptyExpression/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="ContainsKey">
																			<target>
																				<variableReferenceExpression name="filter"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="fieldName"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="ThrowError">
																			<target>
																				<typeReferenceExpression type="RESTfulResource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="invalid_path"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[Query parameer '{0}' is already specified as the entity '{1}' in the path.]]></xsl:attribute>
																				</primitiveExpression>
																				<variableReferenceExpression name="p"/>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="filter"/>
																					</target>
																					<indices>
																						<variableReferenceExpression name="fieldName"/>
																					</indices>
																				</arrayIndexerExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<propertyReferenceExpression name="IsCollection">
																						<variableReferenceExpression name="resource"/>
																					</propertyReferenceExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="ThrowError">
																					<target>
																						<typeReferenceExpression type="RESTfulResource"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="invalid_parameter"/>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[Parameter '{0}' is not allowed.]]></xsl:attribute>
																						</primitiveExpression>
																						<variableReferenceExpression name="p"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																			<falseStatements>
																				<conditionStatement>
																					<condition>
																						<propertyReferenceExpression name="IsImmutable">
																							<variableReferenceExpression name="resource"/>
																						</propertyReferenceExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="Add">
																							<target>
																								<variableReferenceExpression name="filter"/>
																							</target>
																							<parameters>
																								<objectCreateExpression type="JProperty">
																									<parameters>
																										<variableReferenceExpression name="fieldName"/>
																										<arrayIndexerExpression>
																											<target>
																												<propertyReferenceExpression name="QueryString">
																													<variableReferenceExpression name="request"/>
																												</propertyReferenceExpression>
																											</target>
																											<indices>
																												<variableReferenceExpression name="p"/>
																											</indices>
																										</arrayIndexerExpression>
																									</parameters>
																								</objectCreateExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</trueStatements>
																					<falseStatements>
																						<methodInvokeExpression methodName="ThrowError">
																							<target>
																								<typeReferenceExpression type="RESTfulResource"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="invalid_parameter"/>
																								<primitiveExpression>
																									<xsl:attribute name="value"><![CDATA[Parameter '{0}' is not allowed with the {1} method.]]></xsl:attribute>
																								</primitiveExpression>
																								<variableReferenceExpression name="p"/>
																								<propertyReferenceExpression name="HttpMethod">
																									<variableReferenceExpression name="request"/>
																								</propertyReferenceExpression>
																							</parameters>
																						</methodInvokeExpression>
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
																		<binaryOperatorExpression operator="ValueInequality">
																			<variableReferenceExpression name="p"/>
																			<propertyReferenceExpression name="FilterParam">
																				<variableReferenceExpression name="resource"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<argumentReferenceExpression name="args"/>
																				</target>
																				<indices>
																					<variableReferenceExpression name="p"/>
																				</indices>
																			</arrayIndexerExpression>
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="QueryString">
																						<variableReferenceExpression name="request"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<variableReferenceExpression name="p"/>
																				</indices>
																			</arrayIndexerExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Count">
														<variableReferenceExpression name="filter"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="args"/>
														</target>
														<indices>
															<primitiveExpression value="filter"/>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="filter"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<binaryOperatorExpression operator="BooleanOr">
														<binaryOperatorExpression operator="BooleanAnd">
															<propertyReferenceExpression name="IsCollection">
																<variableReferenceExpression name="resource"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="IsImmutable">
																<variableReferenceExpression name="resource"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
														<propertyReferenceExpression name="IsReport">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable name="paramName"/>
													<target>
														<arrayCreateExpression>
															<createType type="System.String"/>
															<initializers>
																<primitiveExpression value="limit"/>
																<primitiveExpression value="sort"/>
																<primitiveExpression value="count"/>
																<primitiveExpression value="filterParam"/>
															</initializers>
														</arrayCreateExpression>
													</target>
													<statements>
														<variableDeclarationStatement name="name">
															<init>
																<methodInvokeExpression methodName="ToApiName">
																	<target>
																		<variableReferenceExpression name="resource"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="paramName"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="QueryString">
																				<variableReferenceExpression name="request"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<variableReferenceExpression name="name"/>
																		</indices>
																	</arrayIndexerExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="ThrowError">
																	<target>
																		<typeReferenceExpression type="RESTfulResource"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="invalid_parameter"/>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[Parameter '{0}' is not allowed.]]></xsl:attribute>
																		</primitiveExpression>
																		<variableReferenceExpression name="name"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="IsCollection">
														<variableReferenceExpression name="resource"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="SetPropertyValue">
													<target>
														<variableReferenceExpression name="resource"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="args"/>
														<primitiveExpression value="limit"/>
														<primitiveExpression value="1"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<propertyReferenceExpression name="Field">
														<variableReferenceExpression name="resource"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="args"/>
																</target>
																<indices>
																	<primitiveExpression value="fields"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ThrowError">
															<target>
																<typeReferenceExpression type="RESTfulResource"/>
															</target>
															<parameters>
																<primitiveExpression value="invalid_parameter"/>
																<primitiveExpression value="Parameter 'fields' is not allowed."/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement name="pathField">
													<init>
														<methodInvokeExpression methodName="ToApiFieldName">
															<target>
																<variableReferenceExpression name="resource"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Field">
																	<variableReferenceExpression name="resource"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="ContainsKey">
																<target>
																	<propertyReferenceExpression name="FieldMap">
																		<variableReferenceExpression name="resource"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<variableReferenceExpression name="pathField"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ThrowError">
															<target>
																<typeReferenceExpression type="RESTfulResource"/>
															</target>
															<parameters>
																<primitiveExpression value="400"/>
																<primitiveExpression value="true"/>
																<primitiveExpression value="invalid_path"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[Unexpected field '{0}' is specified in the path.]]></xsl:attribute>
																</primitiveExpression>
																<variableReferenceExpression name="pathField"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="args"/>
																</target>
																<indices>
																	<primitiveExpression value="fields"/>
																</indices>
															</arrayIndexerExpression>
															<variableReferenceExpression name="pathField"/>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<comment>calculate the page size and index</comment>
										<variableDeclarationStatement name="limit">
											<init>
												<methodInvokeExpression methodName="GetProperty">
													<target>
														<variableReferenceExpression name="resource"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="args"/>
														<primitiveExpression value="limit"/>
														<primitiveExpression value="Int32"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="pageSize">
											<init>
												<convertExpression to="Int32">
													<variableReferenceExpression name="limit"/>
												</convertExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="limit"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="LessThanOrEqual">
														<variableReferenceExpression name="pageSize"/>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ThrowError">
													<target>
														<typeReferenceExpression type="RESTfulResource"/>
													</target>
													<parameters>
														<primitiveExpression value="invalid_argument"/>
														<primitiveExpression value="Parameter 'limit' must be greater than zero."/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="limit"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<variableReferenceExpression name="pageSize"/>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="pageSize"/>
													<propertyReferenceExpression name="Limit">
														<variableReferenceExpression name="resource"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="page">
											<init>
												<methodInvokeExpression methodName="GetProperty">
													<target>
														<variableReferenceExpression name="resource"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="args"/>
														<primitiveExpression value="page"/>
														<primitiveExpression value="Int32"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="pageIndex">
											<init>
												<convertExpression to="Int32">
													<variableReferenceExpression name="page"/>
												</convertExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<variableReferenceExpression name="pageSize"/>
													<propertyReferenceExpression name="MaxLimit"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="pageSize"/>
													<propertyReferenceExpression name="MaxLimit"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<comment>process the field filter</comment>
										<variableDeclarationStatement name="embed">
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="System.String"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="fieldFilter">
											<init>
												<methodInvokeExpression methodName="Execute">
													<target>
														<objectCreateExpression type="NameSetParser">
															<parameters>
																<primitiveExpression value="fields"/>
																<argumentReferenceExpression name="args"/>
															</parameters>
														</objectCreateExpression>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="fieldFilter"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="enumeratedFilterFields">
													<init>
														<objectCreateExpression type="List">
															<typeArguments>
																<typeReference type="System.String"/>
															</typeArguments>
														</objectCreateExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="i">
													<init>
														<primitiveExpression value="0"/>
													</init>
												</variableDeclarationStatement>
												<whileStatement>
													<test>
														<binaryOperatorExpression operator="LessThan">
															<variableReferenceExpression name="i"/>
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="fieldFilter"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</test>
													<statements>
														<variableDeclarationStatement name="fieldName">
															<init>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="fieldFilter"/>
																	</target>
																	<indices>
																		<variableReferenceExpression name="i"/>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="periodIndex">
															<init>
																<methodInvokeExpression methodName="LastIndexOf">
																	<target>
																		<variableReferenceExpression name="fieldName"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="." convertTo="Char"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="GreaterThanOrEqual">
																	<variableReferenceExpression name="periodIndex"/>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="parentFieldName">
																	<init>
																		<methodInvokeExpression methodName="Substring">
																			<target>
																				<variableReferenceExpression name="fieldName"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="0"/>
																				<variableReferenceExpression name="periodIndex"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="Contains">
																				<target>
																					<variableReferenceExpression name="embed"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="parentFieldName"/>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<variableReferenceExpression name="embed"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="parentFieldName"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="embed"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="fieldName"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="RemoveAt">
																	<target>
																		<variableReferenceExpression name="fieldFilter"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="i"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="OutputStyle">
																				<variableReferenceExpression name="resource"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="snake"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="fieldName"/>
																			<methodInvokeExpression methodName="Replace">
																				<target>
																					<variableReferenceExpression name="fieldName"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="_"/>
																					<stringEmptyExpression/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="Contains">
																			<target>
																				<variableReferenceExpression name="enumeratedFilterFields"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="fieldName"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="ThrowError">
																			<target>
																				<typeReferenceExpression type="RESTfulResource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="invalid_filter"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[Duplicate field '{0}' in the filter.]]></xsl:attribute>
																				</primitiveExpression>
																				<variableReferenceExpression name="fieldName"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<methodInvokeExpression methodName="Contains">
																						<target>
																							<variableReferenceExpression name="fieldName"/>
																						</target>
																						<parameters>
																							<primitiveExpression value="."/>
																						</parameters>
																					</methodInvokeExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="fieldFilter"/>
																						</target>
																						<indices>
																							<variableReferenceExpression name="i"/>
																						</indices>
																					</arrayIndexerExpression>
																					<variableReferenceExpression name="fieldName"/>
																				</assignStatement>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="enumeratedFilterFields"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="fieldName"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
																<assignStatement>
																	<variableReferenceExpression name="i"/>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="i"/>
																		<primitiveExpression value="1"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
													</statements>
												</whileStatement>
											</trueStatements>
										</conditionStatement>
										<comment>prepare the basic controller information</comment>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsImmutable">
													<variableReferenceExpression name="resource"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable name="propName"/>
													<target>
														<argumentReferenceExpression name="args"/>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="Contains">
																		<target>
																			<variableReferenceExpression name="supportedGetParameters"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Key">
																				<variableReferenceExpression name="propName"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="ThrowError">
																	<target>
																		<typeReferenceExpression type="RESTfulResource"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="invalid_parameter"/>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[Parameter '{0}' is not supported.]]></xsl:attribute>
																		</primitiveExpression>
																		<propertyReferenceExpression name="Key">
																			<variableReferenceExpression name="propName"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="args"/>
												</target>
												<indices>
													<primitiveExpression value="controller"/>
												</indices>
											</arrayIndexerExpression>
											<propertyReferenceExpression name="Controller">
												<variableReferenceExpression name="resource"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="args"/>
												</target>
												<indices>
													<primitiveExpression value="view"/>
												</indices>
											</arrayIndexerExpression>
											<propertyReferenceExpression name="View">
												<variableReferenceExpression name="resource"/>
											</propertyReferenceExpression>
										</assignStatement>
										<comment>prepare the GET request</comment>
										<variableDeclarationStatement name="r">
											<init>
												<objectCreateExpression type="PageRequest"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="Controller">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="ControllerName">
												<variableReferenceExpression name="resource"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="View">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="PathView">
												<variableReferenceExpression name="resource"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="RequiresMetaData">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<primitiveExpression value="true"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="PageIndex">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="pageIndex"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="PageSize">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="pageSize"/>
										</assignStatement>

										<variableDeclarationStatement name="totalCount">
											<init>
												<methodInvokeExpression methodName="GetProperty">
													<target>
														<variableReferenceExpression name="resource"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="args"/>
														<primitiveExpression value="count"/>
														<primitiveExpression value="Boolean"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="page"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="BooleanOr">
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="totalCount"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="BooleanOr">
															<binaryOperatorExpression operator="ValueInequality">
																<convertExpression to="Boolean">
																	<variableReferenceExpression name="totalCount"/>
																</convertExpression>
																<primitiveExpression value="false"/>
															</binaryOperatorExpression>"
															<binaryOperatorExpression operator="BooleanAnd">
																<unaryOperatorExpression operator="Not">
																	<propertyReferenceExpression name="IsRoot">
																		<variableReferenceExpression name="resource"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
																<propertyReferenceExpression name="IsCollection">
																	<variableReferenceExpression name="resource"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>"
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="RequiresRowCount">
														<variableReferenceExpression name="r"/>
													</propertyReferenceExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<propertyReferenceExpression name="MetadataFilter">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<arrayCreateExpression>
												<createType type="System.String"/>
												<initializers>
													<primitiveExpression value="fields"/>
												</initializers>
											</arrayCreateExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="fieldFilter"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<forStatement>
													<variable name="i">
														<init>
															<primitiveExpression value="0"/>
														</init>
													</variable>
													<test>
														<binaryOperatorExpression operator="LessThan">
															<variableReferenceExpression name="i"/>
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="fieldFilter"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</test>
													<increment>
														<variableReferenceExpression name="i"/>
													</increment>
													<statements>
														<variableDeclarationStatement type="XPathNavigator" name="fieldNav" var="false">
															<init>
																<primitiveExpression value="null"/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="TryGetValue">
																	<target>
																		<propertyReferenceExpression name="FieldMap">
																			<variableReferenceExpression name="resource"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="fieldFilter"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="i"/>
																			</indices>
																		</arrayIndexerExpression>
																		<directionExpression direction="Out">
																			<variableReferenceExpression name="fieldNav"/>
																		</directionExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="fieldFilter"/>
																		</target>
																		<indices>
																			<variableReferenceExpression name="i"/>
																		</indices>
																	</arrayIndexerExpression>
																	<methodInvokeExpression methodName="GetAttribute">
																		<target>
																			<variableReferenceExpression name="fieldNav"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="name"/>
																			<stringEmptyExpression/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</statements>
												</forStatement>
												<assignStatement>
													<propertyReferenceExpression name="FieldFilter">
														<variableReferenceExpression name="r"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="ToArray">
														<target>
															<variableReferenceExpression name="fieldFilter"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="fieldFilter"/>
															</propertyReferenceExpression>
															<primitiveExpression value="0"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="RequiresRowCount">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="totalCount"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="RequiresRowCount">
														<variableReferenceExpression name="r"/>
													</propertyReferenceExpression>
													<convertExpression to="Boolean">
														<variableReferenceExpression name="totalCount"/>
													</convertExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="pageSize"/>
															<primitiveExpression value="0"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="RequiresRowCount">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
										<variableDeclarationStatement name="aggregates">
											<init>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="args"/>
													</target>
													<indices>
														<primitiveExpression value="aggregates"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="aggregates"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="DoesNotRequireAggregates">
														<variableReferenceExpression name="r"/>
													</propertyReferenceExpression>
													<unaryOperatorExpression operator="Not">
														<convertExpression to="Boolean">
															<variableReferenceExpression name="aggregates"/>
														</convertExpression>
													</unaryOperatorExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<propertyReferenceExpression name="DoesNotRequireAggregates">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="RequiresRowCount">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<propertyReferenceExpression name="DoesNotRequireAggregates">
														<variableReferenceExpression name="r"/>
													</propertyReferenceExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
										<assignStatement>
											<propertyReferenceExpression name="SortExpression">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToSortExpression">
												<parameters>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="args"/>
														</target>
														<indices>
															<primitiveExpression value="sort"/>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="resource"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Filter">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToFilter">
												<target>
													<variableReferenceExpression name="resource"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="args"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<comment>*** create CSV output ***</comment>
										<variableDeclarationStatement name="viewPage">
											<init>
												<methodInvokeExpression methodName="Execute">
													<target>
														<variableReferenceExpression name="resource"/>
													</target>
													<parameters>
														<variableReferenceExpression name="r"/>
														<variableReferenceExpression name="payload"/>
														<variableReferenceExpression name="result"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="viewPage"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="IdentityInequality">
															<propertyReferenceExpression name="AcceptTypes">
																<variableReferenceExpression name="request"/>
															</propertyReferenceExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="GreaterThanOrEqual">
															<methodInvokeExpression methodName="IndexOf">
																<target>
																	<typeReferenceExpression type="Array"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="AcceptTypes">
																		<variableReferenceExpression name="request"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="text/csv"/>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression value="0"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="controller">
													<init>
														<castExpression targetType="DataControllerBase">
															<methodInvokeExpression methodName="CreateDataController">
																<target>
																	<typeReferenceExpression type="ControllerFactory"/>
																</target>
															</methodInvokeExpression>
														</castExpression>
													</init>
												</variableDeclarationStatement>
												<assignStatement>
													<propertyReferenceExpression name="ContentType">
														<variableReferenceExpression name="response"/>
													</propertyReferenceExpression>
													<primitiveExpression value="text/csv; charset=utf-8"/>
												</assignStatement>
												<variableDeclarationStatement name="byteOrder">
													<init>
														<methodInvokeExpression methodName="GetPreamble">
															<target>
																<propertyReferenceExpression name="UTF8">
																	<typeReferenceExpression type="Encoding"/>
																</propertyReferenceExpression>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="Write">
													<target>
														<propertyReferenceExpression name="OutputStream">
															<variableReferenceExpression name="response"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="byteOrder"/>
														<primitiveExpression value="0"/>
														<propertyReferenceExpression name="Length">
															<variableReferenceExpression name="byteOrder"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<usingStatement>
													<variable name="sw">
														<init>
															<objectCreateExpression type="StreamWriter">
																<parameters>
																	<propertyReferenceExpression name="OutputStream">
																		<variableReferenceExpression name="response"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</init>
													</variable>
													<statements>
														<methodInvokeExpression methodName="ExportDataAsCsv">
															<target>
																<variableReferenceExpression name="controller"/>
															</target>
															<parameters>
																<variableReferenceExpression name="viewPage"/>
																<objectCreateExpression type="DataTableReader">
																	<parameters>
																		<methodInvokeExpression methodName="ToDataTable">
																			<target>
																				<variableReferenceExpression name="viewPage"/>
																			</target>
																		</methodInvokeExpression>
																	</parameters>
																</objectCreateExpression>
																<variableReferenceExpression name="sw"/>
																<primitiveExpression value="all"/>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="Flush">
															<target>
																<variableReferenceExpression name="sw"/>
															</target>
														</methodInvokeExpression>
													</statements>
												</usingStatement>
												<methodReturnStatement>
													<primitiveExpression value="null"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<comment>*** create a report ***</comment>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="viewPage"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="IsReport">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<propertyReferenceExpression name="RequiresSchema">
																		<variableReferenceExpression name="resource"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="result"/>
																	<primitiveExpression value="null"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<methodInvokeExpression methodName="CreateOwnerCollectionLinks">
															<target>
																<variableReferenceExpression name="resource"/>
															</target>
															<parameters>
																<variableReferenceExpression name="result"/>
															</parameters>
														</methodInvokeExpression>
													</falseStatements>
												</conditionStatement>
												<methodReturnStatement>
													<variableReferenceExpression name="result"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<comment>*** produce the resource data ***</comment>
										<variableDeclarationStatement name="fieldList">
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="DataField"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="ignoreList">
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="DataField"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="fieldIndexMap">
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="System.Int32"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="pkIndexMap">
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="System.Int32"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="fieldFilter"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable name="fieldName"/>
													<target>
														<variableReferenceExpression name="fieldFilter"/>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNotNullOrWhiteSpace">
																	<variableReferenceExpression name="fieldName"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="field">
																	<init>
																		<methodInvokeExpression methodName="FindField">
																			<target>
																				<variableReferenceExpression name="viewPage"/>
																			</target>
																			<parameters>
																				<convertExpression to="String">
																					<variableReferenceExpression name="fieldName"/>
																				</convertExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityEquality">
																			<variableReferenceExpression name="field"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="ThrowError">
																			<target>
																				<typeReferenceExpression type="RESTfulResource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="400"/>
																				<primitiveExpression value="true"/>
																				<primitiveExpression value="invalid_argument"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[Unexpected field '{0}' is specified in the 'fields' parameter.]]></xsl:attribute>
																				</primitiveExpression>
																				<variableReferenceExpression name="fieldName"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="fieldList"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="field"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="fieldIndexMap"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="IndexOfField">
																			<target>
																				<variableReferenceExpression name="viewPage"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
												<comment>add any missing primary key fields to the output</comment>
												<foreachStatement>
													<variable name="pkField"/>
													<target>
														<propertyReferenceExpression name="PK">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="Contains">
																		<target>
																			<variableReferenceExpression name="fieldFilter"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Name">
																				<variableReferenceExpression name="pkField"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="field">
																	<init>
																		<methodInvokeExpression methodName="FindField">
																			<target>
																				<variableReferenceExpression name="viewPage"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="pkField"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="fieldList"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="field"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="fieldIndexMap"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="IndexOfField">
																			<target>
																				<variableReferenceExpression name="viewPage"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="ignoreList"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="field"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
											</trueStatements>
											<falseStatements>
												<variableDeclarationStatement name="enumeratedFields">
													<init>
														<objectCreateExpression type="List">
															<typeArguments>
																<typeReference type="DataField"/>
															</typeArguments>
														</objectCreateExpression>
													</init>
												</variableDeclarationStatement>
												<comment>enumerate primary keys</comment>
												<foreachStatement>
													<variable name="field"/>
													<target>
														<propertyReferenceExpression name="Fields">
															<variableReferenceExpression name="viewPage"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<propertyReferenceExpression name="IsPrimaryKey">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="fieldList"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="field"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="fieldIndexMap"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="IndexOfField">
																			<target>
																				<variableReferenceExpression name="viewPage"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="enumeratedFields"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="field"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
												<comment>enumerate the data fields with alliases following the original</comment>
												<foreachStatement>
													<variable name="field"/>
													<target>
														<propertyReferenceExpression name="Fields">
															<variableReferenceExpression name="viewPage"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="Contains">
																		<target>
																			<variableReferenceExpression name="enumeratedFields"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="field"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="fieldList"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="field"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="fieldIndexMap"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="IndexOfField">
																			<target>
																				<variableReferenceExpression name="viewPage"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<propertyReferenceExpression name="AliasName">
																				<variableReferenceExpression name="field"/>
																			</propertyReferenceExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement name="aliasField">
																			<init>
																				<methodInvokeExpression methodName="FindField">
																					<target>
																						<variableReferenceExpression name="viewPage"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="AliasName">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityInequality">
																					<variableReferenceExpression name="aliasField"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="fieldList"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="aliasField"/>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="fieldIndexMap"/>
																					</target>
																					<parameters>
																						<methodInvokeExpression methodName="IndexOfField">
																							<target>
																								<variableReferenceExpression name="viewPage"/>
																							</target>
																							<parameters>
																								<propertyReferenceExpression name="Name">
																									<variableReferenceExpression name="aliasField"/>
																								</propertyReferenceExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="enumeratedFields"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="aliasField"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
											</falseStatements>
										</conditionStatement>
										<foreachStatement>
											<variable name="fvo"/>
											<target>
												<propertyReferenceExpression name="PK">
													<variableReferenceExpression name="resource"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<forStatement>
													<variable name="fieldIndex">
														<init>
															<primitiveExpression value="0"/>
														</init>
													</variable>
													<test>
														<binaryOperatorExpression operator="LessThan">
															<variableReferenceExpression name="fieldIndex"/>
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="fieldList"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</test>
													<increment>
														<variableReferenceExpression name="fieldIndex"/>
													</increment>
													<statements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Name">
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="fieldList"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="fieldIndex"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="pkIndexMap"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="fieldIndex"/>
																	</parameters>
																</methodInvokeExpression>
																<breakStatement/>
															</trueStatements>
														</conditionStatement>
													</statements>
												</forStatement>
											</statements>
										</foreachStatement>
										<comment>convert the page to the result</comment>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="GreaterThanOrEqual">
														<propertyReferenceExpression name="TotalRowCount">
															<variableReferenceExpression name="viewPage"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
													<propertyReferenceExpression name="IsCollection">
														<variableReferenceExpression name="resource"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="result"/>
													</target>
													<parameters>
														<objectCreateExpression type="JProperty">
															<parameters>
																<primitiveExpression value="count"/>
																<propertyReferenceExpression name="TotalRowCount">
																	<variableReferenceExpression name="viewPage"/>
																</propertyReferenceExpression>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="args"/>
																</target>
																<indices>
																	<primitiveExpression value="page"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="result"/>
															</target>
															<parameters>
																<objectCreateExpression type="JProperty">
																	<parameters>
																		<primitiveExpression value="page"/>
																		<convertExpression to="Int32">
																			<arrayIndexerExpression>
																				<target>
																					<argumentReferenceExpression name="args"/>
																				</target>
																				<indices>
																					<primitiveExpression value="page"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Count">
														<variableReferenceExpression name="fieldList"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<comment>*** return the blob ***</comment>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="BooleanAnd">
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<propertyReferenceExpression name="Field">
																		<variableReferenceExpression name="resource"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
																<binaryOperatorExpression operator="GreaterThan">
																	<propertyReferenceExpression name="Count">
																		<variableReferenceExpression name="fieldList"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="Count">
																		<propertyReferenceExpression name="PK">
																			<variableReferenceExpression name="resource"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanAnd">
																<propertyReferenceExpression name="OnDemand">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="fieldList"/>
																		</target>
																		<indices>
																			<primitiveExpression value="0"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<propertyReferenceExpression name="OnDemandHandler">
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="fieldList"/>
																			</target>
																			<indices>
																				<primitiveExpression value="0"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<propertyReferenceExpression name="IsImmutable">
																	<variableReferenceExpression name="resource"/>
																</propertyReferenceExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<propertyReferenceExpression name="IsMatch">
																			<variableReferenceExpression name="cacheItem"/>
																		</propertyReferenceExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="SetMaxAge">
																			<target>
																				<variableReferenceExpression name="cacheItem"/>
																			</target>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="Send">
																	<target>
																		<typeReferenceExpression type="Blob"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="OnDemandHandler">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="fieldList"/>
																				</target>
																				<indices>
																					<primitiveExpression value="0"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Id">
																			<variableReferenceExpression name="resource"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="StatusCode">
																				<variableReferenceExpression name="response"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="200"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="ClearHeaders"/>
																		<methodInvokeExpression methodName="End">
																			<target>
																				<variableReferenceExpression name="response"/>
																			</target>
																		</methodInvokeExpression>
																	</trueStatements>
																	<falseStatements>
																		<methodInvokeExpression methodName="SetMaxAge">
																			<target>
																				<propertyReferenceExpression name="Cache">
																					<variableReferenceExpression name="response"/>
																				</propertyReferenceExpression>
																			</target>
																			<parameters>
																				<methodInvokeExpression methodName="FromSeconds">
																					<target>
																						<typeReferenceExpression type="TimeSpan"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="0"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="ThrowError">
																			<target>
																				<typeReferenceExpression type="RESTfulResource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="404"/>
																				<primitiveExpression value="invalid_path"/>
																				<primitiveExpression value="The blob value is not available."/>
																			</parameters>
																		</methodInvokeExpression>
																	</falseStatements>

																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
												<comment>*** continue to enumerate the resource objects ***</comment>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanOr">
															<binaryOperatorExpression operator="IdentityEquality">
																<variableReferenceExpression name="limit"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="GreaterThan">
																<convertExpression to="Int32">
																	<arrayIndexerExpression>
																		<target>
																			<argumentReferenceExpression name="args"/>
																		</target>
																		<indices>
																			<primitiveExpression value="limit"/>
																		</indices>
																	</arrayIndexerExpression>
																</convertExpression>
																<primitiveExpression value="0"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="objects">
															<init>
																<objectCreateExpression type="JArray"/>
															</init>
														</variableDeclarationStatement>
														<foreachStatement>
															<variable name="row"/>
															<target>
																<propertyReferenceExpression name="Rows">
																	<variableReferenceExpression name="viewPage"/>
																</propertyReferenceExpression>
															</target>
															<statements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="objects"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="RowToObject">
																			<target>
																				<variableReferenceExpression name="resource"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="fieldList"/>
																				<variableReferenceExpression name="ignoreList"/>
																				<variableReferenceExpression name="row"/>
																				<variableReferenceExpression name="pkIndexMap"/>
																				<variableReferenceExpression name="fieldIndexMap"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</statements>
														</foreachStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="ValueEquality">
																		<propertyReferenceExpression name="PageSize">
																			<variableReferenceExpression name="viewPage"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="1"/>
																	</binaryOperatorExpression>
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<propertyReferenceExpression name="Id">
																			<variableReferenceExpression name="resource"/>
																		</propertyReferenceExpression>
																	</unaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="GreaterThan">
																			<propertyReferenceExpression name="Count">
																				<variableReferenceExpression name="objects"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="0"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<foreachStatement>
																			<variable name="objProp"/>
																			<target>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="objects"/>
																					</target>
																					<indices>
																						<primitiveExpression value="0"/>
																					</indices>
																				</arrayIndexerExpression>
																			</target>
																			<statements>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="result"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="objProp"/>
																					</parameters>
																				</methodInvokeExpression>
																			</statements>
																		</foreachStatement>
																	</trueStatements>
																	<falseStatements>
																		<methodInvokeExpression methodName="ThrowError">
																			<target>
																				<typeReferenceExpression type="RESTfulResource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="404"/>
																				<primitiveExpression value="invalid_path"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[The entity at {0} does not exist.]]></xsl:attribute>
																				</primitiveExpression>
																				<methodInvokeExpression methodName="ReplaceRawUrlWith">
																					<target>
																						<variableReferenceExpression name="resource"/>
																					</target>
																					<parameters>
																						<methodInvokeExpression methodName="PrimaryKeyToPath">
																							<target>
																								<variableReferenceExpression name="resource"/>
																							</target>
																						</methodInvokeExpression>
																						<primitiveExpression value="false"/>
																						<methodInvokeExpression methodName="PrimaryKeyToPath">
																							<target>
																								<variableReferenceExpression name="resource"/>
																							</target>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="Contains">
																			<target>
																				<propertyReferenceExpression name="OutputContentType">
																					<variableReferenceExpression name="resource"/>
																				</propertyReferenceExpression>
																			</target>
																			<parameters>
																				<primitiveExpression value="xml"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<variableReferenceExpression name="result"/>
																			</target>
																			<parameters>
																				<objectCreateExpression type="JProperty">
																					<parameters>
																						<propertyReferenceExpression name="CollectionKey">
																							<variableReferenceExpression name="resource"/>
																						</propertyReferenceExpression>
																						<objectCreateExpression type="JObject">
																							<parameters>
																								<objectCreateExpression type="JProperty">
																									<parameters>
																										<propertyReferenceExpression name="XmlItem">
																											<variableReferenceExpression name="resource"/>
																										</propertyReferenceExpression>
																										<variableReferenceExpression name="objects"/>
																									</parameters>
																								</objectCreateExpression>
																							</parameters>
																						</objectCreateExpression>
																					</parameters>
																				</objectCreateExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																	<falseStatements>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<variableReferenceExpression name="result"/>
																			</target>
																			<parameters>
																				<objectCreateExpression type="JProperty">
																					<parameters>
																						<propertyReferenceExpression name="CollectionKey">
																							<variableReferenceExpression name="resource"/>
																						</propertyReferenceExpression>
																						<variableReferenceExpression name="objects"/>
																					</parameters>
																				</objectCreateExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
												<comment>include the "_schema" key</comment>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<propertyReferenceExpression name="RequiresSchema">
																<variableReferenceExpression name="resource"/>
															</propertyReferenceExpression>
															<unaryOperatorExpression operator="Not">
																<propertyReferenceExpression name="RequiresData">
																	<variableReferenceExpression name="resource"/>
																</propertyReferenceExpression>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="schemaTarget">
															<init>
																<variableReferenceExpression name="result"/>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="collection">
															<init>
																<castExpression targetType="JArray">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="result"/>
																		</target>
																		<indices>
																			<propertyReferenceExpression name="CollectionKey">
																				<variableReferenceExpression name="resource"/>
																			</propertyReferenceExpression>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="collection"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="GreaterThan">
																			<propertyReferenceExpression name="Count">
																				<variableReferenceExpression name="collection"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="0"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="schemaTarget"/>
																			<castExpression targetType="JObject">
																				<propertyReferenceExpression name="First">
																					<variableReferenceExpression name="collection"/>
																				</propertyReferenceExpression>
																			</castExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<variableReferenceExpression name="schemaTarget"/>
																			<primitiveExpression value="null"/>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="schemaTarget"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="propsToRemove">
																	<init>
																		<objectCreateExpression type="List">
																			<typeArguments>
																				<typeReference type="System.String"/>
																			</typeArguments>
																		</objectCreateExpression>
																	</init>
																</variableDeclarationStatement>
																<foreachStatement>
																	<variable name="propName"/>
																	<target>
																		<methodInvokeExpression methodName="Properties">
																			<target>
																				<variableReferenceExpression name="schemaTarget"/>
																			</target>
																		</methodInvokeExpression>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanAnd">
																					<binaryOperatorExpression operator="ValueInequality">
																						<propertyReferenceExpression name="Name">
																							<variableReferenceExpression name="propName"/>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="SchemaKey">
																							<variableReferenceExpression name="resource"/>
																						</propertyReferenceExpression>
																					</binaryOperatorExpression>
																					<binaryOperatorExpression operator="ValueInequality">
																						<propertyReferenceExpression name="Name">
																							<variableReferenceExpression name="propName"/>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="LinksKey">
																							<variableReferenceExpression name="resource"/>
																						</propertyReferenceExpression>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="propsToRemove"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="Name">
																							<variableReferenceExpression name="propName"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
																<foreachStatement>
																	<variable name="propName"/>
																	<target>
																		<variableReferenceExpression name="propsToRemove"/>
																	</target>
																	<statements>
																		<methodInvokeExpression methodName="Remove">
																			<target>
																				<variableReferenceExpression name="schemaTarget"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="propName"/>
																			</parameters>
																		</methodInvokeExpression>
																	</statements>
																</foreachStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="collection"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="result"/>
																				</target>
																				<indices>
																					<propertyReferenceExpression name="CollectionKey">
																						<variableReferenceExpression name="resource"/>
																					</propertyReferenceExpression>
																				</indices>
																			</arrayIndexerExpression>
																			<objectCreateExpression type="JArray">
																				<parameters>
																					<variableReferenceExpression name="schemaTarget"/>
																				</parameters>
																			</objectCreateExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
												<comment>add "aggregate" to the result</comment>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<propertyReferenceExpression name="Aggregates">
																<variableReferenceExpression name="viewPage"/>
															</propertyReferenceExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="Hypermedia">
																<variableReferenceExpression name="resource"/>
															</propertyReferenceExpression>
															<primitiveExpression value="false"/>
														</assignStatement>
														<variableDeclarationStatement name="aggregateObj">
															<init>
																<methodInvokeExpression methodName="RowToObject">
																	<target>
																		<variableReferenceExpression name="resource"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="fieldList"/>
																		<variableReferenceExpression name="ignoreList"/>
																		<propertyReferenceExpression name="Aggregates">
																			<variableReferenceExpression name="viewPage"/>
																		</propertyReferenceExpression>
																		<variableReferenceExpression name="pkIndexMap"/>
																		<variableReferenceExpression name="fieldIndexMap"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="result"/>
															</target>
															<parameters>
																<objectCreateExpression type="JProperty">
																	<parameters>
																		<primitiveExpression value="aggregates"/>
																		<variableReferenceExpression name="aggregateObj"/>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<unaryOperatorExpression operator="Not">
														<propertyReferenceExpression name="DoesNotRequireAggregates">
															<variableReferenceExpression name="r"/>
														</propertyReferenceExpression>
													</unaryOperatorExpression>
													<binaryOperatorExpression operator="IdentityEquality">
														<propertyReferenceExpression name="Aggregates">
															<variableReferenceExpression name="viewPage"/>
														</propertyReferenceExpression>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="result"/>
													</target>
													<parameters>
														<objectCreateExpression type="JProperty">
															<parameters>
																<primitiveExpression value="aggregates"/>
																<primitiveExpression value="null"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<propertyReferenceExpression name="Hypermedia">
														<variableReferenceExpression name="resource"/>
													</propertyReferenceExpression>
													<unaryOperatorExpression operator="IsNullOrEmpty">
														<propertyReferenceExpression name="PathKey">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="links">
													<init>
														<methodInvokeExpression methodName="CreateLinks">
															<target>
																<variableReferenceExpression name="resource"/>
															</target>
															<parameters>
																<variableReferenceExpression name="result"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<comment>build the pager parameters (limit, fields, filter, sort)</comment>
												<variableDeclarationStatement name="pagerLimit">
													<init>
														<convertExpression to="Int32">
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="args"/>
																</target>
																<indices>
																	<primitiveExpression value="limit"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="pagerLimit"/>
															<primitiveExpression value="0"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="pagerLimit"/>
															<propertyReferenceExpression name="PageSize">
																<variableReferenceExpression name="resource"/>
															</propertyReferenceExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement name="pagerPage">
													<init>
														<convertExpression to="Int32">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="args"/>
																</target>
																<indices>
																	<primitiveExpression value="page"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="pagerLast">
													<init>
														<methodInvokeExpression methodName="Ceiling">
															<target>
																<typeReferenceExpression type="Math"/>
															</target>
															<parameters>
																<binaryOperatorExpression operator="Subtract">
																	<binaryOperatorExpression operator="Divide">
																		<propertyReferenceExpression name="TotalRowCount">
																			<variableReferenceExpression name="viewPage"/>
																		</propertyReferenceExpression>
																		<convertExpression to="Double">
																			<variableReferenceExpression name="pagerLimit"/>
																		</convertExpression>
																	</binaryOperatorExpression>
																	<primitiveExpression value="1"/>
																</binaryOperatorExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="args"/>
																</target>
																<indices>
																	<primitiveExpression value="page"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="AddLink">
															<target>
																<variableReferenceExpression name="resource"/>
															</target>
															<parameters>
																<primitiveExpression value="selfLink"/>
																<primitiveExpression value="GET"/>
																<variableReferenceExpression name="links"/>
																<propertyReferenceExpression name="RawUrl">
																	<variableReferenceExpression name="resource"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="AddLink">
															<target>
																<variableReferenceExpression name="resource"/>
															</target>
															<parameters>
																<primitiveExpression value="firstLink"/>
																<primitiveExpression value="GET"/>
																<variableReferenceExpression name="links"/>
																<methodInvokeExpression methodName="ExtendRawUrlWith">
																	<target>
																		<variableReferenceExpression name="resource"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="true"/>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[?page=0&limit={0}]]></xsl:attribute>
																		</primitiveExpression>
																		<propertyReferenceExpression name="PageSize">
																			<variableReferenceExpression name="resource"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<foreachStatement>
															<variable name="viewId"/>
															<target>
																<methodInvokeExpression methodName="EnumerateViews">
																	<target>
																		<variableReferenceExpression name="resource"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="collection"/>
																		<propertyReferenceExpression name="View">
																			<variableReferenceExpression name="resource"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</target>
															<statements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<propertyReferenceExpression name="View">
																				<variableReferenceExpression name="resource"/>
																			</propertyReferenceExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement name="viewName">
																			<init>
																				<variableReferenceExpression name="viewId"/>
																			</init>
																		</variableDeclarationStatement>
																		<variableDeclarationStatement name="viewPath">
																			<init>
																				<variableReferenceExpression name="viewId"/>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<variableReferenceExpression name="viewName"/>
																					<methodInvokeExpression methodName="DefaultView">
																						<target>
																							<variableReferenceExpression name="resource"/>
																						</target>
																						<parameters>
																							<primitiveExpression value="collection"/>
																						</parameters>
																					</methodInvokeExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="viewName"/>
																					<primitiveExpression value="default"/>
																				</assignStatement>
																				<assignStatement>
																					<variableReferenceExpression name="viewPath"/>
																					<stringEmptyExpression/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="IsNotNullOrEmpty">
																					<variableReferenceExpression name="viewPath"/>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="viewPath"/>
																					<binaryOperatorExpression operator="Add">
																						<primitiveExpression value="/"/>
																						<variableReferenceExpression name="viewPath"/>
																					</binaryOperatorExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<variableReferenceExpression name="viewName"/>
																			<methodInvokeExpression methodName="ToPathName">
																				<target>
																					<variableReferenceExpression name="resource"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="viewName"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																		<assignStatement>
																			<variableReferenceExpression name="viewPath"/>
																			<methodInvokeExpression methodName="ToPathName">
																				<target>
																					<variableReferenceExpression name="resource"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="viewPath"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																		<methodInvokeExpression methodName="AddLink">
																			<target>
																				<variableReferenceExpression name="resource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="selfLink"/>
																				<variableReferenceExpression name="viewName"/>
																				<primitiveExpression value="GET"/>
																				<variableReferenceExpression name="links"/>
																				<methodInvokeExpression methodName="ReplaceRawUrlWith">
																					<target>
																						<variableReferenceExpression name="resource"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="ControllerResource">
																							<variableReferenceExpression name="resource"/>
																						</propertyReferenceExpression>
																						<primitiveExpression value="true"/>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[{0}{1}]]></xsl:attribute>
																						</primitiveExpression>
																						<propertyReferenceExpression name="ControllerResource">
																							<variableReferenceExpression name="resource"/>
																						</propertyReferenceExpression>
																						<variableReferenceExpression name="viewPath"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="AddLink">
																			<target>
																				<variableReferenceExpression name="resource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="firstLink"/>
																				<variableReferenceExpression name="viewName"/>
																				<primitiveExpression value="GET"/>
																				<variableReferenceExpression name="links"/>
																				<methodInvokeExpression methodName="ReplaceRawUrlWith">
																					<target>
																						<variableReferenceExpression name="resource"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="ControllerResource">
																							<variableReferenceExpression name="resource"/>
																						</propertyReferenceExpression>
																						<primitiveExpression value="true"/>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[{0}{1}?page=0&limit={2}]]></xsl:attribute>
																						</primitiveExpression>
																						<propertyReferenceExpression name="ControllerResource">
																							<variableReferenceExpression name="resource"/>
																						</propertyReferenceExpression>
																						<variableReferenceExpression name="viewPath"/>
																						<propertyReferenceExpression name="PageSize">
																							<variableReferenceExpression name="resource"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="GreaterThan">
																	<propertyReferenceExpression name="TotalRowCount">
																		<variableReferenceExpression name="viewPage"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="-1"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="AddLink">
																	<target>
																		<variableReferenceExpression name="resource"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="selfLink"/>
																		<primitiveExpression value="GET"/>
																		<variableReferenceExpression name="links"/>
																		<propertyReferenceExpression name="RawUrl">
																			<variableReferenceExpression name="resource"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="GreaterThan">
																			<variableReferenceExpression name="pagerPage"/>
																			<primitiveExpression value="0"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="AddLink">
																			<target>
																				<variableReferenceExpression name="resource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="firstLink"/>
																				<primitiveExpression value="GET"/>
																				<variableReferenceExpression name="links"/>
																				<methodInvokeExpression methodName="ExtendRawUrlWith">
																					<target>
																						<variableReferenceExpression name="resource"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="true"/>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[?page=0&limit={0}]]></xsl:attribute>
																						</primitiveExpression>
																						<variableReferenceExpression name="pagerLimit"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="AddLink">
																			<target>
																				<variableReferenceExpression name="resource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="prevLink"/>
																				<primitiveExpression value="GET"/>
																				<variableReferenceExpression name="links"/>
																				<methodInvokeExpression methodName="ExtendRawUrlWith">
																					<target>
																						<variableReferenceExpression name="resource"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="true"/>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[?page={0}&limit={1}]]></xsl:attribute>
																						</primitiveExpression>
																						<binaryOperatorExpression operator="Subtract">
																							<variableReferenceExpression name="pagerPage"/>
																							<primitiveExpression value="1"/>
																						</binaryOperatorExpression>
																						<variableReferenceExpression name="pagerLimit"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="LessThan">
																			<variableReferenceExpression name="pagerPage"/>
																			<variableReferenceExpression name="pagerLast"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="AddLink">
																			<target>
																				<variableReferenceExpression name="resource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="nextLink"/>
																				<primitiveExpression value="GET"/>
																				<variableReferenceExpression name="links"/>
																				<methodInvokeExpression methodName="ExtendRawUrlWith">
																					<target>
																						<variableReferenceExpression name="resource"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="true"/>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[?page={0}&limit={1}]]></xsl:attribute>
																						</primitiveExpression>
																						<binaryOperatorExpression operator="Add">
																							<variableReferenceExpression name="pagerPage"/>
																							<primitiveExpression value="1"/>
																						</binaryOperatorExpression>
																						<variableReferenceExpression name="pagerLimit"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="LessThan">
																			<variableReferenceExpression name="pagerPage"/>
																			<variableReferenceExpression name="pagerLast"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="AddLink">
																			<target>
																				<variableReferenceExpression name="resource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="lastLink"/>
																				<primitiveExpression value="GET"/>
																				<variableReferenceExpression name="links"/>
																				<methodInvokeExpression methodName="ExtendRawUrlWith">
																					<target>
																						<variableReferenceExpression name="resource"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="true"/>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[?page={0}&limit={1}]]></xsl:attribute>
																						</primitiveExpression>
																						<variableReferenceExpression name="pagerLast"/>
																						<variableReferenceExpression name="pagerLimit"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<propertyReferenceExpression name="LastEntity">
																<variableReferenceExpression name="resource"/>
															</propertyReferenceExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="CreateUpLink">
															<target>
																<variableReferenceExpression name="resource"/>
															</target>
															<parameters>
																<variableReferenceExpression name="links"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<foreachStatement>
													<variable name="field"/>
													<target>
														<propertyReferenceExpression name="Fields">
															<variableReferenceExpression name="viewPage"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<propertyReferenceExpression name="ItemsDataController">
																		<variableReferenceExpression name="field"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="CreateLookupLink">
																	<target>
																		<variableReferenceExpression name="resource"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="field"/>
																		<variableReferenceExpression name="links"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
												<methodInvokeExpression methodName="EnumerateActions">
													<target>
														<variableReferenceExpression name="resource"/>
													</target>
													<parameters>
														<variableReferenceExpression name="links"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="CreateSchemaLink">
													<target>
														<variableReferenceExpression name="resource"/>
													</target>
													<parameters>
														<variableReferenceExpression name="links"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="Hypermedia">
													<variableReferenceExpression name="resource"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="embedQueryParam">
													<init>
														<methodInvokeExpression methodName="Execute">
															<target>
																<objectCreateExpression type="NameSetParser">
																	<parameters>
																		<propertyReferenceExpression name="EmbedParam">
																			<variableReferenceExpression name="resource"/>
																		</propertyReferenceExpression>
																		<argumentReferenceExpression name="args"/>
																	</parameters>
																</objectCreateExpression>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<variableReferenceExpression name="embedQueryParam"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<foreachStatement>
															<variable name="name"/>
															<target>
																<variableReferenceExpression name="embedQueryParam"/>
															</target>
															<statements>
																<variableDeclarationStatement name="allFields">
																	<init>
																		<binaryOperatorExpression operator="Add">
																			<variableReferenceExpression name="name"/>
																			<primitiveExpression value=".*"/>
																		</binaryOperatorExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="Contains">
																				<target>
																					<variableReferenceExpression name="embed"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="allFields"/>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<variableReferenceExpression name="embed"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="allFields"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="GreaterThan">
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="embed"/>
															</propertyReferenceExpression>
															<primitiveExpression value="0"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="ee">
															<init>
																<objectCreateExpression type="EmbeddingEngine">
																	<parameters>
																		<variableReferenceExpression name="result"/>
																		<variableReferenceExpression name="embed"/>
																		<variableReferenceExpression name="resource"/>
																	</parameters>
																</objectCreateExpression>
															</init>
														</variableDeclarationStatement>
														<methodInvokeExpression methodName="Execute">
															<target>
																<variableReferenceExpression name="ee"/>
															</target>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="RemoveLinks">
															<variableReferenceExpression name="resource"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="RemoveLinksFrom">
															<target>
																<variableReferenceExpression name="resource"/>
															</target>
															<parameters>
																<variableReferenceExpression name="result"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
									<!-- catch RESTfulResourceException-->
									<catch exceptionType="RESTfulResourceException" localName="ex">
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="HttpCode">
														<variableReferenceExpression name="ex"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="StatusCode">
														<variableReferenceExpression name="response"/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="HttpCode">
														<argumentReferenceExpression name="ex"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<propertyReferenceExpression name="StatusCode">
														<variableReferenceExpression name="response"/>
													</propertyReferenceExpression>
													<primitiveExpression value="400"/>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="result"/>
											<methodInvokeExpression methodName="JsonError">
												<target>
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<argumentReferenceExpression name="ex"/>
													<argumentReferenceExpression name="args"/>
													<propertyReferenceExpression name="Error">
														<argumentReferenceExpression name="ex"/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="Message">
														<argumentReferenceExpression name="ex"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="SchemaHint">
													<variableReferenceExpression name="ex"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression  name="RequiresSchema">
														<variableReferenceExpression name="resource"/>
													</propertyReferenceExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</catch>
									<!-- catch ThreadAbortException-->
									<catch exceptionType="ThreadAbortException" localName="ex">
										<comment>The response was ended - do nothing</comment>
										<throwExceptionStatement>
											t
											<variableReferenceExpression name="ex"/>
										</throwExceptionStatement>
									</catch>
									<!-- catch Exception-->
									<catch exceptionType="Exception" localName="ex">
										<assignStatement>
											<variableReferenceExpression name="result"/>
											<methodInvokeExpression methodName="JsonError">
												<target>
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="ex"/>
													<argumentReferenceExpression name="args"/>
													<primitiveExpression value="general_error"/>
													<propertyReferenceExpression name="Message">
														<variableReferenceExpression name="ex"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</catch>
									<!-- finally -->
									<finally>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="resource"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="AddSchema">
													<target>
														<variableReferenceExpression name="resource"/>
													</target>
													<parameters>
														<variableReferenceExpression name="result"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</finally>
								</tryStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="cacheItem"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<propertyReferenceExpression name="IsMatch">
												<variableReferenceExpression name="cacheItem"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Value">
												<variableReferenceExpression name="cacheItem"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="result"/>
										</assignStatement>
										<methodInvokeExpression methodName="AddLatestVersionLink">
											<target>
												<variableReferenceExpression name="resource"/>
											</target>
											<parameters>
												<variableReferenceExpression name="result"/>
												<variableReferenceExpression name="cacheItem"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="HasValue">
													<variableReferenceExpression name="cacheItem"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="SetMaxAge">
													<target>
														<variableReferenceExpression name="cacheItem"/>
													</target>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToSortExpression(JToken, RESTfulResourceConfiguration) -->
						<memberMethod returnType="System.String" name="ToSortExpression">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="JToken" name="sort"/>
								<parameter type="RESTfulResource" name="resource"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="sortExpression" var="false">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<argumentReferenceExpression name="sort"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="sortExpression"/>
											<methodInvokeExpression methodName="Trim">
												<target>
													<methodInvokeExpression methodName="Join">
														<target>
															<typeReferenceExpression type="System.String"/>
														</target>
														<parameters>
															<primitiveExpression value=","/>
															<methodInvokeExpression methodName="PropToStringArray">
																<parameters>
																	<argumentReferenceExpression name="sort"/>
																	<primitiveExpression value="false"/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</target>
											</methodInvokeExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="IsMatch">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<variableReferenceExpression name="sortExpression"/>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[^\w+(\s+\w+)?(\s*,\s*\w+(\s+\w+)?)?$]]></xsl:attribute>
															</primitiveExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ThrowError">
													<target>
														<typeReferenceExpression type="RESTfulResource"/>
													</target>
													<parameters>
														<primitiveExpression value="invalid_argument"/>
														<primitiveExpression value="Invalid 'sort' parameter."/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<foreachStatement>
											<variable type="Match" name="m" var="false"/>
											<target>
												<methodInvokeExpression methodName="Matches">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="sortExpression"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[(\w+)(\s+(\w+))?]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="ContainsKey">
																<target>
																	<propertyReferenceExpression name="FieldMap">
																		<argumentReferenceExpression name="resource"/>
																	</propertyReferenceExpression>
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
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ThrowError">
															<target>
																<typeReferenceExpression type="RESTfulResource"/>
															</target>
															<parameters>
																<primitiveExpression value="400"/>
																<primitiveExpression value="true"/>
																<primitiveExpression value="invalid_argument"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[Unexpected field '{0}' is specified in the '{1}' parameter.]]></xsl:attribute>
																</primitiveExpression>
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
																<methodInvokeExpression methodName="ToApiName">
																	<target>
																		<argumentReferenceExpression name="resource"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="sort"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="IsMatch">
																<target>
																	<typeReferenceExpression type="Regex"/>
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
																				<primitiveExpression value="3"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																	<primitiveExpression>
																		<xsl:attribute name="value"><![CDATA[^(asc|desc|\s*)$]]></xsl:attribute>
																	</primitiveExpression>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ThrowError">
															<target>
																<typeReferenceExpression type="RESTfulResource"/>
															</target>
															<parameters>
																<primitiveExpression value="invalid_argument"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[Invalid sort order '{0}' is specified in the '{1}' parameter.]]></xsl:attribute>
																</primitiveExpression>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="m"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="3"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
																<methodInvokeExpression methodName="ToApiName">
																	<target>
																		<argumentReferenceExpression name="resource"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="sort"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="sortExpression"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GraphQLExecute(DataControllerService, args -->
						<memberMethod returnType="System.Object" name="GraphQLExecute">
							<attributes public="true"/>
							<parameters>
								<parameter type="DataControllerService" name="service"/>
								<parameter type="JObject" name="args"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="query">
									<init>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="args"/>
											</target>
											<indices>
												<primitiveExpression value="query"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="query"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="result">
									<init>
										<objectCreateExpression type="JObject"/>
									</init>
								</variableDeclarationStatement>
								<tryStatement>
									<statements>
										<variableDeclarationStatement name="data">
											<init>
												<objectCreateExpression type="JProperty">
													<parameters>
														<primitiveExpression value="data"/>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="result"/>
											</target>
											<parameters>
												<variableReferenceExpression name="data"/>
											</parameters>
										</methodInvokeExpression>
									</statements>
									<catch exceptionType="Exception" localName="ex">
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="result"/>
											</target>
											<parameters>
												<objectCreateExpression type="JProperty">
													<parameters>
														<primitiveExpression value="errors"/>
														<objectCreateExpression type="JArray">
															<parameters>
																<objectCreateExpression type="JProperty">
																	<parameters>
																		<primitiveExpression value="message"/>
																		<propertyReferenceExpression name="Message">
																			<variableReferenceExpression name="ex"/>
																		</propertyReferenceExpression>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</catch>
								</tryStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Parse(string) -->
						<memberMethod returnType="JObject" name="Parse">
							<attributes override ="true" public="true"/>
							<parameters>
								<parameter type="System.String" name="args"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="request">
									<init>
										<propertyReferenceExpression name="Request">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="HttpContext"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="contentType">
									<init>
										<propertyReferenceExpression name="ContentType">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<comment>process HTML form</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="contentType"/>
											<primitiveExpression value="application/x-www-form-urlencoded"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="form">
											<init>
												<objectCreateExpression type="JObject"/>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="System.String" name="key" var="false"/>
											<target>
												<propertyReferenceExpression name="Keys">
													<propertyReferenceExpression name="Form">
														<variableReferenceExpression name="request"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<statements>
												<variableDeclarationStatement name="v">
													<init>
														<methodInvokeExpression methodName="Trim">
															<target>
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Form">
																			<variableReferenceExpression name="request"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<variableReferenceExpression name="key"/>
																	</indices>
																</arrayIndexerExpression>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="v"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="form"/>
															</target>
															<parameters>
																<objectCreateExpression type="JProperty">
																	<parameters>
																		<variableReferenceExpression name="key"/>
																		<variableReferenceExpression name="v"/>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<methodReturnStatement>
											<variableReferenceExpression name="form"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<comment>process mulitpart form-data</comment>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<variableReferenceExpression name="contentType"/>
											</target>
											<parameters>
												<primitiveExpression value="multipart/form-data;"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String" name="suspectedPayload" var="false">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="suspectedPayloadCount">
											<init>
												<primitiveExpression value="0"/>
											</init>
										</variableDeclarationStatement>
										<forStatement>
											<variable name="i">
												<init>
													<primitiveExpression value="0"/>
												</init>
											</variable>
											<test>
												<binaryOperatorExpression operator="LessThan">
													<variableReferenceExpression name="i"/>
													<propertyReferenceExpression name="Count">
														<propertyReferenceExpression name="Files">
															<variableReferenceExpression name="request"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</test>
											<increment>
												<variableReferenceExpression name="i"/>
											</increment>
											<statements>
												<variableDeclarationStatement name="f">
													<init>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Files">
																	<variableReferenceExpression name="request"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<variableReferenceExpression name="i"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNullOrWhiteSpace">
															<propertyReferenceExpression name="FileName">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="IsPayloadContentType">
																	<parameters>
																		<propertyReferenceExpression name="ContentType">
																			<variableReferenceExpression name="f"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="suspectedPayloadCount"/>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="suspectedPayloadCount"/>
																		<primitiveExpression value="1"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanOr">
																	<unaryOperatorExpression operator="Not">
																		<methodInvokeExpression methodName="IsPayloadContentType">
																			<parameters>
																				<propertyReferenceExpression name="ContentType">
																					<variableReferenceExpression name="f"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</unaryOperatorExpression>
																	<binaryOperatorExpression operator="GreaterThan">
																		<variableReferenceExpression name="suspectedPayloadCount"/>
																		<primitiveExpression value="1"/>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="ThrowError">
																	<target>
																		<typeReferenceExpression type="RESTfulResource"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="400"/>
																		<primitiveExpression value="true"/>
																		<primitiveExpression value="invalid_form_data"/>
																		<primitiveExpression value="File data without a name is not allowed."/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</forStatement>
										<variableDeclarationStatement type="JObject" name="form" var="false">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="payload" var="false">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="payloadContentType" var="false">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="payloadName" var="false">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="boundary">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="contentType"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[\bboundary=(.+)(;|$)]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="Success">
														<variableReferenceExpression name="boundary"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ThrowError">
													<target>
														<typeReferenceExpression type="RESTfulResource"/>
													</target>
													<parameters>
														<primitiveExpression value="invalid_form_data"/>
														<primitiveExpression value="Missing boundary in the content type."/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="formDataRegex">
											<init>
												<objectCreateExpression type="Regex">
													<parameters>
														<stringFormatExpression>
															<xsl:attribute name="format"><![CDATA[--{0}\r\nContent-Disposition:\s*form-data;\s*name="(?'Name'(|[\s\S]+?))"(;(?'Disposition'.+?))?\r\n(Content-Type:\s*(?'ContentType'.+?)\r\n)?\r\n(\r\n|(?'Value'|[\s\S]+?)\r\n)(?=((--{0}|$)))]]></xsl:attribute>
															<methodInvokeExpression methodName="Escape">
																<target>
																	<typeReferenceExpression type="Regex"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Value">
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups">
																					<variableReferenceExpression name="boundary"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="1"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</stringFormatExpression>
														<propertyReferenceExpression name="IgnoreCase">
															<typeReferenceExpression type="RegexOptions"/>
														</propertyReferenceExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="formData">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<variableReferenceExpression name="formDataRegex"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="args"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="specifiedNames">
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="System.String"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<propertyReferenceExpression name="Success">
													<variableReferenceExpression name="formData"/>
												</propertyReferenceExpression>
											</test>
											<statements>
												<variableDeclarationStatement name="name">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="formData"/>
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
														<methodInvokeExpression methodName="IsMatch">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="name"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[[^\w_]]]></xsl:attribute>
																</primitiveExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ThrowError">
															<target>
																<typeReferenceExpression type="RESTfulResource"/>
															</target>
															<parameters>
																<primitiveExpression value="invalid_form_data"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[Value '{0}' includes non-alphanumeric characters in the name.]]></xsl:attribute>
																</primitiveExpression>
																<variableReferenceExpression name="name"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Contains">
															<target>
																<variableReferenceExpression name="specifiedNames"/>
															</target>
															<parameters>
																<variableReferenceExpression name="name"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ThrowError">
															<target>
																<typeReferenceExpression type="RESTfulResource"/>
															</target>
															<parameters>
																<primitiveExpression value="invalid_form_data"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[Value with the name '{0}' is specified more than once.]]></xsl:attribute>
																</primitiveExpression>
																<variableReferenceExpression name="name"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="specifiedNames"/>
													</target>
													<parameters>
														<variableReferenceExpression name="name"/>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement name="value">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="formData"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Value"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="disposition">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="formData"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Disposition"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="dataContentType">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="formData"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="ContentType"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="name"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNullOrEmpty">
																	<variableReferenceExpression name="dataContentType"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="suspectedPayload"/>
																	<variableReferenceExpression name="value"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="payload"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="ThrowError">
																			<target>
																				<typeReferenceExpression type="RESTfulResource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="invalid_form_data"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[Duplicate '{0}' payload is specified.]]></xsl:attribute>
																				</primitiveExpression>
																				<variableReferenceExpression name="dataContentType"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="form"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="ThrowError">
																			<target>
																				<typeReferenceExpression type="RESTfulResource"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="invalid_form_data"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[Payload '{0}' cannot be specified after the named values in the 'multipart/form-data' body.]]></xsl:attribute>
																				</primitiveExpression>
																				<variableReferenceExpression name="dataContentType"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<assignStatement>
																	<variableReferenceExpression name="payload"/>
																	<variableReferenceExpression name="value"/>
																</assignStatement>
																<assignStatement>
																	<variableReferenceExpression name="payloadContentType"/>
																	<variableReferenceExpression name="dataContentType"/>
																</assignStatement>
																<assignStatement>
																	<variableReferenceExpression name="payloadName"/>
																	<variableReferenceExpression name="payloadContentType"/>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="IsMatch">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="name"/>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[^[\w_]+$]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNullOrEmpty">
																			<variableReferenceExpression name="dataContentType"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityInequality">
																					<variableReferenceExpression name="payload"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="ThrowError">
																					<target>
																						<typeReferenceExpression type="RESTfulResource"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="invalid_form_data"/>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[Specify '{0}' value in the payload '{1}' instead.]]></xsl:attribute>
																						</primitiveExpression>
																						<variableReferenceExpression name="name"/>
																						<variableReferenceExpression name="payloadName"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityEquality">
																					<variableReferenceExpression name="form"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="form"/>
																					<objectCreateExpression type="JObject"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="form"/>
																				</target>
																				<indices>
																					<variableReferenceExpression  name="name"/>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="value"/>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="IsNullOrEmpty">
																					<variableReferenceExpression name="disposition"/>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="BooleanOr">
																							<binaryOperatorExpression operator="IdentityInequality">
																								<variableReferenceExpression name="payload"/>
																								<primitiveExpression value="null"/>
																							</binaryOperatorExpression>
																							<binaryOperatorExpression operator="IdentityInequality">
																								<variableReferenceExpression name="form"/>
																								<primitiveExpression value="null"/>
																							</binaryOperatorExpression>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="ThrowError">
																							<target>
																								<typeReferenceExpression type="RESTfulResource"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="invalid_form_data"/>
																								<primitiveExpression>
																									<xsl:attribute name="value"><![CDATA[Unexpected payload '{0}' is specified.]]></xsl:attribute>
																								</primitiveExpression>
																								<variableReferenceExpression name="name"/>
																							</parameters>
																						</methodInvokeExpression>
																					</trueStatements>
																				</conditionStatement>
																				<assignStatement>
																					<variableReferenceExpression  name="payload"/>
																					<variableReferenceExpression name="value"/>
																				</assignStatement>
																				<assignStatement>
																					<variableReferenceExpression name="payloadContentType"/>
																					<variableReferenceExpression name="dataContentType"/>
																				</assignStatement>
																				<assignStatement>
																					<variableReferenceExpression name="payloadName"/>
																					<variableReferenceExpression name="name"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="formData"/>
													<methodInvokeExpression methodName="NextMatch">
														<target>
															<variableReferenceExpression name="formData"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</statements>
										</whileStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="form"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<variableReferenceExpression name="form"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="payloadContentType"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="suspectedPayload"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="payload"/>
															<variableReferenceExpression name="suspectedPayload"/>
														</assignStatement>
														<assignStatement>
															<variableReferenceExpression name="payloadContentType"/>
															<primitiveExpression value="application/json"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<methodReturnStatement>
															<objectCreateExpression type="JObject"/>
														</methodReturnStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="contentType"/>
											<variableReferenceExpression name="payloadContentType"/>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="ValueEquality">
														<variableReferenceExpression name="payloadContentType"/>
														<primitiveExpression value="application/xml"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<variableReferenceExpression name="payloadContentType"/>
														<primitiveExpression value="text/xml"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="args"/>
													<methodInvokeExpression methodName="XmlToJson">
														<target>
															<typeReferenceExpression type="TextUtility"/>
														</target>
														<parameters>
															<variableReferenceExpression name="payload"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<argumentReferenceExpression name="args"/>
													<variableReferenceExpression name="payload"/>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<comment>verify the content type and return the payload</comment>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="contentType"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="contentType"/>
											<primitiveExpression value="application/json"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="IsPayloadContentType">
												<parameters>
													<variableReferenceExpression name="contentType"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ThrowError">
											<target>
												<typeReferenceExpression type="RESTfulResource"/>
											</target>
											<parameters>
												<primitiveExpression value="invalid_content_type"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[Content type '{0}' is not supported in the request.]]></xsl:attribute>
												</primitiveExpression>
												<variableReferenceExpression name="contentType"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ParseYamlOrJson">
										<target>
											<typeReferenceExpression type="TextUtility"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="args"/>
											<primitiveExpression value="true"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IsPayloadContentType(string) -->
						<memberMethod returnType="System.Boolean" name="IsPayloadContentType">
							<attributes public ="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="contentType"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="IsMatch">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="contentType"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[^(application/(json|x-yaml|xml)|text/(yaml|x-yaml|xml))$]]></xsl:attribute>
											</primitiveExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
