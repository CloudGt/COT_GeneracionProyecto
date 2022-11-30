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
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Xml"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Caching"/>
				<namespaceImport name="System.Web.Configuration"/>
				<namespaceImport name="System.Web.Security"/>
			</imports>
			<types>
				<!-- enumarations -->
				<typeDeclaration name="DynamicExpressionScope" isEnum="true">
					<members>
						<memberField name="Field">
							<attributes public="true"/>
						</memberField>
						<memberField name="ViewRowStyle">
							<attributes public="true"/>
						</memberField>
						<memberField name="CategoryVisibility">
							<attributes public="true"/>
						</memberField>
						<memberField name="DataFieldVisibility">
							<attributes public="true"/>
						</memberField>
            <memberField name="DefaultValues">
              <attributes public="true"/>
            </memberField>
            <memberField name="ReadOnly">
              <attributes public="true"/>
            </memberField>
            <memberField name="Rule">
              <attributes public="true"/>
            </memberField>
          </members>
				</typeDeclaration>
				<typeDeclaration  name="DynamicExpressionType" isEnum="true">
					<members>
						<memberField name="RegularExpression">
							<attributes public="true"/>
						</memberField>
						<memberField name="ClientScript">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- class ViewPage -->
				<typeDeclaration name="DynamicExpression">
					<members>
						<!-- property Scope-->
						<memberField type="DynamicExpressionScope" name="scope"/>
						<memberProperty type="DynamicExpressionScope" name="Scope">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="scope"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="scope"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property Target -->
						<memberField type="System.String" name="target"/>
						<memberProperty type="System.String" name="Target">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="target"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="target"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property Type -->
						<memberField type="DynamicExpressionType" name="type"/>
						<memberProperty type="DynamicExpressionType" name="Type">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="type"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="type"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property Test -->
						<memberField type="System.String" name="test"/>
						<memberProperty type="System.String" name="Test">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="test"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="test"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property Result -->
						<memberField type="System.String" name="result"/>
						<memberProperty type="System.String" name="Result">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="result"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="result"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!--property ViewId -->
						<memberField type="System.String" name="viewId"/>
						<memberProperty type="System.String" name="ViewId">
							<attributes public="true" final="true"/>
							<getStatements >
								<methodReturnStatement>
									<fieldReferenceExpression name="viewId"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="viewId"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- constructor() -->
						<constructor>
							<attributes public="true"/>
						</constructor>
						<!-- constructor(XPathNavigator, XmlNamespaceManager) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="XPathNavigator" name="expression"/>
								<parameter type="XmlNamespaceManager" name="nm"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="XPathNavigator" name="scope">
									<init>
										<methodInvokeExpression methodName="SelectSingleNode">
											<target>
												<argumentReferenceExpression name="expression"/>
											</target>
											<parameters>
												<primitiveExpression value="parent::c:*"/>
												<argumentReferenceExpression name="nm"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="XPathNavigator" name="target">
									<init>
										<methodInvokeExpression methodName="SelectSingleNode">
											<target>
												<argumentReferenceExpression name="expression"/>
											</target>
											<parameters>
												<primitiveExpression value="parent::c:*/parent::c:*"/>
												<argumentReferenceExpression name="nm"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="LocalName">
												<variableReferenceExpression name="scope"/>
											</propertyReferenceExpression>
											<primitiveExpression value="validate"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="scope"/>
											<propertyReferenceExpression name="Field">
												<typeReferenceExpression type="DynamicExpressionScope"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="target"/>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<variableReferenceExpression name="target"/>
												</target>
												<parameters>
													<primitiveExpression value="name"/>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="LocalName">
														<variableReferenceExpression name="scope"/>
													</propertyReferenceExpression>
													<primitiveExpression value="styles"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<fieldReferenceExpression name="scope"/>
													<propertyReferenceExpression name="ViewRowStyle">
														<typeReferenceExpression type="DynamicExpressionScope"/>
													</propertyReferenceExpression>
												</assignStatement>
												<assignStatement>
													<fieldReferenceExpression name="target"/>
													<methodInvokeExpression methodName="GetAttribute">
														<target>
															<variableReferenceExpression name="target"/>
														</target>
														<parameters>
															<primitiveExpression value="id"/>
															<propertyReferenceExpression name="Empty">
																<typeReferenceExpression type="String"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="LocalName">
																<variableReferenceExpression name="scope"/>
															</propertyReferenceExpression>
															<primitiveExpression value="visibility"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
                            <comment>determine the scope and target of visibility</comment>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="LocalName">
																		<variableReferenceExpression name="target"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="field"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<fieldReferenceExpression name="scope"/>
																	<propertyReferenceExpression name="DataFieldVisibility">
																		<typeReferenceExpression type="DynamicExpressionScope"/>
																	</propertyReferenceExpression>
																</assignStatement>
																<assignStatement>
																	<fieldReferenceExpression name="target"/>
																	<methodInvokeExpression methodName="GetAttribute">
																		<target>
																			<variableReferenceExpression name="target"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="name"/>
																			<propertyReferenceExpression name="Empty">
																				<typeReferenceExpression type="String"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="LocalName">
																				<variableReferenceExpression name="target"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="dataField"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<fieldReferenceExpression name="scope"/>
																			<propertyReferenceExpression name="DataFieldVisibility">
																				<typeReferenceExpression type="DynamicExpressionScope"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																		<assignStatement>
																			<fieldReferenceExpression name="target"/>
																			<methodInvokeExpression methodName="GetAttribute">
																				<target>
																					<variableReferenceExpression name="target"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="fieldName"/>
																					<propertyReferenceExpression name="Empty">
																						<typeReferenceExpression type="String"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<propertyReferenceExpression name="LocalName">
																						<variableReferenceExpression name="target"/>
																					</propertyReferenceExpression>
																					<primitiveExpression value="category"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<fieldReferenceExpression name="scope"/>
																					<propertyReferenceExpression name="CategoryVisibility">
																						<typeReferenceExpression type="DynamicExpressionScope"/>
																					</propertyReferenceExpression>
																				</assignStatement>
																				<assignStatement>
																					<fieldReferenceExpression name="target"/>
																					<methodInvokeExpression methodName="GetAttribute">
																						<target>
																							<variableReferenceExpression name="target"/>
																						</target>
																						<parameters>
																							<primitiveExpression value="id"/>
																							<propertyReferenceExpression name="Empty">
																								<typeReferenceExpression type="String"/>
																							</propertyReferenceExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="LocalName">
																		<variableReferenceExpression name="scope"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="defaultValues"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
                                <comment>determine the scope and target of default values</comment>
                                <conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="LocalName">
																				<variableReferenceExpression name="target"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="field"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<fieldReferenceExpression name="scope"/>
																			<propertyReferenceExpression name="DataFieldVisibility">
																				<typeReferenceExpression type="DynamicExpressionScope"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																		<assignStatement>
																			<fieldReferenceExpression name="target"/>
																			<methodInvokeExpression methodName="GetAttribute">
																				<target>
																					<variableReferenceExpression name="target"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="name"/>
																					<propertyReferenceExpression name="Empty">
																						<typeReferenceExpression type="String"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<propertyReferenceExpression name="LocalName">
																						<variableReferenceExpression name="target"/>
																					</propertyReferenceExpression>
																					<primitiveExpression value="dataField"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<fieldReferenceExpression name="scope"/>
																					<propertyReferenceExpression name="DataFieldVisibility">
																						<typeReferenceExpression type="DynamicExpressionScope"/>
																					</propertyReferenceExpression>
																				</assignStatement>
																				<assignStatement>
																					<fieldReferenceExpression name="target"/>
																					<methodInvokeExpression methodName="GetAttribute">
																						<target>
																							<variableReferenceExpression name="target"/>
																						</target>
																						<parameters>
																							<primitiveExpression value="fieldName"/>
																							<propertyReferenceExpression name="Empty">
																								<typeReferenceExpression type="String"/>
																							</propertyReferenceExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
                              <falseStatements>
                                <conditionStatement>
                                  <condition>
                                    <binaryOperatorExpression operator="ValueEquality">
                                      <propertyReferenceExpression name="LocalName">
                                        <variableReferenceExpression name="scope"/>
                                      </propertyReferenceExpression>
                                      <primitiveExpression value="readOnly"/>
                                    </binaryOperatorExpression>
                                  </condition>
                                  <trueStatements>
                                    <comment>determine the scope and target of read-only expression</comment>
                                    <conditionStatement>
                                      <condition>
                                        <binaryOperatorExpression operator="ValueEquality">
                                          <propertyReferenceExpression name="LocalName">
                                            <variableReferenceExpression name="target"/>
                                          </propertyReferenceExpression>
                                          <primitiveExpression value="field"/>
                                        </binaryOperatorExpression>
                                      </condition>
                                      <trueStatements>
                                        <assignStatement>
                                          <fieldReferenceExpression name="scope"/>
                                          <propertyReferenceExpression name="ReadOnly">
                                            <typeReferenceExpression type="DynamicExpressionScope"/>
                                          </propertyReferenceExpression>
                                        </assignStatement>
                                        <assignStatement>
                                          <fieldReferenceExpression name="target"/>
                                          <methodInvokeExpression methodName="GetAttribute">
                                            <target>
                                              <variableReferenceExpression name="target"/>
                                            </target>
                                            <parameters>
                                              <primitiveExpression value="name"/>
                                              <propertyReferenceExpression name="Empty">
                                                <typeReferenceExpression type="String"/>
                                              </propertyReferenceExpression>
                                            </parameters>
                                          </methodInvokeExpression>
                                        </assignStatement>
                                      </trueStatements>
                                      <falseStatements>
                                        <conditionStatement>
                                          <condition>
                                            <binaryOperatorExpression operator="ValueEquality">
                                              <propertyReferenceExpression name="LocalName">
                                                <variableReferenceExpression name="target"/>
                                              </propertyReferenceExpression>
                                              <primitiveExpression value="dataField"/>
                                            </binaryOperatorExpression>
                                          </condition>
                                          <trueStatements>
                                            <assignStatement>
                                              <fieldReferenceExpression name="scope"/>
                                              <propertyReferenceExpression name="ReadOnly">
                                                <typeReferenceExpression type="DynamicExpressionScope"/>
                                              </propertyReferenceExpression>
                                            </assignStatement>
                                            <assignStatement>
                                              <fieldReferenceExpression name="target"/>
                                              <methodInvokeExpression methodName="GetAttribute">
                                                <target>
                                                  <variableReferenceExpression name="target"/>
                                                </target>
                                                <parameters>
                                                  <primitiveExpression value="fieldName"/>
                                                  <propertyReferenceExpression name="Empty">
                                                    <typeReferenceExpression type="String"/>
                                                  </propertyReferenceExpression>
                                                </parameters>
                                              </methodInvokeExpression>
                                            </assignStatement>
                                          </trueStatements>
                                        </conditionStatement>
                                      </falseStatements>
                                    </conditionStatement>
                                  </trueStatements>
                                </conditionStatement>
                              </falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
                <variableDeclarationStatement type="System.String" name="expressionType">
                  <init>
                    <methodInvokeExpression methodName="GetAttribute">
                      <target>
                        <argumentReferenceExpression name="expression"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="type"/>
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
                      <variableReferenceExpression name="expressionType"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="expressionType"/>
                      <primitiveExpression value="ClientScript"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
								<assignStatement>
									<fieldReferenceExpression name="type"/>
									<castExpression targetType="DynamicExpressionType">
										<methodInvokeExpression methodName="ConvertFromString">
											<target>
												<methodInvokeExpression methodName="GetConverter">
													<target>
														<typeReferenceExpression type="TypeDescriptor"/>
													</target>
													<parameters>
														<typeofExpression type="DynamicExpressionType"/>
													</parameters>
												</methodInvokeExpression>
											</target>
											<parameters>
                        <variableReferenceExpression name="expressionType"/>
											</parameters>
										</methodInvokeExpression>
									</castExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="test"/>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<argumentReferenceExpression name="expression"/>
										</target>
										<parameters>
											<primitiveExpression value="test"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="result"/>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<argumentReferenceExpression name="expression"/>
										</target>
										<parameters>
											<primitiveExpression value="result"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<fieldReferenceExpression name="result"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="result"/>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<fieldReferenceExpression name="viewId"/>
									<castExpression targetType="System.String">
										<methodInvokeExpression methodName="Evaluate">
											<target>
												<argumentReferenceExpression name="expression"/>
											</target>
											<parameters>
												<primitiveExpression value="string(ancestor::c:view/@id)"/>
												<argumentReferenceExpression name="nm"/>
											</parameters>
										</methodInvokeExpression>
									</castExpression>
								</assignStatement>
							</statements>
						</constructor>
						<!-- method AllowedInView(string) -->
						<memberMethod returnType="System.Boolean" name="AllowedInView">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="view"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanOr">
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<fieldReferenceExpression name="viewId"/>
										</unaryOperatorExpression>
										<binaryOperatorExpression operator="ValueEquality">
											<fieldReferenceExpression name="viewId"/>
											<argumentReferenceExpression name="view"/>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
