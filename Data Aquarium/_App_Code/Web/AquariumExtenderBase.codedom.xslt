<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsClassLibrary" select="'false'"/>
	<xsl:param name="Theme" select="'Aquarium'"/>
	<xsl:param name="IsPremium"/>
	<xsl:param name="IsUnlimited"/>
	<xsl:param name="Mobile"/>
	<xsl:param name="Host"/>
	<xsl:param name="AppVersion"/>
	<xsl:param name="ScriptOnly" select="'false'"/>
	<xsl:param name="ProjectId"/>
	<xsl:param name="CodedomProviderName"/>
	<xsl:param name="jQueryMobileVersion"/>


	<xsl:variable name="ThemeFolder">
		<xsl:choose>
			<xsl:when test="$CodedomProviderName='VisualBasic'">
				<xsl:text></xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>.Theme</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="AspNet35AppServicesFix" select="a:project/@targetFramework='3.5' and a:project/a:membership/@enabled='true'"/>
	<xsl:variable name="Namespace" select="/a:project/a:namespace"/>
	<xsl:variable name="PageImplementation" select="/a:project/@pageImplementation"/>
	<xsl:variable name="UI" select="a:project/@userInterface"/>

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Web">
			<imports>
				<namespaceImport name="System"/>
				<!--<namespaceImport name="System.Data"/>-->
				<namespaceImport name="System.Collections.Generic"/>
				<!--<namespaceImport name="System.Configuration"/>-->
				<namespaceImport name="System.Globalization"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Threading"/>
				<namespaceImport name="System.Web"/>
				<!--<namespaceImport name="System.Web.Security"/>-->
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.UI.HtmlControls"/>
				<!--<namespaceImport name="System.Web.UI.WebControls"/>-->
				<!--<namespaceImport name="System.Web.UI.WebControls.WebParts"/>-->
				<!--<namespaceImport name="Newtonsoft.Json.Linq"/>-->
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Services"/>
				<xsl:if test="$ScriptOnly='false'">
					<namespaceImport name="AjaxControlToolkit"/>
				</xsl:if>
			</imports>
			<types>
				<!-- class AquariumFieldEditorAttribute -->
				<typeDeclaration name="AquariumFieldEditorAttribute">
					<baseTypes>
						<typeReference type="Attribute"/>
					</baseTypes>
				</typeDeclaration>
				<!-- class AquariumExtenderBase -->
				<typeDeclaration name="AquariumExtenderBase">
					<attributes public="true"/>
					<customAttributes>
						<!--<xsl:if test="$IsClassLibrary='true'">
              <customAttribute name="ClientCssResource">
                <arguments>
                  <primitiveExpression value="{$Namespace}.Theme.{$Theme}.css"/>
                </arguments>
              </customAttribute>
            </xsl:if>-->
					</customAttributes>
					<baseTypes>
						<typeReference type="ExtenderControl"/>
					</baseTypes>
					<members>
						<memberField type="System.String" name="clientComponentName"/>
						<xsl:if test="$Host='DotNetNuke'">
							<memberProperty type="System.String" name="RootPath">
								<attributes private="true"/>
								<getStatements>
									<variableDeclarationStatement type="System.String" name="path">
										<init>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="appPath">
										<init>
											<propertyReferenceExpression name="ApplicationPath">
												<propertyReferenceExpression name="Request">
													<propertyReferenceExpression name="Page"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="GreaterThan">
												<propertyReferenceExpression name="Length">
													<variableReferenceExpression name="appPath"/>
												</propertyReferenceExpression>
												<primitiveExpression value="1"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="path"/>
												<primitiveExpression value="../"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<forStatement>
										<variable type="System.Int32" name="i">
											<init>
												<primitiveExpression value="1"/>
											</init>
										</variable>
										<test>
											<binaryOperatorExpression operator="LessThan">
												<variableReferenceExpression name="i"/>
												<propertyReferenceExpression name="Length">
													<variableReferenceExpression name="appPath"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</test>
										<increment>
											<variableReferenceExpression name="i"/>
										</increment>
										<statements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="appPath"/>
															</target>
															<indices>
																<variableReferenceExpression name="i"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="/" convertTo="Char"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="path"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="path"/>
															<primitiveExpression value="../"/>
														</binaryOperatorExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</statements>
									</forStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="path"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
						</xsl:if>
						<!-- property DefaultServicePath -->
						<memberField type="System.String" name="DefaultServicePath">
							<attributes public="true" static="true"/>
							<init>
								<xsl:choose>
									<xsl:when test="$PageImplementation='html'">
										<primitiveExpression value="~/_invoke"/>
									</xsl:when>
									<xsl:when test="$IsClassLibrary='true'">
										<primitiveExpression value="~/DAF/Service.asmx"/>
									</xsl:when>
									<xsl:otherwise>
										<primitiveExpression value="~/Services/DataControllerService.asmx"/>
									</xsl:otherwise>
								</xsl:choose>
							</init>
						</memberField>
						<!-- property AppServicePath -->
						<memberField type="System.String" name="AppServicePath">
							<attributes public="true" static="true"/>
							<init>
								<primitiveExpression value="~/appservices"/>
							</init>
						</memberField>
						<!-- property ServicePath -->
						<memberField type="System.String" name="servicePath"/>
						<memberProperty type="System.String" name="ServicePath">
							<attributes public="true" />
							<customAttributes>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="A path to a data controller web service."/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<xsl:choose>
											<xsl:when test="$PageImplementation='html'">
												<primitiveExpression value="~/_invoke"/>
											</xsl:when>
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
								<xsl:if test="$Host='DotNetNuke'">
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="Request">
														<propertyReferenceExpression name="Page"/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Equals">
														<target>
															<propertyReferenceExpression name="AppRelativeCurrentExecutionFilePath">
																<propertyReferenceExpression name="Request">
																	<propertyReferenceExpression name="Page"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="~/Start.aspx"/>
															<propertyReferenceExpression name="OrdinalIgnoreCase">
																<typeReferenceExpression type="StringComparison"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<stringFormatExpression format="~/{{0}}{{1}}/../Service.asmx">
													<propertyReferenceExpression name="RootPath"/>
													<propertyReferenceExpression name="TemplateSourceDirectory"/>
												</stringFormatExpression>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<xsl:if test="$Host='SharePoint'">
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="Request">
														<propertyReferenceExpression name="Page"/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<methodInvokeExpression methodName="StartsWith">
													<target>
														<propertyReferenceExpression name="TemplateSourceDirectory"/>
													</target>
													<parameters>
														<primitiveExpression value="/_CONTROLTEMPLATES/{$Namespace}/"/>
														<propertyReferenceExpression name="OrdinalIgnoreCase">
															<typeReferenceExpression type="StringComparison"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<stringFormatExpression format="/_layouts/{$Namespace}/Service.asmx">
													<propertyReferenceExpression name="TemplateSourceDirectory"/>
												</stringFormatExpression>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<fieldReferenceExpression name="servicePath"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="DefaultServicePath">
												<typeReferenceExpression type="AquariumExtenderBase"/>
											</propertyReferenceExpression>
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
						<!-- property Properties -->
						<memberField type="SortedDictionary" name="properties">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.Object"/>
							</typeArguments>
						</memberField>
						<memberProperty type="SortedDictionary" name="Properties">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.Object"/>
							</typeArguments>
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Browsable">
									<arguments>
										<primitiveExpression value="false"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="properties"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="properties"/>
											<objectCreateExpression type="SortedDictionary">
												<typeArguments>
													<typeReference type="System.String"/>
													<typeReference type="System.Object"/>
												</typeArguments>
											</objectCreateExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="properties"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- contructor AquariumExtenderBase() -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="clientComponentName"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="clientComponentName">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="clientComponentName"/>
								</assignStatement>
							</statements>
						</constructor>
						<!-- method GetScriptDescriptors(Control) -->
						<memberMethod returnType="System.Collections.Generic.IEnumerable" name="GetScriptDescriptors">
							<typeArguments>
								<typeReference type="ScriptDescriptor"/>
							</typeArguments>
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="Control" name="targetControl"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Site"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsInAsyncPostBack">
											<methodInvokeExpression methodName="GetCurrent">
												<target>
													<typeReferenceExpression type="ScriptManager"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Page"/>
												</parameters>
											</methodInvokeExpression>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.Boolean" name="requireRegistration">
											<init>
												<primitiveExpression value="false"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="Control" name="c" var="false">
											<init>
												<thisReferenceExpression/>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<binaryOperatorExpression operator="BooleanAnd">
													<unaryOperatorExpression operator="Not">
														<variableReferenceExpression name="requireRegistration"/>
													</unaryOperatorExpression>
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="IdentityInequality">
															<variableReferenceExpression name="c"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<unaryOperatorExpression operator="Not">
															<binaryOperatorExpression operator="IsTypeOf">
																<variableReferenceExpression name="c"/>
																<typeReferenceExpression type="HtmlForm"/>
															</binaryOperatorExpression>
														</unaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</test>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IsTypeOf">
															<variableReferenceExpression name="c"/>
															<typeReferenceExpression type="UpdatePanel"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="requireRegistration"/>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="c"/>
													<propertyReferenceExpression name="Parent">
														<variableReferenceExpression name="c"/>
													</propertyReferenceExpression>
												</assignStatement>
											</statements>
										</whileStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<variableReferenceExpression name="requireRegistration"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="null"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="ScriptBehaviorDescriptor" name="descriptor">
									<init>
										<objectCreateExpression type="ScriptBehaviorDescriptor">
											<parameters>
												<fieldReferenceExpression name="clientComponentName"/>
												<propertyReferenceExpression name="ClientID">
													<argumentReferenceExpression name="targetControl"/>
												</propertyReferenceExpression>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="AddProperty">
									<target>
										<variableReferenceExpression name="descriptor"/>
									</target>
									<parameters>
										<primitiveExpression value="id"/>
										<propertyReferenceExpression name="ClientID">
											<thisReferenceExpression/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="System.String" name="baseUrl">
									<init>
										<methodInvokeExpression methodName="ResolveUrl">
											<parameters>
												<primitiveExpression value="~"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="baseUrl"/>
											<primitiveExpression value="~"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="baseUrl"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.Boolean" name="isTouchUI">
									<init>
										<xsl:choose>
											<xsl:when test="$Host=''">
												<propertyReferenceExpression name="IsTouchClient">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</xsl:when>
											<xsl:otherwise>
												<primitiveExpression value="false"/>
											</xsl:otherwise>
										</xsl:choose>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<variableReferenceExpression name="isTouchUI"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AddProperty">
											<target>
												<variableReferenceExpression name="descriptor"/>
											</target>
											<parameters>
												<primitiveExpression value="baseUrl"/>
												<variableReferenceExpression name="baseUrl"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AddProperty">
											<target>
												<variableReferenceExpression name="descriptor"/>
											</target>
											<parameters>
												<primitiveExpression value="servicePath"/>
												<methodInvokeExpression methodName="ResolveUrl">
													<parameters>
														<propertyReferenceExpression name="ServicePath"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="ConfigureDescriptor">
									<parameters>
										<variableReferenceExpression name="descriptor"/>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<arrayCreateExpression>
										<createType type="ScriptBehaviorDescriptor"/>
										<initializers>
											<variableReferenceExpression name="descriptor"/>
										</initializers>
									</arrayCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ConfigureDescriptor -->
						<memberMethod name="ConfigureDescriptor">
							<attributes family="true"/>
							<parameters>
								<parameter type="ScriptBehaviorDescriptor" name="descriptor"/>
							</parameters>
						</memberMethod>
						<!-- method CreateScriptReference(string) -->
						<memberMethod returnType="ScriptReference" name="CreateScriptReference">
							<attributes static="true" public="true"/>
							<parameters>
								<parameter type="System.String" name="p"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="CultureInfo" name="culture">
									<init>
										<propertyReferenceExpression name="CurrentUICulture">
											<propertyReferenceExpression name="CurrentThread">
												<typeReferenceExpression type="Thread"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="List" name="scripts">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
									<init>
										<castExpression targetType="List">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Cache">
														<typeReferenceExpression type="HttpRuntime"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="AllApplicationScripts"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="scripts"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="scripts"/>
											<objectCreateExpression type="List">
												<typeArguments>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</assignStatement>
										<variableDeclarationStatement type="System.String[]" name="files">
											<init>
												<methodInvokeExpression methodName="GetFiles">
													<target>
														<typeReferenceExpression type="Directory"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="MapPath">
															<target>
																<propertyReferenceExpression name="Server">
																	<propertyReferenceExpression name="Current">
																		<typeReferenceExpression type="HttpContext"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<primitiveExpression value="~/js"/>
															</parameters>
														</methodInvokeExpression>
														<primitiveExpression value="*.js"/>
														<propertyReferenceExpression name="AllDirectories">
															<typeReferenceExpression type="SearchOption"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="System.String" name="scriptFile"/>
											<target>
												<variableReferenceExpression name="files"/>
											</target>
											<statements>
												<variableDeclarationStatement type="Match" name="m">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="GetFileName">
																	<target>
																		<typeReferenceExpression type="Path"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="scriptFile"/>
																	</parameters>
																</methodInvokeExpression>
																<primitiveExpression value="^(.+?)\.(\w\w(\-\w+)*)\.js$"/>
																<!--<propertyReferenceExpression name="Compiled">
																	<typeReferenceExpression type="RegexOptions"/>
																</propertyReferenceExpression>-->
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
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="scripts"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="m"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Cache">
														<typeReferenceExpression type="HttpRuntime"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="AllApplicationScripts"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="scripts"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
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
										<variableDeclarationStatement type="Match" name="name">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="p"/>
														<primitiveExpression value="^(?'Path'.+\/)(?'Name'.+?)\.js$"/>
														<!--<propertyReferenceExpression name="Compiled">
															<typeReferenceExpression type="RegexOptions"/>
														</propertyReferenceExpression>-->
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="Success">
													<variableReferenceExpression name="name"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String" name="test">
													<init>
														<stringFormatExpression format="{{0}}.{{1}}.js">
															<propertyReferenceExpression name="Value">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Groups">
																			<variableReferenceExpression name="name"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="Name"/>
																	</indices>
																</arrayIndexerExpression>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="culture"/>
															</propertyReferenceExpression>
														</stringFormatExpression>
														<!--<methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="String"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="{{0}}.{{1}}.js"/>
                                <propertyReferenceExpression name="Value">
                                  <arrayIndexerExpression>
                                    <target>
                                      <propertyReferenceExpression name="Groups">
                                        <variableReferenceExpression name="name"/>
                                      </propertyReferenceExpression>
                                    </target>
                                    <indices>
                                      <primitiveExpression value="Name"/>
                                    </indices>
                                  </arrayIndexerExpression>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="culture"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>-->
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.Boolean" name="success">
													<init>
														<methodInvokeExpression methodName="Contains">
															<target>
																<variableReferenceExpression name="scripts"/>
															</target>
															<parameters>
																<variableReferenceExpression name="test"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<variableReferenceExpression name="success"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="test"/>
															<stringFormatExpression format="{{0}}.{{1}}.js">
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="name"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Name"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
																<methodInvokeExpression methodName="Substring">
																	<target>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="culture"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="0"/>
																		<primitiveExpression value="2"/>
																	</parameters>
																</methodInvokeExpression>
															</stringFormatExpression>
															<!--<methodInvokeExpression methodName="Format">
                                <target>
                                  <typeReferenceExpression type="String"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="{{0}}.{{1}}.js"/>
                                  <propertyReferenceExpression name="Value">
                                    <arrayIndexerExpression>
                                      <target>
                                        <propertyReferenceExpression name="Groups">
                                          <variableReferenceExpression name="name"/>
                                        </propertyReferenceExpression>
                                      </target>
                                      <indices>
                                        <primitiveExpression value="Name"/>
                                      </indices>
                                    </arrayIndexerExpression>
                                  </propertyReferenceExpression>
                                  <methodInvokeExpression methodName="Substring">
                                    <target>
                                      <propertyReferenceExpression name="Name">
                                        <variableReferenceExpression name="culture"/>
                                      </propertyReferenceExpression>
                                    </target>
                                    <parameters>
                                      <primitiveExpression value="0"/>
                                      <primitiveExpression value="2"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                </parameters>
                              </methodInvokeExpression>-->
														</assignStatement>
														<assignStatement>
															<variableReferenceExpression name="success"/>
															<methodInvokeExpression methodName="Contains">
																<target>
																	<typeReferenceExpression type="scripts"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="test"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<variableReferenceExpression name="success"/>
													</condition>
													<trueStatements>
														<assignStatement>
															<argumentReferenceExpression name="p"/>
															<binaryOperatorExpression operator="Add">
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="name"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Path"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
																<variableReferenceExpression name="test"/>
															</binaryOperatorExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<xsl:if test="$AppVersion!=''">
									<assignStatement>
										<argumentReferenceExpression name="p"/>
										<binaryOperatorExpression operator="Add">
											<argumentReferenceExpression name="p"/>
											<stringFormatExpression format="?{{0}}">
												<propertyReferenceExpression name="Version">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</stringFormatExpression>/>
										</binaryOperatorExpression>
									</assignStatement>
								</xsl:if>
								<methodReturnStatement>
									<objectCreateExpression type="ScriptReference">
										<parameters>
											<argumentReferenceExpression name="p"/>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property EnableCombinedScript -->
						<memberField type="System.Boolean" name="enableCombinedScript">
							<attributes static="true" private="true"/>
						</memberField>
						<memberProperty type="System.Boolean" name="EnableCombinedScript">
							<attributes public="true" static="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="enableCombinedScript"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="enableCombinedScript"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property IgnoreCombinedScript -->
						<memberProperty type="System.Boolean" name="IgnoreCombinedScript">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property EnableMinifiedScript-->
						<memberField type="System.Boolean" name="enableMinifiedScript">
							<attributes static="true" private="true"/>
							<init>
								<primitiveExpression value="true"/>
							</init>
						</memberField>
						<memberProperty type="System.Boolean" name="EnableMinifiedScript">
							<attributes public="true" static="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="enableMinifiedScript"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="enableMinifiedScript"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<xsl:if test="$Host=''">
							<!-- property CombinedScriptName -->
							<memberProperty type="System.String" name="CombinedScriptName">
								<attributes public="true" static="true"/>
								<getStatements>
									<variableDeclarationStatement type="System.String" name="lang">
										<init>
											<methodInvokeExpression methodName="ToLower">
												<target>
													<propertyReferenceExpression name="IetfLanguageTag">
														<propertyReferenceExpression name="CurrentUICulture">
															<typeReferenceExpression type="CultureInfo"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="scriptMode">
										<init>
											<stringEmptyExpression/>
										</init>
									</variableDeclarationStatement>
									<xsl:call-template name="TouchOrDesktop">
										<xsl:with-param name="Touch">
											<assignStatement>
												<variableReferenceExpression name="scriptMode"/>
												<primitiveExpression value="?_touch"/>
											</assignStatement>
										</xsl:with-param>
										<xsl:with-param name="Conditional">
											<propertyReferenceExpression name="IsTouchClient">
												<typeReferenceExpression type="ApplicationServices"/>
											</propertyReferenceExpression>
										</xsl:with-param>
									</xsl:call-template>
									<methodReturnStatement>
										<methodInvokeExpression methodName="ResolveUrl">
											<target>
												<castExpression targetType="Page">
													<propertyReferenceExpression name="Handler">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</castExpression>
											</target>
											<parameters>
												<stringFormatExpression>
													<xsl:attribute name="format"><![CDATA[~/appservices/combined-{0}.{1}.js{2}{3}]]></xsl:attribute>
													<propertyReferenceExpression name="Version">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
													<variableReferenceExpression name="lang"/>
													<variableReferenceExpression name="scriptMode"/>
													<propertyReferenceExpression name="CombinedResourceType">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</stringFormatExpression>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
						</xsl:if>
						<!-- method GetScriptReferences() -->
						<memberMethod returnType="System.Collections.Generic.IEnumerable" name="GetScriptReferences">
							<typeArguments>
								<typeReference type="ScriptReference"/>
							</typeArguments>
							<attributes family="true" override="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Site"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
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
											<binaryOperatorExpression operator="IdentityInequality">
												<propertyReferenceExpression name="Page"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<propertyReferenceExpression name="IsInAsyncPostBack">
												<methodInvokeExpression methodName="GetCurrent">
													<target>
														<typeReferenceExpression type="ScriptManager"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Page"/>
													</parameters>
												</methodInvokeExpression>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="uiFramework">
									<init>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="Contains">
													<target>
														<propertyReferenceExpression name="Items">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="ui-framework-none"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<binaryOperatorExpression operator="BooleanAnd">
													<methodInvokeExpression methodName="Contains">
														<target>
															<propertyReferenceExpression name="RawUrl">
																<propertyReferenceExpression name="Request">
																	<propertyReferenceExpression name="Context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[/combined-]]></xsl:attribute>
															</primitiveExpression>
														</parameters>
													</methodInvokeExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="QueryString">
																	<propertyReferenceExpression name="Request">
																		<propertyReferenceExpression name="Context"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="ui-framework"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="none"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="List" name="scripts">
									<typeArguments>
										<typeReference type="ScriptReference"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="ScriptReference"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<xsl:if test="$UI='Both'">
									<variableDeclarationStatement type="System.Boolean" name="isMobile">
										<init>
											<propertyReferenceExpression name="IsTouchClient">
												<typeReferenceExpression type="ApplicationServices"/>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
								</xsl:if>
								<xsl:if test="$Host=''">
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<propertyReferenceExpression name="EnableCombinedScript"/>
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="IgnoreCombinedScript"/>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="ScriptReference" name="combinedScript">
												<init>
													<objectCreateExpression type="ScriptReference">
														<parameters>
															<propertyReferenceExpression name="CombinedScriptName"/>
														</parameters>
													</objectCreateExpression>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<propertyReferenceExpression name="ResourceUICultures">
													<variableReferenceExpression name="combinedScript"/>
												</propertyReferenceExpression>
												<primitiveExpression value="null"/>
											</assignStatement>
											<methodInvokeExpression methodName="Add">
												<target>
													<variableReferenceExpression name="scripts"/>
												</target>
												<parameters>
													<variableReferenceExpression name="combinedScript"/>
												</parameters>
											</methodInvokeExpression>
											<methodReturnStatement>
												<variableReferenceExpression name="scripts"/>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<variableDeclarationStatement type="System.String" name="fileType">
									<init>
										<primitiveExpression value=".min.js"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="EnableMinifiedScript"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="fileType"/>
											<primitiveExpression value=".js"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="CultureInfo" name="ci">
									<init>
										<propertyReferenceExpression name="CurrentUICulture">
											<typeReferenceExpression type="CultureInfo"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<xsl:choose>
									<xsl:when test="$IsClassLibrary='true'">
										<variableDeclarationStatement type="System.String" name="assemblyFullName">
											<init>
												<propertyReferenceExpression name="FullName">
													<propertyReferenceExpression name="Assembly">
														<methodInvokeExpression methodName="GetType"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueInequality">
													<propertyReferenceExpression name="Name">
														<variableReferenceExpression name="ci"/>
													</propertyReferenceExpression>
													<primitiveExpression value="en-US"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="scripts"/>
													</target>
													<parameters>
														<objectCreateExpression type="ScriptReference">
															<parameters>
																<stringFormatExpression>
																	<xsl:attribute name="format">
																		<xsl:value-of select="$Namespace"/>
																		<xsl:text>.</xsl:text>
																		<xsl:if test="$CodedomProviderName='CSharp'">
																			<xsl:text>js.sys.culture.</xsl:text>
																		</xsl:if>
																		<xsl:text>{0}.js</xsl:text>
																	</xsl:attribute>
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="ci"/>
																	</propertyReferenceExpression>
																</stringFormatExpression>
																<variableReferenceExpression name="assemblyFullName"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="EnableMinifiedScript"/>
											</condition>
											<trueStatements>
												<xsl:call-template name="GetScriptReferences"/>
											</trueStatements>
											<falseStatements>
												<xsl:call-template name="GetScriptReferences">
													<xsl:with-param name="Debug" select="'true'"/>
												</xsl:call-template>
											</falseStatements>
										</conditionStatement>
									</xsl:when>
									<xsl:otherwise>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueInequality">
													<propertyReferenceExpression name="Name">
														<variableReferenceExpression name="ci"/>
													</propertyReferenceExpression>
													<primitiveExpression value="en-US"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<xsl:call-template name="CreateScriptReference">
													<xsl:with-param name="Path">
														<stringFormatExpression format="~/js/sys/culture/{{0}}.js">
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="ci"/>
															</propertyReferenceExpression>
														</stringFormatExpression>
													</xsl:with-param>
												</xsl:call-template>
											</trueStatements>
										</conditionStatement>
										<xsl:call-template name="GetScriptReferences"/>
									</xsl:otherwise>
								</xsl:choose>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<variableReferenceExpression name="uiFramework"/>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<methodInvokeExpression methodName="AddScripts">
													<target>
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="ApplicationServices"/>
														</propertyReferenceExpression>
													</target>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="scripts"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="CreateScriptReference">
													<parameters>
														<primitiveExpression value="~/js/daf/add.min.js"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<xsl:if test="$Host=''">
									<conditionStatement>
										<condition>
											<variableReferenceExpression name="uiFramework"/>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="ConfigureScripts">
												<target>
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="scripts"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<methodReturnStatement>
									<variableReferenceExpression name="scripts"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<xsl:if test="$Host='DotNetNuke' or $Host='SharePoint'">
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
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<propertyReferenceExpression name="Site"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement/>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="ScriptReferenceCollection" name="scripts">
										<init>
											<propertyReferenceExpression name="Scripts">
												<methodInvokeExpression methodName="GetCurrent">
													<target>
														<typeReferenceExpression type="ScriptManager"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Page"/>
													</parameters>
												</methodInvokeExpression>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
									<foreachStatement>
										<variable type="ScriptReference" name="r"/>
										<target>
											<variableReferenceExpression name="scripts"/>
										</target>
										<statements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="Name">
															<variableReferenceExpression name="r"/>
														</propertyReferenceExpression>
														<xsl:call-template name="ResourceName">
															<xsl:with-param name="FileName" select="'MicrosoftAjax.min.js'"/>
															<xsl:with-param name="Folder" select="'js.sys'"/>
														</xsl:call-template>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodReturnStatement/>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
									<variableDeclarationStatement type="System.String" name="assemblyFullName">
										<init>
											<propertyReferenceExpression name="FullName">
												<propertyReferenceExpression name="Assembly">
													<methodInvokeExpression methodName="GetType"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="Add">
										<target>
											<variableReferenceExpression name="scripts"/>
										</target>
										<parameters>
											<objectCreateExpression type="ScriptReference">
												<parameters>
													<xsl:call-template name="ResourceName">
														<xsl:with-param name="FileName" select="'MicrosoftAjax.min.js'"/>
														<xsl:with-param name="Folder" select="'js.sys'"/>
													</xsl:call-template>
													<variableReferenceExpression name="assemblyFullName"/>
												</parameters>
											</objectCreateExpression>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Add">
										<target>
											<variableReferenceExpression name="scripts"/>
										</target>
										<parameters>
											<objectCreateExpression type="ScriptReference">
												<parameters>
													<xsl:call-template name="ResourceName">
														<xsl:with-param name="FileName" select="'MicrosoftAjaxWebForms.min.js'"/>
														<xsl:with-param name="Folder" select="'js.sys'"/>
													</xsl:call-template>
													<variableReferenceExpression name="assemblyFullName"/>
												</parameters>
											</objectCreateExpression>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
						</xsl:if>
						<!-- property RequiresMembershipScripts -->
						<memberProperty type="System.Boolean" name="RequiresMembershipScripts">
							<attributes family="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method ConfigureScripts(List<ScriptReference> scripts) -->
						<memberMethod name="ConfigureScripts">
							<attributes family="true"/>
							<parameters>
								<parameter type="List" name="scripts">
									<typeArguments>
										<typeReference type="ScriptReference"/>
									</typeArguments>
								</parameter>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<propertyReferenceExpression name="RequiresMembershipScripts"/>
											<unaryOperatorExpression operator="Not">
												<propertyReferenceExpression name="EnableCombinedScript"/>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="EnableMinifiedScript"/>
											</condition>
											<trueStatements>
												<xsl:choose>
													<xsl:when test="$IsClassLibrary='true'">
														<methodInvokeExpression methodName="Add">
															<target>
																<argumentReferenceExpression name="scripts"/>
															</target>
															<parameters>
																<objectCreateExpression type="ScriptReference">
																	<parameters>
																		<methodInvokeExpression methodName="ResolveEmbeddedResourceName">
																			<target>
																				<typeReferenceExpression type="CultureManager"/>
																			</target>
																			<parameters>
																				<xsl:call-template name="ResourceName">
																					<xsl:with-param name="FileName" select="'daf-resources.min.js'"/>
																					<xsl:with-param name="Folder" select="'js.daf'"/>
																				</xsl:call-template>
																			</parameters>
																		</methodInvokeExpression>
																		<propertyReferenceExpression name="FullName">
																			<propertyReferenceExpression name="Assembly">
																				<methodInvokeExpression methodName="GetType"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="Add">
															<target>
																<argumentReferenceExpression name="scripts"/>
															</target>
															<parameters>
																<objectCreateExpression type="ScriptReference">
																	<parameters>
																		<xsl:call-template name="ResourceName">
																			<xsl:with-param name="FileName" select="'daf-membership.min.js'"/>
																			<xsl:with-param name="Folder" select="'js.daf'"/>
																		</xsl:call-template>
																		<propertyReferenceExpression name="FullName">
																			<propertyReferenceExpression name="Assembly">
																				<methodInvokeExpression methodName="GetType"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</xsl:when>
													<xsl:otherwise>
														<methodInvokeExpression methodName="Add">
															<target>
																<argumentReferenceExpression name="scripts"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="CreateScriptReference">
																	<parameters>
																		<primitiveExpression value="~/js/daf/daf-resources.min.js"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="Add">
															<target>
																<argumentReferenceExpression name="scripts"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="CreateScriptReference">
																	<parameters>
																		<primitiveExpression value="~/js/daf/daf-membership.min.js"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</xsl:otherwise>
												</xsl:choose>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<argumentReferenceExpression name="scripts"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="CreateScriptReference">
															<parameters>
																<primitiveExpression value="~/js/daf/daf-resources.js"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Add">
													<target>
														<argumentReferenceExpression name="scripts"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="CreateScriptReference">
															<parameters>
																<primitiveExpression value="~/js/daf/daf-membership.js"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<xsl:variable name="TargetFramework">
							<xsl:choose>
								<xsl:when test="$IsPremium='true'">
									<xsl:text>4.0</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>4.01</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<!-- method OnLoad(EventArgs) -->
						<memberMethod name="OnLoad">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsInAsyncPostBack">
											<methodInvokeExpression methodName="GetCurrent">
												<target>
													<typeReferenceExpression type="ScriptManager"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Page"/>
												</parameters>
											</methodInvokeExpression>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="OnLoad">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<argumentReferenceExpression name="e"/>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Site"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<!--<variableDeclarationStatement type="CalendarExtender" name="ce">
                  <init>
                    <objectCreateExpression type="CalendarExtender"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <typeReferenceExpression type="Controls"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="ce"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="RegisterCssReferences">
                  <target>
                    <typeReferenceExpression type="ScriptObjectBuilder"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="ce"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Clear">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                </methodInvokeExpression>
                <xsl:if test="$IsClassLibrary='true'">
                  <methodInvokeExpression methodName="RegisterCssReferences">
                    <target>
                      <typeReferenceExpression type="ScriptObjectBuilder"/>
                    </target>
                    <parameters>
                      <thisReferenceExpression/>
                    </parameters>
                  </methodInvokeExpression>
                </xsl:if>-->
								<methodInvokeExpression  methodName="RegisterFrameworkSettings">
									<parameters>
										<propertyReferenceExpression name="Page"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method RegisterFrameworkSettings(Page) -->
						<memberMethod name="RegisterFrameworkSettings">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="Page" name="p"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="IsStartupScriptRegistered">
												<target>
													<propertyReferenceExpression name="ClientScript">
														<propertyReferenceExpression name="p"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<typeofExpression type="AquariumExtenderBase"/>
													<primitiveExpression value="TargetFramework"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="RegisterStartupScript">
											<target>
												<propertyReferenceExpression name="ClientScript">
													<propertyReferenceExpression name="p"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<typeofExpression type="AquariumExtenderBase"/>
												<primitiveExpression value="TargetFramework"/>
												<stringFormatExpression>
													<xsl:attribute name="format">
														<xsl:text>var __targetFramework="</xsl:text>
														<xsl:value-of select="a:project/@targetFramework"/>
														<xsl:text>",__tf=</xsl:text>
														<xsl:value-of select="$TargetFramework" />
														<xsl:text>,__servicePath="{0}",__baseUrl="{1}";</xsl:text>
														<xsl:if test="$Host!=''">
															<xsl:text>var __cothost="</xsl:text>
															<xsl:value-of select="$Host"/>
															<xsl:text>";</xsl:text>
														</xsl:if>
													</xsl:attribute>
													<methodInvokeExpression methodName="ResolveUrl">
														<target>
															<argumentReferenceExpression name="p"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="DefaultServicePath">
																<typeReferenceExpression type="AquariumExtenderBase"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
													<methodInvokeExpression methodName="ResolveUrl">
														<target>
															<argumentReferenceExpression name="p"/>
														</target>
														<parameters>
															<primitiveExpression value="~"/>
														</parameters>
													</methodInvokeExpression>
												</stringFormatExpression>
												<primitiveExpression value="true"/>
											</parameters>
										</methodInvokeExpression>
										<xsl:if test="$Host=''">
											<methodInvokeExpression methodName="RegisterStartupScript">
												<target>
													<propertyReferenceExpression name="ClientScript">
														<propertyReferenceExpression name="p"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<typeofExpression type="AquariumExtenderBase"/>
													<primitiveExpression value="TouchUI"/>
													<binaryOperatorExpression operator="Add">
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="var __settings="/>
															<methodInvokeExpression methodName="ToString">
																<target>
																	<methodInvokeExpression methodName="UserSettings">
																		<target>
																			<methodInvokeExpression methodName="Create">
																				<target>
																					<typeReferenceExpression type="ApplicationServices"/>
																				</target>
																			</methodInvokeExpression>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="p"/>
																		</parameters>
																	</methodInvokeExpression>
																</target>
																<parameters>
																	<propertyReferenceExpression name="None">
																		<propertyReferenceExpression name="Formatting">
																			<propertyReferenceExpression name="Json">
																				<typeReferenceExpression type="Newtonsoft"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
														<primitiveExpression value=";"/>
													</binaryOperatorExpression>
													<primitiveExpression value="true"/>
												</parameters>
											</methodInvokeExpression>
										</xsl:if>
										<!--<xsl:if test="$PageImplementation='html'">
                      <variableDeclarationStatement type="System.String" name="prefetches">
                        <init>
                          <castExpression targetType="System.String">
                            <arrayIndexerExpression>
                              <target>
                                <propertyReferenceExpression name="Items">
                                  <propertyReferenceExpression name="Current">
                                    <typeReferenceExpression type="HttpContext"/>
                                  </propertyReferenceExpression>
                                </propertyReferenceExpression>
                              </target>
                              <indices>
                                <primitiveExpression value="PrefetchData"/>
                              </indices>
                            </arrayIndexerExpression>
                          </castExpression>
                        </init>
                      </variableDeclarationStatement>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="IsNotNullOrEmpty">
                            <variableReferenceExpression name="prefetches"/>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodInvokeExpression methodName="RegisterStartupScript">
                            <target>
                              <propertyReferenceExpression name="ClientScript">
                                <variableReferenceExpression name="p"/>
                              </propertyReferenceExpression>
                            </target>
                            <parameters>
                              <typeofExpression type="AquariumExtenderBase"/>
                              <primitiveExpression value="Prefetch"/>
                              <stringFormatExpression format="&lt;script&gt;{{0}}&lt;/script&gt;">
                                <variableReferenceExpression name="prefetches"/>
                              </stringFormatExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </trueStatements>
                      </conditionStatement>
                    </xsl:if>-->
									</trueStatements>
								</conditionStatement>
								<xsl:if test="$AspNet35AppServicesFix">
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="IsStartupScriptRegistered">
													<target>
														<propertyReferenceExpression name="ClientScript">
															<propertyReferenceExpression name="p"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<typeofExpression type="AquariumExtenderBase"/>
														<primitiveExpression value="ApplicatonServices35"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="RegisterStartupScript">
												<target>
													<propertyReferenceExpression name="ClientScript">
														<propertyReferenceExpression name="p"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<typeofExpression type="AquariumExtenderBase"/>
													<primitiveExpression value="ApplicatonServices35"/>
													<stringFormatExpression format="Sys.Services._AuthenticationService.DefaultWebServicePath='{{0}}';Sys.Services.AuthenticationService._setAuthenticated({{1}});">
														<methodInvokeExpression methodName="ResolveUrl">
															<target>
																<propertyReferenceExpression name="p"/>
															</target>
															<parameters>
																<primitiveExpression value="~/Authentication_JSON_AppService.axd"/>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="ToLower">
															<target>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<propertyReferenceExpression name="IsAuthenticated">
																			<propertyReferenceExpression name="Identity">
																				<propertyReferenceExpression name="User">
																					<propertyReferenceExpression name="p"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</target>
																</methodInvokeExpression>
															</target>
														</methodInvokeExpression>
													</stringFormatExpression>
													<!--<methodInvokeExpression methodName="Format">
                            <target>
                              <typeReferenceExpression type="String"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="Sys.Services._AuthenticationService.DefaultWebServicePath='{{0}}';Sys.Services.AuthenticationService._setAuthenticated({{1}});"/>
                              <methodInvokeExpression methodName="ResolveClientUrl">
                                <target>
                                  <propertyReferenceExpression name="Page"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="~/Authentication_JSON_AppService.axd"/>
                                </parameters>
                              </methodInvokeExpression>
                              <methodInvokeExpression methodName="ToLower">
                                <target>
                                  <methodInvokeExpression methodName="ToString">
                                    <target>
                                      <propertyReferenceExpression name="IsAuthenticated">
                                        <propertyReferenceExpression name="Identity">
                                          <propertyReferenceExpression name="User">
                                            <propertyReferenceExpression name="Page"/>
                                          </propertyReferenceExpression>
                                        </propertyReferenceExpression>
                                      </propertyReferenceExpression>
                                    </target>
                                  </methodInvokeExpression>
                                </target>
                              </methodInvokeExpression>
                            </parameters>
                          </methodInvokeExpression>-->
													<primitiveExpression value="true"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- method ListOfStandardScripts(bool) -->
						<memberMethod returnType="List" name="StandardScripts">
							<typeArguments>
								<typeReference type="ScriptReference"/>
							</typeArguments>
							<attributes public="true" static="true"/>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="StandardScripts">
										<parameters>
											<primitiveExpression value="false"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ListOfStandardScripts(bool) -->
						<memberMethod returnType="List" name="StandardScripts">
							<typeArguments>
								<typeReference type="ScriptReference"/>
							</typeArguments>
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Boolean" name="ignoreCombinedScriptFlag"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="AquariumExtenderBase" name="extender">
									<init>
										<objectCreateExpression type="AquariumExtenderBase">
											<parameters>
												<primitiveExpression value="null"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="IgnoreCombinedScript">
										<variableReferenceExpression name="extender"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="ignoreCombinedScriptFlag"/>
								</assignStatement>
								<methodReturnStatement>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="ScriptReference"/>
										</typeArguments>
										<parameters>
											<methodInvokeExpression methodName="GetScriptReferences">
												<target>
													<variableReferenceExpression name="extender"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OnPreRender (EventArgs)-->
						<memberMethod name="OnPreRender">
							<attributes override="true" family="true"/>
							<parameters>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="OnPreRender">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<argumentReferenceExpression name="e"/>
									</parameters>
								</methodInvokeExpression>
								<xsl:if test="$IsClassLibrary='true'">
									<xsl:if test="$ScriptOnly='true' or true()">
										<foreachStatement>
											<variable type="Control" name="c" var="false"/>
											<target>
												<propertyReferenceExpression name="Controls">
													<propertyReferenceExpression name="Header">
														<propertyReferenceExpression name="Page"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="ID">
																<variableReferenceExpression name="c"/>
															</propertyReferenceExpression>
															<primitiveExpression value="{a:project/a:namespace}Theme"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement/>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</xsl:if>
									<variableDeclarationStatement type="HtmlLink" name="link">
										<init>
											<objectCreateExpression type="HtmlLink"/>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="ID">
											<variableReferenceExpression name="link"/>
										</propertyReferenceExpression>
										<primitiveExpression value="{a:project/a:namespace}Theme"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="Href">
											<variableReferenceExpression name="link"/>
										</propertyReferenceExpression>
										<methodInvokeExpression methodName="GetWebResourceUrl">
											<target>
												<propertyReferenceExpression name="ClientScript">
													<typeReferenceExpression type="Page"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<typeofExpression type="AquariumExtenderBase"/>
												<primitiveExpression value="{a:project/a:namespace}{$ThemeFolder}.{a:project/a:theme/@name}.css"/>
											</parameters>
										</methodInvokeExpression>
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
												<propertyReferenceExpression name="Header">
													<typeReferenceExpression type="Page"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<variableReferenceExpression name="link"/>
										</parameters>
									</methodInvokeExpression>
								</xsl:if>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>

	<xsl:template name="TouchOrDesktop">
		<xsl:param name="Touch"/>
		<xsl:param name="Desktop"/>
		<xsl:param name="Conditional">
			<variableReferenceExpression name="isMobile"/>
		</xsl:param>
		<xsl:choose>
			<xsl:when test="$UI='Both' and $Touch">
				<conditionStatement>
					<condition>
						<xsl:copy-of select="$Conditional"/>
					</condition>
					<trueStatements>
						<xsl:copy-of select="$Touch"/>
					</trueStatements>
					<xsl:if test="$Desktop">
						<falseStatements>
							<xsl:copy-of select="$Desktop"/>
						</falseStatements>
					</xsl:if>
				</conditionStatement>
			</xsl:when>
			<xsl:when test="$UI='Both'">
				<conditionStatement>
					<condition>
						<unaryOperatorExpression operator="Not">
							<xsl:copy-of select="$Conditional"/>
						</unaryOperatorExpression>
					</condition>
					<trueStatements>
						<xsl:copy-of select="$Desktop"/>
					</trueStatements>
				</conditionStatement>
			</xsl:when>
			<xsl:when test="$UI='TouchUI' and $Touch">
				<xsl:copy-of select="$Touch"/>
			</xsl:when>
			<xsl:when test="$UI='Desktop' and $Desktop">
				<xsl:copy-of select="$Desktop"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="CreateScriptReference">
		<xsl:param name="Path" select="''"/>
		<xsl:param name="Resource" select="''"/>
		<xsl:param name="Debug" select="'false'"/>
		<methodInvokeExpression methodName="Add">
			<target>
				<variableReferenceExpression name="scripts"/>
			</target>
			<parameters>
				<xsl:choose>
					<xsl:when test="$IsClassLibrary='true' and $Debug='false' and not(not($Resource))">
						<objectCreateExpression type="ScriptReference">
							<parameters>
								<xsl:copy-of select="$Resource"/>
								<variableReferenceExpression name="assemblyFullName"/>
							</parameters>
						</objectCreateExpression>
					</xsl:when>
					<xsl:otherwise>
						<methodInvokeExpression methodName="CreateScriptReference">
							<parameters>
								<xsl:copy-of select="$Path"/>
							</parameters>
						</methodInvokeExpression>
					</xsl:otherwise>
				</xsl:choose>
			</parameters>
		</methodInvokeExpression>
	</xsl:template>

	<xsl:template name="GetScriptReferences">
		<xsl:param name="Debug" select="'false'"/>
		<xsl:if test="$AspNet35AppServicesFix">
			<xsl:call-template name="CreateScriptReference">
				<xsl:with-param name="Resource">
					<xsl:call-template name="ResourceName">
						<xsl:with-param name="FileName" select="'MicrosoftAjaxApplicationServices.min.js'"/>
						<xsl:with-param name="Folder" select="'js.sys'"/>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="Path">
					<primitiveExpression value="~/js/sys/MicrosoftAjaxApplicationServices.min.js"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="TouchOrDesktop">
			<xsl:with-param name="Desktop">
				<xsl:choose>
					<xsl:when test="$Host='DotNetNuke'">
						<variableDeclarationStatement type="System.Boolean" name="registerSystemJs">
							<init>
								<primitiveExpression value="true"/>
							</init>
						</variableDeclarationStatement>
						<foreachStatement>
							<variable type="System.Reflection.Assembly" name="a"/>
							<target>
								<methodInvokeExpression methodName="GetAssemblies">
									<target>
										<propertyReferenceExpression name="CurrentDomain">
											<typeReferenceExpression type="AppDomain"/>
										</propertyReferenceExpression>
									</target>
								</methodInvokeExpression>
							</target>
							<statements>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Contains">
											<target>
												<propertyReferenceExpression name="FullName">
													<variableReferenceExpression name="a"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<primitiveExpression value="DotNetNuke"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="registerSystemJs"/>
											<primitiveExpression value="false"/>
										</assignStatement>
										<breakStatement/>
									</trueStatements>
								</conditionStatement>
							</statements>
						</foreachStatement>
						<conditionStatement>
							<condition>
								<variableReferenceExpression name="registerSystemJs"/>
							</condition>
							<trueStatements>
								<methodInvokeExpression methodName="Add">
									<target>
										<variableReferenceExpression name="scripts"/>
									</target>
									<parameters>
										<objectCreateExpression type="ScriptReference">
											<parameters>
												<xsl:call-template name="ResourceName">
													<xsl:with-param name="FileName" select="'_System.js'"/>
													<xsl:with-param name="Folder" select="'js.sys'"/>
												</xsl:call-template>
												<variableReferenceExpression name="assemblyFullName"/>
											</parameters>
										</objectCreateExpression>
									</parameters>
								</methodInvokeExpression>
							</trueStatements>
						</conditionStatement>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="CreateScriptReference">
							<xsl:with-param name="Resource">
								<xsl:call-template name="ResourceName">
									<xsl:with-param name="FileName" select="'_System.js'"/>
									<xsl:with-param name="Folder" select="'js.sys'"/>
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param name="Path">
								<primitiveExpression value="~/js/sys/_System.js"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="Touch">
				<xsl:choose>
					<xsl:when test="$UI='TouchUI'">
						<conditionStatement>
							<condition>
								<methodInvokeExpression methodName="IsMatch">
									<target>
										<typeReferenceExpression type="Regex"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="Browser">
											<propertyReferenceExpression name="Browser">
												<propertyReferenceExpression name="Request">
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="HttpContext"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
										<primitiveExpression value="IE|InternetExplorer"/>
									</parameters>
								</methodInvokeExpression>
							</condition>
							<trueStatements>
								<xsl:call-template name="CreateScriptReference">
									<xsl:with-param name="Resource">
										<binaryOperatorExpression operator="Add">
											<xsl:call-template name="ResourceName">
												<xsl:with-param name="FileName" select="'jquery-2.2.4'"/>
												<xsl:with-param name="Folder" select="'js.sys'"/>
											</xsl:call-template>
											<variableReferenceExpression name="fileType"/>
										</binaryOperatorExpression>
									</xsl:with-param>
									<xsl:with-param name="Path">
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="~/js/sys/jquery-2.2.4"/>
											<variableReferenceExpression name="fileType"/>
										</binaryOperatorExpression>
									</xsl:with-param>
									<xsl:with-param name="Debug" select="$Debug"/>
								</xsl:call-template>
							</trueStatements>
							<falseStatements>
								<xsl:call-template name="CreateScriptReference">
									<xsl:with-param name="Resource">
										<binaryOperatorExpression operator="Add">
											<xsl:call-template name="ResourceName">
												<xsl:with-param name="FileName" select="'jquery-3.6.0'"/>
												<xsl:with-param name="Folder" select="'js.sys'"/>
											</xsl:call-template>
											<variableReferenceExpression name="fileType"/>
										</binaryOperatorExpression>
									</xsl:with-param>
									<xsl:with-param name="Path">
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="~/js/sys/jquery-3.6.0"/>
											<variableReferenceExpression name="fileType"/>
										</binaryOperatorExpression>
									</xsl:with-param>
									<xsl:with-param name="Debug" select="$Debug"/>
								</xsl:call-template>
							</falseStatements>
						</conditionStatement>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="CreateScriptReference">
							<xsl:with-param name="Resource">
								<binaryOperatorExpression operator="Add">
									<xsl:call-template name="ResourceName">
										<xsl:with-param name="FileName" select="'jquery-2.2.4'"/>
										<xsl:with-param name="Folder" select="'js.sys'"/>
									</xsl:call-template>
									<variableReferenceExpression name="fileType"/>
								</binaryOperatorExpression>
							</xsl:with-param>
							<xsl:with-param name="Path">
								<binaryOperatorExpression operator="Add">
									<primitiveExpression value="~/js/sys/jquery-2.2.4"/>
									<variableReferenceExpression name="fileType"/>
								</binaryOperatorExpression>
							</xsl:with-param>
							<xsl:with-param name="Debug" select="$Debug"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				<conditionStatement>
					<condition>
						<binaryOperatorExpression operator="BooleanAnd">
							<variableReferenceExpression name="uiFramework"/>
							<binaryOperatorExpression operator="BooleanAnd">
								<binaryOperatorExpression operator="BooleanOr">
									<unaryOperatorExpression operator="Not">
										<propertyReferenceExpression name="EnableCombinedScript"/>
									</unaryOperatorExpression>
									<binaryOperatorExpression operator="ValueEquality">
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Params">
													<propertyReferenceExpression name="Request">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="_cf"/>
											</indices>
										</arrayIndexerExpression>
										<primitiveExpression value="bootstrap"/>
									</binaryOperatorExpression>
								</binaryOperatorExpression>
								<convertExpression to="Boolean">
									<methodInvokeExpression methodName="Settings">
										<target>
											<typeReferenceExpression type="ApplicationServicesBase"/>
										</target>
										<parameters>
											<primitiveExpression value="server.bootstrap.js"/>
										</parameters>
									</methodInvokeExpression>
								</convertExpression>
							</binaryOperatorExpression>
						</binaryOperatorExpression>
					</condition>
					<trueStatements>
						<xsl:call-template name="CreateScriptReference">
							<xsl:with-param name="Resource">
								<xsl:call-template name="ResourceName">
									<xsl:with-param name="FileName" select="'bootstrap.min.js'"/>
									<xsl:with-param name="Folder" select="'js.sys'"/>
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param name="Path">
								<primitiveExpression value="~/js/sys/bootstrap.min.js"/>
							</xsl:with-param>
						</xsl:call-template>
					</trueStatements>
				</conditionStatement>
				<conditionStatement>
					<condition>
						<variableReferenceExpression name="uiFramework"/>
					</condition>
					<trueStatements>
						<xsl:call-template name="CreateScriptReference">
							<xsl:with-param name="Resource">
								<binaryOperatorExpression operator="Add">
									<xsl:call-template name="ResourceName">
										<xsl:with-param name="FileName" select="'touch-core'"/>
										<xsl:with-param name="Folder" select="'js.daf'"/>
									</xsl:call-template>
									<variableReferenceExpression name="fileType"/>
								</binaryOperatorExpression>
							</xsl:with-param>
							<xsl:with-param name="Path">
								<stringFormatExpression format="~/js/daf/touch-core{{0}}">
									<variableReferenceExpression name="fileType"/>
								</stringFormatExpression>
							</xsl:with-param>
							<xsl:with-param name="Debug" select="$Debug"/>
						</xsl:call-template>
					</trueStatements>
				</conditionStatement>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="CreateScriptReference">
			<xsl:with-param name="Resource">
				<xsl:call-template name="ResourceName">
					<xsl:with-param name="FileName" select="'MicrosoftAjax.min.js'"/>
					<xsl:with-param name="Folder" select="'js.sys'"/>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="Path">
				<primitiveExpression value="~/js/sys/MicrosoftAjax.min.js"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="$PageImplementation!='html'">
			<xsl:call-template name="CreateScriptReference">
				<xsl:with-param name="Resource">
					<xsl:call-template name="ResourceName">
						<xsl:with-param name="FileName" select="'MicrosoftAjaxWebForms.min.js'"/>
						<xsl:with-param name="Folder" select="'js.sys'"/>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="Path">
					<primitiveExpression value="~/js/sys/MicrosoftAjaxWebForms.min.js"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$ScriptOnly='false'">
			<methodInvokeExpression methodName="AddRange">
				<target>
					<variableReferenceExpression name="scripts"/>
				</target>
				<parameters>
					<methodInvokeExpression methodName="GetScriptReferences">
						<target>
							<typeReferenceExpression type="ScriptObjectBuilder"/>
						</target>
						<parameters>
							<typeofExpression type="ModalPopupExtender"/>
						</parameters>
					</methodInvokeExpression>
				</parameters>
			</methodInvokeExpression>
			<methodInvokeExpression methodName="AddRange">
				<target>
					<variableReferenceExpression name="scripts"/>
				</target>
				<parameters>
					<methodInvokeExpression methodName="GetScriptReferences">
						<target>
							<typeReferenceExpression type="ScriptObjectBuilder"/>
						</target>
						<parameters>
							<typeofExpression type="AlwaysVisibleControlExtender"/>
						</parameters>
					</methodInvokeExpression>
				</parameters>
			</methodInvokeExpression>
			<methodInvokeExpression methodName="AddRange">
				<target>
					<variableReferenceExpression name="scripts"/>
				</target>
				<parameters>
					<methodInvokeExpression methodName="GetScriptReferences">
						<target>
							<typeReferenceExpression type="ScriptObjectBuilder"/>
						</target>
						<parameters>
							<typeofExpression type="PopupControlExtender"/>
						</parameters>
					</methodInvokeExpression>
				</parameters>
			</methodInvokeExpression>
			<methodInvokeExpression methodName="AddRange">
				<target>
					<variableReferenceExpression name="scripts"/>
				</target>
				<parameters>
					<methodInvokeExpression methodName="GetScriptReferences">
						<target>
							<typeReferenceExpression type="ScriptObjectBuilder"/>
						</target>
						<parameters>
							<typeofExpression type="CalendarExtender"/>
						</parameters>
					</methodInvokeExpression>
				</parameters>
			</methodInvokeExpression>
			<methodInvokeExpression methodName="AddRange">
				<target>
					<variableReferenceExpression name="scripts"/>
				</target>
				<parameters>
					<methodInvokeExpression methodName="GetScriptReferences">
						<target>
							<typeReferenceExpression type="ScriptObjectBuilder"/>
						</target>
						<parameters>
							<typeofExpression type="MaskedEditExtender"/>
						</parameters>
					</methodInvokeExpression>
				</parameters>
			</methodInvokeExpression>
			<methodInvokeExpression methodName="AddRange">
				<target>
					<variableReferenceExpression name="scripts"/>
				</target>
				<parameters>
					<methodInvokeExpression methodName="GetScriptReferences">
						<target>
							<typeReferenceExpression type="ScriptObjectBuilder"/>
						</target>
						<parameters>
							<typeofExpression type="AutoCompleteExtender"/>
						</parameters>
					</methodInvokeExpression>
				</parameters>
			</methodInvokeExpression>
		</xsl:if>
		<xsl:if test="$ScriptOnly='true'">
			<xsl:call-template name="TouchOrDesktop">
				<xsl:with-param name="Desktop">
					<xsl:call-template name="CreateScriptReference">
						<xsl:with-param name="Resource">
							<xsl:call-template name="ResourceName">
								<xsl:with-param name="FileName" select="'AjaxControlToolkit.min.js'"/>
								<xsl:with-param name="Folder" select="'js.sys'"/>
							</xsl:call-template>
						</xsl:with-param>
						<xsl:with-param name="Path">
							<primitiveExpression value="~/js/sys/AjaxControlToolkit.min.js"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="$PageImplementation='html'">
						<xsl:call-template name="CreateScriptReference">
							<xsl:with-param name="Resource">
								<xsl:call-template name="ResourceName">
									<xsl:with-param name="FileName" select="'MicrosoftAjaxWebForms.min.js'"/>
									<xsl:with-param name="Folder" select="'js.sys'"/>
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param name="Path">
								<primitiveExpression value="~/js/sys/MicrosoftAjaxWebForms.min.js"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="CreateScriptReference">
			<xsl:with-param name="Resource">
				<methodInvokeExpression methodName="ResolveEmbeddedResourceName">
					<target>
						<typeReferenceExpression type="CultureManager"/>
					</target>
					<parameters>
						<binaryOperatorExpression operator="Add">
							<xsl:call-template name="ResourceName">
								<xsl:with-param name="FileName" select="'daf-resources'"/>
								<xsl:with-param name="Folder" select="'js.daf'"/>
							</xsl:call-template>
							<variableReferenceExpression name="fileType"/>
						</binaryOperatorExpression>
					</parameters>
				</methodInvokeExpression>
			</xsl:with-param>
			<xsl:with-param name="Path">
				<binaryOperatorExpression operator="Add">
					<primitiveExpression value="~/js/daf/daf-resources"/>
					<variableReferenceExpression name="fileType"/>
				</binaryOperatorExpression>
			</xsl:with-param>
			<xsl:with-param name="Debug" select="$Debug"/>
		</xsl:call-template>
		<xsl:call-template name="TouchOrDesktop">
			<xsl:with-param name="Desktop">
				<xsl:call-template name="CreateScriptReference">
					<xsl:with-param name="Resource">
						<binaryOperatorExpression operator="Add">
							<xsl:call-template name="ResourceName">
								<xsl:with-param name="FileName" select="'daf-menu'"/>
								<xsl:with-param name="Folder" select="'js.daf'"/>
							</xsl:call-template>
							<variableReferenceExpression name="fileType"/>
						</binaryOperatorExpression>
					</xsl:with-param>
					<xsl:with-param name="Path">
						<binaryOperatorExpression operator="Add">
							<primitiveExpression value="~/js/daf/daf-menu"/>
							<variableReferenceExpression name="fileType"/>
						</binaryOperatorExpression>
					</xsl:with-param>
					<xsl:with-param name="Debug" select="$Debug"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="CreateScriptReference">
			<xsl:with-param name="Resource">
				<binaryOperatorExpression operator="Add">
					<xsl:call-template name="ResourceName">
						<xsl:with-param name="FileName" select="'daf'"/>
						<xsl:with-param name="Folder" select="'js.daf'"/>
					</xsl:call-template>
					<variableReferenceExpression name="fileType"/>
				</binaryOperatorExpression>
			</xsl:with-param>
			<xsl:with-param name="Path">
				<binaryOperatorExpression operator="Add">
					<primitiveExpression value="~/js/daf/daf"/>
					<variableReferenceExpression name="fileType"/>
				</binaryOperatorExpression>
			</xsl:with-param>
			<xsl:with-param name="Debug" select="$Debug"/>
		</xsl:call-template>
		<xsl:call-template name="CreateScriptReference">
			<xsl:with-param name="Resource">
				<binaryOperatorExpression operator="Add">
					<xsl:call-template name="ResourceName">
						<xsl:with-param name="FileName" select="'daf-odp'"/>
						<xsl:with-param name="Folder" select="'js.daf'"/>
					</xsl:call-template>
					<variableReferenceExpression name="fileType"/>
				</binaryOperatorExpression>
			</xsl:with-param>
			<xsl:with-param name="Path">
				<binaryOperatorExpression operator="Add">
					<primitiveExpression value="~/js/daf/daf-odp"/>
					<variableReferenceExpression name="fileType"/>
				</binaryOperatorExpression>
			</xsl:with-param>
			<xsl:with-param name="Debug" select="$Debug"/>
		</xsl:call-template>
		<xsl:call-template name="CreateScriptReference">
			<xsl:with-param name="Resource">
				<binaryOperatorExpression operator="Add">
					<xsl:call-template name="ResourceName">
						<xsl:with-param name="FileName" select="'daf-ifttt'"/>
						<xsl:with-param name="Folder" select="'js.daf'"/>
					</xsl:call-template>
					<variableReferenceExpression name="fileType"/>
				</binaryOperatorExpression>
			</xsl:with-param>
			<xsl:with-param name="Path">
				<binaryOperatorExpression operator="Add">
					<primitiveExpression value="~/js/daf/daf-ifttt"/>
					<variableReferenceExpression name="fileType"/>
				</binaryOperatorExpression>
			</xsl:with-param>
			<xsl:with-param name="Debug" select="$Debug"/>
		</xsl:call-template>
		<xsl:call-template name="TouchOrDesktop">
			<xsl:with-param name="Desktop">
				<xsl:call-template name="CreateScriptReference">
					<xsl:with-param name="Resource">
						<binaryOperatorExpression operator="Add">
							<xsl:call-template name="ResourceName">
								<xsl:with-param name="FileName" select="'classic'"/>
								<xsl:with-param name="Folder" select="'js.daf'"/>
							</xsl:call-template>
							<variableReferenceExpression name="fileType"/>
						</binaryOperatorExpression>
					</xsl:with-param>
					<xsl:with-param name="Path">
						<binaryOperatorExpression operator="Add">
							<primitiveExpression value="~/js/daf/classic"/>
							<variableReferenceExpression name="fileType"/>
						</binaryOperatorExpression>
					</xsl:with-param>
					<xsl:with-param name="Debug" select="$Debug"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="$IsPremium='true'">
			<xsl:call-template name="TouchOrDesktop">
				<xsl:with-param name="Desktop">
					<conditionStatement>
						<condition>
							<propertyReferenceExpression name="SupportsScrollingInDataSheet">
								<objectCreateExpression type="ControllerUtilities"/>
							</propertyReferenceExpression>
						</condition>
						<trueStatements>
							<xsl:call-template name="CreateScriptReference">
								<xsl:with-param name="Resource">
									<binaryOperatorExpression operator="Add">
										<xsl:call-template name="ResourceName">
											<xsl:with-param name="FileName" select="'daf-extensions'"/>
											<xsl:with-param name="Folder" select="'js.daf'"/>
										</xsl:call-template>
										<variableReferenceExpression name="fileType"/>
									</binaryOperatorExpression>
								</xsl:with-param>
								<xsl:with-param name="Path">
									<binaryOperatorExpression operator="Add">
										<primitiveExpression value="~/js/daf/daf-extensions"/>
										<variableReferenceExpression name="fileType"/>
									</binaryOperatorExpression>
								</xsl:with-param>
								<xsl:with-param name="Debug" select="$Debug"/>
							</xsl:call-template>
						</trueStatements>
					</conditionStatement>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="a:project/a:membership[@enabled='true' or @windowsAuthentication='true' or @customSecurity='true' or @activeDirectory='true']">
			<conditionStatement>
				<condition>
					<binaryOperatorExpression operator="BooleanOr">
						<propertyReferenceExpression name="EnableCombinedScript"/>
						<unaryOperatorExpression operator="Not">
							<variableReferenceExpression name="uiFramework"/>
						</unaryOperatorExpression>
					</binaryOperatorExpression>
				</condition>
				<trueStatements>
					<xsl:call-template name="CreateScriptReference">
						<xsl:with-param name="Resource">
							<binaryOperatorExpression operator="Add">
								<xsl:call-template name="ResourceName">
									<xsl:with-param name="FileName" select="'daf-membership'"/>
									<xsl:with-param name="Folder" select="'js.daf'"/>
								</xsl:call-template>
								<variableReferenceExpression name="fileType"/>
							</binaryOperatorExpression>
						</xsl:with-param>
						<xsl:with-param name="Path">
							<binaryOperatorExpression operator="Add">
								<primitiveExpression value="~/js/daf/daf-membership"/>
								<variableReferenceExpression name="fileType"/>
							</binaryOperatorExpression>
						</xsl:with-param>
						<xsl:with-param name="Debug" select="$Debug"/>
					</xsl:call-template>
				</trueStatements>
			</conditionStatement>
		</xsl:if>
		<methodInvokeExpression methodName="ConfigureScripts">
			<parameters>
				<variableReferenceExpression name="scripts"/>
			</parameters>
		</methodInvokeExpression>
		<xsl:call-template name="TouchOrDesktop">
			<xsl:with-param name="Touch">
				<conditionStatement>
					<condition>
						<variableReferenceExpression name="uiFramework"/>
					</condition>
					<trueStatements>
						<xsl:call-template name="CreateScriptReference">
							<xsl:with-param name="Resource">
								<binaryOperatorExpression operator="Add">
									<xsl:call-template name="ResourceName">
										<xsl:with-param name="FileName" select="'touch'"/>
										<xsl:with-param name="Folder" select="'js.daf'"/>
									</xsl:call-template>
									<variableReferenceExpression name="fileType"/>
								</binaryOperatorExpression>
							</xsl:with-param>
							<xsl:with-param name="Path">
								<binaryOperatorExpression operator="Add">
									<primitiveExpression value="~/js/daf/touch"/>
									<variableReferenceExpression name="fileType"/>
								</binaryOperatorExpression>
							</xsl:with-param>
							<xsl:with-param name="Debug" select="$Debug"/>
						</xsl:call-template>
						<xsl:call-template name="CreateScriptReference">
							<xsl:with-param name="Resource">
								<binaryOperatorExpression operator="Add">
									<xsl:call-template name="ResourceName">
										<xsl:with-param name="FileName" select="'input-blob'"/>
										<xsl:with-param name="Folder" select="'js.daf'"/>
									</xsl:call-template>
									<variableReferenceExpression name="fileType"/>
								</binaryOperatorExpression>
							</xsl:with-param>
							<xsl:with-param name="Path">
								<binaryOperatorExpression operator="Add">
									<primitiveExpression value="~/js/daf/input-blob"/>
									<variableReferenceExpression name="fileType"/>
								</binaryOperatorExpression>
							</xsl:with-param>
							<xsl:with-param name="Debug" select="$Debug"/>
						</xsl:call-template>
						<xsl:call-template name="CreateScriptReference">
							<xsl:with-param name="Resource">
								<binaryOperatorExpression operator="Add">
									<xsl:call-template name="ResourceName">
										<xsl:with-param name="FileName" select="'touch-edit'"/>
										<xsl:with-param name="Folder" select="'js.daf'"/>
									</xsl:call-template>
									<variableReferenceExpression name="fileType"/>
								</binaryOperatorExpression>
							</xsl:with-param>
							<xsl:with-param name="Path">
								<binaryOperatorExpression operator="Add">
									<primitiveExpression value="~/js/daf/touch-edit"/>
									<variableReferenceExpression name="fileType"/>
								</binaryOperatorExpression>
							</xsl:with-param>
							<xsl:with-param name="Debug" select="$Debug"/>
						</xsl:call-template>
						<xsl:call-template name="CreateScriptReference">
							<xsl:with-param name="Resource">
								<binaryOperatorExpression operator="Add">
									<xsl:call-template name="ResourceName">
										<xsl:with-param name="FileName" select="'touch-charts'"/>
										<xsl:with-param name="Folder" select="'js.daf'"/>
									</xsl:call-template>
									<variableReferenceExpression name="fileType"/>
								</binaryOperatorExpression>
							</xsl:with-param>
							<xsl:with-param name="Path">
								<binaryOperatorExpression operator="Add">
									<primitiveExpression value="~/js/daf/touch-charts"/>
									<variableReferenceExpression name="fileType"/>
								</binaryOperatorExpression>
							</xsl:with-param>
							<xsl:with-param name="Debug" select="$Debug"/>
						</xsl:call-template>
					</trueStatements>
				</conditionStatement>
				<xsl:call-template name="CreateScriptReference">
					<xsl:with-param name="Resource">
						<binaryOperatorExpression operator="Add">
							<xsl:call-template name="ResourceName">
								<xsl:with-param name="FileName" select="'unicode'"/>
								<xsl:with-param name="Folder" select="'js.sys'"/>
							</xsl:call-template>
							<variableReferenceExpression name="fileType"/>
						</binaryOperatorExpression>
					</xsl:with-param>
					<xsl:with-param name="Path">
						<binaryOperatorExpression operator="Add">
							<primitiveExpression value="~/js/sys/unicode"/>
							<variableReferenceExpression name="fileType"/>
						</binaryOperatorExpression>
					</xsl:with-param>
					<xsl:with-param name="Debug" select="$Debug"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="ResourceName">
		<xsl:param name="FileName"/>
		<xsl:param name="Folder"/>
		<primitiveExpression>
			<xsl:attribute name="value">
				<xsl:value-of select="$Namespace"/>
				<xsl:text>.</xsl:text>
				<xsl:if test="$CodedomProviderName='CSharp'">
					<xsl:value-of select="$Folder"/>
					<xsl:text>.</xsl:text>
				</xsl:if>
				<xsl:value-of select="$FileName"/>
			</xsl:attribute>
		</primitiveExpression>
	</xsl:template>

</xsl:stylesheet>
