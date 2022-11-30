<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsClassLibrary" select="'false'"/>
	<xsl:param name="Namespace" select="a:project/a:namespace"/>
	<xsl:param name="IsUnlimited"/>
	<xsl:param name="PageImplementation"/>

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Web">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.Globalization"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Configuration"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.UI.HtmlControls"/>
				<namespaceImport name="System.Web.UI.WebControls"/>
				<namespaceImport name="System.Web.UI.WebControls.WebParts"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<!--<namespaceImport name="AjaxControlToolkit"/>-->
			</imports>
			<types>
				<!-- class MembershipBar -->
				<typeDeclaration name="MembershipBar" isPartial="true">
					<baseTypes>
						<typeReference type="MembershipBarBase"/>
					</baseTypes>
				</typeDeclaration>
				<!-- class MembershipBarBase -->
				<typeDeclaration name="MembershipBarBase">
					<baseTypes>
						<typeReference type="Control"/>
						<typeReference type="INamingContainer"/>
					</baseTypes>
					<members>
						<!-- property ServicePath -->
						<memberField type="System.String" name="servicePath"/>
						<memberProperty type="System.String" name="ServicePath">
							<attributes public="true" final="true"/>
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
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<fieldReferenceExpression name="servicePath"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
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
						<!-- property Welcome -->
						<memberField type="System.String" name="welcome"/>
						<memberProperty type="System.String" name="Welcome">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="Specifies a welcome message for an authenticated user. Example: Welcome &lt;b&gt;{{0}}&lt;/b&gt;, Today is {{1:D}}"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="welcome"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="welcome"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DisplayRememberMe -->
						<memberField type="System.Boolean" name="displayRememberMe"/>
						<memberProperty type="System.Boolean" name="DisplayRememberMe">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="true"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="Controls display of 'Remember me' check box in a login window."/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="displayRememberMe"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="displayRememberMe"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DisplayLogin -->
						<memberField type="System.Boolean" name="displayLogin"/>
						<memberProperty type="System.Boolean" name="DisplayLogin">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="true"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="Specifies if a fly-over login dialog is displayed on the memberhhip bar."/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="displayLogin"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="displayLogin"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property RememberMeSet -->
						<memberField type="System.Boolean" name="rememberMeSet"/>
						<memberProperty type="System.Boolean" name="RememberMeSet">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="false"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="Specifies if 'Remember me' check box in a login window is selected by default."/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="rememberMeSet"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="rememberMeSet"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DisplayPasswordRecovery -->
						<memberField type="System.Boolean" name="displayPasswordRecovery"/>
						<memberProperty type="System.Boolean" name="DisplayPasswordRecovery">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="true"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="Controls display of a password recovery link in a login window."/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="displayPasswordRecovery"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="displayPasswordRecovery"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DisplaySignUp -->
						<memberField type="System.Boolean" name="displaySignUp"/>
						<memberProperty type="System.Boolean" name="DisplaySignUp">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="true"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="Controls display of a anonymous user account sign up link in a login window."/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="displaySignUp"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="displaySignUp"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DisplayMyAccount -->
						<memberField type="System.Boolean" name="displayMyAccount"/>
						<memberProperty type="System.Boolean" name="DisplayMyAccount">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="true"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="Controls display of 'My Account' link for authenticated users on a membership bar."/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="displayMyAccount"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="displayMyAccount"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DisplayHelp -->
						<memberField type="System.Boolean" name="displayHelp"/>
						<memberProperty type="System.Boolean" name="DisplayHelp">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="true"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="Controls display of a 'Help' link on a membership bar."/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="displayHelp"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="displayHelp"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property EnableHistory -->
						<memberField type="System.Boolean" name="enableHistory"/>
						<memberProperty type="System.Boolean" name="EnableHistory">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="false"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="Enables interactive history of most recent used data objects."/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="enableHistory"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="enableHistory"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property EnablePermalinks -->
						<memberField type="System.Boolean" name="enablePermalinks"/>
						<memberProperty type="System.Boolean" name="EnablePermalinks">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="false"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="Enables bookmarking of selected master records by end users."/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="enablePermalinks"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="enablePermalinks"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property IdleUserTimeout -->
						<memberField type="System.Int32" name="idleUserTimeout"/>
						<memberProperty type="System.Int32" name="IdleUserTimeout">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="0"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="The idle user detection timeout in minutes."/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="idleUserTimeout"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="idleUserTimeout"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- constructor MembershipManager() -->
						<constructor>
							<attributes public="true"/>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="displayLogin"/>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="displaySignUp"/>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="displayPasswordRecovery"/>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="displayRememberMe"/>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="displayMyAccount"/>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="displayHelp"/>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="displayLogin"/>
									<primitiveExpression value="true"/>
								</assignStatement>
							</statements>
						</constructor>
						<!-- method CreateChildControls() -->
						<memberMethod name="CreateChildControls">
							<attributes override="true" family="true"/>
							<statements>
								<methodInvokeExpression methodName="CreateChildControls">
									<target>
										<baseReferenceExpression/>
									</target>
								</methodInvokeExpression>
								<variableDeclarationStatement type="HtmlGenericControl" name="div">
									<init>
										<objectCreateExpression type="HtmlGenericControl">
											<parameters>
												<primitiveExpression value="div"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="ID">
										<variableReferenceExpression name="div"/>
									</propertyReferenceExpression>
									<primitiveExpression value="d"/>
								</assignStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Style">
											<variableReferenceExpression name="div"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<propertyReferenceExpression name="Display">
											<typeReferenceExpression type="HtmlTextWriterStyle"/>
										</propertyReferenceExpression>
										<primitiveExpression value="none"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls"/>
									</target>
									<parameters>
										<variableReferenceExpression name="div"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="MembershipBarExtender" name="bar">
									<init>
										<objectCreateExpression type="MembershipBarExtender"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="ID">
										<variableReferenceExpression name="bar"/>
									</propertyReferenceExpression>
									<primitiveExpression value="b"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="TargetControlID">
										<variableReferenceExpression name="bar"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="ID">
										<variableReferenceExpression name="div"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="ServicePath">
										<variableReferenceExpression name="bar"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="ServicePath"/>
								</assignStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Properties">
											<variableReferenceExpression name="bar"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="DisplaySignUp"/>
										<propertyReferenceExpression name="DisplaySignUp"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Properties">
											<variableReferenceExpression name="bar"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="DisplayLogin"/>
										<propertyReferenceExpression name="DisplayLogin"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Properties">
											<variableReferenceExpression name="bar"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="DisplayRememberMe"/>
										<propertyReferenceExpression name="DisplayRememberMe"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Properties">
											<variableReferenceExpression name="bar"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="DisplayPasswordRecovery"/>
										<propertyReferenceExpression name="DisplayPasswordRecovery"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Properties">
											<variableReferenceExpression name="bar"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="RememberMeSet"/>
										<propertyReferenceExpression name="RememberMeSet"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Properties">
											<variableReferenceExpression name="bar"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="DisplayMyAccount"/>
										<propertyReferenceExpression name="DisplayMyAccount"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Properties">
											<variableReferenceExpression name="bar"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="DisplayHelp"/>
										<propertyReferenceExpression name="DisplayHelp"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Properties">
											<variableReferenceExpression name="bar"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="EnablePermalinks"/>
										<propertyReferenceExpression name="EnablePermalinks"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Properties">
											<variableReferenceExpression name="bar"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="EnableHistory"/>
										<propertyReferenceExpression name="EnableHistory"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Properties">
											<variableReferenceExpression name="bar"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="User"/>
										<propertyReferenceExpression name="Name">
											<propertyReferenceExpression name="Identity">
												<propertyReferenceExpression name="User">
													<propertyReferenceExpression name="Page"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Properties">
											<variableReferenceExpression name="bar"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="Welcome"/>
										<fieldReferenceExpression name="welcome"/>
									</parameters>
								</methodInvokeExpression>
								<xsl:if test="$IsUnlimited='true'">
									<variableDeclarationStatement type="StringBuilder" name="sb">
										<init>
											<objectCreateExpression type="StringBuilder"/>
										</init>
									</variableDeclarationStatement>
									<foreachStatement>
										<variable type="System.String" name="c"/>
										<target>
											<propertyReferenceExpression name="SupportedCultures">
												<typeReferenceExpression type="CultureManager"/>
											</propertyReferenceExpression>
										</target>
										<statements>
											<variableDeclarationStatement type="CultureInfo" name="ci">
												<init>
													<objectCreateExpression type="CultureInfo">
														<parameters>
															<arrayIndexerExpression>
																<target>
																	<methodInvokeExpression methodName="Split">
																		<target>
																			<variableReferenceExpression name="c"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="," convertTo="Char"/>
																		</parameters>
																	</methodInvokeExpression>
																</target>
																<indices>
																	<primitiveExpression value="1"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</objectCreateExpression>
												</init>
											</variableDeclarationStatement>
											<methodInvokeExpression methodName="AppendFormat">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
												<parameters>
													<primitiveExpression value="{{0}}|{{1}}|{{2}};"/>
													<variableReferenceExpression name="c"/>
													<propertyReferenceExpression name="NativeName">
														<variableReferenceExpression name="ci"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="Equals">
														<target>
															<variableReferenceExpression name="ci"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="CurrentUICulture">
																<propertyReferenceExpression name="CurrentThread">
																	<typeReferenceExpression type="System.Threading.Thread"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</foreachStatement>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Properties">
												<variableReferenceExpression name="bar"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<primitiveExpression value="Cultures"/>
											<methodInvokeExpression methodName="ToString">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</xsl:if>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="IdleUserTimeout"/>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Properties">
													<variableReferenceExpression name="bar"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<primitiveExpression value="IdleUserTimeout"/>
												<binaryOperatorExpression operator="Multiply">
													<propertyReferenceExpression name="IdleUserTimeout"/>
													<primitiveExpression value="60000"/>
												</binaryOperatorExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Controls"/>
									</target>
									<parameters>
										<variableReferenceExpression name="bar"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
