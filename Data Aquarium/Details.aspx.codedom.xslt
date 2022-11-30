<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="Namespace"/>
	<xsl:param name="IsClassLibrary" select="'false'"/>
	<xsl:param name="IsApplication" select="'false'"/>

	<xsl:template match="/">

		<compileUnit namespace="{$Namespace}.Handlers">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.UI"/> 
				<namespaceImport name="System.Web.UI.WebControls"/>
        <namespaceImport name="{$Namespace}.Data"/>
			</imports>
			<types>
				<!-- class Details -->
				<typeDeclaration name="Details" isPartial="true">
					<baseTypes>
						<typeReference type="{$Namespace}.Web.PageBase"/>
					</baseTypes>
					<members>
						<xsl:if test="$IsApplication='true'">
							<memberProperty type="System.String" name="CssClass">
								<attributes public="true" final="true"/>
								<getStatements>
									<methodReturnStatement>
										<primitiveExpression value="Tall Wide"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
						</xsl:if>
						<xsl:if test="$IsClassLibrary='true'">
							<!-- property form1 -->
							<memberField type="System.Web.UI.HtmlControls.HtmlForm" name="form1">
								<attributes public="true"/>
							</memberField>
							<!-- property Div1 -->
							<memberField type="System.Web.UI.HtmlControls.HtmlGenericControl" name="Div1">
								<attributes public="true"/>
							</memberField>
							<!-- property Extender1 -->
							<memberField type="{$Namespace}.Web.DataViewExtender" name="Extender1">
								<attributes public="true"/>
							</memberField>
							<!-- property ExtenderFilter -->
							<memberField type="System.Web.UI.HtmlControls.HtmlInputHidden" name="ExtenderFilter">
								<attributes public="true"/>
							</memberField>
							<!-- method Page_Init(object, EventArgs) -->
							<memberMethod name="Page_Init">
								<attributes family="true" final="true"/>
								<parameters>
									<parameter type="System.Object" name="sender"/>
									<parameter type="EventArgs" name="e"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Controls"/>
										</target>
										<parameters>
											<objectCreateExpression type="LiteralControl">
												<parameters>
													<primitiveExpression value="&lt;!DOCTYPE html PUBLIC &quot;-//W3C//DTD XHTML 1.0 Transitional//EN&quot; &quot;http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd&quot;&gt;&#13;&#10;&lt;html xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;"/>
												</parameters>
											</objectCreateExpression>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Controls"/>
										</target>
										<parameters>
											<objectCreateExpression type="System.Web.UI.HtmlControls.HtmlHead"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Controls"/>
										</target>
										<parameters>
											<objectCreateExpression type="LiteralControl">
												<parameters>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[<body>]]></xsl:attribute>
													</primitiveExpression>
												</parameters>
											</objectCreateExpression>
										</parameters>
									</methodInvokeExpression>
									<assignStatement>
										<propertyReferenceExpression name="form1"/>
										<objectCreateExpression type="System.Web.UI.HtmlControls.HtmlForm"/>
									</assignStatement>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Controls"/>
										</target>
										<parameters>
											<propertyReferenceExpression name="form1"/>
										</parameters>
									</methodInvokeExpression>
									<!-- script manager-->
									<comment>script manager</comment>
									<variableDeclarationStatement type="AjaxControlToolkit.ToolkitScriptManager" name="sm">
										<init>
											<objectCreateExpression type="AjaxControlToolkit.ToolkitScriptManager"/>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="ID">
											<variableReferenceExpression name="sm"/>
										</propertyReferenceExpression>
										<primitiveExpression value="sm"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ScriptMode">
											<variableReferenceExpression name="sm"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Release">
											<typeReferenceExpression type="ScriptMode"/>
										</propertyReferenceExpression>
									</assignStatement>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Controls">
												<variableReferenceExpression name="form1"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<variableReferenceExpression name="sm"/>
										</parameters>
									</methodInvokeExpression>
									<!-- Div1-->
									<comment>Div1</comment>
									<assignStatement>
										<propertyReferenceExpression name="Div1"/>
										<objectCreateExpression type="System.Web.UI.HtmlControls.HtmlGenericControl">
											<parameters>
												<primitiveExpression value="div"/>
											</parameters>
										</objectCreateExpression>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ID">
											<propertyReferenceExpression name="Div1"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Div1"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="Visible">
											<propertyReferenceExpression name="Div1"/>
										</propertyReferenceExpression>
										<primitiveExpression value="false"/>
									</assignStatement>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Controls">
												<propertyReferenceExpression name="form1"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<propertyReferenceExpression name="Div1"/>
										</parameters>
									</methodInvokeExpression>
									<!-- Extender1 -->
									<comment>Extender1</comment>
									<assignStatement>
										<propertyReferenceExpression name="Extender1"/>
										<objectCreateExpression type="{$Namespace}.Web.DataViewExtender"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ID">
											<propertyReferenceExpression name="Extender1"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Extender1"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="TargetControlID">
											<propertyReferenceExpression name="Extender1"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Div1"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="FilterSource">
											<propertyReferenceExpression name="Extender1"/>
										</propertyReferenceExpression>
										<primitiveExpression value="ExtenderFilter"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="View">
											<propertyReferenceExpression name="Extender1"/>
										</propertyReferenceExpression>
										<primitiveExpression value="editForm1"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ShowActionBar">
											<propertyReferenceExpression name="Extender1"/>
										</propertyReferenceExpression>
										<primitiveExpression value="false"/>
									</assignStatement>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Controls">
												<propertyReferenceExpression name="form1"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<propertyReferenceExpression name="Extender1"/>
										</parameters>
									</methodInvokeExpression>
									<!-- ExtenderFilter -->
									<comment>ExtenderFilter</comment>
									<assignStatement>
										<propertyReferenceExpression name="ExtenderFilter"/>
										<objectCreateExpression type="System.Web.UI.HtmlControls.HtmlInputHidden"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="Name">
											<propertyReferenceExpression name="ExtenderFilter"/>
										</propertyReferenceExpression>
										<primitiveExpression value="ExtenderFilter"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ID">
											<propertyReferenceExpression name="ExtenderFilter"/>
										</propertyReferenceExpression>
										<primitiveExpression value="ExtenderFilter"/>
									</assignStatement>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Controls">
												<propertyReferenceExpression name="form1"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<propertyReferenceExpression name="ExtenderFilter"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Controls"/>
										</target>
										<parameters>
											<objectCreateExpression type="LiteralControl">
												<parameters>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[</body></html>]]></xsl:attribute>
													</primitiveExpression>
												</parameters>
											</objectCreateExpression>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
						</xsl:if>
						<!-- method Page_Load(object, EventArgs) -->
						<memberMethod name="Page_Load">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.Object" name="sender"/>
								<parameter type="EventArgs" name="e"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="IsPostBack"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String" name="link">
											<init>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="l"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="IsNullOrEmpty">
                          <variableReferenceExpression name="link"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <variableDeclarationStatement type="StringEncryptor" name="se">
                          <init>
                            <objectCreateExpression type="StringEncryptor"/>
                          </init>
                        </variableDeclarationStatement>
                        <assignStatement>
                          <variableReferenceExpression name="link"/>
                          <methodInvokeExpression methodName="Decrypt">
                            <target>
                              <variableReferenceExpression name="se"/>
                            </target>
                            <parameters>
                              <arrayIndexerExpression>
                                <target>
                                  <propertyReferenceExpression name="QueryString">
                                    <propertyReferenceExpression name="Request"/>
                                  </propertyReferenceExpression>
                                </target>
                                <indices>
                                  <primitiveExpression value="_link"/>
                                </indices>
                              </arrayIndexerExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                        <assignStatement>
                          <variableReferenceExpression name="link"/>
                          <methodInvokeExpression methodName="UrlDecode">
                            <target>
                              <typeReferenceExpression type="HttpUtility"/>
                            </target>
                            <parameters>
                              <methodInvokeExpression methodName="Substring">
                                <target>
                                  <variableReferenceExpression name="link"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="2"/>
                                </parameters>
                              </methodInvokeExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="link"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Contains">
																<target>
																	<variableReferenceExpression name="link"/>
																</target>
																<parameters>
																	<primitiveExpression value="&amp;"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="link"/>
															<methodInvokeExpression methodName="GetString">
																<target>
																	<propertyReferenceExpression name="Default">
																		<typeReferenceExpression type="Encoding"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<methodInvokeExpression methodName="FromBase64String">
																		<target>
																			<typeReferenceExpression type="Convert"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="link"/>
																		</parameters>
																	</methodInvokeExpression>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement type="Match" name="m">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="link"/>
																<primitiveExpression value="(.+?)(&amp;|$)"/>
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
														<assignStatement>
															<propertyReferenceExpression name="Visible">
																<propertyReferenceExpression name="Div1"/>
															</propertyReferenceExpression>
															<primitiveExpression value="true"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Controller">
																<propertyReferenceExpression name="Extender1"/>
															</propertyReferenceExpression>
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
														</assignStatement>
														<assignStatement>
															<variableReferenceExpression name="m"/>
															<methodInvokeExpression methodName="NextMatch">
																<target>
																	<variableReferenceExpression name="m"/>
																</target>
															</methodInvokeExpression>
														</assignStatement>
														<whileStatement>
															<test>
																<propertyReferenceExpression name="Success">
																	<variableReferenceExpression name="m"/>
																</propertyReferenceExpression>
															</test>
															<statements>
																<variableDeclarationStatement type="Match" name="pair">
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
																								<variableReferenceExpression name="m"/>
																							</propertyReferenceExpression>
																						</target>
																						<indices>
																							<primitiveExpression value="1"/>
																						</indices>
																					</arrayIndexerExpression>
																				</propertyReferenceExpression>
																				<primitiveExpression value="^(\w+)=(.+)$"/>
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
																			<variableReferenceExpression name="pair"/>
																		</propertyReferenceExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="IsNotNullOrEmpty">
																					<propertyReferenceExpression name="FilterFields">
																						<propertyReferenceExpression name="Extender1"/>
																					</propertyReferenceExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<propertyReferenceExpression name="FilterFields">
																						<propertyReferenceExpression name="Extender1"/>
																					</propertyReferenceExpression>
																					<binaryOperatorExpression operator="Add">
																						<propertyReferenceExpression name="FilterFields">
																							<propertyReferenceExpression name="Extender1"/>
																						</propertyReferenceExpression>
																						<primitiveExpression value=","/>
																					</binaryOperatorExpression>
																				</assignStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="Value">
																						<propertyReferenceExpression name="ExtenderFilter"/>
																					</propertyReferenceExpression>
																					<binaryOperatorExpression operator="Add">
																						<propertyReferenceExpression name="Value">
																							<propertyReferenceExpression name="ExtenderFilter"/>
																						</propertyReferenceExpression>
																						<primitiveExpression value=","/>
																					</binaryOperatorExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="FilterFields">
																				<propertyReferenceExpression name="Extender1"/>
																			</propertyReferenceExpression>
																			<binaryOperatorExpression operator="Add">
																				<propertyReferenceExpression name="FilterFields">
																					<propertyReferenceExpression name="Extender1"/>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="Value">
																					<arrayIndexerExpression>
																						<target>
																							<propertyReferenceExpression name="Groups">
																								<variableReferenceExpression name="pair"/>
																							</propertyReferenceExpression>
																						</target>
																						<indices>
																							<primitiveExpression value="1"/>
																						</indices>
																					</arrayIndexerExpression>
																				</propertyReferenceExpression>
																			</binaryOperatorExpression>
																		</assignStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="Value">
																				<propertyReferenceExpression name="ExtenderFilter"/>
																			</propertyReferenceExpression>
																			<binaryOperatorExpression operator="Add">
																				<propertyReferenceExpression name="Value">
																					<propertyReferenceExpression name="ExtenderFilter"/>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="Value">
																					<arrayIndexerExpression>
																						<target>
																							<propertyReferenceExpression name="Groups">
																								<variableReferenceExpression name="pair"/>
																							</propertyReferenceExpression>
																						</target>
																						<indices>
																							<primitiveExpression value="2"/>
																						</indices>
																					</arrayIndexerExpression>
																				</propertyReferenceExpression>
																			</binaryOperatorExpression>
																		</assignStatement>
																	</trueStatements>
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
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
