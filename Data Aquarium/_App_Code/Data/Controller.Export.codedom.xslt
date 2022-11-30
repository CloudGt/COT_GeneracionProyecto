<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsPremium"/>
	<xsl:param name="UseMemoryStream"/>
	<xsl:variable name="Namespace" select="a:project/a:namespace"/>
	<!--<xsl:variable name="EnableTransactions" select="a:project/a:features/@enableTransactions"/>-->

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Data">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.Configuration"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Data.Common"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Transactions"/>
				<namespaceImport name="System.Xml"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="System.Xml.Xsl"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Caching"/>
				<namespaceImport name="System.Web.Configuration"/>
				<namespaceImport name="System.Web.Security"/>
			</imports>
			<types>
				<!-- DataControllerBase -->
				<typeDeclaration name="DataControllerBase" isPartial="true">
					<!--<baseTypes>
            <typeReference type="System.Object"/>
            <typeReference type="IDataController"/>
            <typeReference type="IAutoCompleteManager"/>
            <typeReference type="IDataEngine"/>
            <typeReference type="IBusinessObject"/>
          </baseTypes>-->
					<members>
						<memberField type="System.Int32" name="MaximumRssItems">
							<attributes public="true" const="true"/>
							<init>
								<primitiveExpression value="200"/>
							</init>
						</memberField>
						<!-- method ExportDataAsRowset(ViewPage page, DbDataReader reader, StreamWriter writer, string) -->
						<memberMethod name="ExportDataAsRowset">
							<attributes public="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
								<parameter type="DbDataReader" name="reader"/>
								<parameter type="StreamWriter" name="writer"/>
								<parameter type="System.String" name="scope"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="List" name="fields">
									<typeArguments>
										<typeReference type="DataField"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="DataField"/>
											</typeArguments>
										</objectCreateExpression>
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
												<binaryOperatorExpression operator="BooleanAnd">
													<unaryOperatorExpression operator="Not">
														<binaryOperatorExpression operator="BooleanOr">
															<propertyReferenceExpression name="Hidden">
																<variableReferenceExpression name="field"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="BooleanOr">
																<propertyReferenceExpression name="OnDemand">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Type">
																		<variableReferenceExpression name="field"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="DataView"/>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</unaryOperatorExpression>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="Contains">
															<target>
																<variableReferenceExpression name="fields"/>
															</target>
															<parameters>
																<variableReferenceExpression name="field"/>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="DataField" name="aliasField">
													<init>
														<variableReferenceExpression name="field"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<propertyReferenceExpression name="AliasName">
																<variableReferenceExpression name="field"/>
															</propertyReferenceExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="aliasField"/>
															<methodInvokeExpression methodName="FindField">
																<target>
																	<argumentReferenceExpression name="page"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="AliasName">
																		<variableReferenceExpression name="field"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="fields"/>
													</target>
													<parameters>
														<variableReferenceExpression name="aliasField"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<variableDeclarationStatement type="System.String" name="s">
									<init>
										<primitiveExpression value="uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="dt">
									<init>
										<primitiveExpression value="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="rs">
									<init>
										<primitiveExpression value="urn:schemas-microsoft-com:rowset"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="z">
									<init>
										<primitiveExpression value="#RowsetSchema"/>
									</init>
								</variableDeclarationStatement>

								<variableDeclarationStatement name="output">
									<init>
										<castExpression targetType="XmlWriter">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Items">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="Export_XmlWriter"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>

								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="output"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
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
											<primitiveExpression value="false"/>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="output"/>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="XmlWriter"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="writer"/>
													<variableReferenceExpression name="settings"/>
												</parameters>
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
													<primitiveExpression value="Export_XmlWriter"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="output"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>

								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="ValueEquality">
												<argumentReferenceExpression name="scope"/>
												<primitiveExpression value="all"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<argumentReferenceExpression name="scope"/>
												<primitiveExpression value="start"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="WriteStartDocument">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="xml"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="xmlns"/>
												<primitiveExpression value="s"/>
												<primitiveExpression value="null"/>
												<variableReferenceExpression name="s"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="xmlns"/>
												<primitiveExpression value="dt"/>
												<primitiveExpression value="null"/>
												<variableReferenceExpression name="dt"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="xmlns"/>
												<primitiveExpression value="rs"/>
												<primitiveExpression value="null"/>
												<variableReferenceExpression name="rs"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="xmlns"/>
												<primitiveExpression value="z"/>
												<primitiveExpression value="null"/>
												<variableReferenceExpression name="z"/>
											</parameters>
										</methodInvokeExpression>
										<comment>declare rowset schema</comment>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="Schema"/>
												<variableReferenceExpression name="s"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="id"/>
												<primitiveExpression value="RowsetSchema"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="ElementType"/>
												<variableReferenceExpression name="s"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="name"/>
												<primitiveExpression value="row"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="content"/>
												<primitiveExpression value="eltOnly"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="CommandTimeout"/>
												<variableReferenceExpression name="rs"/>
												<primitiveExpression value="60" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<!-- 
            List<DataField> fields = new List<DataField>();
            foreach (DataField field in page.Fields)
                if (!((field.Hidden || field.OnDemand)) && !fields.Contains(field))
                {
                    DataField aliasField = field;
                    if (!(String.IsNullOrEmpty(field.AliasName)))
                        aliasField = page.FindField(field.AliasName);
                    fields.Add(aliasField);
                }                -->
										<variableDeclarationStatement type="System.Int32" name="number">
											<init>
												<primitiveExpression value="1"/>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="DataField" name="field"/>
											<target>
												<variableReferenceExpression name="fields"/>
											</target>
											<statements>
												<!--<methodInvokeExpression methodName="NormalizeDataFormatString">
											<target>
												<variableReferenceExpression name="field"/>
											</target>
										</methodInvokeExpression>-->
												<methodInvokeExpression methodName="WriteStartElement">
													<target>
														<variableReferenceExpression name="output"/>
													</target>
													<parameters>
														<primitiveExpression value="AttributeType"/>
														<variableReferenceExpression name="s"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="output"/>
													</target>
													<parameters>
														<primitiveExpression value="name"/>
														<propertyReferenceExpression name="Name">
															<variableReferenceExpression name="field"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="output"/>
													</target>
													<parameters>
														<primitiveExpression value="number"/>
														<variableReferenceExpression name="rs"/>
														<methodInvokeExpression methodName="ToString">
															<target>
																<variableReferenceExpression name="number"/>
															</target>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="output"/>
													</target>
													<parameters>
														<primitiveExpression value="nullable"/>
														<variableReferenceExpression name="rs"/>
														<primitiveExpression value="true" convertTo="String"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="output"/>
													</target>
													<parameters>
														<primitiveExpression value="name"/>
														<variableReferenceExpression name="rs"/>
														<propertyReferenceExpression name="Label">
															<variableReferenceExpression name="field"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteStartElement">
													<target>
														<variableReferenceExpression name="output"/>
													</target>
													<parameters>
														<primitiveExpression value="datatype"/>
														<variableReferenceExpression name="s"/>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement type="System.String" name="type">
													<init>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="RowsetTypeMap"/>
															</target>
															<indices>
																<propertyReferenceExpression name="Type">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="dbType">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Equals">
															<target>
																<primitiveExpression value="{{0:c}}"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="DataFormatString">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="CurrentCultureIgnoreCase">
																	<typeReferenceExpression type="StringComparison"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="dbType"/>
															<primitiveExpression value="currency"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<propertyReferenceExpression name="DataFormatString">
																			<variableReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																	</unaryOperatorExpression>
																	<binaryOperatorExpression operator="ValueInequality">
																		<propertyReferenceExpression name="Type">
																			<variableReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="DateTime"/>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="type"/>
																	<primitiveExpression value="string"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="output"/>
													</target>
													<parameters>
														<primitiveExpression value="type"/>
														<variableReferenceExpression name="dt"/>
														<variableReferenceExpression name="type"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteAttributeString">
													<target>
														<variableReferenceExpression name="output"/>
													</target>
													<parameters>
														<primitiveExpression value="dbtype"/>
														<variableReferenceExpression name="rs"/>
														<variableReferenceExpression name="dbType"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteEndElement">
													<target>
														<variableReferenceExpression name="output"/>
													</target>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteEndElement">
													<target>
														<variableReferenceExpression name="output"/>
													</target>
												</methodInvokeExpression>
												<assignStatement>
													<variableReferenceExpression name="number"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="number"/>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</assignStatement>

											</statements>
										</foreachStatement>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="extends"/>
												<variableReferenceExpression name="s"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteAttributeString">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="type"/>
												<primitiveExpression value="rs:rowbase"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="data"/>
												<variableReferenceExpression name="rs"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>

								<comment>output rowset data</comment>
								<whileStatement>
									<test>
										<methodInvokeExpression methodName="Read">
											<target>
												<variableReferenceExpression name="reader"/>
											</target>
										</methodInvokeExpression>
									</test>
									<statements>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<argumentReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="row"/>
												<variableReferenceExpression name="z"/>
											</parameters>
										</methodInvokeExpression>
										<foreachStatement>
											<variable type="DataField" name="field"/>
											<target>
												<variableReferenceExpression name="fields"/>
											</target>
											<statements>
												<variableDeclarationStatement type="System.Object" name="v">
													<init>
														<arrayIndexerExpression>
															<target>
																<argumentReferenceExpression name="reader"/>
															</target>
															<indices>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
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
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<unaryOperatorExpression operator="Not">
																		<methodInvokeExpression methodName="IsNullOrEmpty">
																			<target>
																				<typeReferenceExpression type="String"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="DataFormatString">
																					<variableReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</unaryOperatorExpression>
																	<unaryOperatorExpression operator="Not">
																		<binaryOperatorExpression operator="BooleanOr">
																			<binaryOperatorExpression operator="ValueEquality">
																				<propertyReferenceExpression name="DataFormatString">
																					<variableReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																				<primitiveExpression value="{{0:d}}"/>
																			</binaryOperatorExpression>
																			<binaryOperatorExpression operator="ValueEquality">
																				<propertyReferenceExpression name="DataFormatString">
																					<variableReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																				<primitiveExpression value="{{0:c}}"/>
																			</binaryOperatorExpression>
																		</binaryOperatorExpression>
																	</unaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="WriteAttributeString">
																	<target>
																		<variableReferenceExpression name="output"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																		<methodInvokeExpression methodName="Format">
																			<target>
																				<typeReferenceExpression type="String"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="DataFormatString">
																					<variableReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																				<variableReferenceExpression name="v"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="Type">
																				<variableReferenceExpression name="field"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="DateTime"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="WriteAttributeString">
																			<target>
																				<variableReferenceExpression name="output"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																				<methodInvokeExpression methodName="ToString">
																					<target>
																						<castExpression targetType="DateTime">
																							<variableReferenceExpression name="v"/>
																						</castExpression>
																					</target>
																					<parameters>
																						<primitiveExpression value="s"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																	<falseStatements>
																		<methodInvokeExpression methodName="WriteAttributeString">
																			<target>
																				<variableReferenceExpression name="output"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																				<methodInvokeExpression methodName="ToString">
																					<target>
																						<variableReferenceExpression name="v"/>
																					</target>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>

											</statements>
										</foreachStatement>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
										</methodInvokeExpression>
									</statements>
								</whileStatement>

								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="ValueEquality">
												<argumentReferenceExpression name="scope"/>
												<primitiveExpression value="all"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<argumentReferenceExpression name="scope"/>
												<primitiveExpression value="end"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndDocument">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Close">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Remove">
											<target>
												<propertyReferenceExpression name="Items">
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="HttpContext"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<primitiveExpression value="Export_XmlWriter"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ExportDataAsRss(ViewPage page, DbDataReader reader, StreamWriter writer, string) -->
						<memberMethod name="ExportDataAsRss">
							<attributes public="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
								<parameter type="DbDataReader" name="reader"/>
								<parameter type="StreamWriter" name="writer"/>
								<parameter type="System.String" name="scope"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="appPath">
									<init>
										<methodInvokeExpression methodName="Replace">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="AbsoluteUri">
													<propertyReferenceExpression name="Url">
														<propertyReferenceExpression name="Request">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
												<primitiveExpression value="^(.+)Export.ashx.+$"/>
												<primitiveExpression value="$1"/>
												<propertyReferenceExpression name="IgnoreCase">
													<typeReferenceExpression type="RegexOptions"/>
												</propertyReferenceExpression>
												<!--<binaryOperatorExpression operator="BitwiseOr">
                          <propertyReferenceExpression name="Compiled">
                            <typeReferenceExpression type="RegexOptions"/>
                          </propertyReferenceExpression>
                          <propertyReferenceExpression name="IgnoreCase">
                            <typeReferenceExpression type="RegexOptions"/>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>-->
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="XmlWriterSettings" name="settings">
									<init>
										<objectCreateExpression type="XmlWriterSettings"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="CloseOutput">
										<variableReferenceExpression name="settings"/>
									</propertyReferenceExpression>
									<primitiveExpression value="false"/>
								</assignStatement>
								<variableDeclarationStatement type="XmlWriter" name="output">
									<init>
										<methodInvokeExpression methodName="Create">
											<target>
												<variableReferenceExpression name="XmlWriter"/>
											</target>
											<parameters>
												<variableReferenceExpression name="writer"/>
												<variableReferenceExpression name="settings"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="WriteStartDocument">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="WriteStartElement">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
									<parameters>
										<primitiveExpression value="rss"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="WriteAttributeString">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
									<parameters>
										<primitiveExpression value="version"/>
										<primitiveExpression value="2.0" convertTo="String"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="WriteStartElement">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
									<parameters>
										<primitiveExpression value="channel"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="WriteElementString">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
									<parameters>
										<primitiveExpression value="title"/>
										<castExpression targetType="System.String">
											<methodInvokeExpression methodName="Evaluate">
												<target>
													<fieldReferenceExpression name="view"/>
												</target>
												<parameters>
													<primitiveExpression value="string(concat(/c:dataController/@label, ' | ',  @label))"/>
													<propertyReferenceExpression name="Resolver"/>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="WriteElementString">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
									<parameters>
										<primitiveExpression value="lastBuildDate"/>
										<methodInvokeExpression methodName="ToString">
											<target>
												<propertyReferenceExpression name="Now">
													<typeReferenceExpression type="DateTime"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<primitiveExpression value="r"/>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="WriteElementString">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
									<parameters>
										<primitiveExpression value="language"/>
										<methodInvokeExpression methodName="ToLower">
											<target>
												<propertyReferenceExpression name="Name">
													<propertyReferenceExpression name="CurrentCulture">
														<propertyReferenceExpression name="CurrentThread">
															<typeReferenceExpression type="System.Threading.Thread"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="System.Int32" name="rowCount">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="LessThan">
												<variableReferenceExpression name="rowCount"/>
												<propertyReferenceExpression name="MaximumRssItems"/>
											</binaryOperatorExpression>
											<methodInvokeExpression methodName="Read">
												<target>
													<argumentReferenceExpression name="reader"/>
												</target>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</test>
									<statements>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="item"/>
											</parameters>
										</methodInvokeExpression>
										<variableDeclarationStatement type="System.Boolean" name="hasTitle">
											<init>
												<primitiveExpression value="false"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Boolean" name="hasPubDate">
											<init>
												<primitiveExpression value="false"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="StringBuilder" name="desc">
											<init>
												<objectCreateExpression type="StringBuilder"/>
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
														<propertyReferenceExpression name="Fields">
															<argumentReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</test>
											<increment>
												<variableReferenceExpression name="i"/>
											</increment>
											<statements>
												<variableDeclarationStatement type="DataField" name="field">
													<init>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Fields">
																	<argumentReferenceExpression name="page"/>
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
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="Not">
																<propertyReferenceExpression name="Hidden">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="ValueInequality">
																<propertyReferenceExpression name="Type">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
																<primitiveExpression value="DataView"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<!--<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="rowCount"/>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="NormalizeDataFormatString">
																	<target>
																		<variableReferenceExpression name="field"/>
																	</target>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>-->
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="IsNullOrEmpty">
																		<target>
																			<typeReferenceExpression type="String"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="AliasName">
																				<variableReferenceExpression name="field"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="field"/>
																	<methodInvokeExpression methodName="FindField">
																		<target>
																			<argumentReferenceExpression name="page"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="AliasName">
																				<variableReferenceExpression name="field"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<variableDeclarationStatement type="System.String" name="text">
															<init>
																<propertyReferenceExpression name="Empty">
																	<typeReferenceExpression type="String"/>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Object" name="v">
															<init>
																<arrayIndexerExpression>
																	<target>
																		<argumentReferenceExpression name="reader"/>
																	</target>
																	<indices>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
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
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="IsNullOrEmpty">
																				<target>
																					<typeReferenceExpression type="String"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="DataFormatString">
																						<variableReferenceExpression name="field"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="text"/>
																			<methodInvokeExpression methodName="Format">
																				<target>
																					<typeReferenceExpression type="String"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="DataFormatString">
																						<variableReferenceExpression name="field"/>
																					</propertyReferenceExpression>
																					<variableReferenceExpression name="v"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<variableReferenceExpression name="text"/>
																			<methodInvokeExpression methodName="ToString">
																				<target>
																					<typeReferenceExpression type="Convert"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="v"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<unaryOperatorExpression operator="Not">
																		<variableReferenceExpression name="hasPubDate"/>
																	</unaryOperatorExpression>
																	<binaryOperatorExpression operator="ValueEquality">
																		<propertyReferenceExpression name="Type">
																			<variableReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="DateTime"/>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="hasPubDate"/>
																	<primitiveExpression value="true"/>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="IsNullOrEmpty">
																				<target>
																					<typeReferenceExpression type="String"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="text"/>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="WriteElementString">
																			<target>
																				<variableReferenceExpression name="output"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="pubDate"/>
																				<methodInvokeExpression methodName="ToString">
																					<target>
																						<castExpression targetType="DateTime">
																							<arrayIndexerExpression>
																								<target>
																									<argumentReferenceExpression name="reader"/>
																								</target>
																								<indices>
																									<propertyReferenceExpression name="Name">
																										<variableReferenceExpression name="field"/>
																									</propertyReferenceExpression>
																								</indices>
																							</arrayIndexerExpression>
																						</castExpression>
																					</target>
																					<parameters>
																						<primitiveExpression value="r"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<variableReferenceExpression name="hasTitle"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="hasTitle"/>
																	<primitiveExpression value="true"/>
																</assignStatement>
																<methodInvokeExpression methodName="WriteElementString">
																	<target>
																		<variableReferenceExpression name="output"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="title"/>
																		<variableReferenceExpression name="text"/>
																	</parameters>
																</methodInvokeExpression>
																<variableDeclarationStatement type="StringBuilder" name="link">
																	<init>
																		<objectCreateExpression type="StringBuilder"/>
																	</init>
																</variableDeclarationStatement>
																<methodInvokeExpression methodName="Append">
																	<target>
																		<variableReferenceExpression name="link"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="Evaluate">
																			<target>
																				<fieldReferenceExpression name="config"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="string(/c:dataController/@name)"/>
																				<!--<propertyReferenceExpression name="Resolver"/>-->
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
																<foreachStatement>
																	<variable type="DataField" name="pkf"/>
																	<target>
																		<propertyReferenceExpression name="Fields">
																			<argumentReferenceExpression name="page"/>
																		</propertyReferenceExpression>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<propertyReferenceExpression name="IsPrimaryKey">
																					<variableReferenceExpression name="pkf"/>
																				</propertyReferenceExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Append">
																					<target>
																						<variableReferenceExpression name="link"/>
																					</target>
																					<parameters>
																						<methodInvokeExpression methodName="Format">
																							<target>
																								<typeReferenceExpression type="String"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="&amp;{{0}}={{1}}"/>
																								<propertyReferenceExpression name="Name">
																									<variableReferenceExpression name="pkf"/>
																								</propertyReferenceExpression>
																								<arrayIndexerExpression>
																									<target>
																										<argumentReferenceExpression name="reader"/>
																									</target>
																									<indices>
																										<propertyReferenceExpression name="Name">
																											<variableReferenceExpression name="pkf"/>
																										</propertyReferenceExpression>
																									</indices>
																								</arrayIndexerExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
																<variableDeclarationStatement type="System.String" name="itemGuid">
																	<init>
																		<methodInvokeExpression methodName="Format">
																			<target>
																				<typeReferenceExpression type="String"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="{{0}}Details.aspx?l={{1}}"/>
																				<variableReferenceExpression name="appPath"/>
																				<methodInvokeExpression methodName="UrlEncode">
																					<target>
																						<typeReferenceExpression type="HttpUtility"/>
																					</target>
																					<parameters>
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
																										<methodInvokeExpression methodName="ToString">
																											<target>
																												<variableReferenceExpression name="link"/>
																											</target>
																										</methodInvokeExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<methodInvokeExpression methodName="WriteElementString">
																	<target>
																		<variableReferenceExpression name="output"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="link"/>
																		<variableReferenceExpression name="itemGuid"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteElementString">
																	<target>
																		<variableReferenceExpression name="output"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="guid"/>
																		<variableReferenceExpression name="itemGuid"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<unaryOperatorExpression operator="Not">
																				<methodInvokeExpression methodName="IsNullOrEmpty">
																					<target>
																						<typeReferenceExpression type="String"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="OnDemandHandler">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</unaryOperatorExpression>
																			<binaryOperatorExpression operator="ValueEquality">
																				<propertyReferenceExpression name="OnDemandStyle">
																					<propertyReferenceExpression name="field"/>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="Thumbnail">
																					<typeReferenceExpression type="OnDemandDisplayStyle"/>
																				</propertyReferenceExpression>
																			</binaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="Equals">
																					<target>
																						<variableReferenceExpression name="text"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="1" convertTo="String"/>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="AppendFormat">
																					<target>
																						<variableReferenceExpression name="desc"/>
																					</target>
																					<parameters>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[{0}:<br /><img src="{1}Blob.ashx?{2}=t]]></xsl:attribute>
																						</primitiveExpression>
																						<methodInvokeExpression methodName="HtmlEncode">
																							<target>
																								<typeReferenceExpression type="HttpUtility"/>
																							</target>
																							<parameters>
																								<propertyReferenceExpression name="Label">
																									<variableReferenceExpression name="field"/>
																								</propertyReferenceExpression>
																							</parameters>
																						</methodInvokeExpression>
																						<variableReferenceExpression name="appPath"/>
																						<propertyReferenceExpression name="OnDemandHandler">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<foreachStatement>
																					<variable type="DataField" name="f"/>
																					<target>
																						<propertyReferenceExpression name="Fields">
																							<argumentReferenceExpression name="page"/>
																						</propertyReferenceExpression>
																					</target>
																					<statements>
																						<conditionStatement>
																							<condition>
																								<propertyReferenceExpression name="IsPrimaryKey">
																									<variableReferenceExpression name="f"/>
																								</propertyReferenceExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="Append">
																									<target>
																										<variableReferenceExpression name="desc"/>
																									</target>
																									<parameters>
																										<primitiveExpression value="|"/>
																									</parameters>
																								</methodInvokeExpression>
																								<methodInvokeExpression methodName="Append">
																									<target>
																										<variableReferenceExpression name="desc"/>
																									</target>
																									<parameters>
																										<arrayIndexerExpression>
																											<target>
																												<argumentReferenceExpression name="reader"/>
																											</target>
																											<indices>
																												<propertyReferenceExpression name="Name">
																													<variableReferenceExpression name="f"/>
																												</propertyReferenceExpression>
																											</indices>
																										</arrayIndexerExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																					</statements>
																				</foreachStatement>
																				<methodInvokeExpression methodName="Append">
																					<target>
																						<variableReferenceExpression name="desc"/>
																					</target>
																					<parameters>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[" style="width:92px;height:71px;"/><br />]]></xsl:attribute>
																						</primitiveExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																	<falseStatements>
																		<methodInvokeExpression methodName="AppendFormat">
																			<target>
																				<variableReferenceExpression name="desc"/>
																			</target>
																			<parameters>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[{0}: {1}<br />]]></xsl:attribute>
																				</primitiveExpression>
																				<methodInvokeExpression methodName="HtmlEncode">
																					<target>
																						<typeReferenceExpression type="HttpUtility"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="Label">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="HtmlEncode">
																					<target>
																						<typeReferenceExpression type="HttpUtility"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="text"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</forStatement>
										<methodInvokeExpression methodName="WriteStartElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<primitiveExpression value="description"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteCData">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Format">
													<target>
														<typeReferenceExpression type="String"/>
													</target>
													<parameters>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[<span style=\"font-size:small;\">{0}</span>]]></xsl:attribute>
														</primitiveExpression>
														<methodInvokeExpression methodName="ToString">
															<target>
																<variableReferenceExpression name="desc"/>
															</target>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="WriteEndElement">
											<target>
												<variableReferenceExpression name="output"/>
											</target>
										</methodInvokeExpression>
										<assignStatement>
											<variableReferenceExpression name="rowCount"/>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="rowCount"/>
												<primitiveExpression value="1"/>
											</binaryOperatorExpression>
										</assignStatement>
									</statements>
								</whileStatement>
								<methodInvokeExpression methodName="WriteEndElement">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="WriteEndElement">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="WriteEndDocument">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Close">
									<target>
										<variableReferenceExpression name="output"/>
									</target>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- ExportDataAsCsv(ViewPage page, DbDataReader reader, StreamWriter writer, string) -->
						<memberMethod name="ExportDataAsCsv">
							<attributes public="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
								<parameter type="DbDataReader" name="reader"/>
								<parameter type="StreamWriter" name="writer"/>
								<parameter type="System.String" name="scope"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Boolean" name="firstField">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>

								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="ValueEquality">
												<argumentReferenceExpression name="scope"/>
												<primitiveExpression value="all"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<argumentReferenceExpression name="scope"/>
												<primitiveExpression value="start"/>
											</binaryOperatorExpression>
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
													<propertyReferenceExpression name="Count">
														<propertyReferenceExpression name="Fields">
															<argumentReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</test>
											<increment>
												<variableReferenceExpression name="i"/>
											</increment>
											<statements>
												<variableDeclarationStatement type="DataField" name="field">
													<init>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Fields">
																	<argumentReferenceExpression name="page"/>
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
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="Not">
																<propertyReferenceExpression name="Hidden">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="IdentityInequality">
																<propertyReferenceExpression name="Type">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
																<primitiveExpression value="DataView"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<variableReferenceExpression name="firstField"/>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="firstField"/>
																	<primitiveExpression value="false"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="Write">
																	<target>
																		<argumentReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression  name="ListSeparator">
																			<typeReferenceExpression type="System.Globalization.CultureInfo.CurrentCulture.TextInfo"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="IsNullOrEmpty">
																		<target>
																			<typeReferenceExpression type="String"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="AliasName">
																				<variableReferenceExpression name="field"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="field"/>
																	<methodInvokeExpression methodName="FindField">
																		<target>
																			<argumentReferenceExpression name="page"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="AliasName">
																				<variableReferenceExpression name="field"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="Write">
															<target>
																<argumentReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="&quot;{{0}}&quot;"/>
																<methodInvokeExpression methodName="Replace">
																	<target>
																		<propertyReferenceExpression name="Label">
																			<variableReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="&quot;"/>
																		<primitiveExpression value="&quot;&quot;"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="NormalizeDataFormatString">
													<target>
														<variableReferenceExpression name="field"/>
													</target>
												</methodInvokeExpression>
											</statements>
										</forStatement>
										<methodInvokeExpression methodName="WriteLine">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>

								<whileStatement>
									<test>
										<methodInvokeExpression methodName="Read">
											<target>
												<argumentReferenceExpression name="reader"/>
											</target>
										</methodInvokeExpression>
									</test>
									<statements>
										<assignStatement>
											<variableReferenceExpression name="firstField"/>
											<primitiveExpression value="true"/>
										</assignStatement>
										<forStatement>
											<variable type="System.Int32" name="j">
												<init>
													<primitiveExpression value="0"/>
												</init>
											</variable>
											<test>
												<binaryOperatorExpression operator="LessThan">
													<variableReferenceExpression name="j"/>
													<propertyReferenceExpression name="Count">
														<propertyReferenceExpression name="Fields">
															<argumentReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</test>
											<increment>
												<variableReferenceExpression name="j"/>
											</increment>
											<statements>
												<variableDeclarationStatement type="DataField" name="field">
													<init>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Fields">
																	<argumentReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<variableReferenceExpression name="j"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="Not">
																<propertyReferenceExpression name="Hidden">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="IdentityInequality">
																<propertyReferenceExpression name="Type">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
																<primitiveExpression value="DataView"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<variableReferenceExpression name="firstField"/>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="firstField"/>
																	<primitiveExpression value="false"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="Write">
																	<target>
																		<argumentReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression  name="ListSeparator">
																			<typeReferenceExpression type="System.Globalization.CultureInfo.CurrentCulture.TextInfo"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="IsNullOrEmpty">
																		<target>
																			<typeReferenceExpression type="String"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="AliasName">
																				<variableReferenceExpression name="field"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="field"/>
																	<methodInvokeExpression methodName="FindField">
																		<target>
																			<argumentReferenceExpression name="page"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="AliasName">
																				<variableReferenceExpression name="field"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<variableDeclarationStatement type="System.String" name="text">
															<init>
																<propertyReferenceExpression name="Empty">
																	<typeReferenceExpression type="String"/>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Object" name="v">
															<init>
																<arrayIndexerExpression>
																	<target>
																		<argumentReferenceExpression name="reader"/>
																	</target>
																	<indices>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
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
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="IsNullOrEmpty">
																				<target>
																					<typeReferenceExpression type="String"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="DataFormatString">
																						<variableReferenceExpression name="field"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="text"/>
																			<methodInvokeExpression methodName="Format">
																				<target>
																					<typeReferenceExpression type="String"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="DataFormatString">
																						<variableReferenceExpression name="field"/>
																					</propertyReferenceExpression>
																					<variableReferenceExpression name="v"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<variableReferenceExpression name="text"/>
																			<methodInvokeExpression methodName="ToString">
																				<target>
																					<typeReferenceExpression type="Convert"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="v"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="Write">
																	<target>
																		<argumentReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="&quot;{{0}}&quot;"/>
																		<methodInvokeExpression methodName="Replace">
																			<target>
																				<variableReferenceExpression name="text"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="&quot;"/>
																				<primitiveExpression value="&quot;&quot;"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="Write">
																	<target>
																		<argumentReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="&quot;&quot;"/>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</forStatement>
										<methodInvokeExpression methodName="WriteLine">
											<target>
												<argumentReferenceExpression name="writer"/>
											</target>
										</methodInvokeExpression>
									</statements>
								</whileStatement>
							</statements>
						</memberMethod>
						<!-- property RowsetTypeMap -->
						<memberField type="SortedDictionary" name="rowsetTypeMap">
							<attributes private="true" static="true"/>
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
						</memberField>
						<memberProperty type="SortedDictionary" name="RowsetTypeMap">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
							<attributes public="true" static="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="rowsetTypeMap"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>

</xsl:stylesheet>
