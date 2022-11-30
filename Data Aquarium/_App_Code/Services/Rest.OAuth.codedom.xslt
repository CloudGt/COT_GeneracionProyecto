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
				<namespaceImport name="System.Drawing"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Net"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Handlers"/>
			</imports>
			<types>
				<!-- class RESTfulResourceBase -->
				<typeDeclaration name="RESTfulResourceBase" isPartial="true">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="RESTfulResourceConfiguration"/>
					</baseTypes>
					<members>
						<!-- property OAuth -->
						<memberProperty type="System.String" name="OAuth">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property OAuthMethod -->
						<memberProperty type="System.String" name="OAuthMethod">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property OAuthMethodName -->
						<memberProperty type="System.String" name="OAuthMethodName">
							<attributes public="true" final="true"/>
							<getStatements>
								<variableDeclarationStatement name="path">
									<init>
										<stringFormatExpression format="{{0}}/{{1}}">
											<methodInvokeExpression methodName="ToLower">
												<target>
													<propertyReferenceExpression name="HttpMethod"/>
												</target>
											</methodInvokeExpression>
											<propertyReferenceExpression name="OAuth"/>
										</stringFormatExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<propertyReferenceExpression name="OAuthMethod"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="path"/>
											<stringFormatExpression format="{{0}}/{{1}}">
												<variableReferenceExpression name="path"/>
												<propertyReferenceExpression name="OAuthMethod"/>
											</stringFormatExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="path"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property OAuthMethodPath -->
						<memberProperty type="System.String" name="OAuthMethodPath">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Substring">
										<target>
											<propertyReferenceExpression name="OAuthMethodName"/>
										</target>
										<parameters>
											<binaryOperatorExpression operator="Add">
												<propertyReferenceExpression name="Length">
													<propertyReferenceExpression name="HttpMethod"/>
												</propertyReferenceExpression>
												<primitiveExpression value="1"/>
											</binaryOperatorExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<xsl:if test="$IsUnlimited='true'">
							<!-- property IdClaims-->
							<memberField type="JObject" name="idClaims"/>
							<memberProperty type="JObject" name="IdClaims">
								<attributes override="true" public="true"/>
								<getStatements>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<fieldReferenceExpression name="idClaims"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="idClaims"/>
												<objectCreateExpression type="JObject"/>
											</assignStatement>
											<variableDeclarationStatement name="authorization">
												<init>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Headers">
																<propertyReferenceExpression name="Request">
																	<propertyReferenceExpression name="Current">
																		<typeReferenceExpression type="HttpContext"/>
																	</propertyReferenceExpression>
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
													<binaryOperatorExpression operator="BooleanAnd">
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="authorization"/>
														</unaryOperatorExpression>
														<methodInvokeExpression methodName="StartsWith">
															<target>
																<variableReferenceExpression name="authorization"/>
															</target>
															<parameters>
																<primitiveExpression value="Bearer "/>
																<propertyReferenceExpression name="OrdinalIgnoreCase">
																	<typeReferenceExpression type="StringComparison"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ExecuteOAuthPostUserInfo">
														<parameters>
															<objectCreateExpression type="JObject"/>
															<objectCreateExpression type="JObject" />
															<fieldReferenceExpression name="idClaims"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<fieldReferenceExpression name="idClaims"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method ExecuteOAuth(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuth">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<comment>create OAuth2 authorization request</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="OAuthMethodName"/>
												<primitiveExpression value="get/auth"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthGetAuth">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>Process the authorization request</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="OAuthMethodName"/>
												<primitiveExpression value="post/auth"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthPostAuth">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>Exchange 'authorization_code' or 'refresh_token' for an access token</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="OAuthMethodName"/>
												<primitiveExpression value="post/token"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthPostToken">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>Exchange 'authorization_code' or 'refresh_token' for an access token</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="OAuthMethodName"/>
												<primitiveExpression value="post/revoke"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthPostRevoke">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>Get the Open ID user claims for a given access token</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="OAuthMethodName"/>
												<primitiveExpression value="post/userinfo"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthPostUserInfo">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>Get the the user info such as photo, etc.</comment>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="StartsWith">
												<propertyReferenceExpression name="OAuthMethodName"/>
												<target>
													<propertyReferenceExpression name="OAuthMethodName"/>
												</target>
												<parameters>
													<primitiveExpression value="get/userinfo/pictures"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthGetUserInfoPictures">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>create 'authorization' and 'token' links with parameters</comment>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="StartsWith">
												<target>
													<propertyReferenceExpression name="OAuthMethodName"/>
												</target>
												<parameters>
													<primitiveExpression value="post/auth/"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthPostAuthClient">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>get the list of client app records</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="OAuthMethodName"/>
												<primitiveExpression value="get/apps"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthGetApps">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>register a client app</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="OAuthMethodName"/>
												<primitiveExpression value="post/apps"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthPostApps">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>get the client app record</comment>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="StartsWith">
												<target>
													<propertyReferenceExpression name="OAuthMethodName"/>
												</target>
												<parameters>
													<primitiveExpression value="get/apps/"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthGetAppsSingleton">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
													<primitiveExpression value="null"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>delete the client app record</comment>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="StartsWith">
												<target>
													<propertyReferenceExpression name="OAuthMethodName"/>
												</target>
												<parameters>
													<primitiveExpression value="delete/apps/"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthDeleteAppsSingleton">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>patch the client app record</comment>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="StartsWith">
												<target>
													<propertyReferenceExpression name="OAuthMethodName"/>
												</target>
												<parameters>
													<primitiveExpression value="patch/apps/"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthPatchAppsSingleton">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>get information specified in 'id_token' parameter</comment>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="StartsWith">
												<target>
													<propertyReferenceExpression name="OAuthMethodName"/>
												</target>
												<parameters>
													<primitiveExpression value="get/tokeninfo"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthGetTokenInfo">
												<parameters>
													<argumentReferenceExpression name="schema"/>
													<argumentReferenceExpression name="payload"/>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthGetAuth(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthGetAuth">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="authRequest">
										<init>
											<objectCreateExpression type="JObject"/>
										</init>
									</variableDeclarationStatement>
									<comment>verify 'client_id'</comment>
									<variableDeclarationStatement name="clientApp">
										<init>
											<objectCreateExpression type="JObject"/>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="ExecuteOAuthGetAppsSingleton">
										<parameters>
											<argumentReferenceExpression name="schema"/>
											<argumentReferenceExpression name="payload"/>
											<argumentReferenceExpression name="clientApp"/>
											<primitiveExpression value="invalid_client"/>
										</parameters>
									</methodInvokeExpression>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="authRequest"/>
											</target>
											<indices>
												<primitiveExpression value="date"/>
											</indices>
										</arrayIndexerExpression>
										<methodInvokeExpression methodName="ToString">
											<target>
												<propertyReferenceExpression name="UtcNow">
													<typeReferenceExpression type="DateTime"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<primitiveExpression value="o"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="authRequest"/>
											</target>
											<indices>
												<primitiveExpression value="name"/>
											</indices>
										</arrayIndexerExpression>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="clientApp"/>
											</target>
											<indices>
												<primitiveExpression value="name"/>
											</indices>
										</arrayIndexerExpression>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="authRequest"/>
											</target>
											<indices>
												<primitiveExpression value="author"/>
											</indices>
										</arrayIndexerExpression>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="clientApp"/>
											</target>
											<indices>
												<primitiveExpression value="author"/>
											</indices>
										</arrayIndexerExpression>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="authRequest"/>
											</target>
											<indices>
												<primitiveExpression value="trusted"/>
											</indices>
										</arrayIndexerExpression>
										<convertExpression to="Boolean">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="clientApp"/>
												</target>
												<indices>
													<primitiveExpression value="trusted"/>
												</indices>
											</arrayIndexerExpression>
										</convertExpression>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="authRequest"/>
											</target>
											<indices>
												<primitiveExpression value="code"/>
											</indices>
										</arrayIndexerExpression>
										<methodInvokeExpression methodName="ToUrlEncodedToken">
											<target>
												<typeReferenceExpression type="TextUtility"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="GetUniqueKey">
													<target>
														<typeReferenceExpression type="TextUtility"/>
													</target>
													<parameters>
														<primitiveExpression value="40"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<comment>verify 'redirect_uri'</comment>
									<variableDeclarationStatement type="System.String" name="redirectUri" var="false">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<tryStatement>
										<statements>
											<assignStatement>
												<variableReferenceExpression name="redirectUri"/>
												<propertyReferenceExpression name="AbsoluteUri">
													<objectCreateExpression type="Uri">
														<parameters>
															<castExpression targetType="System.String">
																<arrayIndexerExpression>
																	<target>
																		<argumentReferenceExpression  name="payload"/>
																	</target>
																	<indices>
																		<primitiveExpression value="redirect_uri"/>
																	</indices>
																</arrayIndexerExpression>
															</castExpression>
														</parameters>
													</objectCreateExpression>
												</propertyReferenceExpression>
											</assignStatement>
										</statements>
										<catch exceptionType="Exception" localName="ex">
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="invalid_parameter"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[Parameter 'redirect_uri': {0}]]></xsl:attribute>
													</primitiveExpression>
													<propertyReferenceExpression name="Message">
														<variableReferenceExpression name="ex"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</catch>
									</tryStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanOr">
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="redirectUri"/>
													<castExpression targetType="System.String">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="clientApp"/>
															</target>
															<indices>
																<primitiveExpression value="redirect_uri"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="redirectUri"/>
													<castExpression targetType="System.String">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="clientApp"/>
															</target>
															<indices>
																<primitiveExpression value="local_redirect_uri"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="authRequest"/>
													</target>
													<indices>
														<primitiveExpression value="redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="redirectUri"/>
											</assignStatement>
										</trueStatements>
										<falseStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="invalid_parameter"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[Parameter 'redirect_uri' does not match the redirect URIs of '{0}' client application.]]></xsl:attribute>
													</primitiveExpression>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="clientApp"/>
														</target>
														<indices>
															<primitiveExpression value="name"/>
														</indices>
													</arrayIndexerExpression>
												</parameters>
											</methodInvokeExpression>
										</falseStatements>
									</conditionStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="authRequest"/>
											</target>
											<indices>
												<primitiveExpression value="client_id"/>
											</indices>
										</arrayIndexerExpression>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="clientApp"/>
											</target>
											<indices>
												<primitiveExpression value="client_id"/>
											</indices>
										</arrayIndexerExpression>
									</assignStatement>
									<variableDeclarationStatement name="serverAuthorization">
										<init>
											<convertExpression to="Boolean">
												<methodInvokeExpression methodName="SelectToken">
													<target>
														<variableReferenceExpression name="clientApp"/>
													</target>
													<parameters>
														<primitiveExpression value="authorization.server"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="nativeAuthorization">
										<init>
											<convertExpression to="Boolean">
												<methodInvokeExpression methodName="SelectToken">
													<target>
														<variableReferenceExpression name="clientApp"/>
													</target>
													<parameters>
														<primitiveExpression value="authorization.native"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="spaAuthorization">
										<init>
											<convertExpression to="Boolean">
												<methodInvokeExpression methodName="SelectToken">
													<target>
														<variableReferenceExpression name="clientApp"/>
													</target>
													<parameters>
														<primitiveExpression value="authorization.spa"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<variableReferenceExpression name="serverAuthorization"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="authRequest"/>
													</target>
													<indices>
														<primitiveExpression value="client_secret"/>
													</indices>
												</arrayIndexerExpression>
												<methodInvokeExpression methodName="ToUrlEncodedToken">
													<target>
														<typeReferenceExpression type="TextUtility"/>
													</target>
													<parameters>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="clientApp"/>
																</target>
																<indices>
																	<primitiveExpression value="client_secret"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement name="codeChallenge">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="code_challenge"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="codeChallengeMethod">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="code_challenge_method"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="BooleanOr">
														<variableReferenceExpression name="nativeAuthorization"/>
														<variableReferenceExpression name="serverAuthorization"/>
													</binaryOperatorExpression>
													<variableReferenceExpression name="spaAuthorization"/>
												</binaryOperatorExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="unauthorized"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[Client application '{0}' is disabled.]]></xsl:attribute>
													</primitiveExpression>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="clientApp"/>
														</target>
														<indices>
															<primitiveExpression value="name"/>
														</indices>
													</arrayIndexerExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanOr">
												<variableReferenceExpression name="nativeAuthorization"/>
												<variableReferenceExpression name="serverAuthorization"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="codeVerificationRequired">
												<init>
													<binaryOperatorExpression operator="BooleanAnd">
														<variableReferenceExpression name="nativeAuthorization"/>
														<unaryOperatorExpression operator="Not">
															<binaryOperatorExpression operator="BooleanOr">
																<variableReferenceExpression name="spaAuthorization"/>
																<variableReferenceExpression name="serverAuthorization"/>
															</binaryOperatorExpression>
														</unaryOperatorExpression>
													</binaryOperatorExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="clientSecretRequired">
												<init>
													<binaryOperatorExpression operator="BooleanAnd">
														<variableReferenceExpression name="serverAuthorization"/>
														<unaryOperatorExpression operator="Not">
															<binaryOperatorExpression operator="BooleanOr">
																<variableReferenceExpression name="nativeAuthorization"/>
																<variableReferenceExpression name="spaAuthorization"/>
															</binaryOperatorExpression>
														</unaryOperatorExpression>
													</binaryOperatorExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="codeChallenge"/>
														</unaryOperatorExpression>
														<binaryOperatorExpression operator="BooleanOr">
															<variableReferenceExpression name="codeVerificationRequired"/>
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="codeChallengeMethod"/>
															</unaryOperatorExpression>
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
															<primitiveExpression value="Parameter 'code_challenge' is expected."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="codeChallengeMethod"/>
														</unaryOperatorExpression>
														<binaryOperatorExpression operator="BooleanOr">
															<variableReferenceExpression name="codeVerificationRequired"/>
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="codeChallenge"/>
															</unaryOperatorExpression>
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
															<primitiveExpression value="Parameter 'code_challenge_method' is expected."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<variableReferenceExpression name="clientSecretRequired"/>
												</condition>
												<trueStatements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="authRequest"/>
															</target>
															<indices>
																<primitiveExpression value="client_secret_required"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="true"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="authRequest"/>
													</target>
													<indices>
														<primitiveExpression value="code_challenge"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="codeChallenge"/>
											</assignStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="authRequest"/>
													</target>
													<indices>
														<primitiveExpression value="code_challenge_method"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="codeChallengeMethod"/>
											</assignStatement>
											<conditionStatement>
												<condition>
													<variableReferenceExpression name="codeVerificationRequired"/>
												</condition>
												<trueStatements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="authRequest"/>
															</target>
															<indices>
																<primitiveExpression value="code_verifier_required"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="true"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
										<falseStatements>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="codeChallenge"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_parameter"/>
															<primitiveExpression value="Unexpected parameter 'code_challenge' is specified."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="codeChallengeMethod"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_parameter"/>
															<primitiveExpression value="Unexpected parameter 'code_challenge_method' is specified."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</falseStatements>
									</conditionStatement>
									<variableDeclarationStatement name="scopeList">
										<init>
											<methodInvokeExpression methodName="ScopeListFrom">
												<parameters>
													<argumentReferenceExpression name="payload"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="GreaterThan">
												<propertyReferenceExpression name="Count">
													<variableReferenceExpression name="scopeList"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="stdScopes">
												<init>
													<methodInvokeExpression methodName="StandardScopes"/>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="appScopes">
												<init>
													<methodInvokeExpression methodName="ApplicationScopes"/>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="scopeIndex">
												<init>
													<primitiveExpression value="0"/>
												</init>
											</variableDeclarationStatement>
											<whileStatement>
												<test>
													<binaryOperatorExpression operator="LessThan">
														<variableReferenceExpression name="scopeIndex"/>
														<propertyReferenceExpression name="Count">
															<variableReferenceExpression name="scopeList"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</test>
												<statements>
													<variableDeclarationStatement name="scope">
														<init>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="scopeList"/>
																</target>
																<indices>
																	<variableReferenceExpression name="scopeIndex"/>
																</indices>
															</arrayIndexerExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="BooleanAnd">
																<binaryOperatorExpression operator="BooleanOr">
																	<binaryOperatorExpression operator="IdentityInequality">
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="stdScopes"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="scope"/>
																			</indices>
																		</arrayIndexerExpression>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="IdentityInequality">
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="appScopes"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="scope"/>
																			</indices>
																		</arrayIndexerExpression>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
																<binaryOperatorExpression operator="ValueEquality">
																	<methodInvokeExpression methodName="IndexOf">
																		<target>
																			<variableReferenceExpression name="scopeList"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="scope"/>
																		</parameters>
																	</methodInvokeExpression>
																	<variableReferenceExpression name="scopeIndex"/>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="scopeIndex"/>
																<binaryOperatorExpression operator="Add">
																	<variableReferenceExpression name="scopeIndex"/>
																	<primitiveExpression value="1"/>
																</binaryOperatorExpression>
															</assignStatement>
														</trueStatements>
														<falseStatements>
															<methodInvokeExpression methodName="RemoveAt">
																<target>
																	<variableReferenceExpression name="scopeList"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="scopeIndex"/>
																</parameters>
															</methodInvokeExpression>
														</falseStatements>
													</conditionStatement>
												</statements>
											</whileStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="authRequest"/>
													</target>
													<indices>
														<primitiveExpression value="scope"/>
													</indices>
												</arrayIndexerExpression>
												<methodInvokeExpression methodName="Join">
													<target>
														<typeReferenceExpression type="System.String"/>
													</target>
													<parameters>
														<primitiveExpression value=" "/>
														<variableReferenceExpression name="scopeList"/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="authRequest"/>
											</target>
											<indices>
												<primitiveExpression value="state"/>
											</indices>
										</arrayIndexerExpression>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="payload"/>
											</target>
											<indices>
												<primitiveExpression value="state"/>
											</indices>
										</arrayIndexerExpression>
									</assignStatement>
									<comment>delete the last request</comment>
									<variableDeclarationStatement name="cookie">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Cookies">
														<propertyReferenceExpression name="Request">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value=".oauth2"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="cookie"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="lastOAuth2Request">
												<init>
													<methodInvokeExpression methodName="Match">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="cookie"/>
															</propertyReferenceExpression>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[^(.+?)(\:consent)?$]]></xsl:attribute>
															</primitiveExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<propertyReferenceExpression name="Success">
														<variableReferenceExpression name="lastOAuth2Request"/>
													</propertyReferenceExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="AppDataDelete">
														<target>
															<propertyReferenceExpression name="App"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="OAuth2FileName">
																<parameters>
																	<primitiveExpression value="requests"/>
																	<propertyReferenceExpression name="Value">
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups">
																					<variableReferenceExpression name="lastOAuth2Request"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="1"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<comment>create the new request</comment>
									<variableDeclarationStatement name="authData">
										<init>
											<methodInvokeExpression methodName="ToString">
												<target>
													<variableReferenceExpression name="authRequest"/>
												</target>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="authRef">
										<init>
											<methodInvokeExpression methodName="ToUrlEncodedToken">
												<target>
													<typeReferenceExpression type="TextUtility"/>
												</target>
												<parameters>
													<variableReferenceExpression name="authData"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="AppDataWriteAllText">
										<target>
											<propertyReferenceExpression name="App"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="OAuth2FileName">
												<parameters>
													<primitiveExpression value="requests"/>
													<variableReferenceExpression name="authRef"/>
												</parameters>
											</methodInvokeExpression>
											<variableReferenceExpression name="authData"/>
										</parameters>
									</methodInvokeExpression>
									<assignStatement>
										<variableReferenceExpression name="cookie"/>
										<objectCreateExpression type="HttpCookie">
											<parameters>
												<primitiveExpression value=".oauth2"/>
												<variableReferenceExpression name="authRef"/>
											</parameters>
										</objectCreateExpression>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="Expires">
											<variableReferenceExpression name="cookie"/>
										</propertyReferenceExpression>
										<methodInvokeExpression methodName="AddMinutes">
											<target>
												<propertyReferenceExpression name="Now">
													<typeReferenceExpression type="DateTime"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="AuthorizationRequestLifespan"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<methodInvokeExpression methodName="SetCookie">
										<target>
											<typeReferenceExpression type="ApplicationServices"/>
										</target>
										<parameters>
											<variableReferenceExpression name="cookie"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Redirect">
										<target>
											<propertyReferenceExpression name="Response">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<methodInvokeExpression methodName="UserHomePageUrl">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthPostAuth(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthPostAuth">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="authRequestFileName">
										<init>
											<methodInvokeExpression methodName="OAuth2FileName">
												<parameters>
													<primitiveExpression value="requests"/>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="payload"/>
														</target>
														<indices>
															<primitiveExpression value="request_id"/>
														</indices>
													</arrayIndexerExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="authRequest">
										<init>
											<methodInvokeExpression methodName="ReadOAuth2Data">
												<parameters>
													<variableReferenceExpression name="authRequestFileName"/>
													<primitiveExpression value="null"/>
													<primitiveExpression value="invalid_request"/>
													<primitiveExpression value="Invalid OAuth2 authorization 'request_id' is specified."/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="AppDataDelete">
										<target>
											<propertyReferenceExpression name="App"/>
										</target>
										<parameters>
											<variableReferenceExpression name="authRequestFileName"/>
										</parameters>
									</methodInvokeExpression>
									<comment>delete '.oauth2' cookie and the request data</comment>
									<variableDeclarationStatement name="cookie">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Cookies">
														<propertyReferenceExpression name="Request">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value=".oauth2"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="cookie"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
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
														<primitiveExpression value="-10"/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
											<methodInvokeExpression methodName="SetCookie">
												<target>
													<typeReferenceExpression type="ApplicationServices"/>
												</target>
												<parameters>
													<variableReferenceExpression name="cookie"/>
												</parameters>
											</methodInvokeExpression>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="StartsWith">
															<target>
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="cookie"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<castExpression targetType="System.String">
																	<arrayIndexerExpression>
																		<target>
																			<argumentReferenceExpression name="payload"/>
																		</target>
																		<indices>
																			<primitiveExpression value="request_id"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
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
															<primitiveExpression value="The 'request_id' does not match the request authorization state."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
										<falseStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="invalid_state"/>
													<primitiveExpression value="Application is not in the authorization state."/>
												</parameters>
											</methodInvokeExpression>
										</falseStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="LessThan">
												<methodInvokeExpression methodName="AddMinutes">
													<target>
														<methodInvokeExpression methodName="Parse">
															<target>
																<typeReferenceExpression type="DateTime"/>
															</target>
															<parameters>
																<castExpression targetType="System.String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="authRequest"/>
																		</target>
																		<indices>
																			<primitiveExpression value="date"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
															</parameters>
														</methodInvokeExpression>
													</target>
													<parameters>
														<propertyReferenceExpression name="AuthorizationRequestLifespan"/>
													</parameters>
												</methodInvokeExpression>
												<propertyReferenceExpression name="UtcNow">
													<typeReferenceExpression type="DateTime"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="invalid_argument"/>
													<primitiveExpression value="Authorization request has expired."/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="authRequest"/>
											</target>
											<indices>
												<primitiveExpression value="date"/>
											</indices>
										</arrayIndexerExpression>
										<methodInvokeExpression methodName="AddMinutes">
											<target>
												<propertyReferenceExpression name="UtcNow">
													<typeReferenceExpression type="DateTime"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="AuthorizationCodeLifespan"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<comment>save the username to the request</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanOr">
												<convertExpression to="Boolean">
													<methodInvokeExpression methodName="SettingsProperty">
														<target>
															<typeReferenceExpression type="ApplicationServicesBase"/>
														</target>
														<parameters>
															<primitiveExpression value="membership.accountManager.enabled"/>
															<primitiveExpression value="true"/>
														</parameters>
													</methodInvokeExpression>
												</convertExpression>
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
											<methodInvokeExpression methodName="BearerAuthorizationHeader"/>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="authRequest"/>
											</target>
											<indices>
												<primitiveExpression value="username"/>
											</indices>
										</arrayIndexerExpression>
										<propertyReferenceExpression name="Name">
											<propertyReferenceExpression name="Identity">
												<propertyReferenceExpression name="User">
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="HttpContext"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</assignStatement>
									<comment>create a response</comment>
									<variableDeclarationStatement name="links">
										<init>
											<methodInvokeExpression methodName="CreateLinks">
												<parameters>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="redirectUri">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="authRequest"/>
													</target>
													<indices>
														<primitiveExpression value="redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name ="url">
										<init>
											<objectCreateExpression type="StringBuilder">
												<parameters>
													<variableReferenceExpression name="redirectUri"/>
												</parameters>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanOr">
												<methodInvokeExpression methodName="Contains">
													<target>
														<variableReferenceExpression name="redirectUri"/>
													</target>
													<parameters>
														<primitiveExpression value="?"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="IsMatch">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="redirectUri"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[#.+?]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Append">
												<target>
													<variableReferenceExpression name="url"/>
												</target>
												<parameters>
													<primitiveExpression value="&amp;"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
										<falseStatements>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="Contains">
															<target>
																<variableReferenceExpression name="redirectUri"/>
															</target>
															<parameters>
																<primitiveExpression value="#"/>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="Append">
														<target>
															<variableReferenceExpression name="url"/>
														</target>
														<parameters>
															<primitiveExpression value="?"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</falseStatements>
									</conditionStatement>
									<variableDeclarationStatement name="state">
										<init>
											<methodInvokeExpression methodName="UrlEncode">
												<target>
													<typeReferenceExpression type="HttpUtility"/>
												</target>
												<parameters>
													<convertExpression to="String">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name ="authRequest"/>
															</target>
															<indices>
																<primitiveExpression value="state"/>
															</indices>
														</arrayIndexerExpression>
													</convertExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<castExpression targetType="System.String">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="payload"/>
														</target>
														<indices>
															<primitiveExpression value="consent"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
												<primitiveExpression value="allow"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="AppendFormat">
												<target>
													<variableReferenceExpression name="url"/>
												</target>
												<parameters>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[code={0}]]></xsl:attribute>
													</primitiveExpression>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="authRequest"/>
														</target>
														<indices>
															<primitiveExpression value="code"/>
														</indices>
													</arrayIndexerExpression>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="AppendFormat">
												<target>
													<variableReferenceExpression name="url"/>
												</target>
												<parameters>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[&state={0}]]></xsl:attribute>
													</primitiveExpression>
													<variableReferenceExpression name="state"/>
												</parameters>
											</methodInvokeExpression>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="authRequest"/>
													</target>
													<indices>
														<primitiveExpression value="timezone"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="timezone"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="authRequest"/>
													</target>
													<indices>
														<primitiveExpression value="locale"/>
													</indices>
												</arrayIndexerExpression>
												<propertyReferenceExpression name="Name">
													<propertyReferenceExpression name="CurrentCulture">
														<typeReferenceExpression type="System.Globalization.CultureInfo"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</assignStatement>
											<methodInvokeExpression methodName="TrimScopesIn">
												<parameters>
													<variableReferenceExpression name="authRequest"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="AppDataWriteAllText">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="OAuth2FileName">
														<parameters>
															<primitiveExpression value="codes"/>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authRequest"/>
																</target>
																<indices>
																	<primitiveExpression value="code"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</methodInvokeExpression>
													<methodInvokeExpression methodName="ToString">
														<target>
															<variableReferenceExpression name="authRequest"/>
														</target>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
										<falseStatements>
											<methodInvokeExpression methodName="Append">
												<target>
													<variableReferenceExpression name="url"/>
												</target>
												<parameters>
													<primitiveExpression value="error=access_denied"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="AppendFormat">
												<target>
													<variableReferenceExpression name="url"/>
												</target>
												<parameters>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[&state={0}]]></xsl:attribute>
													</primitiveExpression>
													<variableReferenceExpression name="state"/>
												</parameters>
											</methodInvokeExpression>
										</falseStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="AddLink">
										<parameters>
											<primitiveExpression value="redirect-uri"/>
											<primitiveExpression value="GET"/>
											<variableReferenceExpression name ="links"/>
											<binaryOperatorExpression operator="Add">
												<primitiveExpression value="_self:"/>
												<methodInvokeExpression methodName="ToString">
													<target>
														<variableReferenceExpression name="url"/>
													</target>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="OAuthCollectGarbage"/>
								</statements>
							</memberMethod>
							<!-- method OAuthCollectGarbage() -->
							<memberMethod name="OAuthCollectGarbage">
								<attributes public="true"/>
								<statements>
									<comment>Cleanup is performed when the user approves or denies the authorization request</comment>
									<variableDeclarationStatement name="filesToDelete">
										<init>
											<objectCreateExpression type="List">
												<typeArguments>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<comment>1. delete sys/oauth2/requests beyound the lifespan</comment>
									<methodInvokeExpression methodName="AddRange">
										<target>
											<variableReferenceExpression name="filesToDelete"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="AppDataSearch">
												<target>
													<propertyReferenceExpression  name="App"/>
												</target>
												<parameters>
													<primitiveExpression value="sys/oauth2/requests"/>
													<primitiveExpression value="%.json"/>
													<primitiveExpression value="3"/>
													<methodInvokeExpression methodName="AddMinutes">
														<target>
															<propertyReferenceExpression name="UtcNow">
																<typeReferenceExpression type="DateTime"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<binaryOperatorExpression operator="Multiply">
																<primitiveExpression value="-1"/>
																<propertyReferenceExpression name="AuthorizationRequestLifespan"/>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<comment>2. delete sys/oauth2/codes beyond the lifespan</comment>
									<methodInvokeExpression methodName="AddRange">
										<target>
											<variableReferenceExpression name="filesToDelete"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="AppDataSearch">
												<target>
													<propertyReferenceExpression  name="App"/>
												</target>
												<parameters>
													<primitiveExpression value="sys/oauth2/codes"/>
													<primitiveExpression value="%.json"/>
													<primitiveExpression value="3"/>
													<methodInvokeExpression methodName="AddMinutes">
														<target>
															<propertyReferenceExpression name="UtcNow">
																<typeReferenceExpression type="DateTime"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<binaryOperatorExpression operator="Multiply">
																<primitiveExpression value="-1"/>
																<propertyReferenceExpression name="AuthorizationCodeLifespan"/>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<comment>3. delete sys/oauth2/pictures beyond the lifespan (the duration of the id_token)</comment>
									<methodInvokeExpression methodName="AddRange">
										<target>
											<variableReferenceExpression name="filesToDelete"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="AppDataSearch">
												<target>
													<propertyReferenceExpression  name="App"/>
												</target>
												<parameters>
													<primitiveExpression value="sys/oauth2/pictures/%"/>
													<primitiveExpression value="%.json"/>
													<primitiveExpression value="3"/>
													<methodInvokeExpression methodName="AddMinutes">
														<target>
															<propertyReferenceExpression name="UtcNow">
																<typeReferenceExpression type="DateTime"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<binaryOperatorExpression operator="Multiply">
																<primitiveExpression value="-1"/>
																<propertyReferenceExpression name="PictureLifespan"/>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<comment>4. delete sys/oauth2/tokens of this user that have expired</comment>
									<methodInvokeExpression methodName="AddRange">
										<target>
											<variableReferenceExpression name="filesToDelete"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="AppDataSearch">
												<target>
													<propertyReferenceExpression  name="App"/>
												</target>
												<parameters>
													<primitiveExpression value="sys/oauth2/tokens/%"/>
													<primitiveExpression value="%.json"/>
													<primitiveExpression value="3"/>
													<methodInvokeExpression methodName="AddMinutes">
														<target>
															<propertyReferenceExpression name="UtcNow">
																<typeReferenceExpression type="DateTime"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<binaryOperatorExpression operator="Multiply">
																<primitiveExpression value="-1"/>
																<methodInvokeExpression methodName="GetAccessTokenDuration">
																	<target>
																		<propertyReferenceExpression name="App"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="server.rest.authorization.oauth2.accessTokenDuration"/>
																	</parameters>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<foreachStatement>
										<variable name="filename"/>
										<target>
											<variableReferenceExpression name="filesToDelete"/>
										</target>
										<statements>
											<methodInvokeExpression methodName="AppDataDelete">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<variableReferenceExpression name="filename"/>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</foreachStatement>
								</statements>
							</memberMethod>
							<!-- public EnsureRequiredField(JObject, string, string, string) -->
							<memberMethod name="EnsureRequiredField">
								<attributes public="true" static="true"/>
								<parameters>
									<parameter type="JObject" name="payload"/>
									<parameter type="System.String" name="field"/>
									<parameter type="System.String" name="error"/>
									<parameter type="System.String" name="description"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="token">
										<init>
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="payload"/>
												</target>
												<indices>
													<argumentReferenceExpression name="field"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanOr">
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="token"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Type">
														<variableReferenceExpression name="token"/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="Null">
														<typeReferenceExpression type="JTokenType"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="error"/>
													<argumentReferenceExpression name="description"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthPostToken(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthPostToken">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="grantType">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="grant_type"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="clientId">
										<init>
											<convertExpression to="String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="client_id"/>
													</indices>
												</arrayIndexerExpression>
											</convertExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="clientSecret">
										<init>
											<convertExpression to="String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="client_secret"/>
													</indices>
												</arrayIndexerExpression>
											</convertExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="scopeListAdjusted">
										<init>
											<methodInvokeExpression methodName="ScopeListFrom">
												<parameters>
													<argumentReferenceExpression name="payload"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="JObject" name="tokenRequest" var="false">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="refreshTokenRotation">
										<init>
											<primitiveExpression value="false"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<variableReferenceExpression name="grantType"/>
												<primitiveExpression value="authorization_code"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="EnsureRequiredField">
												<parameters>
													<argumentReferenceExpression name="payload"/>
													<primitiveExpression value="code"/>
													<primitiveExpression value="invalid_grant"/>
													<primitiveExpression value="Field 'code' is expected in the body."/>
												</parameters>
											</methodInvokeExpression>
											<variableDeclarationStatement name="authRequestFileName">
												<init>
													<methodInvokeExpression methodName="OAuth2FileName">
														<parameters>
															<primitiveExpression value="codes"/>
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="payload"/>
																</target>
																<indices>
																	<primitiveExpression value="code"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<variableReferenceExpression name="tokenRequest"/>
												<methodInvokeExpression methodName="ReadOAuth2Data">
													<parameters>
														<variableReferenceExpression name="authRequestFileName"/>
														<primitiveExpression value="null"/>
														<primitiveExpression value="invalid_grant"/>
														<primitiveExpression value="The authorization code is invalid."/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
											<comment>validate the request</comment>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueInequality">
														<variableReferenceExpression name="clientId"/>
														<convertExpression to="String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="tokenRequest"/>
																</target>
																<indices>
																	<primitiveExpression value="client_id"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_client"/>
															<primitiveExpression value="Invalid 'client_id' value is specified."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueInequality">
														<convertExpression to="String">
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="payload"/>
																</target>
																<indices>
																	<primitiveExpression value="redirect_uri"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
														<convertExpression to="String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="tokenRequest"/>
																</target>
																<indices>
																	<primitiveExpression value="redirect_uri"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_argument"/>
															<primitiveExpression value="Invalid 'request_uri' value is specified."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<convertExpression to="Boolean">
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="tokenRequest"/>
																</target>
																<indices>
																	<primitiveExpression value="client_secret_required"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="clientSecret"/>
														</unaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_client"/>
															<primitiveExpression value="Field 'client_secret' is required."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="clientSecret"/>
														</unaryOperatorExpression>
														<binaryOperatorExpression operator="ValueInequality">
															<convertExpression to="String">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="tokenRequest"/>
																	</target>
																	<indices>
																		<primitiveExpression value="client_secret"/>
																	</indices>
																</arrayIndexerExpression>
															</convertExpression>
															<methodInvokeExpression methodName="ToUrlEncodedToken">
																<target>
																	<typeReferenceExpression type="TextUtility"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="clientSecret"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_client"/>
															<primitiveExpression value="Invalid 'client_secret' value is specified."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="Count">
															<variableReferenceExpression name="scopeListAdjusted"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_scope"/>
															<primitiveExpression value="The scope cannot be changed when exchanging the authorization code for the access token."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<variableDeclarationStatement name="codeVerifier">
												<init>
													<convertExpression to="String">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="payload"/>
															</target>
															<indices>
																<primitiveExpression value="code_verifier"/>
															</indices>
														</arrayIndexerExpression>
													</convertExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="codeChallenge">
												<init>
													<convertExpression to="String">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="tokenRequest"/>
															</target>
															<indices>
																<primitiveExpression value="code_challenge"/>
															</indices>
														</arrayIndexerExpression>
													</convertExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="codeChallengeMethod">
												<init>
													<convertExpression to="String">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="tokenRequest"/>
															</target>
															<indices>
																<primitiveExpression value="code_challenge_method"/>
															</indices>
														</arrayIndexerExpression>
													</convertExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<variableReferenceExpression name="codeChallengeMethod"/>
														<primitiveExpression value="S256"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="codeVerifier"/>
														<methodInvokeExpression methodName="ToUrlEncodedToken">
															<target>
																<typeReferenceExpression type="TextUtility"/>
															</target>
															<parameters>
																<variableReferenceExpression name="codeVerifier"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<convertExpression to="Boolean">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="tokenRequest"/>
																</target>
																<indices>
																	<primitiveExpression value="code_verifier_required"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="codeVerifier"/>
														</unaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_argument"/>
															<primitiveExpression value="Field 'code_verifier' is required."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="codeVerifier"/>
														</unaryOperatorExpression>
														<binaryOperatorExpression operator="ValueInequality">
															<variableReferenceExpression name="codeVerifier"/>
															<variableReferenceExpression name="codeChallenge"/>
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
															<primitiveExpression value="Invalid 'code_verifier' value is specified."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<methodInvokeExpression methodName="AppDataDelete">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<variableReferenceExpression name="authRequestFileName"/>
												</parameters>
											</methodInvokeExpression>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="LessThan">
														<methodInvokeExpression methodName="AddMinutes">
															<target>
																<methodInvokeExpression methodName="Parse">
																	<target>
																		<typeReferenceExpression type="DateTime"/>
																	</target>
																	<parameters>
																		<castExpression targetType="System.String">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="tokenRequest"/>
																				</target>
																				<indices>
																					<primitiveExpression value="date"/>
																				</indices>
																			</arrayIndexerExpression>
																		</castExpression>
																	</parameters>
																</methodInvokeExpression>
															</target>
															<parameters>
																<propertyReferenceExpression name="AuthorizationCodeLifespan"/>
															</parameters>
														</methodInvokeExpression>
														<propertyReferenceExpression name="UtcNow">
															<typeReferenceExpression type="DateTime"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_grant"/>
															<primitiveExpression value="The authorization code has expired."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<variableReferenceExpression name="grantType"/>
												<primitiveExpression value="refresh_token"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="EnsureRequiredField">
												<parameters>
													<argumentReferenceExpression name="payload"/>
													<primitiveExpression value="refresh_token"/>
													<primitiveExpression value="invalid_grant"/>
													<primitiveExpression value="Field 'refresh_token' is expected in the body."/>
												</parameters>
											</methodInvokeExpression>
											<variableDeclarationStatement name="refreshRequestFileName">
												<init>
													<methodInvokeExpression methodName="OAuth2FileName">
														<parameters>
															<primitiveExpression value="tokens/%"/>
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="payload"/>
																</target>
																<indices>
																	<primitiveExpression value="refresh_token"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<variableReferenceExpression name="tokenRequest"/>
												<methodInvokeExpression methodName="ReadOAuth2Data">
													<parameters>
														<variableReferenceExpression name="refreshRequestFileName"/>
														<primitiveExpression value="null"/>
														<primitiveExpression value="invalid_grant"/>
														<primitiveExpression value="The refresh token is invalid."/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueInequality">
														<variableReferenceExpression name="clientId"/>
														<convertExpression to="String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="tokenRequest"/>
																</target>
																<indices>
																	<primitiveExpression value="client_id"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_client"/>
															<primitiveExpression value="Invalid 'client_id' value is specified."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<convertExpression to="Boolean">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="tokenRequest"/>
																</target>
																<indices>
																	<primitiveExpression value="client_secret_required"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="clientSecret"/>
														</unaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_client"/>
															<primitiveExpression value="Parameter 'client_secret' is required."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="clientSecret"/>
														</unaryOperatorExpression>
														<binaryOperatorExpression operator="ValueInequality">
															<methodInvokeExpression methodName="ToUrlEncodedToken">
																<target>
																	<typeReferenceExpression type="TextUtility"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="clientSecret"/>
																</parameters>
															</methodInvokeExpression>
															<castExpression targetType="System.String">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="tokenRequest"/>
																	</target>
																	<indices>
																		<primitiveExpression value="client_secret"/>
																	</indices>
																</arrayIndexerExpression>
															</castExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_client"/>
															<primitiveExpression value="Invalid 'client_secret' is specified."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<comment>validate the refresh token</comment>
											<variableDeclarationStatement name="authTicket">
												<init>
													<methodInvokeExpression methodName="Decrypt">
														<target>
															<typeReferenceExpression type="FormsAuthentication"/>
														</target>
														<parameters>
															<castExpression targetType="System.String">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="tokenRequest"/>
																	</target>
																	<indices>
																		<primitiveExpression value="token"/>
																	</indices>
																</arrayIndexerExpression>
															</castExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueInequality">
														<propertyReferenceExpression name="UserData">
															<variableReferenceExpression name="authTicket"/>
														</propertyReferenceExpression>
														<primitiveExpression value="REFRESHONLY"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_grant"/>
															<primitiveExpression value="The access token cannot be used to refresh."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<assignStatement>
												<variableReferenceExpression name="refreshTokenRotation"/>
												<convertExpression to="Boolean">
													<methodInvokeExpression methodName="SettingsProperty">
														<target>
															<typeReferenceExpression type="ApplicationServicesBase"/>
														</target>
														<parameters>
															<primitiveExpression value="server.rest.authorization.oauth2.refreshTokenRotation"/>
															<primitiveExpression value="true"/>
														</parameters>
													</methodInvokeExpression>
												</convertExpression>
											</assignStatement>
											<variableDeclarationStatement name="refreshTokenExpired">
												<init>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="ValidateTicket">
															<target>
																<propertyReferenceExpression name="App"/>
															</target>
															<parameters>
																<variableReferenceExpression name="authTicket"/>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
												</init>
											</variableDeclarationStatement>
											<comment>delete the refresh token from the persistent storage</comment>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanOr">
														<variableReferenceExpression name="refreshTokenRotation"/>
														<variableReferenceExpression name="refreshTokenExpired"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="AppDataDelete">
														<target>
															<propertyReferenceExpression name="App"/>
														</target>
														<parameters>
															<variableReferenceExpression name="refreshRequestFileName"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<comment>delete the related access token from the persistent storage</comment>
											<methodInvokeExpression methodName="AppDataDelete">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="OAuth2FileName">
														<parameters>
															<primitiveExpression value="tokens/%"/>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="tokenRequest"/>
																</target>
																<indices>
																	<primitiveExpression value="related_token"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
											<comment>ensure that the token has not expired</comment>
											<conditionStatement>
												<condition>
													<variableReferenceExpression name="refreshTokenExpired"/>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_grant"/>
															<primitiveExpression value="The refresh token has expired."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<comment>adjust the scope list by reducing the number of avaialble scopes to those specified in the payload</comment>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="Count">
															<variableReferenceExpression name="scopeListAdjusted"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement name="tokenScopeList">
														<init>
															<methodInvokeExpression methodName="ScopeListFrom">
																<parameters>
																	<variableReferenceExpression name="tokenRequest"/>
																</parameters>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<variableDeclarationStatement name="newScopeList">
														<init>
															<objectCreateExpression type="List">
																<typeArguments>
																	<typeReference type="System.String"/>
																</typeArguments>
																<parameters>
																	<variableReferenceExpression name="tokenScopeList"/>
																</parameters>
															</objectCreateExpression>
														</init>
													</variableDeclarationStatement>
													<foreachStatement>
														<variable name="tokenScope"/>
														<target>
															<variableReferenceExpression name="tokenScopeList"/>
														</target>
														<statements>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="Not">
																		<methodInvokeExpression methodName="Contains">
																			<target>
																				<variableReferenceExpression name="scopeListAdjusted"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="tokenScope"/>
																			</parameters>
																		</methodInvokeExpression>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<methodInvokeExpression methodName="Remove">
																		<target>
																			<variableReferenceExpression name="newScopeList"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="tokenScope"/>
																		</parameters>
																	</methodInvokeExpression>
																</trueStatements>
															</conditionStatement>
														</statements>
													</foreachStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="tokenRequest"/>
															</target>
															<indices>
																<primitiveExpression value="scope"/>
															</indices>
														</arrayIndexerExpression>
														<methodInvokeExpression methodName="Join">
															<target>
																<typeReferenceExpression type="System.String"/>
															</target>
															<parameters>
																<primitiveExpression value=" "/>
																<variableReferenceExpression name="newScopeList"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<comment>validate the user</comment>
									<variableDeclarationStatement name="user">
										<init>
											<methodInvokeExpression methodName="GetUser">
												<target>
													<typeReferenceExpression type="Membership"/>
												</target>
												<parameters>
													<convertExpression to="String">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="tokenRequest"/>
															</target>
															<indices>
																<primitiveExpression value="username"/>
															</indices>
														</arrayIndexerExpression>
													</convertExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="user"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="invalid_user"/>
													<primitiveExpression value="The user account does not exist."/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<propertyReferenceExpression name="IsApproved">
													<variableReferenceExpression name="user"/>
												</propertyReferenceExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="invalid_user"/>
													<primitiveExpression value="The user account is not approved."/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="IsLockedOut">
												<variableReferenceExpression name="user"/>
											</propertyReferenceExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="invalid_user"/>
													<primitiveExpression value="The user account is locked."/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>create the response with the access and refresh tokens</comment>
									<variableDeclarationStatement name="ticket">
										<init>
											<methodInvokeExpression methodName="CreateTicket">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<variableReferenceExpression name="user"/>
													<primitiveExpression value="null"/>
													<primitiveExpression value="server.rest.authorization.oauth2.accessTokenDuration"/>
													<primitiveExpression value="server.rest.authorization.oauth2.refreshTokenDuration"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="tokenChars">
										<init>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-._~+]]></xsl:attribute>
											</primitiveExpression>
										</init>
									</variableDeclarationStatement>
									<comment>do not include "/" in the token</comment>
									<variableDeclarationStatement name="accessToken">
										<init>
											<methodInvokeExpression methodName="GetUniqueKey">
												<target>
													<typeReferenceExpression type="TextUtility"/>
												</target>
												<parameters>
													<variableReferenceExpression name="AccessTokenSize"/>
													<variableReferenceExpression name="tokenChars"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="result"/>
											</target>
											<indices>
												<primitiveExpression value="access_token"/>
											</indices>
										</arrayIndexerExpression>
										<variableReferenceExpression name="accessToken"/>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="result"/>
											</target>
											<indices>
												<primitiveExpression value="expires_in"/>
											</indices>
										</arrayIndexerExpression>
										<binaryOperatorExpression operator="Multiply">
											<primitiveExpression value="60"/>
											<methodInvokeExpression methodName="GetAccessTokenDuration">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<primitiveExpression value="server.rest.authorization.oauth2.accessTokenDuration"/>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="result"/>
											</target>
											<indices>
												<primitiveExpression value="token_type"/>
											</indices>
										</arrayIndexerExpression>
										<primitiveExpression value="Bearer"/>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="tokenRequest"/>
											</target>
											<indices>
												<primitiveExpression value="token"/>
											</indices>
										</arrayIndexerExpression>
										<propertyReferenceExpression name="AccessToken">
											<variableReferenceExpression name="ticket"/>
										</propertyReferenceExpression>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="tokenRequest"/>
											</target>
											<indices>
												<primitiveExpression value="token_type"/>
											</indices>
										</arrayIndexerExpression>
										<primitiveExpression value="access"/>
									</assignStatement>
									<methodInvokeExpression methodName="Remove">
										<target>
											<variableReferenceExpression name="tokenRequest"/>
										</target>
										<parameters>
											<primitiveExpression value="related_token"/>
										</parameters>
									</methodInvokeExpression>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="tokenRequest"/>
											</target>
											<indices>
												<primitiveExpression value="token_issued"/>
											</indices>
										</arrayIndexerExpression>
										<methodInvokeExpression methodName="ToString">
											<target>
												<propertyReferenceExpression name="UtcNow">
													<typeReferenceExpression type="DateTime"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<primitiveExpression value="o"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<comment>create 'id_token'</comment>
									<variableDeclarationStatement name="idClaims">
										<init>
											<methodInvokeExpression methodName="EnumerateIdClaims">
												<parameters>
													<variableReferenceExpression name="grantType"/>
													<variableReferenceExpression name="user"/>
													<variableReferenceExpression name="tokenRequest"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="idClaims"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Count">
														<variableReferenceExpression name="idClaims"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="id_token"/>
													</indices>
												</arrayIndexerExpression>
												<methodInvokeExpression methodName="CreateJwt">
													<target>
														<typeReferenceExpression type="TextUtility"/>
													</target>
													<parameters>
														<variableReferenceExpression name="idClaims"/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="tokenRequest"/>
													</target>
													<indices>
														<primitiveExpression value="id_token"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="idClaims"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<comment>create 'access_token'</comment>
									<methodInvokeExpression methodName="AppDataWriteAllText">
										<target>
											<propertyReferenceExpression name="App"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="OAuth2FileName">
												<parameters>
													<stringFormatExpression>
														<xsl:attribute name="format"><![CDATA[tokens/{0}/access]]></xsl:attribute>
														<methodInvokeExpression methodName="UrlEncode">
															<target>
																<typeReferenceExpression type="HttpUtility"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="UserName">
																	<variableReferenceExpression name="user"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</stringFormatExpression>
													<variableReferenceExpression name="accessToken"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="ToString">
												<target>
													<variableReferenceExpression name="tokenRequest"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<comment>create 'refresh_token'</comment>
									<variableDeclarationStatement name="refreshTokenDuration">
										<init>
											<methodInvokeExpression methodName="GetAccessTokenDuration">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<primitiveExpression value="server.rest.authorization.oauth2.refreshTokenDuration"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="GreaterThan">
													<variableReferenceExpression name="refreshTokenDuration"/>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="grantType"/>
															<primitiveExpression value="authorization_code"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="BooleanOr">
															<convertExpression to="Boolean">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="tokenRequest"/>
																	</target>
																	<indices>
																		<primitiveExpression value="trusted"/>
																	</indices>
																</arrayIndexerExpression>
															</convertExpression>
															<methodInvokeExpression methodName="Contains">
																<target>
																	<methodInvokeExpression methodName="ScopeListFrom">
																		<parameters>
																			<variableReferenceExpression name="tokenRequest"/>
																		</parameters>
																	</methodInvokeExpression>
																</target>
																<parameters>
																	<primitiveExpression value="offline_access"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
													<variableReferenceExpression name="refreshTokenRotation"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="refreshToken">
												<init>
													<methodInvokeExpression methodName="GetUniqueKey">
														<target>
															<typeReferenceExpression type="TextUtility"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="RefreshTokenSize"/>
															<variableReferenceExpression name="tokenChars"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="refresh_token"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="refreshToken"/>
											</assignStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="tokenRequest"/>
													</target>
													<indices>
														<primitiveExpression value="token"/>
													</indices>
												</arrayIndexerExpression>
												<propertyReferenceExpression name="RefreshToken">
													<variableReferenceExpression name="ticket"/>
												</propertyReferenceExpression>
											</assignStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="tokenRequest"/>
													</target>
													<indices>
														<primitiveExpression value="token_type"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="refresh"/>
											</assignStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="tokenRequest"/>
													</target>
													<indices>
														<primitiveExpression value="related_token"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="accessToken"/>
											</assignStatement>
											<methodInvokeExpression methodName="Remove">
												<target>
													<variableReferenceExpression name="tokenRequest"/>
												</target>
												<parameters>
													<primitiveExpression value="id_token"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="AppDataWriteAllText">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="OAuth2FileName">
														<parameters>
															<stringFormatExpression>
																<xsl:attribute name="format"><![CDATA[tokens/{0}/refresh]]></xsl:attribute>
																<methodInvokeExpression methodName="UrlEncode">
																	<target>
																		<typeReferenceExpression type="HttpUtility"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="UserName">
																			<variableReferenceExpression name="user"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</stringFormatExpression>
															<variableReferenceExpression name="refreshToken"/>
														</parameters>
													</methodInvokeExpression>
													<methodInvokeExpression methodName="ToString">
														<target>
															<variableReferenceExpression name="tokenRequest"/>
														</target>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement name="scope">
										<init>
											<convertExpression to="String">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="tokenRequest"/>
													</target>
													<indices>
														<primitiveExpression value="scope"/>
													</indices>
												</arrayIndexerExpression>
											</convertExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="scope"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="scope"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="scope"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthPostRevoke(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthPostRevoke">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="clientId">
										<init>
											<convertExpression to="String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="client_id"/>
													</indices>
												</arrayIndexerExpression>
											</convertExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="clientSecret">
										<init>
											<convertExpression to="String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="client_secret"/>
													</indices>
												</arrayIndexerExpression>
											</convertExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="tokenRequest">
										<init>
											<methodInvokeExpression methodName="ReadOAuth2Data">
												<parameters>
													<methodInvokeExpression methodName="OAuth2FileName">
														<parameters>
															<primitiveExpression value="%"/>
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="payload"/>
																</target>
																<indices>
																	<primitiveExpression value="token"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</methodInvokeExpression>
													<primitiveExpression value="null"/>
													<primitiveExpression value="invalid_grant"/>
													<primitiveExpression value="Invalid or expired token is specified."/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<comment>validate the request</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueInequality">
												<variableReferenceExpression name="clientId"/>
												<convertExpression to="String">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="tokenRequest"/>
														</target>
														<indices>
															<primitiveExpression value="client_id"/>
														</indices>
													</arrayIndexerExpression>
												</convertExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="invalid_client"/>
													<primitiveExpression value="Invalid 'client_id' value is specified."/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<convertExpression to="Boolean">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="tokenRequest"/>
														</target>
														<indices>
															<primitiveExpression value="client_secret_required"/>
														</indices>
													</arrayIndexerExpression>
												</convertExpression>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="clientSecret"/>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="invalid_client"/>
													<primitiveExpression value="Field 'client_secret' is required."/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="clientSecret"/>
												</unaryOperatorExpression>
												<binaryOperatorExpression operator="ValueInequality">
													<convertExpression to="String">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="tokenRequest"/>
															</target>
															<indices>
																<primitiveExpression value="client_secret"/>
															</indices>
														</arrayIndexerExpression>
													</convertExpression>
													<methodInvokeExpression methodName="ToUrlEncodedToken">
														<target>
															<typeReferenceExpression type="TextUtility"/>
														</target>
														<parameters>
															<variableReferenceExpression name="clientSecret"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="invalid_client"/>
													<primitiveExpression value="Invalid 'client_secret' value is specified."/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<comment>delete the token and the related token if any</comment>
									<methodInvokeExpression methodName="AppDataDelete">
										<target>
											<propertyReferenceExpression name="App"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="OAuth2FileName">
												<parameters>
													<primitiveExpression value="%"/>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="payload"/>
														</target>
														<indices>
															<primitiveExpression value="token"/>
														</indices>
													</arrayIndexerExpression>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement name="relatedToken">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="tokenRequest"/>
													</target>
													<indices>
														<primitiveExpression value="related_token"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="relatedToken"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="AppDataDelete">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="OAuth2FileName">
														<parameters>
															<primitiveExpression value="%"/>
															<variableReferenceExpression name="relatedToken"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method BearerAuthroizationHeader() -->
							<memberMethod returnType="System.String" name="BearerAuthorizationHeader">
								<attributes public="true" final="true"/>
								<statements>
									<variableDeclarationStatement name="authorization">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Headers">
														<propertyReferenceExpression name="Request">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
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
											<binaryOperatorExpression operator="BooleanOr">
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="authorization"/>
												</unaryOperatorExpression>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="StartsWith">
														<target>
															<variableReferenceExpression name="authorization"/>
														</target>
														<parameters>
															<primitiveExpression value="Bearer "/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="403"/>
													<primitiveExpression value="unauthorized"/>
													<primitiveExpression value="Specify an access token in the Bearer 'Authorization' header."/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Substring">
											<target>
												<variableReferenceExpression name="authorization"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Length">
													<primitiveExpression value="Bearer "/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthGetUserInfoPictures(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthGetUserInfoPictures">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="type">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="type"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="filename">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="filename"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="MembershipUser" name="user" var="false">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<variableReferenceExpression name="filename"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="authorization">
												<init>
													<methodInvokeExpression methodName="BearerAuthorizationHeader"/>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="accessToken">
												<init>
													<methodInvokeExpression methodName="ReadOAuth2Data">
														<parameters>
															<primitiveExpression value="tokens/%"/>
															<variableReferenceExpression name="authorization"/>
															<primitiveExpression value="invalid_token"/>
															<primitiveExpression value="Invalid or expired access token."/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<variableReferenceExpression name="user"/>
												<methodInvokeExpression methodName="GetUser">
													<target>
														<typeReferenceExpression type="Membership"/>
													</target>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
										<falseStatements>
											<variableDeclarationStatement name="picture">
												<init>
													<methodInvokeExpression methodName="ReadOAuth2Data">
														<parameters>
															<primitiveExpression value="pictures/%"/>
															<methodInvokeExpression methodName="GetFileNameWithoutExtension">
																<target>
																	<typeReferenceExpression type="Path"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="filename"/>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression value="invalid_path"/>
															<stringFormatExpression>
																<xsl:attribute name="format"><![CDATA[User picture {0} '{1}' does not exist.]]></xsl:attribute>
																<variableReferenceExpression name="type"/>
																<variableReferenceExpression name="filename"/>
															</stringFormatExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<variableReferenceExpression name="user"/>
												<methodInvokeExpression methodName="GetUser">
													<target>
														<typeReferenceExpression type="Membership"/>
													</target>
													<parameters>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="picture"/>
																</target>
																<indices>
																	<primitiveExpression value="username"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="user"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="404"/>
															<primitiveExpression value="invalid_path"/>
															<primitiveExpression value="The user does not exist."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</falseStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.Byte[]" name="imageData" var="false">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="imageContentType" var="false">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="TryGetUserImage">
													<parameters>
														<variableReferenceExpression name="user"/>
														<variableReferenceExpression name="type"/>
														<directionExpression direction="Out">
															<variableReferenceExpression name="imageData"/>
														</directionExpression>
														<directionExpression direction="Out">
															<variableReferenceExpression name="imageContentType"/>
														</directionExpression>
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
													<primitiveExpression value="404"/>
													<primitiveExpression value="invalid_path"/>
													<primitiveExpression value="User photo does not exist."/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement name="response">
										<init>
											<propertyReferenceExpression name="Response">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentType">
											<variableReferenceExpression name="response"/>
										</propertyReferenceExpression>
										<variableReferenceExpression name="imageContentType"/>
									</assignStatement>
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
									<methodInvokeExpression methodName="SetMaxAge">
										<target>
											<propertyReferenceExpression name="Cache">
												<variableReferenceExpression name="response"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<methodInvokeExpression methodName="FromMinutes">
												<target>
													<typeReferenceExpression type="TimeSpan"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="PictureLifespan"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Write">
										<target>
											<propertyReferenceExpression name="OutputStream">
												<variableReferenceExpression name="response"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<variableReferenceExpression name="imageData"/>
											<primitiveExpression value="0"/>
											<propertyReferenceExpression name="Length">
												<variableReferenceExpression name="imageData"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="End">
										<target>
											<variableReferenceExpression name="response"/>
										</target>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method TryGetUserImage(MembershipUser, string, out byte[], out string) -->
							<memberMethod returnType="System.Boolean" name="TryGetUserImage">
								<attributes public="true" static="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
									<parameter type="System.String" name="type"/>
									<parameter type="System.Byte[]" name="data" direction="Out"/>
									<parameter type="System.String" name="contentType" direction="Out"/>
								</parameters>
								<statements>
									<assignStatement>
										<argumentReferenceExpression name="data"/>
										<primitiveExpression value="null"/>
									</assignStatement>
									<assignStatement>
										<argumentReferenceExpression name="contentType"/>
										<primitiveExpression value="null"/>
									</assignStatement>
									<variableDeclarationStatement name="app">
										<init>
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="url">
										<init>
											<methodInvokeExpression methodName="UserPictureUrl">
												<target>
													<variableReferenceExpression name="app"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="user"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="url"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="request">
												<init>
													<methodInvokeExpression methodName="Create">
														<target>
															<typeReferenceExpression type="WebRequest"/>
														</target>
														<parameters>
															<variableReferenceExpression name="url"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<usingStatement>
												<variable name="imageResponse">
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
														<variable name="stream">
															<init>
																<methodInvokeExpression methodName="GetResponseStream">
																	<target>
																		<variableReferenceExpression name="imageResponse"/>
																	</target>
																</methodInvokeExpression>
															</init>
														</variable>
														<statements>
															<usingStatement>
																<variable name="ms">
																	<init>
																		<objectCreateExpression type="MemoryStream"/>
																	</init>
																</variable>
																<statements>
																	<assignStatement>
																		<argumentReferenceExpression name="contentType"/>
																		<propertyReferenceExpression name="ContentType">
																			<variableReferenceExpression name="imageResponse"/>
																		</propertyReferenceExpression>
																	</assignStatement>
																	<assignStatement>
																		<variableReferenceExpression name="data"/>
																		<methodInvokeExpression methodName="ToArray">
																			<target>
																				<variableReferenceExpression name="ms"/>
																			</target>
																		</methodInvokeExpression>
																	</assignStatement>
																</statements>
															</usingStatement>
														</statements>
													</usingStatement>
												</statements>
											</usingStatement>
										</trueStatements>
										<falseStatements>
											<assignStatement>
												<variableReferenceExpression name="url"/>
												<methodInvokeExpression methodName="UserPictureFilePath">
													<target>
														<variableReferenceExpression name="app"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="user"/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="url"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<argumentReferenceExpression name="data"/>
														<methodInvokeExpression methodName="ReadAllBytes">
															<target>
																<typeReferenceExpression type="File"/>
															</target>
															<parameters>
																<variableReferenceExpression name="url"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
													<assignStatement>
														<argumentReferenceExpression name="contentType"/>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="image/"/>
															<methodInvokeExpression methodName="Substring">
																<target>
																	<methodInvokeExpression methodName="GetExtension">
																		<target>
																			<typeReferenceExpression type="Path"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="url"/>
																		</parameters>
																	</methodInvokeExpression>
																</target>
																<parameters>
																	<primitiveExpression value="1"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</falseStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityEquality">
													<argumentReferenceExpression name="data"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<propertyReferenceExpression name="IsSiteContentEnabled">
													<typeReferenceExpression type="ApplicationServicesBase"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="list">
												<init>
													<methodInvokeExpression methodName="ReadSiteContent">
														<target>
															<variableReferenceExpression name="app"/>
														</target>
														<parameters>
															<primitiveExpression value="sys/users"/>
															<binaryOperatorExpression operator="Add">
																<propertyReferenceExpression name="UserName">
																	<argumentReferenceExpression name="user"/>
																</propertyReferenceExpression>
																<primitiveExpression value=".%"/>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<foreachStatement>
												<variable name="file"/>
												<target>
													<variableReferenceExpression name="list"/>
												</target>
												<statements>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="BooleanAnd">
																<methodInvokeExpression methodName="StartsWith">
																	<target>
																		<propertyReferenceExpression name="ContentType">
																			<variableReferenceExpression name="file"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="image/"/>
																	</parameters>
																</methodInvokeExpression>
																<binaryOperatorExpression operator="IdentityInequality">
																	<propertyReferenceExpression name="Data">
																		<variableReferenceExpression name="file"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<argumentReferenceExpression  name="data"/>
																<propertyReferenceExpression name="Data">
																	<variableReferenceExpression name="file"/>
																</propertyReferenceExpression>
															</assignStatement>
															<assignStatement>
																<argumentReferenceExpression name="contentType"/>
																<propertyReferenceExpression name="ContentType">
																	<argumentReferenceExpression name="file"/>
																</propertyReferenceExpression>
															</assignStatement>
															<breakStatement/>
														</trueStatements>
													</conditionStatement>
												</statements>
											</foreachStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<argumentReferenceExpression name="data"/>
												<primitiveExpression value="null"/>
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
											<binaryOperatorExpression operator="ValueEquality">
												<argumentReferenceExpression name="type"/>
												<primitiveExpression value="thumbnail"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="img">
												<init>
													<castExpression targetType="Image">
														<methodInvokeExpression methodName="ConvertFrom">
															<target>
																<objectCreateExpression type="ImageConverter"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="data"/>
															</parameters>
														</methodInvokeExpression>
													</castExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="thumbnailSize">
												<init>
													<primitiveExpression value="96"/>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanOr">
														<binaryOperatorExpression operator="GreaterThan">
															<propertyReferenceExpression name="Width">
																<variableReferenceExpression name="img"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="thumbnailSize"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="GreaterThan">
															<propertyReferenceExpression name="Height">
																<variableReferenceExpression name="img"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="thumbnailSize"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement name="scale">
														<init>
															<binaryOperatorExpression operator="Divide">
																<castExpression targetType="System.Single">
																	<propertyReferenceExpression name="Width">
																		<variableReferenceExpression name="img"/>
																	</propertyReferenceExpression>
																</castExpression>
																<variableReferenceExpression name="thumbnailSize"/>
															</binaryOperatorExpression>
														</init>
													</variableDeclarationStatement>
													<variableDeclarationStatement name="height">
														<init>
															<castExpression targetType="System.Int32">
																<binaryOperatorExpression operator="Divide">
																	<propertyReferenceExpression name="Height">
																		<variableReferenceExpression name="img"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="scale"/>
																</binaryOperatorExpression>
															</castExpression>
														</init>
													</variableDeclarationStatement>
													<variableDeclarationStatement name="width">
														<init>
															<variableReferenceExpression name="thumbnailSize"/>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="LessThan">
																<propertyReferenceExpression name="Height">
																	<variableReferenceExpression name="img"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Width">
																	<variableReferenceExpression name="img"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="scale"/>
																<binaryOperatorExpression operator="Divide">
																	<castExpression targetType="System.Single">
																		<propertyReferenceExpression name="Height">
																			<variableReferenceExpression name="img"/>
																		</propertyReferenceExpression>
																	</castExpression>
																	<variableReferenceExpression name="thumbnailSize"/>
																</binaryOperatorExpression>
															</assignStatement>
															<assignStatement>
																<variableReferenceExpression name="height"/>
																<variableReferenceExpression name="thumbnailSize"/>
															</assignStatement>
															<assignStatement>
																<variableReferenceExpression name="width"/>
																<castExpression targetType="System.Int32">
																	<binaryOperatorExpression operator="Divide">
																		<propertyReferenceExpression name="Width">
																			<variableReferenceExpression name="img"/>
																		</propertyReferenceExpression>
																		<variableReferenceExpression name="scale"/>
																	</binaryOperatorExpression>
																</castExpression>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<variableDeclarationStatement name="originalImg">
														<init>
															<variableReferenceExpression name="img"/>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="GreaterThan">
																<variableReferenceExpression name="height"/>
																<variableReferenceExpression name="width"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="width"/>
																<castExpression targetType="System.Int32">
																	<binaryOperatorExpression operator="Multiply">
																		<castExpression targetType="System.Single">
																			<variableReferenceExpression name="width"/>
																		</castExpression>
																		<binaryOperatorExpression operator="Divide">
																			<castExpression targetType="System.Single">
																				<variableReferenceExpression name="thumbnailSize"/>
																			</castExpression>
																			<castExpression targetType="System.Single">
																				<variableReferenceExpression name="height"/>
																			</castExpression>
																		</binaryOperatorExpression>
																	</binaryOperatorExpression>
																</castExpression>
															</assignStatement>
															<assignStatement>
																<variableReferenceExpression name="height"/>
																<variableReferenceExpression name="thumbnailSize"/>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<assignStatement>
														<variableReferenceExpression name="img"/>
														<methodInvokeExpression methodName="ResizeImage">
															<target>
																<typeReferenceExpression type="Blob"/>
															</target>
															<parameters>
																<variableReferenceExpression name="img"/>
																<variableReferenceExpression name="width"/>
																<variableReferenceExpression name="height"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
													<methodInvokeExpression methodName="Dispose">
														<target>
															<variableReferenceExpression name="originalImg"/>
														</target>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<usingStatement>
												<variable name="output">
													<init>
														<objectCreateExpression type="MemoryStream"/>
													</init>
												</variable>
												<statements>
													<variableDeclarationStatement name="encoderParams">
														<init>
															<objectCreateExpression type="System.Drawing.Imaging.EncoderParameters">
																<parameters>
																	<primitiveExpression value="1"/>
																</parameters>
															</objectCreateExpression>
														</init>
													</variableDeclarationStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Param">
																	<variableReferenceExpression name="encoderParams"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="0"/>
															</indices>
														</arrayIndexerExpression>
														<objectCreateExpression type="System.Drawing.Imaging.EncoderParameter">
															<parameters>
																<propertyReferenceExpression name="Quality">
																	<typeReferenceExpression type="System.Drawing.Imaging.Encoder"/>
																</propertyReferenceExpression>
																<convertExpression to="Int64">
																	<variableReferenceExpression name="85"/>
																</convertExpression>
															</parameters>
														</objectCreateExpression>
													</assignStatement>
													<methodInvokeExpression methodName="Save">
														<target>
															<variableReferenceExpression name="img"/>
														</target>
														<parameters>
															<variableReferenceExpression name="output"/>
															<methodInvokeExpression methodName="ImageFormatToEncoder">
																<target>
																	<typeReferenceExpression type="Blob"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Jpeg">
																		<typeReferenceExpression type="System.Drawing.Imaging.ImageFormat"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
															<variableReferenceExpression name="encoderParams"/>
														</parameters>
													</methodInvokeExpression>
													<assignStatement>
														<argumentReferenceExpression name="data"/>
														<methodInvokeExpression methodName="ToArray">
															<target>
																<variableReferenceExpression name="output"/>
															</target>
														</methodInvokeExpression>
													</assignStatement>
													<assignStatement>
														<argumentReferenceExpression name="contentType"/>
														<primitiveExpression value="image/jpeg"/>
													</assignStatement>
												</statements>
											</usingStatement>
											<methodInvokeExpression methodName="Dispose">
												<target>
													<variableReferenceExpression name="img"/>
												</target>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<primitiveExpression value="true"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthPostUserInfo(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthPostUserInfo">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="authorization">
										<init>
											<methodInvokeExpression methodName="BearerAuthorizationHeader"/>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="accessToken">
										<init>
											<methodInvokeExpression methodName="ReadOAuth2Data">
												<parameters>
													<primitiveExpression value="tokens/%"/>
													<variableReferenceExpression name="authorization"/>
													<primitiveExpression value="invalid_token"/>
													<primitiveExpression value="Invalid or expired access token."/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="claims">
										<init>
											<methodInvokeExpression methodName="EnumerateIdClaims">
												<parameters>
													<primitiveExpression value="authorization_code"/>
													<methodInvokeExpression methodName="GetUser">
														<target>
															<typeReferenceExpression type="Membership"/>
														</target>
													</methodInvokeExpression>
													<variableReferenceExpression name="accessToken"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="claims"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="BooleanOr">
													<convertExpression to="Boolean">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="accessToken"/>
															</target>
															<indices>
																<primitiveExpression value="trusted"/>
															</indices>
														</arrayIndexerExpression>
													</convertExpression>
													<methodInvokeExpression methodName="Contains">
														<target>
															<methodInvokeExpression methodName="ScopeListFrom">
																<parameters>
																	<variableReferenceExpression name="accessToken"/>
																</parameters>
															</methodInvokeExpression>
														</target>
														<parameters>
															<primitiveExpression value="offline_access"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<foreachStatement>
												<variable name="p"/>
												<target>
													<methodInvokeExpression methodName="Properties">
														<target>
															<variableReferenceExpression name="claims"/>
														</target>
													</methodInvokeExpression>
												</target>
												<statements>
													<conditionStatement>
														<condition>
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression methodName="IsMatch">
																	<target>
																		<typeReferenceExpression  type="Regex"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="p"/>
																		</propertyReferenceExpression>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[^(aud|azp|exp|iat|iss)$]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
														</condition>
														<trueStatements>
															<methodInvokeExpression methodName="Add">
																<target>
																	<argumentReferenceExpression name="result"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="p"/>
																</parameters>
															</methodInvokeExpression>
														</trueStatements>
													</conditionStatement>
												</statements>
											</foreachStatement>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthGetTokenInfo(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthGetTokenInfo">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="idToken">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="id_token"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="ValidateJwt">
												<target>
													<typeReferenceExpression type="TextUtility"/>
												</target>
												<parameters>
													<variableReferenceExpression name="idToken"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="claims">
												<init>
													<methodInvokeExpression methodName="ParseYamlOrJson">
														<target>
															<typeReferenceExpression type="TextUtility"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="GetString">
																<target>
																	<propertyReferenceExpression name="UTF8">
																		<typeReferenceExpression type="Encoding"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<methodInvokeExpression methodName="FromBase64UrlEncoded">
																		<target>
																			<typeReferenceExpression type="TextUtility"/>
																		</target>
																		<parameters>
																			<arrayIndexerExpression>
																				<target>
																					<methodInvokeExpression methodName="Split">
																						<target>
																							<variableReferenceExpression name="idToken"/>
																						</target>
																						<parameters>
																							<primitiveExpression value="." convertTo="Char"/>
																						</parameters>
																					</methodInvokeExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="1"/>
																				</indices>
																			</arrayIndexerExpression>
																		</parameters>
																	</methodInvokeExpression>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="exp">
												<init>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="claims"/>
														</target>
														<indices>
															<primitiveExpression value="exp"/>
														</indices>
													</arrayIndexerExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="exp"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="AddFirst">
														<target>
															<variableReferenceExpression name="claims"/>
														</target>
														<parameters>
															<objectCreateExpression type="JProperty">
																<parameters>
																	<primitiveExpression value="active"/>
																	<binaryOperatorExpression operator="LessThan">
																		<methodInvokeExpression methodName="ToUnixTimeSeconds">
																			<target>
																				<propertyReferenceExpression name="UtcNow">
																					<typeReferenceExpression type="DateTimeOffset"/>
																				</propertyReferenceExpression>
																			</target>
																		</methodInvokeExpression>
																		<convertExpression to="Int64">
																			<variableReferenceExpression name="exp"/>
																		</convertExpression>
																	</binaryOperatorExpression>
																</parameters>
															</objectCreateExpression>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<foreachStatement>
												<variable name="p"/>
												<target>
													<methodInvokeExpression methodName="Properties">
														<target>
															<variableReferenceExpression name="claims"/>
														</target>
													</methodInvokeExpression>
												</target>
												<statements>
													<methodInvokeExpression methodName="Add">
														<target>
															<argumentReferenceExpression name="result"/>
														</target>
														<parameters>
															<variableReferenceExpression name="p"/>
														</parameters>
													</methodInvokeExpression>
												</statements>
											</foreachStatement>
											<variableDeclarationStatement name="jose">
												<init>
													<methodInvokeExpression methodName="ParseYamlOrJson">
														<target>
															<typeReferenceExpression type="TextUtility"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="GetString">
																<target>
																	<propertyReferenceExpression name="UTF8">
																		<typeReferenceExpression type="Encoding"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<methodInvokeExpression methodName="FromBase64UrlEncoded">
																		<target>
																			<typeReferenceExpression type="TextUtility"/>
																		</target>
																		<parameters>
																			<arrayIndexerExpression>
																				<target>
																					<methodInvokeExpression methodName="Split">
																						<target>
																							<variableReferenceExpression name="idToken"/>
																						</target>
																						<parameters>
																							<primitiveExpression value="." convertTo="Char"/>
																						</parameters>
																					</methodInvokeExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="0"/>
																				</indices>
																			</arrayIndexerExpression>
																		</parameters>
																	</methodInvokeExpression>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="alg"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="jose"/>
													</target>
													<indices>
														<primitiveExpression value="alg"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
										<falseStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="invalid_token"/>
													<primitiveExpression value="The token specified in 'id_token' parameter is invalid."/>
												</parameters>
											</methodInvokeExpression>
										</falseStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ReadOAuth2Data(string, string, string, string) -->
							<memberMethod returnType="JObject" name="ReadOAuth2Data">
								<attributes family="true"/>
								<parameters>
									<parameter type="System.String" name="path"/>
									<parameter type="System.Object" name="id"/>
									<parameter type="System.String" name="error"/>
									<parameter type="System.String" name="errorDescription"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<argumentReferenceExpression name="id"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<argumentReferenceExpression name="path"/>
												<methodInvokeExpression methodName="OAuth2FileName">
													<parameters>
														<argumentReferenceExpression name="path"/>
														<argumentReferenceExpression name="id"/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement name="data">
										<init>
											<methodInvokeExpression methodName="AppDataReadAllText">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="path"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="data"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="error"/>
													<argumentReferenceExpression name="errorDescription"/>
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
												<variableReferenceExpression name="data"/>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method ScopeListFrom(JObject) -->
							<memberMethod returnType="List" name="ScopeListFrom">
								<typeArguments>
									<typeReference type="System.String"/>
								</typeArguments>
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="context"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="scope">
										<init>
											<convertExpression to="String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="context"/>
													</target>
													<indices>
														<primitiveExpression value="scope"/>
													</indices>
												</arrayIndexerExpression>
											</convertExpression>
										</init>
									</variableDeclarationStatement>
									<methodReturnStatement>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
											<parameters>
												<methodInvokeExpression methodName="Split">
													<target>
														<variableReferenceExpression name="scope"/>
													</target>
													<parameters>
														<arrayCreateExpression>
															<createType type="System.Char"/>
															<initializers>
																<primitiveExpression value=" " convertTo="Char"/>
																<primitiveExpression value="," convertTo="Char"/>
															</initializers>
														</arrayCreateExpression>
														<propertyReferenceExpression name="RemoveEmptyEntries">
															<typeReferenceExpression type="StringSplitOptions"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</objectCreateExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method TrimScopesIn(JObject) -->
							<memberMethod returnType="System.Boolean" name="TrimScopesIn">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="context"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="changed">
										<init>
											<primitiveExpression value="false"/>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="scopeList">
										<init>
											<methodInvokeExpression methodName="ScopeListFrom">
												<parameters>
													<argumentReferenceExpression name="context"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="user">
										<init>
											<propertyReferenceExpression name="User">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="IsAuthenticated">
												<propertyReferenceExpression name="Identity">
													<argumentReferenceExpression name="user"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="appScopes">
												<init>
													<methodInvokeExpression methodName="ApplicationScopes"/>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="stdScopes">
												<init>
													<methodInvokeExpression methodName="StandardScopes"/>
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
															<variableReferenceExpression name="scopeList"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</test>
												<statements>
													<variableDeclarationStatement name="scope">
														<init>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="scopeList"/>
																</target>
																<indices>
																	<variableReferenceExpression name="i"/>
																</indices>
															</arrayIndexerExpression>
														</init>
													</variableDeclarationStatement>
													<variableDeclarationStatement name="scopeDef">
														<init>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="appScopes"/>
																</target>
																<indices>
																	<variableReferenceExpression name="scope"/>
																</indices>
															</arrayIndexerExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="IdentityInequality">
																<variableReferenceExpression name="scopeDef"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<variableDeclarationStatement name="roles">
																<init>
																	<methodInvokeExpression methodName="Split">
																		<target>
																			<convertExpression to="String">
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="scopeDef"/>
																					</target>
																					<indices>
																						<primitiveExpression value="role"/>
																					</indices>
																				</arrayIndexerExpression>
																			</convertExpression>
																		</target>
																		<parameters>
																			<arrayCreateExpression>
																				<createType type="System.Char"/>
																				<initializers>
																					<primitiveExpression value=" " convertTo="Char"/>
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
																	<binaryOperatorExpression operator="GreaterThan">
																		<propertyReferenceExpression name="Length">
																			<variableReferenceExpression name="roles"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="0"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<conditionStatement>
																		<condition>
																			<methodInvokeExpression methodName="UserIsInRole">
																				<target>
																					<typeReferenceExpression type="DataControllerBase"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="roles"/>
																				</parameters>
																			</methodInvokeExpression>
																		</condition>
																		<trueStatements>
																			<assignStatement>
																				<variableReferenceExpression name="i"/>
																				<binaryOperatorExpression operator="Add">
																					<variableReferenceExpression name="i"/>
																					<primitiveExpression value="1"/>
																				</binaryOperatorExpression>
																			</assignStatement>
																		</trueStatements>
																		<falseStatements>
																			<assignStatement>
																				<variableReferenceExpression name="changed"/>
																				<primitiveExpression value="true"/>
																			</assignStatement>
																			<methodInvokeExpression methodName="RemoveAt">
																				<target>
																					<variableReferenceExpression name="scopeList"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="i"/>
																				</parameters>
																			</methodInvokeExpression>
																		</falseStatements>
																	</conditionStatement>
																</trueStatements>
																<falseStatements>
																	<assignStatement>
																		<variableReferenceExpression name="i"/>
																		<binaryOperatorExpression operator="Add">
																			<variableReferenceExpression name="i"/>
																			<primitiveExpression value="1"/>
																		</binaryOperatorExpression>
																	</assignStatement>
																</falseStatements>
															</conditionStatement>
														</trueStatements>
														<falseStatements>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="IdentityEquality">
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="stdScopes"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="scope"/>
																			</indices>
																		</arrayIndexerExpression>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<variableReferenceExpression name="changed"/>
																		<primitiveExpression value="true"/>
																	</assignStatement>
																	<methodInvokeExpression methodName="RemoveAt">
																		<target>
																			<variableReferenceExpression name="scopeList"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="i"/>
																		</parameters>
																	</methodInvokeExpression>
																</trueStatements>
																<falseStatements>
																	<assignStatement>
																		<variableReferenceExpression name="i"/>
																		<binaryOperatorExpression operator="Add">
																			<variableReferenceExpression name="i"/>
																			<primitiveExpression value="1"/>
																		</binaryOperatorExpression>
																	</assignStatement>
																</falseStatements>
															</conditionStatement>
														</falseStatements>
													</conditionStatement>
												</statements>
											</whileStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<variableReferenceExpression name="changed"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="context"/>
													</target>
													<indices>
														<primitiveExpression value="scope"/>
													</indices>
												</arrayIndexerExpression>
												<methodInvokeExpression methodName="Join">
													<target>
														<typeReferenceExpression type="System.String"/>
													</target>
													<parameters>
														<primitiveExpression value=" "/>
														<variableReferenceExpression name="scopeList"/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="changed"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method EnumerateIdClaims(string, MembershipUser, JObject) -->
							<memberMethod returnType="JObject" name="EnumerateIdClaims">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="grantType"/>
									<parameter type="MembershipUser" name="user"/>
									<parameter type="JObject" name="context"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="IdTokenDuration"/>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="ValueEquality">
														<argumentReferenceExpression name="grantType"/>
														<primitiveExpression value="authorization_code"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="ValueEquality">
															<argumentReferenceExpression name="grantType"/>
															<primitiveExpression value="refresh_token"/>
														</binaryOperatorExpression>
														<convertExpression to="Boolean">
															<methodInvokeExpression methodName="SettingsProperty">
																<target>
																	<typeReferenceExpression type="ApplicationServices"/>
																</target>
																<parameters>
																	<primitiveExpression value="server.rest.authorization.oauth2.idTokenRefresh"/>
																	<primitiveExpression value="true"/>
																</parameters>
															</methodInvokeExpression>
														</convertExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="scopeList">
												<init>
													<methodInvokeExpression methodName="ScopeListFrom">
														<parameters>
															<argumentReferenceExpression name="context"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="clientId">
												<init>
													<convertExpression to="String">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="context"/>
															</target>
															<indices>
																<primitiveExpression value="client_id"/>
															</indices>
														</arrayIndexerExpression>
													</convertExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="claims">
												<init>
													<objectCreateExpression type="JObject"/>
												</init>
											</variableDeclarationStatement>
											<comment>"openid" scope</comment>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="scopeList"/>
														</target>
														<parameters>
															<primitiveExpression value="openid"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="iss"/>
															</indices>
														</arrayIndexerExpression>
														<methodInvokeExpression methodName="ResolveClientUrl">
															<target>
																<typeReferenceExpression type="ApplicationServicesBase"/>
															</target>
															<parameters>
																<primitiveExpression value="~/oauth2/v2"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="azp"/>
															</indices>
														</arrayIndexerExpression>
														<variableReferenceExpression name="clientId"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="aud"/>
															</indices>
														</arrayIndexerExpression>
														<methodInvokeExpression methodName="ResolveClientUrl">
															<target>
																<typeReferenceExpression type="ApplicationServicesBase"/>
															</target>
															<parameters>
																<primitiveExpression value="~/v2"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="sub"/>
															</indices>
														</arrayIndexerExpression>
														<methodInvokeExpression methodName="FromObject">
															<target>
																<typeReferenceExpression type="JToken"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="ProviderUserKey">
																	<argumentReferenceExpression name="user"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="iat"/>
															</indices>
														</arrayIndexerExpression>
														<methodInvokeExpression methodName="ToUnixTimeSeconds">
															<target>
																<propertyReferenceExpression name="UtcNow">
																	<typeReferenceExpression type="DateTimeOffset"/>
																</propertyReferenceExpression>
															</target>
														</methodInvokeExpression>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="exp"/>
															</indices>
														</arrayIndexerExpression>
														<methodInvokeExpression methodName="ToUnixTimeSeconds">
															<target>
																<methodInvokeExpression methodName="AddMinutes">
																	<target>
																		<propertyReferenceExpression name="UtcNow">
																			<typeReferenceExpression type="DateTimeOffset"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="IdTokenDuration"/>
																	</parameters>
																</methodInvokeExpression>
															</target>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
												<falseStatements>
													<methodReturnStatement>
														<primitiveExpression value="null"/>
													</methodReturnStatement>
												</falseStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="scopeList"/>
														</target>
														<parameters>
															<primitiveExpression value="email"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="email"/>
															</indices>
														</arrayIndexerExpression>
														<propertyReferenceExpression name="Email">
															<argumentReferenceExpression name="user"/>
														</propertyReferenceExpression>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="email_verified"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="true"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<comment>"profile" scope</comment>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="scopeList"/>
														</target>
														<parameters>
															<primitiveExpression value="profile"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="name"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="given_name"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="family_name"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="middle_name"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="nickname"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="preferred_username"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="profile"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="picture"/>
															</indices>
														</arrayIndexerExpression>
														<methodInvokeExpression methodName="ToPictureClaim">
															<parameters>
																<argumentReferenceExpression name="user"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueEquality">
																<propertyReferenceExpression name="OAuth"/>
																<primitiveExpression value="userinfo"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<variableDeclarationStatement name="picture">
																<init>
																	<castExpression targetType="System.String">
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="claims"/>
																			</target>
																			<indices>
																				<primitiveExpression value="picture"/>
																			</indices>
																		</arrayIndexerExpression>
																	</castExpression>
																</init>
															</variableDeclarationStatement>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<variableReferenceExpression name="picture"/>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="claims"/>
																			</target>
																			<indices>
																				<primitiveExpression value="picture_thumbnail"/>
																			</indices>
																		</arrayIndexerExpression>
																		<methodInvokeExpression methodName="ResolveClientUrl">
																			<target>
																				<typeReferenceExpression type="ApplicationServicesBase"/>
																			</target>
																			<parameters>
																				<stringFormatExpression>
																					<xsl:attribute name="format"><![CDATA[~/oauth2/v2/userinfo/pictures/thumbnail/{0}.jpeg]]></xsl:attribute>
																					<methodInvokeExpression methodName="GetFileNameWithoutExtension">
																						<target>
																							<typeReferenceExpression type="Path"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="picture"/>
																						</parameters>
																					</methodInvokeExpression>
																				</stringFormatExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																</trueStatements>
															</conditionStatement>
														</trueStatements>
													</conditionStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="gender"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="birthdate"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="zoneinfo"/>
															</indices>
														</arrayIndexerExpression>
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="context"/>
															</target>
															<indices>
																<primitiveExpression value="timezone"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="locale"/>
															</indices>
														</arrayIndexerExpression>
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="context"/>
															</target>
															<indices>
																<primitiveExpression value="locale"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="updated_at"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<comment>"address" scope</comment>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="scopeList"/>
														</target>
														<parameters>
															<primitiveExpression value="address"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement name="address">
														<init>
															<objectCreateExpression type="JObject"/>
														</init>
													</variableDeclarationStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="address"/>
															</indices>
														</arrayIndexerExpression>
														<variableReferenceExpression name="address"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="address"/>
															</target>
															<indices>
																<primitiveExpression value="formatted"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="address"/>
															</target>
															<indices>
																<primitiveExpression value="street_address"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="address"/>
															</target>
															<indices>
																<primitiveExpression value="locality"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="address"/>
															</target>
															<indices>
																<primitiveExpression value="region"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="address"/>
															</target>
															<indices>
																<primitiveExpression value="postal_code"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="address"/>
															</target>
															<indices>
																<primitiveExpression value="country"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<comment>"phone" scope</comment>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="scopeList"/>
														</target>
														<parameters>
															<primitiveExpression value="phone"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="phone_number"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="phone_number_verified"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="false"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="Count">
															<variableReferenceExpression name="scopeList"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="claims"/>
															</target>
															<indices>
																<primitiveExpression value="scope"/>
															</indices>
														</arrayIndexerExpression>
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="context"/>
															</target>
															<indices>
																<primitiveExpression value="scope"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<methodInvokeExpression methodName="EnumerateIdClaims">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="user"/>
													<variableReferenceExpression name="claims"/>
													<variableReferenceExpression name="scopeList"/>
												</parameters>
											</methodInvokeExpression>
											<methodReturnStatement>
												<variableReferenceExpression name="claims"/>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<primitiveExpression value="null"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method ToPictureClaim(MembershipUser) -->
							<memberMethod returnType="System.String" name="ToPictureClaim">
								<attributes public="true" final="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<tryStatement>
										<statements>
											<variableDeclarationStatement name="pictureData">
												<init>
													<methodInvokeExpression methodName="AppDataReadAllText">
														<target>
															<propertyReferenceExpression name="App"/>
														</target>
														<parameters>
															<stringFormatExpression>
																<xsl:attribute name="format"><![CDATA[sys/oauth2/pictures/{0}/%.json]]></xsl:attribute>
																<methodInvokeExpression methodName="UrlEncode">
																	<target>
																		<typeReferenceExpression type="HttpUtility"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="UserName">
																			<argumentReferenceExpression name="user"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</stringFormatExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="JObject" name="picture" var="false">
												<init>
													<primitiveExpression value="null"/>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="pictureData"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="picture"/>
														<methodInvokeExpression methodName="ParseYamlOrJson">
															<target>
																<typeReferenceExpression type="TextUtility"/>
															</target>
															<parameters>
																<variableReferenceExpression name="pictureData"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="IdentityInequality">
															<variableReferenceExpression name="picture"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="LessThan">
															<methodInvokeExpression methodName="AddMinutes">
																<target>
																	<methodInvokeExpression methodName="Parse">
																		<target>
																			<typeReferenceExpression type="DateTime"/>
																		</target>
																		<parameters>
																			<castExpression targetType="System.String">
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="picture"/>
																					</target>
																					<indices>
																						<primitiveExpression value="date"/>
																					</indices>
																				</arrayIndexerExpression>
																			</castExpression>
																		</parameters>
																	</methodInvokeExpression>
																</target>
																<parameters>
																	<propertyReferenceExpression name="PictureLifespan"/>
																</parameters>
															</methodInvokeExpression>
															<propertyReferenceExpression name="UtcNow">
																<typeReferenceExpression type="DateTime"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="AppDataDelete">
														<target>
															<propertyReferenceExpression name="App"/>
														</target>
														<parameters>
															<stringFormatExpression>
																<xsl:attribute name="format"><![CDATA[sys/oauth2/pictures/%/{0}.json]]></xsl:attribute>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="picture"/>
																	</target>
																	<indices>
																		<primitiveExpression value="id"/>
																	</indices>
																</arrayIndexerExpression>
															</stringFormatExpression>
														</parameters>
													</methodInvokeExpression>
													<assignStatement>
														<variableReferenceExpression name="pictureData"/>
														<primitiveExpression value="null"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="pictureData"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement type="System.Byte[]" name="imageData" var="false">
														<init>
															<primitiveExpression value="null"/>
														</init>
													</variableDeclarationStatement>
													<variableDeclarationStatement type="System.String" name="imageContentType" var="false">
														<init>
															<primitiveExpression value="null"/>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="TryGetUserImage">
																<parameters>
																	<argumentReferenceExpression name="user"/>
																	<primitiveExpression value="original"/>
																	<directionExpression direction="Out">
																		<variableReferenceExpression name="imageData"/>
																	</directionExpression>
																	<directionExpression direction="Out">
																		<variableReferenceExpression name="imageContentType"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="picture"/>
																<objectCreateExpression type="JObject"/>
															</assignStatement>
															<assignStatement>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="picture"/>
																	</target>
																	<indices>
																		<primitiveExpression value="username"/>
																	</indices>
																</arrayIndexerExpression>
																<propertyReferenceExpression name="UserName">
																	<argumentReferenceExpression name="user"/>
																</propertyReferenceExpression>
															</assignStatement>
															<assignStatement>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="picture"/>
																	</target>
																	<indices>
																		<primitiveExpression value="id"/>
																	</indices>
																</arrayIndexerExpression>
																<methodInvokeExpression methodName="ToUrlEncodedToken">
																	<target>
																		<typeReferenceExpression type="TextUtility"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="ToString">
																			<target>
																				<methodInvokeExpression methodName="NewGuid">
																					<target>
																						<typeReferenceExpression type="Guid"/>
																					</target>
																				</methodInvokeExpression>
																			</target>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
															<assignStatement>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="picture"/>
																	</target>
																	<indices>
																		<primitiveExpression value="date"/>
																	</indices>
																</arrayIndexerExpression>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<propertyReferenceExpression name="UtcNow">
																			<typeReferenceExpression type="DateTime"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="o"/>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
															<assignStatement>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="picture"/>
																	</target>
																	<indices>
																		<primitiveExpression value="contentType"/>
																	</indices>
																</arrayIndexerExpression>
																<variableReferenceExpression name="imageContentType"/>
															</assignStatement>
															<assignStatement>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="picture"/>
																	</target>
																	<indices>
																		<primitiveExpression value="extension"/>
																	</indices>
																</arrayIndexerExpression>
																<arrayIndexerExpression>
																	<target>
																		<methodInvokeExpression methodName="Split">
																			<target>
																				<castExpression targetType="System.String">
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="picture"/>
																						</target>
																						<indices>
																							<primitiveExpression value="contentType"/>
																						</indices>
																					</arrayIndexerExpression>
																				</castExpression>
																			</target>
																			<parameters>
																				<primitiveExpression value="/" convertTo="Char"/>
																			</parameters>
																		</methodInvokeExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="1"/>
																	</indices>
																</arrayIndexerExpression>
															</assignStatement>
															<assignStatement>
																<variableReferenceExpression name="pictureData"/>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<variableReferenceExpression name="picture"/>
																	</target>
																</methodInvokeExpression>
															</assignStatement>
															<methodInvokeExpression methodName="AppDataWriteAllText">
																<target>
																	<propertyReferenceExpression name="App"/>
																</target>
																<parameters>
																	<stringFormatExpression>
																		<xsl:attribute name="format"><![CDATA[sys/oauth2/pictures/{0}/{1}.json]]></xsl:attribute>
																		<methodInvokeExpression methodName="UrlEncode">
																			<target>
																				<typeReferenceExpression type="HttpUtility"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="UserName">
																					<argumentReferenceExpression name="user"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="picture"/>
																			</target>
																			<indices>
																				<primitiveExpression value="id"/>
																			</indices>
																		</arrayIndexerExpression>
																	</stringFormatExpression>
																	<variableReferenceExpression name="pictureData"/>
																</parameters>
															</methodInvokeExpression>
														</trueStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="picture"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodReturnStatement>
														<methodInvokeExpression methodName="ResolveClientUrl">
															<target>
																<typeReferenceExpression type="ApplicationServicesBase"/>
															</target>
															<parameters>
																<stringFormatExpression>
																	<xsl:attribute name="format"><![CDATA[~/oauth2/v2/userinfo/pictures/original/{0}.{1}]]></xsl:attribute>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="picture"/>
																		</target>
																		<indices>
																			<primitiveExpression value="id"/>
																		</indices>
																	</arrayIndexerExpression>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="picture"/>
																		</target>
																		<indices>
																			<primitiveExpression value="extension"/>
																		</indices>
																	</arrayIndexerExpression>
																</stringFormatExpression>
															</parameters>
														</methodInvokeExpression>
													</methodReturnStatement>
												</trueStatements>
												<falseStatements>
													<methodReturnStatement>
														<primitiveExpression value="null"/>
													</methodReturnStatement>
												</falseStatements>
											</conditionStatement>
										</statements>
										<catch exceptionType="Exception" localName="ex">
											<methodReturnStatement>
												<propertyReferenceExpression name="Message">
													<variableReferenceExpression name="ex"/>
												</propertyReferenceExpression>
											</methodReturnStatement>
										</catch>
									</tryStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthPostAuthClient(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthPostAuthClient">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="appReg">
										<init>
											<objectCreateExpression type="JObject"/>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="ExecuteOAuthGetAppsSingleton">
										<parameters>
											<argumentReferenceExpression name="schema"/>
											<argumentReferenceExpression name="payload"/>
											<variableReferenceExpression name="appReg"/>
											<primitiveExpression value="invalid_client"/>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement name="links">
										<init>
											<methodInvokeExpression methodName="CreateLinks">
												<parameters>
													<argumentReferenceExpression name="result"/>
													<primitiveExpression value="true"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="inputSchema">
										<init>
											<castExpression targetType="JObject">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="schema"/>
													</target>
													<indices>
														<primitiveExpression value="_input"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<comment>produce the "mobile" authorization response</comment>
									<variableDeclarationStatement name="authorizeLinkInfo">
										<init>
											<methodInvokeExpression methodName="Match">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="OAuthMethodName"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[post/auth/(pkce|spa|server)]]></xsl:attribute>
													</primitiveExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="authorizeLinkInfo"/>
											</propertyReferenceExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="isPKCE">
												<init>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="authorizeLinkInfo"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="1"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
														<primitiveExpression value="pkce"/>
													</binaryOperatorExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="isServer">
												<init>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="authorizeLinkInfo"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="1"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
														<primitiveExpression value="server"/>
													</binaryOperatorExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<variableReferenceExpression name="isServer"/>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="isPKCE"/>
														<primitiveExpression value="true"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<variableDeclarationStatement name="state">
												<init>
													<castExpression targetType="System.String">
														<methodInvokeExpression methodName="GetPropertyValue">
															<parameters>
																<argumentReferenceExpression name="payload"/>
																<primitiveExpression value="state"/>
																<variableReferenceExpression name="inputSchema"/>
															</parameters>
														</methodInvokeExpression>
													</castExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNullOrEmpty">
														<variableReferenceExpression name="state"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="state"/>
														<methodInvokeExpression methodName="GetUniqueKey">
															<target>
																<typeReferenceExpression type="TextUtility"/>
															</target>
															<parameters>
																<primitiveExpression value="16"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="state"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="state"/>
											</assignStatement>
											<variableDeclarationStatement type="System.String" name="codeChallenge" var="false">
												<init>
													<primitiveExpression value="null"/>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="System.String" name="codeChallengeMethod" var="false">
												<init>
													<primitiveExpression value="null"/>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="System.String" name="codeVerifier" var="false">
												<init>
													<primitiveExpression value="null"/>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<variableReferenceExpression name="isPKCE"/>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="codeChallenge"/>
														<castExpression targetType="System.String">
															<methodInvokeExpression methodName="GetPropertyValue">
																<parameters>
																	<argumentReferenceExpression name="payload"/>
																	<primitiveExpression value="code_challenge"/>
																	<variableReferenceExpression name="inputSchema"/>
																</parameters>
															</methodInvokeExpression>
														</castExpression>
													</assignStatement>
													<assignStatement>
														<variableReferenceExpression name="codeChallengeMethod"/>
														<castExpression targetType="System.String">
															<methodInvokeExpression methodName="GetPropertyValue">
																<parameters>
																	<argumentReferenceExpression name="payload"/>
																	<primitiveExpression value="code_challenge_method"/>
																	<variableReferenceExpression name="inputSchema"/>
																</parameters>
															</methodInvokeExpression>
														</castExpression>
													</assignStatement>
													<conditionStatement>
														<condition>
															<unaryOperatorExpression operator="IsNullOrEmpty">
																<variableReferenceExpression name="codeChallengeMethod"/>
															</unaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="codeChallengeMethod"/>
																<primitiveExpression value="S256"/>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<conditionStatement>
														<condition>
															<unaryOperatorExpression operator="IsNullOrEmpty">
																<variableReferenceExpression name="codeChallenge"/>
															</unaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="codeChallenge"/>
																<methodInvokeExpression methodName="GetUniqueKey">
																	<target>
																		<typeReferenceExpression type="TextUtility"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="64"/>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-._~]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<assignStatement>
														<variableReferenceExpression name="codeVerifier"/>
														<variableReferenceExpression name="codeChallenge"/>
													</assignStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueEquality">
																<variableReferenceExpression name="codeChallengeMethod"/>
																<primitiveExpression value="S256"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="codeChallenge"/>
																<methodInvokeExpression methodName="ToUrlEncodedToken">
																	<target>
																		<typeReferenceExpression type="TextUtility"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="codeChallenge"/>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
											<variableDeclarationStatement name="token">
												<init>
													<objectCreateExpression type="JObject"/>
												</init>
											</variableDeclarationStatement>
											<methodInvokeExpression methodName="AddLink">
												<parameters>
													<primitiveExpression value="selfLink"/>
													<primitiveExpression value="POST"/>
													<methodInvokeExpression methodName="CreateLinks">
														<parameters>
															<variableReferenceExpression name="token"/>
														</parameters>
													</methodInvokeExpression>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[{0}/oauth2/v2/token]]></xsl:attribute>
													</primitiveExpression>
													<methodInvokeExpression methodName="ResolveClientUrl">
														<target>
															<typeReferenceExpression type="ApplicationServices"/>
														</target>
														<parameters>
															<primitiveExpression value="~/"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="Add">
												<target>
													<argumentReferenceExpression name="result"/>
												</target>
												<parameters>
													<objectCreateExpression type="JProperty">
														<parameters>
															<primitiveExpression value="token"/>
															<variableReferenceExpression name="token"/>
														</parameters>
													</objectCreateExpression>
												</parameters>
											</methodInvokeExpression>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="token"/>
													</target>
													<indices>
														<primitiveExpression value="grant_type"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="authorization_code"/>
											</assignStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="token"/>
													</target>
													<indices>
														<primitiveExpression value="code"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="null"/>
											</assignStatement>
											<variableDeclarationStatement name="redirectUri">
												<init>
													<convertExpression to="String">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="payload"/>
															</target>
															<indices>
																<primitiveExpression value="redirect_uri"/>
															</indices>
														</arrayIndexerExpression>
													</convertExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="ValueInequality">
															<variableReferenceExpression name="redirectUri"/>
															<convertExpression to="String">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="appReg"/>
																	</target>
																	<indices>
																		<primitiveExpression value="redirect_uri"/>
																	</indices>
																</arrayIndexerExpression>
															</convertExpression>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="ValueInequality">
															<variableReferenceExpression name="redirectUri"/>
															<convertExpression to="String">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="appReg"/>
																	</target>
																	<indices>
																		<primitiveExpression value="local_redirect_uri"/>
																	</indices>
																</arrayIndexerExpression>
															</convertExpression>
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
															<primitiveExpression value="The 'redirect_uri' value does not match the URIs of the client application registration."/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="token"/>
													</target>
													<indices>
														<primitiveExpression value="redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="redirectUri"/>
											</assignStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="token"/>
													</target>
													<indices>
														<primitiveExpression value="client_id"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="client_id"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
											<conditionStatement>
												<condition>
													<variableReferenceExpression name="isServer"/>
												</condition>
												<trueStatements>
													<variableDeclarationStatement name="clientSecret">
														<init>
															<convertExpression to="String">
																<arrayIndexerExpression>
																	<target>
																		<argumentReferenceExpression name="payload"/>
																	</target>
																	<indices>
																		<primitiveExpression value="client_secret"/>
																	</indices>
																</arrayIndexerExpression>
															</convertExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueInequality">
																<variableReferenceExpression name="clientSecret"/>
																<convertExpression to="String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="appReg"/>
																		</target>
																		<indices>
																			<primitiveExpression value="client_secret"/>
																		</indices>
																	</arrayIndexerExpression>
																</convertExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<methodInvokeExpression methodName="ThrowError">
																<target>
																	<typeReferenceExpression type="RESTfulResource"/>
																</target>
																<parameters>
																	<primitiveExpression value="invalid_client"/>
																	<primitiveExpression value="The 'client_secret' value does not match the client application registration."/>
																</parameters>
															</methodInvokeExpression>
														</trueStatements>
													</conditionStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="token"/>
															</target>
															<indices>
																<primitiveExpression value="client_secret"/>
															</indices>
														</arrayIndexerExpression>
														<variableReferenceExpression name="clientSecret"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<variableReferenceExpression name="isPKCE"/>
												</condition>
												<trueStatements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="token"/>
															</target>
															<indices>
																<primitiveExpression value="code_verifier"/>
															</indices>
														</arrayIndexerExpression>
														<variableReferenceExpression name="codeVerifier"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<variableDeclarationStatement name="url">
												<init>
													<objectCreateExpression type="StringBuilder"/>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="clientIdParam">
												<init>
													<methodInvokeExpression methodName="GetPropertyValue">
														<parameters>
															<argumentReferenceExpression name="payload"/>
															<primitiveExpression value="client_id"/>
															<variableReferenceExpression name="inputSchema"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="redirectUriParam">
												<init>
													<methodInvokeExpression methodName="UrlEncode">
														<target>
															<typeReferenceExpression type="HttpUtility"/>
														</target>
														<parameters>
															<castExpression targetType="System.String">
																<methodInvokeExpression methodName="GetPropertyValue">
																	<parameters>
																		<argumentReferenceExpression name="payload"/>
																		<primitiveExpression value="redirect_uri"/>
																		<variableReferenceExpression name="inputSchema"/>
																	</parameters>
																</methodInvokeExpression>
															</castExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="scopeParam">
												<init>
													<methodInvokeExpression methodName="UrlEncode">
														<target>
															<typeReferenceExpression type="HttpUtility"/>
														</target>
														<parameters>
															<castExpression targetType="System.String">
																<methodInvokeExpression methodName="GetPropertyValue">
																	<parameters>
																		<argumentReferenceExpression name="payload"/>
																		<primitiveExpression value="scope"/>
																		<variableReferenceExpression name="inputSchema"/>
																	</parameters>
																</methodInvokeExpression>
															</castExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<methodInvokeExpression methodName="AppendFormat">
												<target>
													<variableReferenceExpression name="url"/>
												</target>
												<parameters>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[{0}/oauth2/v2/auth?response_type=code&client_id={1}&redirect_uri={2}&scope={3}&state={4}]]></xsl:attribute>
													</primitiveExpression>
													<methodInvokeExpression methodName="ResolveClientUrl">
														<target>
															<typeReferenceExpression type="ApplicationServices"/>
														</target>
														<parameters>
															<primitiveExpression value="~/"/>
														</parameters>
													</methodInvokeExpression>
													<variableReferenceExpression name="clientIdParam"/>
													<variableReferenceExpression name="redirectUriParam"/>
													<variableReferenceExpression name="scopeParam"/>
													<methodInvokeExpression methodName="UrlEncode">
														<target>
															<typeReferenceExpression type="HttpUtility"/>
														</target>
														<parameters>
															<variableReferenceExpression name="state"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
											<conditionStatement>
												<condition>
													<variableReferenceExpression name="isPKCE"/>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="AppendFormat">
														<target>
															<variableReferenceExpression name="url"/>
														</target>
														<parameters>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[&code_challenge={0}&code_challenge_method={1}]]></xsl:attribute>
															</primitiveExpression>
															<methodInvokeExpression methodName="UrlEncode">
																<target>
																	<typeReferenceExpression type="HttpUtility"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="codeChallenge"/>
																</parameters>
															</methodInvokeExpression>
															<variableReferenceExpression name="codeChallengeMethod"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<methodInvokeExpression methodName="AddLink">
												<parameters>
													<primitiveExpression value="authorize"/>
													<primitiveExpression value="GET"/>
													<variableReferenceExpression name="links"/>
													<methodInvokeExpression methodName="ToString">
														<target>
															<variableReferenceExpression name="url"/>
														</target>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthAppsValidate(JObject) -->
							<memberMethod name="ExecuteOAuthAppsValidate">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="url">
										<init>
											<convertExpression to="String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
											</convertExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="url"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<tryStatement>
												<statements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="result"/>
															</target>
															<indices>
																<primitiveExpression value="redirect_uri"/>
															</indices>
														</arrayIndexerExpression>
														<propertyReferenceExpression name="AbsoluteUri">
															<objectCreateExpression type="Uri">
																<parameters>
																	<variableReferenceExpression name="url"/>
																</parameters>
															</objectCreateExpression>
														</propertyReferenceExpression>
													</assignStatement>
												</statements>
												<catch exceptionType="Exception" localName="ex">
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_argument"/>
															<binaryOperatorExpression operator="Add">
																<primitiveExpression value="Invalid 'redirect_uri' value. "/>
																<propertyReferenceExpression name="Message">
																	<variableReferenceExpression name="ex"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</catch>
											</tryStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<variableReferenceExpression name="url"/>
										<convertExpression to="String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="result"/>
												</target>
												<indices>
													<primitiveExpression value="local_redirect_uri"/>
												</indices>
											</arrayIndexerExpression>
										</convertExpression>
									</assignStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="url"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<tryStatement>
												<statements>
													<variableDeclarationStatement name="redirectUri">
														<init>
															<objectCreateExpression type="Uri">
																<parameters>
																	<variableReferenceExpression name="url"/>
																</parameters>
															</objectCreateExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression methodName="IsMatch">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Scheme">
																			<variableReferenceExpression name="redirectUri"/>
																		</propertyReferenceExpression>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[^https?$]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
														</condition>
														<trueStatements>
															<throwExceptionStatement>
																<objectCreateExpression type="Exception">
																	<parameters>
																		<primitiveExpression value="Only 'http' and 'https' protocols are allowed."/>
																	</parameters>
																</objectCreateExpression>
															</throwExceptionStatement>
														</trueStatements>
													</conditionStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueInequality">
																<propertyReferenceExpression name="Host">
																	<variableReferenceExpression name="redirectUri"/>
																</propertyReferenceExpression>
																<primitiveExpression value="localhost"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<throwExceptionStatement>
																<objectCreateExpression type="Exception">
																	<parameters>
																		<stringFormatExpression>
																			<xsl:attribute name="format"><![CDATA[Host '{0}' is not allowed. Use 'localhost' instead.]]></xsl:attribute>
																			<propertyReferenceExpression name="Host">
																				<variableReferenceExpression name="redirectUri"/>
																			</propertyReferenceExpression>
																		</stringFormatExpression>
																	</parameters>
																</objectCreateExpression>
															</throwExceptionStatement>
														</trueStatements>
													</conditionStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="result"/>
															</target>
															<indices>
																<primitiveExpression value="local_redirect_uri"/>
															</indices>
														</arrayIndexerExpression>
														<propertyReferenceExpression name="AbsoluteUri">
															<variableReferenceExpression name="redirectUri"/>
														</propertyReferenceExpression>
													</assignStatement>
												</statements>
												<catch exceptionType="Exception" localName="ex">
													<methodInvokeExpression methodName="ThrowError">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<primitiveExpression value="invalid_argument"/>
															<binaryOperatorExpression operator="Add">
																<primitiveExpression value="Invalid 'local_redirect_uri' value. "/>
																<propertyReferenceExpression name="Message">
																	<variableReferenceExpression name="ex"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</catch>
											</tryStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<convertExpression to="Boolean">
													<methodInvokeExpression methodName="SelectToken">
														<target>
															<argumentReferenceExpression name="result"/>
														</target>
														<parameters>
															<primitiveExpression value="authorization.server"/>
														</parameters>
													</methodInvokeExpression>
												</convertExpression>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<castExpression targetType="System.String">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="result"/>
															</target>
															<indices>
																<primitiveExpression value="client_secret"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="client_secret"/>
													</indices>
												</arrayIndexerExpression>
												<methodInvokeExpression methodName="GetUniqueKey">
													<target>
														<typeReferenceExpression type="TextUtility"/>
													</target>
													<parameters>
														<primitiveExpression value="64"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-._~]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthAppsLinks(JObject) -->
							<memberMethod returnType="System.String" name="ExecuteOAuthAppsLinks">
								<attributes family="true"/>
								<parameters>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="clientId">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="client_id"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="resourceLocation">
										<init>
											<binaryOperatorExpression operator="Add">
												<primitiveExpression value="~/oauth2/v2/apps/"/>
												<variableReferenceExpression name="clientId"/>
											</binaryOperatorExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="links">
										<init>
											<methodInvokeExpression methodName="CreateLinks">
												<parameters>
													<argumentReferenceExpression name="result"/>
													<primitiveExpression value="true"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="AddLink">
										<parameters>
											<primitiveExpression value="selfLink"/>
											<primitiveExpression value="GET"/>
											<variableReferenceExpression name="links"/>
											<variableReferenceExpression name="resourceLocation"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="AddLink">
										<parameters>
											<primitiveExpression value="editLink"/>
											<primitiveExpression value="PATCH"/>
											<variableReferenceExpression name="links"/>
											<variableReferenceExpression name="resourceLocation"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="AddLink">
										<parameters>
											<primitiveExpression value="deleteLink"/>
											<primitiveExpression value="DELETE"/>
											<variableReferenceExpression name="links"/>
											<variableReferenceExpression name="resourceLocation"/>
										</parameters>
									</methodInvokeExpression>
									<methodReturnStatement>
										<variableReferenceExpression name="resourceLocation"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthPostApps(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthPostApps">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="clientId">
										<init>
											<methodInvokeExpression methodName="GetUniqueKey">
												<target>
													<typeReferenceExpression type="TextUtility"/>
												</target>
												<parameters>
													<primitiveExpression value="43"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="result"/>
											</target>
											<indices>
												<primitiveExpression value="name"/>
											</indices>
										</arrayIndexerExpression>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="payload"/>
											</target>
											<indices>
												<primitiveExpression value="name"/>
											</indices>
										</arrayIndexerExpression>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="result"/>
											</target>
											<indices>
												<primitiveExpression value="author"/>
											</indices>
										</arrayIndexerExpression>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="payload"/>
											</target>
											<indices>
												<primitiveExpression value="author"/>
											</indices>
										</arrayIndexerExpression>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="result"/>
											</target>
											<indices>
												<primitiveExpression value="client_id"/>
											</indices>
										</arrayIndexerExpression>
										<variableReferenceExpression name="clientId"/>
									</assignStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="client_secret"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="client_secret"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="client_secret"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="result"/>
											</target>
											<indices>
												<primitiveExpression value="redirect_uri"/>
											</indices>
										</arrayIndexerExpression>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="payload"/>
											</target>
											<indices>
												<primitiveExpression value="redirect_uri"/>
											</indices>
										</arrayIndexerExpression>
									</assignStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="local_redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="local_redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="local_redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement name="authorization">
										<init>
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="payload"/>
												</target>
												<indices>
													<primitiveExpression value="authorization"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="authorization"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="404"/>
													<primitiveExpression value="invalid_parameter"/>
													<primitiveExpression value="Field 'authorization' is required."/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="result"/>
											</target>
											<indices>
												<primitiveExpression value="authorization"/>
											</indices>
										</arrayIndexerExpression>
										<variableReferenceExpression name="authorization"/>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="result"/>
											</target>
											<indices>
												<primitiveExpression value="trusted"/>
											</indices>
										</arrayIndexerExpression>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="payload"/>
											</target>
											<indices>
												<primitiveExpression value="trusted"/>
											</indices>
										</arrayIndexerExpression>
									</assignStatement>
									<methodInvokeExpression methodName="ExecuteOAuthAppsValidate">
										<parameters>
											<argumentReferenceExpression name="result"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="AppDataWriteAllText">
										<target>
											<propertyReferenceExpression name="App"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="OAuth2FileName">
												<parameters>
													<primitiveExpression value="apps"/>
													<variableReferenceExpression name="clientId"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="ToString">
												<target>
													<argumentReferenceExpression name="result"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="ExecuteOAuthAppsUpdateCORs">
										<parameters>
											<argumentReferenceExpression name="result"/>
											<objectCreateExpression type="JObject"/>
										</parameters>
									</methodInvokeExpression>
									<assignStatement>
										<propertyReferenceExpression name="StatusCode">
											<propertyReferenceExpression name="Response">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
										<primitiveExpression value="201"/>
									</assignStatement>
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
												<primitiveExpression value="Location"/>
											</indices>
										</arrayIndexerExpression>
										<methodInvokeExpression methodName="ToServiceUrl">
											<parameters>
												<methodInvokeExpression methodName="ExecuteOAuthAppsLinks">
													<parameters>
														<argumentReferenceExpression name="result"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthGetApps(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthGetApps">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="regList">
										<init>
											<methodInvokeExpression methodName="AppDataSearch">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<primitiveExpression value="sys/oauth2/apps"/>
													<primitiveExpression value="%.json"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="collection">
										<init>
											<objectCreateExpression type="JArray"/>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="result"/>
											</target>
											<indices>
												<primitiveExpression value="count"/>
											</indices>
										</arrayIndexerExpression>
										<propertyReferenceExpression name="Length">
											<variableReferenceExpression name="regList"/>
										</propertyReferenceExpression>
									</assignStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="result"/>
											</target>
											<indices>
												<propertyReferenceExpression name="CollectionKey"/>
											</indices>
										</arrayIndexerExpression>
										<variableReferenceExpression name="collection"/>
									</assignStatement>
									<variableDeclarationStatement name="sortedApps">
										<init>
											<objectCreateExpression type="SortedDictionary">
												<typeArguments>
													<typeReference type="System.String"/>
													<typeReference type="JObject"/>
												</typeArguments>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<foreachStatement>
										<variable name="filename"/>
										<target>
											<variableReferenceExpression name="regList"/>
										</target>
										<statements>
											<variableDeclarationStatement name="appReg">
												<init>
													<methodInvokeExpression methodName="ParseYamlOrJson">
														<target>
															<typeReferenceExpression type="TextUtility"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="AppDataReadAllText">
																<target>
																	<propertyReferenceExpression  name="App"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="filename"/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="item">
												<init>
													<objectCreateExpression type="JObject"/>
												</init>
											</variableDeclarationStatement>
											<foreachStatement>
												<variable name="p"/>
												<target>
													<methodInvokeExpression methodName="Properties">
														<target>
															<variableReferenceExpression name="appReg"/>
														</target>
													</methodInvokeExpression>
												</target>
												<statements>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="BooleanAnd">
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="client_secret"/>
																</binaryOperatorExpression>
																<binaryOperatorExpression operator="ValueInequality">
																	<propertyReferenceExpression name="Type">
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="p"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="Null">
																		<typeReferenceExpression type="JTokenType"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<variableDeclarationStatement name="secret">
																<init>
																	<convertExpression to="String">
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="p"/>
																		</propertyReferenceExpression>
																	</convertExpression>
																</init>
															</variableDeclarationStatement>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="GreaterThan">
																		<propertyReferenceExpression name="Length">
																			<variableReferenceExpression name="secret"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="6"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<variableReferenceExpression name="secret"/>
																		<methodInvokeExpression methodName="PadLeft">
																			<target>
																				<methodInvokeExpression methodName="Substring">
																					<target>
																						<variableReferenceExpression name="secret"/>
																					</target>
																					<parameters>
																						<binaryOperatorExpression operator="Subtract">
																							<propertyReferenceExpression name="Length">
																								<variableReferenceExpression name="secret"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="6"/>
																						</binaryOperatorExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</target>
																			<parameters>
																				<binaryOperatorExpression operator="Subtract">
																					<propertyReferenceExpression name="Length">
																						<variableReferenceExpression name="secret"/>
																					</propertyReferenceExpression>
																					<primitiveExpression value="6"/>
																				</binaryOperatorExpression>
																				<primitiveExpression value="*" convertTo="Char"/>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																</trueStatements>
															</conditionStatement>
															<methodInvokeExpression methodName="Add">
																<target>
																	<variableReferenceExpression name="item"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="secret"/>
																</parameters>
															</methodInvokeExpression>
														</trueStatements>
														<falseStatements>
															<methodInvokeExpression methodName="Add">
																<target>
																	<variableReferenceExpression name="item"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="p"/>
																</parameters>
															</methodInvokeExpression>
														</falseStatements>
													</conditionStatement>
												</statements>
											</foreachStatement>
											<variableDeclarationStatement name="itemLinks">
												<init>
													<methodInvokeExpression methodName="CreateLinks">
														<parameters>
															<variableReferenceExpression name="item"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="itemLinks"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="AddLink">
														<parameters>
															<primitiveExpression value="selfLink"/>
															<primitiveExpression value="GET"/>
															<variableReferenceExpression name="itemLinks"/>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[~/oauth2/v2/apps/{0}]]></xsl:attribute>
															</primitiveExpression>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="appReg"/>
																</target>
																<indices>
																	<primitiveExpression value="client_id"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<variableDeclarationStatement name="appName">
												<init>
													<castExpression targetType="System.String">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="item"/>
															</target>
															<indices>
																<primitiveExpression value="name"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="ContainsKey">
														<target>
															<variableReferenceExpression name="sortedApps"/>
														</target>
														<parameters>
															<variableReferenceExpression name="appName"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="appName"/>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="item"/>
																</target>
																<indices>
																	<primitiveExpression value="client_id"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="sortedApps"/>
													</target>
													<indices>
														<variableReferenceExpression name="appName"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="item"/>
											</assignStatement>
										</statements>
									</foreachStatement>
									<foreachStatement>
										<variable name="name"/>
										<target>
											<propertyReferenceExpression name="Keys">
												<variableReferenceExpression name="sortedApps"/>
											</propertyReferenceExpression>
										</target>
										<statements>
											<methodInvokeExpression methodName="Add">
												<target>
													<variableReferenceExpression name="collection"/>
												</target>
												<parameters>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="sortedApps"/>
														</target>
														<indices>
															<variableReferenceExpression name="name"/>
														</indices>
													</arrayIndexerExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</foreachStatement>
									<comment>add links</comment>
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
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="links"/>
												<primitiveExpression value="null"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="AddLink">
												<parameters>
													<primitiveExpression value="selfLink"/>
													<primitiveExpression value="GET"/>
													<variableReferenceExpression name="links"/>
													<primitiveExpression value="~/oauth2/v2/apps"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="AddLink">
												<parameters>
													<primitiveExpression value="createLink"/>
													<primitiveExpression value="POST"/>
													<variableReferenceExpression name="links"/>
													<primitiveExpression value="~/oauth2/v2/apps"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthGetAppsSingleton(JObject, JObject, JObject, string) -->
							<memberMethod name="ExecuteOAuthGetAppsSingleton">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
									<parameter type="System.String" name="error"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<argumentReferenceExpression name="error"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<argumentReferenceExpression name="error"/>
												<primitiveExpression value="invalid_path"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement name="appReg">
										<init>
											<methodInvokeExpression methodName="AppDataReadAllText">
												<target>
													<propertyReferenceExpression name="App"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="OAuth2FileName">
														<parameters>
															<primitiveExpression value="apps"/>
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="payload"/>
																</target>
																<indices>
																	<primitiveExpression value="client_id"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="appReg"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ThrowError">
												<target>
													<typeReferenceExpression type="RESTfulResource"/>
												</target>
												<parameters>
													<primitiveExpression value="404"/>
													<argumentReferenceExpression name="error"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[Client application '{0}' is not registered.]]></xsl:attribute>
													</primitiveExpression>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="payload"/>
														</target>
														<indices>
															<primitiveExpression value="client_id"/>
														</indices>
													</arrayIndexerExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<foreachStatement>
										<variable name="p"/>
										<target>
											<methodInvokeExpression methodName="Properties">
												<target>
													<methodInvokeExpression methodName="ParseYamlOrJson">
														<target>
															<typeReferenceExpression type="TextUtility"/>
														</target>
														<parameters>
															<variableReferenceExpression name="appReg"/>
														</parameters>
													</methodInvokeExpression>
												</target>
											</methodInvokeExpression>
										</target>
										<statements>
											<methodInvokeExpression methodName="Add">
												<target>
													<argumentReferenceExpression name="result"/>
												</target>
												<parameters>
													<variableReferenceExpression name="p"/>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</foreachStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="IsImmutable"/>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ExecuteOAuthAppsLinks">
												<parameters>
													<argumentReferenceExpression name="result"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthDeleteAppsSingleton(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthDeleteAppsSingleton">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="ExecuteOAuthGetAppsSingleton">
										<parameters>
											<argumentReferenceExpression name="schema"/>
											<argumentReferenceExpression name="payload"/>
											<argumentReferenceExpression name="result"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="AppDataDelete">
										<target>
											<propertyReferenceExpression name="App"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="OAuth2FileName">
												<parameters>
													<primitiveExpression value="apps"/>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="payload"/>
														</target>
														<indices>
															<primitiveExpression value="client_id"/>
														</indices>
													</arrayIndexerExpression>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="ExecuteOAuthAppsUpdateCORs">
										<parameters>
											<argumentReferenceExpression name="result"/>
											<argumentReferenceExpression name="result"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="RemoveAll">
										<target>
											<variableReferenceExpression name="result"/>
										</target>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthPatchAppsSingleton(JObject, JObject, JObject) -->
							<memberMethod name="ExecuteOAuthPatchAppsSingleton">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="schema"/>
									<parameter type="JObject" name="payload"/>
									<parameter type="JObject" name="result"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="ExecuteOAuthGetAppsSingleton">
										<parameters>
											<argumentReferenceExpression name="schema"/>
											<argumentReferenceExpression name="payload"/>
											<argumentReferenceExpression name="result"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement name="original">
										<init>
											<methodInvokeExpression methodName="DeepClone">
												<target>
													<argumentReferenceExpression name="result"/>
												</target>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="name"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="name"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="name"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="author"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="author"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="author"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="client_secret"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="client_secret"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="client_secret"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="local_redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="local_redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="local_redirect_uri"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="authorization"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityEquality">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="result"/>
															</target>
															<indices>
																<primitiveExpression value="authorization"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="result"/>
															</target>
															<indices>
																<primitiveExpression value="authorization"/>
															</indices>
														</arrayIndexerExpression>
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="payload"/>
															</target>
															<indices>
																<primitiveExpression value="authorization"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
												</trueStatements>
												<falseStatements>
													<foreachStatement>
														<variable name="p"/>
														<target>
															<methodInvokeExpression methodName="Properties">
																<target>
																	<castExpression targetType="JObject">
																		<arrayIndexerExpression>
																			<target>
																				<argumentReferenceExpression name="payload"/>
																			</target>
																			<indices>
																				<primitiveExpression value="authorization"/>
																			</indices>
																		</arrayIndexerExpression>
																	</castExpression>
																</target>
															</methodInvokeExpression>
														</target>
														<statements>
															<assignStatement>
																<arrayIndexerExpression>
																	<target>
																		<arrayIndexerExpression>
																			<target>
																				<argumentReferenceExpression name="result"/>
																			</target>
																			<indices>
																				<primitiveExpression  value="authorization"/>
																			</indices>
																		</arrayIndexerExpression>
																	</target>
																	<indices>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="p"/>
																		</propertyReferenceExpression>
																	</indices>
																</arrayIndexerExpression>
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="p"/>
																</propertyReferenceExpression>
															</assignStatement>
														</statements>
													</foreachStatement>
												</falseStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="trusted"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="result"/>
													</target>
													<indices>
														<primitiveExpression value="trusted"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="payload"/>
													</target>
													<indices>
														<primitiveExpression value="trusted"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="ExecuteOAuthAppsValidate">
										<parameters>
											<argumentReferenceExpression name="result"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="AppDataWriteAllText">
										<target>
											<propertyReferenceExpression name="App"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="OAuth2FileName">
												<parameters>
													<primitiveExpression value="apps"/>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="result"/>
														</target>
														<indices>
															<primitiveExpression value="client_id"/>
														</indices>
													</arrayIndexerExpression>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="ToString">
												<target>
													<argumentReferenceExpression name="result"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="ExecuteOAuthAppsLinks">
										<parameters>
											<argumentReferenceExpression name="result"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="ExecuteOAuthAppsUpdateCORs">
										<parameters>
											<argumentReferenceExpression name="result"/>
											<castExpression targetType="JObject">
												<variableReferenceExpression name="original"/>
											</castExpression>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method ExecuteOAuthAppsUpdateCORs(JObject, JObject) -->
							<memberMethod name="ExecuteOAuthAppsUpdateCORs">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="appReg"/>
									<parameter type="JObject" name="appRegOriginal"/>
								</parameters>
								<statements>
									<foreachStatement>
										<variable name="propName"/>
										<target>
											<arrayCreateExpression>
												<createType type="System.String"/>
												<initializers>
													<primitiveExpression value="redirect_uri"/>
													<primitiveExpression value="local_redirect_uri"/>
												</initializers>
											</arrayCreateExpression>
										</target>
										<statements>
											<variableDeclarationStatement name="redirectUri">
												<init>
													<castExpression targetType="System.String">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="appReg"/>
															</target>
															<indices>
																<variableReferenceExpression name="propName"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement name="originalRedirectUri">
												<init>
													<castExpression targetType="System.String">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="appRegOriginal"/>
															</target>
															<indices>
																<variableReferenceExpression name="propName"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</init>
											</variableDeclarationStatement>
											<comment>delete the previous CORs entries</comment>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="originalRedirectUri"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="AppDataDelete">
														<target>
															<propertyReferenceExpression name="App"/>
														</target>
														<parameters>
															<stringFormatExpression>
																<xsl:attribute name="format"><![CDATA[sys/cors/{0}/{1}.json]]></xsl:attribute>
																<methodInvokeExpression methodName="ToUrlEncodedToken">
																	<target>
																		<typeReferenceExpression type="TextUtility"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="UriToCORsOrigin">
																			<parameters>
																				<variableReferenceExpression name="originalRedirectUri"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
																<arrayIndexerExpression>
																	<target>
																		<argumentReferenceExpression name="appReg"/>
																	</target>
																	<indices>
																		<primitiveExpression value="client_id"/>
																	</indices>
																</arrayIndexerExpression>
															</stringFormatExpression>
														</parameters>
													</methodInvokeExpression>
													<methodInvokeExpression methodName="Remove">
														<target>
															<propertyReferenceExpression name="Cache">
																<propertyReferenceExpression name="Current">
																	<typeReferenceExpression type="HttpContext"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<binaryOperatorExpression operator="Add">
																<primitiveExpression value="cors_origin_"/>
																<methodInvokeExpression methodName="UriToCORsOrigin">
																	<parameters>
																		<variableReferenceExpression name="originalRedirectUri"/>
																	</parameters>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<comment>create the new CORs entries</comment>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="redirectUri"/>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="ValueInequality">
																<propertyReferenceExpression name="HttpMethod"/>
																<primitiveExpression value="DELETE"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="BooleanOr">
															<convertExpression to="Boolean">
																<methodInvokeExpression methodName="SelectToken">
																	<target>
																		<argumentReferenceExpression name="appReg"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="authorization.spa"/>
																	</parameters>
																</methodInvokeExpression>
															</convertExpression>
															<convertExpression to="Boolean">
																<methodInvokeExpression methodName="SelectToken">
																	<target>
																		<argumentReferenceExpression name="appReg"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="authorization.native"/>
																	</parameters>
																</methodInvokeExpression>
															</convertExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement name="data">
														<init>
															<objectCreateExpression type="JObject"/>
														</init>
													</variableDeclarationStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="data"/>
															</target>
															<indices>
																<primitiveExpression value="app"/>
															</indices>
														</arrayIndexerExpression>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="appReg"/>
															</target>
															<indices>
																<primitiveExpression value="name"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="data"/>
															</target>
															<indices>
																<primitiveExpression value="client_id"/>
															</indices>
														</arrayIndexerExpression>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="appReg"/>
															</target>
															<indices>
																<primitiveExpression value="client_id"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="data"/>
															</target>
															<indices>
																<primitiveExpression value="uri"/>
															</indices>
														</arrayIndexerExpression>
														<variableReferenceExpression name="redirectUri"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="data"/>
															</target>
															<indices>
																<primitiveExpression value="type"/>
															</indices>
														</arrayIndexerExpression>
														<variableReferenceExpression name="propName"/>
													</assignStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="data"/>
															</target>
															<indices>
																<primitiveExpression value="origin"/>
															</indices>
														</arrayIndexerExpression>
														<methodInvokeExpression methodName="UriToCORsOrigin">
															<parameters>
																<variableReferenceExpression name="redirectUri"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
													<methodInvokeExpression methodName="AppDataWriteAllText">
														<target>
															<propertyReferenceExpression name="App"/>
														</target>
														<parameters>
															<stringFormatExpression>
																<xsl:attribute name="format"><![CDATA[sys/cors/{0}/{1}.json]]></xsl:attribute>
																<methodInvokeExpression methodName="ToUrlEncodedToken">
																	<target>
																		<typeReferenceExpression type="TextUtility"/>
																	</target>
																	<parameters>
																		<castExpression targetType="System.String">
																			<arrayIndexerExpression>
																				<target>
																					<argumentReferenceExpression name="data"/>
																				</target>
																				<indices>
																					<primitiveExpression value="origin"/>
																				</indices>
																			</arrayIndexerExpression>
																		</castExpression>
																	</parameters>
																</methodInvokeExpression>
																<arrayIndexerExpression>
																	<target>
																		<argumentReferenceExpression name="appReg"/>
																	</target>
																	<indices>
																		<primitiveExpression value="client_id"/>
																	</indices>
																</arrayIndexerExpression>
															</stringFormatExpression>
															<methodInvokeExpression methodName="ToString">
																<target>
																	<variableReferenceExpression name="data"/>
																</target>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>

										</statements>
									</foreachStatement>
								</statements>
							</memberMethod>
							<!-- method UriToCORsOrigin(string) -->
							<memberMethod returnType="System.String" name="UriToCORsOrigin">
								<attributes public="true" static="true"/>
								<parameters>
									<parameter type="System.String" name="appUri"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="url">
										<init>
											<objectCreateExpression type="Uri">
												<parameters>
													<argumentReferenceExpression name="appUri"/>
												</parameters>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="origin">
										<init>
											<stringFormatExpression>
												<xsl:attribute name="format"><![CDATA[{0}://{1}]]></xsl:attribute>
												<propertyReferenceExpression name="Scheme">
													<variableReferenceExpression name="url"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="Host">
													<variableReferenceExpression name="url"/>
												</propertyReferenceExpression>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueInequality">
												<propertyReferenceExpression name="Port">
													<variableReferenceExpression name="url"/>
												</propertyReferenceExpression>
												<primitiveExpression value="80"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="origin"/>
												<stringFormatExpression>
													<xsl:attribute name="format"><![CDATA[{0}:{1}]]></xsl:attribute>
													<variableReferenceExpression name="origin"/>
													<propertyReferenceExpression name="Port">
														<variableReferenceExpression name="url"/>
													</propertyReferenceExpression>
												</stringFormatExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="origin"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</xsl:if>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
