<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="Namespace"/>
	<xsl:param name="IsClassLibrary"/>
	<xsl:param name="CodedomProviderName"/>
	<xsl:param name="MembershipEnabled" select="'false'"/>

	<xsl:param name="IsUnlimited"/>

	<xsl:variable name="Copyright" select="a:project/a:features/@copyright"/>
	<!--<xsl:variable name="PrettyName" select="a:project/@prettyName"/>-->
	<xsl:variable name="ScriptsFolder">
		<xsl:choose>
			<xsl:when test="$CodedomProviderName='VisualBasic'">
				<xsl:text></xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>.Scripts</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:template match="/">

		<compileUnit namespace="{$Namespace}.Handlers">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.Globalization"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Net"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.UI.HtmlControls"/>
				<namespaceImport name="System.Web.UI.WebControls"/>
				<namespaceImport name="System.Web.Configuration"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="Newtonsoft.Json"/>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Services"/>
				<namespaceImport name="{$Namespace}.Services.Rest"/>
				<namespaceImport name="{$Namespace}.Web"/>
			</imports>
			<types>
				<!-- class Site -->
				<typeDeclaration name="Site" isPartial="true">
					<baseTypes>
						<typeReference type="SiteBase"/>
					</baseTypes>
					<members>
						<!--<typeConstructor>
              <statements>
                -->
						<!--<variableDeclarationStatement type="System.Boolean" name="releaseMode">
                  <init>
                    <primitiveExpression value="true"/>
                  </init>
                </variableDeclarationStatement>-->
						<!--
                -->
						<!--<assignStatement>
                  <propertyReferenceExpression name="EnableMinifiedScript">
                    <typeReferenceExpression type="AquariumExtenderBase"/>
                  </propertyReferenceExpression>
                  <variableReferenceExpression name="releaseMode"/>
                </assignStatement>-->
						<!--
                -->
						<!--<xsl:if test="$IsUnlimited='true'">
                  <assignStatement>
                    <propertyReferenceExpression name="EnableCombinedScript">
                      <typeReferenceExpression type="AquariumExtenderBase"/>
                    </propertyReferenceExpression>
                    <variableReferenceExpression name="releaseMode"/>
                  </assignStatement>
                </xsl:if>-->
						<!--
                -->
						<!--<assignStatement>
                  <propertyReferenceExpression name="EnableMinifiedCss">
                    <typeReferenceExpression type="ApplicationServices"/>
                  </propertyReferenceExpression>
                  <variableReferenceExpression name="releaseMode"/>
                </assignStatement>-->
						<!--
                -->
						<!--<xsl:if test="$IsUnlimited='true'">
                  <assignStatement>
                    <propertyReferenceExpression name="EnableCombinedCss">
                      <typeReferenceExpression type="ApplicationServices"/>
                    </propertyReferenceExpression>
                    <variableReferenceExpression name="releaseMode"/>
                  </assignStatement>
                </xsl:if>-->
						<!--
              </statements>
            </typeConstructor>-->
					</members>
				</typeDeclaration>
				<!-- class SiteBase -->
				<typeDeclaration name="SiteBase">
					<baseTypes>
						<typeReference type="{$Namespace}.Web.PageBase"/>
					</baseTypes>
					<members>
						<memberField type="System.Boolean" name="isTouchUI"/>
						<memberField type="AttributeDictionary" name="bodyAttributes"/>
						<memberField type="LiteralControl" name="bodyTag"/>
						<memberField type="LiteralContainer" name="pageHeaderContent"/>
						<memberField type="LiteralContainer" name="pageTitleContent"/>
						<memberField type="LiteralContainer" name="headContent"/>
						<memberField type="LiteralContainer" name="pageContent"/>
						<memberField type="LiteralContainer" name="pageFooterContent"/>
						<memberField type="LiteralContainer" name="pageSideBarContent"/>
						<!-- property Copyright-->
						<memberProperty type="System.String" name="Copyright">
							<attributes public="true" static="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression>
										<xsl:attribute name="value" xml:space="preserve"><xsl:choose>
                          <xsl:when test="string-length($Copyright)=0"><xsl:text disable-output-escaping="yes">&amp;copy; </xsl:text><xsl:text disable-output-escaping="yes">2022 </xsl:text><xsl:value-of select="$Namespace"/><xsl:text>. ^Copyright^All rights reserved.^Copyright^</xsl:text></xsl:when>
                            <xsl:otherwise><xsl:value-of select="$Copyright" disable-output-escaping="yes"/></xsl:otherwise>
                          </xsl:choose></xsl:attribute>
									</primitiveExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Device -->
						<memberProperty type="System.String" name="Device">
							<attributes public="true" override="true"/>
							<getStatements>
								<methodReturnStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="bodyAttributes"/>
										</target>
										<indices>
											<primitiveExpression value="data-device"/>
										</indices>
									</arrayIndexerExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method ResolveAppUrl(string) -->
						<memberMethod returnType="System.String" name="ResolveAppUrl">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="html"/>
							</parameters>
							<statements>
								<!-- 
                string appPath = Request.ApplicationPath;
            if (!appPath.EndsWith("/"))
                appPath = appPath + "/";
            return html.Replace("=\"~/", ("=\"" + appPath));-->
								<variableDeclarationStatement type="System.String" name="appPath">
									<init>
										<propertyReferenceExpression name="ApplicationPath">
											<propertyReferenceExpression name="Request"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="EndsWith">
												<target>
													<variableReferenceExpression name="appPath"/>
												</target>
												<parameters>
													<primitiveExpression value="/"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="appPath"/>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="appPath"/>
												<primitiveExpression value="/"/>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Replace">
										<target>
											<argumentReferenceExpression name="html"/>
										</target>
										<parameters>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[="~/]]></xsl:attribute>
											</primitiveExpression>
											<binaryOperatorExpression operator="Add">
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[="]]></xsl:attribute>
												</primitiveExpression>
												<variableReferenceExpression name="appPath"/>
											</binaryOperatorExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method InjectPrefetch(string) -->
						<memberMethod returnType="System.String" name="InjectPrefetch">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="s"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<fieldReferenceExpression name="isTouchUI"/>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String" name="prefetch">
											<init>
												<methodInvokeExpression methodName="PreparePrefetch">
													<parameters>
														<variableReferenceExpression name="s"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="prefetch"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="s"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="prefetch"/>
														<variableReferenceExpression name="s"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="s"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OnInit(object, EventArgs) -->
						<memberMethod name="OnInit">
							<attributes override="true" family="true"/>
							<parameters>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="isRESTfulRequest">
									<init>
										<propertyReferenceExpression name="IsRequested">
											<typeReferenceExpression type="RESTfulResource"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="Not">
												<variableReferenceExpression name="isRESTfulRequest"/>
											</unaryOperatorExpression>
											<binaryOperatorExpression operator="BooleanAnd">
												<propertyReferenceExpression name="IsAuthenticated">
													<propertyReferenceExpression name="Identity">
														<propertyReferenceExpression name="User"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="AllowUI">
														<target>
															<typeReferenceExpression type="ApplicationServices"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Name">
																<propertyReferenceExpression name="Identity">
																	<propertyReferenceExpression name="User"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="SignOut">
											<target>
												<typeReferenceExpression type="FormsAuthentication"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="RedirectToLoginPage">
											<target>
												<methodInvokeExpression methodName="Create">
													<target>
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</target>
												</methodInvokeExpression>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="End">
											<target>
												<propertyReferenceExpression name="Response"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<variableReferenceExpression name="isRESTfulRequest"/>
											<binaryOperatorExpression operator="BooleanOr">
												<methodInvokeExpression methodName="StartsWith">
													<target>
														<propertyReferenceExpression name="Path">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<binaryOperatorExpression operator="Add">
															<methodInvokeExpression methodName="ResolveUrl">
																<parameters>
																	<propertyReferenceExpression name="DefaultServicePath">
																		<typeReferenceExpression type="AquariumExtenderBase"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression value="/"/>
														</binaryOperatorExpression>
														<propertyReferenceExpression name="CurrentCultureIgnoreCase">
															<typeReferenceExpression type="StringComparison"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="StartsWith">
													<target>
														<propertyReferenceExpression name="Path">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<binaryOperatorExpression operator="Add">
															<methodInvokeExpression methodName="ResolveUrl">
																<parameters>
																	<propertyReferenceExpression name="AppServicePath">
																		<typeReferenceExpression type="AquariumExtenderBase"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression value="/"/>
														</binaryOperatorExpression>
														<propertyReferenceExpression name="CurrentCultureIgnoreCase">
															<typeReferenceExpression type="StringComparison"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="HandleServiceRequest">
											<target>
												<typeReferenceExpression type="ApplicationServices"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Context"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
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
										<variableDeclarationStatement type="System.String[]" name="permalink">
											<init>
												<methodInvokeExpression methodName="Split">
													<target>
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
													</target>
													<parameters>
														<primitiveExpression value="?" convertTo="Char"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="permalink"/>
													</propertyReferenceExpression>
													<primitiveExpression value="2"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="RegisterStartupScript">
													<target>
														<propertyReferenceExpression name="ClientScript">
															<propertyReferenceExpression name="Page"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<methodInvokeExpression methodName="GetType"/>
														<primitiveExpression value="Redirect"/>
														<stringFormatExpression format="window.location.replace('{{0}}?_link={{1}}');">
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
														</stringFormatExpression>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<variableDeclarationStatement type="System.String" name="requestUrl">
											<init>
												<propertyReferenceExpression name="RawUrl">
													<propertyReferenceExpression name="Request"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="Length">
															<variableReferenceExpression name="requestUrl"/>
														</propertyReferenceExpression>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
													<methodInvokeExpression methodName="EndsWith">
														<target>
															<variableReferenceExpression name="requestUrl"/>
														</target>
														<parameters>
															<primitiveExpression value="/"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="requestUrl"/>
													<methodInvokeExpression methodName="Substring">
														<target>
															<variableReferenceExpression name="requestUrl"/>
														</target>
														<parameters>
															<primitiveExpression value="0"/>
															<binaryOperatorExpression operator="Subtract">
																<propertyReferenceExpression name="Length">
																	<variableReferenceExpression name="requestUrl"/>
																</propertyReferenceExpression>
																<primitiveExpression value="1"/>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Equals">
													<target>
														<propertyReferenceExpression name="ApplicationPath">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="requestUrl"/>
														<propertyReferenceExpression name="CurrentCultureIgnoreCase">
															<typeReferenceExpression type="StringComparison"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String" name="homePageUrl">
													<init>
														<propertyReferenceExpression name="HomePageUrl">
															<typeReferenceExpression type="ApplicationServices"/>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Equals">
																<target>
																	<propertyReferenceExpression name="ApplicationPath">
																		<propertyReferenceExpression name="Request"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<variableReferenceExpression name="homePageUrl"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Redirect">
															<target>
																<propertyReferenceExpression name="Response"/>
															</target>
															<parameters>
																<variableReferenceExpression name="homePageUrl"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<variableDeclarationStatement type="SortedDictionary" name="contentInfo">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="System.String"/>
									</typeArguments>
									<init>
										<methodInvokeExpression methodName="LoadContent">
											<target>
												<typeReferenceExpression type="ApplicationServices"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="InitializeSiteMaster"/>
								<variableDeclarationStatement type="System.String" name="s">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<variableReferenceExpression name="contentInfo"/>
												</target>
												<parameters>
													<primitiveExpression value="PageTitle"/>
													<directionExpression direction="Out">
														<variableReferenceExpression name="s"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="s"/>
											<propertyReferenceExpression name="DisplayName">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="ApplicationServicesBase"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="Title">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="s"/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="pageTitleContent"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<fieldReferenceExpression name="isTouchUI"/>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Text">
														<fieldReferenceExpression name="pageTitleContent"/>
													</propertyReferenceExpression>
													<stringEmptyExpression/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<propertyReferenceExpression name="Text">
														<fieldReferenceExpression name="pageTitleContent"/>
													</propertyReferenceExpression>
													<variableReferenceExpression name="s"/>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<!--<variableDeclarationStatement type="HtmlMeta" name="appName">
                  <init>
                    <objectCreateExpression type="HtmlMeta"/>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Name">
                    <variableReferenceExpression name="appName"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="application-name"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Content">
                    <variableReferenceExpression name="appName"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="DisplayName">
                    <propertyReferenceExpression name="Current">
                      <typeReferenceExpression type="ApplicationServicesBase"/>
                    </propertyReferenceExpression>
                  </propertyReferenceExpression>
                </assignStatement>-->
								<variableDeclarationStatement name="appName">
									<init>
										<objectCreateExpression type="LiteralControl">
											<parameters>
												<stringFormatExpression>
													<xsl:attribute name="format"><![CDATA[<meta name="application-name" content="{0}">]]></xsl:attribute>
													<methodInvokeExpression methodName="HtmlAttributeEncode">
														<target>
															<typeReferenceExpression type="HttpUtility"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="DisplayName">
																<propertyReferenceExpression name="Current">
																	<typeReferenceExpression type="ApplicationServicesBase"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</stringFormatExpression>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls">
											<propertyReferenceExpression name="Header"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<variableReferenceExpression name="appName"/>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<propertyReferenceExpression name="UserAgent">
													<propertyReferenceExpression name="Request"/>
												</propertyReferenceExpression>
											</unaryOperatorExpression>
											<methodInvokeExpression methodName="IsMatch">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="UserAgent">
														<propertyReferenceExpression name="Request"/>
													</propertyReferenceExpression>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[Trident/7\.]]></xsl:attribute>
													</primitiveExpression>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Controls">
													<propertyReferenceExpression name="Header"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<objectCreateExpression type="LiteralControl">
													<parameters>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[<meta http-equiv="X-UA-COMPATIBLE" content="IE=Edge">]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<variableReferenceExpression name="contentInfo"/>
												</target>
												<parameters>
													<primitiveExpression value="Head"/>
													<directionExpression direction="Out">
														<variableReferenceExpression name="s"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
											<binaryOperatorExpression operator="IdentityInequality">
												<fieldReferenceExpression name="headContent"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Text">
												<fieldReferenceExpression name="headContent"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="s"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<variableReferenceExpression name="contentInfo"/>
												</target>
												<parameters>
													<primitiveExpression value="PageContent"/>
													<directionExpression direction="Out">
														<variableReferenceExpression name="s"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
											<binaryOperatorExpression operator="IdentityInequality">
												<fieldReferenceExpression name="pageContent"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<fieldReferenceExpression name="isTouchUI"/>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="s"/>
													<stringFormatExpression>
														<xsl:attribute name="format"><![CDATA[<div id="PageContent" style="display:none">{0}</div>]]></xsl:attribute>
														<variableReferenceExpression name="s"/>
													</stringFormatExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="Match" name="userControl">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="s"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[<div\s+data-user-control\s*=s*"([\s\S]+?)".*?>\s*</div>]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="Success">
													<variableReferenceExpression name="userControl"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.Int32" name="startPos">
													<init>
														<primitiveExpression value="0"/>
													</init>
												</variableDeclarationStatement>
												<whileStatement>
													<test>
														<propertyReferenceExpression name="Success">
															<variableReferenceExpression name="userControl"/>
														</propertyReferenceExpression>
													</test>
													<statements>
														<methodInvokeExpression methodName="Add">
															<target>
																<propertyReferenceExpression name="Controls">
																	<fieldReferenceExpression name="pageContent"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<objectCreateExpression type="LiteralControl">
																	<parameters>
																		<methodInvokeExpression methodName="Substring">
																			<target>
																				<variableReferenceExpression name="s"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="startPos"/>
																				<binaryOperatorExpression operator="Subtract">
																					<propertyReferenceExpression name="Index">
																						<variableReferenceExpression name="userControl"/>
																					</propertyReferenceExpression>
																					<variableReferenceExpression name="startPos"/>
																				</binaryOperatorExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
														<assignStatement>
															<variableReferenceExpression name="startPos"/>
															<binaryOperatorExpression operator="Add">
																<propertyReferenceExpression name="Index">
																	<variableReferenceExpression name="userControl"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Length">
																	<variableReferenceExpression name="userControl"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</assignStatement>
														<variableDeclarationStatement type="System.String" name="controlFileName">
															<init>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="userControl"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="1"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="controlExtension">
															<init>
																<methodInvokeExpression methodName="GetExtension">
																	<target>
																		<typeReferenceExpression type="Path"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="controlFileName"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="siteControlText">
															<init>
																<primitiveExpression value="null"/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="StartsWith">
																		<target>
																			<variableReferenceExpression name="controlFileName"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="~"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="controlFileName"/>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="controlFileName"/>
																		<primitiveExpression value="~"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNullOrEmpty">
																	<variableReferenceExpression name="controlExtension"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="System.String" name="testFileName">
																	<init>
																		<binaryOperatorExpression operator="Add">
																			<variableReferenceExpression name="controlFileName"/>
																			<primitiveExpression value=".ascx"/>
																		</binaryOperatorExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="Exists">
																			<target>
																				<typeReferenceExpression type="File"/>
																			</target>
																			<parameters>
																				<methodInvokeExpression methodName="MapPath">
																					<target>
																						<propertyReferenceExpression name="Server"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="testFileName"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="controlFileName"/>
																			<variableReferenceExpression name="testFileName"/>
																		</assignStatement>
																		<assignStatement>
																			<variableReferenceExpression name="controlExtension"/>
																			<primitiveExpression value=".ascx"/>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<propertyReferenceExpression name="IsSiteContentEnabled">
																					<typeReferenceExpression type="ApplicationServices"/>
																				</propertyReferenceExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement type="System.String" name="relativeControlPath">
																					<init>
																						<methodInvokeExpression methodName="Substring">
																							<target>
																								<variableReferenceExpression name="controlFileName"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="1"/>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<methodInvokeExpression methodName="StartsWith">
																							<target>
																								<variableReferenceExpression name="relativeControlPath"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="/"/>
																							</parameters>
																						</methodInvokeExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="relativeControlPath"/>
																							<methodInvokeExpression methodName="Substring">
																								<target>
																									<variableReferenceExpression name="relativeControlPath"/>
																								</target>
																								<parameters>
																									<primitiveExpression value="1"/>
																								</parameters>
																							</methodInvokeExpression>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																				<assignStatement>
																					<variableReferenceExpression name="siteControlText"/>
																					<methodInvokeExpression methodName="ReadSiteContentString">
																						<target>
																							<propertyReferenceExpression name="Current">
																								<typeReferenceExpression type="ApplicationServices"/>
																							</propertyReferenceExpression>
																						</target>
																						<parameters>
																							<binaryOperatorExpression operator="Add">
																								<primitiveExpression value="sys/"/>
																								<variableReferenceExpression name="relativeControlPath"/>
																							</binaryOperatorExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityEquality">
																					<variableReferenceExpression name="siteControlText"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="testFileName"/>
																					<binaryOperatorExpression operator="Add">
																						<variableReferenceExpression name="controlFileName"/>
																						<primitiveExpression value=".html"/>
																					</binaryOperatorExpression>
																				</assignStatement>
																				<conditionStatement>
																					<condition>
																						<methodInvokeExpression methodName="Exists">
																							<target>
																								<typeReferenceExpression type="File"/>
																							</target>
																							<parameters>
																								<methodInvokeExpression methodName="MapPath">
																									<target>
																										<propertyReferenceExpression name="Server"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="testFileName"/>
																									</parameters>
																								</methodInvokeExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="controlFileName"/>
																							<variableReferenceExpression name="testFileName"/>
																						</assignStatement>
																						<assignStatement>
																							<variableReferenceExpression name="controlExtension"/>
																							<primitiveExpression value=".html"/>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<variableDeclarationStatement type="Match" name="userControlAuthorizeRoles">
															<init>
																<methodInvokeExpression methodName="Match">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="userControl"/>
																		</propertyReferenceExpression>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[data-authorize-roles\s*=\s*"(.+?)"]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Boolean" name="allowUserControl">
															<init>
																<unaryOperatorExpression operator="Not">
																	<propertyReferenceExpression name="Success">
																		<variableReferenceExpression name="userControlAuthorizeRoles"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<variableReferenceExpression name="allowUserControl"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="System.String" name="authorizeRoles">
																	<init>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="userControlAuthorizeRoles"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="1"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="authorizeRoles"/>
																			<primitiveExpression value="?"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<propertyReferenceExpression name="IsAuthenticated">
																						<propertyReferenceExpression name="Identity">
																							<propertyReferenceExpression name="User">
																								<propertyReferenceExpression name="Context"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="allowUserControl"/>
																					<primitiveExpression value="true"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<variableReferenceExpression name="allowUserControl"/>
																			<methodInvokeExpression methodName="UserIsAuthorizedToAccessResource">
																				<target>
																					<typeReferenceExpression type="ApplicationServices"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="controlFileName"/>
																					<variableReferenceExpression name="authorizeRoles"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<variableReferenceExpression name="allowUserControl"/>
															</condition>
															<trueStatements>
																<tryStatement>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<variableReferenceExpression name="controlExtension"/>
																					<primitiveExpression value=".ascx"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<propertyReferenceExpression name="Controls">
																							<fieldReferenceExpression name="pageContent"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<methodInvokeExpression methodName="LoadControl">
																							<parameters>
																								<variableReferenceExpression name="controlFileName"/>
																							</parameters>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																			<falseStatements>
																				<variableDeclarationStatement type="System.String" name="controlText">
																					<init>
																						<variableReferenceExpression name="siteControlText"/>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="IdentityEquality">
																							<variableReferenceExpression name="controlText"/>
																							<primitiveExpression value="null"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="controlText"/>
																							<methodInvokeExpression methodName="ReadAllText">
																								<target>
																									<typeReferenceExpression type="File"/>
																								</target>
																								<parameters>
																									<methodInvokeExpression methodName="MapPath">
																										<target>
																											<propertyReferenceExpression name="Server"/>
																										</target>
																										<parameters>
																											<variableReferenceExpression name="controlFileName"/>
																										</parameters>
																									</methodInvokeExpression>
																								</parameters>
																							</methodInvokeExpression>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																				<variableDeclarationStatement type="Match" name="bodyMatch">
																					<init>
																						<methodInvokeExpression methodName="Match">
																							<target>
																								<typeReferenceExpression type="Regex"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="controlText"/>
																								<primitiveExpression>
																									<xsl:attribute name="value"><![CDATA[<body[\s\S]*?>([\s\S]+?)</body>]]></xsl:attribute>
																								</primitiveExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<propertyReferenceExpression name="Success">
																							<variableReferenceExpression name="bodyMatch"/>
																						</propertyReferenceExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="controlText"/>
																							<propertyReferenceExpression name="Value">
																								<arrayIndexerExpression>
																									<target>
																										<propertyReferenceExpression name="Groups">
																											<variableReferenceExpression name="bodyMatch"/>
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
																				<assignStatement>
																					<variableReferenceExpression name="controlText"/>
																					<methodInvokeExpression methodName="EnrichData">
																						<target>
																							<typeReferenceExpression type="ApplicationServices"/>
																						</target>
																						<parameters>
																							<methodInvokeExpression methodName="Replace">
																								<target>
																									<typeReferenceExpression type="Localizer"/>
																								</target>
																								<parameters>
																									<primitiveExpression value="Controls"/>
																									<methodInvokeExpression methodName="GetFileName">
																										<target>
																											<typeReferenceExpression type="Path"/>
																										</target>
																										<parameters>
																											<methodInvokeExpression methodName="MapPath">
																												<target>
																													<propertyReferenceExpression name="Server"/>
																												</target>
																												<parameters>
																													<variableReferenceExpression name="controlFileName"/>
																												</parameters>
																											</methodInvokeExpression>
																										</parameters>
																									</methodInvokeExpression>
																									<variableReferenceExpression name="controlText"/>
																								</parameters>
																							</methodInvokeExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<propertyReferenceExpression name="Controls">
																							<fieldReferenceExpression name="pageContent"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<objectCreateExpression type="LiteralControl">
																							<parameters>
																								<methodInvokeExpression methodName="InjectPrefetch">
																									<parameters>
																										<variableReferenceExpression name="controlText"/>
																									</parameters>
																								</methodInvokeExpression>
																							</parameters>
																						</objectCreateExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</falseStatements>
																		</conditionStatement>
																	</statements>
																	<catch exceptionType="Exception" localName="ex">
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<propertyReferenceExpression name="Controls">
																					<fieldReferenceExpression name="pageContent"/>
																				</propertyReferenceExpression>
																			</target>
																			<parameters>
																				<objectCreateExpression type="LiteralControl">
																					<parameters>
																						<stringFormatExpression format="Error loading '{{0}}': {{1}}">
																							<variableReferenceExpression name="controlFileName"/>
																							<propertyReferenceExpression name="Message">
																								<variableReferenceExpression name="ex"/>
																							</propertyReferenceExpression>
																						</stringFormatExpression>
																					</parameters>
																				</objectCreateExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</catch>
																</tryStatement>
															</trueStatements>
														</conditionStatement>
														<assignStatement>
															<variableReferenceExpression name="userControl"/>
															<methodInvokeExpression methodName="NextMatch">
																<target>
																	<variableReferenceExpression name="userControl"/>
																</target>
															</methodInvokeExpression>
														</assignStatement>
													</statements>
												</whileStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="LessThan">
															<variableReferenceExpression name="startPos"/>
															<propertyReferenceExpression name="Length">
																<variableReferenceExpression name="s"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<propertyReferenceExpression name="Controls">
																	<fieldReferenceExpression name="pageContent"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<objectCreateExpression type="LiteralControl">
																	<parameters>
																		<methodInvokeExpression methodName="Substring">
																			<target>
																				<variableReferenceExpression name="s"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="startPos"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<propertyReferenceExpression name="Text">
														<fieldReferenceExpression name="pageContent"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="InjectPrefetch">
														<parameters>
															<variableReferenceExpression name="s"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<fieldReferenceExpression name="isTouchUI"/>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Text">
														<fieldReferenceExpression name="pageContent"/>
													</propertyReferenceExpression>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[<div id="PageContent" style="display:none"><div data-app-role="page">404 Not Found</div></div>]]></xsl:attribute>
													</primitiveExpression>
												</assignStatement>
												<assignStatement>
													<propertyReferenceExpression name="Title">
														<thisReferenceExpression/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="DisplayName">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="ApplicationServicesBase"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<!--<primitiveExpression value="{$PrettyName}" convertTo="String"/>-->
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<propertyReferenceExpression name="Text">
														<fieldReferenceExpression name="pageContent"/>
													</propertyReferenceExpression>
													<primitiveExpression value="404 Not Found"/>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<fieldReferenceExpression name="isTouchUI"/>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<fieldReferenceExpression name="pageFooterContent"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Text">
														<fieldReferenceExpression name="pageFooterContent"/>
													</propertyReferenceExpression>
													<binaryOperatorExpression operator="Add">
														<binaryOperatorExpression operator="Add">
															<primitiveExpression>
																<xsl:attribute name="value" xml:space="preserve"><![CDATA[<footer style="display:none"><small>]]></xsl:attribute>
															</primitiveExpression>
															<propertyReferenceExpression name="Copyright"/>
														</binaryOperatorExpression>
														<primitiveExpression>
															<xsl:attribute name="value" xml:space="preserve"><![CDATA[</small></footer>]]></xsl:attribute>
														</primitiveExpression>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="TryGetValue">
													<target>
														<variableReferenceExpression name="contentInfo"/>
													</target>
													<parameters>
														<primitiveExpression value="About"/>
														<directionExpression direction="Out">
															<variableReferenceExpression name="s"/>
														</directionExpression>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<fieldReferenceExpression name="pageSideBarContent"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="Text">
																<fieldReferenceExpression name="pageSideBarContent"/>
															</propertyReferenceExpression>
															<stringFormatExpression>
																<xsl:attribute name="format"><![CDATA[<div class="TaskBox About"><div class="Inner"><div class="Header">About</div><div class="Value">{0}</div></div></div>]]></xsl:attribute>
																<variableReferenceExpression name="s"/>
															</stringFormatExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.String" name="bodyAttributes">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="TryGetValue">
											<target>
												<variableReferenceExpression name="contentInfo"/>
											</target>
											<parameters>
												<primitiveExpression value="BodyAttributes"/>
												<directionExpression direction="Out">
													<variableReferenceExpression name="bodyAttributes"/>
												</directionExpression>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Parse">
											<target>
												<fieldReferenceExpression name="bodyAttributes"/>
											</target>
											<parameters>
												<variableReferenceExpression name="bodyAttributes"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<xsl:if test="$MembershipEnabled='true' or /a:project/a:membership[@customSecurity='true' or @activeDirectory='true']">
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="UserIsAuthorizedToAccessResource">
													<target>
														<typeReferenceExpression type="ApplicationServices"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Path">
															<propertyReferenceExpression name="Request">
																<propertyReferenceExpression name="Current">
																	<typeReferenceExpression type="HttpContext"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
														<arrayIndexerExpression>
															<target>
																<fieldReferenceExpression name="bodyAttributes"/>
															</target>
															<indices>
																<primitiveExpression value="data-authorize-roles"/>
															</indices>
														</arrayIndexerExpression>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="System.String" name="requestPath">
												<init>
													<methodInvokeExpression methodName="Substring">
														<target>
															<propertyReferenceExpression name="Path">
																<variableReferenceExpression name="Request"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="1"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="Not">
														<binaryOperatorExpression operator="BooleanOr">
															<propertyReferenceExpression name="IsEnabled">
																<typeReferenceExpression type="WorkflowRegister"/>
															</propertyReferenceExpression>
															<methodInvokeExpression methodName="Allows">
																<target>
																	<typeReferenceExpression type="WorkflowRegister"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="requestPath"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="RedirectToLoginPage">
														<target>
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="ApplicationServices"/>
															</propertyReferenceExpression>
														</target>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="Remove">
										<target>
											<fieldReferenceExpression name="bodyAttributes"/>
										</target>
										<parameters>
											<primitiveExpression value="data-authorize-roles"/>
										</parameters>
									</methodInvokeExpression>
								</xsl:if>
								<variableDeclarationStatement type="System.String" name="classAttr">
									<init>
										<arrayIndexerExpression>
											<target>
												<fieldReferenceExpression name="bodyAttributes"/>
											</target>
											<indices>
												<primitiveExpression value="class"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="classAttr"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="classAttr"/>
											<stringEmptyExpression/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<fieldReferenceExpression name="isTouchUI"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="classAttr"/>
														</target>
														<parameters>
															<primitiveExpression value="Wide"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="classAttr"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="classAttr"/>
														<primitiveExpression value=" Standard"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="classAttr"/>
											<binaryOperatorExpression operator="Add">
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="classAttr"/>
													<primitiveExpression value=" "/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="Add">
													<methodInvokeExpression methodName="Substring">
														<target>
															<methodInvokeExpression methodName="Replace">
																<target>
																	<typeReferenceExpression type="Regex"/>
																</target>
																<parameters>
																	<methodInvokeExpression methodName="ToLower">
																		<target>
																			<propertyReferenceExpression name="Path">
																				<variableReferenceExpression name="Request"/>
																			</propertyReferenceExpression>
																		</target>
																	</methodInvokeExpression>
																	<primitiveExpression value="\W"/>
																	<primitiveExpression value="_"/>
																</parameters>
															</methodInvokeExpression>
														</target>
														<parameters>
															<primitiveExpression value="1"/>
														</parameters>
													</methodInvokeExpression>
													<primitiveExpression value="_html"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<fieldReferenceExpression name="summaryDisabled"/>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="classAttr"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="classAttr"/>
														<primitiveExpression value=" see-all-always"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="classAttr"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<fieldReferenceExpression name="bodyAttributes"/>
												</target>
												<indices>
													<primitiveExpression value="class"/>
												</indices>
											</arrayIndexerExpression>
											<methodInvokeExpression methodName="Trim">
												<target>
													<variableReferenceExpression name="classAttr"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="Text">
										<fieldReferenceExpression name="bodyTag"/>
									</propertyReferenceExpression>
									<stringFormatExpression>
										<xsl:attribute name="format" xml:space="preserve"><xsl:text>&#13;&#10;</xsl:text><![CDATA[<body{0}>]]><xsl:text>&#13;&#10;</xsl:text></xsl:attribute>
										<methodInvokeExpression methodName="ToString">
											<target>
												<fieldReferenceExpression name="bodyAttributes"/>
											</target>
										</methodInvokeExpression>
									</stringFormatExpression>
								</assignStatement>
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
						<!-- field summaryDisabled-->
						<memberField name="summaryDisabled" type="System.Boolean">
							<init>
								<primitiveExpression value="false"/>
							</init>
						</memberField>
						<!-- property UnsupportedDataViewProperties-->
						<memberField type="System.String[]" name="UnsupportedDataViewProperties">
							<attributes public="true" static="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String[]"/>
									<initializers>
										<primitiveExpression value="data-start-command-name"/>
										<primitiveExpression value="data-start-command-argument"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- method PreparePrefetch(string)-->
						<memberMethod returnType="System.String" name="PreparePrefetch">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="content"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="output">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<propertyReferenceExpression name="Query">
													<propertyReferenceExpression name="Url">
														<propertyReferenceExpression name="Request"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</unaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Headers">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="X-Cot-Manifest-Request"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="true" convertTo="String"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<variableReferenceExpression name="output"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="JToken" name="token">
									<init>
										<methodInvokeExpression methodName="TryGetJsonProperty">
											<target>
												<typeReferenceExpression type="ApplicationServices"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="DefaultSettings">
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
												<primitiveExpression value="ui.history.dataView"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Boolean" name="supportGridPrefetch">
									<init>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="token"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="IsMatch">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<castExpression targetType="System.String">
															<variableReferenceExpression name="token"/>
														</castExpression>
														<primitiveExpression value="\b(search|sort|group|filter)\b"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="List" name="prefetches">
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
								<variableDeclarationStatement type="System.Boolean" name="prefetch">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="List" name="dataViews">
									<typeArguments>
										<typeReference type="Tuple">
											<typeArguments>
												<typeReference type="System.String"/>
												<typeReference type="AttributeDictionary"/>
											</typeArguments>
										</typeReference>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="Tuple">
													<typeArguments>
														<typeReference type="System.String"/>
														<typeReference type="AttributeDictionary"/>
													</typeArguments>
												</typeReference>
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
												<variableReferenceExpression name="content"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[<div\s+(id="(?'Id'\w+)")\s+(?'Props'data-controller.*?)>]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</target>
									<statements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="dataViews"/>
											</target>
											<parameters>
												<objectCreateExpression type="Tuple">
													<typeArguments>
														<typeReference type="System.String"/>
														<typeReference type="AttributeDictionary"/>
													</typeArguments>
													<parameters>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Id"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
														<objectCreateExpression type="AttributeDictionary">
															<parameters>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="m"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Props"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="Count">
												<variableReferenceExpression name="dataViews"/>
											</propertyReferenceExpression>
											<primitiveExpression value="1"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="prefetch"/>
											<primitiveExpression value="true"/>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<comment>LEGACY MASTER DETAIL PAGE SUPPORT</comment>
										<comment>
											<![CDATA[
 1. convert text of containers into single container with single dataview referring to virtual dashboard controller
                      
 <div data-flow="row">
   <div id="view1" data-controller="Dashboards" data-view="form1" data-show-action-buttons="none"></div> 

 </div>

 2. produce response for this controller.
 a. standalone data views become data view fields of the virtual controller
 b. the layout of the page is optionally converted into form1 layout of the virtual controller
 c. render json response of virtual controller with layout in it]]>
										</comment>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<variableReferenceExpression name="prefetch"/>
									</condition>
									<trueStatements>
										<forStatement>
											<variable type="System.Int32" name="i">
												<init>
													<primitiveExpression value="0"/>
												</init>
											</variable>
											<test>
												<binaryOperatorExpression operator="LessThan">
													<variableReferenceExpression name="i"/>
													<propertyReferenceExpression name="Count">
														<variableReferenceExpression name="dataViews"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</test>
											<increment>
												<variableReferenceExpression name="i"/>
											</increment>
											<statements>
												<variableDeclarationStatement type="Tuple" name="dataView">
													<typeArguments>
														<typeReference type="System.String"/>
														<typeReference type="AttributeDictionary"/>
													</typeArguments>
													<init>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="dataViews"/>
															</target>
															<indices>
																<variableReferenceExpression name="i"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="dataViewId">
													<init>
														<propertyReferenceExpression name="Item1">
															<variableReferenceExpression name="dataView"/>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="AttributeDictionary" name="attrs">
													<init>
														<propertyReferenceExpression name="Item2">
															<variableReferenceExpression name="dataView"/>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable type="System.String" name="p"/>
													<target>
														<propertyReferenceExpression name="UnsupportedDataViewProperties"/>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="ContainsKey">
																	<target>
																		<variableReferenceExpression name="attrs"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="p"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<methodReturnStatement>
																	<variableReferenceExpression name="output"/>
																</methodReturnStatement>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
												<variableDeclarationStatement type="System.String" name="controllerName">
													<init>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="attrs"/>
															</target>
															<indices>
																<primitiveExpression value="data-controller"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="viewId">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="tags">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="TryGetValue">
													<target>
														<variableReferenceExpression name="attrs"/>
													</target>
													<parameters>
														<primitiveExpression value="data-tags"/>
														<directionExpression direction="Out">
															<variableReferenceExpression name="tags"/>
														</directionExpression>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement type="ControllerConfiguration" name="c">
													<init>
														<methodInvokeExpression methodName="CreateConfigurationInstance">
															<target>
																<typeReferenceExpression type="Controller"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="GetType"/>
																<variableReferenceExpression name="controllerName"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="TryGetValue">
																<target>
																	<variableReferenceExpression name="attrs"/>
																</target>
																<parameters>
																	<primitiveExpression value="data-view"/>
																	<directionExpression direction="Out">
																		<variableReferenceExpression name="viewId"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="viewId"/>
															<castExpression targetType="System.String">
																<methodInvokeExpression methodName="Evaluate">
																	<target>
																		<variableReferenceExpression name="c"/>
																	</target>
																	<parameters>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[string(/c:dataController/c:views/c:view[1]/@id)]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
															</castExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement type="XPathNavigator" name="viewNav">
													<init>
														<methodInvokeExpression methodName="SelectSingleNode">
															<target>
																<variableReferenceExpression name="c"/>
															</target>
															<parameters>
																<primitiveExpression value="/c:dataController/c:views/c:view[@id='{{0}}']"/>
																<variableReferenceExpression name="viewId"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="Not">
																<propertyReferenceExpression name="IsAuthenticated">
																	<propertyReferenceExpression name="Identity">
																		<propertyReferenceExpression name="User">
																			<propertyReferenceExpression name="Context"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="ValueInequality">
																<methodInvokeExpression methodName="GetAttribute">
																	<target>
																		<variableReferenceExpression name="viewNav"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="access"/>
																		<stringEmptyExpression/>
																	</parameters>
																</methodInvokeExpression>
																<primitiveExpression value="Public"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<variableReferenceExpression name="output"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement type="System.String" name="roles">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<methodInvokeExpression methodName="TryGetValue">
																<target>
																	<variableReferenceExpression name="attrs"/>
																</target>
																<parameters>
																	<primitiveExpression value="data-roles"/>
																	<directionExpression direction="Out">
																		<variableReferenceExpression name="roles"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression methodName="UserIsInRole">
																	<target>
																		<objectCreateExpression type="ControllerUtilities"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="Split">
																			<target>
																				<variableReferenceExpression name="roles"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="," convertTo="Char"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<variableReferenceExpression name="output"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="tags"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="tags"/>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value=" "/>
															<methodInvokeExpression methodName="GetAttribute">
																<target>
																	<variableReferenceExpression name="viewNav"/>
																</target>
																<parameters>
																	<primitiveExpression value="tags"/>
																	<stringEmptyExpression/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</assignStatement>
												<variableDeclarationStatement type="System.Boolean" name="isForm">
													<init>
														<binaryOperatorExpression operator="ValueEquality">
															<methodInvokeExpression methodName="GetAttribute">
																<target>
																	<variableReferenceExpression name="viewNav"/>
																</target>
																<parameters>
																	<primitiveExpression value="type"/>
																	<stringEmptyExpression/>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression value="Form"/>
														</binaryOperatorExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<variableReferenceExpression name="isForm"/>
													</condition>
													<trueStatements>
														<assignStatement>
															<fieldReferenceExpression name="summaryDisabled"/>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression methodName="IsMatch">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="tags"/>
																		<primitiveExpression value="\bprefetch-data-none\b"/>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanOr">
																<variableReferenceExpression name="supportGridPrefetch"/>
																<variableReferenceExpression name="isForm"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="PageRequest" name="request">
															<init>
																<objectCreateExpression type="PageRequest">
																	<parameters>
																		<primitiveExpression value="-1"/>
																		<primitiveExpression value="30"/>
																		<primitiveExpression value="null"/>
																		<primitiveExpression value="null"/>
																	</parameters>
																</objectCreateExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<propertyReferenceExpression name="Controller">
																<variableReferenceExpression name="request"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="controllerName"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="View">
																<variableReferenceExpression name="request"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="viewId"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Tag">
																<variableReferenceExpression name="request"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="tags"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="ContextKey">
																<variableReferenceExpression name="request"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="dataViewId"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="SupportsCaching">
																<variableReferenceExpression name="request"/>
															</propertyReferenceExpression>
															<primitiveExpression value="true"/>
														</assignStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="ContainsKey">
																	<target>
																		<variableReferenceExpression name="attrs"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="data-search-on-start"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="DoesNotRequireData">
																		<variableReferenceExpression name="request"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="true"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<variableDeclarationStatement type="ViewPage" name="response">
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
																			<variableReferenceExpression name="request"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="View">
																			<variableReferenceExpression name="request"/>
																		</propertyReferenceExpression>
																		<variableReferenceExpression name="request"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="result">
															<init>
																<stringFormatExpression format="{{{{ &quot;d&quot;: {{0}} }}}}">
																	<methodInvokeExpression methodName="CompressViewPageJsonOutput">
																		<target>
																			<typeReferenceExpression type="ApplicationServices"/>
																		</target>
																		<parameters>
																			<methodInvokeExpression methodName="SerializeObject">
																				<target>
																					<typeReferenceExpression type="JsonConvert"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="response"/>
																				</parameters>
																			</methodInvokeExpression>
																		</parameters>
																	</methodInvokeExpression>
																</stringFormatExpression>
															</init>
														</variableDeclarationStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="prefetches"/>
															</target>
															<parameters>
																<stringFormatExpression>
																	<xsl:attribute name="format"><![CDATA[<script type="application/json" id="_{0}_prefetch">{1}</script>]]></xsl:attribute>
																	<variableReferenceExpression name="dataViewId"/>
																	<methodInvokeExpression methodName="Replace">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="result"/>
																			<primitiveExpression>
																				<xsl:attribute name="value"><![CDATA[(<(/?\s*script)(\s|>))]]></xsl:attribute>
																			</primitiveExpression>/>
																			<primitiveExpression>
																				<xsl:attribute name="value"><![CDATA[]_[$2$3]^[]]></xsl:attribute>
																			</primitiveExpression>
																			<propertyReferenceExpression name="IgnoreCase">
																				<typeReferenceExpression type="RegexOptions"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</stringFormatExpression>
															</parameters>
														</methodInvokeExpression>
														<conditionStatement>
															<condition>
																<variableReferenceExpression name="isForm"/>
															</condition>
															<trueStatements>
																<foreachStatement>
																	<variable type="DataField" name="field"/>
																	<target>
																		<propertyReferenceExpression name="Fields">
																			<variableReferenceExpression name="response"/>
																		</propertyReferenceExpression>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanAnd">
																					<unaryOperatorExpression operator="IsNullOrEmpty">
																						<propertyReferenceExpression name="DataViewFilterFields">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																					</unaryOperatorExpression>
																					<binaryOperatorExpression operator="ValueEquality">
																						<propertyReferenceExpression name="Type">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																						<primitiveExpression value="DataView"/>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement type="AttributeDictionary" name="fieldAttr">
																					<init>
																						<objectCreateExpression type="AttributeDictionary">
																							<parameters>
																								<stringEmptyExpression/>
																							</parameters>
																						</objectCreateExpression>
																					</init>
																				</variableDeclarationStatement>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="fieldAttr"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="data-controller"/>
																						<propertyReferenceExpression name="DataViewController">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="fieldAttr"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="data-view"/>
																						<propertyReferenceExpression name="DataViewId">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="fieldAttr"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="data-tags"/>
																						<propertyReferenceExpression name="Tag">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<conditionStatement>
																					<condition>
																						<propertyReferenceExpression name="DataViewSearchOnStart">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="Add">
																							<target>
																								<variableReferenceExpression name="fieldAttr"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="data-search-on-start"/>
																								<primitiveExpression value="true" convertTo="String"/>
																							</parameters>
																						</methodInvokeExpression>
																					</trueStatements>
																				</conditionStatement>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="dataViews"/>
																					</target>
																					<parameters>
																						<objectCreateExpression type="Tuple">
																							<typeArguments>
																								<typeReference type="System.String"/>
																								<typeReference type="AttributeDictionary"/>
																							</typeArguments>
																							<parameters>
																								<stringFormatExpression format="{{0}}_{{1}}">
																									<variableReferenceExpression name="dataViewId"/>
																									<propertyReferenceExpression name="Name">
																										<variableReferenceExpression name="field"/>
																									</propertyReferenceExpression>
																								</stringFormatExpression>
																								<variableReferenceExpression name="fieldAttr"/>
																							</parameters>
																						</objectCreateExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</forStatement>
									</trueStatements>
									<methodReturnStatement>
										<variableReferenceExpression name="output"/>
									</methodReturnStatement>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Count">
												<variableReferenceExpression name="prefetches"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<!--<methodInvokeExpression methodName="Add">
                      <target>
                        <propertyReferenceExpression name="Items">
                          <propertyReferenceExpression name="Context"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="PrefetchData"/>
                        <methodInvokeExpression methodName="Join">
                          <target>
                            <typeReferenceExpression type="System.String"/>
                          </target>
                          <parameters>
                            <stringEmptyExpression/>
                            <variableReferenceExpression name="prefetches"/>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>-->
										<assignStatement>
											<variableReferenceExpression name="output"/>
											<methodInvokeExpression methodName="Join">
												<target>
													<typeReferenceExpression type="System.String"/>
												</target>
												<parameters>
													<stringEmptyExpression/>
													<variableReferenceExpression name="prefetches"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="output"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IntializeSiteMaster() -->
						<memberMethod name="InitializeSiteMaster">
							<attributes family="true"/>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="isTouchUI"/>
									<propertyReferenceExpression name="IsTouchClient">
										<typeReferenceExpression type="ApplicationServices"/>
									</propertyReferenceExpression>
								</assignStatement>
								<variableDeclarationStatement type="System.String" name="html">
									<init>
										<stringEmptyExpression/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="siteMasterPath">
									<init>
										<primitiveExpression value="~/site.desktop.html"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<fieldReferenceExpression name="isTouchUI"/>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="siteMasterPath"/>
											<primitiveExpression value="~/site.touch.html"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<variableReferenceExpression name="siteMasterPath"/>
									<methodInvokeExpression methodName="MapPath">
										<target>
											<propertyReferenceExpression name="Server"/>
										</target>
										<parameters>
											<variableReferenceExpression name="siteMasterPath"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="Exists">
												<target>
													<typeReferenceExpression type="File"/>
												</target>
												<parameters>
													<variableReferenceExpression name="siteMasterPath"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="siteMasterPath"/>
											<methodInvokeExpression methodName="MapPath">
												<target>
													<propertyReferenceExpression name="Server"/>
												</target>
												<parameters>
													<primitiveExpression value="~/site.html"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Exists">
											<target>
												<typeReferenceExpression type="File"/>
											</target>
											<parameters>
												<variableReferenceExpression name="siteMasterPath"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="html"/>
											<methodInvokeExpression methodName="ReadAllText">
												<target>
													<typeReferenceExpression type="File"/>
												</target>
												<parameters>
													<variableReferenceExpression name="siteMasterPath"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="Exception">
												<parameters>
													<primitiveExpression value="File site.html has not been found."/>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</falseStatements>
								</conditionStatement>
								<variableDeclarationStatement type="Match" name="htmlMatch">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<variableReferenceExpression name="html"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[<html(?'HtmlAttr'[\S\s]*?)>\s*<head(?'HeadAttr'[\S\s]*?)>\s*(?'Head'[\S\s]*?)\s*</head>\s*<body(?'BodyAttr'[\S\s]*?)>\s*(?'Body'[\S\s]*?)\s*</body>\s*</html>\s*]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="htmlMatch"/>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="Exception">
												<parameters>
													<primitiveExpression value="File site.html must contain 'head' and 'body' elements."/>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</trueStatements>
								</conditionStatement>
								<comment>instructions</comment>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls"/>
									</target>
									<parameters>
										<objectCreateExpression type="LiteralControl">
											<parameters>
												<methodInvokeExpression methodName="Substring">
													<target>
														<variableReferenceExpression name="html"/>
													</target>
													<parameters>
														<primitiveExpression value="0"/>
														<propertyReferenceExpression name="Index">
															<variableReferenceExpression name="htmlMatch"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</objectCreateExpression>
									</parameters>
								</methodInvokeExpression>
								<comment>html</comment>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls"/>
									</target>
									<parameters>
										<objectCreateExpression type="LiteralControl">
											<parameters>
												<stringFormatExpression >
													<xsl:attribute name="format" xml:space="preserve"><![CDATA[<html{0} xml:lang={1} lang="{1}">]]><xsl:text>&#13;&#10;</xsl:text></xsl:attribute>
													<propertyReferenceExpression name="Value">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<variableReferenceExpression name="htmlMatch"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="HtmlAttr"/>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="IetfLanguageTag">
														<propertyReferenceExpression name="CurrentUICulture">
															<propertyReferenceExpression name="CultureInfo"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</stringFormatExpression>
											</parameters>
										</objectCreateExpression>
									</parameters>
								</methodInvokeExpression>
								<comment>head</comment>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls"/>
									</target>
									<parameters>
										<objectCreateExpression type="HtmlHead"/>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<fieldReferenceExpression name="isTouchUI"/>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Controls">
													<propertyReferenceExpression name="Header"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<objectCreateExpression type="LiteralControl">
													<parameters>
														<primitiveExpression>
															<xsl:attribute name="value" xml:space="preserve"><![CDATA[<meta charset="utf-8">]]><xsl:text>&#13;&#10;</xsl:text></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Controls">
													<propertyReferenceExpression name="Header"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<objectCreateExpression type="LiteralControl">
													<parameters>
														<primitiveExpression>
															<xsl:attribute name="value" xml:space="preserve"><![CDATA[<meta http-equiv="Content-Type" content="text/html; charset=utf-8">]]><xsl:text>&#13;&#10;</xsl:text></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.String" name="headHtml">
									<init>
										<methodInvokeExpression methodName="Replace">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<variableReferenceExpression name="htmlMatch"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="Head"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[\s*<title([\s\S+]*?title>)\s*]]></xsl:attribute>
												</primitiveExpression>
												<stringEmptyExpression/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls">
											<propertyReferenceExpression name="Header"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<objectCreateExpression type="LiteralControl">
											<parameters>
												<variableReferenceExpression name="headHtml"/>
											</parameters>
										</objectCreateExpression>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<fieldReferenceExpression name="headContent"/>
									<objectCreateExpression type="LiteralContainer"/>
								</assignStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls">
											<propertyReferenceExpression name="Header"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<fieldReferenceExpression name="headContent"/>
									</parameters>
								</methodInvokeExpression>
								<!--<comment>preload</comment>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsTouchClient">
											<typeReferenceExpression type="ApplicationServicesBase"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Controls">
													<propertyReferenceExpression name="Header"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<objectCreateExpression type="LiteralControl">
													<parameters>
														<methodInvokeExpression methodName="ConfigureMaterialIconFont">
															<target>
																<typeReferenceExpression type="StylesheetGenerator"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ResolveAppUrl">
																	<parameters>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[<link rel="preload" href="~/fonts/MaterialIcons-Regular.woff2" as="font" type="font/woff2" crossorigin>]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>-->
								<comment>body</comment>
								<assignStatement>
									<fieldReferenceExpression name="bodyTag"/>
									<objectCreateExpression type="LiteralControl"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="bodyAttributes"/>
									<objectCreateExpression type="AttributeDictionary">
										<parameters>
											<propertyReferenceExpression name="Value">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Groups">
															<variableReferenceExpression name="htmlMatch"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="BodyAttr"/>
													</indices>
												</arrayIndexerExpression>
											</propertyReferenceExpression>
										</parameters>
									</objectCreateExpression>
								</assignStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls"/>
									</target>
									<parameters>
										<fieldReferenceExpression name="bodyTag"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="System.String" name="themePath">
									<init>
										<methodInvokeExpression methodName="MapPath">
											<target>
												<propertyReferenceExpression name="Server"/>
											</target>
											<parameters>
												<primitiveExpression value="~/App_Themes/{$Namespace}"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Exists">
											<target>
												<typeReferenceExpression type="Directory"></typeReferenceExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="themePath"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="System.String" name="stylesheetFileName"/>
											<target>
												<methodInvokeExpression methodName="GetFiles">
													<target>
														<typeReferenceExpression type="Directory"/>
													</target>
													<parameters>
														<variableReferenceExpression name="themePath"/>
														<primitiveExpression value="*.css"/>
													</parameters>
												</methodInvokeExpression>
											</target>
											<statements>
												<variableDeclarationStatement type="System.String" name="fileName">
													<init>
														<methodInvokeExpression methodName="GetFileName">
															<target>
																<typeReferenceExpression type="Path"/>
															</target>
															<parameters>
																<variableReferenceExpression name="stylesheetFileName"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Equals">
																<target>
																	<variableReferenceExpression name="fileName"/>
																</target>
																<parameters>
																	<primitiveExpression value="_Theme_{a:project/a:theme/@name}.css"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="HtmlLink" name="link">
															<init>
																<objectCreateExpression type="HtmlLink"/>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<propertyReferenceExpression name="Href">
																<variableReferenceExpression name="link"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="Add">
																<primitiveExpression value="~/App_Themes/{$Namespace}/"/>
																<variableReferenceExpression name="fileName"/>
															</binaryOperatorExpression>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Attributes">
																		<variableReferenceExpression name="link"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="type"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="text/css"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Attributes">
																		<variableReferenceExpression name="link"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="rel"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="stylesheet"/>
														</assignStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<propertyReferenceExpression name="Controls">
																	<propertyReferenceExpression name="Header"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="link"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<comment>form</comment>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls"/>
									</target>
									<parameters>
										<objectCreateExpression type="HtmlForm"/>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<propertyReferenceExpression name="ID">
										<propertyReferenceExpression name="Form"/>
									</propertyReferenceExpression>
									<primitiveExpression value="aspnetForm"/>
								</assignStatement>
								<comment>ScriptManager</comment>
								<variableDeclarationStatement type="ScriptManager" name="sm">
									<init>
										<objectCreateExpression type="ScriptManager"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="ID">
										<variableReferenceExpression name="sm"/>
									</propertyReferenceExpression>
									<primitiveExpression value="sm"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="AjaxFrameworkMode">
										<variableReferenceExpression name="sm"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="Disabled">
										<typeReferenceExpression type="AjaxFrameworkMode"/>
									</propertyReferenceExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="EnableCombinedScript">
											<typeReferenceExpression type="AquariumExtenderBase"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="EnableScriptLocalization">
												<variableReferenceExpression name="sm"/>
											</propertyReferenceExpression>
											<primitiveExpression value="false"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="ScriptMode">
										<variableReferenceExpression name="sm"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="Release">
										<typeReferenceExpression type="ScriptMode"/>
									</propertyReferenceExpression>
								</assignStatement>
								<!--<attachEventStatement>
                  <event name="ResolveScriptReference">
                    <variableReferenceExpression name="sm"/>
                  </event>
                  <listener>
                    <delegateCreateExpression type="EventHandler" methodName="sm_ResolveScriptReference">
                      <typeArguments>
                        <typeReference type="ScriptReferenceEventArgs"/>
                      </typeArguments>
                      <target>
                        <thisReferenceExpression/>
                      </target>
                    </delegateCreateExpression>
                  </listener>
                </attachEventStatement>-->
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls">
											<propertyReferenceExpression name="Form"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<variableReferenceExpression name="sm"/>
									</parameters>
								</methodInvokeExpression>
								<comment>SiteMapDataSource</comment>
								<variableDeclarationStatement type="SiteMapDataSource" name="siteMapDataSource1">
									<init>
										<objectCreateExpression type="SiteMapDataSource"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="ID">
										<variableReferenceExpression name="siteMapDataSource1"/>
									</propertyReferenceExpression>
									<primitiveExpression value="SiteMapDataSource1"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="ShowStartingNode">
										<variableReferenceExpression name="siteMapDataSource1"/>
									</propertyReferenceExpression>
									<primitiveExpression value="false"/>
								</assignStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls">
											<propertyReferenceExpression name="Form"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<variableReferenceExpression name="siteMapDataSource1"/>
									</parameters>
								</methodInvokeExpression>
								<comment>parse and initialize placeholders</comment>
								<variableDeclarationStatement type="System.String" name="body">
									<init>
										<propertyReferenceExpression name="Value">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Groups">
														<variableReferenceExpression name="htmlMatch"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="Body"/>
												</indices>
											</arrayIndexerExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="Match" name="placeholderMatch">
									<init>
										<methodInvokeExpression  methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<variableReferenceExpression name="body"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[<div\s+data-role\s*=\s*"placeholder"(?'Attributes'[\s\S]+?)>\s*(?'DefaultContent'[\s\S]*?)\s*</div>]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Int32" name="startPos">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<propertyReferenceExpression name="Success">
											<variableReferenceExpression name="placeholderMatch"/>
										</propertyReferenceExpression>
									</test>
									<statements>
										<variableDeclarationStatement type="AttributeDictionary" name="attributes">
											<init>
												<objectCreateExpression type="AttributeDictionary">
													<parameters>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="placeholderMatch"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Attributes"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<comment>create placeholder content</comment>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Controls">
													<propertyReferenceExpression name="Form"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<objectCreateExpression type="LiteralControl">
													<parameters>
														<methodInvokeExpression methodName="Substring">
															<target>
																<variableReferenceExpression name="body"/>
															</target>
															<parameters>
																<variableReferenceExpression name="startPos"/>
																<binaryOperatorExpression operator="Subtract">
																	<propertyReferenceExpression name="Index">
																		<variableReferenceExpression name="placeholderMatch"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="startPos"/>
																</binaryOperatorExpression>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
										<variableDeclarationStatement type="System.String" name="placeholder">
											<init>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="attributes"/>
													</target>
													<indices>
														<primitiveExpression value="data-placeholder"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="defaultContent">
											<init>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<variableReferenceExpression name="placeholderMatch"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="DefaultContent"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="CreatePlaceholder">
														<parameters>
															<propertyReferenceExpression name="Controls">
																<propertyReferenceExpression name="Form"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="placeholder"/>
															<variableReferenceExpression name="defaultContent"/>
															<variableReferenceExpression name="attributes"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="LiteralContainer" name="placeholderControl">
													<init>
														<objectCreateExpression type="LiteralContainer"/>
													</init>
												</variableDeclarationStatement>
												<assignStatement>
													<propertyReferenceExpression name="Text">
														<variableReferenceExpression name="placeholderControl"/>
													</propertyReferenceExpression>
													<variableReferenceExpression name="defaultContent"/>
												</assignStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<propertyReferenceExpression name="Controls">
															<propertyReferenceExpression name="Form"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="placeholderControl"/>
													</parameters>
												</methodInvokeExpression>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="placeholder"/>
															<primitiveExpression value="page-header"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<fieldReferenceExpression name="pageHeaderContent"/>
															<variableReferenceExpression name="placeholderControl"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="placeholder"/>
															<primitiveExpression value="page-title"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<fieldReferenceExpression name="pageTitleContent"/>
															<variableReferenceExpression name="placeholderControl"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="placeholder"/>
															<primitiveExpression value="page-side-bar"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<fieldReferenceExpression name="pageSideBarContent"/>
															<variableReferenceExpression name="placeholderControl"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="placeholder"/>
															<primitiveExpression value="page-content"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<fieldReferenceExpression name="pageContent"/>
															<variableReferenceExpression name="placeholderControl"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="placeholder"/>
															<primitiveExpression value="page-footer"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<fieldReferenceExpression name="pageFooterContent"/>
															<variableReferenceExpression name="placeholderControl"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="startPos"/>
											<binaryOperatorExpression operator="Add">
												<propertyReferenceExpression name="Index">
													<variableReferenceExpression name="placeholderMatch"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="Length">
													<variableReferenceExpression name="placeholderMatch"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="placeholderMatch"/>
											<methodInvokeExpression methodName="NextMatch">
												<target>
													<variableReferenceExpression name="placeholderMatch"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</statements>
								</whileStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="startPos"/>
											<propertyReferenceExpression name="Length">
												<variableReferenceExpression name="body"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Controls">
													<propertyReferenceExpression name="Form"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<objectCreateExpression type="LiteralControl">
													<parameters>
														<methodInvokeExpression methodName="Substring">
															<target>
																<variableReferenceExpression name="body"/>
															</target>
															<parameters>
																<variableReferenceExpression name="startPos"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<comment>end body</comment>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls"/>
									</target>
									<parameters>
										<objectCreateExpression type="LiteralControl">
											<parameters>
												<primitiveExpression>
													<xsl:attribute name="value" xml:space="preserve"><xsl:text>&#13;&#10;</xsl:text><![CDATA[</body>]]><xsl:text>&#13;&#10;</xsl:text></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</objectCreateExpression>
									</parameters>
								</methodInvokeExpression>
								<comment>end html</comment>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls"/>
									</target>
									<parameters>
										<objectCreateExpression type="LiteralControl">
											<parameters>
												<primitiveExpression>
													<xsl:attribute name="value" xml:space="preserve"><xsl:text>&#13;&#10;</xsl:text><![CDATA[</html>]]><xsl:text>&#13;&#10;</xsl:text></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</objectCreateExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method CreatePlaceholder(ControlCollection, string, string, AttributeDictionary) -->
						<memberMethod returnType="System.Boolean" name="CreatePlaceholder">
							<attributes family="true"/>
							<parameters>
								<parameter type="ControlCollection" name="container"/>
								<parameter type="System.String" name="placeholder"/>
								<parameter type="System.String" name="defaultContent"/>
								<parameter type="AttributeDictionary" name="attributes"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="placeholder"/>
											<primitiveExpression value="membership-bar"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<xsl:if test="$MembershipEnabled='true' or /a:project/a:membership[@windowsAuthentication='true' or @customSecurity='true' or @activeDirectory='true']">
											<variableDeclarationStatement type="MembershipBar" name="mb">
												<init>
													<objectCreateExpression type="MembershipBar"/>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<propertyReferenceExpression name="ID">
													<variableReferenceExpression name="mb"/>
												</propertyReferenceExpression>
												<primitiveExpression value="mb"/>
											</assignStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<indices>
																<primitiveExpression value="data-display-remember-me"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="false" convertTo="String"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="DisplayRememberMe">
															<variableReferenceExpression name="mb"/>
														</propertyReferenceExpression>
														<primitiveExpression value="false"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<indices>
																<primitiveExpression value="data-remember-me-set"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="true" convertTo="String"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="RememberMeSet">
															<variableReferenceExpression name="mb"/>
														</propertyReferenceExpression>
														<primitiveExpression value="true"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<indices>
																<primitiveExpression value="data-display-password-recovery"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="false" convertTo="String"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="DisplayPasswordRecovery">
															<variableReferenceExpression name="mb"/>
														</propertyReferenceExpression>
														<primitiveExpression value="false"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<indices>
																<primitiveExpression value="data-display-sign-up"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="false" convertTo="String"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="DisplaySignUp">
															<variableReferenceExpression name="mb"/>
														</propertyReferenceExpression>
														<primitiveExpression value="false"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<indices>
																<primitiveExpression value="data-display-my-account"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="false" convertTo="String"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="DisplayMyAccount">
															<variableReferenceExpression name="mb"/>
														</propertyReferenceExpression>
														<primitiveExpression value="false"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<indices>
																<primitiveExpression value="data-display-help"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="false" convertTo="String"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="DisplayHelp">
															<variableReferenceExpression name="mb"/>
														</propertyReferenceExpression>
														<primitiveExpression value="false"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<indices>
																<primitiveExpression value="data-display-login"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="false" convertTo="String"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="DisplayLogin">
															<variableReferenceExpression name="mb"/>
														</propertyReferenceExpression>
														<primitiveExpression value="false"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<indices>
																<primitiveExpression value="data-idle-user-timeout"/>
															</indices>
														</arrayIndexerExpression>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="IdleUserTimeout">
															<variableReferenceExpression name="mb"/>
														</propertyReferenceExpression>
														<convertExpression to="Int32">
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="attributes"/>
																</target>
																<indices>
																	<primitiveExpression value="data-idle-user-timeout"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<indices>
																<primitiveExpression value="data-enable-history"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="true" convertTo="String"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="EnableHistory">
															<variableReferenceExpression name="mb"/>
														</propertyReferenceExpression>
														<primitiveExpression value="true"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<indices>
																<primitiveExpression value="data-enable-permalinks"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="true" convertTo="String"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="EnablePermalinks">
															<variableReferenceExpression name="mb"/>
														</propertyReferenceExpression>
														<primitiveExpression value="true"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<methodInvokeExpression methodName="Add">
												<target>
													<argumentReferenceExpression name="container"/>
												</target>
												<parameters>
													<variableReferenceExpression name="mb"/>
												</parameters>
											</methodInvokeExpression>
											<methodReturnStatement>
												<primitiveExpression value="true"/>
											</methodReturnStatement>
										</xsl:if>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="placeholder"/>
											<primitiveExpression value="menu-bar"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="HtmlGenericControl" name="menuDiv">
											<init>
												<objectCreateExpression type="HtmlGenericControl"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="TagName">
												<variableReferenceExpression name="menuDiv"/>
											</propertyReferenceExpression>
											<primitiveExpression value="div"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="ID">
												<variableReferenceExpression name="menuDiv"/>
											</propertyReferenceExpression>
											<primitiveExpression value="PageMenuBar"/>
										</assignStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Attributes">
														<variableReferenceExpression name="menuDiv"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="class"/>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="PageMenuBar"/>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<argumentReferenceExpression name="container"/>
											</target>
											<parameters>
												<variableReferenceExpression name="menuDiv"/>
											</parameters>
										</methodInvokeExpression>
										<variableDeclarationStatement type="MenuExtender" name="menu">
											<init>
												<objectCreateExpression type="MenuExtender"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="ID">
												<variableReferenceExpression name="menu"/>
											</propertyReferenceExpression>
											<primitiveExpression value="Menu1"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="DataSourceID">
												<variableReferenceExpression name="menu"/>
											</propertyReferenceExpression>
											<primitiveExpression value="SiteMapDataSource1"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="TargetControlID">
												<variableReferenceExpression name="menu"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="ID">
												<variableReferenceExpression name="menuDiv"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="HoverStyle">
												<variableReferenceExpression name="menu"/>
											</propertyReferenceExpression>
											<castExpression targetType="MenuHoverStyle">
												<methodInvokeExpression methodName="ConvertFromString">
													<target>
														<methodInvokeExpression methodName="GetConverter">
															<target>
																<typeReferenceExpression type="TypeDescriptor"/>
															</target>
															<parameters>
																<typeofExpression type="MenuHoverStyle"/>
															</parameters>
														</methodInvokeExpression>
													</target>
													<parameters>
														<methodInvokeExpression methodName="ValueOf">
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<parameters>
																<primitiveExpression value="data-hover-style"/>
																<primitiveExpression value="Auto"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</castExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="PopupPosition">
												<variableReferenceExpression name="menu"/>
											</propertyReferenceExpression>
											<castExpression targetType="MenuPopupPosition">
												<methodInvokeExpression methodName="ConvertFromString">
													<target>
														<methodInvokeExpression methodName="GetConverter">
															<target>
																<typeReferenceExpression type="TypeDescriptor"/>
															</target>
															<parameters>
																<typeofExpression type="MenuPopupPosition"/>
															</parameters>
														</methodInvokeExpression>
													</target>
													<parameters>
														<methodInvokeExpression methodName="ValueOf">
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<parameters>
																<primitiveExpression value="data-popup-position"/>
																<primitiveExpression value="Left"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</castExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="ShowSiteActions">
												<variableReferenceExpression name="menu"/>
											</propertyReferenceExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="attributes"/>
													</target>
													<indices>
														<primitiveExpression value="data-show-site-actions"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="true" convertTo="String"/>
											</binaryOperatorExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="PresentationStyle">
												<variableReferenceExpression name="menu"/>
											</propertyReferenceExpression>
											<castExpression targetType="MenuPresentationStyle">
												<methodInvokeExpression methodName="ConvertFromString">
													<target>
														<methodInvokeExpression methodName="GetConverter">
															<target>
																<typeReferenceExpression type="TypeDescriptor"/>
															</target>
															<parameters>
																<typeofExpression type="MenuPresentationStyle"/>
															</parameters>
														</methodInvokeExpression>
													</target>
													<parameters>
														<methodInvokeExpression methodName="ValueOf">
															<target>
																<argumentReferenceExpression name="attributes"/>
															</target>
															<parameters>
																<primitiveExpression value="data-presentation-style"/>
																<primitiveExpression value="MultiLevel"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</castExpression>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<argumentReferenceExpression name="container"/>
											</target>
											<parameters>
												<variableReferenceExpression name="menu"/>
											</parameters>
										</methodInvokeExpression>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="placeholder"/>
											<primitiveExpression value="site-map-path"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="SiteMapPath" name="siteMapPath1">
											<init>
												<objectCreateExpression type="SiteMapPath"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="ID">
												<variableReferenceExpression name="siteMapPath1"/>
											</propertyReferenceExpression>
											<primitiveExpression value="SiteMapPath1"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="CssClass">
												<variableReferenceExpression name="siteMapPath1"/>
											</propertyReferenceExpression>
											<primitiveExpression value="SiteMapPath"/>
										</assignStatement>
										<!-- 
                siteMapPath1.PathSeparatorStyle.CssClass = "PathSeparator";
                siteMapPath1.CurrentNodeStyle.CssClass = "CurrentNode";
                siteMapPath1.NodeStyle.CssClass = "Node";
                siteMapPath1.RootNodeStyle.CssClass = "RootNode";
                    -->
										<assignStatement>
											<propertyReferenceExpression name="CssClass">
												<propertyReferenceExpression name="PathSeparatorStyle">
													<variableReferenceExpression name="siteMapPath1"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="PathSeparator"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="CssClass">
												<propertyReferenceExpression name="CurrentNodeStyle">
													<variableReferenceExpression name="siteMapPath1"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="CurrentNode"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="CssClass">
												<propertyReferenceExpression name="NodeStyle">
													<variableReferenceExpression name="siteMapPath1"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="Node"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="CssClass">
												<propertyReferenceExpression name="RootNodeStyle">
													<variableReferenceExpression name="siteMapPath1"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="RootNode"/>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<argumentReferenceExpression name="container"/>
											</target>
											<parameters>
												<variableReferenceExpression name="siteMapPath1"/>
											</parameters>
										</methodInvokeExpression>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OnPreRender(object, EventArgs) -->
						<memberMethod name="OnPreRender">
							<attributes override="true" family="true"/>
							<parameters>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="RegisterCssLinks">
									<target>
										<typeReferenceExpression type="ApplicationServices"/>
									</target>
									<parameters>
										<thisReferenceExpression/>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<fieldReferenceExpression name="isTouchUI"/>
									</condition>
									<trueStatements>
										<comment>hide top-level literals</comment>
										<foreachStatement>
											<variable type="Control" name="c" var="false"/>
											<target>
												<propertyReferenceExpression name="Controls">
													<propertyReferenceExpression name="Form"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IsTypeOf">
															<variableReferenceExpression name="c"/>
															<typeReferenceExpression type="LiteralControl"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="Visible">
																<variableReferenceExpression name="c"/>
															</propertyReferenceExpression>
															<primitiveExpression value="false"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<comment>look deep in children for ASP.NET controls</comment>
										<methodInvokeExpression methodName="HideAspNetControls">
											<parameters>
												<propertyReferenceExpression name="Controls">
													<propertyReferenceExpression name="Form"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="OnPreRender">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<argumentReferenceExpression name="e"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method Render(HtmlTextWriter ) -->
						<memberMethod name="Render">
							<attributes override="true" family="true"/>
							<parameters>
								<parameter type="HtmlTextWriter" name="writer"/>
							</parameters>
							<statements>
								<comment>create page content</comment>
								<variableDeclarationStatement type="StringBuilder" name="sb">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="HtmlTextWriter" name="w">
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
										<variableReferenceExpression name="w"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Flush">
									<target>
										<variableReferenceExpression name="w"/>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Close">
									<target>
										<variableReferenceExpression name="w"/>
									</target>
								</methodInvokeExpression>
								<variableDeclarationStatement type="System.String" name="content">
									<init>
										<methodInvokeExpression methodName="ToString">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<fieldReferenceExpression name="isTouchUI"/>
									</condition>
									<trueStatements>
										<comment>perform cleanup for super lightweight output</comment>
										<assignStatement>
											<variableReferenceExpression name="content"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="content"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[(<body([\s\S]*?)>\s*)<form\s+([\s\S]*?)</div>\s*]]></xsl:attribute>
													</primitiveExpression>
													<primitiveExpression value="$1"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="content"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="content"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[\s*</form>\s*(</body>)]]></xsl:attribute>
													</primitiveExpression>
													<primitiveExpression value="&#13;&#10;$1"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="content"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="content"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[<script(?'Attributes'[\s\S]*?)>(?'Script'[\s\S]*?)</script>\s*]]></xsl:attribute>
													</primitiveExpression>
													<addressOfExpression>
														<methodReferenceExpression methodName="DoValidateScript"/>
													</addressOfExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="content"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="content"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[<title>\s*([\s\S]+?)\s*</title>]]></xsl:attribute>
													</primitiveExpression>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[<title>$1</title>]]></xsl:attribute>
													</primitiveExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="content"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="content"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[<div>\s*<input([\s\S]+?)VIEWSTATEGENERATOR([\s\S]+?)</div>]]></xsl:attribute>
													</primitiveExpression>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="content"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="content"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[</script>.+?(<div.+?class="PageMenuBar"></div>)\s*]]></xsl:attribute>
													</primitiveExpression>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[</script>]]></xsl:attribute>
													</primitiveExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="content"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="content"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[\$get\(".*?mb_d"\)]]></xsl:attribute>
													</primitiveExpression>
													<primitiveExpression value="null" convertTo="String"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="content"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="content"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[\s*(<footer[\s\S]+?</small></footer>)\s*]]></xsl:attribute>
													</primitiveExpression>
													<primitiveExpression value="$1"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="content"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="content"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[\s*type="text/javascript"\s*]]></xsl:attribute>
													</primitiveExpression>
													<primitiveExpression value=" "/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<variableReferenceExpression name="content"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<variableReferenceExpression name="content"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[(>\s+)//<\!\[CDATA\[\s*]]></xsl:attribute>
											</primitiveExpression>
											<primitiveExpression value="$1"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="content"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<variableReferenceExpression name="content"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[\s*//\]\]>\s*</script>]]></xsl:attribute>
											</primitiveExpression>
											<primitiveExpression>
												<xsl:attribute name="value" xml:space="preserve"><xsl:text>&#13;&#10;</xsl:text><![CDATA[</script>]]></xsl:attribute>
											</primitiveExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="content"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<variableReferenceExpression name="content"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[<div\s+data-role\s*="placeholder"\s+(?'Attributes'[\s\S]+?)>(?'DefaultContent'[\s\S]*?)</div>]]></xsl:attribute>
											</primitiveExpression>
											<addressOfExpression>
												<methodReferenceExpression methodName="DoReplacePlaceholder"/>
											</addressOfExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Items">
														<propertyReferenceExpression name="Context"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="AppState"/>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="rawText">
											<init>
												<castExpression targetType="System.String">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Items">
																<propertyReferenceExpression name="Context"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="ui-framework-none.text"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="rawText"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="scripts">
													<init>
														<methodInvokeExpression methodName="Matches">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="content"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[<script[\s\S]+?</script>]]></xsl:attribute>
																</primitiveExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="GreaterThan">
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="scripts"/>
															</propertyReferenceExpression>
															<primitiveExpression value="0"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="lastScript">
															<init>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="scripts"/>
																	</target>
																	<indices>
																		<binaryOperatorExpression operator="Subtract">
																			<propertyReferenceExpression name="Count">
																				<variableReferenceExpression name="scripts"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="1"/>
																		</binaryOperatorExpression>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="Contains">
																	<target>
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="lastScript"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="Web.Menu.Nodes.Menu1"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="content"/>
																	<binaryOperatorExpression operator="Add">
																		<methodInvokeExpression methodName="Replace">
																			<target>
																				<variableReferenceExpression name="rawText"/>
																			</target>
																			<parameters>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[</body>]]></xsl:attribute>
																				</primitiveExpression>
																				<methodInvokeExpression methodName="Replace">
																					<target>
																						<propertyReferenceExpression name="Value">
																							<variableReferenceExpression name="lastScript"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<primitiveExpression value="Web.Menu.Nodes.Menu1"/>
																						<primitiveExpression value="var __menu"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[</body>]]></xsl:attribute>
																		</primitiveExpression>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<assignStatement>
																	<variableReferenceExpression name="content"/>
																	<variableReferenceExpression name="rawText"/>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<variableReferenceExpression name="content"/>
									<methodInvokeExpression methodName="ResolveAppUrl">
										<parameters>
											<variableReferenceExpression name="content"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="ContentType">
										<propertyReferenceExpression name="Response">
											<propertyReferenceExpression name="Context"/>
										</propertyReferenceExpression>
									</propertyReferenceExpression>
									<primitiveExpression value="text/html; charset=utf-8"/>
								</assignStatement>
								<methodInvokeExpression methodName="CompressOutput">
									<target>
										<typeReferenceExpression type="ApplicationServicesBase"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="Context"/>
										<variableReferenceExpression name="content"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method DoReplacePlaceholder(Match) -->
						<memberMethod returnType="System.String" name="DoReplacePlaceholder">
							<attributes private="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="AttributeDictionary" name="attributes">
									<init>
										<objectCreateExpression type="AttributeDictionary">
											<parameters>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<argumentReferenceExpression name="m"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="Attributes"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="defaultContent">
									<init>
										<propertyReferenceExpression name="Value">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Groups">
														<argumentReferenceExpression name="m"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="DefaultContent"/>
												</indices>
											</arrayIndexerExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="replacement">
									<init>
										<methodInvokeExpression methodName="ReplaceStaticPlaceholder">
											<parameters>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="attributes"/>
													</target>
													<indices>
														<primitiveExpression value="data-placeholder"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="attributes"/>
												<variableReferenceExpression name="defaultContent"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="replacement"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Value">
												<argumentReferenceExpression name="m"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
									<falseStatements>
										<methodReturnStatement>
											<variableReferenceExpression name="replacement"/>
										</methodReturnStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ReplaceStaticPlaceholder(string, AttributeDictionary, string) -->
						<memberMethod returnType="System.String" name="ReplaceStaticPlaceholder">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
								<parameter type="AttributeDictionary" name="attributes"/>
								<parameter type="System.String" name="defaultContent"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method HideAspNetControls(ControlCollection) -->
						<memberMethod name="HideAspNetControls">
							<attributes final="true" private="true"/>
							<parameters>
								<parameter type="ControlCollection" name="controls"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Int32" name="i">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="i"/>
											<propertyReferenceExpression name="Count">
												<argumentReferenceExpression name="controls"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</test>
									<statements>
										<variableDeclarationStatement type="Control" name="c">
											<init>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="controls"/>
													</target>
													<indices>
														<variableReferenceExpression name="i"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="IsTypeOf">
														<variableReferenceExpression name="c"/>
														<typeReferenceExpression type="SiteMapPath"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="BooleanOr">
														<binaryOperatorExpression operator="IsTypeOf">
															<variableReferenceExpression name="c"/>
															<typeReferenceExpression type="Image"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="IsTypeOf">
															<variableReferenceExpression name="c"/>
															<typeReferenceExpression type="TreeView"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Remove">
													<target>
														<argumentReferenceExpression name="controls"/>
													</target>
													<parameters>
														<variableReferenceExpression name="c"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="HideAspNetControls">
													<parameters>
														<propertyReferenceExpression name="Controls">
															<variableReferenceExpression name="c"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
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
							</statements>
						</memberMethod>
						<!-- DoValidateStript(Match) -->
						<memberMethod returnType="System.String" name="DoValidateScript">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="script">
									<init>
										<propertyReferenceExpression name="Value">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Groups">
														<argumentReferenceExpression name="m"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="Script"/>
												</indices>
											</arrayIndexerExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Contains">
											<target>
												<variableReferenceExpression name="script"/>
											</target>
											<parameters>
												<primitiveExpression value="aspnetForm"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<stringEmptyExpression/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="Match" name="srcMatch">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<argumentReferenceExpression name="m"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="Attributes"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[src="(.+?)"]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Success">
											<variableReferenceExpression name="srcMatch"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String" name="src">
											<init>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<variableReferenceExpression name="srcMatch"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="1"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Contains">
													<target>
														<variableReferenceExpression name="src"/>
													</target>
													<parameters>
														<primitiveExpression value=".axd?"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<tryStatement>
													<statements>
														<variableDeclarationStatement type="WebClient" name="client">
															<init>
																<objectCreateExpression type="WebClient"/>
															</init>
														</variableDeclarationStatement>
														<xsl:if test="/a:project/a:membership/@windowsAuthentication='true'">
															<assignStatement>
																<propertyReferenceExpression name="UseDefaultCredentials">
																	<variableReferenceExpression name="client"/>
																</propertyReferenceExpression>
																<primitiveExpression value="true"/>
															</assignStatement>
														</xsl:if>
														<assignStatement>
															<variableReferenceExpression name="script"/>
															<methodInvokeExpression methodName="DownloadString">
																<target>
																	<variableReferenceExpression name="client"/>
																</target>
																<parameters>
																	<stringFormatExpression format="http://{{0}}/{{1}}">
																		<propertyReferenceExpression name="Authority">
																			<propertyReferenceExpression name="Url">
																				<propertyReferenceExpression name="Request"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																		<variableReferenceExpression name="src"/>
																	</stringFormatExpression>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</statements>
													<catch exceptionType="Exception">
														<methodReturnStatement>
															<variableReferenceExpression name="script"/>
														</methodReturnStatement>
													</catch>
												</tryStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Contains">
															<target>
																<variableReferenceExpression name="script"/>
															</target>
															<parameters>
																<primitiveExpression value="WebForm_PostBack"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<stringEmptyExpression/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<variableReferenceExpression name="script"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<propertyReferenceExpression name="Value">
												<argumentReferenceExpression name="m"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<primitiveExpression value="WebForm_InitCallback();"/>
											<stringEmptyExpression/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="script"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class SiteVirtualFile -->
				<!--<typeDeclaration name="SiteVirtualFile">
          <baseTypes>
            <typeReference type="VirtualFile"/>
          </baseTypes>
          <members>
            -->
				<!-- constructor -->
				<!--
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="virtualPath"/>
              </parameters>
              <baseConstructorArgs>
                <argumentReferenceExpression name="virtualPath"/>
              </baseConstructorArgs>
            </constructor>
            -->
				<!-- method Open() -->
				<!--
            <memberMethod returnType="Stream" name="Open">
              <attributes public="true" override="true"/>
              <statements>
                <variableDeclarationStatement type="System.String" name="text">
                  <init>
                    <stringEmptyExpression/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="VirtualPath">
                        <thisReferenceExpression/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="/Site.aspx"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="text"/>
                      <primitiveExpression>
                        <xsl:attribute name="value" xml:space="preserve"><![CDATA[<%@ Page Inherits="]]><xsl:value-of select="$Namespace"/><![CDATA[.Handlers.Site"%>]]></xsl:attribute>
                      </primitiveExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="VirtualPath"/>
                          <methodInvokeExpression methodName="Substring">
                            <target>
                              <propertyReferenceExpression name="DefaultServicePath">
                                <typeReferenceExpression type="AquariumExtenderBase"/>
                              </propertyReferenceExpression>
                            </target>
                            <parameters>
                              <primitiveExpression value="1"/>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="text"/>
                          <primitiveExpression>
                            <xsl:attribute name="value" xml:space="preserve"><![CDATA[<%@ WebService Class="]]><xsl:value-of select="$Namespace"/><![CDATA[.Services.DataControllerService"%>]]></xsl:attribute>
                          </primitiveExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
                <variableDeclarationStatement type="System.Byte[]" name="data">
                  <init>
                    <methodInvokeExpression methodName="GetBytes">
                      <target>
                        <propertyReferenceExpression name="UTF8">
                          <typeReferenceExpression type="Encoding"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="text"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="MemoryStream" name="stream">
                  <init>
                    <objectCreateExpression type="MemoryStream"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Write">
                  <target>
                    <variableReferenceExpression name="stream"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="data"/>
                    <primitiveExpression value="0"/>
                    <propertyReferenceExpression name="Length">
                      <variableReferenceExpression name="data"/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
                <assignStatement>
                  <propertyReferenceExpression name="Position">
                    <variableReferenceExpression name="stream"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="0"/>
                </assignStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="stream"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        -->
				<!-- class SiteVirtualPathProvider -->
				<!--
        <typeDeclaration name="SiteVirtualPathProvider">
          <attributes public="true"/>
          <baseTypes>
            <typeReference type="VirtualPathProvider"/>
          </baseTypes>
          <members>
            -->
				<!-- field Registered -->
				<!--
            <memberField type="System.Boolean" name="registered">
              <attributes static="true" private="true"/>
            </memberField>
            -->
				<!-- method IsPathKnown(string) -->
				<!--
            <memberMethod returnType="System.Boolean" name="IsPathKnown">
              <attributes private="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="virtualPath"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <binaryOperatorExpression operator="BooleanOr">
                    <binaryOperatorExpression operator="ValueEquality">
                      <argumentReferenceExpression name="virtualPath"/>
                      <primitiveExpression value="/Site.aspx"/>
                    </binaryOperatorExpression>
                    <binaryOperatorExpression operator="ValueEquality">
                      <argumentReferenceExpression name="virtualPath"/>
                      <methodInvokeExpression methodName="Substring">
                        <target>
                          <propertyReferenceExpression name="DefaultServicePath">
                            <typeReferenceExpression type="AquariumExtenderBase"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <primitiveExpression value="1"/>
                        </parameters>
                      </methodInvokeExpression>
                    </binaryOperatorExpression>
                  </binaryOperatorExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            -->
				<!-- method AppInitialize-->
				<!--
            <memberMethod name="AppInitialize">
              <attributes static="true" public="true"/>
              <statements>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <fieldReferenceExpression name="registered"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="SiteVirtualPathProvider" name="svpp">
                      <init>
                        <objectCreateExpression type="SiteVirtualPathProvider"/>
                      </init>
                    </variableDeclarationStatement>
                    <methodInvokeExpression methodName="RegisterVirtualPathProvider">
                      <target>
                        <typeReferenceExpression type="HostingEnvironment"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="svpp"/>
                      </parameters>
                    </methodInvokeExpression>
                    <assignStatement>
                      <fieldReferenceExpression name="registered"/>
                      <primitiveExpression value="true"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            -->
				<!-- method FileExists(string) -->
				<!--
            <memberMethod returnType="System.Boolean" name="FileExists">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="virtualPath"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="IsPathKnown">
                      <parameters>
                        <argumentReferenceExpression name="virtualPath"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <primitiveExpression value="true"/>
                    </methodReturnStatement>
                  </trueStatements>
                  <falseStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="FileExists">
                        <target>
                          <propertyReferenceExpression name="Previous"/>
                        </target>
                        <parameters>
                          <argumentReferenceExpression name="virtualPath"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            -->
				<!-- method GetFile(string) -->
				<!--
            <memberMethod returnType="VirtualFile" name="GetFile">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="virtualPath"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="IsPathKnown">
                      <parameters>
                        <argumentReferenceExpression name="virtualPath"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <objectCreateExpression type="SiteVirtualFile">
                        <parameters>
                          <argumentReferenceExpression name="virtualPath"/>
                        </parameters>
                      </objectCreateExpression>
                    </methodReturnStatement>
                  </trueStatements>
                  <falseStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="GetFile">
                        <target>
                          <propertyReferenceExpression name="Previous"/>
                        </target>
                        <parameters>
                          <argumentReferenceExpression name="virtualPath"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            -->
				<!-- method GetCacheDependency(string, IEnumerable, DateTime) -->
				<!--
            <memberMethod returnType="CacheDependency" name="GetCacheDependency">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="virtualPath"/>
                <parameter type="IEnumerable" name="virtualPathDependencies"/>
                <parameter type="DateTime" name="utcStart"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="IsPathKnown">
                      <parameters>
                        <argumentReferenceExpression name="virtualPath"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <primitiveExpression value="null"/>
                    </methodReturnStatement>
                  </trueStatements>
                  <falseStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="GetCacheDependency">
                        <target>
                          <propertyReferenceExpression name="Previous"/>
                        </target>
                        <parameters>
                          <argumentReferenceExpression name="virtualPath"/>
                          <argumentReferenceExpression name="virtualPathDependencies"/>
                          <argumentReferenceExpression name="utcStart"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>-->
				<!-- class LiteralContainer -->
				<typeDeclaration name="LiteralContainer">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="Panel"/>
					</baseTypes>
					<members>
						<!-- property Text-->
						<memberProperty type="System.String" name="Text">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- method Render(HtmlTextWriter) -->
						<memberMethod name="Render">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="HtmlTextWriter" name="output"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Count">
												<propertyReferenceExpression name="Controls"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="Control" name="c" var="false"/>
											<target>
												<propertyReferenceExpression name="Controls"/>
											</target>
											<statements>
												<methodInvokeExpression methodName="RenderControl">
													<target>
														<variableReferenceExpression name="c"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="output"/>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</foreachStatement>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="Write">
											<target>
												<argumentReferenceExpression name="output"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Text"/>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class AttributeDictionary -->
				<typeDeclaration name="AttributeDictionary">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="SortedDictionary">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
						</typeReference>
					</baseTypes>
					<members>
						<!-- constructor(string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="attributes"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="Parse">
									<parameters>
										<argumentReferenceExpression name="attributes"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</constructor>
						<!-- method ValueOf(string, string) -->
						<memberMethod returnType="System.String" name="ValueOf">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
								<parameter type="System.String" name="defaultValue"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="v">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="TryGetValue">
												<parameters>
													<argumentReferenceExpression name="name"/>
													<directionExpression direction="Out">
														<variableReferenceExpression name="v"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="v"/>
											<argumentReferenceExpression name="defaultValue"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="v"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method this[name] -->
						<memberProperty type="System.String" name="Item">
							<attributes new="true" public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<getStatements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ValueOf">
										<target>
											<thisReferenceExpression/>
										</target>
										<parameters>
											<argumentReferenceExpression name="name"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<propertySetValueReferenceExpression/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Remove">
											<parameters>
												<argumentReferenceExpression name="name"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<baseReferenceExpression/>
												</target>
												<indices>
													<argumentReferenceExpression name="name"/>
												</indices>
											</arrayIndexerExpression>
											<propertySetValueReferenceExpression/>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
							</setStatements>
						</memberProperty>
						<!-- method Parse(string) -->
						<memberMethod name="Parse">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="attributes"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="Match" name="attributeMatch">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="attributes"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[\s*(?'Name'[\w\-]+?)\s*=\s*"(?'Value'.+?)"]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<propertyReferenceExpression name="Success">
											<variableReferenceExpression name="attributeMatch"/>
										</propertyReferenceExpression>
									</test>
									<statements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<thisReferenceExpression/>
												</target>
												<indices>
													<propertyReferenceExpression name="Value">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<variableReferenceExpression name="attributeMatch"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Name"/>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
												</indices>
											</arrayIndexerExpression>
											<propertyReferenceExpression name="Value">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Groups">
															<variableReferenceExpression name="attributeMatch"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="Value"/>
													</indices>
												</arrayIndexerExpression>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="attributeMatch"/>
											<methodInvokeExpression methodName="NextMatch">
												<target>
													<variableReferenceExpression name="attributeMatch"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</statements>
								</whileStatement>
							</statements>
						</memberMethod>
						<!-- method ToString() -->
						<memberMethod returnType="System.String" name="ToString">
							<attributes public="true" override="true"/>
							<statements>
								<variableDeclarationStatement type="StringBuilder" name="sb">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="name"/>
									<target>
										<propertyReferenceExpression name="Keys"/>
									</target>><statements>
										<methodInvokeExpression methodName="AppendFormat">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value=" {{0}}=&quot;{{1}}&quot;"/>
												<variableReferenceExpression name="name"/>
												<arrayIndexerExpression>
													<target>
														<thisReferenceExpression/>
													</target>
													<indices>
														<variableReferenceExpression name="name"/>
													</indices>
												</arrayIndexerExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToString">
										<target>
											<variableReferenceExpression name="sb"/>
										</target>
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
