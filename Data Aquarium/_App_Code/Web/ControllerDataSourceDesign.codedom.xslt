<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="/">
		<compileUnit namespace="{a:project/a:namespace}.Web.Design">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Collections"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.ComponentModel.Design"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.UI.Design"/>
				<namespaceImport name="System.Web.UI.Design.WebControls"/>
				<namespaceImport name="System.Xml"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="{a:project/a:namespace}.Data"/>
			</imports>
			<types>
				<!-- class DataControllerService -->
				<typeDeclaration name="ControllerDataSourceDesigner">
					<baseTypes>
						<typeReference type="DataSourceDesigner"/>
					</baseTypes>
					<members>
						<memberField type="ControllerDataSource" name="control"/>
						<memberField type="ControllerDataSourceDesignView" name="view"/>
						<!-- Initialize(IComponent) -->
						<memberMethod name="Initialize">
							<attributes public="true" override="true"/>
							<parameters>
								<parameter type="IComponent" name="component"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="Initialize">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<argumentReferenceExpression name="component"/>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<fieldReferenceExpression name="control"/>
									<castExpression targetType="ControllerDataSource">
										<argumentReferenceExpression name="component"/>
									</castExpression>
								</assignStatement>
							</statements>
						</memberMethod>
						<!-- method GetView(string) -->
						<memberMethod returnType="DesignerDataSourceView" name="GetView">
							<attributes public="true" override="true"/>
							<parameters>
								<parameter type="System.String" name="viewName"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="Equals">
												<target>
													<argumentReferenceExpression name="viewName"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="DefaultViewName">
														<typeReferenceExpression type="ControllerDataSourceView"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="IWebApplication" name="webApp">
									<init>
										<castExpression targetType="IWebApplication">
											<methodInvokeExpression methodName="GetService">
												<target>
													<propertyReferenceExpression name="Site">
														<propertyReferenceExpression name="Component">
															<thisReferenceExpression/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<typeofExpression type="IWebApplication"/>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="webApp"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="IProjectItem" name="item">
									<init>
										<methodInvokeExpression methodName="GetProjectItemFromUrl">
											<target>
												<variableReferenceExpression name="webApp"/>
											</target>
											<parameters>
												<primitiveExpression value="~/Controllers"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="view"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<comment>ensure the view instance</comment>
										<assignStatement>
											<fieldReferenceExpression name="view"/>
											<objectCreateExpression type="ControllerDataSourceDesignView">
												<parameters>
													<thisReferenceExpression/>
													<propertyReferenceExpression name="DefaultViewName">
														<typeReferenceExpression type="ControllerDataSourceView"/>
													</propertyReferenceExpression>
												</parameters>
											</objectCreateExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="DataController">
										<fieldReferenceExpression name="view"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="DataController">
										<fieldReferenceExpression name="control"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="DataView">
										<fieldReferenceExpression name="view"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="DataView">
										<fieldReferenceExpression name="control"/>
									</propertyReferenceExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="item"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="BasePath">
												<fieldReferenceExpression name="view"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="PhysicalPath">
												<variableReferenceExpression name="item"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="view"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetViewNames() -->
						<memberMethod returnType="System.String[]" name="GetViewNames">
							<attributes public="true" override="true"/>
							<statements>
								<methodReturnStatement>
									<arrayCreateExpression>
										<createType type="System.String"/>
										<initializers>
											<propertyReferenceExpression name="DefaultViewName">
												<propertyReferenceExpression name="ControllerDataSourceView"/>
											</propertyReferenceExpression>
										</initializers>
									</arrayCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property CanRefreshSchema -->
						<memberProperty type="System.Boolean" name="CanRefreshSchema">
							<attributes public="true" override="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method RefreshSchema(bool) -->
						<memberMethod name="RefreshSchema">
							<attributes public="true" override="true"/>
							<parameters>
								<parameter type="System.Boolean" name="preferSilent"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="OnSchemaRefreshed">
									<parameters>
										<propertyReferenceExpression name="Empty">
											<typeReferenceExpression type="EventArgs"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method PreFilterProperties(IDictionary) -->
						<memberMethod name="PreFilterProperties">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="IDictionary" name="properties"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="PreFilterProperties">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<argumentReferenceExpression name="properties"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="PropertyDescriptor" name="typeNameProp">
									<init>
										<castExpression targetType="PropertyDescriptor">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="properties"/>
												</target>
												<indices>
													<primitiveExpression value="DataController"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<argumentReferenceExpression name="properties"/>
										</target>
										<indices>
											<primitiveExpression value="DataController"/>
										</indices>
									</arrayIndexerExpression>
									<methodInvokeExpression methodName="CreateProperty">
										<target>
											<typeReferenceExpression type="TypeDescriptor"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="GetType"/>
											<variableReferenceExpression name="typeNameProp"/>
											<arrayCreateExpression>
												<createType type="Attribute"/>
												<sizeExpression>
													<primitiveExpression value="0"/>
												</sizeExpression>
											</arrayCreateExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="typeNameProp"/>
									<castExpression targetType="PropertyDescriptor">
										<arrayIndexerExpression>
											<target>
												<argumentReferenceExpression name="properties"/>
											</target>
											<indices>
												<primitiveExpression value="DataView"/>
											</indices>
										</arrayIndexerExpression>
									</castExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<argumentReferenceExpression name="properties"/>
										</target>
										<indices>
											<primitiveExpression value="DataView"/>
										</indices>
									</arrayIndexerExpression>
									<methodInvokeExpression methodName="CreateProperty">
										<target>
											<typeReferenceExpression type="TypeDescriptor"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="GetType"/>
											<variableReferenceExpression name="typeNameProp"/>
											<arrayCreateExpression>
												<createType type="Attribute"/>
												<sizeExpression>
													<primitiveExpression value="0"/>
												</sizeExpression>
											</arrayCreateExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
							</statements>
						</memberMethod>
						<!-- property DataController -->
						<memberProperty type="System.String" name="DataController">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<propertyReferenceExpression name="DataController">
										<fieldReferenceExpression name="control"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<methodInvokeExpression methodName="Compare">
												<target>
													<typeReferenceExpression type="String"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="DataController">
														<fieldReferenceExpression name="control"/>
													</propertyReferenceExpression>
													<propertySetValueReferenceExpression/>
													<primitiveExpression value="false"/>
												</parameters>
											</methodInvokeExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="DataController">
												<fieldReferenceExpression name="control"/>
											</propertyReferenceExpression>
											<propertySetValueReferenceExpression/>
										</assignStatement>
										<methodInvokeExpression methodName="RefreshSchema">
											<parameters>
												<primitiveExpression value="false"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataView -->
						<memberProperty type="System.String" name="DataView">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<propertyReferenceExpression name="DataView">
										<fieldReferenceExpression name="control"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<methodInvokeExpression methodName="Compare">
												<target>
													<typeReferenceExpression type="String"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="DataView">
														<fieldReferenceExpression name="control"/>
													</propertyReferenceExpression>
													<propertySetValueReferenceExpression/>
													<primitiveExpression value="false"/>
												</parameters>
											</methodInvokeExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="DataView">
												<fieldReferenceExpression name="control"/>
											</propertyReferenceExpression>
											<propertySetValueReferenceExpression/>
										</assignStatement>
										<methodInvokeExpression methodName="RefreshSchema">
											<parameters>
												<primitiveExpression value="false"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</setStatements>
						</memberProperty>
					</members>
				</typeDeclaration>
				<!-- class ControllerDataSourceDesignView -->
				<typeDeclaration name="ControllerDataSourceDesignView">
					<baseTypes>
						<typeReference type="DesignerDataSourceView"/>
					</baseTypes>
					<members>
						<!-- property BasePath -->
						<memberField type="System.String" name="basePath"/>
						<memberProperty type="System.String" name="BasePath">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="basePath"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="basePath"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataController -->
						<memberField type="System.String" name="dataController"/>
						<memberProperty type="System.String" name="DataController">
							<attributes public="true" final="true"/>
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
						<!-- constructor ControllerDataSourceDesignView -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="ControllerDataSourceDesigner" name="owner"/>
								<parameter type="System.String" name="viewName"/>
							</parameters>
							<baseConstructorArgs>
								<argumentReferenceExpression name="owner"/>
								<argumentReferenceExpression name="viewName"/>
							</baseConstructorArgs>
						</constructor>
						<!-- property CanPage -->
						<memberProperty type="System.Boolean" name="CanPage">
							<attributes public="true" override="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property CanSort -->
						<memberProperty type="System.Boolean" name="CanSort">
							<attributes public="true" override ="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property CanRetrieveTotalRowCount -->
						<memberProperty type="System.Boolean" name="CanRetrieveTotalRowCount">
							<attributes public="true" override ="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property CanDelete -->
						<memberProperty type="System.Boolean" name="CanDelete">
							<attributes public="true" override ="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property CanInsert -->
						<memberProperty type="System.Boolean" name="CanInsert">
							<attributes public="true" override ="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property CanUpdate -->
						<memberProperty type="System.Boolean" name="CanUpdate">
							<attributes public="true" override ="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- propert Schema -->
						<memberProperty type="IDataSourceViewSchema" name="Schema">
							<attributes public="true" override="true"/>
							<getStatements>
								<variableDeclarationStatement type="XPathDocument" name="document">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>

								<variableDeclarationStatement type="Stream" name="res">
									<init>
										<methodInvokeExpression methodName="GetManifestResourceStream">
											<target>
												<propertyReferenceExpression name="Assembly">
													<methodInvokeExpression methodName="GetType"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Format">
													<target>
														<typeReferenceExpression type="String"/>
													</target>
													<parameters>
														4
														<primitiveExpression value="{a:project/a:namespace}.Controllers.{{0}}.xml"/>
														<propertyReferenceExpression name="DataController"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="res"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="res"/>
											<methodInvokeExpression methodName="GetManifestResourceStream">
												<target>
													<propertyReferenceExpression name="Assembly">
														<methodInvokeExpression methodName="GetType"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<methodInvokeExpression methodName="Format">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<primitiveExpression value="{a:project/a:namespace}.{{0}}.xml"/>
															<propertyReferenceExpression name="DataController"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="res"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="document"/>
											<objectCreateExpression type="XPathDocument">
												<parameters>
													<variableReferenceExpression name="res"/>
												</parameters>
											</objectCreateExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<variableDeclarationStatement type="System.String" name="dataControllerPath">
											<init>
												<methodInvokeExpression methodName="Combine">
													<target>
														<typeReferenceExpression type="Path"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="BasePath"/>
														<binaryOperatorExpression operator="Add">
															<propertyReferenceExpression name="DataController"/>
															<primitiveExpression value=".xml"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="document"/>
											<objectCreateExpression type="XPathDocument">
												<parameters>
													<variableReferenceExpression name="dataControllerPath"/>
												</parameters>
											</objectCreateExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<objectCreateExpression type="DataViewDesignSchema">
										<parameters>
											<variableReferenceExpression name="document"/>
											<propertyReferenceExpression name="DataView"/>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method GetDesignTimeData(int, out bool) -->
						<memberMethod returnType="IEnumerable" name="GetDesignTimeData">
							<attributes public="true" override="true"/>
							<parameters>
								<parameter type="System.Int32" name="minimumRows"/>
								<parameter type="System.Boolean" direction="Out" name="isSampleData"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="IDataSourceFieldSchema[]" name="fields">
									<init>
										<methodInvokeExpression methodName="GetFields">
											<target>
												<propertyReferenceExpression name="Schema"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="DataTable" name="dt">
									<init>
										<objectCreateExpression type="DataTable">
											<parameters>
												<propertyReferenceExpression name="DataView"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="IDataSourceFieldSchema" name="field"/>
									<target>
										<variableReferenceExpression name="fields"/>
									</target>
									<statements>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Columns">
													<variableReferenceExpression name="dt"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="Name">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="DataType">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<forStatement>
									<variable type="System.Int32" name="i">
										<init>
											<primitiveExpression value="0"/>
										</init>
									</variable>
									<test>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="i"/>
											<argumentReferenceExpression name="minimumRows"/>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="i"/>
									</increment>
									<statements>
										<variableDeclarationStatement type="DataRow" name="row">
											<init>
												<methodInvokeExpression methodName="NewRow">
													<target>
														<variableReferenceExpression name="dt"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="IDataSourceFieldSchema" name="field"/>
											<target>
												<variableReferenceExpression name="fields"/>
											</target>
											<statements>
												<variableDeclarationStatement type="System.String" name="typeName">
													<init>
														<propertyReferenceExpression name="Name">
															<propertyReferenceExpression name="DataType">
																<variableReferenceExpression name="field"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.Object" name="v" var="false">
													<init>
														<variableReferenceExpression name="i"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="typeName"/>
															<primitiveExpression value="String"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="v"/>
															<primitiveExpression value="abc"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="typeName"/>
																	<primitiveExpression value="DateTime"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="v"/>
																	<propertyReferenceExpression name="Now">
																		<typeReferenceExpression type="DateTime"/>
																	</propertyReferenceExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="typeName"/>
																			<primitiveExpression value="Boolean"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="v"/>
																			<binaryOperatorExpression operator="ValueEquality">
																				<binaryOperatorExpression operator="Modulus">
																					<variableReferenceExpression name="i"/>
																					<primitiveExpression value="2"/>
																				</binaryOperatorExpression>
																				<primitiveExpression value="1"/>
																			</binaryOperatorExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<variableReferenceExpression name="typeName"/>
																					<primitiveExpression value="Guid"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="v"/>
																					<methodInvokeExpression methodName="NewGuid">
																						<target>
																							<typeReferenceExpression type="Guid"/>
																						</target>
																					</methodInvokeExpression>
																				</assignStatement>
																			</trueStatements>
																			<falseStatements>
																				<conditionStatement>
																					<condition>
																						<unaryOperatorExpression operator="Not">
																							<methodInvokeExpression methodName="Contains">
																								<target>
																									<variableReferenceExpression name="typeName"/>
																								</target>
																								<parameters>
																									<primitiveExpression value="Int"/>
																								</parameters>
																							</methodInvokeExpression>
																						</unaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="v"/>
																							<binaryOperatorExpression operator="Divide">
																								<methodInvokeExpression methodName="ToDouble">
																									<target>
																										<typeReferenceExpression type="Convert"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="i"/>
																									</parameters>
																								</methodInvokeExpression>
																								<primitiveExpression value="10"/>
																							</binaryOperatorExpression>
																						</assignStatement>
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
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="row"/>
														</target>
														<indices>
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="field"/>
															</propertyReferenceExpression>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="v"/>
												</assignStatement>
											</statements>
										</foreachStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Rows">
													<variableReferenceExpression name="dt"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="row"/>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</forStatement>
								<methodInvokeExpression methodName="AcceptChanges">
									<target>
										<variableReferenceExpression name="dt"/>
									</target>
								</methodInvokeExpression>
								<assignStatement>
									<argumentReferenceExpression name="isSampleData"/>
									<primitiveExpression value="true"/>
								</assignStatement>
								<methodReturnStatement>
									<propertyReferenceExpression name="DefaultView">
										<variableReferenceExpression name="dt"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class DataViewDesignSchema -->
				<typeDeclaration name="DataViewDesignSchema">
					<baseTypes>
						<typeReference type="System.Object"/>
						<typeReference type="IDataSourceViewSchema"/>
					</baseTypes>
					<members>
						<memberField type="System.String" name="name"/>
						<memberField type="XmlNamespaceManager" name="nm"/>
						<memberField type="XPathNavigator" name="view"/>
						<!-- constructor DataViewDesignSchme(XPathDocument, string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="XPathDocument" name="document"/>
								<parameter type="System.String" name="dataView"/>
							</parameters>
							<statements>
								<comment>initialize the schema</comment>
								<variableDeclarationStatement type="XPathNavigator" name="navigator">
									<init>
										<methodInvokeExpression methodName="CreateNavigator">
											<target>
												<argumentReferenceExpression name="document"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<fieldReferenceExpression name="nm"/>
									<objectCreateExpression type="XmlNamespaceManager">
										<parameters>
											<propertyReferenceExpression name="NameTable">
												<variableReferenceExpression name="navigator"/>
											</propertyReferenceExpression>
										</parameters>
									</objectCreateExpression>
								</assignStatement>
								<methodInvokeExpression methodName="AddNamespace">
									<target>
										<fieldReferenceExpression name="nm"/>
									</target>
									<parameters>
										<primitiveExpression value="a"/>
										<primitiveExpression value="urn:schemas-codeontime-com:data-aquarium"/>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<fieldReferenceExpression name="name"/>
									<castExpression targetType="System.String">
										<methodInvokeExpression methodName="Evaluate">
											<target>
												<variableReferenceExpression name="navigator"/>
											</target>
											<parameters>
												<primitiveExpression value="string(/a:dataController/@name)"/>
												<fieldReferenceExpression name="nm"/>
											</parameters>
										</methodInvokeExpression>
									</castExpression>
								</assignStatement>
								<comment>find the data view metadata</comment>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="IsNullOrEmpty">
											<target>
												<typeReferenceExpression type="String"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="dataView"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="view"/>
											<methodInvokeExpression methodName="SelectSingleNode">
												<target>
													<variableReferenceExpression name="navigator"/>
												</target>
												<parameters>
													<primitiveExpression value="//a:view"/>
													<fieldReferenceExpression name="nm"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<fieldReferenceExpression name="view"/>
											<methodInvokeExpression methodName="SelectSingleNode">
												<target>
													<variableReferenceExpression name="navigator"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="Format">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<primitiveExpression value="//a:view[@id='{{0}}']"/>
															<argumentReferenceExpression name="dataView"/>
														</parameters>
													</methodInvokeExpression>
													<fieldReferenceExpression name="nm"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</constructor>
						<!-- method IDataSourceViewSchema.GetChildren()-->
						<memberMethod returnType="IDataSourceViewSchema[]" name="GetChildren" privateImplementationType="IDataSourceViewSchema">
							<attributes/>
							<statements>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IDataSourceViewSchema.GetFields() -->
						<memberMethod returnType="IDataSourceFieldSchema[]" name="GetFields" privateImplementationType="IDataSourceViewSchema">
							<attributes/>
							<statements>
								<variableDeclarationStatement type="List" name="fields">
									<typeArguments>
										<typeReference type="IDataSourceFieldSchema"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="IDataSourceFieldSchema"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="view"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="XPathNodeIterator" name="dataFieldIterator">
											<init>
												<methodInvokeExpression methodName="Select">
													<target>
														<fieldReferenceExpression name="view"/>
													</target>
													<parameters>
														<primitiveExpression value=".//a:dataField"/>
														<fieldReferenceExpression name="nm"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<methodInvokeExpression methodName="MoveNext">
													<target>
														<variableReferenceExpression name="dataFieldIterator"/>
													</target>
												</methodInvokeExpression>
											</test>
											<statements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="fields"/>
													</target>
													<parameters>
														<objectCreateExpression type="DataViewFieldSchema">
															<parameters>
																<propertyReferenceExpression name="Current">
																	<variableReferenceExpression name="dataFieldIterator"/>
																</propertyReferenceExpression>
																<fieldReferenceExpression name="nm"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</whileStatement>
										<variableDeclarationStatement type="XPathNodeIterator" name="systemFieldIterator">
											<init>
												<methodInvokeExpression methodName="Select">
													<target>
														<fieldReferenceExpression name="view"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="Format">
															<target>
																<typeReferenceExpression type="String"/>
															</target>
															<parameters>
																<primitiveExpression value="//a:field[not(@name=//a:view[@id='{{0}}']//a:dataField/@fieldName) and @isPrimaryKey='true']"/>
																<methodInvokeExpression methodName="GetAttribute">
																	<target>
																		<fieldReferenceExpression name="view"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="id"/>
																		<propertyReferenceExpression name="Empty">
																			<typeReferenceExpression type="String"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<fieldReferenceExpression name="nm"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<methodInvokeExpression methodName="MoveNext">
													<target>
														<variableReferenceExpression name="systemFieldIterator"/>
													</target>
												</methodInvokeExpression>
											</test>
											<statements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="fields"/>
													</target>
													<parameters>
														<objectCreateExpression type="DataViewFieldSchema">
															<parameters>
																<propertyReferenceExpression name="Current">
																	<variableReferenceExpression name="systemFieldIterator"/>
																</propertyReferenceExpression>
																<fieldReferenceExpression name="nm"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</whileStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="fields"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property IDataSourceViewSchema.Name -->
						<memberProperty type="System.String" name="Name" privateImplementationType="IDataSourceViewSchema">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="name"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
					</members>
				</typeDeclaration>
				<!-- class DataViewFieldSchema -->
				<typeDeclaration name="DataViewFieldSchema">
					<baseTypes>
						<typeReference type="System.Object"/>
						<typeReference type="IDataSourceFieldSchema"/>
					</baseTypes>
					<members>
						<memberField type="System.String" name="name"/>
						<memberField type="Type" name="type"/>
						<memberField type="System.Boolean" name="identity"/>
						<memberField type="System.Boolean" name="readOnly"/>
						<memberField type="System.Boolean" name="unique"/>
						<memberField type="System.Int32" name="length"/>
						<memberField type="System.Boolean" name="nullable"/>
						<memberField type="System.Boolean" name="primaryKey"/>
						<!-- constructor DataViewFieldSchema(XPathNavigator, XmlNamespaceManager) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="XPathNavigator" name="fieldInfo"/>
								<parameter type="XmlNamespaceManager" name="nm"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="XPathNavigator" name="field">
									<init>
										<argumentReferenceExpression name="fieldInfo"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="LocalName">
												<argumentReferenceExpression name="fieldInfo"/>
											</propertyReferenceExpression>
											<primitiveExpression value="dataField"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="name"/>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<argumentReferenceExpression name="fieldInfo"/>
												</target>
												<parameters>
													<primitiveExpression value="fieldName"/>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<variableDeclarationStatement type="System.String" name="aliasFieldName">
											<init>
												<methodInvokeExpression methodName="GetAttribute">
													<target>
														<argumentReferenceExpression name="fieldInfo"/>
													</target>
													<parameters>
														<primitiveExpression value="aliasFieldName"/>
														<propertyReferenceExpression name="Empty">
															<typeReferenceExpression type="String"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="IsNullOrEmpty">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<variableReferenceExpression name="aliasFieldName"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<fieldReferenceExpression name="name"/>
													<variableReferenceExpression name="aliasFieldName"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="field"/>
											<methodInvokeExpression methodName="SelectSingleNode">
												<target>
													<argumentReferenceExpression name="fieldInfo"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="Format">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<primitiveExpression value="/a:dataController/a:fields/a:field[@name='{{0}}']"/>
															<fieldReferenceExpression name="name"/>
														</parameters>
													</methodInvokeExpression>
													<argumentReferenceExpression name="nm"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<fieldReferenceExpression name="name"/>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<argumentReferenceExpression name="fieldInfo"/>
												</target>
												<parameters>
													<primitiveExpression value="name"/>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
								<assignStatement>
									<fieldReferenceExpression name="type"/>
									<typeofExpression type="System.String"/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="field"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="type"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="TypeMap">
														<typeReferenceExpression type="Controller"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<methodInvokeExpression methodName="GetAttribute">
														<target>
															<variableReferenceExpression  name="field"/>
														</target>
														<parameters>
															<primitiveExpression value="type"/>
															<propertyReferenceExpression name="Empty">
																<typeReferenceExpression type="String"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="IsNullOrEmpty">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="GetAttribute">
																<target>
																	<variableReferenceExpression name="field"/>
																</target>
																<parameters>
																	<primitiveExpression value="length"/>
																	<propertyReferenceExpression name="Empty">
																		<typeReferenceExpression type="String"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<fieldReferenceExpression name="length"/>
													<methodInvokeExpression methodName="ToInt32">
														<target>
															<typeReferenceExpression type="Convert"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="GetAttribute">
																<target>
																	<variableReferenceExpression name="field"/>
																</target>
																<parameters>
																	<primitiveExpression value="length"/>
																	<propertyReferenceExpression name="Empty">
																		<typeReferenceExpression type="String"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<fieldReferenceExpression name="identity"/>
											<castExpression targetType="System.Boolean">
												<methodInvokeExpression methodName="Evaluate">
													<target>
														<variableReferenceExpression name="field"/>
													</target>
													<parameters>
														<primitiveExpression value="@isPrimaryKey='true' and @readOnly='true'"/>
													</parameters>
												</methodInvokeExpression>
											</castExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="readOnly"/>
											<castExpression targetType="System.Boolean">
												<methodInvokeExpression methodName="Evaluate">
													<target>
														<variableReferenceExpression name="field"/>
													</target>
													<parameters>
														<primitiveExpression value="@readOnly='true'"/>
													</parameters>
												</methodInvokeExpression>
											</castExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="unique"/>
											<primitiveExpression value="false"/>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="nullable"/>
											<castExpression targetType="System.Boolean">
												<methodInvokeExpression methodName="Evaluate">
													<target>
														<variableReferenceExpression name="field"/>
													</target>
													<parameters>
														<primitiveExpression value="not(@allowNulls='false')"/>
													</parameters>
												</methodInvokeExpression>
											</castExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="primaryKey"/>
											<castExpression targetType="System.Boolean">
												<methodInvokeExpression methodName="Evaluate">
													<target>
														<variableReferenceExpression name="field"/>
													</target>
													<parameters>
														<primitiveExpression value="@isPrimaryKey='true'"/>
													</parameters>
												</methodInvokeExpression>
											</castExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</constructor>
						<!-- property IDataSourceFieldSchema.DataType -->
						<memberProperty type="Type" name="DataType" privateImplementationType="IDataSourceFieldSchema">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="type"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property IDataSourceFieldSchema.Identity -->
						<memberProperty type="System.Boolean" name="Identity" privateImplementationType="IDataSourceFieldSchema">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="identity"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property IDataSourceFieldSchema.IsReadOnly -->
						<memberProperty type="System.Boolean" name="IsReadOnly" privateImplementationType="IDataSourceFieldSchema">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="readOnly"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property IDataSourceFieldSchema.IsUnique -->
						<memberProperty type="System.Boolean" name="IsUnique" privateImplementationType="IDataSourceFieldSchema">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="unique"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property IDataSourceFieldSchema.Length -->
						<memberProperty type="System.Int32" name="Length" privateImplementationType="IDataSourceFieldSchema">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="length"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property IDataSourceFieldSchema.Name -->
						<memberProperty type="System.String" name="Name" privateImplementationType="IDataSourceFieldSchema">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="name"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property IDataSourceFieldSchema.Nullable -->
						<memberProperty type="System.Boolean" name="Nullable" privateImplementationType="IDataSourceFieldSchema">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="nullable"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property IDataSourceFieldSchema.Precision -->
						<memberProperty type="System.Int32" name="Precision" privateImplementationType="IDataSourceFieldSchema">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="0"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property IDataSourceFieldSchema.PrimaryKey -->
						<memberProperty type="System.Boolean" name="PrimaryKey" privateImplementationType="IDataSourceFieldSchema">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="primaryKey"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property IDataSourceFieldSchema.Scale -->
						<memberProperty type="System.Int32" name="Scale" privateImplementationType="IDataSourceFieldSchema">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="0"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
