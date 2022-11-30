<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:param name="Namespace"/>
	<xsl:param name="TargetFramework"/>
	<xsl:param name="ScriptOnly" select="'false'"/>
	<xsl:param name="Host"/>
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
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="Newtonsoft.Json"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Services"/>
				<namespaceImport name="{$Namespace}.Web"/>
			</imports>
			<types>
				<!-- class ReportData -->
				<typeDeclaration name="ReportData">
					<members>
						<!-- property Data-->
						<memberProperty type="System.Byte[]" name="Data">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property MimeType -->
						<memberProperty type="System.String" name="MimeType">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property FileNameExtension-->
						<memberProperty type="System.String" name="FileNameExtension">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Encoding-->
						<memberProperty type="System.String" name="Encoding">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- constructor -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.Byte[]" name="data"/>
								<parameter type="System.String" name="mimeType"/>
								<parameter type="System.String" name="fileNameExtension"/>
								<parameter type="System.String" name="encoding"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="Data">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="data"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="MimeType">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="mimeType"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="FileNameExtension">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="fileNameExtension"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Encoding">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="encoding"/>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>
				<!-- class ReportArgs -->
				<typeDeclaration name="ReportArgs">
					<comment>
						<![CDATA[
    /// <summary>
    /// A collection of parameters controlling the process or report generation.
    /// </summary>
          ]]>
					</comment>
					<members>
						<!-- property Controller -->
						<memberProperty type="System.String" name="Controller">
							<comment>
								<![CDATA[
        /// <summary>
        /// The name of the data controller
        /// </summary>
                ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property View -->
						<memberProperty type="System.String" name="View">
							<comment>
								<![CDATA[
        /// <summary>
        /// The ID of the view. Optional.
        /// </summary>
                ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property TemplateName -->
						<memberProperty type="System.String" name="TemplateName">
							<comment>
								<![CDATA[
        /// <summary>
        /// The name of a custom RDLC template. Optional.
        /// </summary>
                ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Format -->
						<memberProperty type="System.String" name="Format">
							<comment>
								<![CDATA[
        /// <summary>
        /// Report output format. Supported values are Pdf, Word, Excel, and Tiff. The default value is Pdf. Optional.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property FilterDetails -->
						<memberProperty type="System.String" name="FilterDetails">
							<comment>
								<![CDATA[
        /// <summary>
        /// Specifies a user-friendly description of the filter. The description is displayed on the automatically produced reports below the report header. Optional.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property SortExpression -->
						<memberProperty type="System.String" name="SortExpression">
							<comment>
								<![CDATA[
        /// <summary>
        /// Sort expression that must be applied to the dataset prior to the report generation. Optional.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Filter -->
						<memberProperty type="FieldFilter[]" name="Filter">
							<comment>
								<![CDATA[
        /// <summary>
        /// A filter expression that must be applied to the dataset prior to the report generation. Optional.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property FilterRaw -->
						<memberProperty type="System.String[]" name="FilterRaw">
							<comment>
								<![CDATA[
        /// <summary>
        /// The raw filter expression that must be applied to the dataset prior to the report generation. Optional.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property MimeType -->
						<memberProperty type="System.String" name="MimeType">
							<comment>
								<![CDATA[
        /// <summary>
        /// Specifies the MIME type of the report produced by Report.Execute() method.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property FileNameExtension -->
						<memberProperty type="System.String" name="FileNameExtension">
							<comment>
								<![CDATA[
        /// <summary>
        /// Specifies the file name extension of the report produced by Report.Execute() method.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property FileName -->
						<memberProperty type="System.String" name="FileName">
							<comment>
								<![CDATA[
        /// <summary>
        /// Specifies the file name of the report produced by the RESTful API Engine.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Encoding -->
						<memberProperty type="System.String" name="Encoding">
							<comment>
								<![CDATA[
        /// <summary>
        /// Specifies the encoding of the report produced by Report.Execute() method.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- constructor () -->
						<constructor>
							<attributes  public="true"/>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="View"/>
									<primitiveExpression value="grid1"/>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>

				<!-- class ReportBase -->
				<typeDeclaration name="ReportBase">
					<baseTypes>
						<typeReference type="GenericHandlerBase"/>
						<typeReference type="IHttpHandler"/>
						<typeReference type="System.Web.SessionState.IRequiresSessionState"/>
					</baseTypes>
					<members>
						<!-- property ReportArgs -->
						<memberProperty type="ReportArgs" name="Arguments">
							<attributes family="true" final="true"/>
						</memberProperty>
						<!-- property Request -->
						<memberProperty type="PageRequest" name="Request">
							<attributes family="true" final="true"/>
						</memberProperty>
						<!-- property ExecuteArgs -->
						<memberProperty type="ActionArgs" name="ExecuteArgs">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property OutputStream -->
						<memberProperty type="Stream" name="OutputStream">
							<attributes family="true" final="true"/>
						</memberProperty>
						<!-- field validationKeyRegex-->
						<memberField type="Regex" name="validationKeyRegex">
							<attributes static="true" private="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression value="/Blob.ashx\?"/>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- method IHttpHandler.ProcessRequest(HttpContext) -->
						<memberMethod name="ProcessRequest" privateImplementationType="IHttpHandler">
							<attributes/>
							<parameters>
								<parameter type="HttpContext" name="context"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="c">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Request">
													<argumentReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="c"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="q">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Request">
													<argumentReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="q"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="PageRequest" name="request">
									<init>
										<propertyReferenceExpression name="Request">
											<thisReferenceExpression/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="request"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="BooleanOr">
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="c"/>
												</unaryOperatorExpression>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="q"/>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="Exception">
												<parameters>
													<primitiveExpression value="Invalid report request."/>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</trueStatements>
								</conditionStatement>
								<comment>create a data table for report</comment>
								<variableDeclarationStatement type="System.String" name="templateName">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="aa">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="reportFormat">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="request"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="request"/>
											<methodInvokeExpression methodName="DeserializeObject">
												<typeArguments>
													<typeReference type="PageRequest"/>
												</typeArguments>
												<target>
													<typeReferenceExpression type="JsonConvert"/>
												</target>
												<parameters>
													<variableReferenceExpression name="q"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="templateName"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Form">
														<propertyReferenceExpression name="Request">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="a"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="aa"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Request">
														<argumentReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="aa"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<variableReferenceExpression name="templateName"/>
											<propertyReferenceExpression name="TemplateName">
												<propertyReferenceExpression name="Arguments">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="reportFormat"/>
											<propertyReferenceExpression name="Format">
												<propertyReferenceExpression name="Arguments">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="FilterDetails">
												<variableReferenceExpression name="request"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="FilterDetails">
												<propertyReferenceExpression name="Arguments">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="PageIndex">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<primitiveExpression value="0"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="PageSize">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="MaxValue">
										<typeReferenceExpression type="Int32"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="RequiresMetaData">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<comment>try to generate a report via a business rule</comment>
								<variableDeclarationStatement type="ActionArgs" name="args">
									<init>
										<propertyReferenceExpression name="ExecuteArgs">
											<thisReferenceExpression/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="args"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="aa"/>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="args"/>
											<methodInvokeExpression methodName="DeserializeObject">
												<typeArguments>
													<typeReference type="ActionArgs"/>
												</typeArguments>
												<target>
													<typeReferenceExpression type="JsonConvert"/>
												</target>
												<parameters>
													<variableReferenceExpression name="aa"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition >
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="args"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="IDataController" name="controller">
											<init>
												<methodInvokeExpression methodName="CreateDataController">
													<target>
														<typeReferenceExpression type="ControllerFactory"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="ActionResult" name="result">
											<init>
												<methodInvokeExpression methodName="Execute">
													<target>
														<variableReferenceExpression name="controller"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Controller">
															<variableReferenceExpression name="args"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="View">
															<variableReferenceExpression name="args"/>
														</propertyReferenceExpression>
														<variableReferenceExpression name="args"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<propertyReferenceExpression name="NavigateUrl">
														<variableReferenceExpression name="result"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="AppendDownloadTokenCookie"/>
												<methodInvokeExpression methodName="Redirect">
													<target>
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<propertyReferenceExpression name="NavigateUrl">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="Canceled">
													<variableReferenceExpression name="result"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="AppendDownloadTokenCookie"/>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="RaiseExceptionIfErrors">
											<target>
												<variableReferenceExpression name="result"/>
											</target>
										</methodInvokeExpression>
										<comment>parse action data</comment>
										<variableDeclarationStatement type="SortedDictionary" name="actionData">
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
										<methodInvokeExpression methodName="ParseActionData">
											<target>
												<propertyReferenceExpression name="Config">
													<castExpression targetType="DataControllerBase">
														<variableReferenceExpression name="controller"/>
													</castExpression>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="Path">
													<variableReferenceExpression name="args"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="actionData"/>
											</parameters>
										</methodInvokeExpression>
										<variableDeclarationStatement type="List" name="filter">
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
										<foreachStatement>
											<variable type="System.String" name="name"/>
											<target>
												<propertyReferenceExpression name="Keys">
													<variableReferenceExpression name="actionData"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<variableDeclarationStatement type="System.String" name="v">
													<init>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="actionData"/>
															</target>
															<indices>
																<variableReferenceExpression name="name"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="StartsWith">
															<target>
																<variableReferenceExpression name="name"/>
															</target>
															<parameters>
																<primitiveExpression value="_"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="name"/>
																	<primitiveExpression value="_controller"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="Controller">
																		<variableReferenceExpression name="request"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="v"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="name"/>
																	<primitiveExpression value="_view"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="View">
																		<variableReferenceExpression name="request"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="v"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="name"/>
																	<primitiveExpression value="_sortExpression"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="SortExpression">
																		<variableReferenceExpression name="request"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="v"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="name"/>
																	<primitiveExpression value="_count"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="PageSize">
																		<variableReferenceExpression name="request"/>
																	</propertyReferenceExpression>
																	<convertExpression to="Int32">
																		<variableReferenceExpression name="v"/>
																	</convertExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="name"/>
																	<primitiveExpression value="_template"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="templateName"/>
																	<variableReferenceExpression name="v"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="v"/>
																	<primitiveExpression value="@Arguments_SelectedValues"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="GreaterThan">
																			<propertyReferenceExpression name="Length">
																				<propertyReferenceExpression name="SelectedValues">
																					<variableReferenceExpression name="args"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																			<primitiveExpression value="0"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="StringBuilder" name="sb">
																			<init>
																				<objectCreateExpression type="StringBuilder"/>
																			</init>
																		</variableDeclarationStatement>
																		<foreachStatement>
																			<variable type="System.String" name="key"/>
																			<target>
																				<propertyReferenceExpression name="SelectedValues">
																					<variableReferenceExpression name="args"/>
																				</propertyReferenceExpression>
																			</target>
																			<statements>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="GreaterThan">
																							<propertyReferenceExpression name="Length">
																								<variableReferenceExpression name="sb"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="0"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="Append">
																							<target>
																								<variableReferenceExpression name="sb"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="$or$"/>
																							</parameters>
																						</methodInvokeExpression>
																					</trueStatements>
																				</conditionStatement>
																				<methodInvokeExpression methodName="Append">
																					<target>
																						<variableReferenceExpression name="sb"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="key"/>
																					</parameters>
																				</methodInvokeExpression>
																			</statements>
																		</foreachStatement>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<variableReferenceExpression name="filter"/>
																			</target>
																			<parameters>
																				<stringFormatExpression format="{{0}}:$in${{1}}">
																					<variableReferenceExpression name="name"/>
																					<methodInvokeExpression methodName="ToString">
																						<target>
																							<variableReferenceExpression name="sb"/>
																						</target>
																					</methodInvokeExpression>
																				</stringFormatExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																	<falseStatements>
																		<methodReturnStatement/>
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
																				<variableReferenceExpression name="v"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[^('|").+('|")$]]></xsl:attribute>
																				</primitiveExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<variableReferenceExpression name="filter"/>
																			</target>
																			<parameters>
																				<stringFormatExpression format="{{0}}:={{1}}">
																					<variableReferenceExpression name="name"/>
																					<methodInvokeExpression methodName="Substring">
																						<target>
																							<variableReferenceExpression name="v"/>
																						</target>
																						<parameters>
																							<primitiveExpression value="1"/>
																							<binaryOperatorExpression operator="Subtract">
																								<propertyReferenceExpression name="Length">
																									<variableReferenceExpression name="v"/>
																								</propertyReferenceExpression>
																								<primitiveExpression value="2"/>
																							</binaryOperatorExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</stringFormatExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityInequality">
																					<propertyReferenceExpression name="Values">
																						<variableReferenceExpression name="args"/>
																					</propertyReferenceExpression>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<foreachStatement>
																					<variable type="FieldValue" name="fvo"/>
																					<target>
																						<propertyReferenceExpression name="Values">
																							<variableReferenceExpression name="args"/>
																						</propertyReferenceExpression>
																					</target>
																					<statements>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="Name">
																										<variableReferenceExpression name="fvo"/>
																									</propertyReferenceExpression>
																									<variableReferenceExpression name="v"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="Add">
																									<target>
																										<variableReferenceExpression name="filter"/>
																									</target>
																									<parameters>
																										<stringFormatExpression format="{{0}}:={{1}}">
																											<variableReferenceExpression name="name"/>
																											<propertyReferenceExpression name="Value">
																												<variableReferenceExpression name="fvo"/>
																											</propertyReferenceExpression>
																										</stringFormatExpression>
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
													</falseStatements>
												</conditionStatement>
												<assignStatement>
													<propertyReferenceExpression name="Filter">
														<variableReferenceExpression name="request"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="ToArray">
														<target>
															<variableReferenceExpression name="filter"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<comment>load report definition</comment>
								<variableDeclarationStatement type="System.String" name="reportTemplate">
									<init>
										<methodInvokeExpression methodName="CreateReportInstance">
											<target>
												<typeReferenceExpression type="Controller"/>
											</target>
											<parameters>
												<primitiveExpression value="null"/>
												<variableReferenceExpression name="templateName"/>
												<propertyReferenceExpression name="Controller">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="View">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<!--<comment>create a data reader</comment>
                <variableDeclarationStatement type="DbDataReader" name="reader">
                  <init>
                    <methodInvokeExpression methodName="ExecuteReader">
                      <target>
                        <methodInvokeExpression methodName="CreateDataEngine">
                          <target>
                            <typeReferenceExpression type="ControllerFactory"/>
                          </target>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="request"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="DataTable" name="table">
                  <init>
                    <objectCreateExpression type="DataTable">
                      <parameters>
                        <propertyReferenceExpression name="Controller">
                          <variableReferenceExpression name="request"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <forStatement>
                  <variable type="System.Int32" name="i">
                    <init>
                      <primitiveExpression value="0"/>
                    </init>
                  </variable>
                  <test>
                    <binaryOperatorExpression operator="LessThan">
                      <variableReferenceExpression name="i"/>
                      <propertyReferenceExpression name="FieldCount">
                        <variableReferenceExpression name="reader"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </test>
                  <increment>
                    <variableReferenceExpression name="i"/>
                  </increment>
                  <statements>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <propertyReferenceExpression name="Columns">
                          <variableReferenceExpression name="table"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <objectCreateExpression type="DataColumn">
                          <parameters>
                            <methodInvokeExpression methodName="GetName">
                              <target>
                                <variableReferenceExpression name="reader"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="i"/>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="GetFieldType">
                              <target>
                                <variableReferenceExpression name="reader"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="i"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </objectCreateExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                </forStatement>
                <methodInvokeExpression methodName="Load">
                  <target>
                    <variableReferenceExpression name="table"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="reader"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Close">
                  <target>
                    <variableReferenceExpression name="reader"/>
                  </target>
                </methodInvokeExpression>-->
								<!-- 
       ViewPage page = ControllerFactory.CreateDataController().GetPage(request.Controller, request.View, request);
            DataTable table = page.ToDataTable();
            -->
								<variableDeclarationStatement name="page">
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
								<methodInvokeExpression methodName="ResolveManyToManyFields">
									<target>
										<typeReferenceExpression type="Export"/>
									</target>
									<parameters>
										<variableReferenceExpression name="page"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="DataTable" name="table">
									<init>
										<methodInvokeExpression methodName="ToDataTable">
											<target>
												<variableReferenceExpression name="page"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<comment>insert validation key</comment>
								<assignStatement>
									<variableReferenceExpression name="reportTemplate"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<fieldReferenceExpression name="validationKeyRegex"/>
										</target>
										<parameters>
											<variableReferenceExpression name="reportTemplate"/>
											<stringFormatExpression format="/Blob.ashx?_validationKey={{0}}&amp;amp;">
												<propertyReferenceExpression name="ValidationKey">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</stringFormatExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<comment>figure report output format</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<propertyReferenceExpression name="Arguments">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="Match" name="m">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="c"/>
														<primitiveExpression value="^(ReportAs|Report)(Pdf|Excel|Image|Word|)$"/>
														<!--<propertyReferenceExpression name="Compiled">
                          <typeReferenceExpression type="RegexOptions"/>
                        </propertyReferenceExpression>-->
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="reportFormat"/>
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
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="reportFormat"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="reportFormat"/>
											<primitiveExpression value="Pdf"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<comment>render a report</comment>
								<variableDeclarationStatement type="ReportData" name="report">
									<init>
										<methodInvokeExpression methodName="Render">
											<parameters>
												<variableReferenceExpression name="request"/>
												<variableReferenceExpression name="table"/>
												<variableReferenceExpression name="reportTemplate"/>
												<variableReferenceExpression name="reportFormat"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="fileName">
									<init>
										<methodInvokeExpression methodName="FormatFileName">
											<parameters>
												<argumentReferenceExpression name="context"/>
												<variableReferenceExpression name="request"/>
												<propertyReferenceExpression name="FileNameExtension">
													<variableReferenceExpression name="report"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="fileName"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="reportTimeStamp">
											<init>
												<methodInvokeExpression methodName="Replace">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="ToString">
															<target>
																<propertyReferenceExpression name="Now">
																	<typeReferenceExpression type="DateTime"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<primitiveExpression value="s"/>
															</parameters>
														</methodInvokeExpression>
														<primitiveExpression value="\W"/>
														<stringEmptyExpression/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="fileName"/>
											<stringFormatExpression>
												<xsl:attribute name="format"><![CDATA[{0}_{1}_{2}.{3}]]></xsl:attribute>
												<propertyReferenceExpression name="Controller">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="View">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="reportTimeStamp"/>
												<propertyReferenceExpression name="FileNameExtension">
													<variableReferenceExpression name="report"/>
												</propertyReferenceExpression>
											</stringFormatExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="args"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="fileName"/>
													<methodInvokeExpression methodName="GenerateOutputFileName">
														<parameters>
															<variableReferenceExpression name="args"/>
															<variableReferenceExpression name="fileName"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Arguments">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="MimeType">
												<propertyReferenceExpression name="Arguments">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="MimeType">
												<variableReferenceExpression name="report"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="FileNameExtension">
												<propertyReferenceExpression name="Arguments">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="FileNameExtension">
												<variableReferenceExpression name="report"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Encoding">
												<propertyReferenceExpression name="Arguments">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="Encoding">
												<variableReferenceExpression name="report"/>
											</propertyReferenceExpression>
										</assignStatement>
										<methodInvokeExpression methodName="Write">
											<target>
												<propertyReferenceExpression name="OutputStream">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="Data">
													<variableReferenceExpression name="report"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
												<propertyReferenceExpression name="Length">
													<propertyReferenceExpression name="Data">
														<variableReferenceExpression name="report"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<propertyReferenceExpression name="FileName">
												<propertyReferenceExpression name="Arguments">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<variableReferenceExpression name="fileName"/>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<comment>send report data to the client</comment>
										<methodInvokeExpression methodName="Clear">
											<target>
												<propertyReferenceExpression name="Response">
													<argumentReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</target>
										</methodInvokeExpression>
										<assignStatement>
											<propertyReferenceExpression name="ContentType">
												<propertyReferenceExpression name="Response">
													<argumentReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="MimeType">
												<variableReferenceExpression name="report"/>
											</propertyReferenceExpression>
										</assignStatement>
										<methodInvokeExpression methodName="AddHeader">
											<target>
												<propertyReferenceExpression name="Response">
													<argumentReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<primitiveExpression value="Content-Length"/>
												<methodInvokeExpression methodName="ToString">
													<target>
														<propertyReferenceExpression name="Length">
															<propertyReferenceExpression name="Data">
																<variableReferenceExpression name="report"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendDownloadTokenCookie"/>
										<methodInvokeExpression methodName="AddHeader">
											<target>
												<propertyReferenceExpression name="Response">
													<argumentReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<primitiveExpression value="Content-Disposition"/>
												<stringFormatExpression format="attachment;filename={{0}}">
													<variableReferenceExpression name="fileName"/>
												</stringFormatExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Write">
											<target>
												<propertyReferenceExpression name="OutputStream">
													<propertyReferenceExpression name="Response">
														<argumentReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="Data">
													<variableReferenceExpression name="report"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
												<propertyReferenceExpression name="Length">
													<propertyReferenceExpression name="Data">
														<variableReferenceExpression name="report"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method Render(PagerRequest, DataTable, string, string) -->
						<memberMethod returnType="ReportData" name="Render">
							<attributes family="true"/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="DataTable" name="table"/>
								<parameter type="System.String" name="reportTemplate"/>
								<parameter type="System.String" name="reportFormat"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property IsReusable -->
						<memberProperty type="System.Boolean" name="IsReusable" privateImplementationType="IHttpHandler">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method FormatFileName-->
						<memberMethod returnType="System.String" name="FormatFileName">
							<attributes family="true"/>
							<parameters>
								<parameter type="HttpContext" name="context"/>
								<parameter type="PageRequest" name="request"/>
								<parameter type="System.String" name="extension"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Exeucte(ReportArgs) -->
						<memberMethod returnType="System.Byte[]" name="Execute">
							<comment>
								<![CDATA[
        /// <summary>
        /// Generates a report using the default or custom report template with optional sort expression and filter applied to the dataset.
        /// </summary>
        /// <param name="args">A collection of parameters that control the report generation.</param>
        /// <returns>A binary array representing the report data.</returns>
              ]]>
							</comment>
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="ReportArgs" name="args"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Execute">
										<parameters>
											<argumentReferenceExpression name="args"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Exeucte(ReportArgs, ActionArgs executeArgs) -->
						<memberMethod returnType="System.Byte[]" name="Execute">
							<comment>
								<![CDATA[
        /// <summary>
        /// Generates a report using the default or custom report template with optional sort expression and filter applied to the dataset.
        /// </summary>
        /// <param name="args">A collection of parameters that control the report generation.</param>
        /// <returns>A binary array representing the report data.</returns>
              ]]>
							</comment>
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="ReportArgs" name="args"/>
								<parameter type="ActionArgs" name="executeArgs"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="Stream" name="output">
									<init>
										<objectCreateExpression type="MemoryStream"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="PageRequest" name="request">
									<init>
										<objectCreateExpression type="PageRequest"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Controller">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="Controller">
										<argumentReferenceExpression name="args"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="View">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="View">
										<argumentReferenceExpression name="args"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="SortExpression">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="SortExpression">
										<argumentReferenceExpression name="args"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Filter">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="FilterRaw">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
								</assignStatement>
								<variableDeclarationStatement type="ReportBase" name="reportHandler">
									<init>
										<castExpression targetType="ReportBase">
											<methodInvokeExpression methodName="CreateInstance">
												<target>
													<typeReferenceExpression type="ApplicationServices"/>
												</target>
												<parameters>
													<primitiveExpression value="{$Namespace}.Handlers.Report"/>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="OutputStream">
										<variableReferenceExpression name="reportHandler"/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="output"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Arguments">
										<variableReferenceExpression name="reportHandler"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="args"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Request">
										<variableReferenceExpression name="reportHandler"/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="request"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="ExecuteArgs">
										<variableReferenceExpression name="reportHandler"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="executeArgs"/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator ="IdentityInequality">
											<propertyReferenceExpression name="Filter">
												<argumentReferenceExpression name="args"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="DataViewExtender" name="dve">
											<init>
												<objectCreateExpression type="DataViewExtender"/>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="AssignStartupFilter">
											<target>
												<variableReferenceExpression name="dve"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Filter">
													<argumentReferenceExpression name="args"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<propertyReferenceExpression name="Filter">
												<variableReferenceExpression name="request"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToArray">
												<target>
													<castExpression targetType="List">
														<typeArguments>
															<typeReference type="System.String"/>
														</typeArguments>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Properties">
																	<variableReferenceExpression name="dve"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="StartupFilter"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="ProcessRequest">
									<target>
										<castExpression targetType="IHttpHandler">
											<variableReferenceExpression name="reportHandler"/>
										</castExpression>
									</target>
									<parameters>
										<propertyReferenceExpression name="Current">
											<typeReferenceExpression type="HttpContext"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<comment>return report data</comment>
								<assignStatement>
									<propertyReferenceExpression name="Position">
										<variableReferenceExpression name="output"/>
									</propertyReferenceExpression>
									<primitiveExpression value="0"/>
								</assignStatement>
								<variableDeclarationStatement type="System.Byte[]" name="data">
									<init>
										<arrayCreateExpression>
											<createType type="System.Byte"/>
											<sizeExpression>
												<propertyReferenceExpression name="Length">
													<variableReferenceExpression name="output"/>
												</propertyReferenceExpression>
											</sizeExpression>
										</arrayCreateExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Read">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
									<parameters>
										<variableReferenceExpression name="data"/>
										<primitiveExpression value="0"/>
										<propertyReferenceExpression name="Length">
											<variableReferenceExpression name="data"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<variableReferenceExpression name="data"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property DefaultDeviceInfo -->
						<memberProperty type="System.String" name="DefaultDeviceInfo">
							<attributes family="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[<DeviceInfo><EmbedFonts>True</EmbedFonts></DeviceInfo>]]></xsl:attribute>
									</primitiveExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
