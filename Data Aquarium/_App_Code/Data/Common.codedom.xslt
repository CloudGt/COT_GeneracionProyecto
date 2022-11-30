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
				<namespaceImport name="System.Configuration"/>
				<namespaceImport name="System.Data.Common"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Reflection"/>
				<namespaceImport name="System.Security.Cryptography"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Caching"/>
				<namespaceImport name="System.Xml"/>
				<namespaceImport name="Newtonsoft.Json"/>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
				<namespaceImport name="YamlDotNet.Serialization"/>
				<namespaceImport name="{a:project/a:namespace}.Services"/>
				<namespaceImport name="{a:project/a:namespace}.Services.Rest"/>
			</imports>
			<types>
				<!-- class SelectClauseDictionary -->
				<typeDeclaration name="SelectClauseDictionary">
					<baseTypes>
						<typeReference type="SortedDictionary">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
						</typeReference>
					</baseTypes>
					<members>
						<!-- property TrackAliases -->
						<memberProperty type="System.Boolean" name="TrackAliases">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ReferencedAliases -->
						<memberProperty type="List" name="ReferencedAliases">
							<typeArguments>
								<typeReference type="System.String"/>
							</typeArguments>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- string this[string] -->
						<memberProperty type="System.String" name="Item">
							<attributes new="true" public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<getStatements>
								<variableDeclarationStatement type="System.String" name="expression">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="TryGetValue">
												<parameters>
													<methodInvokeExpression methodName="ToLower">
														<target>
															<argumentReferenceExpression name="name"/>
														</target>
													</methodInvokeExpression>
													<directionExpression direction="Out">
														<variableReferenceExpression name="expression"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="expression"/>
											<primitiveExpression value="null" convertTo="String"/>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="TrackAliases"/>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="Match" name="m">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="expression"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[^('|"|\[|`)(?'Alias'.+?)('|"|\]|`)]]></xsl:attribute>
																</primitiveExpression>
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
																<binaryOperatorExpression operator="IdentityEquality">
																	<propertyReferenceExpression name="ReferencedAliases"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="ReferencedAliases"/>
																	<objectCreateExpression type="List">
																		<typeArguments>
																			<typeReference type="System.String"/>
																		</typeArguments>
																	</objectCreateExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<variableDeclarationStatement type="System.String" name="aliasName">
															<init>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="m"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Alias"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<propertyReferenceExpression name="Success">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																	<unaryOperatorExpression operator="Not">
																		<methodInvokeExpression methodName="Contains">
																			<target>
																				<propertyReferenceExpression name="ReferencedAliases"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="aliasName"/>
																			</parameters>
																		</methodInvokeExpression>
																	</unaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<propertyReferenceExpression name="ReferencedAliases"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="aliasName"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="expression"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<baseReferenceExpression/>
										</target>
										<indices>
											<methodInvokeExpression methodName="ToLower">
												<target>
													<argumentReferenceExpression name="name"/>
												</target>
											</methodInvokeExpression>
										</indices>
									</arrayIndexerExpression>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- bool ContainsKey(string) -->
						<memberMethod returnType="System.Boolean" name="ContainsKey">
							<attributes public="true" new="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ContainsKey">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="ToLower">
												<target>
													<argumentReferenceExpression name="name"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- void Add(string, string) -->
						<memberMethod name="Add">
							<attributes new="true" final="true" public="true"/>
							<parameters>
								<parameter name="key" type="System.String"/>
								<parameter type="System.String" name="value"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="Add">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<methodInvokeExpression methodName="ToLower">
											<target>
												<argumentReferenceExpression name="key"/>
											</target>
										</methodInvokeExpression>
										<argumentReferenceExpression name="value"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- bool TryGetValue(string key, out string) -->
						<memberMethod returnType="System.Boolean" name="TryGetValue">
							<attributes new="true" final="true" public="true"/>
							<parameters>
								<parameter type="System.String" name="key"/>
								<parameter type="System.String" name="value" direction="Out"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="TryGetValue">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="ToLower">
												<target>
													<argumentReferenceExpression name="key"/>
												</target>
											</methodInvokeExpression>
											<directionExpression direction="Out">
												<argumentReferenceExpression name="value"/>
											</directionExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- interface IDataController -->
				<typeDeclaration name="IDataController" isInterface="true">
					<members>
						<memberMethod returnType="ViewPage" name="GetPage">
							<attributes/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="PageRequest" name="request"/>
							</parameters>
						</memberMethod>
						<memberMethod returnType="System.Object[]" name="GetListOfValues">
							<attributes/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="DistinctValueRequest" name="request"/>
							</parameters>
						</memberMethod>
						<memberMethod returnType="ActionResult" name="Execute">
							<attributes/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="ActionArgs" name="args"/>
							</parameters>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- interface IAutoCompleteManager -->
				<typeDeclaration name="IAutoCompleteManager" isInterface="true">
					<members>
						<memberMethod returnType="System.String[]" name="GetCompletionList">
							<attributes/>
							<parameters>
								<parameter type="System.String" name="prefixText"/>
								<parameter type="System.Int32" name="count"/>
								<parameter type="System.String" name="contextKey"/>
							</parameters>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- interface IActionHandler -->
				<typeDeclaration name="IActionHandler" isInterface="true">
					<members>
						<memberMethod name="BeforeSqlAction">
							<attributes/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
						</memberMethod>
						<memberMethod name="AfterSqlAction">
							<attributes/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
						</memberMethod>
						<memberMethod name="ExecuteAction">
							<attributes/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- inteface IRowHandler -->
				<typeDeclaration name="IRowHandler" isInterface="true">
					<members>
						<memberMethod returnType="System.Boolean" name="SupportsNewRow">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="requet"/>
							</parameters>
						</memberMethod>
						<memberMethod name="NewRow">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
								<parameter type="System.Object[]" name="row"/>
							</parameters>
						</memberMethod>
						<memberMethod returnType="System.Boolean" name="SupportsPrepareRow">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
							</parameters>
						</memberMethod>
						<memberMethod name="PrepareRow">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
								<parameter type="System.Object[]" name="row"/>
							</parameters>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- interface IDataFilter -->
				<typeDeclaration name="IDataFilter" isInterface="true">
					<members>
						<memberMethod name="Filter">
							<attributes/>
							<parameters>
								<parameter type="SortedDictionary" name="filter">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="System.Object"/>
									</typeArguments>
								</parameter>
							</parameters>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- interface IDataFilter2 -->
				<typeDeclaration name="IDataFilter2" isInterface="true">
					<members>
						<memberMethod name="Filter">
							<attributes/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="SortedDictionary" name="filter">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="System.Object"/>
									</typeArguments>
								</parameter>
							</parameters>
						</memberMethod>
						<memberMethod name="AssignContext">
							<attributes/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="lookupContextController"/>
								<parameter type="System.String" name="lookupContextView"/>
								<parameter type="System.String" name="lookupContextFieldName"/>
							</parameters>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- interface IDataEngine -->
				<typeDeclaration name="IDataEngine" isInterface="true">
					<members>
						<memberMethod returnType="DbDataReader" name="ExecuteReader">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
							</parameters>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- inteface IPlugIn -->
				<typeDeclaration name="IPlugIn" isInterface="true">
					<members>
						<memberProperty type="ControllerConfiguration" name="Config">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<methodReturnStatement/>
							</setStatements>
						</memberProperty>
						<memberMethod returnType="ControllerConfiguration" name="Create">
							<attributes/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
							</parameters>
						</memberMethod>
						<memberMethod name="PreProcessPageRequest">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
							</parameters>
						</memberMethod>
						<memberMethod name="ProcessPageRequest">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
							</parameters>
						</memberMethod>
						<memberMethod name="PreProcessArguments">
							<attributes/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
								<parameter type="ViewPage" name="page"/>
							</parameters>
						</memberMethod>
						<memberMethod name="ProcessArguments">
							<attributes/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
								<parameter type="ViewPage" name="page"/>
							</parameters>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- class BusinessObjectParameters -->
				<typeDeclaration name="BusinessObjectParameters">
					<baseTypes>
						<typeReference type="SortedDictionary">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.Object"/>
							</typeArguments>
						</typeReference>
					</baseTypes>
					<members>
						<memberField type="System.String" name="parameterMarker">
							<init>
								<primitiveExpression value="null"/>
							</init>
						</memberField>
						<!-- constructor() -->
						<constructor>
							<attributes public="true"/>
						</constructor>
						<!-- contructor(params object[]) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="params System.Object[]" name="values"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="Assign">
									<parameters>
										<argumentReferenceExpression name="values"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</constructor>
						<!-- method Create(string, params object[]) -->
						<memberMethod returnType="BusinessObjectParameters" name="Create">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="parameterMarker"/>
								<parameter type="params System.Object[]" name="values"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="BusinessObjectParameters" name="paramList">
									<init>
										<objectCreateExpression type="BusinessObjectParameters"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<fieldReferenceExpression name="parameterMarker">
										<variableReferenceExpression name="paramList"/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="parameterMarker"/>
								</assignStatement>
								<methodInvokeExpression methodName="Assign">
									<target>
										<variableReferenceExpression name="paramList"/>
									</target>
									<parameters>
										<argumentReferenceExpression name="values"/>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<variableReferenceExpression name="paramList"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Assign(params object[]) -->
						<memberMethod name="Assign">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="params System.Object[]" name="values"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="parameterMarker">
									<init>
										<fieldReferenceExpression name="parameterMarker"/>
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
											<propertyReferenceExpression name="Length">
												<argumentReferenceExpression name="values"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="i"/>
									</increment>
									<statements>
										<variableDeclarationStatement type="System.Object" name="v">
											<init>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="values"/>
													</target>
													<indices>
														<variableReferenceExpression name="i"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IsTypeOf">
													<variableReferenceExpression name="v"/>
													<typeReferenceExpression type="FieldValue"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="FieldValue" name="fv">
													<init>
														<castExpression targetType="FieldValue">
															<variableReferenceExpression name="v"/>
														</castExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="Add">
													<parameters>
														<propertyReferenceExpression name="Name">
															<variableReferenceExpression name="fv"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="Value">
															<variableReferenceExpression name="fv"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IsTypeOf">
															<variableReferenceExpression name="v"/>
															<typeReferenceExpression type="SortedDictionary">
																<typeArguments>
																	<typeReference type="System.String"/>
																	<typeReference type="System.Object"/>
																</typeArguments>
															</typeReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="BusinessObjectParameters" name="paramList">
															<init>
																<castExpression targetType="SortedDictionary">
																	<typeArguments>
																		<typeReference type="System.String"/>
																		<typeReference type="System.Object"/>
																	</typeArguments>
																	<variableReferenceExpression name="v"/>
																</castExpression>
															</init>
														</variableDeclarationStatement>
														<foreachStatement>
															<variable type="System.String" name="name"/>
															<target>
																<propertyReferenceExpression name="Keys">
																	<variableReferenceExpression name="paramList"/>
																</propertyReferenceExpression>
															</target>
															<statements>
																<variableDeclarationStatement name="paramName">
																	<init>
																		<variableReferenceExpression name="name"/>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<unaryOperatorExpression operator="Not">
																				<methodInvokeExpression methodName="IsLetterOrDigit">
																					<target>
																						<typeReferenceExpression type="Char"/>
																					</target>
																					<parameters>
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="paramName"/>
																							</target>
																							<indices>
																								<primitiveExpression value="0"/>
																							</indices>
																						</arrayIndexerExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</unaryOperatorExpression>
																			<unaryOperatorExpression operator="IsNotNullOrEmpty">
																				<variableReferenceExpression name="parameterMarker"/>
																			</unaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="paramName"/>
																			<binaryOperatorExpression operator="Add">
																				<variableReferenceExpression name="parameterMarker"/>
																				<methodInvokeExpression methodName="Substring">
																					<target>
																						<variableReferenceExpression name="paramName"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="1"/>
																					</parameters>
																				</methodInvokeExpression>
																			</binaryOperatorExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="Add">
																	<parameters>
																		<variableReferenceExpression name="paramName"/>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="paramList"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="name"/>
																			</indices>
																		</arrayIndexerExpression>
																	</parameters>
																</methodInvokeExpression>
															</statements>
														</foreachStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNullOrEmpty">
																	<variableReferenceExpression name="parameterMarker"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="parameterMarker"/>
																	<methodInvokeExpression methodName="GetParameterMarker">
																		<target>
																			<typeReferenceExpression type="SqlStatement"/>
																		</target>
																		<parameters>
																			<stringEmptyExpression/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="IdentityInequality">
																		<variableReferenceExpression name="v"/>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="IdentityEquality">
																		<propertyReferenceExpression name="Namespace">
																			<methodInvokeExpression methodName="GetType">
																				<target>
																					<variableReferenceExpression name="v"/>
																				</target>
																			</methodInvokeExpression>
																		</propertyReferenceExpression>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<foreachStatement>
																	<variable type="PropertyInfo" name="pi"/>
																	<target>
																		<methodInvokeExpression methodName="GetProperties">
																			<target>
																				<methodInvokeExpression methodName="GetType">
																					<target>
																						<variableReferenceExpression name="v"/>
																					</target>
																				</methodInvokeExpression>
																			</target>
																		</methodInvokeExpression>
																	</target>
																	<statements>
																		<methodInvokeExpression methodName="Add">
																			<parameters>
																				<binaryOperatorExpression operator="Add">
																					<variableReferenceExpression name="parameterMarker"/>
																					<propertyReferenceExpression name="Name">
																						<variableReferenceExpression name="pi"/>
																					</propertyReferenceExpression>
																				</binaryOperatorExpression>
																				<methodInvokeExpression methodName="GetValue">
																					<target>
																						<variableReferenceExpression name="pi"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="v"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</statements>
																</foreachStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="Add">
																	<parameters>
																		<binaryOperatorExpression operator="Add">
																			<variableReferenceExpression name="parameterMarker"/>
																			<binaryOperatorExpression operator="Add">
																				<primitiveExpression value="p"/>
																				<methodInvokeExpression methodName="ToString">
																					<target>
																						<variableReferenceExpression name="i"/>
																					</target>
																				</methodInvokeExpression>
																			</binaryOperatorExpression>
																		</binaryOperatorExpression>
																		<variableReferenceExpression name="v"/>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</statements>
								</forStatement>
							</statements>
						</memberMethod>
						<!-- method ToWhere() -->
						<memberMethod returnType="System.String" name="ToWhere">
							<attributes public="true" final="true"/>
							<statements>
								<variableDeclarationStatement type="StringBuilder" name="filterExpression">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="paramName"/>
									<target>
										<propertyReferenceExpression name="Keys"/>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="filterExpression"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Append">
													<target>
														<variableReferenceExpression name="filterExpression"/>
													</target>
													<parameters>
														<primitiveExpression value="and"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="System.Object" name="v">
											<init>
												<arrayIndexerExpression>
													<target>
														<thisReferenceExpression/>
													</target>
													<indices>
														<variableReferenceExpression name="paramName"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<methodInvokeExpression methodName="Equals">
														<target>
															<propertyReferenceExpression name="Value">
																<typeReferenceExpression type="DBNull"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<variableReferenceExpression name="v"/>
														</parameters>
													</methodInvokeExpression>
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="v"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="AppendFormat">
													<target>
														<variableReferenceExpression name="filterExpression"/>
													</target>
													<parameters>
														<primitiveExpression value="({{0}} is null)"/>
														<methodInvokeExpression methodName="Substring">
															<target>
																<variableReferenceExpression name="paramName"/>
															</target>
															<parameters>
																<primitiveExpression value="1"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="AppendFormat">
													<target>
														<variableReferenceExpression name="filterExpression"/>
													</target>
													<parameters>
														<primitiveExpression value="({{0}}={{1}})"/>
														<methodInvokeExpression methodName="Substring">
															<target>
																<variableReferenceExpression name="paramName"/>
															</target>
															<parameters>
																<primitiveExpression value="1"/>
															</parameters>
														</methodInvokeExpression>
														<variableReferenceExpression name="paramName"/>
													</parameters>
												</methodInvokeExpression>
											</falseStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToString">
										<target>
											<variableReferenceExpression name="filterExpression"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- interface IBusinessObject -->
				<typeDeclaration name="IBusinessObject" isInterface="true">
					<members>
						<memberMethod name="AssignFilter">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="filter"/>
								<parameter type="BusinessObjectParameters" name="parameters"/>
							</parameters>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- enum CommandConfigurationType -->
				<typeDeclaration name="CommandConfigurationType" isEnum="true">
					<members>
						<memberField name="Select">
							<attributes public="true"/>
						</memberField>
						<memberField name="Update">
							<attributes public="true"/>
						</memberField>
						<memberField name="Insert">
							<attributes public="true"/>
						</memberField>
						<memberField name="Delete">
							<attributes public="true"/>
						</memberField>
						<memberField name="SelectCount">
							<attributes public="true"/>
						</memberField>
						<memberField name="SelectDistinct">
							<attributes public="true"/>
						</memberField>
						<memberField name="SelectAggregates">
							<attributes public="true"/>
						</memberField>
						<memberField name="SelectFirstLetters">
							<attributes public="true"/>
						</memberField>
						<memberField name="SelectExisting">
							<attributes public="true"/>
						</memberField>
						<memberField name="Sync">
							<attributes public="true"/>
						</memberField>
						<memberField name="None">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>

				<!-- class TextUtility -->
				<typeDeclaration name="TextUtility">
					<attributes public="true"/>
					<members>
						<!-- method byte[] HexToByte(string) -->
						<memberMethod returnType="System.Byte[]" name="HexToByte">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="hexString"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="returnBytes">
									<init>
										<arrayCreateExpression>
											<createType type="System.Byte"/>
											<sizeExpression>
												<binaryOperatorExpression operator="Divide">
													<propertyReferenceExpression name="Length">
														<argumentReferenceExpression name="hexString"/>
													</propertyReferenceExpression>
													<primitiveExpression value="2"/>
												</binaryOperatorExpression>
											</sizeExpression>
										</arrayCreateExpression>
									</init>
								</variableDeclarationStatement>
								<forStatement>
									<variable name="i">
										<init>
											<primitiveExpression value="0"/>
										</init>
									</variable>
									<test>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="i"/>
											<propertyReferenceExpression name="Length">
												<variableReferenceExpression name="returnBytes"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="i"/>
									</increment>
									<statements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="returnBytes"/>
												</target>
												<indices>
													<variableReferenceExpression name="i"/>
												</indices>
											</arrayIndexerExpression>
											<methodInvokeExpression methodName="ToByte">
												<target>
													<typeReferenceExpression type="Convert"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="Substring">
														<target>
															<variableReferenceExpression name="hexString"/>
														</target>
														<parameters>
															<binaryOperatorExpression operator="Multiply">
																<variableReferenceExpression name="i"/>
																<primitiveExpression value="2"/>
															</binaryOperatorExpression>
															<primitiveExpression value="2"/>
														</parameters>
													</methodInvokeExpression>
													<primitiveExpression value="16"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</statements>
								</forStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="returnBytes"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Hash(byte[]) -->
						<memberMethod returnType="System.String" name="Hash">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Byte[]" name="data"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="theHash">
									<init>
										<objectCreateExpression type="HMACSHA1"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Key">
										<variableReferenceExpression name="theHash"/>
									</propertyReferenceExpression>
									<methodInvokeExpression methodName="HexToByte">
										<parameters>
											<propertyReferenceExpression name="ValidationKey">
												<typeReferenceExpression type="ApplicationServices"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement name="hashedText">
									<init>
										<methodInvokeExpression methodName="ToBase64String">
											<target>
												<typeReferenceExpression type="Convert"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="ComputeHash">
													<target>
														<variableReferenceExpression name="theHash"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="data"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="hashedText"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Hash(string) -->
						<memberMethod returnType="System.String" name="Hash">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="text"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<argumentReferenceExpression name="text"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<argumentReferenceExpression name="text"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Hash">
										<parameters>
											<methodInvokeExpression methodName="GetBytes">
												<target>
													<propertyReferenceExpression name="UTF8">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<argumentReferenceExpression name="text"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ComputeS256Hash(string) -->
						<memberMethod returnType="System.Byte[]" name="ComputeS256Hash">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="text"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<argumentReferenceExpression name="text"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<usingStatement>
									<variable name="theSHA256">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="SHA256"/>
												</target>
											</methodInvokeExpression>
										</init>
									</variable>
									<statements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ComputeHash">
												<target>
													<variableReferenceExpression name="theSHA256"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="GetBytes">
														<target>
															<propertyReferenceExpression name="UTF8">
																<typeReferenceExpression type="Encoding"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<argumentReferenceExpression name="text"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</statements>
								</usingStatement>
							</statements>
						</memberMethod>
						<!-- method ToBase32String(s) -->
						<memberMethod returnType="System.String" name="ToBase32String">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="s"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToBase32String">
										<parameters>
											<methodInvokeExpression methodName="GetBytes">
												<target>
													<propertyReferenceExpression name="UTF8">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<argumentReferenceExpression name="s"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToBase32String(byte[]) -->
						<memberMethod returnType="System.String" name="ToBase32String">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Byte[]" name="input"/>
							</parameters>
							<statements>
								<comment>https://datatracker.ietf.org/doc/html/rfc4648</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="IdentityEquality">
												<argumentReferenceExpression name="input"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="Length">
													<argumentReferenceExpression name="input"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="ArgumentNullException">
												<parameters>
													<primitiveExpression value="input"/>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="charCount">
									<init>
										<castExpression targetType="System.Int32">
											<binaryOperatorExpression operator="Multiply">
												<methodInvokeExpression methodName="Ceiling">
													<target>
														<typeReferenceExpression type="Math"/>
													</target>
													<parameters>
														<binaryOperatorExpression operator="Divide">
															<propertyReferenceExpression name="Length">
																<variableReferenceExpression name="input"/>
															</propertyReferenceExpression>
															<castExpression targetType="System.Double">
																<primitiveExpression value="5"/>
															</castExpression>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
												<primitiveExpression value="8"/>
											</binaryOperatorExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="returnArray">
									<init>
										<arrayCreateExpression>
											<createType type="System.Char"/>
											<sizeExpression>
												<variableReferenceExpression name="charCount"/>
											</sizeExpression>
										</arrayCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Byte" name="nextChar" var="false">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Byte" name="bitsRemaining" var="false">
									<init>
										<primitiveExpression value="5"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Byte" name="arrayIndex" var="false">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable name="b" type="System.Byte" var="false"/>
									<target>
										<argumentReferenceExpression name="input"/>
									</target>
									<statements>
										<assignStatement>
											<variableReferenceExpression name="nextChar"/>
											<castExpression targetType="System.Byte">
												<binaryOperatorExpression operator="BitwiseOr">
													<variableReferenceExpression name="nextChar"/>
													<binaryOperatorExpression operator="ShiftRight">
														<variableReferenceExpression name="b"/>
														<binaryOperatorExpression operator="Subtract">
															<primitiveExpression value="8"/>
															<variableReferenceExpression name="bitsRemaining"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</castExpression>
										</assignStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="returnArray"/>
												</target>
												<indices>
													<variableReferenceExpression name="arrayIndex"/>
												</indices>
											</arrayIndexerExpression>
											<methodInvokeExpression methodName="ByteToBase32Char">
												<parameters>
													<variableReferenceExpression name="nextChar"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="arrayIndex"/>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="arrayIndex"/>
												<primitiveExpression value="1"/>
											</binaryOperatorExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="LessThan">
													<variableReferenceExpression name="bitsRemaining"/>
													<primitiveExpression value="4"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="nextChar"/>
													<castExpression targetType="System.Byte">
														<binaryOperatorExpression operator="BitwiseAnd">
															<binaryOperatorExpression operator="ShiftRight">
																<variableReferenceExpression name="b"/>
																<binaryOperatorExpression operator="Subtract">
																	<primitiveExpression value="3"/>
																	<variableReferenceExpression name="bitsRemaining"/>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
															<primitiveExpression value="31"/>
														</binaryOperatorExpression>
													</castExpression>
												</assignStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="returnArray"/>
														</target>
														<indices>
															<variableReferenceExpression name="arrayIndex"/>
														</indices>
													</arrayIndexerExpression>
													<methodInvokeExpression methodName="ByteToBase32Char">
														<parameters>
															<variableReferenceExpression name="nextChar"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="arrayIndex"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="arrayIndex"/>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="bitsRemaining"/>
													<castExpression targetType="System.Byte">
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="bitsRemaining"/>
															<primitiveExpression value="5"/>
														</binaryOperatorExpression>
													</castExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="bitsRemaining"/>
											<castExpression targetType="System.Byte">
												<binaryOperatorExpression operator="Subtract">
													<variableReferenceExpression name="bitsRemaining"/>
													<primitiveExpression value="3"/>
												</binaryOperatorExpression>
											</castExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="nextChar"/>
											<methodInvokeExpression methodName="ToByte">
												<parameters>
													<binaryOperatorExpression operator="BitwiseAnd">
														<binaryOperatorExpression operator="ShiftLeft">
															<variableReferenceExpression name="b"/>
															<variableReferenceExpression name="bitsRemaining"/>
														</binaryOperatorExpression>
														<primitiveExpression value="31"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</statements>
								</foreachStatement>
								<comment>if we didn't end with a full char</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<variableReferenceExpression name="arrayIndex"/>
											<variableReferenceExpression name="charCount"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="returnArray"/>
												</target>
												<indices>
													<variableReferenceExpression name="arrayIndex"/>
												</indices>
											</arrayIndexerExpression>
											<methodInvokeExpression methodName="ByteToBase32Char">
												<parameters>
													<variableReferenceExpression name="nextChar"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="arrayIndex"/>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="arrayIndex"/>
												<primitiveExpression value="1"/>
											</binaryOperatorExpression>
										</assignStatement>
										<whileStatement>
											<test>
												<binaryOperatorExpression operator="ValueInequality">
													<variableReferenceExpression name="arrayIndex"/>
													<variableReferenceExpression name="charCount"/>
												</binaryOperatorExpression>
											</test>
											<statements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="returnArray"/>
														</target>
														<indices>
															<variableReferenceExpression name="arrayIndex"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="=" convertTo="Char"/>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="arrayIndex"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="arrayIndex"/>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</assignStatement>
											</statements>
										</whileStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<objectCreateExpression type="System.String">
										<parameters>
											<variableReferenceExpression name="returnArray"/>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToByte(int) -->
						<memberMethod returnType="System.Byte" name="ToByte">
							<attributes family="true" static="true"/>
							<parameters>
								<parameter type="System.Int32" name="i"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<arrayIndexerExpression>
										<target>
											<methodInvokeExpression methodName="GetBytes">
												<target>
													<typeReferenceExpression type="BitConverter"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="i"/>
												</parameters>
											</methodInvokeExpression>
										</target>
										<indices>
											<primitiveExpression value="0"/>
										</indices>
									</arrayIndexerExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method FromBase32String(string) -->
						<memberMethod returnType="System.Byte[]" name="FromBase32String">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="input"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<argumentReferenceExpression name="input"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="ArgumentNullException">
												<parameters>
													<primitiveExpression value="input"/>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<argumentReferenceExpression name="input"/>
									<methodInvokeExpression methodName="Trim">
										<target>
											<argumentReferenceExpression name="input"/>
										</target>
										<parameters>
											<primitiveExpression value="=" convertTo="Char"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement name="byteCount">
									<init>
										<binaryOperatorExpression operator="Divide">
											<binaryOperatorExpression operator="Multiply">
												<propertyReferenceExpression name="Length">
													<argumentReferenceExpression name="input"/>
												</propertyReferenceExpression>
												<primitiveExpression value="5"/>
											</binaryOperatorExpression>
											<primitiveExpression value="8"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="returnArray">
									<init>
										<arrayCreateExpression>
											<createType type="System.Byte"/>
											<sizeExpression>
												<variableReferenceExpression name="byteCount"/>
											</sizeExpression>
										</arrayCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Byte" name="curByte" var="false">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Byte" name="bitsRemaining" var="false">
									<init>
										<primitiveExpression value="8"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Int32" name="mask" var="false"/>
								<variableDeclarationStatement name="arrayIndex">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable name="c"/>
									<target>
										<argumentReferenceExpression name="input"/>
									</target>
									<statements>
										<variableDeclarationStatement name="cValue">
											<init>
												<methodInvokeExpression methodName="CharToValue">
													<parameters>
														<variableReferenceExpression name="c"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<variableReferenceExpression name="bitsRemaining"/>
													<primitiveExpression value="5"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="mask"/>
													<binaryOperatorExpression operator="ShiftLeft">
														<variableReferenceExpression name="cValue"/>
														<binaryOperatorExpression operator="Subtract">
															<variableReferenceExpression name="bitsRemaining"/>
															<primitiveExpression value="5"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="curByte"/>
													<castExpression targetType="System.Byte">
														<binaryOperatorExpression operator="BitwiseOr">
															<variableReferenceExpression name="curByte"/>
															<variableReferenceExpression name="mask"/>
														</binaryOperatorExpression>
													</castExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="bitsRemaining"/>
													<castExpression targetType="System.Byte">
														<binaryOperatorExpression operator="Subtract">
															<variableReferenceExpression name="bitsRemaining"/>
															<primitiveExpression value="5"/>
														</binaryOperatorExpression>
													</castExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="mask"/>
													<binaryOperatorExpression operator="ShiftRight">
														<variableReferenceExpression name="cValue"/>
														<binaryOperatorExpression operator="Subtract">
															<primitiveExpression value="5"/>
															<variableReferenceExpression name="bitsRemaining"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="curByte"/>
													<castExpression targetType="System.Byte">
														<binaryOperatorExpression operator="BitwiseOr">
															<variableReferenceExpression name="curByte"/>
															<variableReferenceExpression name="mask"/>
														</binaryOperatorExpression>
													</castExpression>
												</assignStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="returnArray"/>
														</target>
														<indices>
															<variableReferenceExpression name="arrayIndex"/>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="curByte"/>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="arrayIndex"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="arrayIndex"/>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="curByte"/>
													<methodInvokeExpression methodName="ToByte">
														<parameters>
															<binaryOperatorExpression operator="ShiftLeft">
																<variableReferenceExpression name="cValue"/>
																<binaryOperatorExpression operator="Add">
																	<primitiveExpression value="3"/>
																	<variableReferenceExpression name="bitsRemaining"/>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="bitsRemaining"/>
													<castExpression targetType="System.Byte">
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="bitsRemaining"/>
															<primitiveExpression value="3"/>
														</binaryOperatorExpression>
													</castExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<variableReferenceExpression name="arrayIndex"/>
											<variableReferenceExpression name="byteCount"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="returnArray"/>
												</target>
												<indices>
													<variableReferenceExpression name="arrayIndex"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="curByte"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="returnArray"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CharToValue(char) -->
						<memberMethod returnType="System.Int32" name="CharToValue">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Char" name="c"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="value">
									<init>
										<convertExpression to="Int32">
											<argumentReferenceExpression name="c"/>
										</convertExpression>
									</init>
								</variableDeclarationStatement>
								<comment>65-90 == uppercase letters </comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="LessThan">
												<variableReferenceExpression name="value"/>
												<primitiveExpression value="91"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="GreaterThan">
												<variableReferenceExpression name="value"/>
												<primitiveExpression value="64"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<binaryOperatorExpression operator="Subtract">
												<variableReferenceExpression name="value"/>
												<primitiveExpression value="65"/>
											</binaryOperatorExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<comment>50-55 == numbers 2-7</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="LessThan">
												<variableReferenceExpression name="value"/>
												<primitiveExpression value="56"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="GreaterThan">
												<variableReferenceExpression name="value"/>
												<primitiveExpression value="49"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<binaryOperatorExpression operator="Subtract">
												<variableReferenceExpression name="value"/>
												<primitiveExpression value="24"/>
											</binaryOperatorExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<comment>97-122 == lowercase letters</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="LessThan">
												<variableReferenceExpression name="value"/>
												<primitiveExpression value="123"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="GreaterThan">
												<variableReferenceExpression name="value"/>
												<primitiveExpression value="96"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<binaryOperatorExpression operator="Subtract">
												<variableReferenceExpression name="value"/>
												<primitiveExpression value="97"/>
											</binaryOperatorExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<throwExceptionStatement>
									<objectCreateExpression type="ArgumentException">
										<parameters>
											<primitiveExpression value="Character is not a Base32 character."/>
											<primitiveExpression value="c"/>
										</parameters>
									</objectCreateExpression>
								</throwExceptionStatement>
							</statements>
						</memberMethod>
						<!-- method BytesToBase32Char(byte) -->
						<memberMethod returnType="System.Char" name="ByteToBase32Char">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Byte" name="b"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="LessThan">
											<argumentReferenceExpression name="b"/>
											<primitiveExpression value="26"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<convertExpression to="Char">
												<binaryOperatorExpression operator="Add">
													<argumentReferenceExpression name="b"/>
													<primitiveExpression value="65"/>
												</binaryOperatorExpression>
											</convertExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="LessThan">
											<argumentReferenceExpression name="b"/>
											<primitiveExpression value="32"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<convertExpression to="Char">
												<binaryOperatorExpression operator="Add">
													<argumentReferenceExpression name="b"/>
													<primitiveExpression value="24"/>
												</binaryOperatorExpression>
											</convertExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<throwExceptionStatement>
									<objectCreateExpression type="ArgumentException">
										<parameters>
											<primitiveExpression value="Byte is not a value Base32 value."/>
											<primitiveExpression value="b"/>
										</parameters>
									</objectCreateExpression>
								</throwExceptionStatement>
							</statements>
						</memberMethod>
						<!-- method XmlToJson(string) -->
						<memberMethod returnType="System.String" name="XmlToJson">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="xml"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="doc">
									<init>
										<objectCreateExpression type="XmlDocument"/>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="LoadXml">
									<target>
										<variableReferenceExpression name="doc"/>
									</target>
									<parameters>
										<argumentReferenceExpression name="xml"/>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<methodInvokeExpression methodName="SerializeXmlNode">
										<target>
											<typeReferenceExpression type="JsonConvert"/>
										</target>
										<parameters>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="ChildNodes">
														<variableReferenceExpression name="doc"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="0"/>
												</indices>
											</arrayIndexerExpression>
											<propertyReferenceExpression name="Indented">
												<typeReferenceExpression type="Newtonsoft.Json.Formatting"/>
											</propertyReferenceExpression>
											<primitiveExpression value="true"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ParseYamlOrJson(string yamlOrJson) -->
						<memberMethod returnType="JObject" name="ParseYamlOrJson">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="yamlOrJson"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ParseYamlOrJson">
										<parameters>
											<argumentReferenceExpression name="yamlOrJson"/>
											<primitiveExpression value="false"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ParseYamlOrJson(string yamlOrJson) -->
						<memberMethod returnType="JObject" name="ParseYamlOrJson">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="yamlOrJson"/>
								<parameter type="System.Boolean" name="throwError"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrWhiteSpace">
											<argumentReferenceExpression name="yamlOrJson"/> 
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<tryStatement>
									<statements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="IsMatch">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="yamlOrJson"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[^\s*\{]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<methodInvokeExpression methodName="Parse">
														<target>
															<typeReferenceExpression type="JObject"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="yamlOrJson"/>
														</parameters>
													</methodInvokeExpression>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="yamlObject">
											<init>
												<methodInvokeExpression methodName="Deserialize">
													<target>
														<methodInvokeExpression methodName="Build">
															<target>
																<objectCreateExpression type="DeserializerBuilder"/>
															</target>
														</methodInvokeExpression>
													</target>
													<parameters>
														<objectCreateExpression type="StringReader">
															<parameters>
																<argumentReferenceExpression name="yamlOrJson"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="json">
											<init>
												<methodInvokeExpression methodName="Serialize">
													<target>
														<methodInvokeExpression methodName="Build">
															<target>
																<methodInvokeExpression methodName="JsonCompatible">
																	<target>
																		<objectCreateExpression type="SerializerBuilder"/>
																	</target>
																</methodInvokeExpression>
															</target>
														</methodInvokeExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="yamlObject"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="json"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="json"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[: "(true|True|TRUE|false|False|FALSE)"]]></xsl:attribute>
													</primitiveExpression>
													<addressOfExpression>
														<methodReferenceExpression methodName="YamlBooleanToJSON"/>
													</addressOfExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<methodReturnStatement>
											<methodInvokeExpression methodName="Parse">
												<target>
													<typeReferenceExpression type="JObject"/>
												</target>
												<parameters>
													<variableReferenceExpression name="json"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</statements>
									<catch exceptionType="Exception" localName="ex">
										<conditionStatement>
											<condition>
												<argumentReferenceExpression name="throwError"/>
											</condition>
											<trueStatements>
												<throwExceptionStatement>
													<variableReferenceExpression name="ex"/>
												</throwExceptionStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<objectCreateExpression type="JObject">
												<parameters>
													<objectCreateExpression type="JProperty">
														<parameters>
															<primitiveExpression value="error"/>
															<propertyReferenceExpression name="Message">
																<variableReferenceExpression name="ex"/>
															</propertyReferenceExpression>
														</parameters>
													</objectCreateExpression>
												</parameters>
											</objectCreateExpression>
										</methodReturnStatement>
									</catch>
								</tryStatement>
							</statements>
						</memberMethod>
						<!-- method YamlBooleanToJSON(Match) -->
						<memberMethod returnType="System.String" name="YamlBooleanToJSON">
							<attributes private="true" static="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="Add">
										<primitiveExpression value=": "/>
										<methodInvokeExpression methodName="ToLower">
											<target>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<argumentReferenceExpression name="m"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="1"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</target>
										</methodInvokeExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method JsonToYaml(JToken) -->
						<memberMethod returnType="System.Object" name="JsonToYaml">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="JToken" name="token"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IsTypeOf">
											<argumentReferenceExpression name="token"/>
											<typeReferenceExpression type="JValue"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Value">
												<castExpression targetType="JValue">
													<variableReferenceExpression name="token"/>
												</castExpression>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IsTypeOf">
											<variableReferenceExpression name="token"/>
											<typeReferenceExpression type="JArray"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ToList">
												<target>
													<methodInvokeExpression methodName="Select">
														<target>
															<methodInvokeExpression methodName="AsEnumerable">
																<target>
																	<argumentReferenceExpression name="token"/>
																</target>
															</methodInvokeExpression>
														</target>
														<parameters>
															<addressOfExpression>
																<methodReferenceExpression methodName="JsonToYaml"/>
															</addressOfExpression>
														</parameters>
													</methodInvokeExpression>
												</target>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IsTypeOf">
											<argumentReferenceExpression name="token"/>
											<typeReferenceExpression type="JObject"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ToDictionary">
												<target>
													<methodInvokeExpression methodName="Cast">
														<typeArguments>
															<typeReference type="JProperty"/>
														</typeArguments>
														<target>
															<methodInvokeExpression methodName="AsEnumerable">
																<target>
																	<argumentReferenceExpression name="token"/>
																</target>
															</methodInvokeExpression>
														</target>
													</methodInvokeExpression>
												</target>
												<parameters>
													<addressOfExpression>
														<methodReferenceExpression methodName="JTokenToString"/>
													</addressOfExpression>
													<addressOfExpression>
														<methodReferenceExpression methodName="JTokenToYaml"/>
													</addressOfExpression>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<throwExceptionStatement>
									<objectCreateExpression type="InvalidOperationException">
										<parameters>
											<binaryOperatorExpression operator="Add">
												<primitiveExpression value="Unexpected token:"/>
												<convertExpression to="String">
													<argumentReferenceExpression name="token"/>
												</convertExpression>
											</binaryOperatorExpression>
										</parameters>
									</objectCreateExpression>
								</throwExceptionStatement>
							</statements>
						</memberMethod>
						<!-- method JTokenToString(JToken) -->
						<memberMethod returnType="System.String" name="JTokenToString">
							<attributes private="true" static="true"/>
							<parameters>
								<parameter type="JProperty" name="x"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<propertyReferenceExpression name="Name">
										<argumentReferenceExpression name="x"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method JTokenToYaml(JToken) -->
						<memberMethod returnType="System.Object" name="JTokenToYaml">
							<attributes static="true" private="true"/>
							<parameters>
								<parameter type="JProperty" name="x"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="JsonToYaml">
										<parameters>
											<propertyReferenceExpression name="Value">
												<argumentReferenceExpression name="x"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToYamlString(JObject) -->
						<memberMethod returnType="System.String" name="ToYamlString">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="JObject" name="json"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="stringWriter">
									<init>
										<objectCreateExpression type="StringWriter"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="serializer">
									<init>
										<objectCreateExpression type="YamlDotNet.Serialization.Serializer"/>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Serialize">
									<target>
										<variableReferenceExpression name="serializer"/>
									</target>
									<parameters>
										<variableReferenceExpression name="stringWriter"/>
										<methodInvokeExpression methodName="JsonToYaml">
											<parameters>
												<argumentReferenceExpression name="json"/>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement name="output">
									<init>
										<methodInvokeExpression methodName="ToString">
											<target>
												<variableReferenceExpression name="stringWriter"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<variableReferenceExpression name="output"/>"
											</unaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<methodInvokeExpression methodName="Trim">
													<target>
														<methodInvokeExpression methodName="ToString">
															<target>
																<variableReferenceExpression name="output"/>
															</target>
														</methodInvokeExpression>
													</target>
												</methodInvokeExpression>
												<primitiveExpression value="{{}}"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="output"/>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="output"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetUniqueKey(int) -->
						<memberField type="System.Char[]" name="chars">
							<attributes private="true" static="true"/>
							<init>
								<methodInvokeExpression methodName="ToCharArray">
									<target>
										<primitiveExpression value="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"/>
									</target>
								</methodInvokeExpression>
							</init>
						</memberField>
						<memberMethod returnType="System.String" name="GetUniqueKey">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Int32" name="size"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetUniqueKey">
										<parameters>
											<argumentReferenceExpression name="size"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetUniqueKey(int, string) -->
						<memberMethod returnType="System.String" name="GetUniqueKey">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Int32" name="size"/>
								<parameter type="System.String" name="charsAlt"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="chars">
									<init>
										<fieldReferenceExpression name="chars"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<argumentReferenceExpression name="charsAlt"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="chars"/>
											<methodInvokeExpression methodName="ToCharArray">
												<target>
													<argumentReferenceExpression name="charsAlt"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="data">
									<init>
										<arrayCreateExpression>
											<createType type="System.Byte"/>
											<sizeExpression>
												<binaryOperatorExpression operator="Multiply">
													<primitiveExpression value="4"/>
													<argumentReferenceExpression name="size"/>
												</binaryOperatorExpression>
											</sizeExpression>
										</arrayCreateExpression>
									</init>
								</variableDeclarationStatement>
								<usingStatement>
									<variable name="crypto">
										<init>
											<objectCreateExpression type="RNGCryptoServiceProvider"/>
										</init>
									</variable>
									<statements>
										<methodInvokeExpression methodName="GetBytes">
											<target>
												<variableReferenceExpression name="crypto"/>
											</target>
											<parameters>
												<variableReferenceExpression name="data"/>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</usingStatement>
								<variableDeclarationStatement name="result">
									<init>
										<objectCreateExpression type="StringBuilder">
											<parameters>
												<argumentReferenceExpression name="size"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<forStatement>
									<variable name="i">
										<init>
											<primitiveExpression value="0"/>
										</init>
									</variable>
									<test>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="i"/>
											<argumentReferenceExpression name="size"/>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="i"/>
									</increment>
									<statements>
										<variableDeclarationStatement name="rnd">
											<init>
												<methodInvokeExpression methodName="ToUInt32">
													<target>
														<typeReferenceExpression type="BitConverter"/>
													</target>
													<parameters>
														<variableReferenceExpression name="data"/>
														<binaryOperatorExpression operator="Multiply">
															<variableReferenceExpression name="i"/>
															<primitiveExpression value="4"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="idx">
											<init>
												<binaryOperatorExpression operator="Modulus">
													<variableReferenceExpression name="rnd"/>
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="chars"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="Append">
											<target>
												<variableReferenceExpression name="result"/>
											</target>
											<parameters>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="chars"/>
													</target>
													<indices>
														<variableReferenceExpression name="idx"/>
													</indices>
												</arrayIndexerExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</forStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToString">
										<target>
											<variableReferenceExpression name="result"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToUrlEncodedToken(string) -->
						<memberMethod returnType="System.String" name="ToUrlEncodedToken">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="text"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToBase64UrlEncoded">
										<parameters>
											<methodInvokeExpression methodName="ComputeS256Hash">
												<parameters>
													<argumentReferenceExpression name="text"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToBase64UrlEncoded(byte[]) -->
						<memberMethod returnType="System.String" name="ToBase64UrlEncoded">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Byte[]" name="data"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Replace">
										<target>
											<methodInvokeExpression methodName="Replace">
												<target>
													<methodInvokeExpression methodName="TrimEnd">
														<target>
															<methodInvokeExpression methodName="ToBase64String">
																<target>
																	<typeReferenceExpression type="Convert"/>
																</target>
																<parameters>
																	<argumentReferenceExpression name="data"/>
																</parameters>
															</methodInvokeExpression>
														</target>
														<parameters>
															<primitiveExpression value="=" convertTo="Char"/>
														</parameters>
													</methodInvokeExpression>
												</target>
												<parameters>
													<primitiveExpression value="+" convertTo="Char"/>
													<primitiveExpression value="-" convertTo="Char"/>
												</parameters>
											</methodInvokeExpression>
										</target>
										<parameters>
											<primitiveExpression value="/" convertTo="Char"/>
											<primitiveExpression value="_" convertTo="Char"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method FromBase64UrlEncoded(string) -->
						<memberMethod returnType="System.Byte[]" name="FromBase64UrlEncoded">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="text"/>
							</parameters>
							<statements>
								<assignStatement>
									<variableReferenceExpression name="text"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<methodInvokeExpression methodName="Replace">
												<target>
													<variableReferenceExpression name="text"/>
												</target>
												<parameters>
													<primitiveExpression value="_" convertTo="Char"/>
													<primitiveExpression value="/" convertTo="Char"/>
												</parameters>
											</methodInvokeExpression>
										</target>
										<parameters>
											<primitiveExpression value="-" convertTo="Char"/>
											<primitiveExpression value="+" convertTo="Char"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement name="padding">
									<init>
										<stringEmptyExpression/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="paddingSize">
									<init>
										<binaryOperatorExpression operator="Modulus">
											<propertyReferenceExpression name="Length">
												<argumentReferenceExpression name="text"/>
											</propertyReferenceExpression>
											<primitiveExpression value="4"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="paddingSize"/>
											<primitiveExpression value="2"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="padding"/>
											<primitiveExpression value="=="/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="paddingSize"/>
											<primitiveExpression value="3"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="padding"/>
											<primitiveExpression value="="/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="FromBase64String">
										<target>
											<typeReferenceExpression type="Convert"/>
										</target>
										<parameters>
											<binaryOperatorExpression operator="Add">
												<argumentReferenceExpression name="text"/>
												<variableReferenceExpression name="padding"/>
											</binaryOperatorExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateJwt(JObject) -->
						<memberMethod returnType="System.String" name="CreateJwt">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="JObject" name="claims"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="jwtHeader">
									<init>
										<objectCreateExpression type="JObject">
											<parameters>
												<objectCreateExpression type="JProperty">
													<parameters>
														<primitiveExpression value="typ"/>
														<primitiveExpression value="JWT"/>
													</parameters>
												</objectCreateExpression>
												<objectCreateExpression type="JProperty">
													<parameters>
														<primitiveExpression value="alg"/>
														<primitiveExpression value="HS256"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="jwt">
									<init>
										<stringFormatExpression format="{{0}}.{{1}}">
											<methodInvokeExpression methodName="ToBase64UrlEncoded">
												<parameters>
													<methodInvokeExpression methodName="GetBytes">
														<target>
															<propertyReferenceExpression name="UTF8">
																<typeReferenceExpression type="Encoding"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<methodInvokeExpression methodName="ToString">
																<target>
																	<variableReferenceExpression name="jwtHeader"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="None">
																		<typeReferenceExpression type="Newtonsoft.Json.Formatting"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="null"/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="ToBase64UrlEncoded">
												<parameters>
													<methodInvokeExpression methodName="GetBytes">
														<target>
															<propertyReferenceExpression name="UTF8">
																<typeReferenceExpression type="Encoding"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<methodInvokeExpression methodName="ToString">
																<target>
																	<argumentReferenceExpression name="claims"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="None">
																		<typeReferenceExpression type="Newtonsoft.Json.Formatting"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="null"/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</stringFormatExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="secret">
									<init>
										<methodInvokeExpression methodName="GetBytes">
											<target>
												<propertyReferenceExpression name="UTF8">
													<typeReferenceExpression type="Encoding"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="ValidationKey">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<usingStatement>
									<variable name="hmacSha256">
										<init>
											<objectCreateExpression type="HMACSHA256">
												<parameters>
													<variableReferenceExpression name="secret"/>
												</parameters>
											</objectCreateExpression>
										</init>
									</variable>
									<statements>
										<variableDeclarationStatement name="dataToHmac">
											<init>
												<methodInvokeExpression methodName="GetBytes">
													<target>
														<propertyReferenceExpression name="UTF8">
															<typeReferenceExpression type="Encoding"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="jwt"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="jwt"/>
											<stringFormatExpression format="{{0}}.{{1}}">
												<variableReferenceExpression name="jwt"/>
												<methodInvokeExpression methodName="ToBase64UrlEncoded">
													<parameters>
														<methodInvokeExpression methodName="ComputeHash">
															<target>
																<variableReferenceExpression name="hmacSha256"/>
															</target>
															<parameters>
																<variableReferenceExpression name="dataToHmac"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</stringFormatExpression>
										</assignStatement>
									</statements>
								</usingStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="jwt"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ValidateJwt(string token) -->
						<memberMethod returnType="System.Boolean" name="ValidateJwt">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="token"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="jwt">
									<init>
										<methodInvokeExpression methodName="Split">
											<target>
												<argumentReferenceExpression name="token"/>
											</target>
											<parameters>
												<primitiveExpression value="." convertTo="Char"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Length">
												<variableReferenceExpression name="jwt"/>
											</propertyReferenceExpression>
											<primitiveExpression value="3"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="newToken">
									<init>
										<stringFormatExpression format="{{0}}.{{1}}">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="jwt"/>
												</target>
												<indices>
													<primitiveExpression value="0"/>
												</indices>
											</arrayIndexerExpression>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="jwt"/>
												</target>
												<indices>
													<primitiveExpression value="1"/>
												</indices>
											</arrayIndexerExpression>
										</stringFormatExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="secret">
									<init>
										<methodInvokeExpression methodName="GetBytes">
											<target>
												<propertyReferenceExpression name="UTF8">
													<typeReferenceExpression type="Encoding"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="ValidationKey">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<usingStatement>
									<variable name="hmacSha256">
										<init>
											<objectCreateExpression type="HMACSHA256">
												<parameters>
													<variableReferenceExpression name="secret"/>
												</parameters>
											</objectCreateExpression>
										</init>
									</variable>
									<statements>
										<variableDeclarationStatement name="dataToHmac">
											<init>
												<methodInvokeExpression methodName="GetBytes">
													<target>
														<propertyReferenceExpression name="UTF8">
															<typeReferenceExpression type="Encoding"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="newToken"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="newToken"/>
											<stringFormatExpression format="{{0}}.{{1}}">
												<variableReferenceExpression name="newToken"/>
												<methodInvokeExpression methodName="ToBase64UrlEncoded">
													<parameters>
														<methodInvokeExpression methodName="ComputeHash">
															<target>
																<variableReferenceExpression name="hmacSha256"/>
															</target>
															<parameters>
																<variableReferenceExpression name="dataToHmac"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</stringFormatExpression>
										</assignStatement>
									</statements>
								</usingStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="ValueEquality">
										<argumentReferenceExpression name="token"/>
										<variableReferenceExpression name="newToken"/>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class FolderCacheDependency -->
				<typeDeclaration name="FolderCacheDependency">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="CacheDependency"/>
					</baseTypes>
					<members>
						<memberField type="FileSystemWatcher" name="watcher"/>
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="dirName"/>
								<parameter type="System.String" name="filter"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="watcher"/>
									<objectCreateExpression type="FileSystemWatcher">
										<parameters>
											<variableReferenceExpression name="dirName"/>
											<variableReferenceExpression name="filter"/>
										</parameters>
									</objectCreateExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="EnableRaisingEvents">
										<fieldReferenceExpression name="watcher"/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<attachEventStatement>
									<event name="Changed">
										<fieldReferenceExpression name="watcher"/>
									</event>
									<listener>
										<delegateCreateExpression type="FileSystemEventHandler" methodName="watcher_Changed"/>
									</listener>
								</attachEventStatement>
								<attachEventStatement>
									<event name="Deleted">
										<fieldReferenceExpression name="watcher"/>
									</event>
									<listener>
										<delegateCreateExpression type="FileSystemEventHandler" methodName="watcher_Changed"/>
									</listener>
								</attachEventStatement>
								<attachEventStatement>
									<event name="Created">
										<fieldReferenceExpression name="watcher"/>
									</event>
									<listener>
										<delegateCreateExpression type="FileSystemEventHandler" methodName="watcher_Changed"/>
									</listener>
								</attachEventStatement>
								<attachEventStatement>
									<event name="Renamed">
										<fieldReferenceExpression name="watcher"/>
									</event>
									<listener>
										<delegateCreateExpression type="RenamedEventHandler" methodName="watcher_Renamed"/>
									</listener>
								</attachEventStatement>
							</statements>
						</constructor>
						<!-- method watcher_Renamed(object, RenamedEventArgs)-->
						<memberMethod name="watcher_Renamed">
							<attributes/>
							<parameters>
								<parameter type="System.Object" name="sender"/>
								<parameter type="RenamedEventArgs" name="e"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="NotifyDependencyChanged">
									<parameters>
										<thisReferenceExpression/>
										<variableReferenceExpression name="e"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method watcher_Changed(object, FileSystemEventArgs)-->
						<memberMethod name="watcher_Changed">
							<attributes/>
							<parameters>
								<parameter type="System.Object" name="sender"/>
								<parameter type="FileSystemEventArgs" name="e"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="NotifyDependencyChanged">
									<parameters>
										<thisReferenceExpression/>
										<variableReferenceExpression name="e"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class Totp -->
				<typeDeclaration name="Totp">
					<members>
						<memberField type="System.Int64" name="unixEpochTicks">
							<attributes private="true"/>
							<init>
								<convertExpression to="Int64">
									<primitiveExpression value="621355968000000000" convertTo="String"/>
								</convertExpression>
							</init>
						</memberField>
						<memberField type="System.Int64" name="ticksToSeconds">
							<attributes private="true" />
							<init>
								<primitiveExpression value="10000000"/>
								<!--<convertExpression to="Int64">
									<primitiveExpression value="10000000" convertTo="String"/>
								</convertExpression>-->
							</init>
						</memberField>
						<memberField type="System.Int32" name="step">
							<attributes private="true"/>
						</memberField>
						<memberField type="System.Byte[]" name="key"/>
						<!-- Totp(string, int) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="secretKey"/>
								<parameter type="System.Int32" name="period"/>
							</parameters>
							<chainedConstructorArgs>
								<methodInvokeExpression methodName="GetBytes">
									<target>
										<propertyReferenceExpression name="UTF8">
											<typeReferenceExpression type="Encoding"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<argumentReferenceExpression name="secretKey"/>
									</parameters>
								</methodInvokeExpression>
								<argumentReferenceExpression name="period"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- Totp(byte[], int) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.Byte[]" name="secretKey"/>
								<parameter type="System.Int32" name="period"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="key"/>
									<argumentReferenceExpression name="secretKey"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="step"/>
									<argumentReferenceExpression name="period"/>
								</assignStatement>
							</statements>
						</constructor>
						<!-- method Compute() -->
						<memberMethod returnType="System.String" name="Compute">
							<attributes public="true" final="true"/>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Compute">
										<parameters>
											<propertyReferenceExpression name="UtcNow">
												<typeReferenceExpression type="DateTime"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Compute(DateTime) -->
						<memberMethod returnType="System.String" name="Compute">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="DateTime" name="date"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Compute">
										<parameters>
											<argumentReferenceExpression name="date"/>
											<argumentReferenceExpression name="6"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Compute(DateTime, int) -->
						<memberMethod returnType="System.String" name="Compute">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="DateTime" name="date"/>
								<parameter type="System.Int32" name="totpSize"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="window">
									<init>
										<methodInvokeExpression methodName="CalculateTimeStepFromTimestamp">
											<parameters>
												<argumentReferenceExpression name="date"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="data">
									<init>
										<methodInvokeExpression methodName="GetBigEndianBytes">
											<parameters>
												<variableReferenceExpression name="window"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="hmac">
									<init>
										<objectCreateExpression type="HMACSHA1"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Key">
										<variableReferenceExpression name="hmac"/>
									</propertyReferenceExpression>
									<fieldReferenceExpression name="key"/>
								</assignStatement>
								<variableDeclarationStatement name="hmacComputedHash">
									<init>
										<methodInvokeExpression methodName="ComputeHash">
											<target>
												<variableReferenceExpression name="hmac"/>
											</target>
											<parameters>
												<variableReferenceExpression name="data"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="offset">
									<init>
										<binaryOperatorExpression operator="BitwiseAnd">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="hmacComputedHash"/>
												</target>
												<indices>
													<binaryOperatorExpression operator="Subtract">
														<propertyReferenceExpression name="Length">
															<variableReferenceExpression name="hmacComputedHash"/>
														</propertyReferenceExpression>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</indices>
											</arrayIndexerExpression>
											<!-- 0x0F-->
											<primitiveExpression value="15"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="otp">
									<init>
										<binaryOperatorExpression operator="ShiftLeft">
											<binaryOperatorExpression operator="BitwiseAnd">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="hmacComputedHash"/>
													</target>
													<indices>
														<variableReferenceExpression name="offset"/>
													</indices>
												</arrayIndexerExpression>
												<!-- 0x7f -->
												<primitiveExpression value="127"/>
											</binaryOperatorExpression>
											<primitiveExpression value="24"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<variableReferenceExpression name="otp"/>
									<binaryOperatorExpression operator="BitwiseOr">
										<variableReferenceExpression name="otp"/>
										<binaryOperatorExpression operator="ShiftLeft">
											<binaryOperatorExpression operator="BitwiseAnd">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="hmacComputedHash"/>
													</target>
													<indices>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="offset"/>
															<primitiveExpression value="1"/>
														</binaryOperatorExpression>
													</indices>
												</arrayIndexerExpression>
												<!-- 0xff -->
												<primitiveExpression value="255"/>
											</binaryOperatorExpression>
											<primitiveExpression value="16"/>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="otp"/>
									<binaryOperatorExpression operator="BitwiseOr">
										<variableReferenceExpression name="otp"/>
										<binaryOperatorExpression operator="ShiftLeft">
											<binaryOperatorExpression operator="BitwiseAnd">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="hmacComputedHash"/>
													</target>
													<indices>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="offset"/>
															<primitiveExpression value="2"/>
														</binaryOperatorExpression>
													</indices>
												</arrayIndexerExpression>
												<!-- 0xff -->
												<primitiveExpression value="255"/>
											</binaryOperatorExpression>
											<primitiveExpression value="8"/>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="otp"/>
									<binaryOperatorExpression operator="BitwiseOr">
										<variableReferenceExpression name="otp"/>
										<binaryOperatorExpression operator="Modulus">
											<binaryOperatorExpression operator="BitwiseAnd">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="hmacComputedHash"/>
													</target>
													<indices>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="offset"/>
															<primitiveExpression value="3"/>
														</binaryOperatorExpression>
													</indices>
												</arrayIndexerExpression>
												<!-- 0xff -->
												<primitiveExpression value="255"/>
											</binaryOperatorExpression>
											<primitiveExpression value="1000000"/>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</assignStatement>
								<variableDeclarationStatement name="result">
									<init>
										<methodInvokeExpression methodName="Digits">
											<parameters>
												<variableReferenceExpression name="otp"/>
												<argumentReferenceExpression name="totpSize"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Compute(int, int, int) -->
						<memberMethod returnType="System.String[]" name="Compute">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.Int32" name="totpSize"/>
								<parameter type="System.Int32" name="count"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="d">
									<init>
										<objectCreateExpression type="DateTime">
											<parameters>
												<primitiveExpression value="1995"/>
												<primitiveExpression value="1"/>
												<primitiveExpression value="1"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="range">
									<init>
										<propertyReferenceExpression name="Days">
											<binaryOperatorExpression operator="Subtract">
												<propertyReferenceExpression name="Today">
													<typeReferenceExpression type="DateTime"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="d"/>
											</binaryOperatorExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<variableReferenceExpression name="d"/>
									<methodInvokeExpression methodName="AddDays">
										<target>
											<variableReferenceExpression name="d"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="Next">
												<target>
													<objectCreateExpression type="Random"/>
												</target>
												<parameters>
													<variableReferenceExpression name="range"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement name="list">
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<forStatement>
									<variable name="i">
										<init>
											<primitiveExpression value="0"/>
										</init>
									</variable>
									<test>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="i"/>
											<argumentReferenceExpression name="count"/>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="i"/>
									</increment>
									<statements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="list"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Compute">
													<parameters>
														<methodInvokeExpression methodName="AddSeconds">
															<target>
																<variableReferenceExpression name="d"/>
															</target>
															<parameters>
																<binaryOperatorExpression operator="Multiply">
																	<fieldReferenceExpression name="step"/>
																	<variableReferenceExpression name="i"/>
																</binaryOperatorExpression>
															</parameters>
														</methodInvokeExpression>
														<argumentReferenceExpression name="totpSize"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</forStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="list"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method RemainingSeconds() -->
						<memberMethod returnType="System.Int32" name="RemainingSeconds">
							<attributes public="true" final="true"/>
							<statements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="Subtract">
										<fieldReferenceExpression name="step"/>
										<castExpression targetType="System.Int32">
											<binaryOperatorExpression operator="Modulus">
												<binaryOperatorExpression operator="Divide">
													<binaryOperatorExpression operator="Subtract">
														<propertyReferenceExpression name="Ticks">
															<propertyReferenceExpression name="UtcNow">
																<typeReferenceExpression type="DateTime"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
														<fieldReferenceExpression name="unixEpochTicks"/>
													</binaryOperatorExpression>
													<fieldReferenceExpression name="ticksToSeconds"/>
												</binaryOperatorExpression>
												<fieldReferenceExpression name="step"/>
											</binaryOperatorExpression>
										</castExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetBigEndianBytes(long) -->
						<memberMethod returnType="System.Byte[]" name="GetBigEndianBytes">
							<attributes private ="true" final="true"/>
							<parameters>
								<parameter type="System.Int64" name="input"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="data">
									<init>
										<methodInvokeExpression methodName="GetBytes">
											<target>
												<typeReferenceExpression type="BitConverter"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="input"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Reverse">
									<target>
										<typeReferenceExpression type="Array"/>
									</target>
									<parameters>
										<variableReferenceExpression name="data"/>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<variableReferenceExpression name="data"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CalculateTimeStepFromTimestamp(DateTime) -->
						<memberMethod returnType="System.Int64" name="CalculateTimeStepFromTimestamp">
							<attributes public="true" private="true"/>
							<parameters>
								<parameter type="DateTime" name="timestamp"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="unixTimestamp">
									<init>
										<binaryOperatorExpression operator="Divide">
											<binaryOperatorExpression operator="Subtract">
												<propertyReferenceExpression name="Ticks">
													<argumentReferenceExpression name="timestamp"/>
												</propertyReferenceExpression>
												<fieldReferenceExpression name="unixEpochTicks"/>
											</binaryOperatorExpression>
											<fieldReferenceExpression name="ticksToSeconds"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="window">
									<init>
										<binaryOperatorExpression operator="Divide">
											<variableReferenceExpression name="unixTimestamp"/>
											<castExpression targetType="System.Int64">
												<fieldReferenceExpression name="step"/>
											</castExpression>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="window"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Digits(long, int) -->
						<memberMethod returnType="System.String" name="Digits">
							<attributes private ="true" final="true"/>
							<parameters>
								<parameter type="System.Int64" name="input"/>
								<parameter type="System.Int32" name="digitCount"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="truncateValue">
									<init>
										<binaryOperatorExpression operator="Modulus">
											<castExpression targetType="System.Int32">
												<argumentReferenceExpression name="input"/>
											</castExpression>
											<castExpression targetType="System.Int32">
												<methodInvokeExpression methodName="Pow">
													<target>
														<typeReferenceExpression type="Math"/>
													</target>
													<parameters>
														<primitiveExpression value="10"/>
														<argumentReferenceExpression name="digitCount"/>
													</parameters>
												</methodInvokeExpression>
											</castExpression>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="PadLeft">
										<target>
											<methodInvokeExpression methodName="ToString">
												<target>
													<variableReferenceExpression name="truncateValue"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<argumentReferenceExpression name="digitCount"/>
											<primitiveExpression value="0" convertTo="Char"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class DataCacheItem-->
				<typeDeclaration name="DataCacheItem">
					<attributes public="true"/>
					<members>
						<!-- property Controller -->
						<memberProperty type="System.String" name="Controller">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Duration -->
						<memberProperty type="System.Int32" name="Duration">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property MaxAge  -->
						<memberField type="System.Int64" name="maxAge"/>
						<memberProperty type="System.Int64" name="MaxAge">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="value"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Duration"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="maxAge"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Key -->
						<memberProperty type="System.String" name="Key">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Value  -->
						<memberField type="System.Object" name="value"/>
						<memberProperty type="System.Object" name="Value">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="value"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsMatch"/>
									</condition>
									<trueStatements>
										<tryStatement>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanOr">
															<unaryOperatorExpression operator="Not">
																<binaryOperatorExpression operator="IsTypeOf">
																	<propertySetValueReferenceExpression/>
																	<typeReferenceExpression type="JObject"/>
																</binaryOperatorExpression>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="IdentityEquality">
																<arrayIndexerExpression>
																	<target>
																		<castExpression targetType="JObject">
																			<propertySetValueReferenceExpression/>
																		</castExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="error"/>
																	</indices>
																</arrayIndexerExpression>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<fieldReferenceExpression name="value"/>
															<propertySetValueReferenceExpression/>
														</assignStatement>
														<assignStatement>
															<fieldReferenceExpression name="maxAge"/>
															<propertyReferenceExpression name="Duration"/>
														</assignStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<propertyReferenceExpression name="Cache">
																	<propertyReferenceExpression name="Current">
																		<typeReferenceExpression type="HttpContext"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<propertyReferenceExpression name="Key"/>
																<arrayCreateExpression>
																	<createType type="System.Object"/>
																	<initializers>
																		<fieldReferenceExpression name="value"/>
																		<propertyReferenceExpression name="Now">
																			<typeReferenceExpression type="DateTime"/>
																		</propertyReferenceExpression>
																	</initializers>
																</arrayCreateExpression>
																<primitiveExpression value="null"/>
																<methodInvokeExpression methodName="AddSeconds">
																	<target>
																		<propertyReferenceExpression name="Now">
																			<typeReferenceExpression type="DateTime"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Duration"/>
																	</parameters>
																</methodInvokeExpression>
																<propertyReferenceExpression name="NoSlidingExpiration">
																	<typeReferenceExpression type="Cache"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Normal">
																	<typeReferenceExpression type="CacheItemPriority"/>
																</propertyReferenceExpression>
																<primitiveExpression value="null"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
											<catch exceptionType="Exception">
												<comment>ignore the possible dupicates in the cache that may be created under the high load</comment>
											</catch>
										</tryStatement>
									</trueStatements>
								</conditionStatement>
							</setStatements>
						</memberProperty>
						<!-- property IsMatch -->
						<memberProperty type="System.Boolean" name="IsMatch">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="GreaterThan">
										<propertyReferenceExpression name="Duration"/>
										<primitiveExpression value="0"/>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- propperty HasValue -->
						<memberProperty type="System.Boolean" name="HasValue">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanAnd">
										<propertyReferenceExpression name="IsMatch"/>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Value"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- constructor(string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="controller"/>
								<primitiveExpression value="null"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor(string, object) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.Object" name="request"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="Controller">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="controller"/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<argumentReferenceExpression name="controller"/>
											</unaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="IsSystemController">
													<target>
														<methodInvokeExpression methodName="Create">
															<target>
																<typeReferenceExpression type="ApplicationServices"/>
															</target>
														</methodInvokeExpression>
													</target>
													<parameters>
														<argumentReferenceExpression name="controller"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="rules">
											<init>
												<castExpression targetType="JObject">
													<methodInvokeExpression methodName="SettingsProperty">
														<target>
															<typeReferenceExpression type="ApplicationServicesBase"/>
														</target>
														<parameters>
															<primitiveExpression value="server.cache.rules"/>
														</parameters>
													</methodInvokeExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="rules"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<comment>test the exemptions</comment>
												<foreachStatement>
													<variable name="p"/>
													<target>
														<methodInvokeExpression methodName="Properties">
															<target>
																<variableReferenceExpression name="rules"/>
															</target>
														</methodInvokeExpression>
													</target>
													<statements>
														<tryStatement>
															<statements>
																<variableDeclarationStatement name="re">
																	<init>
																		<objectCreateExpression type="Regex">
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="p"/>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="IgnoreCase">
																					<typeReferenceExpression type="RegexOptions"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</objectCreateExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="IsMatch">
																			<target>
																				<variableReferenceExpression name="re"/>
																			</target>
																			<parameters>
																				<argumentReferenceExpression name="controller"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<propertyReferenceExpression name="LatestVersion">
																						<typeReferenceExpression type="RESTfulResource"/>
																					</propertyReferenceExpression>
																					<argumentReferenceExpression name="controller"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<breakStatement/>
																			</trueStatements>
																			<falseStatements>
																				<assignStatement>
																					<propertyReferenceExpression name="Duration"/>
																					<convertExpression to="Int32">
																						<binaryOperatorExpression operator="Multiply">
																							<convertExpression to="Double">
																								<arrayIndexerExpression>
																									<target>
																										<propertyReferenceExpression name="Value">
																											<variableReferenceExpression name="p"/>
																										</propertyReferenceExpression>
																									</target>
																									<indices>
																										<primitiveExpression value="duration"/>
																									</indices>
																								</arrayIndexerExpression>
																							</convertExpression>
																							<primitiveExpression value="60"/>
																						</binaryOperatorExpression>
																					</convertExpression>
																				</assignStatement>
																			</falseStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<propertyReferenceExpression name="IsMatch"/>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement name="exempt">
																					<init>
																						<convertExpression to="String">
																							<arrayIndexerExpression>
																								<target>
																									<propertyReferenceExpression name="Value">
																										<variableReferenceExpression name="p"/>
																									</propertyReferenceExpression>
																								</target>
																								<indices>
																									<primitiveExpression value="exemptRoles"/>
																								</indices>
																							</arrayIndexerExpression>
																						</convertExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<unaryOperatorExpression operator="IsNotNullOrEmpty">
																							<variableReferenceExpression name="exempt"/>
																						</unaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<variableDeclarationStatement name="exemptRoles">
																							<init>
																								<methodInvokeExpression methodName="Split">
																									<target>
																										<typeReferenceExpression type="Regex"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="exempt"/>
																										<primitiveExpression>
																											<xsl:attribute name="value"><![CDATA[\s*,\s*]]></xsl:attribute>
																										</primitiveExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</init>
																						</variableDeclarationStatement>
																						<foreachStatement>
																							<variable name="role"/>
																							<target>
																								<variableReferenceExpression name="exemptRoles"/>
																							</target>
																							<statements>
																								<conditionStatement>
																									<condition>
																										<methodInvokeExpression methodName="IsInRole">
																											<target>
																												<propertyReferenceExpression name="User">
																													<propertyReferenceExpression name="Current">
																														<typeReferenceExpression type="HttpContext"/>
																													</propertyReferenceExpression>
																												</propertyReferenceExpression>
																											</target>
																											<parameters>
																												<variableReferenceExpression name="role"/>
																											</parameters>
																										</methodInvokeExpression>
																									</condition>
																									<trueStatements>
																										<assignStatement>
																											<propertyReferenceExpression name="Duration"/>
																											<primitiveExpression value="0"/>
																										</assignStatement>
																										<breakStatement/>
																									</trueStatements>
																								</conditionStatement>
																							</statements>
																						</foreachStatement>
																					</trueStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<propertyReferenceExpression name="IsMatch"/>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement name="exempt">
																					<init>
																						<convertExpression to="String">
																							<arrayIndexerExpression>
																								<target>
																									<propertyReferenceExpression name="Value">
																										<variableReferenceExpression name="p"/>
																									</propertyReferenceExpression>
																								</target>
																								<indices>
																									<primitiveExpression value="exemptScopes"/>
																								</indices>
																							</arrayIndexerExpression>
																						</convertExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<unaryOperatorExpression operator="IsNotNullOrEmpty">
																							<variableReferenceExpression name="exempt"/>
																						</unaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<variableDeclarationStatement name="exemptScopes">
																							<init>
																								<methodInvokeExpression methodName="Split">
																									<target>
																										<typeReferenceExpression type="Regex"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="exempt"/>
																										<primitiveExpression value="\s+"/>
																									</parameters>
																								</methodInvokeExpression>
																							</init>
																						</variableDeclarationStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="GreaterThan">
																									<propertyReferenceExpression name="Length">
																										<variableReferenceExpression name="exemptScopes"/>
																									</propertyReferenceExpression>
																									<primitiveExpression value="0"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<variableDeclarationStatement name="userScopes">
																									<init>
																										<propertyReferenceExpression name="Scopes">
																											<typeReferenceExpression type="RESTfulResource"/>
																										</propertyReferenceExpression>
																									</init>
																								</variableDeclarationStatement>
																								<foreachStatement>
																									<variable name="scope"/>
																									<target>
																										<variableReferenceExpression name="exemptScopes"/>
																									</target>
																									<statements>
																										<conditionStatement>
																											<condition>
																												<methodInvokeExpression methodName="Contains">
																													<target>
																														<variableReferenceExpression name="userScopes"/>
																													</target>
																													<parameters>
																														<variableReferenceExpression name="scope"/>
																													</parameters>
																												</methodInvokeExpression>
																											</condition>
																											<trueStatements>
																												<assignStatement>
																													<propertyReferenceExpression name="Duration"/>
																													<primitiveExpression value="0"/>
																												</assignStatement>
																												<breakStatement/>
																											</trueStatements>
																										</conditionStatement>
																									</statements>
																								</foreachStatement>
																							</trueStatements>
																						</conditionStatement>
																					</trueStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
															</statements>
															<catch exceptionType="Exception">
																<comment>do nothing</comment>
															</catch>
														</tryStatement>
													</statements>
												</foreachStatement>
												<comment>fetch from cache if there is a match to the request</comment>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<propertyReferenceExpression name="IsMatch"/>
															<binaryOperatorExpression operator="IdentityInequality">
																<argumentReferenceExpression name="request"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="json">
															<init>
																<methodInvokeExpression methodName="SerializeObject">
																	<target>
																		<typeReferenceExpression type="JsonConvert"/>
																	</target>
																	<parameters>
																		<argumentReferenceExpression name="request"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="hash">
															<init>
																<methodInvokeExpression methodName="ToUrlEncodedToken">
																	<target>
																		<typeReferenceExpression type="TextUtility"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="json"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<propertyReferenceExpression name="Key"/>
															<stringFormatExpression format="data-cache/{{0}}/{{1}}">
																<methodInvokeExpression methodName="ToLower">
																	<target>
																		<argumentReferenceExpression name="controller"/>
																	</target>
																</methodInvokeExpression>
																<variableReferenceExpression name="hash"/>
															</stringFormatExpression>
														</assignStatement>
														<variableDeclarationStatement name="cachedData">
															<init>
																<castExpression targetType="System.Object[]">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Cache">
																				<propertyReferenceExpression name="Current">
																					<typeReferenceExpression type="HttpContext"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<propertyReferenceExpression name="Key"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="cachedData"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<fieldReferenceExpression name="value"/>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="cachedData"/>
																		</target>
																		<indices>
																			<primitiveExpression value="0"/>
																		</indices>
																	</arrayIndexerExpression>
																</assignStatement>
																<assignStatement>
																	<fieldReferenceExpression name="maxAge"/>
																	<binaryOperatorExpression operator="Subtract">
																		<propertyReferenceExpression name="Duration"/>
																		<propertyReferenceExpression name="Seconds">
																			<methodInvokeExpression methodName="FromTicks">
																				<target>
																					<typeReferenceExpression type="TimeSpan"/>
																				</target>
																				<parameters>
																					<binaryOperatorExpression operator="Subtract">
																						<propertyReferenceExpression name="Ticks">
																							<propertyReferenceExpression name="Now">
																								<typeReferenceExpression type="DateTime"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="Ticks">
																							<castExpression targetType="DateTime">
																								<arrayIndexerExpression>
																									<target>
																										<variableReferenceExpression name="cachedData"/>
																									</target>
																									<indices>
																										<primitiveExpression value="1"/>
																									</indices>
																								</arrayIndexerExpression>
																							</castExpression>
																						</propertyReferenceExpression>
																					</binaryOperatorExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</propertyReferenceExpression>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</constructor>
						<!-- method SetMaxAge() -->
						<memberMethod name="SetMaxAge">
							<attributes public="true"/>
							<statements>
								<variableDeclarationStatement name="response">
									<init>
										<propertyReferenceExpression name="Response">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="HttpContext"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Clear">
									<target>
										<propertyReferenceExpression name="Cookies">
											<variableReferenceExpression name="response"/>
										</propertyReferenceExpression>
									</target>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="PublicApiKey">
												<typeReferenceExpression type="RESTfulResource"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="SetCacheability">
											<target>
												<propertyReferenceExpression name="Cache">
													<variableReferenceExpression name="response"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="Public">
													<typeReferenceExpression type="HttpCacheability"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="SetProxyMaxAge">
											<target>
												<propertyReferenceExpression name="Cache">
													<variableReferenceExpression name="response"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<methodInvokeExpression methodName="FromSeconds">
													<target>
														<typeReferenceExpression type="TimeSpan"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="MaxAge"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="SetMaxAge">
									<target>
										<propertyReferenceExpression name="Cache">
											<variableReferenceExpression name="response"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<methodInvokeExpression methodName="FromSeconds">
											<target>
												<typeReferenceExpression type="TimeSpan"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="MaxAge"/>
											</parameters>
										</methodInvokeExpression>
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
