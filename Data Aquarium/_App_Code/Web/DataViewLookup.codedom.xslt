<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="/">
		<compileUnit namespace="{a:project/a:namespace}.Web">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.Configuration"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.UI.HtmlControls"/>
				<namespaceImport name="System.Web.UI.WebControls"/>
				<namespaceImport name="System.Web.UI.WebControls.WebParts"/>
				<namespaceImport name="{a:project/a:namespace}.Data"/>
			</imports>
			<types>
				<!-- class DataControllerService -->
				<typeDeclaration name="DataViewLookup">
					<customAttributes>
						<customAttribute name="DefaultProperty">
							<arguments>
								<primitiveExpression value="SelectedValue"/>
							</arguments>
						</customAttribute>
						<customAttribute name="ControlValueProperty">
							<arguments>
								<primitiveExpression value="SelectedValue"/>
							</arguments>
						</customAttribute>
						<customAttribute name="DefaultEvent">
							<arguments>
								<primitiveExpression value="SelectedValueChanged"/>
							</arguments>
						</customAttribute>
					</customAttributes>
					<baseTypes>
						<typeReference type="System.Web.UI.Control"/>
						<typeReference type="INamingContainer"/>
					</baseTypes>
					<members>
						<!-- property AutoPostBack -->
						<memberField type="System.Boolean" name="autoPostBack"/>
						<memberProperty type="System.Boolean" name="AutoPostBack">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Category">
									<arguments>
										<primitiveExpression value="Behavior"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="false"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="autoPostBack"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="autoPostBack"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property AllowCreateItems -->
						<memberField type="System.Boolean" name="allowCreateItems">
							<init>
								<primitiveExpression value="true"/>
							</init>
						</memberField>
						<memberProperty type="System.Boolean" name="AllowCreateItems">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<customAttribute name="System.ComponentModel.Category">
										<arguments>
											<primitiveExpression value="Behavior"/>
										</arguments>
									</customAttribute>
									<arguments>
										<primitiveExpression value="true"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="allowCreateItems"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="allowCreateItems"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property SelectedValue -->
						<memberProperty type="System.String" name="SelectedValue">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Browsable">
									<arguments>
										<primitiveExpression value="false"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<variableDeclarationStatement type="System.String" name="v">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="ViewState"/>
												</target>
												<indices>
													<primitiveExpression value="SelectedValue"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="v"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="v"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="v"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="ViewState"/>
										</target>
										<indices>
											<primitiveExpression value="SelectedValue"/>
										</indices>
									</arrayIndexerExpression>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataController -->
						<memberField type="System.String" name="dataController"/>
						<memberProperty type="System.String" name="DataController">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Category">
									<arguments>
										<primitiveExpression value="Data"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="dataController"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="dataController"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataView -->
						<memberField type="System.String" name="dataView"/>
						<memberProperty type="System.String" name="DataView">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Category">
									<arguments>
										<primitiveExpression value="Data"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="dataView"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="dataView"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataValueField -->
						<memberField type="System.String" name="dataValueField"/>
						<memberProperty type="System.String" name="DataValueField">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Category">
									<arguments>
										<primitiveExpression value="Data"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="dataValueField"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="dataValueField"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataTextField -->
						<memberField type="System.String" name="dataTextField"/>
						<memberProperty type="System.String" name="DataTextField">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Category">
									<arguments>
										<primitiveExpression value="Data"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="dataTextField"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="dataTextField"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property LookupText -->
						<memberProperty type="System.String" name="LookupText">
							<attributes family="true" final="true"/>
							<getStatements>
								<variableDeclarationStatement type="System.String" name="text">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="ViewState"/>
												</target>
												<indices>
													<primitiveExpression value="LookupText"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<methodInvokeExpression methodName="IsNullOrEmpty">
												<target>
													<typeReferenceExpression type="String"/>
												</target>
												<parameters>
													<variableReferenceExpression name="text"/>
												</parameters>
											</methodInvokeExpression>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="IsNullOrEmpty">
													<target>
														<typeReferenceExpression type="String"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="SelectedValue"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="text"/>
											<methodInvokeExpression methodName="LookupText">
												<target>
													<typeReferenceExpression type="Controller"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="DataController"/>
													<methodInvokeExpression methodName="Format">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<primitiveExpression value="{{0}}:={{1}}"/>
															<propertyReferenceExpression name="DataValueField"/>
															<propertyReferenceExpression name="SelectedValue"/>
														</parameters>
													</methodInvokeExpression>
													<propertyReferenceExpression name="DataTextField"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="ViewState"/>
												</target>
												<indices>
													<primitiveExpression value="LookupText"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="text"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="IsNullOrEmpty">
											<target>
												<typeReferenceExpression type="String"/>
											</target>
											<parameters>
												<variableReferenceExpression name="text"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="text"/>
											<primitiveExpression value="(select)"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="text"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="ViewState"/>
										</target>
										<indices>
											<primitiveExpression value="LookupText"/>
										</indices>
									</arrayIndexerExpression>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property Enabled -->
						<memberProperty type="System.Boolean" name="Enabled">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Category">
									<arguments>
										<primitiveExpression value="Behavior"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="true"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<variableDeclarationStatement type="System.Object" name="v">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="ViewState"/>
											</target>
											<indices>
												<primitiveExpression value="Enabled"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="v"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<castExpression targetType="System.Boolean">
										<variableReferenceExpression name="v"/>
									</castExpression>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="ViewState"/>
										</target>
										<indices>
											<primitiveExpression value="Enabled"/>
										</indices>
									</arrayIndexerExpression>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property TabIndex -->
						<memberProperty type="System.Int32" name="TabIndex">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Category">
									<arguments>
										<primitiveExpression value="Accessibility"/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<primitiveExpression value="0"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<variableDeclarationStatement type="System.Object" name="v">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="ViewState"/>
											</target>
											<indices>
												<primitiveExpression value="TabIndex"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="v"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="0"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<castExpression targetType="System.Int32">
										<variableReferenceExpression name="v"/>
									</castExpression>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="ViewState"/>
										</target>
										<indices>
											<primitiveExpression value="TabIndex"/>
										</indices>
									</arrayIndexerExpression>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- field span -->
						<memberField type="HtmlGenericControl" name="span"/>
						<!-- field extender -->
						<memberField type="DataViewExtender" name="extender"/>
						<!-- constructor DataViewLookup() -->
						<constructor>
							<attributes public="true"/>
						</constructor>
						<!-- event SelectedValueChanged -->
						<memberEvent type="EventHandler" name="SelectedValueChanged">
							<typeArguments>
								<typeReference type="EventArgs"/>
							</typeArguments>
							<attributes public="true"/>
						</memberEvent>
						<!-- method OnSelectedValueChanged(EventArgs)-->
						<memberMethod name="OnSelectedValueChanged">
							<attributes family="true"/>
							<parameters>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<eventReferenceExpression name="SelectedValueChanged"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<delegateInvokeExpression>
											<target>
												<eventReferenceExpression name="SelectedValueChanged"/>
											</target>
											<parameters>
												<thisReferenceExpression/>
												<argumentReferenceExpression name="e"/>
											</parameters>
										</delegateInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method OnInit(EventArgs) -->
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
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="DesignMode"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="span"/>
											<objectCreateExpression type="HtmlGenericControl">
												<parameters>
													<primitiveExpression value="span"/>
												</parameters>
											</objectCreateExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="ID">
												<fieldReferenceExpression name="span"/>
											</propertyReferenceExpression>
											<primitiveExpression value="s"/>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Controls"/>
											</target>
											<parameters>
												<fieldReferenceExpression name="span"/>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<fieldReferenceExpression name="extender"/>
											<objectCreateExpression type="DataViewExtender"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="ID">
												<fieldReferenceExpression name="extender"/>
											</propertyReferenceExpression>
											<primitiveExpression value="e"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="TargetControlID">
												<fieldReferenceExpression name="extender"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="ID">
												<fieldReferenceExpression name="span"/>
											</propertyReferenceExpression>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Controls"/>
											</target>
											<parameters>
												<fieldReferenceExpression name="extender"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method OnLoad(EventArgs) -->
						<memberMethod name="OnLoad">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
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
										<propertyReferenceExpression name="IsPostBack">
											<propertyReferenceExpression name="Page"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String" name="valueKey">
											<init>
												<binaryOperatorExpression operator="Add">
													<propertyReferenceExpression name="ClientID">
														<fieldReferenceExpression name="extender"/>
													</propertyReferenceExpression>
													<primitiveExpression value="_Item0"/>
												</binaryOperatorExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Contains">
													<target>
														<propertyReferenceExpression name="AllKeys">
															<propertyReferenceExpression name="Form">
																<propertyReferenceExpression name="Request">
																	<propertyReferenceExpression name="Page"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="valueKey"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="SelectedValue"/>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Form">
																<propertyReferenceExpression name="Request">
																	<propertyReferenceExpression name="Page"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</target>
														<indices>
															<variableReferenceExpression name="valueKey"/>
														</indices>
													</arrayIndexerExpression>
												</assignStatement>
												<assignStatement>
													<propertyReferenceExpression name="LookupText"/>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Form">
																<propertyReferenceExpression name="Request">
																	<propertyReferenceExpression name="Page"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</target>
														<indices>
															<binaryOperatorExpression operator="Add">
																<propertyReferenceExpression name="ClientID">
																	<fieldReferenceExpression name="extender"/>
																</propertyReferenceExpression>
																<primitiveExpression value="_Text0"/>
															</binaryOperatorExpression>
														</indices>
													</arrayIndexerExpression>
												</assignStatement>
												<methodInvokeExpression methodName="OnSelectedValueChanged">
													<parameters>
														<propertyReferenceExpression name="Empty">
															<typeReferenceExpression type="EventArgs"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method OnPreRender(EventArgs) -->
						<memberMethod name="OnPreRender">
							<attributes family="true" override="true"/>
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
								<assignStatement>
									<propertyReferenceExpression  name="InnerHtml">
										<fieldReferenceExpression name="span"/>
									</propertyReferenceExpression>
									<methodInvokeExpression methodName="Format">
										<target>
											<typeReferenceExpression type="String"/>
										</target>
										<parameters>
											<primitiveExpression>
												<xsl:attribute name="value">
													<xsl:text><![CDATA[<table cellpadding="0" cellspacing="0" class="DataViewLookup"><tr><td>{0}</td></tr></table>]]></xsl:text>
												</xsl:attribute>
											</primitiveExpression>
											<methodInvokeExpression methodName="HtmlEncode">
												<target>
													<typeReferenceExpression type="HttpUtility"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="LookupText"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Controller">
										<fieldReferenceExpression name="extender"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="DataController"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="View">
										<fieldReferenceExpression name="extender"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="DataView"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="LookupValue">
										<fieldReferenceExpression name="extender"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="SelectedValue"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="LookupText">
										<fieldReferenceExpression name="extender"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="LookupText"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="AllowCreateLookupItems">
										<fieldReferenceExpression name="extender"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="AllowCreateItems"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Enabled">
										<fieldReferenceExpression name="extender"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="Enabled"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="TabIndex">
										<fieldReferenceExpression name="extender"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="TabIndex"/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="AutoPostBack"/>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="LookupPostBackExpression">
												<fieldReferenceExpression name="extender"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="GetPostBackEventReference">
												<target>
													<propertyReferenceExpression name="ClientScript">
														<propertyReferenceExpression  name="Page"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<thisReferenceExpression/>
													<primitiveExpression value="null"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method Render(HtmlTextWriter) -->
						<memberMethod name="Render">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="HtmlTextWriter" name="writer"/>
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
										<methodInvokeExpression methodName="RenderBeginTag">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Span">
													<typeReferenceExpression type="HtmlTextWriterTag"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Write">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="DataViewLookup ("/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Write">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="DataValueField"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Write">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="=>"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Write">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="DataController"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="IsNullOrEmpty">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<primitiveExpression value="DataView"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Write">
													<target>
														<argumentReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value=", "/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="DataView"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="Write">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value=")"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="RenderEndTag">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="Render">
											<target>
												<baseReferenceExpression/>
											</target>
											<parameters>
												<argumentReferenceExpression name="writer"/>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
								<comment>add a hidden field to support UpdatePanel with partial rendering</comment>
								<methodInvokeExpression methodName="AddAttribute">
									<target>
										<argumentReferenceExpression name="writer"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="Type">
											<typeReferenceExpression type="HtmlTextWriterAttribute"/>
										</propertyReferenceExpression>
										<primitiveExpression value="hidden"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="AddAttribute">
									<target>
										<argumentReferenceExpression name="writer"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="Id">
											<typeReferenceExpression type="HtmlTextWriterAttribute"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="ClientID"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="RenderBeginTag">
									<target>
										<argumentReferenceExpression name="writer"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="Input">
											<typeReferenceExpression type="HtmlTextWriterTag"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="RenderEndTag">
									<target>
										<argumentReferenceExpression name="writer"/>
									</target>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method Clear()-->
						<memberMethod name="Clear">
							<attributes public="true" final="true"/>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="SelectedValue"/>
									<primitiveExpression value="null"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="LookupText"/>
									<primitiveExpression value="null"/>
								</assignStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
