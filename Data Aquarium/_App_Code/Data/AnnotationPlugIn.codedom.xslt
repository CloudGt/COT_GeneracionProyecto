<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="/">
		<compileUnit namespace="{a:project/a:namespace}.Data">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Data.Common"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Xml"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Configuration"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="{a:project/a:namespace}.Handlers"/>
			</imports>
			<types>
				<!-- class AnnotationPlugIn -->
				<typeDeclaration name="AnnotationPlugIn">
					<baseTypes>
						<typeReference type="System.Object"/>
						<typeReference type="IPlugIn"/>
					</baseTypes>
					<members>
						<memberField type="ControllerConfiguration" name="config"/>
						<memberField type="List" name="annotations">
							<typeArguments>
								<typeReference type="FieldValue"/>
							</typeArguments>
						</memberField>
						<memberField type="System.Boolean" name="retrieveAnnotations"/>
						<memberField type="System.Boolean" name="requireProcessing"/>
						<!-- static constructor() -->
						<typeConstructor>
							<statements>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Handlers">
											<typeReferenceExpression type="BlobFactory"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<primitiveExpression value="AnnotationPlugIn"/>
										<objectCreateExpression type="AnnotationBlobHandler"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</typeConstructor>
						<!-- property AnnotationsPath -->
						<memberProperty type="System.String" name="AnnotationsPath">
							<attributes public="true" static="true"/>
							<getStatements>
								<variableDeclarationStatement type="System.String" name="p">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="AppSettings">
													<typeReferenceExpression type="WebConfigurationManager"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="AnnotationsPath"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="p"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="p"/>
											<methodInvokeExpression methodName="Combine">
												<target>
													<typeReferenceExpression type="Path"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="PhysicalApplicationPath">
														<propertyReferenceExpression name="Request">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="App_Data"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="p"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- string GenerateDataRecordPath() -->
						<memberMethod returnType="System.String" name="GenerateDataRecordPath">
							<attributes public="true" static="true"/>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GenerateDataRecordPath">
										<parameters>
											<primitiveExpression value="null"/>
											<primitiveExpression value="null"/>
											<primitiveExpression value="null"/>
											<primitiveExpression value="0"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- string GenerateDataRecordPath(string, ViewPage, FieldValue[]) -->
						<memberMethod returnType="System.String" name="GenerateDataRecordPath">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="ViewPage" name="page"/>
								<parameter type="FieldValue[]" name="values"/>
								<parameter type="System.Int32" name="rowIndex"/>
							</parameters>
							<statements>
								<comment>Sample path:</comment>
								<comment>[Documents]\Code OnTime\Projects\Web Site Factory\Annotations\App_Data\OrderDetails\10248,11</comment>
								<comment>Sample URL parameter:</comment>
								<comment>u|OrderDetails,_Annotation_AttachmentNew|10248|11</comment>
								<variableDeclarationStatement type="System.String" name="p">
									<init>
										<propertyReferenceExpression name="AnnotationsPath">
											<typeReferenceExpression type="AnnotationPlugIn"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<argumentReferenceExpression name="controller"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String" name="handlerInfo">
											<init>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Request">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="AnnotationPlugIn"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="Match" name="m">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="handlerInfo"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[^((t|o|u)\|){0,1}\w+\|(\w+).+?\|(.+)?$]]></xsl:attribute>
														</primitiveExpression>
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
													<variableReferenceExpression name="p"/>
													<methodInvokeExpression methodName="Combine">
														<target>
															<typeReferenceExpression type="Path"/>
														</target>
														<parameters>
															<variableReferenceExpression name="p"/>
															<propertyReferenceExpression name="Value">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Groups">
																			<variableReferenceExpression name="m"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="3"/>
																	</indices>
																</arrayIndexerExpression>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="p"/>
													<methodInvokeExpression methodName="Combine">
														<target>
															<typeReferenceExpression type="Path"/>
														</target>
														<parameters>
															<variableReferenceExpression name="p"/>
															<methodInvokeExpression methodName="Replace">
																<target>
																	<propertyReferenceExpression name="Value">
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups">
																					<variableReferenceExpression name="m"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="4"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="|"/>
																	<primitiveExpression value=","/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<variableReferenceExpression name="p"/>
											<methodInvokeExpression methodName="Combine">
												<target>
													<typeReferenceExpression type="Path"/>
												</target>
												<parameters>
													<variableReferenceExpression name="p"/>
													<argumentReferenceExpression name="controller"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<variableDeclarationStatement type="System.String" name="keys">
											<init>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="DataField" name="field"/>
											<target>
												<propertyReferenceExpression name="Fields">
													<argumentReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="IsPrimaryKey">
															<variableReferenceExpression name="field"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.String" name="keyValue">
															<init>
																<primitiveExpression value="null"/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityEquality">
																	<variableReferenceExpression name="values"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="keyValue"/>
																	<convertExpression to="String">
																		<arrayIndexerExpression>
																			<target>
																				<arrayIndexerExpression>
																					<target>
																						<propertyReferenceExpression name="Rows">
																							<argumentReferenceExpression name="page"/>
																						</propertyReferenceExpression>
																					</target>
																					<indices>
																						<argumentReferenceExpression name="rowIndex"/>
																					</indices>
																				</arrayIndexerExpression>
																			</target>
																			<indices>
																				<methodInvokeExpression methodName="IndexOf">
																					<target>
																						<propertyReferenceExpression name="Fields">
																							<argumentReferenceExpression name="page"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="field"/>
																					</parameters>
																				</methodInvokeExpression>
																			</indices>
																		</arrayIndexerExpression>
																	</convertExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<foreachStatement>
																	<variable type="FieldValue" name="v"/>
																	<target>
																		<variableReferenceExpression name="values"/>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<propertyReferenceExpression name="Name">
																						<variableReferenceExpression name="v"/>
																					</propertyReferenceExpression>
																					<propertyReferenceExpression name="Name">
																						<variableReferenceExpression name="field"/>
																					</propertyReferenceExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="keyValue"/>
																					<convertExpression to="String">
																						<propertyReferenceExpression name="Value">
																							<variableReferenceExpression name="v"/>
																						</propertyReferenceExpression>
																					</convertExpression>
																				</assignStatement>
																				<breakStatement/>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
															</falseStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="GreaterThan">
																	<propertyReferenceExpression name="Length">
																		<variableReferenceExpression name="keys"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="keys"/>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="keys"/>
																		<primitiveExpression value=","/>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<assignStatement>
															<variableReferenceExpression name="keys"/>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="keys"/>
																<methodInvokeExpression methodName="Trim">
																	<target>
																		<variableReferenceExpression name="keyValue"/>
																	</target>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<assignStatement>
											<variableReferenceExpression name="p"/>
											<methodInvokeExpression methodName="Combine">
												<target>
													<typeReferenceExpression type="Path"/>
												</target>
												<parameters>
													<variableReferenceExpression name="p"/>
													<variableReferenceExpression name="keys"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="p"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property IPlugIn.Config -->
						<memberProperty type="ControllerConfiguration" name="Config" privateImplementationType="IPlugIn">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="config"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="config"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- ControllerConfiguration IPlugIn.Create(ControllerConfiguration) -->
						<memberMethod returnType="ControllerConfiguration" name="Create" privateImplementationType="IPlugIn">
							<attributes/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="CanEdit">
											<propertyReferenceExpression name="Navigator">
												<argumentReferenceExpression name="config"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<argumentReferenceExpression name="config"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="XmlDocument" name="document">
									<init>
										<objectCreateExpression type="XmlDocument"/>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="LoadXml">
									<target>
										<variableReferenceExpression name="document"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="OuterXml">
											<propertyReferenceExpression name="Navigator">
												<argumentReferenceExpression name="config"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<objectCreateExpression type="ControllerConfiguration">
										<parameters>
											<methodInvokeExpression methodName="CreateNavigator">
												<target>
													<variableReferenceExpression name="document"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property Fields -->
						<memberField type="XPathNavigator" name="fields"/>
						<memberProperty type="XPathNavigator" name="Fields">
							<attributes family="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="fields"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="fields"/>
											<methodInvokeExpression methodName="SelectSingleNode">
												<target>
													<fieldReferenceExpression name="config"/>
												</target>
												<parameters>
													<primitiveExpression value="/c:dataController/c:fields"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="fields"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property KeyFields -->
						<memberProperty type="System.String" name="KeyFields">
							<attributes public="true" family="true"/>
							<getStatements>
								<variableDeclarationStatement type="System.String" name="kf">
									<init>
										<propertyReferenceExpression name="Empty">
											<typeReferenceExpression type="String"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="XPathNodeIterator" name="iterator">
									<init>
										<methodInvokeExpression methodName="Select">
											<target>
												<propertyReferenceExpression name="Fields"/>
											</target>
											<parameters>
												<primitiveExpression value="c:field[@isPrimaryKey='true']/@name"/>
												<propertyReferenceExpression name="Resolver">
													<fieldReferenceExpression name="config"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<methodInvokeExpression methodName="MoveNext">
											<target>
												<variableReferenceExpression name="iterator"/>
											</target>
										</methodInvokeExpression>
									</test>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="kf"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="kf"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="kf"/>
														<primitiveExpression value=","/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="kf"/>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="kf"/>
												<propertyReferenceExpression name="Value">
													<propertyReferenceExpression name="Current">
														<variableReferenceExpression name="iterator"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</assignStatement>
									</statements>
								</whileStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="kf"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- void IPlugIn.PreProcessPageRequest(PageRequest, ViewPage) -->
						<memberMethod name="PreProcessPageRequest" privateImplementationType="IPlugIn">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="XPathNavigator" name="view">
									<init>
										<methodInvokeExpression methodName="SelectSingleNode">
											<target>
												<fieldReferenceExpression name="config"/>
											</target>
											<parameters>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[//c:view[@id='{0}' and @type='Form']/c:categories]]></xsl:attribute>
												</primitiveExpression>
												<propertyReferenceExpression name="View">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
												<!--<methodInvokeExpression methodName="Format">
                          <target>
                            <typeReferenceExpression type="String"/>
                          </target>
                          <parameters>
                            <primitiveExpression>
                              <xsl:attribute name="value"><![CDATA[//c:view[@id='{0}' and @type='Form']/c:categories]]></xsl:attribute>
                            </primitiveExpression>
                            <propertyReferenceExpression name="View">
                              <argumentReferenceExpression name="request"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <propertyReferenceExpression name="Resolver">
                          <fieldReferenceExpression name="config"/>
                        </propertyReferenceExpression>-->
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="view"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<!--<binaryOperatorExpression operator="BooleanAnd">
                        <unaryOperatorExpression operator="Not">
                          <propertyReferenceExpression name="IsModal">
                            <argumentReferenceExpression name="request"/>
                          </propertyReferenceExpression>
                        </unaryOperatorExpression>
                        <binaryOperatorExpression operator="GreaterThan">
                          <propertyReferenceExpression name="PageSize">
                            <argumentReferenceExpression name="request"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>-->
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="PageSize">
														<argumentReferenceExpression name="request"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="BooleanAnd">
													<unaryOperatorExpression operator="Not">
														<propertyReferenceExpression name="Inserting">
															<argumentReferenceExpression name="request"/>
														</propertyReferenceExpression>
													</unaryOperatorExpression>
													<!-- (m_Config.SelectSingleNode("/c:dataController/c:fields/c:field[@name='_Annotation_NoteNew']") Is Nothing -->
													<binaryOperatorExpression operator="IdentityEquality">
														<methodInvokeExpression methodName="SelectSingleNode">
															<target>
																<fieldReferenceExpression name="config"/>
															</target>
															<parameters>
																<primitiveExpression value="/c:dataController/c:fields/c:field[@name='_Annotation_NoteNew']"/>
															</parameters>
														</methodInvokeExpression>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="requireProcessing"/>
											<primitiveExpression value="true"/>
										</assignStatement>
										<variableDeclarationStatement type="System.String" name="ns">
											<init>
												<propertyReferenceExpression name="Namespace">
													<typeReferenceExpression type="ControllerConfiguration"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="List" name="expressions">
											<typeArguments>
												<typeReference type="DynamicExpression"/>
											</typeArguments>
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="DynamicExpression"/>
													</typeArguments>
													<parameters>
														<propertyReferenceExpression name="Expressions">
															<fieldReferenceExpression name="config"/>
														</propertyReferenceExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<comment>create NewXXX fields under "fields" node</comment>
										<variableDeclarationStatement type="StringBuilder" name="sb">
											<init>
												<objectCreateExpression type="StringBuilder"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="XmlWriterSettings" name="settings">
											<init>
												<objectCreateExpression type="XmlWriterSettings"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="ConformanceLevel">
												<variableReferenceExpression name="settings"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="Fragment">
												<typeReferenceExpression type="ConformanceLevel"/>
											</propertyReferenceExpression>
										</assignStatement>
										<variableDeclarationStatement type="XmlWriter" name="writer">
											<init>
												<methodInvokeExpression methodName="Create">
													<target>
														<typeReferenceExpression type="XmlWriter"/>
													</target>
													<parameters>
														<variableReferenceExpression name="sb"/>
														<variableReferenceExpression name="settings"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<comment>NoteNew field</comment>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="field"/>
												<variableReferenceExpression name="ns"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="name"/>
												<primitiveExpression value="_Annotation_NoteNew"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="type"/>
												<primitiveExpression value="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="allowSorting"/>
												<primitiveExpression value="false" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="allowQBE"/>
												<primitiveExpression value="false" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="label"/>
												<methodInvokeExpression methodName="Replace">
													<target>
														<typeReferenceExpression type="Localizer"/>
													</target>
													<parameters>
														<primitiveExpression value="AnnotationNoteNewFieldLabel"/>
														<primitiveExpression value="Notes"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="computed"/>
												<primitiveExpression value="true" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteElementString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="formula"/>
												<variableReferenceExpression name="ns"/>
												<primitiveExpression value="null" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<variableDeclarationStatement type="DynamicExpression" name="de">
											<init>
												<objectCreateExpression type="DynamicExpression"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="Target">
												<variableReferenceExpression name="de"/>
											</propertyReferenceExpression>
											<primitiveExpression value="_Annotation_NoteNew"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Scope">
												<variableReferenceExpression name="de"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="DataFieldVisibility">
												<typeReferenceExpression type="DynamicExpressionScope"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Type">
												<variableReferenceExpression name="de"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="ClientScript">
												<typeReferenceExpression type="DynamicExpressionType"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Test">
												<variableReferenceExpression name="de"/>
											</propertyReferenceExpression>
											<primitiveExpression value="this.get_isEditing()"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="ViewId">
												<variableReferenceExpression name="de"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="View">
												<argumentReferenceExpression name="request"/>
											</propertyReferenceExpression>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="expressions"/>
											</target>
											<parameters>
												<variableReferenceExpression name="de"/>
											</parameters>
										</methodInvokeExpression>
										<comment>AttachmentNew field</comment>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="field"/>
												<variableReferenceExpression name="ns"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="name"/>
												<primitiveExpression value="_Annotation_AttachmentNew"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="type"/>
												<primitiveExpression value="Byte[]"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="onDemand"/>
												<primitiveExpression value="true" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="sourceFields"/>
												<propertyReferenceExpression name="KeyFields">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="onDemandHandler"/>
												<primitiveExpression value="AnnotationPlugIn"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="allowQBE"/>
												<primitiveExpression value="false" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="allowSorting"/>
												<primitiveExpression value="false" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="label"/>
												<methodInvokeExpression methodName="Replace">
													<target>
														<typeReferenceExpression type="Localizer"/>
													</target>
													<parameters>
														<primitiveExpression value="AnnotationAttachmentNewFieldLabel"/>
														<primitiveExpression value="Attachment"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="computed"/>
												<primitiveExpression value="true" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteElementString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="formula"/>
												<variableReferenceExpression name="ns"/>
												<primitiveExpression value="null" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Close">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendChild">
											<target>
												<propertyReferenceExpression name="Fields">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<methodInvokeExpression methodName="ToString">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<variableDeclarationStatement type="DynamicExpression" name="ade">
											<init>
												<objectCreateExpression type="DynamicExpression"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="Target">
												<variableReferenceExpression name="ade"/>
											</propertyReferenceExpression>
											<primitiveExpression value="_Annotation_AttachmentNew"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Scope">
												<variableReferenceExpression name="ade"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="DataFieldVisibility">
												<typeReferenceExpression type="DynamicExpressionScope"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Type">
												<variableReferenceExpression name="ade"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="ClientScript">
												<typeReferenceExpression type="DynamicExpressionType"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Test">
												<variableReferenceExpression name="ade"/>
											</propertyReferenceExpression>
											<primitiveExpression value="this.get_isEditing()"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="ViewId">
												<variableReferenceExpression name="ade"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="View">
												<argumentReferenceExpression name="request"/>
											</propertyReferenceExpression>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="expressions"/>
											</target>
											<parameters>
												<variableReferenceExpression name="ade"/>
											</parameters>
										</methodInvokeExpression>
										<comment>create NewXXX data fields under "view/dataFields" node</comment>
										<assignStatement>
											<variableReferenceExpression name="sb"/>
											<objectCreateExpression type="StringBuilder"/>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="writer"/>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="XmlWriter"/>
												</target>
												<parameters>
													<variableReferenceExpression name="sb"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="category"/>
												<variableReferenceExpression name="ns"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="id"/>
												<primitiveExpression value="Annotations"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="headerText"/>
												<methodInvokeExpression methodName="Replace">
													<target>
														<typeReferenceExpression type="Localizer"/>
													</target>
													<parameters>
														<primitiveExpression value="AnnotationCategoryHeaderText"/>
														<primitiveExpression value="Notes and Attachments"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteElementString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="description"/>
												<variableReferenceExpression name="ns"/>
												<methodInvokeExpression methodName="Replace">
													<target>
														<typeReferenceExpression type="Localizer"/>
													</target>
													<parameters>
														<primitiveExpression value="AnnotationCategoryDescription"/>
														<primitiveExpression value="Enter optional notes and attach files."/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="dataFields"/>
												<variableReferenceExpression name="ns"/>
											</parameters>
										</methodInvokeExpression>
										<comment>_Annotation_NoteNew dataField</comment>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="dataField"/>
												<variableReferenceExpression name="ns"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="fieldName"/>
												<primitiveExpression value="_Annotation_NoteNew"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="columns"/>
												<primitiveExpression value="50" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="rows"/>
												<primitiveExpression value="7" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<comment>_Annotation_AttachmentNew</comment>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="dataField"/>
												<variableReferenceExpression name="ns"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="fieldName"/>
												<primitiveExpression value="_Annotation_AttachmentNew"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Close">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendChild">
											<target>
												<variableReferenceExpression name="view"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="ToString">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<fieldReferenceExpression name="retrieveAnnotations"/>
											<unaryOperatorExpression operator="Not">
												<propertyReferenceExpression name="Inserting">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</unaryOperatorExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Expressions">
												<fieldReferenceExpression name="config"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToArray">
												<target>
													<variableReferenceExpression name="expressions"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- void IPlugIn.ProcessPageRequest(PageRequest, ViewPage) -->
						<memberMethod name="ProcessPageRequest" privateImplementationType="IPlugIn">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="Count">
												<propertyReferenceExpression name="Rows">
													<argumentReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Icons">
												<argumentReferenceExpression name="page"/>
											</propertyReferenceExpression>
											<arrayCreateExpression>
												<createType type="System.String"/>
											</arrayCreateExpression>
										</assignStatement>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<fieldReferenceExpression name="requireProcessing"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="List" name="icons">
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
														<propertyReferenceExpression name="Rows">
															<argumentReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</test>
											<increment>
												<variableReferenceExpression name="i"/>
											</increment>
											<statements>
												<variableDeclarationStatement type="System.String" name="rowDir">
													<init>
														<methodInvokeExpression methodName="GenerateDataRecordPath">
															<target>
																<typeReferenceExpression type="AnnotationPlugIn"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Controller">
																	<argumentReferenceExpression name="request"/>
																</propertyReferenceExpression>
																<argumentReferenceExpression name="page"/>
																<primitiveExpression value="null"/>
																<variableReferenceExpression name="i"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Exists">
															<target>
																<typeReferenceExpression type="Directory"/>
															</target>
															<parameters>
																<variableReferenceExpression name="rowDir"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="icons"/>
															</target>
															<parameters>
																<primitiveExpression value="Attachment"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="icons"/>
															</target>
															<parameters>
																<primitiveExpression value="null"/>
															</parameters>
														</methodInvokeExpression>
													</falseStatements>
												</conditionStatement>
											</statements>
										</forStatement>
										<assignStatement>
											<propertyReferenceExpression name="Icons">
												<argumentReferenceExpression name="page"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToArray">
												<target>
													<variableReferenceExpression name="icons"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="List" name="expressions">
									<typeArguments>
										<typeReference type="DynamicExpression"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="DynamicExpression"/>
											</typeArguments>
											<parameters>
												<propertyReferenceExpression name="Expressions">
													<argumentReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="DynamicExpression" name="de">
									<init>
										<objectCreateExpression type="DynamicExpression"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Target">
										<variableReferenceExpression name="de"/>
									</propertyReferenceExpression>
									<primitiveExpression value="Annotations"/>
									<!--<methodInvokeExpression methodName="Replace">
                    <target>
                      <typeReferenceExpression type="Localizer"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="AnnotationCategoryHeaderText"/>
                      <primitiveExpression value="Notes and Attachments"/>
                    </parameters>
                  </methodInvokeExpression>-->
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Scope">
										<variableReferenceExpression name="de"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="CategoryVisibility">
										<typeReferenceExpression type="DynamicExpressionScope"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Type">
										<variableReferenceExpression name="de"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="ClientScript">
										<typeReferenceExpression type="DynamicExpressionType"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Test">
										<variableReferenceExpression name="de"/>
									</propertyReferenceExpression>
									<primitiveExpression value="!this.get_isInserting()"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="ViewId">
										<variableReferenceExpression name="de"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="View">
										<argumentReferenceExpression name="page"/>
									</propertyReferenceExpression>
								</assignStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<variableReferenceExpression name="expressions"/>
									</target>
									<parameters>
										<variableReferenceExpression name="de"/>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<propertyReferenceExpression name="Expressions">
										<argumentReferenceExpression name="page"/>
									</propertyReferenceExpression>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="expressions"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<fieldReferenceExpression name="retrieveAnnotations"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="DataField" name="field">
									<init>
										<methodInvokeExpression methodName="FindField">
											<target>
												<argumentReferenceExpression name="page"/>
											</target>
											<parameters>
												<primitiveExpression value="_Annotation_AttachmentNew"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="field"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.Int32" name="fieldIndex">
											<init>
												<methodInvokeExpression methodName="IndexOf">
													<target>
														<propertyReferenceExpression name="Fields">
															<argumentReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="field"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="newValue">
											<init>
												<methodInvokeExpression methodName="Format">
													<target>
														<typeReferenceExpression type="String"/>
													</target>
													<parameters>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[{0},{1}|{2}]]></xsl:attribute>
														</primitiveExpression>
														<propertyReferenceExpression name="Controller">
															<argumentReferenceExpression name="request"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="Name">
															<variableReferenceExpression name="field"/>
														</propertyReferenceExpression>
														<methodInvokeExpression methodName="Replace">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<castExpression targetType="System.String">
																	<arrayIndexerExpression>
																		<target>
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Rows">
																						<argumentReferenceExpression name="page"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="0"/>
																				</indices>
																			</arrayIndexerExpression>
																		</target>
																		<indices>
																			<variableReferenceExpression name="fieldIndex"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
																<primitiveExpression value="^\w+\|(.+)$"/>
																<primitiveExpression value="$1"/>
																<!--<propertyReferenceExpression name="Compiled">
                                  <typeReferenceExpression type="RegexOptions"/>
                                </propertyReferenceExpression>-->
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Name">
														<variableReferenceExpression name="field"/>
													</propertyReferenceExpression>
													<primitiveExpression value="_Annotation_AttachmentNew"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="newValue"/>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="null|"/>
														<variableReferenceExpression name="newValue"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Rows">
																<argumentReferenceExpression name="page"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="0"/>
														</indices>
													</arrayIndexerExpression>
												</target>
												<indices>
													<variableReferenceExpression name="fieldIndex"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="newValue"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.String" name="p">
									<init>
										<methodInvokeExpression methodName="GenerateDataRecordPath">
											<target>
												<typeReferenceExpression type="AnnotationPlugIn"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Controller">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
												<argumentReferenceExpression name="page"/>
												<primitiveExpression value="null"/>
												<primitiveExpression value="0"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Exists">
											<target>
												<typeReferenceExpression type="Directory"/>
											</target>
											<parameters>
												<variableReferenceExpression name="p"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String[]" name="files">
											<init>
												<methodInvokeExpression methodName="GetFiles">
													<target>
														<typeReferenceExpression type="Directory"/>
													</target>
													<parameters>
														<variableReferenceExpression name="p"/>
														<primitiveExpression value="*.xml"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="List" name="values">
											<typeArguments>
												<typeReference type="System.Object"/>
											</typeArguments>
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="System.Object"/>
													</typeArguments>
													<parameters>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Rows">
																	<argumentReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="0"/>
															</indices>
														</arrayIndexerExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Int32" name="i">
											<init>
												<binaryOperatorExpression operator="Subtract">
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="files"/>
													</propertyReferenceExpression>
													<primitiveExpression value="1"/>
												</binaryOperatorExpression>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<binaryOperatorExpression operator ="GreaterThanOrEqual">
													<variableReferenceExpression name="i"/>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</test>
											<statements>
												<variableDeclarationStatement type="System.String" name="filename">
													<init>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="files"/>
															</target>
															<indices>
																<variableReferenceExpression name="i"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="XPathDocument" name="doc">
													<init>
														<objectCreateExpression type="XPathDocument">
															<parameters>
																<variableReferenceExpression name="filename"/>
															</parameters>
														</objectCreateExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="XPathNavigator" name="nav">
													<init>
														<methodInvokeExpression methodName="SelectSingleNode">
															<target>
																<methodInvokeExpression methodName="CreateNavigator">
																	<target>
																		<variableReferenceExpression name="doc"/>
																	</target>
																</methodInvokeExpression>
															</target>
															<parameters>
																<primitiveExpression value="/*"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="DataField" name="f">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="nav"/>
															</propertyReferenceExpression>
															<primitiveExpression value="note"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="f"/>
															<objectCreateExpression type="DataField"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
															<primitiveExpression value="_Annotation_Note"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Type">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
															<primitiveExpression value="String"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="HeaderText">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
															<methodInvokeExpression methodName="Format">
																<target>
																	<typeReferenceExpression type="String"/>
																</target>
																<parameters>
																	<methodInvokeExpression methodName="Replace">
																		<target>
																			<typeReferenceExpression type="Localizer"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="AnnotationNoteDynamicFieldHeaderText"/>
																			<primitiveExpression>
																				<xsl:attribute  name="value"><![CDATA[{0} written at {1}]]></xsl:attribute>
																			</primitiveExpression>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="ReadNameAndEmail">
																		<parameters>
																			<variableReferenceExpression name="nav"/>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="ToDateTime">
																		<target>
																			<typeReferenceExpression type="Convert"/>
																		</target>
																		<parameters>
																			<methodInvokeExpression methodName="GetAttribute">
																				<target>
																					<variableReferenceExpression name="nav"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="timestamp"/>
																					<propertyReferenceExpression name="Empty">
																						<typeReferenceExpression type="String"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</parameters>
																	</methodInvokeExpression>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Columns">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
															<primitiveExpression value="50"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Rows">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
															<primitiveExpression value="7"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="TextMode">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Note">
																<typeReferenceExpression type="TextInputMode"/>
															</propertyReferenceExpression>
														</assignStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="values"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="nav"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="nav"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="attachment"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="f"/>
																	<objectCreateExpression type="DataField"/>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="f"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="_Annotation_Attachment"/>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="Type">
																		<variableReferenceExpression name="f"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="Byte[]"/>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="HeaderText">
																		<variableReferenceExpression name="f"/>
																	</propertyReferenceExpression>
																	<methodInvokeExpression methodName="Format">
																		<target>
																			<typeReferenceExpression type="String"/>
																		</target>
																		<parameters>
																			<methodInvokeExpression methodName="Replace">
																				<target>
																					<typeReferenceExpression type="Localizer"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="AnnotationAttachmentDynamicFieldHeaderText"/>
																					<primitiveExpression>
																						<xsl:attribute name="value"><![CDATA[{0} attached <b>{1}</b> at {2}]]></xsl:attribute>
																					</primitiveExpression>
																				</parameters>
																			</methodInvokeExpression>
																			<methodInvokeExpression methodName="ReadNameAndEmail">
																				<parameters>
																					<variableReferenceExpression name="nav"/>
																				</parameters>
																			</methodInvokeExpression>
																			<methodInvokeExpression methodName="GetAttribute">
																				<target>
																					<variableReferenceExpression name="nav"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="fileName"/>
																					<propertyReferenceExpression name="Empty">
																						<typeReferenceExpression type="String"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																			<methodInvokeExpression methodName="ToDateTime">
																				<target>
																					<typeReferenceExpression type="Convert"/>
																				</target>
																				<parameters>
																					<methodInvokeExpression methodName="GetAttribute">
																						<target>
																							<variableReferenceExpression name="nav"/>
																						</target>
																						<parameters>
																							<primitiveExpression value="timestamp"/>
																							<propertyReferenceExpression name="Empty">
																								<typeReferenceExpression type="String"/>
																							</propertyReferenceExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="OnDemand">
																		<variableReferenceExpression name="f"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="true" />
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="OnDemandHandler">
																		<variableReferenceExpression name="f"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="AnnotationPlugIn"/>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="OnDemandStyle">
																		<variableReferenceExpression name="f"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="Link">
																		<typeReferenceExpression type="OnDemandDisplayStyle"/>
																	</propertyReferenceExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="StartsWith">
																			<target>
																				<methodInvokeExpression methodName="GetAttribute">
																					<target>
																						<variableReferenceExpression name="nav"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="contentType"/>
																						<propertyReferenceExpression name="Empty">
																							<typeReferenceExpression type="String"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</target>
																			<parameters>
																				<primitiveExpression value="image/"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="OnDemandStyle">
																				<variableReferenceExpression name="f"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="Thumbnail">
																				<typeReferenceExpression type="OnDemandDisplayStyle"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<assignStatement>
																	<propertyReferenceExpression name="CategoryIndex">
																		<variableReferenceExpression name="f"/>
																	</propertyReferenceExpression>
																	<binaryOperatorExpression operator="Subtract">
																		<propertyReferenceExpression name="Count">
																			<propertyReferenceExpression name="Categories">
																				<argumentReferenceExpression name="page"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																		<primitiveExpression value="1"/>
																	</binaryOperatorExpression>
																</assignStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="values"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="GetAttribute">
																			<target>
																				<variableReferenceExpression name="nav"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="value"/>
																				<propertyReferenceExpression name="Empty">
																					<typeReferenceExpression type="String"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<variableReferenceExpression name="f"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="Add">
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="f"/>
																</propertyReferenceExpression>
																<methodInvokeExpression methodName="GetFileNameWithoutExtension">
																	<target>
																		<typeReferenceExpression type="Path"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="filename"/>
																	</parameters>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="AllowNulls">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
															<primitiveExpression value="true" />
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="CategoryIndex">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="Subtract">
																<propertyReferenceExpression name="Count">
																	<propertyReferenceExpression name="Categories">
																		<argumentReferenceExpression name="page"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
																<primitiveExpression value="1"/>
															</binaryOperatorExpression>
														</assignStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="UserIsInRole">
																		<target>
																			<typeReferenceExpression type="Controller"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="Administrators"/>
																		</parameters>
																	</methodInvokeExpression>
																	<!--<methodInvokeExpression methodName="IsInRole">
                                    <target>
                                      <propertyReferenceExpression name="User">
                                        <propertyReferenceExpression name="Current">
                                          <typeReferenceExpression type="HttpContext"/>
                                        </propertyReferenceExpression>
                                      </propertyReferenceExpression>
                                    </target>
                                    <parameters>
                                      <primitiveExpression value="Administrators"/>
                                    </parameters>
                                  </methodInvokeExpression>-->
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="ReadOnly">
																		<variableReferenceExpression name="f"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="true"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<propertyReferenceExpression name="Fields">
																	<argumentReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="f"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="i"/>
													<binaryOperatorExpression operator="Subtract">
														<variableReferenceExpression name="i"/>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</assignStatement>
											</statements>
										</whileStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Rows">
														<argumentReferenceExpression name="page"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="0"/>
												</indices>
											</arrayIndexerExpression>
											<methodInvokeExpression methodName="ToArray">
												<target>
													<variableReferenceExpression name="values"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="files"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Tab">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Categories">
																	<argumentReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<binaryOperatorExpression operator="Subtract">
																	<propertyReferenceExpression name="Count">
																		<propertyReferenceExpression name="Categories">
																			<argumentReferenceExpression name="page"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																	<primitiveExpression value="1"/>
																</binaryOperatorExpression>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="Replace">
														<target>
															<typeReferenceExpression type="Localizer"/>
														</target>
														<parameters>
															<primitiveExpression value="AnnotationTab"/>
															<primitiveExpression value="Notes &amp; Attachments"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<methodInvokeExpression methodName="RemoveAt">
													<target>
														<variableReferenceExpression name="expressions"/>
													</target>
													<parameters>
														<binaryOperatorExpression operator="Subtract">
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="expressions"/>
															</propertyReferenceExpression>
															<primitiveExpression value="1"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
												<assignStatement>
													<propertyReferenceExpression name="Expressions">
														<argumentReferenceExpression name="page"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="ToArray">
														<target>
															<variableReferenceExpression name="expressions"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<propertyReferenceExpression name="Test">
												<variableReferenceExpression name="de"/>
											</propertyReferenceExpression>
											<primitiveExpression value="this.get_isEditing() &amp;&amp; this.get_view()._displayAnnotations"/>
										</assignStatement>
										<variableDeclarationStatement type="ActionGroup" name="g">
											<init>
												<objectCreateExpression type="ActionGroup"/>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="ActionGroups">
													<argumentReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="g"/>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<propertyReferenceExpression name="Scope">
												<variableReferenceExpression name="g"/>
											</propertyReferenceExpression>
											<primitiveExpression value="ActionBar"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Flat">
												<variableReferenceExpression name="g"/>
											</propertyReferenceExpression>
											<primitiveExpression value="true"/>
										</assignStatement>
										<variableDeclarationStatement type="Action" name="a">
											<init>
												<objectCreateExpression type="Action"/>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Actions">
													<variableReferenceExpression name="g"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="a"/>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<propertyReferenceExpression name="WhenLastCommandName">
												<variableReferenceExpression name="a"/>
											</propertyReferenceExpression>
											<primitiveExpression value="Edit"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="WhenView">
												<variableReferenceExpression name="a"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="View">
												<argumentReferenceExpression name="page"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="CommandName">
												<variableReferenceExpression name="a"/>
											</propertyReferenceExpression>
											<primitiveExpression value="ClientScript"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="CommandArgument">
												<variableReferenceExpression name="a"/>
											</propertyReferenceExpression>
											<primitiveExpression value="this.get_view()._displayAnnotations=true;this._focusedFieldName = '_Annotation_NoteNew';this._raiseSelectedDelayed=false;"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="HeaderText">
												<variableReferenceExpression name="a"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Localizer"/>
												</target>
												<parameters>
													<primitiveExpression value="AnnotationActionHeaderText"/>
													<primitiveExpression value="Annotate"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="CssClass">
												<variableReferenceExpression name="a"/>
											</propertyReferenceExpression>
											<primitiveExpression value="AttachIcon"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="WhenClientScript">
												<variableReferenceExpression name="a"/>
											</propertyReferenceExpression>
											<primitiveExpression value="this.get_view()._displayAnnotations!=true;"/>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ReadNameAndEmail(XPathNavigator) -->
						<memberMethod returnType="System.String" name="ReadNameAndEmail">
							<attributes private="true"/>
							<parameters>
								<parameter type="XPathNavigator" name="nav"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="userName">
									<init>
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="nav"/>
											</target>
											<parameters>
												<primitiveExpression value="username"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="email">
									<init>
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="nav"/>
											</target>
											<parameters>
												<primitiveExpression value="email"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="email"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<variableReferenceExpression name="userName"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<stringFormatExpression>
										<xsl:attribute name="format"><![CDATA[<a href="mailto:{0}" title="{0}" target="_blank">{1}</a>]]></xsl:attribute>
										<variableReferenceExpression name="email"/>
										<variableReferenceExpression name="userName"/>
									</stringFormatExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property UserEmail -->
						<memberProperty type="System.String" name="UserEmail">
							<attributes public="true" static="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IsTypeOf">
											<propertyReferenceExpression name="Identity">
												<propertyReferenceExpression name="User">
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="HttpContext"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<typeReferenceExpression type="System.Security.Principal.WindowsIdentity"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
									<falseStatements>
										<variableDeclarationStatement type="MembershipUser" name="user">
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
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="user"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<propertyReferenceExpression name="Email">
												<variableReferenceExpression name="user"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</falseStatements>
								</conditionStatement>
							</getStatements>
						</memberProperty>
						<!-- void IPlugIn.PreProcessArguments(ActionArgs, ActionResult, ViewPage) -->
						<memberMethod name="PreProcessArguments" privateImplementationType="IPlugIn">
							<attributes/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="annotations"/>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="FieldValue"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Values">
												<argumentReferenceExpression name="args"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="FieldValue" name="v"/>
											<target>
												<propertyReferenceExpression name="Values">
													<argumentReferenceExpression name="args"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<methodInvokeExpression methodName="StartsWith">
																<target>
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="v"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="_Annotation_"/>
																</parameters>
															</methodInvokeExpression>
															<propertyReferenceExpression name="Modified">
																<variableReferenceExpression name="v"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<fieldReferenceExpression name="annotations"/>
															</target>
															<parameters>
																<variableReferenceExpression name="v"/>
															</parameters>
														</methodInvokeExpression>
														<assignStatement>
															<propertyReferenceExpression name="Modified">
																<variableReferenceExpression name="v"/>
															</propertyReferenceExpression>
															<primitiveExpression value="false"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- void IPlugIn.ProcessArguments(ActionArgs, ActionResult, ViewPage) -->
						<memberMethod name="ProcessArguments" privateImplementationType="IPlugIn">
							<attributes/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="Count">
												<fieldReferenceExpression name="annotations"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.String" name="p">
									<init>
										<methodInvokeExpression methodName="GenerateDataRecordPath">
											<target>
												<typeReferenceExpression type="AnnotationPlugIn"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Controller">
													<argumentReferenceExpression name="args"/>
												</propertyReferenceExpression>
												<argumentReferenceExpression name="page"/>
												<propertyReferenceExpression name="Values">
													<argumentReferenceExpression name="args"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="Exists">
												<target>
													<typeReferenceExpression type="Directory"/>
												</target>
												<parameters>
													<variableReferenceExpression name="p"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="CreateDirectory">
											<target>
												<typeReferenceExpression type="Directory"/>
											</target>
											<parameters>
												<variableReferenceExpression name="p"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<foreachStatement>
									<variable type="FieldValue" name="v"/>
									<target>
										<fieldReferenceExpression name="annotations"/>
									</target>
									<statements>
										<variableDeclarationStatement type="Match" name="m">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Name">
															<variableReferenceExpression name="v"/>
														</propertyReferenceExpression>
														<primitiveExpression value="^_Annotation_(Note)(New|\w+)$"/>
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
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
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
															<primitiveExpression value="Note"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.String" name="fileName">
															<init>
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
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="fileName"/>
																	<primitiveExpression value="New"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="fileName"/>
																	<methodInvokeExpression methodName="ToString">
																		<target>
																			<propertyReferenceExpression name="Now">
																				<typeReferenceExpression type="DateTime"/>
																			</propertyReferenceExpression>
																		</target>
																		<parameters>
																			<primitiveExpression value="u"/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
																<assignStatement>
																	<variableReferenceExpression name="fileName"/>
																	<methodInvokeExpression methodName="Replace">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="fileName"/>
																			<primitiveExpression value="[\W]"/>
																			<propertyReferenceExpression name="Empty">
																				<typeReferenceExpression type="String"/>
																			</propertyReferenceExpression>
																			<!--<propertyReferenceExpression name="Compiled">
                                        <typeReferenceExpression type="RegexOptions"/>
                                      </propertyReferenceExpression>-->
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<assignStatement>
															<variableReferenceExpression name="fileName"/>
															<methodInvokeExpression methodName="Combine">
																<target>
																	<typeReferenceExpression type="Path"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="p"/>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="fileName"/>
																		<primitiveExpression value=".xml"/>
																	</binaryOperatorExpression>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<methodInvokeExpression methodName="ToString">
																		<target>
																			<typeReferenceExpression type="Convert"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="NewValue">
																				<variableReferenceExpression name="v"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="XmlWriterSettings" name="settings">
																	<init>
																		<objectCreateExpression type="XmlWriterSettings"/>
																	</init>
																</variableDeclarationStatement>
																<assignStatement>
																	<propertyReferenceExpression name="CloseOutput">
																		<variableReferenceExpression name="settings"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="true"/>
																</assignStatement>
																<variableDeclarationStatement type="XmlWriter" name="writer">
																	<init>
																		<methodInvokeExpression methodName="Create">
																			<target>
																				<typeReferenceExpression type="XmlWriter"/>
																			</target>
																			<parameters>
																				<objectCreateExpression type="FileStream">
																					<parameters>
																						<variableReferenceExpression name="fileName"/>
																						<propertyReferenceExpression name="Create">
																							<typeReferenceExpression type="FileMode"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</objectCreateExpression>
																				<variableReferenceExpression name="settings"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<tryStatement>
																	<statements>
																		<methodInvokeExpression methodName="WriteStartElement">
																			<target>
																				<variableReferenceExpression name="writer"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="note"/>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="WriteAttributeString">
																			<target>
																				<variableReferenceExpression name="writer"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="timestamp"/>
																				<methodInvokeExpression methodName="ToString">
																					<target>
																						<propertyReferenceExpression name="Now">
																							<typeReferenceExpression type="DateTime"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<primitiveExpression value="o"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="WriteAttributeString">
																			<target>
																				<variableReferenceExpression name="writer"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="username"/>
																				<propertyReferenceExpression name="Name">
																					<propertyReferenceExpression name="Identity">
																						<propertyReferenceExpression name="User">
																							<propertyReferenceExpression name="Current">
																								<typeReferenceExpression type="HttpContext"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="WriteAttributeString">
																			<target>
																				<variableReferenceExpression name="writer"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="email"/>
																				<propertyReferenceExpression name="UserEmail">
																					<typeReferenceExpression type="AnnotationPlugIn"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="WriteString">
																			<target>
																				<variableReferenceExpression name="writer"/>
																			</target>
																			<parameters>
																				<methodInvokeExpression methodName="ToString">
																					<target>
																						<typeReferenceExpression type="Convert"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="NewValue">
																							<variableReferenceExpression name="v"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="WriteEndElement">
																			<target>
																				<variableReferenceExpression name="writer"/>
																			</target>
																		</methodInvokeExpression>
																	</statements>
																	<finally>
																		<methodInvokeExpression methodName="Close">
																			<target>
																				<variableReferenceExpression name="writer"/>
																			</target>
																		</methodInvokeExpression>
																	</finally>
																</tryStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="Delete">
																	<target>
																		<typeReferenceExpression type="File"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="fileName"/>
																	</parameters>
																</methodInvokeExpression>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="Length">
																				<methodInvokeExpression methodName="GetFiles">
																					<target>
																						<typeReferenceExpression type="Directory"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="p"/>
																					</parameters>
																				</methodInvokeExpression>
																			</propertyReferenceExpression>
																			<primitiveExpression value="0"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Delete">
																			<target>
																				<typeReferenceExpression type="Directory"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="p"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- type AnnotationBlobHandler -->
				<typeDeclaration name="AnnotationBlobHandler">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="BlobHandlerInfo"/>
					</baseTypes>
					<members>
						<!-- constructor() -->
						<constructor>
							<attributes public="true"/>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="Key">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<primitiveExpression value="AnnotationPlugIn"/>
								</assignStatement>
							</statements>
						</constructor>
						<!-- property Text-->
						<memberProperty type="System.String" name="Text">
							<attributes public="true" override="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="Attachment"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<propertyReferenceExpression name="Text">
										<baseReferenceExpression/>
									</propertyReferenceExpression>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- bool SaveFile(HttpContext, BlobAdapter, string) -->
						<memberMethod returnType="System.Boolean" name="SaveFile">
							<attributes public="true" override="true"/>
							<parameters>
								<parameter type="HttpContext" name="context"/>
								<parameter type="BlobAdapter" name="ba"/>
								<parameter type="System.String" name="keyValue"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<propertyReferenceExpression name="Count">
												<propertyReferenceExpression name="Files">
													<propertyReferenceExpression name="Request">
														<variableReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="1"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="HttpPostedFile" name="file">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Files">
													<propertyReferenceExpression name="Request">
														<argumentReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="0"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="p">
									<init>
										<methodInvokeExpression methodName="GenerateDataRecordPath">
											<target>
												<typeReferenceExpression type="AnnotationPlugIn"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="Exists">
												<target>
													<typeReferenceExpression type="Directory"/>
												</target>
												<parameters>
													<variableReferenceExpression name="p"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="CreateDirectory">
											<target>
												<typeReferenceExpression type="Directory"/>
											</target>
											<parameters>
												<variableReferenceExpression name="p"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<comment>u|OrderDetails,_Annotation_AttachmentNew|10248|11</comment>
								<variableDeclarationStatement type="Match" name="m">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Value">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
												<primitiveExpression value="_Annotation_Attachment(\w+)\|"/>
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
										<variableDeclarationStatement type="System.String" name="fileName">
											<init>
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
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="fileName"/>
													<primitiveExpression value="New"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="fileName"/>
													<methodInvokeExpression methodName="ToString">
														<target>
															<propertyReferenceExpression name="Now">
																<typeReferenceExpression type="DateTime"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="u"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="fileName"/>
													<methodInvokeExpression methodName="Replace">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<variableReferenceExpression name="fileName"/>
															<primitiveExpression value="[\W]"/>
															<propertyReferenceExpression name="Empty">
																<typeReferenceExpression type="String"/>
															</propertyReferenceExpression>
															<!--<propertyReferenceExpression name="Compiled">
                                <typeReferenceExpression type="RegexOptions"/>
                              </propertyReferenceExpression>-->
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Exists">
															<target>
																<typeReferenceExpression type="System.IO.File"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="Combine">
																	<target>
																		<typeReferenceExpression type="Path"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="p"/>
																		<binaryOperatorExpression operator="Add">
																			<variableReferenceExpression name="fileName"/>
																			<primitiveExpression value=".xml"/>
																		</binaryOperatorExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="fileName"/>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="fileName"/>
																<primitiveExpression value="_"/>
															</binaryOperatorExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="fileName"/>
											<methodInvokeExpression methodName="Combine">
												<target>
													<typeReferenceExpression type="Path"/>
												</target>
												<parameters>
													<variableReferenceExpression name="p"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="fileName"/>
														<primitiveExpression value=".xml"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="ContentLength">
														<variableReferenceExpression name="file"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable type="System.String" name="f"/>
													<target>
														<methodInvokeExpression methodName="GetFiles">
															<target>
																<typeReferenceExpression type="Directory"/>
															</target>
															<parameters>
																<variableReferenceExpression name="p"/>
																<binaryOperatorExpression operator="Add">
																	<methodInvokeExpression methodName="GetFileNameWithoutExtension">
																		<target>
																			<typeReferenceExpression type="Path"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="fileName"/>
																		</parameters>
																	</methodInvokeExpression>
																	<primitiveExpression value="*.*"/>
																</binaryOperatorExpression>
															</parameters>
														</methodInvokeExpression>
													</target>
													<statements>
														<methodInvokeExpression methodName="Delete">
															<target>
																<typeReferenceExpression type="System.IO.File"/>
															</target>
															<parameters>
																<variableReferenceExpression name="f"/>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
											</trueStatements>
											<falseStatements>
												<variableDeclarationStatement type="XmlWriterSettings" name="settings">
													<init>
														<objectCreateExpression type="XmlWriterSettings"/>
													</init>
												</variableDeclarationStatement>
												<assignStatement>
													<propertyReferenceExpression name="CloseOutput">
														<variableReferenceExpression name="settings"/>
													</propertyReferenceExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
												<variableDeclarationStatement type="XmlWriter" name="writer">
													<init>
														<methodInvokeExpression methodName="Create">
															<target>
																<typeReferenceExpression type="XmlWriter"/>
															</target>
															<parameters>
																<objectCreateExpression type="FileStream">
																	<parameters>
																		<variableReferenceExpression name="fileName"/>
																		<propertyReferenceExpression name="Create">
																			<typeReferenceExpression type="FileMode"/>
																		</propertyReferenceExpression>
																	</parameters>
																</objectCreateExpression>
																<variableReferenceExpression name="settings"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<tryStatement>
													<statements>
														<methodInvokeExpression methodName="WriteStartElement">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="attachment"/>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteAttributeString">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="timestamp"/>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<propertyReferenceExpression name="Now">
																			<typeReferenceExpression type="DateTime"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="o"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteAttributeString">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="username"/>
																<propertyReferenceExpression name="Name">
																	<propertyReferenceExpression name="Identity">
																		<propertyReferenceExpression name="User">
																			<propertyReferenceExpression name="Current">
																				<typeReferenceExpression type="HttpContext"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteAttributeString">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="email"/>
																<propertyReferenceExpression name="UserEmail">
																	<typeReferenceExpression type="AnnotationPlugIn"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteAttributeString">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="fileName"/>
																<methodInvokeExpression methodName="GetFileName">
																	<target>
																		<typeReferenceExpression type="Path"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="FileName">
																			<variableReferenceExpression name="file"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteAttributeString">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="contentType"/>
																<propertyReferenceExpression name="ContentType">
																	<variableReferenceExpression name="file"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteAttributeString">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="contentLength"/>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<propertyReferenceExpression name="ContentLength">
																			<variableReferenceExpression name="file"/>
																		</propertyReferenceExpression>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteAttributeString">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="value"/>
																<methodInvokeExpression methodName="Replace">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Value">
																			<thisReferenceExpression/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="^.+?\|([\w,]+?)_Annotation_Attachment(New|\w+)(.+)$"/>
																		<methodInvokeExpression methodName="Format">
																			<target>
																				<typeReferenceExpression type="String"/>
																			</target>
																			<parameters>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[1|$1_Annotation_Attachment{0}$3]]></xsl:attribute>
																				</primitiveExpression>
																				<methodInvokeExpression methodName="GetFileNameWithoutExtension">
																					<target>
																						<typeReferenceExpression type="Path"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="fileName"/>
																					</parameters>
																				</methodInvokeExpression>
																				<!--<propertyReferenceExpression name="Compiled">
                                          <typeReferenceExpression type="RegexOptions"/>
                                        </propertyReferenceExpression>-->
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="WriteEndElement">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
														</methodInvokeExpression>
														<assignStatement>
															<variableReferenceExpression name="fileName"/>
															<binaryOperatorExpression operator="Add">
																<binaryOperatorExpression operator="Add">
																	<methodInvokeExpression methodName="GetFileNameWithoutExtension">
																		<target>
																			<typeReferenceExpression type="Path"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="fileName"/>
																		</parameters>
																	</methodInvokeExpression>
																	<primitiveExpression value="_"/>
																</binaryOperatorExpression>
																<methodInvokeExpression methodName="GetExtension">
																	<target>
																		<typeReferenceExpression type="Path"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="FileName">
																			<variableReferenceExpression name="file"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</assignStatement>
														<methodInvokeExpression methodName="SaveAs">
															<target>
																<variableReferenceExpression name="file"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="Combine">
																	<target>
																		<typeReferenceExpression type="Path"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="p"/>
																		<variableReferenceExpression name="fileName"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
													<finally>
														<methodInvokeExpression methodName="Close">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
														</methodInvokeExpression>
													</finally>
												</tryStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- void LoadFile(Stream) -->
						<memberMethod name="LoadFile">
							<attributes public="true" override="true"/>
							<parameters>
								<parameter type="Stream" name="stream"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="p">
									<init>
										<methodInvokeExpression methodName="GenerateDataRecordPath">
											<target>
												<typeReferenceExpression type="AnnotationPlugIn"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<comment>t|1|OrderDetails,_Annotation_Attachment20091219164153Z|10248|11</comment>
								<variableDeclarationStatement type="Match" name="m">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Value">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
												<primitiveExpression value="_Annotation_Attachment(\w+)\|"/>
												<!--<propertyReferenceExpression name="Compiled">
                          <typeReferenceExpression type="RegexOptions"/>
                        </propertyReferenceExpression>-->
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="fileName">
									<init>
										<methodInvokeExpression methodName="Combine">
											<target>
												<typeReferenceExpression type="Path"/>
											</target>
											<parameters>
												<variableReferenceExpression name="p"/>
												<binaryOperatorExpression operator="Add">
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
													<primitiveExpression value=".xml"/>
												</binaryOperatorExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="XPathNavigator" name="nav">
									<init>
										<methodInvokeExpression methodName="SelectSingleNode">
											<target>
												<methodInvokeExpression methodName="CreateNavigator">
													<target>
														<objectCreateExpression type="XPathDocument">
															<parameters>
																<variableReferenceExpression name="fileName"/>
															</parameters>
														</objectCreateExpression>
													</target>
												</methodInvokeExpression>
											</target>
											<parameters>
												<primitiveExpression value="/*"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<variableReferenceExpression name="fileName"/>
									<methodInvokeExpression methodName="Combine">
										<target>
											<typeReferenceExpression type="Path"/>
										</target>
										<parameters>
											<variableReferenceExpression name="p"/>
											<binaryOperatorExpression operator="Add">
												<binaryOperatorExpression operator="Add">
													<methodInvokeExpression methodName="GetFileNameWithoutExtension">
														<target>
															<typeReferenceExpression type="Path"/>
														</target>
														<parameters>
															<variableReferenceExpression name="fileName"/>
														</parameters>
													</methodInvokeExpression>
													<primitiveExpression value="_"/>
												</binaryOperatorExpression>
												<methodInvokeExpression methodName="GetExtension">
													<target>
														<typeReferenceExpression type="Path"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="GetAttribute">
															<target>
																<variableReferenceExpression name="nav"/>
															</target>
															<parameters>
																<primitiveExpression value="fileName"/>
																<propertyReferenceExpression name="Empty">
																	<typeReferenceExpression type="String"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="StartsWith">
												<target>
													<propertyReferenceExpression name="Value">
														<thisReferenceExpression/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<primitiveExpression value="t|"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="ContentType">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<variableReferenceExpression name="nav"/>
												</target>
												<parameters>
													<primitiveExpression value="contentLength"/>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="ContentType">
												<propertyReferenceExpression name="Response">
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="HttpContext"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="ContentType">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="FileName">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<variableReferenceExpression name="nav"/>
										</target>
										<parameters>
											<primitiveExpression value="fileName"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement type="Stream" name="input">
									<init>
										<methodInvokeExpression methodName="OpenRead">
											<target>
												<typeReferenceExpression type="File"/>
											</target>
											<parameters>
												<variableReferenceExpression name="fileName"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<tryStatement>
									<statements>
										<variableDeclarationStatement type="System.Byte[]" name="buffer">
											<init>
												<arrayCreateExpression>
													<createType type="System.Byte"/>
													<sizeExpression>
														<binaryOperatorExpression operator="Multiply">
															<primitiveExpression value="1024"/>
															<primitiveExpression value="64"/>
														</binaryOperatorExpression>
													</sizeExpression>
												</arrayCreateExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Int64" name="offset">
											<init>
												<primitiveExpression value="0"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Int64" name="bytesRead">
											<init>
												<methodInvokeExpression methodName="Read">
													<target>
														<variableReferenceExpression name="input"/>
													</target>
													<parameters>
														<variableReferenceExpression name="buffer"/>
														<primitiveExpression value="0"/>
														<propertyReferenceExpression name="Length">
															<variableReferenceExpression name="buffer"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<binaryOperatorExpression operator="GreaterThan">
													<variableReferenceExpression name="bytesRead"/>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</test>
											<statements>
												<methodInvokeExpression methodName="Write">
													<target>
														<variableReferenceExpression name="stream"/>
													</target>
													<parameters>
														<variableReferenceExpression name="buffer"/>
														<primitiveExpression value="0"/>
														<methodInvokeExpression methodName="ToInt32">
															<target>
																<typeReferenceExpression type="Convert"/>
															</target>
															<parameters>
																<variableReferenceExpression name="bytesRead"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
												<assignStatement>
													<variableReferenceExpression name="offset"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="offset"/>
														<variableReferenceExpression name="bytesRead"/>
													</binaryOperatorExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="bytesRead"/>
													<methodInvokeExpression methodName="Read">
														<target>
															<variableReferenceExpression name="input"/>
														</target>
														<parameters>
															<variableReferenceExpression name="buffer"/>
															<primitiveExpression value="0"/>
															<propertyReferenceExpression name="Length">
																<variableReferenceExpression name="buffer"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</statements>
										</whileStatement>
									</statements>
									<finally>
										<methodInvokeExpression methodName="Close">
											<target>
												<variableReferenceExpression name="input"/>
											</target>
										</methodInvokeExpression>
									</finally>
								</tryStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
