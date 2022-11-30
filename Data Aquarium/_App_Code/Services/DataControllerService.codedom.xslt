<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsPremium"/>

	<xsl:variable name="PageImplementation" select="a:project/@pageImplementation"/>

	<xsl:template match="/">
		<compileUnit namespace="{a:project/a:namespace}.Services">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Services"/>
				<namespaceImport name="System.Web.Script.Services"/>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
				<namespaceImport name="{a:project/a:namespace}.Data"/>
			</imports>
			<types>
				<!-- class DataControllerService -->
				<typeDeclaration name="DataControllerService">
					<xsl:if test="$PageImplementation !='html'">
						<customAttributes>
							<customAttribute name="WebService">
								<arguments>
									<attributeArgument name="Namespace">
										<primitiveExpression value="http://www.codeontime.com/productsdaf.aspx"/>
									</attributeArgument>
								</arguments>
							</customAttribute>
							<customAttribute name="WebServiceBinding">
								<arguments>
									<attributeArgument name="ConformsTo">
										<propertyReferenceExpression name="BasicProfile1_1">
											<typeReferenceExpression type="WsiProfiles"/>
										</propertyReferenceExpression>
									</attributeArgument>
								</arguments>
							</customAttribute>
							<customAttribute name="ScriptService"/>
						</customAttributes>
						<baseTypes>
							<typeReference type="System.Web.Services.WebService"/>
						</baseTypes>
					</xsl:if>
					<members>
						<!-- constructor DataControllerService()-->
						<constructor>
							<attributes public="true"/>
						</constructor>
						<!-- method GetPage(string, string, PageRequest) -->
						<memberMethod returnType="ViewPage" name="GetPage">
							<attributes public="true" final="true"/>
							<xsl:if test="$PageImplementation !='html'">
								<customAttributes>
									<customAttribute name="WebMethod">
										<arguments>
											<attributeArgument name="EnableSession">
												<primitiveExpression value="true"/>
											</attributeArgument>
										</arguments>
									</customAttribute>
									<customAttribute name="ScriptMethod"/>
								</customAttributes>
							</xsl:if>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="PageRequest" name="request"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetPage">
										<target>
											<methodInvokeExpression methodName="CreateDataController">
												<target>
													<typeReferenceExpression type="ControllerFactory"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<argumentReferenceExpression name="controller"/>
											<argumentReferenceExpression name="view"/>
											<argumentReferenceExpression name="request"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ExecuteList(ActionArgs[]) -->
						<memberMethod returnType="ActionResult[]" name="ExecuteList">
							<attributes public="true" final="true"/>
							<xsl:if test="$PageImplementation !='html'">
								<customAttributes>
									<customAttribute name="WebMethod">
										<arguments>
											<attributeArgument name="EnableSession">
												<primitiveExpression value="true"/>
											</attributeArgument>
										</arguments>
									</customAttribute>
									<customAttribute name="ScriptMethod"/>
								</customAttributes>
							</xsl:if>
							<parameters>
								<parameter type="ActionArgs[]" name="requests"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ExecuteList">
										<target>
											<castExpression targetType="DataControllerBase">
												<methodInvokeExpression methodName="CreateDataController">
													<target>
														<typeReferenceExpression type="ControllerFactory"/>
													</target>
												</methodInvokeExpression>
											</castExpression>
										</target>
										<parameters>
											<argumentReferenceExpression name="requests"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetPageList(PageRequest[]) -->
						<memberMethod returnType="ViewPage[]" name="GetPageList">
							<attributes public="true" final="true"/>
							<xsl:if test="$PageImplementation !='html'">
								<customAttributes>
									<customAttribute name="WebMethod">
										<arguments>
											<attributeArgument name="EnableSession">
												<primitiveExpression value="true"/>
											</attributeArgument>
										</arguments>
									</customAttribute>
									<customAttribute name="ScriptMethod"/>
								</customAttributes>
							</xsl:if>
							<parameters>
								<parameter type="PageRequest[]" name="requests"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetPageList">
										<target>
											<castExpression targetType="DataControllerBase">
												<methodInvokeExpression methodName="CreateDataController">
													<target>
														<typeReferenceExpression type="ControllerFactory"/>
													</target>
												</methodInvokeExpression>
											</castExpression>
										</target>
										<parameters>
											<argumentReferenceExpression name="requests"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetListOfValues(string, string, DistinctValueRequest) -->
						<memberMethod returnType="System.Object[]" name="GetListOfValues" >
							<attributes public="true" final="true"/>
							<xsl:if test="$PageImplementation !='html'">
								<customAttributes>
									<customAttribute name="WebMethod">
										<arguments>
											<attributeArgument name="EnableSession">
												<primitiveExpression value="true"/>
											</attributeArgument>
										</arguments>
									</customAttribute>
									<customAttribute name="ScriptMethod"/>
								</customAttributes>
							</xsl:if>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="DistinctValueRequest" name="request"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetListOfValues">
										<target>
											<methodInvokeExpression methodName="CreateDataController">
												<target>
													<typeReferenceExpression type="ControllerFactory"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<argumentReferenceExpression name="controller"/>
											<argumentReferenceExpression name="view"/>
											<argumentReferenceExpression name="request"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Execute(string, string, DistinctValueRequest) -->
						<memberMethod returnType="ActionResult" name="Execute">
							<attributes public="true" final="true"/>
							<xsl:if test="$PageImplementation !='html'">
								<customAttributes>
									<customAttribute name="WebMethod">
										<arguments>
											<attributeArgument name="EnableSession">
												<primitiveExpression value="true"/>
											</attributeArgument>
										</arguments>
									</customAttribute>
									<customAttribute name="ScriptMethod"/>
								</customAttributes>
							</xsl:if>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="ActionArgs" name="args"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Execute">
										<target>
											<methodInvokeExpression methodName="CreateDataController">
												<target>
													<typeReferenceExpression type="ControllerFactory"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<argumentReferenceExpression name="controller"/>
											<argumentReferenceExpression name="view"/>
											<argumentReferenceExpression name="args"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetCompletionList(string, int, string) -->
						<memberMethod returnType="System.String[]" name="GetCompletionList">
							<attributes public="true" final="true"/>
							<xsl:if test="$PageImplementation !='html'">
								<customAttributes>
									<customAttribute name="WebMethod">
										<arguments>
											<attributeArgument name="EnableSession">
												<primitiveExpression value="true"/>
											</attributeArgument>
										</arguments>
									</customAttribute>
									<customAttribute name="ScriptMethod"/>
								</customAttributes>
							</xsl:if>
							<parameters>
								<parameter type="System.String" name="prefixText"/>
								<parameter type="System.Int32" name="count"/>
								<parameter type="System.String" name="contextKey"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetCompletionList">
										<target>
											<methodInvokeExpression methodName="CreateAutoCompleteManager">
												<target>
													<typeReferenceExpression type="ControllerFactory"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<argumentReferenceExpression name="prefixText"/>
											<argumentReferenceExpression name="count"/>
											<argumentReferenceExpression name="contextKey"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<xsl:if test="$IsPremium='true'">
							<!-- property Permalinks -->
							<memberProperty type="List" name="Permalinks">
								<typeArguments>
									<typeReference type="System.String[]"/>
								</typeArguments>
								<attributes family="true" final="true"/>
								<getStatements>
									<variableDeclarationStatement type="List" name="links">
										<typeArguments>
											<typeReference type="System.String[]"/>
										</typeArguments>
										<init>
											<castExpression targetType="List">
												<typeArguments>
													<typeReference type="System.String[]"/>
												</typeArguments>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Session">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="Permalinks"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
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
											<assignStatement>
												<variableReferenceExpression name="links"/>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="System.String[]"/>
													</typeArguments>
												</objectCreateExpression>
											</assignStatement>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Session">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="Permalinks"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="links"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="links"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method FindPermalink(string link) -->
							<memberMethod returnType="System.String[]" name="FindPermalink">
								<attributes family="true" final="true"/>
								<parameters>
									<parameter type="System.String" name="link"/>
								</parameters>
								<statements>
									<foreachStatement>
										<variable type="System.String[]" name="entry"/>
										<target>
											<propertyReferenceExpression name="Permalinks"/>
										</target>
										<statements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="entry"/>
															</target>
															<indices>
																<primitiveExpression value="0"/>
															</indices>
														</arrayIndexerExpression>
														<argumentReferenceExpression name="link"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodReturnStatement>
														<variableReferenceExpression name="entry"/>
													</methodReturnStatement>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
									<methodReturnStatement>
										<primitiveExpression value="null"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method SavePermalink(string link, string html) -->
							<memberMethod name="SavePermalink">
								<attributes public="true" final="true"/>
								<xsl:if test="$PageImplementation !='html'">
									<customAttributes>
										<customAttribute name="WebMethod">
											<arguments>
												<attributeArgument name="EnableSession">
													<primitiveExpression value="true"/>
												</attributeArgument>
											</arguments>
										</customAttribute>
										<customAttribute name="ScriptMethod"/>
									</customAttributes>
								</xsl:if>
								<parameters>
									<parameter type="System.String" name="link"/>
									<parameter type="System.String" name="html"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="System.String[]" name="permalink">
										<init>
											<methodInvokeExpression methodName="FindPermalink">
												<parameters>
													<argumentReferenceExpression name="link"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="Contains">
												<target>
													<propertyReferenceExpression name="Permalinks"/>
												</target>
												<parameters>
													<variableReferenceExpression name="permalink"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Remove">
												<target>
													<propertyReferenceExpression name="Permalinks"/>
												</target>
												<parameters>
													<variableReferenceExpression name="permalink"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<argumentReferenceExpression name="html"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Insert">
												<target>
													<propertyReferenceExpression name="Permalinks"/>
												</target>
												<parameters>
													<primitiveExpression value="0"/>
													<arrayCreateExpression>
														<createType type="System.String"/>
														<initializers>
															<argumentReferenceExpression name="link"/>
															<argumentReferenceExpression name="html"/>
														</initializers>
													</arrayCreateExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
										<falseStatements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="Count">
															<propertyReferenceExpression name="Permalinks"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="RemoveAt">
														<target>
															<propertyReferenceExpression name="Permalinks"/>
														</target>
														<parameters>
															<primitiveExpression value="0"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</falseStatements>
									</conditionStatement>
									<whileStatement>
										<test>
											<binaryOperatorExpression operator="GreaterThan">
												<propertyReferenceExpression name="Count">
													<propertyReferenceExpression name="Permalinks"/>
												</propertyReferenceExpression>
												<primitiveExpression value="10"/>
											</binaryOperatorExpression>
										</test>
										<statements>
											<methodInvokeExpression methodName="RemoveAt">
												<target>
													<propertyReferenceExpression name="Permalinks"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Subtract">
														<propertyReferenceExpression name="Count">
															<propertyReferenceExpression name="Permalinks"/>
														</propertyReferenceExpression>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</whileStatement>
								</statements>
							</memberMethod>
							<!-- method EncodePermalink(string) -->
							<memberMethod returnType="System.String" name="EncodePermalink">
								<attributes public="true" final="true"/>
								<xsl:if test="$PageImplementation !='html'">
									<customAttributes>
										<customAttribute name="WebMethod"/>
										<customAttribute name="ScriptMethod"/>
									</customAttributes>
								</xsl:if>
								<parameters>
									<parameter type="System.String" name="link"/>
									<parameter type="System.Boolean" name="rooted"/>
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
									<conditionStatement>
										<condition>
											<argumentReferenceExpression name="rooted"/>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="System.String" name="appPath">
												<init>
													<propertyReferenceExpression name="ApplicationPath">
														<variableReferenceExpression name="request"/>
													</propertyReferenceExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="Equals">
														<target>
															<variableReferenceExpression name="appPath"/>
														</target>
														<parameters>
															<primitiveExpression value="/"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="appPath"/>
														<propertyReferenceExpression name="Empty">
															<typeReferenceExpression type="String"/>
														</propertyReferenceExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<methodReturnStatement>
												<stringFormatExpression>
													<xsl:attribute name="format"><![CDATA[{0}://{1}{2}/default.aspx?_link={3}]]></xsl:attribute>
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
													<variableReferenceExpression name="appPath"/>
													<methodInvokeExpression methodName="UrlEncode">
														<target>
															<typeReferenceExpression type="HttpUtility"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="ToString">
																<target>
																	<typeReferenceExpression type="StringEncryptor"/>
																</target>
																<parameters>
																	<argumentReferenceExpression name="link"/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</stringFormatExpression>
											</methodReturnStatement>
										</trueStatements>
										<falseStatements>
											<variableDeclarationStatement type="System.String[]" name="linkSegments">
												<init>
													<methodInvokeExpression methodName="Split">
														<target>
															<argumentReferenceExpression name="link"/>
														</target>
														<parameters>
															<primitiveExpression value="?" convertTo="Char"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="System.String" name="arguments">
												<init>
													<stringEmptyExpression/>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="Length">
															<variableReferenceExpression name="linkSegments"/>
														</propertyReferenceExpression>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="arguments"/>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="linkSegments"/>
															</target>
															<indices>
																<primitiveExpression value="1"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<methodReturnStatement>
												<stringFormatExpression format="{{0}}?_link={{1}}">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="linkSegments"/>
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
															<methodInvokeExpression methodName="ToString">
																<target>
																	<typeReferenceExpression type="StringEncryptor"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="arguments"/>
																	<!--<arrayIndexerExpression>
                                    <target>
                                      <variableReferenceExpression name="linkSegments"/>
                                    </target>
                                    <indices>
                                      <primitiveExpression value="1"/>
                                    </indices>
                                  </arrayIndexerExpression>-->
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</stringFormatExpression>
											</methodReturnStatement>
										</falseStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ListAllPermalinks() -->
							<memberMethod returnType="System.String[][]" name="ListAllPermalinks">
								<attributes public="true" final="true"/>
								<xsl:if test="$PageImplementation !='html'">
									<customAttributes>
										<customAttribute name="WebMethod">
											<arguments>
												<attributeArgument name="EnableSession">
													<primitiveExpression value="true"/>
												</attributeArgument>
											</arguments>
										</customAttribute>
										<customAttribute name="ScriptMethod"/>
									</customAttributes>
								</xsl:if>
								<statements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="ToArray">
											<target>
												<propertyReferenceExpression name="Permalinks"/>
											</target>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</xsl:if>
						<!-- method GetSurvey() -->
						<memberMethod returnType="System.String" name="GetSurvey">
							<attributes public="true" final="true"/>
							<xsl:if test="$PageImplementation !='html'">
								<customAttributes>
									<customAttribute name="WebMethod">
										<arguments>
											<attributeArgument name="EnableSession">
												<primitiveExpression value="true"/>
											</attributeArgument>
										</arguments>
									</customAttribute>
									<customAttribute name="ScriptMethod"/>
								</customAttributes>
							</xsl:if>
							<parameters>
								<parameter type="System.String" name="survey"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetSurvey">
										<target>
											<typeReferenceExpression type="ControllerFactory"/>
										</target>
										<parameters>
											<variableReferenceExpression name="survey"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<xsl:if test="not(contains(a:project/@type, 'DotNetNuke')) and not(contains(a:project/@type, 'SharePoint'))">
							<!-- method Login(username, password, createPersistentCookie)-->
							<memberMethod returnType="System.Object" name="Login">
								<attributes public="true" final="true"/>
								<xsl:if test="$PageImplementation !='html'">
									<customAttributes>
										<customAttribute name="WebMethod">
											<arguments>
												<attributeArgument name="EnableSession">
													<primitiveExpression value="true"/>
												</attributeArgument>
											</arguments>
										</customAttribute>
										<customAttribute name="ScriptMethod"/>
									</customAttributes>
								</xsl:if>
								<parameters>
									<parameter type="System.String" name="username"/>
									<parameter type="System.String" name="password"/>
									<parameter type="System.Boolean" name="createPersistentCookie"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Login">
											<target>
												<typeReferenceExpression type="ApplicationServices"/>
											</target>
											<parameters>
												<variableReferenceExpression name="username"/>
												<variableReferenceExpression name="password"/>
												<variableReferenceExpression name="createPersistentCookie"/>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method Logout()-->
							<memberMethod name="Logout">
								<attributes public="true" final="true"/>
								<xsl:if test="$PageImplementation !='html'">
									<customAttributes>
										<customAttribute name="WebMethod">
											<arguments>
												<attributeArgument name="EnableSession">
													<primitiveExpression value="true"/>
												</attributeArgument>
											</arguments>
										</customAttribute>
										<customAttribute name="ScriptMethod"/>
									</customAttributes>
								</xsl:if>
								<statements>
									<methodInvokeExpression methodName="Logout">
										<target>
											<typeReferenceExpression type="ApplicationServices"/>
										</target>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method Roles()-->
							<memberMethod returnType="System.String[]" name="Roles">
								<attributes public="true" final="true"/>
								<xsl:if test="$PageImplementation !='html'">
									<customAttributes>
										<customAttribute name="WebMethod">
											<arguments>
												<attributeArgument name="EnableSession">
													<primitiveExpression value="true"/>
												</attributeArgument>
											</arguments>
										</customAttribute>
										<customAttribute name="ScriptMethod"/>
									</customAttributes>
								</xsl:if>
								<statements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Roles">
											<target>
												<typeReferenceExpression type="ApplicationServices"/>
											</target>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method Themes()-->
							<memberMethod returnType="System.Object" name="Themes">
								<attributes public="true" final="true"/>
								<xsl:if test="$PageImplementation !='html'">
									<customAttributes>
										<customAttribute name="WebMethod">
											<arguments>
												<attributeArgument name="EnableSession">
													<primitiveExpression value="true"/>
												</attributeArgument>
											</arguments>
										</customAttribute>
										<customAttribute name="ScriptMethod"/>
									</customAttributes>
								</xsl:if>
								<statements>
									<xsl:choose>
										<xsl:when test="$PageImplementation!='html'">
											<methodReturnStatement>
												<methodInvokeExpression methodName="ToString">
													<target>
														<methodInvokeExpression methodName="Themes">
															<target>
																<typeReferenceExpression type="ApplicationServices"/>
															</target>
														</methodInvokeExpression>
													</target>
												</methodInvokeExpression>
											</methodReturnStatement>
										</xsl:when>
										<xsl:otherwise>
											<methodReturnStatement>
												<methodInvokeExpression methodName="Themes">
													<target>
														<typeReferenceExpression type="ApplicationServices"/>
													</target>
												</methodInvokeExpression>
											</methodReturnStatement>
										</xsl:otherwise>
									</xsl:choose>
								</statements>
							</memberMethod>
						</xsl:if>
						<!-- method Invoke(string, object) -->
						<xsl:if test="$PageImplementation !='html'">
							<memberMethod returnType="System.Object" name="Invoke">
								<attributes public="true" final="true"/>
								<customAttributes>
									<customAttribute name="WebMethod">
										<arguments>
											<attributeArgument name="EnableSession">
												<primitiveExpression value="true"/>
											</attributeArgument>
										</arguments>
									</customAttribute>
									<customAttribute name="ScriptMethod">
										<arguments>
											<attributeArgument name="ResponseFormat">
												<propertyReferenceExpression name="Json">
													<typeReferenceExpression type="ResponseFormat"/>
												</propertyReferenceExpression>
											</attributeArgument>
										</arguments>
									</customAttribute>
								</customAttributes>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.Object" name="args"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="args2">
										<init>
											<methodInvokeExpression methodName="FromObject">
												<target>
													<typeReferenceExpression type="JObject"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="args"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="ServiceRequestHandler" name="handler"/>
									<variableDeclarationStatement type="System.Object" name="result">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<propertyReferenceExpression name="RequestHandlers">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<methodInvokeExpression methodName="ToLower">
														<target>
															<argumentReferenceExpression name="method"/>
														</target>
													</methodInvokeExpression>
													<directionExpression direction="Out">
														<variableReferenceExpression name="handler"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="result"/>
												<methodInvokeExpression methodName="HandleRequest">
													<target>
														<variableReferenceExpression name="handler"/>
													</target>
													<parameters>
														<thisReferenceExpression/>
														<argumentReferenceExpression name="args2"/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="result"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="BooleanAnd">
													<propertyReferenceExpression name="IsClass">
														<methodInvokeExpression methodName="GetType">
															<target>
																<variableReferenceExpression name="result"/>
															</target>
														</methodInvokeExpression>
													</propertyReferenceExpression>
													<unaryOperatorExpression operator="Not">
														<propertyReferenceExpression name="IsArray">
															<methodInvokeExpression methodName="GetType">
																<target>
																	<variableReferenceExpression name="result"/>
																</target>
															</methodInvokeExpression>
														</propertyReferenceExpression>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="Not">
														<binaryOperatorExpression operator="IsTypeOf">
															<variableReferenceExpression name="result"/>
															<objectCreateExpression type="JObject"/>
														</binaryOperatorExpression>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="result"/>
														<methodInvokeExpression methodName="FromObject">
															<target>
																<typeReferenceExpression type="JObject"/>
															</target>
															<parameters>
																<variableReferenceExpression name="result"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<assignStatement>
												<variableReferenceExpression name="result"/>
												<methodInvokeExpression methodName="JsonToYaml">
													<target>
														<typeReferenceExpression type="TextUtility"/>
													</target>
													<parameters>
														<castExpression targetType="JObject">
															<variableReferenceExpression name="result"/>
														</castExpression>
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
						</xsl:if>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
