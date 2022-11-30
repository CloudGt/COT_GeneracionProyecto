<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:bo="urn:schemas-codeontime-com:business-objects"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a bo"
>
	<xsl:param name="Namespace"/>
	<xsl:param name="Host"/>
	<xsl:param name="UseMemoryStream"/>
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="/">

		<compileUnit>
			<xsl:attribute name="namespace">
				<xsl:value-of select="$Namespace"/>
				<xsl:if test="$Host='SharePoint'">
					<xsl:text>.WebParts</xsl:text>
				</xsl:if>
				<xsl:text>.Handlers</xsl:text>
			</xsl:attribute>
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Xml"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="Newtonsoft.Json"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Services"/>
			</imports>
			<types>
				<typeDeclaration name="Export" isPartial="true">
					<baseTypes>
						<typeReference type="ExportBase"/>
					</baseTypes>
				</typeDeclaration>
				<typeDeclaration name="ExportBase">
					<baseTypes>
						<typeReference type="GenericHandlerBase"/>
						<typeReference type="IHttpHandler"/>
						<typeReference type="System.Web.SessionState.IRequiresSessionState"/>
					</baseTypes>
					<members>
						<!-- method IHttpHandler.ProcessRequest(HttpContext) -->
						<memberMethod name="ProcessRequest" privateImplementationType="IHttpHandler">
							<attributes/>
							<parameters>
								<parameter type="HttpContext" name="context"/>
							</parameters>
							<statements>
								<!--<xsl:if test="$UseMemoryStream!='true'">
                  <variableDeclarationStatement type="System.String" name="fileName">
                    <init>
                      <primitiveExpression value="null"/>
                    </init>
                  </variableDeclarationStatement>
                </xsl:if>-->
								<variableDeclarationStatement type="System.String" name="q">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Params">
													<propertyReferenceExpression name="Request">
														<argumentReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="q"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="q"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Contains">
													<target>
														<variableReferenceExpression name="q"/>
													</target>
													<parameters>
														<primitiveExpression value="{{"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="q"/>
													<methodInvokeExpression methodName="ToBase64String">
														<target>
															<typeReferenceExpression type="Convert"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="GetBytes">
																<target>
																	<propertyReferenceExpression name="Default">
																		<typeReferenceExpression type="Encoding"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<variableReferenceExpression name="q"/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<methodInvokeExpression methodName="Redirect">
													<target>
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<binaryOperatorExpression operator="Add">
															<!--<primitiveExpression value="~/Export.ashx?q="/>-->
															<binaryOperatorExpression operator="Add">
																<propertyReferenceExpression name="AppRelativeCurrentExecutionFilePath">
																	<propertyReferenceExpression name="Request">
																		<argumentReferenceExpression name="context"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
																<primitiveExpression value="?q="/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="Add">
																<binaryOperatorExpression operator="Add">
																	<methodInvokeExpression methodName="UrlEncode">
																		<target>
																			<typeReferenceExpression type="HttpUtility"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="q"/>
																		</parameters>
																	</methodInvokeExpression>
																	<primitiveExpression value="&amp;t="/>
																</binaryOperatorExpression>
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Params">
																			<propertyReferenceExpression name="Request">
																				<variableReferenceExpression name="context"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="t"/>
																	</indices>
																</arrayIndexerExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="q"/>
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
															<variableReferenceExpression name="q"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<variableDeclarationStatement type="ActionArgs" name="args">
											<init>
												<methodInvokeExpression methodName="DeserializeObject">
													<typeArguments>
														<typeReference type="ActionArgs"/>
													</typeArguments>
													<target>
														<typeReferenceExpression type="JsonConvert"/>
													</target>
													<parameters>
														<variableReferenceExpression name="q"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>

										<variableDeclarationStatement name="viewId">
											<init>
												<propertyReferenceExpression name="CommandArgument">
													<variableReferenceExpression name="args"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="viewId"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="viewId"/>
													<propertyReferenceExpression name="View">
														<variableReferenceExpression name="args"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>

										<variableDeclarationStatement name="commandName">
											<init>
												<propertyReferenceExpression name="CommandName">
													<variableReferenceExpression name="args"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>

										<variableDeclarationStatement name="attchmentFileName">
											<init>
												<methodInvokeExpression methodName="Format">
													<target>
														<typeReferenceExpression type="System.String"/>
													</target>
													<parameters>
														<stringFormatExpression format="attachment; filename={{0}}">
															<methodInvokeExpression methodName="GenerateOutputFileName">
																<parameters>
																	<variableReferenceExpression name="args"/>
																	<stringFormatExpression format="{{0}}_{{1}}">
																		<propertyReferenceExpression name="Controller">
																			<variableReferenceExpression name="args"/>
																		</propertyReferenceExpression>
																		<variableReferenceExpression name="viewId"/>
																	</stringFormatExpression>
																</parameters>
															</methodInvokeExpression>
														</stringFormatExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>

										<comment>create an Excel Web Query</comment>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="ValueEquality">
														<variableReferenceExpression name="commandName"/>
														<primitiveExpression value="ExportRowset"/>
													</binaryOperatorExpression>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="Contains">
															<target>
																<propertyReferenceExpression name="AbsoluteUri">
																	<propertyReferenceExpression name="Url">
																		<propertyReferenceExpression name="Request">
																			<argumentReferenceExpression name="context"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<primitiveExpression value="&amp;d"/>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String" name="webQueryUrl">
													<init>
														<propertyReferenceExpression name="AbsoluteUri">
															<propertyReferenceExpression name="Url">
																<propertyReferenceExpression name="Request">
																	<argumentReferenceExpression name="context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="accessToken">
													<init>
														<stringEmptyExpression/>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="user">
													<init>
														<methodInvokeExpression methodName="GetUser">
															<target>
																<typeReferenceExpression type="Membership"/>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<variableReferenceExpression name="user"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="accessToken"/>
															<propertyReferenceExpression name="AccessToken">
																<methodInvokeExpression methodName="CreateTicket">
																	<target>
																		<methodInvokeExpression methodName="Create">
																			<target>
																				<typeReferenceExpression type="ApplicationServicesBase"/>
																			</target>
																		</methodInvokeExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="user"/>
																		<primitiveExpression value="null"/>
																		<primitiveExpression value="export.rowset.accessTokenDuration"/>"
																		<stringEmptyExpression/>
																	</parameters>
																</methodInvokeExpression>
															</propertyReferenceExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement name="indexOfToken">
													<init>
														<methodInvokeExpression methodName="IndexOf">
															<target>
																<variableReferenceExpression name="webQueryUrl"/>
															</target>
															<parameters>
																<primitiveExpression value="&amp;t="/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="indexOfToken"/>
															<primitiveExpression value="-1"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="webQueryUrl"/>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="webQueryUrl"/>
																<primitiveExpression value="&amp;t="/>
															</binaryOperatorExpression>
														</assignStatement>
														<assignStatement>
															<variableReferenceExpression name="indexOfToken"/>
															<propertyReferenceExpression name="Length">
																<variableReferenceExpression name="webQueryUrl"/>
															</propertyReferenceExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<assignStatement>
															<variableReferenceExpression name="indexOfToken"/>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="indexOfToken"/>
																<primitiveExpression value="3"/>
															</binaryOperatorExpression>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="webQueryUrl"/>
													<binaryOperatorExpression operator="Add">
														<methodInvokeExpression methodName="Substring">
															<target>
																<variableReferenceExpression name="webQueryUrl"/>
															</target>
															<parameters>
																<primitiveExpression value="0"/>
																<variableReferenceExpression name="indexOfToken"/>
															</parameters>
														</methodInvokeExpression>
														<variableReferenceExpression name="accessToken"/>
													</binaryOperatorExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="webQueryUrl"/>
													<methodInvokeExpression methodName="ToClientUrl">
														<parameters>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="webQueryUrl"/>
																<primitiveExpression value="&amp;d=true"/>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>

												<methodInvokeExpression methodName="Write">
													<target>
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="Web&#13;&#10;1&#13;&#10;"/>
															<variableReferenceExpression name="webQueryUrl"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
												<assignStatement>
													<propertyReferenceExpression name="ContentType">
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="text/x-ms-iqy"/>
												</assignStatement>
												<methodInvokeExpression methodName="AddHeader">
													<target>
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="Content-Disposition"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="attchmentFileName"/>
															<primitiveExpression value=".iqy"/>
														</binaryOperatorExpression>
														<!--<methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="String"/>
                              </target>
                              <parameters>
                                <stringFormatExpression format="attachment; filename={{0}}">
                                  <methodInvokeExpression methodName="GenerateOutputFileName">
                                    <parameters>
                                      <variableReferenceExpression name="args"/>
                                      <stringFormatExpression format="{{0}}_{{1}}.iqy">
                                        <propertyReferenceExpression name="Controller">
                                          <variableReferenceExpression name="args"/>
                                        </propertyReferenceExpression>
                                        <propertyReferenceExpression name="View">
                                          <variableReferenceExpression name="args"/>
                                        </propertyReferenceExpression>
                                      </stringFormatExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </stringFormatExpression>
                              </parameters>
                            </methodInvokeExpression>-->
													</parameters>
												</methodInvokeExpression>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>

										<comment>execute data export</comment>
										<variableDeclarationStatement name="requestPageSize">
											<init>
												<propertyReferenceExpression name="PageSize"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="requiresRowCount">
											<init>
												<primitiveExpression value="true"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="methodNameSuffix">
											<init>
												<primitiveExpression value="Csv"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="commandName"/>
													<primitiveExpression value="ExportCsv"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="ContentType">
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="text/csv"/>
												</assignStatement>
												<methodInvokeExpression methodName="AddHeader">
													<target>
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="Content-Disposition"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="attchmentFileName"/>
															<primitiveExpression value=".csv"/>
														</binaryOperatorExpression>
														<!--<methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="System.String"/>
                              </target>
                              <parameters>
                                <stringFormatExpression format="attachment; filename={{0}}">
                                  <methodInvokeExpression methodName="GenerateOutputFileName">
                                    <parameters>
                                      <variableReferenceExpression name="args"/>
                                      <stringFormatExpression format="{{0}}_{{1}}.csv">
                                        <propertyReferenceExpression name="Controller">
                                          <variableReferenceExpression name="args"/>
                                        </propertyReferenceExpression>
                                        <propertyReferenceExpression name="View">
                                          <variableReferenceExpression name="args"/>
                                        </propertyReferenceExpression>
                                      </stringFormatExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </stringFormatExpression>
                              </parameters>
                            </methodInvokeExpression>-->
													</parameters>
												</methodInvokeExpression>
												<assignStatement>
													<propertyReferenceExpression name="Charset">
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="utf-8"/>
												</assignStatement>
												<!--<methodInvokeExpression methodName="Write">
                          <target>
                            <propertyReferenceExpression name="Response">
                              <argumentReferenceExpression name="context"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <convertExpression to="Char">
                              <primitiveExpression value="65279"/>
                            </convertExpression>
                          </parameters>
                        </methodInvokeExpression>-->
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="commandName"/>
															<primitiveExpression value="ExportRowset"/>
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
														<assignStatement>
															<variableReferenceExpression name="methodNameSuffix"/>
															<primitiveExpression value="Rowset"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<assignStatement>
															<propertyReferenceExpression name="ContentType">
																<propertyReferenceExpression name="Response">
																	<argumentReferenceExpression name="context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<primitiveExpression value="application/rss+xml"/>
														</assignStatement>
														<assignStatement>
															<variableReferenceExpression name="methodNameSuffix"/>
															<primitiveExpression value="Rss"/>
														</assignStatement>
														<assignStatement>
															<variableReferenceExpression name="requestPageSize"/>
															<propertyReferenceExpression name="MaximumRssItems">
																<typeReferenceExpression type="DataControllerBase"/>
															</propertyReferenceExpression>
														</assignStatement>
														<assignStatement>
															<variableReferenceExpression name="requiresRowCount"/>
															<primitiveExpression value="false"/>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
										<variableDeclarationStatement name="r">
											<init>
												<objectCreateExpression type="PageRequest"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="Controller">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="Controller">
												<variableReferenceExpression name="args"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="View">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="viewId"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Filter">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="Filter">
												<variableReferenceExpression name="args"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="ExternalFilter">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="ExternalFilter">
												<variableReferenceExpression name="args"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="PageSize">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="requestPageSize"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="RequiresMetaData">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<primitiveExpression value="true"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="MetadataFilter">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<arrayCreateExpression>
												<createType type="System.String"/>
												<initializers>
													<primitiveExpression value="fields"/>
													<primitiveExpression value="items"/>
												</initializers>
											</arrayCreateExpression>
										</assignStatement>
										<variableDeclarationStatement name="pageIndex">
											<init>
												<primitiveExpression value="0"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="totalRowCount">
											<init>
												<primitiveExpression value="-1"/>
											</init>
										</variableDeclarationStatement>
										<usingStatement>
											<variable name="writer">
												<init>
													<objectCreateExpression type="StreamWriter">
														<parameters>
															<propertyReferenceExpression name="OutputStream">
																<propertyReferenceExpression name="Response">
																	<argumentReferenceExpression name="context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="UTF8">
																<typeReferenceExpression type="Encoding"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="Multiply">
																<primitiveExpression value="1024"/>
																<primitiveExpression value="10"/>
															</binaryOperatorExpression>
															<primitiveExpression value="true"/>
														</parameters>
													</objectCreateExpression>
												</init>
											</variable>
											<statements>
												<whileStatement>
													<test>
														<binaryOperatorExpression operator="BooleanOr">
															<binaryOperatorExpression operator="ValueEquality">
																<variableReferenceExpression name="totalRowCount"/>
																<primitiveExpression value="-1"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="GreaterThan">
																<variableReferenceExpression name="totalRowCount"/>
																<primitiveExpression value="0"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</test>
													<statements>
														<assignStatement>
															<propertyReferenceExpression name="PageIndex">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="pageIndex"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="RequiresRowCount">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="BooleanAnd">
																<variableReferenceExpression name="requiresRowCount"/>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="pageIndex"/>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
														</assignStatement>
														<variableDeclarationStatement name="controller">
															<init>
																<methodInvokeExpression methodName="CreateDataController">
																	<target>
																		<typeReferenceExpression type="ControllerFactory"/>
																	</target>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="p">
															<init>
																<methodInvokeExpression methodName="GetPage">
																	<target>
																		<variableReferenceExpression name="controller"/>
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
														<foreachStatement>
															<variable name="field"/>
															<target>
																<propertyReferenceExpression name="Fields">
																	<variableReferenceExpression name="p"/>
																</propertyReferenceExpression>
															</target>
															<statements>
																<methodInvokeExpression methodName="NormalizeDataFormatString">
																	<target>
																		<variableReferenceExpression name="field"/>
																	</target>
																</methodInvokeExpression>
															</statements>
														</foreachStatement>
														<variableDeclarationStatement name="scope">
															<init>
																<primitiveExpression value="current"/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="pageIndex"/>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="totalRowCount"/>
																	<propertyReferenceExpression name="TotalRowCount">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="GreaterThan">
																			<variableReferenceExpression name="totalRowCount"/>
																			<variableReferenceExpression name="requestPageSize"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="scope"/>
																			<primitiveExpression value="start"/>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<variableReferenceExpression name="scope"/>
																			<primitiveExpression value="all"/>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<assignStatement>
															<variableReferenceExpression name="totalRowCount"/>
															<binaryOperatorExpression operator="Subtract">
																<variableReferenceExpression name="totalRowCount"/>
																<propertyReferenceExpression name="Count">
																	<propertyReferenceExpression name="Rows">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</assignStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="LessThanOrEqual">
																		<variableReferenceExpression name="totalRowCount"/>
																		<primitiveExpression value="0"/>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="GreaterThan">
																		<variableReferenceExpression name="pageIndex"/>
																		<primitiveExpression value="0"/>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="scope"/>
																	<primitiveExpression value="end"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<assignStatement>
															<variableReferenceExpression name="pageIndex"/>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="pageIndex"/>
																<primitiveExpression value="1"/>
															</binaryOperatorExpression>
														</assignStatement>
														<methodInvokeExpression methodName="ResolveManyToManyFields">
															<parameters>
																<variableReferenceExpression name="p"/>
															</parameters>
														</methodInvokeExpression>
														<comment>send data to the output</comment>
														<methodInvokeExpression methodName="Invoke">
															<target>
																<methodInvokeExpression methodName="GetMethod">
																	<target>
																		<methodInvokeExpression methodName="GetType">
																			<target>
																				<variableReferenceExpression name="controller"/>
																			</target>
																		</methodInvokeExpression>
																	</target>
																	<parameters>
																		<binaryOperatorExpression operator="Add">
																			<primitiveExpression value="ExportDataAs"/>
																			<variableReferenceExpression name="methodNameSuffix"/>
																		</binaryOperatorExpression>
																	</parameters>
																</methodInvokeExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="controller"/>
																<arrayCreateExpression>
																	<createType type="System.Object"/>
																	<initializers>
																		<variableReferenceExpression name="p"/>
																		<objectCreateExpression type="DataTableReader">
																			<parameters>
																				<methodInvokeExpression methodName="ToDataTable">
																					<target>
																						<variableReferenceExpression name="p"/>
																					</target>
																				</methodInvokeExpression>
																			</parameters>
																		</objectCreateExpression>
																		<variableReferenceExpression name="writer"/>
																		<variableReferenceExpression name="scope"/>
																	</initializers>
																</arrayCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</whileStatement>
											</statements>
										</usingStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- property IsReusable -->
						<memberProperty type="System.Boolean" name="IsReusable" privateImplementationType="IHttpHandler">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method ToClientUrl(string) -->
						<memberMethod returnType="System.String" name="ToClientUrl">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="url"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<argumentReferenceExpression name="url"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ResolveManyToManyFields(ViewPage) -->
						<memberMethod name="ResolveManyToManyFields">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="manyToManyFields">
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.Int32"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable name="df"/>
									<target>
										<propertyReferenceExpression name="Fields">
											<argumentReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="ItemsStyle">
															<variableReferenceExpression name="df"/>
														</propertyReferenceExpression>
														<primitiveExpression value="CheckBoxList"/>
													</binaryOperatorExpression>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<propertyReferenceExpression name="ItemsTargetController">
															<variableReferenceExpression name="df"/>
														</propertyReferenceExpression>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="fieldIndex">
													<init>
														<methodInvokeExpression methodName="IndexOfField">
															<target>
																<argumentReferenceExpression name="page"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="df"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="manyToManyFields"/>
													</target>
													<parameters>
														<variableReferenceExpression name="fieldIndex"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Count">
												<variableReferenceExpression name="manyToManyFields"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable name="row"/>
											<target>
												<propertyReferenceExpression name="Rows">
													<argumentReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<foreachStatement>
													<variable name="fieldIndex"/>
													<target>
														<variableReferenceExpression name="manyToManyFields"/>
													</target>
													<statements>
														<variableDeclarationStatement name="v">
															<init>
																<castExpression targetType="System.String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="row"/>
																		</target>
																		<indices>
																			<variableReferenceExpression name="fieldIndex"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="newValue">
															<init>
																<objectCreateExpression type="List">
																	<typeArguments>
																		<typeReference type="System.String"/>
																	</typeArguments>
																</objectCreateExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<variableReferenceExpression name="v"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="lov">
																	<init>
																		<methodInvokeExpression methodName="Split">
																			<target>
																				<typeReferenceExpression type="Regex"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="v"/>
																				<primitiveExpression value=","/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<foreachStatement>
																	<variable name="item"/>
																	<target>
																		<propertyReferenceExpression name="Items">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Fields">
																						<argumentReferenceExpression name="page"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<variableReferenceExpression name="fieldIndex"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="Contains">
																					<target>
																						<variableReferenceExpression name="lov"/>
																					</target>
																					<parameters>
																						<convertExpression to="String">
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="item"/>
																								</target>
																								<indices>
																									<primitiveExpression value="0"/>
																								</indices>
																							</arrayIndexerExpression>
																						</convertExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="newValue"/>
																					</target>
																					<parameters>
																						<convertExpression to="String">
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="item"/>
																								</target>
																								<indices>
																									<primitiveExpression value="1"/>
																								</indices>
																							</arrayIndexerExpression>
																						</convertExpression>
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
																	<variableReferenceExpression name="row"/>
																</target>
																<indices>
																	<variableReferenceExpression name="fieldIndex"/>
																</indices>
															</arrayIndexerExpression>
															<methodInvokeExpression methodName="Join">
																<target>
																	<typeReferenceExpression type="System.String"/>
																</target>
																<parameters>
																	<primitiveExpression value=", "/>
																	<variableReferenceExpression name="newValue"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</statements>
												</foreachStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- property PageSize -->
						<memberProperty type="System.Int32" name="PageSize">
							<attributes public="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="1000"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
