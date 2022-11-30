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
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Data.Common"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="{a:project/a:namespace}.Services"/>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
			</imports>
			<types>
				<!-- class DataTransaction -->
				<typeDeclaration name="DataTransaction">
					<baseTypes>
						<typeReference type="DataConnection"/>
					</baseTypes>
					<members>
						<!-- constructore() -->
						<constructor>
							<attributes public="true"/>
							<chainedConstructorArgs>
								<primitiveExpression value="{a:project/a:namespace}"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- contructor(string) -->
						<constructor>
							<attributes public="t"/>
							<baseConstructorArgs>
								<argumentReferenceExpression name="connectionStringName"/>
								<primitiveExpression value="true"/>
							</baseConstructorArgs>
							<parameters>
								<parameter type="System.String" name="connectionStringName"/>
							</parameters>
						</constructor>
					</members>
				</typeDeclaration>
				<!-- class DataConnection -->
				<typeDeclaration name="DataConnection">
					<baseTypes>
						<typeReference type="Object"/>
						<typeReference type="IDisposable"/>
					</baseTypes>
					<members>
						<memberField type="System.String" name="connectionStringName"/>
						<memberField type="System.Boolean" name="disposed"/>
						<memberField type="System.Boolean" name="keepOpen"/>
						<memberField type="System.Boolean" name="canClose"/>
						<memberField type="DbConnection" name="connection"/>
						<memberField type="System.String" name="parameterMarker"/>
						<memberField type="System.String" name="leftQuote"/>
						<memberField type="System.String" name="rightQuote"/>
						<memberField type="DbTransaction" name="transaction"/>
						<memberField type="System.Boolean" name="transactionsEnabled"/>
						<!-- property Connection -->
						<memberProperty type="DbConnection" name="Connection">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="connection"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Transaction -->
						<memberProperty type="DbTransaction" name="Transaction">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="transaction"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property KeepOpen -->
						<memberProperty type="System.Boolean" name="KeepOpen">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="keepOpen"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property CanClose -->
						<memberProperty type="System.Boolean" name="CanClose">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="canClose"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property ConnectionStringName -->
						<memberProperty type="System.String" name="ConnectionStringName">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="connectionStringName"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property ParameterMarker -->
						<memberProperty type="System.String" name="ParameterMarker">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="parameterMarker"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property LeftQuote -->
						<memberProperty type="System.String" name="LeftQuote">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="leftQuote"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Right Quote -->
						<memberProperty type="System.String" name="RightQuote">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="rightQuote"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- constructor (string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="connectionStringName"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="connectionStringName"/>
								<primitiveExpression value="false"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor (string, bool) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="connectionStringName"/>
								<parameter type="System.BOolean" name="keepOpen"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="connectionStringName">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="connectionStringName"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="keepOpen">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="keepOpen"/>
								</assignStatement>
								<variableDeclarationStatement type="IDictionary" name="contextItems">
									<init>
										<propertyReferenceExpression name="Items">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="HttpContext"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<fieldReferenceExpression name="connection">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<castExpression targetType="DbConnection">
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="contextItems"/>
											</target>
											<indices>
												<methodInvokeExpression methodName="ToContextKey">
													<parameters>
														<primitiveExpression value="connection"/>
													</parameters>
												</methodInvokeExpression>
											</indices>
										</arrayIndexerExpression>
									</castExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="connection">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="connection">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<methodInvokeExpression methodName="CreateConnection">
												<target>
													<typeReferenceExpression type="SqlStatement"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="connectionStringName"/>
													<primitiveExpression value="true"/>
													<directionExpression direction="Out">
														<fieldReferenceExpression name="parameterMarker"/>
													</directionExpression>
													<directionExpression direction="Out">
														<fieldReferenceExpression name="leftQuote"/>
													</directionExpression>
													<directionExpression direction="Out">
														<fieldReferenceExpression name="rightQuote"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="canClose">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<primitiveExpression value="true"/>
										</assignStatement>
										<conditionStatement>
											<condition>
												<argumentReferenceExpression name="keepOpen"/>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="JToken" name="transactionsEnabled">
													<init>
														<methodInvokeExpression methodName="Settings">
															<target>
																<typeReferenceExpression type="ApplicationServices"/>
															</target>
															<parameters>
																<primitiveExpression value="odp.transactions.enabled"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<assignStatement>
													<fieldReferenceExpression name="transactionsEnabled">
														<thisReferenceExpression/>
													</fieldReferenceExpression>
													<binaryOperatorExpression operator="BooleanOr">
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="transactionsEnabled"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<castExpression targetType="System.Boolean">
															<variableReferenceExpression name="transactionsEnabled"/>
														</castExpression>
													</binaryOperatorExpression>
												</assignStatement>
												<methodInvokeExpression methodName="BeginTransaction"/>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="contextItems"/>
														</target>
														<indices>
															<methodInvokeExpression methodName="ToContextKey">
																<parameters>
																	<primitiveExpression value="connection"/>
																</parameters>
															</methodInvokeExpression>
														</indices>
													</arrayIndexerExpression>
													<fieldReferenceExpression name="connection"/>
												</assignStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="contextItems"/>
														</target>
														<indices>
															<methodInvokeExpression methodName="ToContextKey">
																<parameters>
																	<primitiveExpression value="parameterMarker"/>
																</parameters>
															</methodInvokeExpression>
														</indices>
													</arrayIndexerExpression>
													<fieldReferenceExpression name="parameterMarker"/>
												</assignStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="contextItems"/>
														</target>
														<indices>
															<methodInvokeExpression methodName="ToContextKey">
																<parameters>
																	<primitiveExpression value="leftQuote"/>
																</parameters>
															</methodInvokeExpression>
														</indices>
													</arrayIndexerExpression>
													<fieldReferenceExpression name="leftQuote"/>
												</assignStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="contextItems"/>
														</target>
														<indices>
															<methodInvokeExpression methodName="ToContextKey">
																<parameters>
																	<primitiveExpression value="rightQuote"/>
																</parameters>
															</methodInvokeExpression>
														</indices>
													</arrayIndexerExpression>
													<fieldReferenceExpression name="rightQuote"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<fieldReferenceExpression name="transaction"/>
											<castExpression targetType="DbTransaction">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="contextItems"/>
													</target>
													<indices>
														<methodInvokeExpression methodName="ToContextKey">
															<parameters>
																<primitiveExpression value="transaction"/>
															</parameters>
														</methodInvokeExpression>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="parameterMarker"/>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="contextItems"/>
													</target>
													<indices>
														<methodInvokeExpression methodName="ToContextKey">
															<parameters>
																<primitiveExpression value="parameterMarker"/>
															</parameters>
														</methodInvokeExpression>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="leftQuote"/>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="contextItems"/>
													</target>
													<indices>
														<methodInvokeExpression methodName="ToContextKey">
															<parameters>
																<primitiveExpression value="leftQuote"/>
															</parameters>
														</methodInvokeExpression>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="rightQuote"/>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="contextItems"/>
													</target>
													<indices>
														<methodInvokeExpression methodName="ToContextKey">
															<parameters>
																<primitiveExpression value="rightQuote"/>
															</parameters>
														</methodInvokeExpression>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</constructor>
						<!-- method IDisposable.Dispose() -->
						<memberMethod name="Dispose" privateImplementationType="IDisposable">
							<attributes private="true" final="true"/>
							<statements>
								<methodInvokeExpression methodName="Dispose">
									<parameters>
										<primitiveExpression value="true"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method Dispose(bool) -->
						<memberMethod name="Dispose">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.Boolean" name="disposing"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="Close"/>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<fieldReferenceExpression name="disposed"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<fieldReferenceExpression name="connection"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<fieldReferenceExpression name="canClose"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Dispose">
													<target>
														<fieldReferenceExpression name="connection"/>
													</target>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<fieldReferenceExpression name="disposed"/>
											<primitiveExpression value="true"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<argumentReferenceExpression name="disposing"/>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="SuppressFinalize">
											<target>
												<typeReferenceExpression type="GC"/>
											</target>
											<parameters>
												<thisReferenceExpression/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method Close()-->
						<memberMethod name="Close">
							<attributes public="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<fieldReferenceExpression name="connection"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="State">
													<fieldReferenceExpression name="connection"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="Open">
													<typeReferenceExpression type="ConnectionState"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<fieldReferenceExpression name="canClose"/>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Commit"/>
												<methodInvokeExpression methodName="Close">
													<target>
														<fieldReferenceExpression name="connection"/>
													</target>
												</methodInvokeExpression>
												<conditionStatement>
													<condition>
														<fieldReferenceExpression name="keepOpen"/>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="IDictionary" name="contextItems">
															<init>
																<propertyReferenceExpression name="Items">
																	<propertyReferenceExpression name="Current">
																		<typeReferenceExpression type="HttpContext"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<methodInvokeExpression methodName="Remove">
															<target>
																<variableReferenceExpression name="contextItems"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ToContextKey">
																	<parameters>
																		<primitiveExpression value="connection"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="Remove">
															<target>
																<variableReferenceExpression name="contextItems"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ToContextKey">
																	<parameters>
																		<primitiveExpression value="transaction"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="Remove">
															<target>
																<variableReferenceExpression name="contextItems"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ToContextKey">
																	<parameters>
																		<primitiveExpression value="parameterMarker"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="Remove">
															<target>
																<variableReferenceExpression name="contextItems"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ToContextKey">
																	<parameters>
																		<primitiveExpression value="leftQuote"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="Remove">
															<target>
																<variableReferenceExpression name="contextItems"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ToContextKey">
																	<parameters>
																		<primitiveExpression value="rightQuote"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ToContextKey(string) -->
						<memberMethod returnType="System.String" name="ToContextKey">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<stringFormatExpression format="DataConnection_{{0}}_{{1}}">
										<fieldReferenceExpression name="connectionStringName"/>
										<argumentReferenceExpression name="name"/>
									</stringFormatExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method BeginTransaction() -->
						<memberMethod name="BeginTransaction">
							<attributes public="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<fieldReferenceExpression name="transactionsEnabled"/>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<fieldReferenceExpression name="transaction">
														<thisReferenceExpression/>
													</fieldReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Dispose">
													<target>
														<fieldReferenceExpression name="transaction">
															<thisReferenceExpression/>
														</fieldReferenceExpression>
													</target>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<fieldReferenceExpression name="transaction">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<methodInvokeExpression methodName="BeginTransaction">
												<target>
													<fieldReferenceExpression name="connection">
														<thisReferenceExpression/>
													</fieldReferenceExpression>
												</target>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Items">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<methodInvokeExpression methodName="ToContextKey">
														<parameters>
															<primitiveExpression value="transaction"/>
														</parameters>
													</methodInvokeExpression>
												</indices>
											</arrayIndexerExpression>
											<fieldReferenceExpression name="transaction">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method Commit() -->
						<memberMethod name="Commit">
							<attributes public="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="transaction">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Commit">
											<target>
												<fieldReferenceExpression name="transaction">
													<thisReferenceExpression/>
												</fieldReferenceExpression>
											</target>
										</methodInvokeExpression>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Items">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<methodInvokeExpression methodName="ToContextKey">
														<parameters>
															<primitiveExpression value="transaction"/>
														</parameters>
													</methodInvokeExpression>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="null"/>
										</assignStatement>
										<methodInvokeExpression methodName="Dispose">
											<target>
												<fieldReferenceExpression name="transaction">
													<thisReferenceExpression/>
												</fieldReferenceExpression>
											</target>
										</methodInvokeExpression>
										<assignStatement>
											<fieldReferenceExpression name="transaction">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method Rollback() -->
						<memberMethod name="Rollback">
							<attributes public="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="transaction">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Rollback">
											<target>
												<fieldReferenceExpression name="transaction">
													<thisReferenceExpression/>
												</fieldReferenceExpression>
											</target>
										</methodInvokeExpression>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Items">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<methodInvokeExpression methodName="ToContextKey">
														<parameters>
															<primitiveExpression value="transaction"/>
														</parameters>
													</methodInvokeExpression>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="null"/>
										</assignStatement>
										<methodInvokeExpression methodName="Dispose">
											<target>
												<fieldReferenceExpression name="transaction">
													<thisReferenceExpression/>
												</fieldReferenceExpression>
											</target>
										</methodInvokeExpression>
										<assignStatement>
											<fieldReferenceExpression name="transaction">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class ControllerFieldValue -->
				<typeDeclaration name="ControllerFieldValue">
					<baseTypes>
						<typeReference type="FieldValue"/>
					</baseTypes>
					<members>
						<!-- property Controller  -->
						<memberProperty type="System.String" name="Controller">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- contructor() -->
						<constructor>
							<attributes public="true"/>
							<baseConstructorArgs/>
						</constructor>
						<!-- constructor(string, string, object, object) -->
						<constructor>
							<attributes public="true"/>
							<baseConstructorArgs>
								<argumentReferenceExpression name="fieldName"/>
								<argumentReferenceExpression name="oldValue"/>
								<argumentReferenceExpression name="newValue"/>
							</baseConstructorArgs>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="System.Object" name="oldValue"/>
								<parameter type="System.Object" name="newValue"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="Controller">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="controller"/>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>

				<!-- class CommitResult -->
				<typeDeclaration name="CommitResult">
					<members>
						<!--  property Date -->
						<memberProperty type="System.String" name="Date">
							<comment><![CDATA[<summary>The timestamp indicating the start of ActionArgs log processing on the server.</summary>]]></comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property CommitSequence-->
						<memberProperty type="System.Int32" name="Sequence">
							<comment><![CDATA[<summary>The last committed sequence in the ActionArgs log. Equals -1 if no entries in the log were committed to the database.</summary>]]></comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Index -->
						<memberProperty type="System.Int32" name="Index">
							<comment><![CDATA[<summary>The index of the ActionArgs entry in the log that has caused an error. Equals -1 if no errors were detected.</summary>]]></comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Errors -->
						<memberProperty type="System.String[]" name="Errors">
							<comment><![CDATA[<summary>The array of errors reported when an entry in the log has failed to executed.</summary>]]></comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property RowNotFound -->
						<memberProperty type="System.Boolean" name="RowNotFound">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Values -->
						<memberProperty type="List" name="Values">
							<typeArguments>
								<typeReference type="ControllerFieldValue"/>
							</typeArguments>
							<comment><![CDATA[<summary>The list of values that includes resolved primary key values.</summary>]]></comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Success -->
						<memberProperty type="System.Boolean" name="Success">
							<comment><![CDATA[<summary>Indicates that the log has been committed sucessfully. Returns false if property Index has any value other than -1.</summary>]]></comment>
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="ValueEquality">
										<propertyReferenceExpression name="Index"/>
										<primitiveExpression value="-1"/>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- constructor() -->
						<constructor>
							<attributes public="true"/>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="sequence"/>
									<primitiveExpression value="-1"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="index"/>
									<primitiveExpression value="-1"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="date"/>
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
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="values"/>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="ControllerFieldValue"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>
				<!-- class TransactionManager -->
				<typeDeclaration name="TransactionManager">
					<comment>
						<![CDATA[<summary>Provides a mechism to execute an array of ActionArgs instances in the context of a transaction. 
Transactions are enabled by default. The default "scope" is "all". The default "upload" is "all".
</summary>
<remarks>
Use the following definition in touch-settings.json file to control Offline Data Processor (ODP):
{
  "odp": {
    "enabled": true,
    "transactions": {
      "enabled": true,
      "scope": "sequence",
      "upload": "all"
    }
  }
}
</remarks>
]]>
					</comment>
					<baseTypes>
						<typeReference type="TransactionManagerBase"/>
					</baseTypes>
				</typeDeclaration>
				<!-- class TransactionManagerBase -->
				<typeDeclaration name="TransactionManagerBase">
					<members>
						<memberField type="SortedDictionary" name="controllers">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="ControllerConfiguration"/>
							</typeArguments>
						</memberField>
						<memberField type="SortedDictionary" name="resolvedKeys">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.Object"/>
							</typeArguments>
						</memberField>
						<memberField type="FieldValue" name="pk"/>
						<memberField type="CommitResult" name="commitResult"/>
						<!-- constructor() -->
						<constructor>
							<attributes public="true"/>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="controllers"/>
									<objectCreateExpression type="SortedDictionary">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="ControllerConfiguration"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="resolvedKeys"/>
									<objectCreateExpression type="SortedDictionary">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="System.Object"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
							</statements>
						</constructor>
						<!-- method LoadConfig(string) -->
						<memberMethod returnType="ControllerConfiguration" name="LoadConfig">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="controllerName"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ControllerConfiguration" name="config">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<fieldReferenceExpression name="controllers"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="controllerName"/>
													<directionExpression direction="Out">
														<variableReferenceExpression name="config"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="config"/>
											<methodInvokeExpression methodName="CreateConfigurationInstance">
												<target>
													<typeReferenceExpression type="DataControllerBase"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="GetType"/>
													<argumentReferenceExpression name="controllerName"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<fieldReferenceExpression name="controllers"/>
												</target>
												<indices>
													<argumentReferenceExpression name="controllerName"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="config"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="config"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ResolvePrimaryKey(string, string, object, object) -->
						<memberMethod name="ResolvePrimaryKey">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="controllerName"/>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="System.Object" name="oldValue"/>
								<parameter type="System.Object" name="newValue"/>
							</parameters>
							<statements>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<fieldReferenceExpression name="resolvedKeys"/>
										</target>
										<indices>
											<stringFormatExpression format="{{0}}${{1}}">
												<argumentReferenceExpression name="controllerName"/>
												<argumentReferenceExpression name="oldValue"/>
											</stringFormatExpression>
										</indices>
									</arrayIndexerExpression>
									<argumentReferenceExpression name="newValue"/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="ValueInequality">
												<argumentReferenceExpression name="newValue"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="GreaterThanOrEqual">
												<propertyReferenceExpression name="Length">
													<convertExpression to="String">
														<argumentReferenceExpression name="newValue"/>
													</convertExpression>
												</propertyReferenceExpression>
												<primitiveExpression value="36"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="oldValueAsInteger">
											<init>
												<primitiveExpression value="0"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<methodInvokeExpression methodName="TryParse">
														<target>
															<typeReferenceExpression type="System.Int32"/>
														</target>
														<parameters>
															<convertExpression to="String">
																<argumentReferenceExpression name="oldValue"/>
															</convertExpression>
															<directionExpression direction="Out">
																<variableReferenceExpression name="oldValueAsInteger"/>
															</directionExpression>
														</parameters>
													</methodInvokeExpression>
													<binaryOperatorExpression operator="LessThan">
														<variableReferenceExpression name="oldValueAsInteger"/>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="oldValueAsInteger"/>
													<binaryOperatorExpression operator="Multiply">
														<variableReferenceExpression name="oldValueAsInteger"/>
														<primitiveExpression value="-1"/>
													</binaryOperatorExpression>
												</assignStatement>
												<variableDeclarationStatement name="uid">
													<init>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="000000000000" convertTo="String"/>
															<methodInvokeExpression methodName="ToString">
																<target>
																	<variableReferenceExpression name="oldValueAsInteger"/>
																</target>
																<parameters>
																	<primitiveExpression value="x"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</init>
												</variableDeclarationStatement>
												<assignStatement>
													<variableReferenceExpression name="uid"/>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="00000000-0000-0000-0000-"/>
														<methodInvokeExpression methodName="Substring">
															<target>
																<variableReferenceExpression name="uid"/>
															</target>
															<parameters>
																<binaryOperatorExpression operator="Subtract">
																	<propertyReferenceExpression name="Length">
																		<variableReferenceExpression name="uid"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="12"/>
																</binaryOperatorExpression>
															</parameters>
														</methodInvokeExpression>
													</binaryOperatorExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="oldValue"/>
													<variableReferenceExpression name="uid"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Values">
											<fieldReferenceExpression name="commitResult"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<objectCreateExpression type="ControllerFieldValue">
											<parameters>
												<argumentReferenceExpression name="controllerName"/>
												<argumentReferenceExpression name="fieldName"/>
												<argumentReferenceExpression name="oldValue"/>
												<argumentReferenceExpression name="newValue"/>
											</parameters>
										</objectCreateExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method TryParseTempPK(object, int) -->
						<memberMethod returnType="System.Boolean" name="TryParseTempPK">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.Object" name="v"/>
								<parameter type="System.Int32" name="value" direction="Out"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="s">
									<init>
										<convertExpression to="String">
											<argumentReferenceExpression name="v"/>
										</convertExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="s"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="value"/>
											<primitiveExpression value="0"/>
										</assignStatement>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="uid">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<variableReferenceExpression name="s"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[0{8}-0{4}-0{4}-0{4}-([\da-f]{12})$]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Success">
											<variableReferenceExpression name="uid"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="value"/>
											<binaryOperatorExpression operator="Multiply">
												<methodInvokeExpression methodName="ToInt32">
													<target>
														<typeReferenceExpression type="Convert"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="uid"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="1"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
														<primitiveExpression value="16"/>
													</parameters>
												</methodInvokeExpression>
												<primitiveExpression value="-1"/>
											</binaryOperatorExpression>
										</assignStatement>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="TryParse">
										<target>
											<typeReferenceExpression type="System.Int32"/>
										</target>
										<parameters>
											<variableReferenceExpression name="s"/>
											<directionExpression direction="Out">
												<argumentReferenceExpression name="value"/>
											</directionExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ProcessArguments(ControllerConfiguration, ActionArgs) -->
						<memberMethod name="ProcessArguments">
							<attributes family="true"/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
								<parameter type="ActionArgs" name="args"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<propertyReferenceExpression name="Values">
												<argumentReferenceExpression name="args"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="FieldValueDictionary" name="values">
									<init>
										<objectCreateExpression type="FieldValueDictionary">
											<parameters>
												<argumentReferenceExpression name="args"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<fieldReferenceExpression name="pk"/>
									<primitiveExpression value="null"/>
								</assignStatement>
								<comment>detect negative primary keys</comment>
								<variableDeclarationStatement type="XPathNavigator" name="pkNav">
									<init>
										<methodInvokeExpression methodName="SelectSingleNode">
											<target>
												<argumentReferenceExpression name="config"/>
											</target>
											<parameters>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[/c:dataController/c:fields/c:field[@isPrimaryKey='true']]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="pkNav"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="FieldValue" name="fvo">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="TryGetValue">
													<target>
														<variableReferenceExpression name="values"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="GetAttribute">
															<target>
																<variableReferenceExpression name="pkNav"/>
															</target>
															<parameters>
																<primitiveExpression value="name"/>
																<stringEmptyExpression/>
															</parameters>
														</methodInvokeExpression>
														<directionExpression direction="Out">
															<variableReferenceExpression name="fvo"/>
														</directionExpression>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.Int32" name="value">
													<init>
														<primitiveExpression value="0"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="TryParseTempPK">
															<parameters>
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="fvo"/>
																</propertyReferenceExpression>
																<directionExpression direction="Out">
																	<variableReferenceExpression name="value"/>
																</directionExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="LessThan">
																	<variableReferenceExpression name="value"/>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="CommandName">
																				<argumentReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="Insert"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<comment>request a new row from business rules</comment>
																		<variableDeclarationStatement type="PageRequest" name="newRowRequest">
																			<init>
																				<objectCreateExpression type="PageRequest"/>
																			</init>
																		</variableDeclarationStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="Controller">
																				<variableReferenceExpression name="newRowRequest"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="Controller">
																				<argumentReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="View">
																				<variableReferenceExpression name="newRowRequest"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="View">
																				<argumentReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="Inserting">
																				<variableReferenceExpression name="newRowRequest"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="RequiresMetaData">
																				<variableReferenceExpression name="newRowRequest"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="MetadataFilter">
																				<variableReferenceExpression name="newRowRequest"/>
																			</propertyReferenceExpression>
																			<arrayCreateExpression>
																				<createType type="System.String"/>
																				<initializers>
																					<primitiveExpression value="fields"/>
																				</initializers>
																			</arrayCreateExpression>
																		</assignStatement>
																		<variableDeclarationStatement type="ViewPage" name="page">
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
																							<variableReferenceExpression name="newRowRequest"/>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="View">
																							<variableReferenceExpression name="newRowRequest"/>
																						</propertyReferenceExpression>
																						<variableReferenceExpression name="newRowRequest"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityInequality">
																					<propertyReferenceExpression name="NewRow">
																						<variableReferenceExpression name="page"/>
																					</propertyReferenceExpression>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<forStatement>
																					<variable type="System.Int32" name="i">
																						<init>
																							<primitiveExpression value="0"/>
																						</init>
																					</variable>
																					<test>
																						<binaryOperatorExpression operator="LessThan">
																							<variableReferenceExpression name="i"/>
																							<propertyReferenceExpression name="Length">
																								<propertyReferenceExpression name="NewRow">
																									<variableReferenceExpression name="page"/>
																								</propertyReferenceExpression>
																							</propertyReferenceExpression>
																						</binaryOperatorExpression>
																					</test>
																					<increment>
																						<variableReferenceExpression name="i"/>
																					</increment>
																					<statements>
																						<variableDeclarationStatement type="System.Object" name="newValue">
																							<init>
																								<arrayIndexerExpression>
																									<target>
																										<propertyReferenceExpression name="NewRow">
																											<variableReferenceExpression name="page"/>
																										</propertyReferenceExpression>
																									</target>
																									<indices>
																										<variableReferenceExpression name="i"/>
																									</indices>
																								</arrayIndexerExpression>
																							</init>
																						</variableDeclarationStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="IdentityInequality">
																									<variableReferenceExpression name="newValue"/>
																									<primitiveExpression value="null"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<variableDeclarationStatement type="DataField" name="field">
																									<init>
																										<arrayIndexerExpression>
																											<target>
																												<propertyReferenceExpression name="Fields">
																													<variableReferenceExpression name="page"/>
																												</propertyReferenceExpression>
																											</target>
																											<indices>
																												<variableReferenceExpression name="i"/>
																											</indices>
																										</arrayIndexerExpression>
																									</init>
																								</variableDeclarationStatement>
																								<conditionStatement>
																									<condition>
																										<propertyReferenceExpression name="IsPrimaryKey">
																											<variableReferenceExpression name="field"/>
																										</propertyReferenceExpression>
																									</condition>
																									<trueStatements>
																										<comment>resolve the value of the primary key</comment>
																										<methodInvokeExpression methodName="ResolvePrimaryKey">
																											<parameters>
																												<propertyReferenceExpression name="Controller">
																													<argumentReferenceExpression name="args"/>
																												</propertyReferenceExpression>
																												<propertyReferenceExpression name="Name">
																													<variableReferenceExpression name="fvo"/>
																												</propertyReferenceExpression>
																												<variableReferenceExpression name="value"/>
																												<variableReferenceExpression name="newValue"/>
																											</parameters>
																										</methodInvokeExpression>
																										<assignStatement>
																											<variableReferenceExpression name="value"/>
																											<primitiveExpression value="0"/>
																										</assignStatement>
																										<assignStatement>
																											<propertyReferenceExpression name="NewValue">
																												<variableReferenceExpression name="fvo"/>
																											</propertyReferenceExpression>
																											<variableReferenceExpression name="newValue"/>
																										</assignStatement>
																									</trueStatements>
																									<falseStatements>
																										<comment>inject a missing default value in the arguments</comment>
																										<variableDeclarationStatement type="FieldValue" name="newFieldValue">
																											<init>
																												<primitiveExpression value="null"/>
																											</init>
																										</variableDeclarationStatement>
																										<conditionStatement>
																											<condition>
																												<methodInvokeExpression methodName="TryGetValue">
																													<target>
																														<variableReferenceExpression name="values"/>
																													</target>
																													<parameters>
																														<propertyReferenceExpression name="Name">
																															<variableReferenceExpression name="field"/>
																														</propertyReferenceExpression>
																														<directionExpression direction="Out">
																															<variableReferenceExpression name="newFieldValue"/>
																														</directionExpression>
																													</parameters>
																												</methodInvokeExpression>
																											</condition>
																											<trueStatements>
																												<conditionStatement>
																													<condition>
																														<unaryOperatorExpression operator="Not">
																															<propertyReferenceExpression name="Modified">
																																<variableReferenceExpression name="newFieldValue"/>
																															</propertyReferenceExpression>
																														</unaryOperatorExpression>
																													</condition>
																													<trueStatements>
																														<assignStatement>
																															<propertyReferenceExpression name="NewValue">
																																<variableReferenceExpression name="newFieldValue"/>
																															</propertyReferenceExpression>
																															<variableReferenceExpression name="newValue"/>
																														</assignStatement>
																														<assignStatement>
																															<propertyReferenceExpression name="Modified">
																																<variableReferenceExpression name="newFieldValue"/>
																															</propertyReferenceExpression>
																															<primitiveExpression value="true"/>
																														</assignStatement>
																													</trueStatements>
																												</conditionStatement>
																											</trueStatements>
																											<falseStatements>
																												<variableDeclarationStatement type="List" name="newValues">
																													<typeArguments>
																														<typeReference type="FieldValue"/>
																													</typeArguments>
																													<init>
																														<objectCreateExpression type="List">
																															<typeArguments>
																																<typeReference type="FieldValue"/>
																															</typeArguments>
																															<parameters>
																																<propertyReferenceExpression name="Values">
																																	<argumentReferenceExpression name="args"/>
																																</propertyReferenceExpression>
																															</parameters>
																														</objectCreateExpression>
																													</init>
																												</variableDeclarationStatement>
																												<assignStatement>
																													<variableReferenceExpression name="newFieldValue"/>
																													<objectCreateExpression type="FieldValue">
																														<parameters>
																															<propertyReferenceExpression name="Name">
																																<variableReferenceExpression name="field"/>
																															</propertyReferenceExpression>
																															<variableReferenceExpression name="newValue"/>
																														</parameters>
																													</objectCreateExpression>
																												</assignStatement>
																												<methodInvokeExpression methodName="Add">
																													<target>
																														<variableReferenceExpression name="newValues"/>
																													</target>
																													<parameters>
																														<variableReferenceExpression name="newFieldValue"/>
																													</parameters>
																												</methodInvokeExpression>
																												<assignStatement>
																													<propertyReferenceExpression name="Values">
																														<argumentReferenceExpression name="args"/>
																													</propertyReferenceExpression>
																													<methodInvokeExpression methodName="ToArray">
																														<target>
																															<variableReferenceExpression name="newValues"/>
																														</target>
																													</methodInvokeExpression>
																												</assignStatement>
																												<assignStatement>
																													<arrayIndexerExpression>
																														<target>
																															<variableReferenceExpression name="values"/>
																														</target>
																														<indices>
																															<propertyReferenceExpression name="Name">
																																<variableReferenceExpression name="field"/>
																															</propertyReferenceExpression>
																														</indices>
																													</arrayIndexerExpression>
																													<variableReferenceExpression name="newFieldValue"/>
																												</assignStatement>
																											</falseStatements>
																										</conditionStatement>
																									</falseStatements>
																								</conditionStatement>
																							</trueStatements>
																						</conditionStatement>
																					</statements>
																				</forStatement>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
																<comment>resolve the primary key after the command execution</comment>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="LessThan">
																			<variableReferenceExpression name="value"/>
																			<primitiveExpression value="0"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<propertyReferenceExpression name="CommandName">
																						<argumentReferenceExpression name="args"/>
																					</propertyReferenceExpression>
																					<primitiveExpression value="Insert"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="IdentityEquality">
																							<methodInvokeExpression methodName="SelectSingleNode">
																								<target>
																									<variableReferenceExpression name="pkNav"/>
																								</target>
																								<parameters>
																									<primitiveExpression>
																										<xsl:attribute name="value"><![CDATA[c:items/@dataController]]></xsl:attribute>
																									</primitiveExpression>
																									<propertyReferenceExpression name="Resolver">
																										<argumentReferenceExpression name="config"/>
																									</propertyReferenceExpression>
																								</parameters>
																							</methodInvokeExpression>
																							<primitiveExpression value="null"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<fieldReferenceExpression name="pk"/>
																							<objectCreateExpression type="FieldValue">
																								<parameters>
																									<propertyReferenceExpression name="Name">
																										<variableReferenceExpression name="fvo"/>
																									</propertyReferenceExpression>
																									<variableReferenceExpression name="value"/>
																								</parameters>
																							</objectCreateExpression>
																						</assignStatement>
																						<assignStatement>
																							<propertyReferenceExpression name="NewValue">
																								<variableReferenceExpression name="fvo"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="null"/>
																						</assignStatement>
																						<assignStatement>
																							<propertyReferenceExpression name="Modified">
																								<variableReferenceExpression name="fvo"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="false"/>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																			</trueStatements>
																			<falseStatements>
																				<comment>otherwise try to resolve the primary key</comment>
																				<variableDeclarationStatement type="System.Object" name="resolvedKey">
																					<init>
																						<primitiveExpression value="null"/>
																					</init>
																				</variableDeclarationStatement>
																				<variableDeclarationStatement name="fkValue">
																					<init>
																						<primitiveExpression value="0"/>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="BooleanAnd">
																							<methodInvokeExpression methodName="TryParseTempPK">
																								<parameters>
																									<propertyReferenceExpression name="Value">
																										<variableReferenceExpression name="fvo"/>
																									</propertyReferenceExpression>
																									<directionExpression direction="Out">
																										<variableReferenceExpression name="fkValue"/>
																									</directionExpression>
																								</parameters>
																							</methodInvokeExpression>
																							<methodInvokeExpression methodName="TryGetValue">
																								<target>
																									<fieldReferenceExpression name="resolvedKeys"/>
																								</target>
																								<parameters>
																									<stringFormatExpression format="{{0}}${{1}}">
																										<propertyReferenceExpression name="Controller">
																											<argumentReferenceExpression name="args"/>
																										</propertyReferenceExpression>
																										<variableReferenceExpression name="fkValue"/>
																									</stringFormatExpression>
																									<directionExpression direction="Out">
																										<variableReferenceExpression name="resolvedKey"/>
																									</directionExpression>
																								</parameters>
																							</methodInvokeExpression>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<conditionStatement>
																							<condition>
																								<propertyReferenceExpression name="Modified">
																									<variableReferenceExpression name="fvo"/>
																								</propertyReferenceExpression>
																							</condition>
																							<trueStatements>
																								<assignStatement>
																									<propertyReferenceExpression name="NewValue">
																										<variableReferenceExpression name="fvo"/>
																									</propertyReferenceExpression>
																									<variableReferenceExpression name="resolvedKey"/>
																								</assignStatement>
																							</trueStatements>
																							<falseStatements>
																								<assignStatement>
																									<propertyReferenceExpression name="OldValue">
																										<variableReferenceExpression name="fvo"/>
																									</propertyReferenceExpression>
																									<variableReferenceExpression name="resolvedKey"/>
																								</assignStatement>
																							</falseStatements>
																						</conditionStatement>
																					</trueStatements>
																				</conditionStatement>
																			</falseStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<comment>resolve negative foreign keys</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Count">
												<fieldReferenceExpression name="resolvedKeys"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="XPathNodeIterator" name="fkIterator">
											<init>
												<methodInvokeExpression methodName="Select">
													<target>
														<argumentReferenceExpression name="config"/>
													</target>
													<parameters>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[/c:dataController/c:fields/c:field[c:items/@dataController]]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<methodInvokeExpression methodName="MoveNext">
													<target>
														<variableReferenceExpression name="fkIterator"/>
													</target>
												</methodInvokeExpression>
											</test>
											<statements>
												<variableDeclarationStatement type="FieldValue" name="fvo">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="TryGetValue">
															<target>
																<variableReferenceExpression name="values"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="GetAttribute">
																	<target>
																		<propertyReferenceExpression name="Current">
																			<variableReferenceExpression name="fkIterator"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="name"/>
																		<stringEmptyExpression/>
																	</parameters>
																</methodInvokeExpression>
																<directionExpression direction="Out">
																	<variableReferenceExpression name="fvo"/>
																</directionExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="XPathNavigator" name="itemsDataControllerNav">
															<init>
																<methodInvokeExpression methodName="SelectSingleNode">
																	<target>
																		<propertyReferenceExpression name="Current">
																			<variableReferenceExpression name="fkIterator"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[c:items/@dataController]]></xsl:attribute>
																		</primitiveExpression>
																		<propertyReferenceExpression name="Resolver">
																			<argumentReferenceExpression name="config"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Object" name="resolvedKey">
															<init>
																<primitiveExpression value="null"/>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="fkValue">
															<init>
																<primitiveExpression value="0"/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<methodInvokeExpression methodName="TryParseTempPK">
																		<parameters>
																			<propertyReferenceExpression name="Value">
																				<variableReferenceExpression name="fvo"/>
																			</propertyReferenceExpression>
																			<directionExpression direction="Out">
																				<variableReferenceExpression name="fkValue"/>
																			</directionExpression>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="TryGetValue">
																		<target>
																			<fieldReferenceExpression name="resolvedKeys"/>
																		</target>
																		<parameters>
																			<stringFormatExpression format="{{0}}${{1}}">
																				<propertyReferenceExpression name="Value">
																					<variableReferenceExpression name="itemsDataControllerNav"/>
																				</propertyReferenceExpression>
																				<variableReferenceExpression name="fkValue"/>
																			</stringFormatExpression>
																			<directionExpression direction="Out">
																				<variableReferenceExpression name="resolvedKey"/>
																			</directionExpression>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<propertyReferenceExpression name="Modified">
																			<variableReferenceExpression name="fvo"/>
																		</propertyReferenceExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="NewValue">
																				<variableReferenceExpression name="fvo"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="resolvedKey"/>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="OldValue">
																				<variableReferenceExpression name="fvo"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="resolvedKey"/>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</whileStatement>
									</trueStatements>
								</conditionStatement>
								<comment>scan resolved primary keys and look for the one that are matching the keys referenced in SelectedValues, ExternalFilter, or Filter of the action</comment>
								<foreachStatement>
									<variable name="resolvedKeyInfo"/>
									<target>
										<propertyReferenceExpression name="Keys">
											<fieldReferenceExpression name="resolvedKeys"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<variableDeclarationStatement name="separatorIndex">
											<init>
												<methodInvokeExpression methodName="IndexOf">
													<target>
														<variableReferenceExpression name="resolvedKeyInfo"/>
													</target>
													<parameters>
														<primitiveExpression value="$"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="resolvedController">
											<init>
												<methodInvokeExpression methodName="Substring">
													<target>
														<variableReferenceExpression name="resolvedKeyInfo"/>
													</target>
													<parameters>
														<primitiveExpression value="0"/>
														<variableReferenceExpression name="separatorIndex"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="unresolvedKeyValue">
											<init>
												<methodInvokeExpression methodName="Substring">
													<target>
														<variableReferenceExpression name="resolvedKeyInfo"/>
													</target>
													<parameters>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="separatorIndex"/>
															<primitiveExpression value="1"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Object" name="resolvedKeyValue">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="Controller">
															<argumentReferenceExpression name="args"/>
														</propertyReferenceExpression>
														<variableReferenceExpression name="resolvedController"/>
													</binaryOperatorExpression>
													<methodInvokeExpression methodName="TryGetValue">
														<target>
															<fieldReferenceExpression name="resolvedKeys"/>
														</target>
														<parameters>
															<variableReferenceExpression name="resolvedKeyInfo"/>
															<directionExpression direction="Out">
																<variableReferenceExpression name="resolvedKeyValue"/>
															</directionExpression>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="resolvedKeyValueAsString">
													<init>
														<methodInvokeExpression methodName="ToString">
															<target>
																<variableReferenceExpression name="resolvedKeyValue"/>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<comment>resolve primary key references in SelectedValues</comment>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<propertyReferenceExpression name="SelectedValues">
																<variableReferenceExpression name="args"/>
															</propertyReferenceExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<forStatement>
															<variable name="selectedValueIndex">
																<init>
																	<primitiveExpression value="0"/>
																</init>
															</variable>
															<test>
																<binaryOperatorExpression operator="LessThan">
																	<variableReferenceExpression name="selectedValueIndex"/>
																	<propertyReferenceExpression name="Length">
																		<propertyReferenceExpression name="SelectedValues">
																			<variableReferenceExpression name="args"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</test>
															<increment>
																<variableReferenceExpression name="selectedValueIndex"/>
															</increment>
															<statements>
																<variableDeclarationStatement name="selectedKey">
																	<init>
																		<methodInvokeExpression methodName="Split">
																			<target>
																				<typeReferenceExpression type="Regex"/>
																			</target>
																			<parameters>
																				<arrayIndexerExpression>
																					<target>
																						<propertyReferenceExpression name="SelectedValues">
																							<variableReferenceExpression name="args"/>
																						</propertyReferenceExpression>
																					</target>
																					<indices>
																						<variableReferenceExpression name="selectedValueIndex"/>
																					</indices>
																				</arrayIndexerExpression>
																				<primitiveExpression value=","/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="tempPK">
																	<init>
																		<primitiveExpression value="0"/>
																	</init>
																</variableDeclarationStatement>
																<forStatement>
																	<variable name="keyValueIndex">
																		<init>
																			<primitiveExpression value="0"/>
																		</init>
																	</variable>
																	<test>
																		<binaryOperatorExpression operator="LessThan">
																			<variableReferenceExpression name="keyValueIndex"/>
																			<propertyReferenceExpression name="Length">
																				<variableReferenceExpression name="selectedKey"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</test>
																	<increment>
																		<variableReferenceExpression name="keyValueIndex"/>
																	</increment>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanAnd">
																					<methodInvokeExpression methodName="TryParseTempPK">
																						<parameters>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="selectedKey"/>
																								</target>
																								<indices>
																									<variableReferenceExpression name="keyValueIndex"/>
																								</indices>
																							</arrayIndexerExpression>
																							<directionExpression direction="Out">
																								<variableReferenceExpression name="tempPK"/>
																							</directionExpression>
																						</parameters>
																					</methodInvokeExpression>
																					<binaryOperatorExpression operator="ValueEquality">
																						<convertExpression to="String">
																							<variableReferenceExpression name="tempPK"/>
																						</convertExpression>
																						<variableReferenceExpression name="unresolvedKeyValue"/>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="selectedKey"/>
																						</target>
																						<indices>
																							<variableReferenceExpression name="keyValueIndex"/>
																						</indices>
																					</arrayIndexerExpression>
																					<variableReferenceExpression name="resolvedKeyValueAsString"/>
																				</assignStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<propertyReferenceExpression name="SelectedValues">
																								<argumentReferenceExpression name="args"/>
																							</propertyReferenceExpression>
																						</target>
																						<indices>
																							<variableReferenceExpression name="selectedValueIndex"/>
																						</indices>
																					</arrayIndexerExpression>
																					<methodInvokeExpression methodName="Join">
																						<target>
																							<typeReferenceExpression type="System.String"/>
																						</target>
																						<parameters>
																							<primitiveExpression value=","/>
																							<variableReferenceExpression name="selectedKey"/>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																				<assignStatement>
																					<variableReferenceExpression name="selectedKey"/>
																					<primitiveExpression value="null"/>
																				</assignStatement>
																				<breakStatement/>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</forStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityEquality">
																			<variableReferenceExpression name="selectedKey"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<breakStatement/>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</forStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
						<!-- method ProcessResult(ControllerConfiguration, ActionResult, List<ControllerFieldValue> -->
						<memberMethod name="ProcessResult">
							<attributes family="true"/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="pk"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable name="fvo"/>
											<target>
												<propertyReferenceExpression name="Values">
													<argumentReferenceExpression name="result"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<methodInvokeExpression methodName="Add">
													<target>
														<propertyReferenceExpression name="Values">
															<fieldReferenceExpression name="commitResult"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<objectCreateExpression type="ControllerFieldValue">
															<parameters>
																<propertyReferenceExpression name="ControllerName">
																	<argumentReferenceExpression name="config"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="fvo"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="OldValue">
																	<variableReferenceExpression name="fvo"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="NewValue">
																	<variableReferenceExpression name="fvo"/>
																</propertyReferenceExpression>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</foreachStatement>
									</trueStatements>
									<falseStatements>
										<foreachStatement>
											<variable type="FieldValue" name="fvo"/>
											<target>
												<propertyReferenceExpression name="Values">
													<argumentReferenceExpression name="result"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="fvo"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Name">
																<fieldReferenceExpression name="pk"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ResolvePrimaryKey">
															<parameters>
																<propertyReferenceExpression name="ControllerName">
																	<argumentReferenceExpression name="config"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="fvo"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Value">
																	<fieldReferenceExpression name="pk"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="fvo"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<breakStatement/>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method Commit(JArray) -->
						<memberMethod returnType="CommitResult" name="Commit">
							<attributes public="true"/>
							<parameters>
								<parameter type="JArray" name="log"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="list">
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="ActionArgs"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable name="entry"/>
									<target>
										<argumentReferenceExpression name="log"/>
									</target>
									<statements>
										<variableDeclarationStatement name="executeArgs">
											<init>
												<methodInvokeExpression methodName="ToObject">
													<typeArguments>
														<typeReference type="ActionArgs"/>
													</typeArguments>
													<target>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="entry"/>
															</target>
															<indices>
																<primitiveExpression value="args"/>
															</indices>
														</arrayIndexerExpression>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="controller">
											<init>
												<castExpression targetType="System.String">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="entry"/>
														</target>
														<indices>
															<primitiveExpression value="controller"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="view">
											<init>
												<castExpression targetType="System.String">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="entry"/>
														</target>
														<indices>
															<primitiveExpression value="view"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="ValueEquality">
														<variableReferenceExpression name="controller"/>
														<propertyReferenceExpression name="Controller">
															<variableReferenceExpression name="executeArgs"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<variableReferenceExpression name="view"/>
														<propertyReferenceExpression name="View">
															<variableReferenceExpression name="executeArgs"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="list"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="executeArgs"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Commit">
										<parameters>
											<variableReferenceExpression name="list"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Commit(List<ActionArgs>) -->
						<memberMethod returnType="CommitResult" name="Commit">
							<attributes public="true"/>
							<parameters>
								<parameter type="List" name="log">
									<typeArguments>
										<typeReference type="ActionArgs"/>
									</typeArguments>
								</parameter>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="commitResult"/>
									<objectCreateExpression type="CommitResult"/>
								</assignStatement>
								<tryStatement>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Count">
														<argumentReferenceExpression name="log"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<usingStatement>
													<variable type="DataTransaction" name="tx">
														<init>
															<objectCreateExpression type="DataTransaction">
																<parameters>
																	<propertyReferenceExpression name="ConnectionStringName">
																		<methodInvokeExpression methodName="LoadConfig">
																			<parameters>
																				<propertyReferenceExpression name="Controller">
																					<arrayIndexerExpression>
																						<target>
																							<argumentReferenceExpression name="log"/>
																						</target>
																						<indices>
																							<primitiveExpression value="0"/>
																						</indices>
																					</arrayIndexerExpression>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</init>
													</variable>
													<statements>
														<variableDeclarationStatement name="index">
															<init>
																<primitiveExpression value="-1"/>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="sequence">
															<init>
																<primitiveExpression value="-1"/>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="lastSequence">
															<init>
																<variableReferenceExpression name="sequence"/>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="commitedValueCount">
															<init>
																<propertyReferenceExpression name="Count">
																	<propertyReferenceExpression name="Values">
																		<fieldReferenceExpression name="commitResult"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="transactionScope">
															<init>
																<castExpression targetType="System.String">
																	<methodInvokeExpression methodName="Settings">
																		<target>
																			<typeReferenceExpression type="ApplicationServices"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="odp.transactions.scope"/>
																		</parameters>
																	</methodInvokeExpression>
																</castExpression>
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
																		<argumentReferenceExpression name="log"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</test>
															<increment>
																<variableReferenceExpression name="i"/>
															</increment>
															<statements>
																<methodInvokeExpression methodName="Forget">
																	<target>
																		<typeReferenceExpression type="ActionArgs"/>
																	</target>
																</methodInvokeExpression>
																<variableDeclarationStatement name="executeArgs">
																	<init>
																		<arrayIndexerExpression>
																			<target>
																				<argumentReferenceExpression name="log"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="i"/>
																			</indices>
																		</arrayIndexerExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="entry">
																	<init>
																		<arrayIndexerExpression>
																			<target>
																				<argumentReferenceExpression name="log"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="i"/>
																			</indices>
																		</arrayIndexerExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="controller">
																	<init>
																		<propertyReferenceExpression name="Controller">
																			<variableReferenceExpression name="executeArgs"/>
																		</propertyReferenceExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="view">
																	<init>
																		<propertyReferenceExpression name="View">
																			<variableReferenceExpression name="executeArgs"/>
																		</propertyReferenceExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<propertyReferenceExpression name="HasValue">
																			<propertyReferenceExpression name="Sequence">
																				<variableReferenceExpression name="executeArgs"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="sequence"/>
																			<propertyReferenceExpression name="Value">
																				<propertyReferenceExpression name="Sequence">
																					<variableReferenceExpression name="executeArgs"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</assignStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanAnd">
																					<binaryOperatorExpression operator="ValueInequality">
																						<variableReferenceExpression name="transactionScope"/>
																						<primitiveExpression value="all"/>
																					</binaryOperatorExpression>
																					<binaryOperatorExpression operator="BooleanAnd">
																						<binaryOperatorExpression operator="ValueInequality">
																							<variableReferenceExpression name="sequence"/>
																							<variableReferenceExpression name="lastSequence"/>
																						</binaryOperatorExpression>
																						<binaryOperatorExpression operator="GreaterThan">
																							<variableReferenceExpression name="i"/>
																							<primitiveExpression value="0"/>
																						</binaryOperatorExpression>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Commit">
																					<target>
																						<variableReferenceExpression name="tx"/>
																					</target>
																				</methodInvokeExpression>
																				<assignStatement>
																					<propertyReferenceExpression name="Sequence">
																						<fieldReferenceExpression name="commitResult"/>
																					</propertyReferenceExpression>
																					<variableReferenceExpression name="lastSequence"/>
																				</assignStatement>
																				<assignStatement>
																					<variableReferenceExpression name="commitedValueCount"/>
																					<propertyReferenceExpression name="Count">
																						<propertyReferenceExpression name="Values">
																							<fieldReferenceExpression name="commitResult"/>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																				</assignStatement>
																				<methodInvokeExpression methodName="BeginTransaction">
																					<target>
																						<variableReferenceExpression name="tx"/>
																					</target>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<variableReferenceExpression name="lastSequence"/>
																			<variableReferenceExpression name="sequence"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<variableDeclarationStatement type="ControllerConfiguration" name="config">
																	<init>
																		<methodInvokeExpression methodName="LoadConfig">
																			<parameters>
																				<propertyReferenceExpression name="Controller">
																					<variableReferenceExpression name="executeArgs"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<methodInvokeExpression methodName="ProcessArguments">
																	<parameters>
																		<variableReferenceExpression name="config"/>
																		<variableReferenceExpression name="executeArgs"/>
																	</parameters>
																</methodInvokeExpression>
																<variableDeclarationStatement type="ActionResult" name="executeResult">
																	<init>
																		<methodInvokeExpression methodName="Execute">
																			<target>
																				<methodInvokeExpression methodName="CreateDataController">
																					<target>
																						<typeReferenceExpression type="ControllerFactory"/>
																					</target>
																				</methodInvokeExpression>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="controller"/>
																				<variableReferenceExpression name="view"/>
																				<variableReferenceExpression name="executeArgs"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="GreaterThan">
																			<propertyReferenceExpression name="Count">
																				<propertyReferenceExpression name="Errors">
																					<variableReferenceExpression name="executeResult"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																			<primitiveExpression value="0"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="index"/>
																			<variableReferenceExpression name="i"/>
																		</assignStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="Index">
																				<fieldReferenceExpression name="commitResult"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="index"/>
																		</assignStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="Errors">
																				<fieldReferenceExpression name="commitResult"/>
																			</propertyReferenceExpression>
																			<methodInvokeExpression methodName="ToArray">
																				<target>
																					<propertyReferenceExpression name="Errors">
																						<variableReferenceExpression name="executeResult"/>
																					</propertyReferenceExpression>
																				</target>
																			</methodInvokeExpression>
																		</assignStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="RowNotFound">
																				<fieldReferenceExpression name="commitResult"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="RowNotFound">
																				<variableReferenceExpression name="executeResult"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																		<breakStatement/>
																	</trueStatements>
																	<falseStatements>
																		<methodInvokeExpression methodName="ProcessResult">
																			<parameters>
																				<variableReferenceExpression name="config"/>
																				<variableReferenceExpression name="executeResult"/>
																			</parameters>
																		</methodInvokeExpression>
																	</falseStatements>
																</conditionStatement>
															</statements>
														</forStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="index"/>
																	<primitiveExpression value="-1"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Commit">
																	<target>
																		<variableReferenceExpression name="tx"/>
																	</target>
																</methodInvokeExpression>
																<assignStatement>
																	<propertyReferenceExpression name="Sequence">
																		<fieldReferenceExpression name="commitResult"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="sequence"/>
																</assignStatement>
																<assignStatement>
																	<variableReferenceExpression name="commitedValueCount"/>
																	<propertyReferenceExpression name="Count">
																		<propertyReferenceExpression name="Values">
																			<fieldReferenceExpression name="commitResult"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="Rollback">
																	<target>
																		<variableReferenceExpression name="tx"/>
																	</target>
																</methodInvokeExpression>
																<assignStatement>
																	<propertyReferenceExpression name="Index">
																		<fieldReferenceExpression name="commitResult"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="index"/>
																</assignStatement>
																<methodInvokeExpression methodName="RemoveRange">
																	<target>
																		<propertyReferenceExpression name="Values">
																			<fieldReferenceExpression name="commitResult"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="commitedValueCount"/>
																		<binaryOperatorExpression operator="Subtract">
																			<propertyReferenceExpression name="Count">
																				<propertyReferenceExpression name="Values">
																					<fieldReferenceExpression name="commitResult"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="commitedValueCount"/>
																		</binaryOperatorExpression>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
													</statements>
												</usingStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
									<catch exceptionType="Exception" localName="ex">
										<assignStatement>
											<propertyReferenceExpression name="Errors">
												<fieldReferenceExpression name="commitResult"/>
											</propertyReferenceExpression>
											<arrayCreateExpression>
												<createType type="System.String"/>
												<initializers>
													<propertyReferenceExpression name="Message">
														<variableReferenceExpression name="ex"/>
													</propertyReferenceExpression>
												</initializers>
											</arrayCreateExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Index">
												<fieldReferenceExpression name="commitResult"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</assignStatement>
									</catch>
								</tryStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="commitResult"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
