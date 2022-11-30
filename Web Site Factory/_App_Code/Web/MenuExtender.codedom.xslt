<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsClassLibrary" select="'false'"/>
	<xsl:param name="ScriptOnly" select="'false'"/>
	<xsl:param name="Namespace" select="a:project/a:namespace"/>
	<xsl:param name="Theme" select="'Aquarium'"/>
	<xsl:param name="ProjectId"/>
	<xsl:param name="Mobile" />
	<xsl:variable name="MembershipEnabled" select="a:project/a:membership/@enabled='true'"/>
	<xsl:variable name="PageImplementation" select="a:project/@pageImplementation"/>

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Web">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Collections"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.UI.HtmlControls"/>
				<namespaceImport name="System.Web.UI.WebControls"/>
				<xsl:if test="$ScriptOnly='false'">
					<namespaceImport name="AjaxControlToolkit"/>
				</xsl:if>
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Services"/>
			</imports>
			<types>
				<!-- enum MenuHoverStyle -->
				<typeDeclaration name="MenuHoverStyle" isEnum="true">
					<members>
						<memberField name="Auto">
							<attributes public="true"/>
							<init>
								<primitiveExpression value="1"/>
							</init>
						</memberField>
						<memberField name="Click">
							<attributes public="true"/>
							<init>
								<primitiveExpression value="1"/>
							</init>
						</memberField>
						<memberField name="ClickAndStay">
							<attributes public="true"/>
							<init>
								<primitiveExpression value="1"/>
							</init>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- enum MenuPresentationStyle -->
				<typeDeclaration name="MenuPresentationStyle" isEnum="true">
					<members>
						<memberField name="MultiLevel">
							<attributes public="true"/>
						</memberField>
						<memberField name="TwoLevel">
							<attributes public="true"/>
						</memberField>
						<memberField name="NavigationButton">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- enum MenuOrientation -->
				<typeDeclaration name="MenuOrientation" isEnum="true">
					<members>
						<memberField name="Horizontal">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- enum PopupPosition -->
				<typeDeclaration name="MenuPopupPosition" isEnum="true">
					<members>
						<memberField name="Left">
							<attributes public="true"/>
						</memberField>
						<memberField name="Right">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- enum ItemDescriptionStyle -->
				<typeDeclaration name="MenuItemDescriptionStyle" isEnum="true">
					<members>
						<memberField name="None">
							<attributes public="true"/>
						</memberField>
						<memberField name="Inline">
							<attributes public="true"/>
						</memberField>
						<memberField name="ToolTip">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- class MembershipBarExtender -->
				<typeDeclaration name="MenuExtender">
					<customAttributes>
						<customAttribute name="TargetControlType">
							<arguments>
								<typeofExpression type="Panel"/>
							</arguments>
						</customAttribute>
						<customAttribute name="TargetControlType">
							<arguments>
								<typeofExpression type="HtmlContainerControl"/>
							</arguments>
						</customAttribute>
						<customAttribute name="DefaultProperty">
							<arguments>
								<primitiveExpression value="TargetControlID"/>
							</arguments>
						</customAttribute>
						<!--<xsl:if test="$IsClassLibrary='true'">
              <customAttribute name="ClientCssResource">
                <arguments>
                  -->
						<!--<primitiveExpression value="{$Namespace}.Theme.Membership.css"/>-->
						<!--
                  <primitiveExpression value="{$Namespace}.Theme.{$Theme}.css"/>
                </arguments>
              </customAttribute>
            </xsl:if>-->
					</customAttributes>
					<baseTypes>
						<typeReference type="System.Web.UI.WebControls.HierarchicalDataBoundControl"/>
						<typeReference type="IExtenderControl"/>
					</baseTypes>
					<members>
						<memberField type="System.String" name="items"/>
						<memberField type="ScriptManager" name="sm"/>
						<!-- TargetControlID -->
						<memberField type="System.String" name="targetControlID"/>
						<memberProperty type="System.String" name="TargetControlID">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="IDReferenceProperty"/>
								<customAttribute name="Category">
									<arguments>
										<primitiveExpression value="Behavior"/>
									</arguments>
								</customAttribute>
								<customAttribute name="DefaultValue">
									<arguments>
										<primitiveExpression value=""/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="targetControlID"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="targetControlID"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property Visible -->
						<memberField type="System.Boolean" name="visible"/>
						<memberProperty type="System.Boolean" name="Visible">
							<attributes public="true" override="true"/>
							<customAttributes>
								<customAttribute name="EditorBrowsable">
									<arguments>
										<propertyReferenceExpression name="Never">
											<typeReferenceExpression type="EditorBrowsableState"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
								<customAttribute name="DesignerSerializationVisibility">
									<arguments>
										<propertyReferenceExpression name="Hidden">
											<typeReferenceExpression type="DesignerSerializationVisibility"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
								<customAttribute name="Browsable">
									<arguments>
										<primitiveExpression value="false"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="visible"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="visible"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property HoverStyle -->
						<memberField type="MenuHoverStyle" name="hoverStyle"/>
						<memberProperty type="MenuHoverStyle" name="HoverStyle">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="hoverStyle"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="hoverStyle"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property PopupPosition -->
						<memberField type="MenuPopupPosition" name="popupPosition"/>
						<memberProperty type="MenuPopupPosition" name="PopupPosition">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="popupPosition"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="popupPosition"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property ItemDescriptionStyle -->
						<memberField type="MenuItemDescriptionStyle" name="itemDescriptionStyle"/>
						<memberProperty type="MenuItemDescriptionStyle" name="ItemDescriptionStyle">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="itemDescriptionStyle"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="itemDescriptionStyle"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property ShowSiteActions -->
						<memberField type="System.Boolean" name="showSiteActions"/>
						<memberProperty type="System.Boolean" name="ShowSiteActions">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="The &quot;Site Actions&quot; menu is automatically displayed."/>
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
									<fieldReferenceExpression name="showSiteActions"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="showSiteActions"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property PresentationStyle -->
						<memberProperty type="MenuPresentationStyle" name="PresentationStyle">
							<attributes public="true" final="true"/>
							<customAttributes>
								<customAttribute name="System.ComponentModel.Description">
									<arguments>
										<primitiveExpression value="Specifies the menu presentation style."/>
									</arguments>
								</customAttribute>
								<customAttribute name="System.ComponentModel.DefaultValue">
									<arguments>
										<propertyReferenceExpression name="MultiLevel">
											<typeReferenceExpression type="MenuPresentationStyle"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
						</memberProperty>
						<!-- constructor -->
						<constructor>
							<attributes public="true"/>
							<baseConstructorArgs/>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="Visible">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="ItemDescriptionStyle"/>
									<propertyReferenceExpression name="ToolTip">
										<typeReferenceExpression type="MenuItemDescriptionStyle"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="HoverStyle"/>
									<propertyReferenceExpression name="Auto">
										<typeReferenceExpression type="MenuHoverStyle"/>
									</propertyReferenceExpression>
								</assignStatement>
							</statements>
						</constructor>
						<!-- method PerformDataBinding() -->
						<memberMethod name="PerformDataBinding">
							<attributes family="true" override="true"/>
							<statements>
								<methodInvokeExpression methodName="PerformDataBinding">
									<target>
										<baseReferenceExpression/>
									</target>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="Not">
												<propertyReferenceExpression name="IsBoundUsingDataSourceID"/>
											</unaryOperatorExpression>
											<binaryOperatorExpression operator="IdentityInequality">
												<propertyReferenceExpression name="DataSource"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="HierarchicalDataSourceView" name="view">
									<init>
										<methodInvokeExpression methodName="GetData">
											<parameters>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="IHierarchicalEnumerable" name="enumerable">
									<init>
										<methodInvokeExpression methodName="Select">
											<target>
												<variableReferenceExpression name="view"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<xsl:if test="$PageImplementation='html'">
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<propertyReferenceExpression name="IsSiteContentEnabled">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="IsSafeMode">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="SiteContentFileList" name="sitemaps">
												<init>
													<methodInvokeExpression methodName="ReadSiteContent">
														<target>
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="ApplicationServices"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="sys/sitemaps%"/>
															<primitiveExpression value="%"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="Count">
															<variableReferenceExpression name="sitemaps"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement type="System.Boolean" name="hasMain">
														<init>
															<primitiveExpression value="false"/>
														</init>
													</variableDeclarationStatement>
													<foreachStatement>
														<variable type="SiteContentFile" name="f"/>
														<target>
															<variableReferenceExpression name="sitemaps"/>
														</target>
														<statements>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="ValueEquality">
																		<propertyReferenceExpression name="PhysicalName">
																			<variableReferenceExpression name="f"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="main"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<variableReferenceExpression name="hasMain"/>
																		<primitiveExpression value="true"/>
																	</assignStatement>
																	<methodInvokeExpression methodName="Remove">
																		<target>
																			<variableReferenceExpression name="sitemaps"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="f"/>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="Insert">
																		<target>
																			<variableReferenceExpression name="sitemaps"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="0"/>
																			<variableReferenceExpression name="f"/>
																		</parameters>
																	</methodInvokeExpression>
																	<breakStatement/>
																</trueStatements>
															</conditionStatement>
														</statements>
													</foreachStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="BooleanAnd">
																<unaryOperatorExpression operator="Not">
																	<variableReferenceExpression name="hasMain"/>
																</unaryOperatorExpression>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="enumerable"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<variableDeclarationStatement type="StringBuilder" name="msb">
																<init>
																	<objectCreateExpression type="StringBuilder"/>
																</init>
															</variableDeclarationStatement>
															<methodInvokeExpression methodName="BuildMainMenu">
																<parameters>
																	<variableReferenceExpression name="enumerable"/>
																	<variableReferenceExpression name="msb"/>
																	<primitiveExpression value="1"/>
																</parameters>
															</methodInvokeExpression>
															<variableDeclarationStatement type="SiteContentFile" name="main">
																<init>
																	<objectCreateExpression type="SiteContentFile"/>
																</init>
															</variableDeclarationStatement>
															<assignStatement>
																<propertyReferenceExpression name="Text">
																	<variableReferenceExpression name="main"/>
																</propertyReferenceExpression>
																<methodInvokeExpression methodName="Replace">
																	<target>
																		<typeReferenceExpression type="Localizer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="Pages"/>
																		<methodInvokeExpression methodName="GetFileName">
																			<target>
																				<typeReferenceExpression type="Path"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="PhysicalPath">
																					<propertyReferenceExpression name="Request">
																						<propertyReferenceExpression name="Page"/>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="ToString">
																			<target>
																				<variableReferenceExpression name="msb"/>
																			</target>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
															<methodInvokeExpression methodName="Insert">
																<target>
																	<variableReferenceExpression name="sitemaps"/>
																</target>
																<parameters>
																	<primitiveExpression value="0"/>
																	<variableReferenceExpression name="main"/>
																</parameters>
															</methodInvokeExpression>
														</trueStatements>
													</conditionStatement>
													<variableDeclarationStatement type="System.String" name="text">
														<init>
															<primitiveExpression value="null"/>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="GreaterThan">
																<propertyReferenceExpression name="Count">
																	<variableReferenceExpression name="sitemaps"/>
																</propertyReferenceExpression>
																<primitiveExpression value="1"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<variableDeclarationStatement type="SiteMapBuilder" name="sm">
																<init>
																	<objectCreateExpression type="SiteMapBuilder"/>
																</init>
															</variableDeclarationStatement>
															<foreachStatement>
																<variable type="SiteContentFile" name="cf"/>
																<target>
																	<variableReferenceExpression name="sitemaps"/>
																</target>
																<statements>
																	<variableDeclarationStatement type="System.String" name="sitemapText">
																		<init>
																			<propertyReferenceExpression name="Text">
																				<variableReferenceExpression name="cf"/>
																			</propertyReferenceExpression>
																		</init>
																	</variableDeclarationStatement>
																	<conditionStatement>
																		<condition>
																			<unaryOperatorExpression operator="IsNotNullOrEmpty">
																				<variableReferenceExpression name="sitemapText"/>
																			</unaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<variableDeclarationStatement type="MatchCollection" name="coll">
																				<init>
																					<methodInvokeExpression methodName="Matches">
																						<target>
																							<propertyReferenceExpression name="MenuItemRegex"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="sitemapText"/>
																						</parameters>
																					</methodInvokeExpression>
																				</init>
																			</variableDeclarationStatement>
																			<foreachStatement>
																				<variable type="Match" name="m" var="false"/>
																				<target>
																					<variableReferenceExpression name="coll"/>
																				</target>
																				<statements>
																					<methodInvokeExpression methodName="Insert">
																						<target>
																							<variableReferenceExpression name="sm"/>
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
																										<primitiveExpression value="Title"/>
																									</indices>
																								</arrayIndexerExpression>
																							</propertyReferenceExpression>
																							<propertyReferenceExpression name="Length">
																								<propertyReferenceExpression name="Value">
																									<arrayIndexerExpression>
																										<target>
																											<propertyReferenceExpression name="Groups">
																												<variableReferenceExpression name="m"/>
																											</propertyReferenceExpression>
																										</target>
																										<indices>
																											<primitiveExpression value="Depth"/>
																										</indices>
																									</arrayIndexerExpression>
																								</propertyReferenceExpression>
																							</propertyReferenceExpression>
																							<propertyReferenceExpression name="Value">
																								<arrayIndexerExpression>
																									<target>
																										<propertyReferenceExpression name="Groups">
																											<variableReferenceExpression name="m"/>
																										</propertyReferenceExpression>
																									</target>
																									<indices>
																										<primitiveExpression value="Text"/>
																									</indices>
																								</arrayIndexerExpression>
																							</propertyReferenceExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</statements>
																			</foreachStatement>
																		</trueStatements>
																	</conditionStatement>
																</statements>
															</foreachStatement>
															<assignStatement>
																<variableReferenceExpression name="text"/>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<variableReferenceExpression name="sm"/>
																	</target>
																</methodInvokeExpression>
															</assignStatement>
														</trueStatements>
														<falseStatements>
															<assignStatement>
																<variableReferenceExpression name="text"/>
																<propertyReferenceExpression name="Text">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="sitemaps"/>
																		</target>
																		<indices>
																			<primitiveExpression value="0"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</assignStatement>
														</falseStatements>
													</conditionStatement>
													<variableDeclarationStatement type="StringBuilder" name="sb">
														<init>
															<objectCreateExpression type="StringBuilder"/>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="text"/>
															</unaryOperatorExpression>
														</condition>
														<trueStatements>
															<variableDeclarationStatement type="System.Boolean" name="first">
																<init>
																	<primitiveExpression value="true"/>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement type="Match" name="m">
																<init>
																	<methodInvokeExpression methodName="Match">
																		<target>
																			<typeReferenceExpression type="MenuItemRegex"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="text"/>
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
																	<methodInvokeExpression methodName="BuildNode">
																		<parameters>
																			<directionExpression direction="Ref">
																				<variableReferenceExpression name="m"/>
																			</directionExpression>
																			<argumentReferenceExpression name="sb"/>
																			<variableReferenceExpression name="first"/>
																		</parameters>
																	</methodInvokeExpression>
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
																	</conditionStatement>
																</statements>
															</whileStatement>
															<assignStatement>
																<fieldReferenceExpression name="items"/>
																<methodInvokeExpression methodName="Replace">
																	<target>
																		<methodInvokeExpression methodName="Replace">
																			<target>
																				<typeReferenceExpression type="Regex"/>
																			</target>
																			<parameters>
																				<methodInvokeExpression methodName="ToString">
																					<target>
																						<variableReferenceExpression name="sb"/>
																					</target>
																				</methodInvokeExpression>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[(\{\}\,?)+]]></xsl:attribute>
																				</primitiveExpression>
																				<stringEmptyExpression/>
																			</parameters>
																		</methodInvokeExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="}},]"/>
																		<primitiveExpression value="}}]"/>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
															<methodReturnStatement/>
														</trueStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="enumerable"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="StringBuilder" name="sb">
											<init>
												<objectCreateExpression type="StringBuilder"/>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="RecursiveDataBindInternal">
											<parameters>
												<variableReferenceExpression name="enumerable"/>
												<variableReferenceExpression name="sb"/>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<fieldReferenceExpression name="items"/>
											<methodInvokeExpression methodName="ToString">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<xsl:if test="$PageImplementation='html'">
							<!-- method BuildMainMenu(IHierarchicalEnumerable, StringBuilder, int) -->
							<memberMethod name="BuildMainMenu">
								<attributes private="true"/>
								<parameters>
									<parameter type="IHierarchicalEnumerable" name="enumerable"/>
									<parameter type="StringBuilder" name="sb"/>
									<parameter type="System.Int32" name="depth"/>
								</parameters>
								<statements>
									<foreachStatement>
										<variable type="System.Object" name="item"/>
										<target>
											<argumentReferenceExpression name="enumerable"/>
										</target>
										<statements>
											<variableDeclarationStatement type="IHierarchyData" name="data">
												<init>
													<methodInvokeExpression methodName="GetHierarchyData">
														<target>
															<argumentReferenceExpression name="enumerable"/>
														</target>
														<parameters>
															<variableReferenceExpression name="item"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="data"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement type="PropertyDescriptorCollection" name="props">
														<init>
															<methodInvokeExpression methodName="GetProperties">
																<target>
																	<typeReferenceExpression type="TypeDescriptor"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="data"/>
																</parameters>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="GreaterThan">
																<propertyReferenceExpression name="Count">
																	<variableReferenceExpression name="props"/>
																</propertyReferenceExpression>
																<primitiveExpression value="0"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<variableDeclarationStatement type="System.String" name="title">
																<init>
																	<castExpression targetType="System.String">
																		<methodInvokeExpression methodName="GetValue">
																			<target>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="props"/>
																					</target>
																					<indices>
																						<primitiveExpression value="Title"/>
																					</indices>
																				</arrayIndexerExpression>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="data"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement type="System.String" name="description">
																<init>
																	<castExpression targetType="System.String">
																		<methodInvokeExpression methodName="GetValue">
																			<target>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="props"/>
																					</target>
																					<indices>
																						<primitiveExpression value="Description"/>
																					</indices>
																				</arrayIndexerExpression>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="data"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement type="System.String" name="url">
																<init>
																	<castExpression targetType="System.String">
																		<methodInvokeExpression methodName="GetValue">
																			<target>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="props"/>
																					</target>
																					<indices>
																						<primitiveExpression value="Url"/>
																					</indices>
																				</arrayIndexerExpression>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="data"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement type="System.String" name="cssClass">
																<init>
																	<primitiveExpression value="null"/>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement type="System.String" name="roles">
																<init>
																	<xsl:choose>
																		<xsl:when test="$MembershipEnabled='true' or /a:project/a:membership[@customSecurity='true' or @activeDirectory='true']">
																			<primitiveExpression value="*"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<primitiveExpression value="null"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement type="ArrayList" name="roleList">
																<init>
																	<castExpression targetType="ArrayList">
																		<methodInvokeExpression methodName="GetValue">
																			<target>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="props"/>
																					</target>
																					<indices>
																						<primitiveExpression value="Roles"/>
																					</indices>
																				</arrayIndexerExpression>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="data"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</init>
															</variableDeclarationStatement>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="GreaterThan">
																		<propertyReferenceExpression name="Count">
																			<variableReferenceExpression name="roleList"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="0"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<variableReferenceExpression name="roles"/>
																		<methodInvokeExpression methodName="Join">
																			<target>
																				<typeReferenceExpression type="String"/>
																			</target>
																			<parameters>
																				<primitiveExpression value=","/>
																				<castExpression targetType="System.String[]">
																					<methodInvokeExpression methodName="ToArray">
																						<target>
																							<variableReferenceExpression name="roleList"/>
																						</target>
																						<parameters>
																							<typeofExpression type="System.String"/>
																						</parameters>
																					</methodInvokeExpression>
																				</castExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																</trueStatements>
															</conditionStatement>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="IsTypeOf">
																		<variableReferenceExpression name="item"/>
																		<typeReferenceExpression type="SiteMapNode"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<variableReferenceExpression name="cssClass"/>
																		<arrayIndexerExpression>
																			<target>
																				<castExpression targetType="SiteMapNode">
																					<variableReferenceExpression name="item"/>
																				</castExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="cssClass"/>
																			</indices>
																		</arrayIndexerExpression>
																	</assignStatement>
																	<conditionStatement>
																		<condition>
																			<binaryOperatorExpression operator="ValueEquality">
																				<primitiveExpression value="true" convertTo="String"/>
																				<arrayIndexerExpression>
																					<target>
																						<castExpression targetType="SiteMapNode">
																							<variableReferenceExpression name="item"/>
																						</castExpression>
																					</target>
																					<indices>
																						<primitiveExpression value="public"/>
																					</indices>
																				</arrayIndexerExpression>
																			</binaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<assignStatement>
																				<variableReferenceExpression name="roles"/>
																				<primitiveExpression value="?"/>
																			</assignStatement>
																		</trueStatements>
																	</conditionStatement>
																</trueStatements>
															</conditionStatement>
															<methodInvokeExpression methodName="AppendFormat">
																<target>
																	<argumentReferenceExpression name="sb"/>
																</target>
																<parameters>
																	<primitiveExpression value="{{0}} {{1}}"/>
																	<objectCreateExpression type="String">
																		<parameters>
																			<primitiveExpression value="+" convertTo="Char"/>
																			<argumentReferenceExpression name="depth"/>
																		</parameters>
																	</objectCreateExpression>
																	<variableReferenceExpression name="title"/>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="AppendLine">
																<target>
																	<argumentReferenceExpression name="sb"/>
																</target>
															</methodInvokeExpression>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<variableReferenceExpression name="url"/>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<methodInvokeExpression methodName="AppendLine">
																		<target>
																			<argumentReferenceExpression name="sb"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="url"/>
																		</parameters>
																	</methodInvokeExpression>
																</trueStatements>
																<falseStatements>
																	<methodInvokeExpression methodName="AppendLine">
																		<target>
																			<argumentReferenceExpression name="sb"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="about:blank"/>
																		</parameters>
																	</methodInvokeExpression>
																</falseStatements>
															</conditionStatement>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<variableReferenceExpression name="description"/>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<methodInvokeExpression methodName="AppendFormat">
																		<target>
																			<argumentReferenceExpression name="sb"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="description: {{0}}"/>
																			<variableReferenceExpression name="description"/>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="AppendLine">
																		<target>
																			<argumentReferenceExpression name="sb"/>
																		</target>
																	</methodInvokeExpression>
																</trueStatements>
															</conditionStatement>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<variableReferenceExpression name="roles"/>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<methodInvokeExpression methodName="AppendFormat">
																		<target>
																			<argumentReferenceExpression name="sb"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="roles: {{0}}"/>
																			<variableReferenceExpression name="roles"/>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="AppendLine">
																		<target>
																			<argumentReferenceExpression name="sb"/>
																		</target>
																	</methodInvokeExpression>
																</trueStatements>
															</conditionStatement>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<variableReferenceExpression name="cssClass"/>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<methodInvokeExpression methodName="AppendFormat">
																		<target>
																			<argumentReferenceExpression name="sb"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="cssclass: {{0}}"/>
																			<variableReferenceExpression name="cssClass"/>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="AppendLine">
																		<target>
																			<argumentReferenceExpression name="sb"/>
																		</target>
																	</methodInvokeExpression>
																</trueStatements>
															</conditionStatement>
															<methodInvokeExpression methodName="AppendLine">
																<target>
																	<argumentReferenceExpression name="sb"/>
																</target>
															</methodInvokeExpression>
															<conditionStatement>
																<condition>
																	<propertyReferenceExpression name="HasChildren">
																		<variableReferenceExpression name="data"/>
																	</propertyReferenceExpression>
																</condition>
																<trueStatements>
																	<variableDeclarationStatement type="IHierarchicalEnumerable" name="childrenEnumerable">
																		<init>
																			<methodInvokeExpression methodName="GetChildren">
																				<target>
																					<variableReferenceExpression name="data"/>
																				</target>
																			</methodInvokeExpression>
																		</init>
																	</variableDeclarationStatement>
																	<conditionStatement>
																		<condition>
																			<binaryOperatorExpression operator="IdentityInequality">
																				<variableReferenceExpression name="childrenEnumerable"/>
																				<primitiveExpression value="null"/>
																			</binaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<methodInvokeExpression methodName="BuildMainMenu">
																				<parameters>
																					<variableReferenceExpression name="childrenEnumerable"/>
																					<argumentReferenceExpression name="sb"/>
																					<binaryOperatorExpression operator="Add">
																						<argumentReferenceExpression name="depth"/>
																						<primitiveExpression value="1"/>
																					</binaryOperatorExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</trueStatements>
																	</conditionStatement>
																</trueStatements>
															</conditionStatement>
														</trueStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
								</statements>
							</memberMethod>
							<!-- property MenuItemPropRegex -->
							<memberField type="Regex" name="MenuItemPropRegex">
								<attributes public="true" final="true"/>
								<init>
									<objectCreateExpression type="Regex">
										<parameters>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[\s*(?'Name'\w+)\s*(=|:)\s*(?'Value'.+?)\s*(\r?\n|$)]]></xsl:attribute>
											</primitiveExpression>
										</parameters>
									</objectCreateExpression>
								</init>
							</memberField>
							<!-- method BuildNode(ref Match, StringBuilder, bool) -->
							<memberMethod name="BuildNode">
								<attributes private="true"/>
								<parameters>
									<parameter type="Match" name="node" direction="Ref"/>
									<parameter type="StringBuilder" name="sb"/>
									<parameter type="System.Boolean" name="first"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<argumentReferenceExpression name="first"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Append">
												<target>
													<argumentReferenceExpression name="sb"/>
												</target>
												<parameters>
													<primitiveExpression value=","/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="SortedDictionary" name="propList">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="System.String"/>
										</typeArguments>
										<init>
											<objectCreateExpression type="SortedDictionary">
												<typeArguments>
													<typeReference type="System.String"/>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="Match" name="prop">
										<init>
											<methodInvokeExpression methodName="Match">
												<target>
													<propertyReferenceExpression name="MenuItemPropRegex"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Value">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<argumentReferenceExpression name="node"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="PropList"/>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<whileStatement>
										<test>
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="prop"/>
											</propertyReferenceExpression>
										</test>
										<statements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="propList"/>
													</target>
													<indices>
														<methodInvokeExpression methodName="Replace">
															<target>
																<methodInvokeExpression methodName="ToLower">
																	<target>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="prop"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="Name"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																	</target>
																</methodInvokeExpression>
															</target>
															<parameters>
																<primitiveExpression value="-"/>
																<stringEmptyExpression/>
															</parameters>
														</methodInvokeExpression>
													</indices>
												</arrayIndexerExpression>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<variableReferenceExpression name="prop"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="Value"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</assignStatement>
											<assignStatement>
												<variableReferenceExpression name="prop"/>
												<methodInvokeExpression methodName="NextMatch">
													<target>
														<variableReferenceExpression name="prop"/>
													</target>
												</methodInvokeExpression>
											</assignStatement>
										</statements>
									</whileStatement>
									<variableDeclarationStatement type="System.String" name="roles">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="TryGetValue">
										<target>
											<variableReferenceExpression name="propList"/>
										</target>
										<parameters>
											<primitiveExpression value="roles"/>
											<directionExpression direction="Out">
												<variableReferenceExpression name="roles"/>
											</directionExpression>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="System.String" name="users">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="TryGetValue">
										<target>
											<variableReferenceExpression name="propList"/>
										</target>
										<parameters>
											<primitiveExpression value="users"/>
											<directionExpression direction="Out">
												<variableReferenceExpression name="users"/>
											</directionExpression>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="System.String" name="roleExceptions">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="TryGetValue">
										<target>
											<variableReferenceExpression name="propList"/>
										</target>
										<parameters>
											<primitiveExpression value="roleexceptions"/>
											<directionExpression direction="Out">
												<variableReferenceExpression name="roleExceptions"/>
											</directionExpression>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="System.String" name="userExceptions">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="TryGetValue">
										<target>
											<variableReferenceExpression name="propList"/>
										</target>
										<parameters>
											<primitiveExpression value="userexceptions"/>
											<directionExpression direction="Out">
												<variableReferenceExpression name="userExceptions"/>
											</directionExpression>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="System.String" name="cssClass">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="TryGetValue">
										<target>
											<variableReferenceExpression name="propList"/>
										</target>
										<parameters>
											<primitiveExpression value="cssclass"/>
											<directionExpression direction="Out">
												<variableReferenceExpression name="cssClass"/>
											</directionExpression>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="System.String" name="url">
										<init>
											<methodInvokeExpression methodName="Trim">
												<target>
													<propertyReferenceExpression name="Value">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<variableReferenceExpression name="node"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Url"/>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
												</target>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="target">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="StartsWith">
												<target>
													<variableReferenceExpression name="url"/>
												</target>
												<parameters>
													<primitiveExpression value="_blank:"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="target"/>
												<primitiveExpression value="_blank:"/>
											</assignStatement>
											<assignStatement>
												<variableReferenceExpression name="url"/>
												<methodInvokeExpression methodName="Substring">
													<target>
														<variableReferenceExpression name="url"/>
													</target>
													<parameters>
														<primitiveExpression value="7"/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<variableReferenceExpression name="url"/>
										<methodInvokeExpression methodName="ResolveUrl">
											<parameters>
												<variableReferenceExpression name="url"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="target"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="url"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="target"/>
													<variableReferenceExpression name="url"/>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.Boolean" name="resourceAuthorized">
										<init>
											<primitiveExpression value="true"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="roles"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="UserIsAuthorizedToAccessResource">
															<target>
																<typeReferenceExpression type="ApplicationServices"/>
															</target>
															<parameters>
																<variableReferenceExpression name="url"/>
																<variableReferenceExpression name="roles"/>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="resourceAuthorized"/>
														<primitiveExpression value="false"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<variableReferenceExpression name="resourceAuthorized"/>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="users"/>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="ValueInequality">
															<variableReferenceExpression name="users"/>
															<primitiveExpression value="?"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="ValueEquality">
															<methodInvokeExpression methodName="IndexOf">
																<target>
																	<typeReferenceExpression type="Array"/>
																</target>
																<parameters>
																	<methodInvokeExpression methodName="Split">
																		<target>
																			<methodInvokeExpression methodName="ToLower">
																				<target>
																					<variableReferenceExpression name="users"/>
																				</target>
																			</methodInvokeExpression>
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
																	<methodInvokeExpression methodName="ToLower">
																		<target>
																			<propertyReferenceExpression name="Name">
																				<propertyReferenceExpression name="Identity">
																					<propertyReferenceExpression name="User">
																						<propertyReferenceExpression name="Page"/>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</target>
																	</methodInvokeExpression>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression value="-1"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="resourceAuthorized"/>
														<primitiveExpression value="false"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<unaryOperatorExpression operator="Not">
													<variableReferenceExpression name="resourceAuthorized"/>
												</unaryOperatorExpression>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="roleExceptions"/>
												</unaryOperatorExpression>
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
															<variableReferenceExpression name="roleExceptions"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="resourceAuthorized"/>
														<primitiveExpression value="true"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<unaryOperatorExpression operator="Not">
													<variableReferenceExpression name="resourceAuthorized"/>
												</unaryOperatorExpression>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="userExceptions"/>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueInequality">
														<methodInvokeExpression methodName="IndexOf">
															<target>
																<typeReferenceExpression type="Array"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="Split">
																	<target>
																		<methodInvokeExpression methodName="ToLower">
																			<target>
																				<variableReferenceExpression name="userExceptions"/>
																			</target>
																		</methodInvokeExpression>
																	</target>
																	<parameters>
																		<arrayCreateExpression >
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
																<methodInvokeExpression methodName="ToLower">
																	<target>
																		<propertyReferenceExpression name="Name">
																			<propertyReferenceExpression name="Identity">
																				<propertyReferenceExpression name="User">
																					<propertyReferenceExpression name="Page"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<primitiveExpression value="-1"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="resourceAuthorized"/>
														<primitiveExpression value="true"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="Append">
										<target>
											<argumentReferenceExpression name="sb"/>
										</target>
										<parameters>
											<primitiveExpression value="{{"/>
										</parameters>
									</methodInvokeExpression>
									<conditionStatement>
										<condition>
											<variableReferenceExpression name="resourceAuthorized"/>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="System.String" name="title">
												<init>
													<methodInvokeExpression methodName="Trim">
														<target>
															<propertyReferenceExpression name="Value">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Groups">
																			<argumentReferenceExpression name="node"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="Title"/>
																	</indices>
																</arrayIndexerExpression>
															</propertyReferenceExpression>
														</target>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="System.String" name="depth">
												<init>
													<propertyReferenceExpression name="Value">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<argumentReferenceExpression name="node"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Depth"/>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
												</init>
											</variableDeclarationStatement>
											<methodInvokeExpression methodName="AppendFormat">
												<target>
													<argumentReferenceExpression name="sb"/>
												</target>
												<parameters>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[title:"{0}"]]></xsl:attribute>
													</primitiveExpression>
													<methodInvokeExpression methodName="JavaScriptString">
														<target>
															<typeReferenceExpression type="BusinessRules"/>
														</target>
														<parameters>
															<variableReferenceExpression name="title"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueInequality">
														<variableReferenceExpression name="url"/>
														<primitiveExpression value="about:blank"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="AppendFormat">
														<target>
															<argumentReferenceExpression name="sb"/>
														</target>
														<parameters>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[,url:"{0}"]]></xsl:attribute>
															</primitiveExpression>
															<methodInvokeExpression methodName="JavaScriptString">
																<target>
																	<typeReferenceExpression type="BusinessRules"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="url"/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="RawUrl">
															<propertyReferenceExpression name="Request">
																<variableReferenceExpression name="Page"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
														<variableReferenceExpression name="url"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="Append">
														<target>
															<argumentReferenceExpression name="sb"/>
														</target>
														<parameters>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[,selected:true]]></xsl:attribute>
															</primitiveExpression>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<variableDeclarationStatement type="System.String" name="description">
												<init>
													<primitiveExpression value="null"/>
												</init>
											</variableDeclarationStatement>
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<variableReferenceExpression name="propList"/>
												</target>
												<parameters>
													<primitiveExpression value="description"/>
													<directionExpression direction="Out">
														<variableReferenceExpression name="description"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="description"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="AppendFormat">
														<target>
															<argumentReferenceExpression name="sb"/>
														</target>
														<parameters>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[,description:"{0}"]]></xsl:attribute>
															</primitiveExpression>
															<methodInvokeExpression methodName="JavaScriptString">
																<target>
																	<typeReferenceExpression type="BusinessRules"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="description"/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="cssClass"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="AppendFormat">
														<target>
															<argumentReferenceExpression name="sb"/>
														</target>
														<parameters>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[,cssClass:"{0}"]]></xsl:attribute>
															</primitiveExpression>
															<methodInvokeExpression methodName="JavaScriptString">
																<target>
																	<typeReferenceExpression type="BusinessRules"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="cssClass"/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<assignStatement>
												<argumentReferenceExpression name="node"/>
												<methodInvokeExpression methodName="NextMatch">
													<target>
														<argumentReferenceExpression name="node"/>
													</target>
												</methodInvokeExpression>
											</assignStatement>
											<conditionStatement>
												<condition>
													<propertyReferenceExpression name="Success">
														<argumentReferenceExpression name="node"/>
													</propertyReferenceExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement type="System.String" name="firstChildDepth">
														<init>
															<propertyReferenceExpression name="Value">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Groups">
																			<argumentReferenceExpression name="node"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="Depth"/>
																	</indices>
																</arrayIndexerExpression>
															</propertyReferenceExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="GreaterThan">
																<propertyReferenceExpression name="Length">
																	<variableReferenceExpression name="firstChildDepth"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Length">
																	<variableReferenceExpression name="depth"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<methodInvokeExpression methodName="Append">
																<target>
																	<argumentReferenceExpression name="sb"/>
																</target>
																<parameters>
																	<primitiveExpression>
																		<xsl:attribute name="value"><![CDATA[,children:[]]></xsl:attribute>
																	</primitiveExpression>
																</parameters>
															</methodInvokeExpression>
															<assignStatement>
																<variableReferenceExpression name="first"/>
																<primitiveExpression value="true"/>
															</assignStatement>
															<whileStatement>
																<test>
																	<propertyReferenceExpression name="Success">
																		<argumentReferenceExpression name="node"/>
																	</propertyReferenceExpression>
																</test>
																<statements>
																	<methodInvokeExpression methodName="BuildNode">
																		<parameters>
																			<directionExpression direction="Ref">
																				<argumentReferenceExpression name="node"/>
																			</directionExpression>
																			<argumentReferenceExpression name="sb"/>
																			<argumentReferenceExpression name="first"/>
																		</parameters>
																	</methodInvokeExpression>
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
																	</conditionStatement>
																	<conditionStatement>
																		<condition>
																			<propertyReferenceExpression name="Success">
																				<argumentReferenceExpression name="node"/>
																			</propertyReferenceExpression>
																		</condition>
																		<trueStatements>
																			<variableDeclarationStatement type="System.String" name="nextDepth">
																				<init>
																					<propertyReferenceExpression name="Value">
																						<arrayIndexerExpression>
																							<target>
																								<propertyReferenceExpression name="Groups">
																									<argumentReferenceExpression name="node"/>
																								</propertyReferenceExpression>
																							</target>
																							<indices>
																								<primitiveExpression value="Depth"/>
																							</indices>
																						</arrayIndexerExpression>
																					</propertyReferenceExpression>
																				</init>
																			</variableDeclarationStatement>
																			<conditionStatement>
																				<condition>
																					<binaryOperatorExpression operator="GreaterThan">
																						<propertyReferenceExpression name="Length">
																							<variableReferenceExpression name="firstChildDepth"/>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="Length">
																							<variableReferenceExpression name="nextDepth"/>
																						</propertyReferenceExpression>
																					</binaryOperatorExpression>
																				</condition>
																				<trueStatements>
																					<breakStatement/>
																				</trueStatements>
																			</conditionStatement>
																		</trueStatements>
																	</conditionStatement>
																</statements>
															</whileStatement>
															<methodInvokeExpression methodName="Append">
																<target>
																	<variableReferenceExpression name="sb"/>
																</target>
																<parameters>
																	<primitiveExpression value="]"/>
																</parameters>
															</methodInvokeExpression>
														</trueStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
										<falseStatements>
											<assignStatement>
												<argumentReferenceExpression name="node"/>
												<methodInvokeExpression methodName="NextMatch">
													<target>
														<argumentReferenceExpression name="node"/>
													</target>
												</methodInvokeExpression>
											</assignStatement>
										</falseStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="Append">
										<target>
											<argumentReferenceExpression name="sb"/>
										</target>
										<parameters>
											<primitiveExpression value="}}"/>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- property MenuItemRegex -->
							<memberField type="Regex" name="MenuItemRegex">
								<attributes public="true" static="true"/>
								<init>
									<objectCreateExpression type="Regex">
										<parameters>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[(?'Text'(?'Depth'(#|\+|\^)+)\s*(?'Title'.+?)\r?\n(?'Url'.*?)(\r?\n|$)(?'PropList'(\s*\w+\s*(:|=)\s*.+?(\r?\n|$))*))]]></xsl:attribute>
											</primitiveExpression>
										</parameters>
									</objectCreateExpression>
								</init>
							</memberField>
						</xsl:if>
						<!-- method RecursiveDataBindInternal(IHierarchicalEnumerable, sb) -->
						<memberMethod name="RecursiveDataBindInternal">
							<attributes private="true"/>
							<parameters>
								<parameter type="IHierarchicalEnumerable" name="enumerable"/>
								<parameter type="StringBuilder" name="sb"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Boolean" name="first">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Site">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement></methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<foreachStatement>
									<variable type="System.Object" name="item"/>
									<target>
										<argumentReferenceExpression name="enumerable"/>
									</target>
									<statements>
										<variableDeclarationStatement type="IHierarchyData" name="data">
											<init>
												<methodInvokeExpression methodName="GetHierarchyData">
													<target>
														<argumentReferenceExpression name="enumerable"/>
													</target>
													<parameters>
														<variableReferenceExpression name="item"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<primitiveExpression value="null"/>
													<variableReferenceExpression name="data"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="PropertyDescriptorCollection" name="props">
													<init>
														<methodInvokeExpression methodName="GetProperties">
															<target>
																<typeReferenceExpression type="TypeDescriptor"/>
															</target>
															<parameters>
																<variableReferenceExpression name="data"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="GreaterThan">
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="props"/>
															</propertyReferenceExpression>
															<primitiveExpression value="0"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.String" name="title">
															<init>
																<castExpression targetType="System.String">
																	<methodInvokeExpression  methodName="GetValue">
																		<target>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="props"/>
																				</target>
																				<indices>
																					<primitiveExpression value="Title"/>
																				</indices>
																			</arrayIndexerExpression>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="data"/>
																		</parameters>
																	</methodInvokeExpression>
																</castExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="description">
															<init>
																<castExpression targetType="System.String">
																	<methodInvokeExpression  methodName="GetValue">
																		<target>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="props"/>
																				</target>
																				<indices>
																					<primitiveExpression value="Description"/>
																				</indices>
																			</arrayIndexerExpression>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="data"/>
																		</parameters>
																	</methodInvokeExpression>
																</castExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="url">
															<init>
																<castExpression targetType="System.String">
																	<methodInvokeExpression  methodName="GetValue">
																		<target>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="props"/>
																				</target>
																				<indices>
																					<primitiveExpression value="Url"/>
																				</indices>
																			</arrayIndexerExpression>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="data"/>
																		</parameters>
																	</methodInvokeExpression>
																</castExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="cssClass">
															<init>
																<primitiveExpression value="null"/>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Boolean" name="isPublic">
															<init>
																<primitiveExpression value="false"/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IsTypeOf">
																	<variableReferenceExpression name="item"/>
																	<typeReferenceExpression type="SiteMapNode"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="cssClass"/>
																	<arrayIndexerExpression>
																		<target>
																			<castExpression targetType="SiteMapNode">
																				<variableReferenceExpression name="item"/>
																			</castExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="cssClass"/>
																		</indices>
																	</arrayIndexerExpression>
																</assignStatement>
																<assignStatement>
																	<variableReferenceExpression name="isPublic"/>
																	<binaryOperatorExpression operator="ValueEquality">
																		<primitiveExpression value="true" convertTo="String"/>
																		<castExpression targetType="System.String">
																			<arrayIndexerExpression>
																				<target>
																					<castExpression targetType="SiteMapNode">
																						<variableReferenceExpression name="item"/>
																					</castExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="public"/>
																				</indices>
																			</arrayIndexerExpression>
																		</castExpression>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<xsl:if test="$PageImplementation='html'">
															<variableDeclarationStatement type="System.String" name="roles">
																<init>
																	<stringEmptyExpression/>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement type="ArrayList" name="roleList">
																<init>
																	<castExpression targetType="ArrayList">
																		<methodInvokeExpression methodName="GetValue">
																			<target>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="props"/>
																					</target>
																					<indices>
																						<primitiveExpression value="Roles"/>
																					</indices>
																				</arrayIndexerExpression>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="data"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</init>
															</variableDeclarationStatement>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="GreaterThan">
																		<propertyReferenceExpression name="Count">
																			<variableReferenceExpression name="roleList"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="0"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<variableReferenceExpression name="roles"/>
																		<methodInvokeExpression methodName="Join">
																			<target>
																				<typeReferenceExpression type="String"/>
																			</target>
																			<parameters>
																				<primitiveExpression value=","/>
																				<castExpression targetType="System.String[]">
																					<methodInvokeExpression methodName="ToArray">
																						<target>
																							<variableReferenceExpression name="roleList"/>
																						</target>
																						<parameters>
																							<typeofExpression type="System.String"/>
																						</parameters>
																					</methodInvokeExpression>
																				</castExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																</trueStatements>
															</conditionStatement>
														</xsl:if>
														<variableDeclarationStatement type="System.Boolean" name="resourceAuthorized">
															<init>
																<xsl:choose>
																	<xsl:when test="$PageImplementation='html' and ($MembershipEnabled='true' or /a:project/a:membership[@customSecurity='true' or @activeDirectory='true'])">
																		<binaryOperatorExpression operator="BooleanOr">
																			<binaryOperatorExpression operator="BooleanOr">
																				<variableReferenceExpression name="isPublic"/>
																				<binaryOperatorExpression operator="ValueEquality">
																					<variableReferenceExpression name="roles"/>
																					<primitiveExpression value="*"/>
																				</binaryOperatorExpression>
																			</binaryOperatorExpression>
																			<methodInvokeExpression methodName="UserIsAuthorizedToAccessResource">
																				<target>
																					<typeReferenceExpression type="ApplicationServices"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="url"/>
																					<variableReferenceExpression name="roles"/>
																				</parameters>
																			</methodInvokeExpression>
																		</binaryOperatorExpression>
																	</xsl:when>
																	<xsl:otherwise>
																		<primitiveExpression value="true"/>
																	</xsl:otherwise>
																</xsl:choose>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<variableReferenceExpression name="resourceAuthorized"/>
															</condition>
															<trueStatements>
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
																		<methodInvokeExpression methodName="Append">
																			<target>
																				<argumentReferenceExpression name="sb"/>
																			</target>
																			<parameters>
																				<primitiveExpression value=","/>
																			</parameters>
																		</methodInvokeExpression>
																	</falseStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="AppendFormat">
																	<target>
																		<argumentReferenceExpression name="sb"/>
																	</target>
																	<parameters>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[{{title:"{0}",url:"{1}"]]></xsl:attribute>
																		</primitiveExpression>
																		<methodInvokeExpression methodName="JavaScriptString">
																			<target>
																				<typeReferenceExpression type="BusinessRules"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="title"/>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="JavaScriptString">
																			<target>
																				<typeReferenceExpression type="BusinessRules"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="url"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="description"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="AppendFormat">
																			<target>
																				<argumentReferenceExpression name="sb"/>
																			</target>
																			<parameters>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[,description:"{0}"]]></xsl:attribute>
																				</primitiveExpression>
																				<methodInvokeExpression methodName="JavaScriptString">
																					<target>
																						<typeReferenceExpression type="BusinessRules"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="description"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="url"/>
																			<propertyReferenceExpression name="RawUrl">
																				<propertyReferenceExpression name="Request">
																					<propertyReferenceExpression name="Page"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Append">
																			<target>
																				<argumentReferenceExpression name="sb"/>
																			</target>
																			<parameters>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[,selected:true]]></xsl:attribute>
																				</primitiveExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="cssClass"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="AppendFormat">
																			<target>
																				<argumentReferenceExpression name="sb"/>
																			</target>
																			<parameters>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[,cssClass:"{0}"]]></xsl:attribute>
																				</primitiveExpression>
																				<variableReferenceExpression name="cssClass"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<propertyReferenceExpression name="HasChildren">
																			<variableReferenceExpression name="data"/>
																		</propertyReferenceExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="IHierarchicalEnumerable" name="childrenEnumerable">
																			<init>
																				<methodInvokeExpression methodName="GetChildren">
																					<target>
																						<variableReferenceExpression name="data"/>
																					</target>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityInequality">
																					<primitiveExpression value="null"/>
																					<variableReferenceExpression name="childrenEnumerable"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Append">
																					<target>
																						<argumentReferenceExpression name="sb"/>
																					</target>
																					<parameters>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[,"children":[]]></xsl:attribute>
																						</primitiveExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="RecursiveDataBindInternal">
																					<parameters>
																						<variableReferenceExpression name="childrenEnumerable"/>
																						<argumentReferenceExpression name="sb"/>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="Append">
																					<target>
																						<argumentReferenceExpression name="sb"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="]"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="Append">
																	<target>
																		<argumentReferenceExpression name="sb"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="}}"/>
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
								<assignStatement>
									<fieldReferenceExpression name="sm"/>
									<methodInvokeExpression methodName="GetCurrent">
										<target>
											<typeReferenceExpression type="ScriptManager"/>
										</target>
										<parameters>
											<propertyReferenceExpression name="Page"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
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
								<methodInvokeExpression methodName="RegisterFrameworkSettings">
									<target>
										<typeReferenceExpression type="AquariumExtenderBase"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="Page"/>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsPostBack">
											<typeReferenceExpression type="Page"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="DataBind"/>
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
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<primitiveExpression value="null"/>
											<fieldReferenceExpression name="sm"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.String" name="script">
									<init>
										<methodInvokeExpression methodName="Format">
											<target>
												<typeReferenceExpression type="String"/>
											</target>
											<parameters>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[Web.Menu.Nodes.{0}=[{1}];]]></xsl:attribute>
												</primitiveExpression>
												<propertyReferenceExpression name="ClientID">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
												<fieldReferenceExpression name="items"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="Control" name="target">
									<init>
										<methodInvokeExpression methodName="FindControl">
											<target>
												<propertyReferenceExpression name="Form">
													<propertyReferenceExpression name="Page"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="TargetControlID"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<primitiveExpression value="null"/>
												<variableReferenceExpression name="target"/>
											</binaryOperatorExpression>
											<propertyReferenceExpression name="Visible">
												<variableReferenceExpression name="target"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="RegisterStartupScript">
											<target>
												<typeReferenceExpression type="ScriptManager"/>
											</target>
											<parameters>
												<thisReferenceExpression/>
												<typeofExpression type="MenuExtender"/>
												<primitiveExpression value="Nodes"/>
												<variableReferenceExpression name="script"/>
												<primitiveExpression value="true"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="RegisterExtenderControl">
									<typeArguments>
										<typeReference type="MenuExtender"/>
									</typeArguments>
									<target>
										<fieldReferenceExpression name="sm"/>
									</target>
									<parameters>
										<thisReferenceExpression/>
										<variableReferenceExpression name="target"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method Render(HtmlTextWriter)-->
						<memberMethod name="Render">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="HtmlTextWriter" name="writer"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Boolean" name="isTouchUI">
									<init>
										<xsl:choose>
											<xsl:when test="$Mobile='true'">
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
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="IdentityEquality">
												<primitiveExpression value="null"/>
												<fieldReferenceExpression name="sm"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="BooleanOr">
												<propertyReferenceExpression name="IsInAsyncPostBack">
													<fieldReferenceExpression name="sm"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="isTouchUI"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="RegisterScriptDescriptors">
									<target>
										<fieldReferenceExpression name="sm"/>
									</target>
									<parameters>
										<thisReferenceExpression/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method IExtenderControl.GetScriptDescriptors(Control)-->
						<memberMethod returnType="IEnumerable" name="GetScriptDescriptors" privateImplementationType="IExtenderControl">
							<typeArguments>
								<typeReference type="ScriptDescriptor"/>
							</typeArguments>
							<attributes/>
							<parameters>
								<parameter type="Control" name="targetControl"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ScriptBehaviorDescriptor" name="descriptor">
									<init>
										<objectCreateExpression type="ScriptBehaviorDescriptor">
											<parameters>
												<primitiveExpression value="Web.Menu"/>
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
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<propertyReferenceExpression name="HoverStyle"/>
											<propertyReferenceExpression name="Auto">
												<typeReferenceExpression type="MenuHoverStyle"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AddProperty">
											<target>
												<variableReferenceExpression name="descriptor"/>
											</target>
											<parameters>
												<primitiveExpression value="hoverStyle"/>
												<methodInvokeExpression methodName="ToInt32">
													<target>
														<typeReferenceExpression type="Convert"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="HoverStyle"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<propertyReferenceExpression name="PopupPosition"/>
											<propertyReferenceExpression name="Left">
												<typeReferenceExpression type="MenuPopupPosition"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AddProperty">
											<target>
												<variableReferenceExpression name="descriptor"/>
											</target>
											<parameters>
												<primitiveExpression value="popupPosition"/>
												<methodInvokeExpression methodName="ToInt32">
													<target>
														<typeReferenceExpression type="Convert"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="PopupPosition"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<propertyReferenceExpression name="ItemDescriptionStyle"/>
											<propertyReferenceExpression name="ToolTip">
												<typeReferenceExpression type="MenuItemDescriptionStyle"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AddProperty">
											<target>
												<variableReferenceExpression name="descriptor"/>
											</target>
											<parameters>
												<primitiveExpression value="itemDescriptionStyle"/>
												<methodInvokeExpression methodName="ToInt32">
													<target>
														<typeReferenceExpression type="Convert"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="ItemDescriptionStyle"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="ShowSiteActions"/>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AddProperty">
											<target>
												<variableReferenceExpression name="descriptor"/>
											</target>
											<parameters>
												<primitiveExpression value="showSiteActions"/>
												<primitiveExpression value="true" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<propertyReferenceExpression name="PresentationStyle"/>
											<propertyReferenceExpression name="MultiLevel">
												<typeReferenceExpression type="MenuPresentationStyle"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AddProperty">
											<target>
												<argumentReferenceExpression name="descriptor"/>
											</target>
											<parameters>
												<primitiveExpression value="presentationStyle"/>
												<convertExpression to="Int32">
													<propertyReferenceExpression name="PresentationStyle"/>
												</convertExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
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
						<!-- method IExtenderControl.GetScriptReferences() -->
						<memberMethod returnType="IEnumerable" name="GetScriptReferences" privateImplementationType="IExtenderControl">
							<typeArguments>
								<typeReference type="ScriptReference"/>
							</typeArguments>
							<attributes/>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="StandardScripts">
										<target>
											<typeReferenceExpression type="AquariumExtenderBase"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<xsl:if test="$PageImplementation='html'">
					<!-- class SiteMapBuilder -->
					<typeDeclaration name="SiteMapBuilder">
						<attributes public="true"/>
						<members>
							<!-- field root-->
							<memberField type="SiteMapBuilderNode" name="root">
								<init>
									<objectCreateExpression type="SiteMapBuilderNode">
										<parameters>
											<stringEmptyExpression/>
											<primitiveExpression value="0"/>
											<stringEmptyExpression/>
										</parameters>
									</objectCreateExpression>
								</init>
							</memberField>
							<!-- field last-->
							<memberField type="SiteMapBuilderNode" name="last"/>
							<!-- method Insert(string, int, string)-->
							<memberMethod name="Insert">
								<attributes public="true" final="true"/>
								<parameters>
									<parameter type="System.String" name="title"/>
									<parameter type="System.Int32" name="depth"/>
									<parameter type="System.String" name="text"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<fieldReferenceExpression name="last"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="last"/>
												<fieldReferenceExpression name="root"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="SiteMapBuilderNode" name="entry">
										<init>
											<objectCreateExpression type="SiteMapBuilderNode">
												<parameters>
													<argumentReferenceExpression name="title"/>
													<argumentReferenceExpression name="depth"/>
													<argumentReferenceExpression name="text"/>
												</parameters>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<fieldReferenceExpression name="last"/>
										<methodInvokeExpression methodName="AddNode">
											<target>
												<fieldReferenceExpression name="last"/>
											</target>
											<parameters>
												<variableReferenceExpression name="entry"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
								</statements>
							</memberMethod>
							<!-- method ToString-->
							<memberMethod returnType="System.String" name="ToString">
								<attributes override="true" public="true" />
								<statements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="ToString">
											<target>
												<fieldReferenceExpression name="root"/>
											</target>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- class SiteMapBuilderNode -->
					<typeDeclaration name="SiteMapBuilderNode">
						<attributes public="true" />
						<members>
							<!-- property Title-->
							<memberProperty type="System.String" name="Title">
								<attributes public="true" final="true"/>
							</memberProperty>
							<!-- property Depth-->
							<memberProperty type="System.Int32" name="Depth">
								<attributes public="true" final="true"/>
							</memberProperty>
							<!-- property Text-->
							<memberProperty type="System.String" name="Text">
								<attributes public="true" final="true"/>
							</memberProperty>
							<!-- property Parent-->
							<memberProperty type="SiteMapBuilderNode" name="Parent">
								<attributes public="true" final="true"/>
							</memberProperty>
							<!-- property Children-->
							<memberProperty type="List" name="Children">
								<typeArguments>
									<typeReference type="SiteMapBuilderNode"/>
								</typeArguments>
								<attributes public="true" final="true"/>
							</memberProperty>
							<!-- constructor-->
							<constructor>
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="title"/>
									<parameter type="System.Int32" name="depth"/>
									<parameter type="System.String" name="text"/>
								</parameters>
								<statements>
									<assignStatement>
										<propertyReferenceExpression name="Title">
											<thisReferenceExpression/>
										</propertyReferenceExpression>
										<argumentReferenceExpression name="title"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="Depth">
											<thisReferenceExpression/>
										</propertyReferenceExpression>
										<argumentReferenceExpression name="depth"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="Text">
											<thisReferenceExpression/>
										</propertyReferenceExpression>
										<argumentReferenceExpression name="text"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="Children"/>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="SiteMapBuilderNode"/>
											</typeArguments>
										</objectCreateExpression>
									</assignStatement>
								</statements>
							</constructor>
							<!-- method AddNode(SiteMapBuilderNode)-->
							<memberMethod returnType="SiteMapBuilderNode" name="AddNode">
								<attributes public="true" final="true"/>
								<parameters>
									<parameter type="SiteMapBuilderNode" name="entry"/>
								</parameters>
								<statements>
									<comment>go up</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="LessThanOrEqual">
												<propertyReferenceExpression name="Depth">
													<argumentReferenceExpression name="entry"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="Depth"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<methodInvokeExpression methodName="AddNode">
													<target>
														<propertyReferenceExpression name="Parent"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="entry"/>
													</parameters>
												</methodInvokeExpression>
											</methodReturnStatement>
										</trueStatements>
										<falseStatements>
											<comment>current child</comment>
											<foreachStatement>
												<variable type="SiteMapBuilderNode" name="child"/>
												<target>
													<propertyReferenceExpression name="Children"/>
												</target>
												<statements>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueEquality">
																<propertyReferenceExpression name="Title">
																	<variableReferenceExpression name="child"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Title">
																	<argumentReferenceExpression name="entry"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="IsNotNullOrWhiteSpace">
																		<methodInvokeExpression methodName="Replace">
																			<target>
																				<methodInvokeExpression methodName="Replace">
																					<target>
																						<propertyReferenceExpression name="Text">
																							<variableReferenceExpression name="entry"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="Title">
																							<variableReferenceExpression name="entry"/>
																						</propertyReferenceExpression>
																						<stringEmptyExpression/>
																					</parameters>
																				</methodInvokeExpression>
																			</target>
																			<parameters>
																				<primitiveExpression value="+"/>
																				<stringEmptyExpression/>
																			</parameters>
																		</methodInvokeExpression>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<propertyReferenceExpression name="Text">
																			<variableReferenceExpression name="child"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Text">
																			<argumentReferenceExpression name="entry"/>
																		</propertyReferenceExpression>
																	</assignStatement>
																</trueStatements>
															</conditionStatement>
															<methodReturnStatement>
																<variableReferenceExpression name="child"/>
															</methodReturnStatement>
														</trueStatements>
													</conditionStatement>
												</statements>
											</foreachStatement>
											<methodInvokeExpression methodName="Add">
												<target>
													<propertyReferenceExpression name="Children"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="entry"/>
												</parameters>
											</methodInvokeExpression>
											<assignStatement>
												<propertyReferenceExpression name="Parent">
													<argumentReferenceExpression name="entry"/>
												</propertyReferenceExpression>
												<thisReferenceExpression/>
											</assignStatement>
											<methodReturnStatement>
												<argumentReferenceExpression name="entry"/>
											</methodReturnStatement>
										</falseStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ToString()-->
							<memberMethod returnType="System.String" name="ToString">
								<attributes public="true" override="true" />
								<statements>
									<variableDeclarationStatement type="StringBuilder" name="sb">
										<init>
											<objectCreateExpression type="StringBuilder"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<propertyReferenceExpression name="Text"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="AppendLine">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Text"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<foreachStatement>
										<variable type="SiteMapBuilderNode" name="entry"/>
										<target>
											<propertyReferenceExpression name="Children"/>
										</target>
										<statements>
											<methodInvokeExpression methodName="AppendLine">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="ToString">
														<target>
															<variableReferenceExpression name="entry"/>
														</target>
													</methodInvokeExpression>
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
				</xsl:if>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
