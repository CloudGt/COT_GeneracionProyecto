<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsPremium"/>
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
				<namespaceImport name="System.Globalization"/>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
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
						<memberField type="System.String" name="viewFilter"/>
						<!-- field BusinessObjectParameters parameters-->
						<memberField type="BusinessObjectParameters" name="parameters"/>
						<!-- method AppendWhereExpressions(StringBuilder, DbCommand, ViewPage, SelectClauseExpression, FieldValue[] -->
						<memberMethod name="AppendWhereExpressions">
							<attributes private="true"/>
							<parameters>
								<parameter type="StringBuilder" name="sb"/>
								<parameter type="DbCommand" name="command"/>
								<parameter type="ViewPage" name="page"/>
								<parameter type="SelectClauseDictionary" name="expressions"/>
								<parameter type="FieldValue[]" name="values"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String[]" name="surrogatePK">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="FieldValue" name="fvo"/>
									<target>
										<argumentReferenceExpression name="values"/>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Name">
														<variableReferenceExpression name="fvo"/>
													</propertyReferenceExpression>
													<primitiveExpression value="_SurrogatePK"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IsTypeOf">
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="fvo"/>
															</propertyReferenceExpression>
															<typeReferenceExpression type="JArray"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="surrogatePK"/>
															<methodInvokeExpression methodName="ToObject">
																<typeArguments>
																	<typeReference type="System.String[]"/>
																</typeArguments>
																<target>
																	<castExpression targetType="JArray">
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="fvo"/>
																		</propertyReferenceExpression>
																	</castExpression>
																</target>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<assignStatement>
															<variableReferenceExpression name="surrogatePK"/>
															<castExpression targetType="System.String[]">
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="fvo"/>
																</propertyReferenceExpression>
															</castExpression>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
												<breakStatement/>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodInvokeExpression methodName="AppendLine">
									<target>
										<argumentReferenceExpression name="sb"/>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Append">
									<target>
										<argumentReferenceExpression name="sb"/>
									</target>
									<parameters>
										<primitiveExpression value="where"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="System.Boolean" name="firstField">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="FieldValue" name="v"/>
									<target>
										<argumentReferenceExpression name="values"/>
									</target>
									<statements>
										<variableDeclarationStatement type="DataField" name="field">
											<init>
												<methodInvokeExpression methodName="FindField">
													<target>
														<argumentReferenceExpression name="page"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Name">
															<variableReferenceExpression name="v"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="field"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="BooleanOr">
														<binaryOperatorExpression operator="BooleanAnd">
															<propertyReferenceExpression name="IsPrimaryKey">
																<variableReferenceExpression name="field"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="IdentityEquality">
																<variableReferenceExpression name="surrogatePK"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="IdentityInequality">
																<variableReferenceExpression name="surrogatePK"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
															<methodInvokeExpression methodName="Contains">
																<target>
																	<variableReferenceExpression name="surrogatePK"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="v"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="AppendLine">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
												</methodInvokeExpression>
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
														<methodInvokeExpression methodName="Append">
															<target>
																<variableReferenceExpression name="sb"/>
															</target>
															<parameters>
																<primitiveExpression value="and "/>
															</parameters>
														</methodInvokeExpression>
													</falseStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="AppendFormat">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="RemoveTableAliasFromExpression">
															<parameters>
																<arrayIndexerExpression>
																	<target>
																		<argumentReferenceExpression name="expressions"/>
																	</target>
																	<indices>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="v"/>
																		</propertyReferenceExpression>
																	</indices>
																</arrayIndexerExpression>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="AppendFormat">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<primitiveExpression value="={{0}}p{{1}}"/>
														<fieldReferenceExpression name="parameterMarker"/>
														<propertyReferenceExpression name="Count">
															<propertyReferenceExpression name="Parameters">
																<variableReferenceExpression name="command"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement type="DbParameter" name="parameter">
													<init>
														<methodInvokeExpression methodName="CreateParameter">
															<target>
																<argumentReferenceExpression name="command"/>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<assignStatement>
													<propertyReferenceExpression name="ParameterName">
														<variableReferenceExpression name="parameter"/>
													</propertyReferenceExpression>
													<stringFormatExpression format="{{0}}p{{1}}">
														<fieldReferenceExpression name="parameterMarker"/>
														<propertyReferenceExpression name="Count">
															<propertyReferenceExpression name="Parameters">
																<variableReferenceExpression name="command"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</stringFormatExpression>
													<!--<methodInvokeExpression methodName="Format">
                            <target>
                              <typeReferenceExpression type="String"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="{{0}}p{{1}}"/>
                              <fieldReferenceExpression name="parameterMarker"/>
                              <propertyReferenceExpression name="Count">
                                <propertyReferenceExpression name="Parameters">
                                  <variableReferenceExpression name="command"/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>-->
												</assignStatement>
												<methodInvokeExpression methodName="AssignParameterValue">
													<parameters>
														<variableReferenceExpression name="parameter"/>
														<propertyReferenceExpression name="Type">
															<variableReferenceExpression name="field"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="OldValue">
															<variableReferenceExpression name="v"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Add">
													<target>
														<propertyReferenceExpression name="Parameters">
															<argumentReferenceExpression name="command"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="parameter"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<propertyReferenceExpression name="ConflictDetectionEnabled">
												<fieldReferenceExpression name="config"/>
											</propertyReferenceExpression>
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="surrogatePK"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="FieldValue" name="v"/>
											<target>
												<argumentReferenceExpression name="values"/>
											</target>
											<statements>
												<variableDeclarationStatement type="DataField" name="field">
													<init>
														<methodInvokeExpression methodName="FindField">
															<target>
																<argumentReferenceExpression name="page"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="v"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="IdentityInequality">
																<variableReferenceExpression name="field"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanAnd">
																<unaryOperatorExpression operator="Not">
																	<binaryOperatorExpression operator="BooleanOr">
																		<propertyReferenceExpression name="IsPrimaryKey">
																			<variableReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="OnDemand">
																			<variableReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																	</binaryOperatorExpression>
																</unaryOperatorExpression>
																<unaryOperatorExpression operator="Not">
																	<propertyReferenceExpression name="ReadOnly">
																		<variableReferenceExpression name="v"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="AppendLine">
															<target>
																<variableReferenceExpression name="sb"/>
															</target>
														</methodInvokeExpression>
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
																<methodInvokeExpression methodName="Append">
																	<target>
																		<variableReferenceExpression name="sb"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="and "/>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="Append">
															<target>
																<variableReferenceExpression name="sb"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="RemoveTableAliasFromExpression">
																	<parameters>
																		<arrayIndexerExpression>
																			L<target>
																				<argumentReferenceExpression name="expressions"/>
																			</target>
																			<indices>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="v"/>
																				</propertyReferenceExpression>
																			</indices>
																		</arrayIndexerExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityEquality">
																	<propertyReferenceExpression name="OldValue">
																		<variableReferenceExpression name="v"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Append">
																	<target>
																		<variableReferenceExpression name="sb"/>
																	</target>
																	<parameters>
																		<primitiveExpression value=" is null"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="AppendFormat">
																	<target>
																		<variableReferenceExpression name="sb"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="={{0}}p{{1}}"/>
																		<fieldReferenceExpression name="parameterMarker"/>
																		<propertyReferenceExpression name="Count">
																			<propertyReferenceExpression name="Parameters">
																				<argumentReferenceExpression name="command"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
																<variableDeclarationStatement type="DbParameter" name="parameter">
																	<init>
																		<methodInvokeExpression methodName="CreateParameter">
																			<target>
																				<argumentReferenceExpression name="command"/>
																			</target>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<assignStatement>
																	<propertyReferenceExpression name="ParameterName">
																		<variableReferenceExpression name="parameter"/>
																	</propertyReferenceExpression>
																	<stringFormatExpression format="{{0}}p{{1}}">
																		<fieldReferenceExpression name="parameterMarker"/>
																		<propertyReferenceExpression name="Count">
																			<propertyReferenceExpression name="Parameters">
																				<argumentReferenceExpression name="command"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</stringFormatExpression>
																	<!--<methodInvokeExpression methodName="Format">
                                    <target>
                                      <typeReferenceExpression type="String"/>
                                    </target>
                                    <parameters>
                                      <primitiveExpression value="{{0}}p{{1}}"/>
                                      <fieldReferenceExpression name="parameterMarker"/>
                                      <propertyReferenceExpression name="Count">
                                        <propertyReferenceExpression name="Parameters">
                                          <argumentReferenceExpression name="command"/>
                                        </propertyReferenceExpression>
                                      </propertyReferenceExpression>
                                    </parameters>
                                  </methodInvokeExpression>-->
																</assignStatement>
																<methodInvokeExpression methodName="AssignParameterValue">
																	<parameters>
																		<variableReferenceExpression name="parameter"/>
																		<propertyReferenceExpression name="Type">
																			<variableReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="OldValue">
																			<variableReferenceExpression name="v"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<propertyReferenceExpression name="Parameters">
																			<argumentReferenceExpression name="command"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="parameter"/>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="AppendLine">
									<target>
										<variableReferenceExpression name="sb"/>
									</target>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method EnsureWhereKeyword(StringBuilder) -->
						<memberField type="System.Boolean" name="hasWhere"/>
						<memberMethod name="EnsureWhereKeyword">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="StringBuilder" name="sb"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<fieldReferenceExpression name="hasWhere"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="hasWhere"/>
											<primitiveExpression value="true"/>
										</assignStatement>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<argumentReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value="where"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method FilterIsApplicable(ViewPage) -->
						<!--<memberMethod returnType="System.Boolean" name="FilterIsApplicable">
              <attributes private ="true"/>
              <parameters>
                <parameter type="ViewPage" name="page"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanOr">
                      <binaryOperatorExpression operator="IdentityEquality">
                        <propertyReferenceExpression name="Filter">
                          <argumentReferenceExpression name="page"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                      <binaryOperatorExpression operator="ValueEquality">
                        <propertyReferenceExpression name="Length">
                          <propertyReferenceExpression name="Filter">
                            <argumentReferenceExpression name="page"/>
                          </propertyReferenceExpression>
                        </propertyReferenceExpression>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <primitiveExpression value="false"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <foreachStatement>
                  <variable type="System.String" name="expression"/>
                  <target>
                    <propertyReferenceExpression name="Filter">
                      <argumentReferenceExpression name="page"/>
                    </propertyReferenceExpression>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="Match" name="m">
                      <init>
                        <methodInvokeExpression methodName="Match">
                          <target>
                            <typeReferenceExpression type="Regex"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="expression"/>
                            <primitiveExpression value="(\w+):"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>

                        <binaryOperatorExpression operator="BooleanAnd">
                          <propertyReferenceExpression name="Success">
                            <variableReferenceExpression name="m"/>
                          </propertyReferenceExpression>

                          <methodInvokeExpression methodName="ContainsField">
                            <target>
                              <argumentReferenceExpression name="page"/>
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
                            </parameters>
                          </methodInvokeExpression>

                          -->
						<!--<binaryOperatorExpression operator="IdentityInequality">
                            <methodInvokeExpression methodName="FindField">
                              <target>
                                <argumentReferenceExpression name="page"/>
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
                              </parameters>
                            </methodInvokeExpression>
                            <primitiveExpression value="null"/>
                          </binaryOperatorExpression>-->
						<!--
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <primitiveExpression value="true"/>
                        </methodReturnStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodReturnStatement>
                      <primitiveExpression value="false"/>
                    </methodReturnStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <primitiveExpression value="false"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>-->
						<!-- method ProcessViewFilter(VierPage, DbCommand, SelectClauseDictionary-->
						<memberField type="DbCommand" name="currentCommand"/>
						<memberField type="SelectClauseDictionary" name="currentExpressions"/>
						<memberMethod returnType="System.String" name="ProcessViewFilter">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
								<parameter type="DbCommand" name="command"/>
								<parameter type="SelectClauseDictionary" name="expressions"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="currentCommand"/>
									<argumentReferenceExpression name="command"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="currentExpressions"/>
									<argumentReferenceExpression name="expressions"/>
								</assignStatement>
								<variableDeclarationStatement type="System.String" name="filter">
									<init>
										<methodInvokeExpression methodName="Replace">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<fieldReferenceExpression name="viewFilter"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[/\*Sql\*/(?'Sql'[\s\S]+)/\*Sql\*/|(?'Parameter'(@|:)\w+)|(?'Other'("|'|\[|`)\s*\w+)|(?'Function'\$\w+\s*\((?'Arguments'[\S\s]*?)\))|(?'Name'\w+)]]></xsl:attribute>
												</primitiveExpression>
												<addressOfExpression>
													<methodReferenceExpression methodName="DoReplaceKnownNames"/>
												</addressOfExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="filter"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- string DoReplaceKnownNames(Match) -->
						<memberMethod returnType="System.String" name="DoReplaceKnownNames">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="sql">
									<init>
										<propertyReferenceExpression name="Value">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Groups">
														<argumentReferenceExpression name="m"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="Sql"/>
												</indices>
											</arrayIndexerExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="sql"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<variableReferenceExpression name="sql"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="IsNullOrEmpty">
												<target>
													<typeReferenceExpression type="String"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Value">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<argumentReferenceExpression name="m"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Other"/>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Value">
												<argumentReferenceExpression name="m"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="IsNullOrEmpty">
												<target>
													<typeReferenceExpression type="String"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Value">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<argumentReferenceExpression name="m"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Parameter"/>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="AssignFilterParameterValue">
												<parameters>
													<propertyReferenceExpression name="Value">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<argumentReferenceExpression name="m"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Parameter"/>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="IsNullOrEmpty">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Value">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Groups">
																			<argumentReferenceExpression name="m"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="Function"/>
																	</indices>
																</arrayIndexerExpression>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<methodInvokeExpression methodName="Replace">
														<target>
															<typeReferenceExpression type="FilterFunctions"/>
														</target>
														<parameters>
															<fieldReferenceExpression name="currentCommand"/>
															<fieldReferenceExpression name="currentExpressions"/>
															<propertyReferenceExpression name="Value">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Groups">
																			<argumentReferenceExpression name="m"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="Function"/>
																	</indices>
																</arrayIndexerExpression>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</methodReturnStatement>
											</trueStatements>
											<falseStatements>
												<variableDeclarationStatement type="System.String" name="s">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="TryGetValue">
															<target>
																<fieldReferenceExpression name="currentExpressions"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<argumentReferenceExpression name="m"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Name"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
																<directionExpression direction="Out">
																	<variableReferenceExpression name="s"/>
																</directionExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<variableReferenceExpression name="s"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<propertyReferenceExpression name="Value">
										<argumentReferenceExpression name="m"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AssignFilterParameterValue(string) -->
						<memberMethod returnType="System.String" name="AssignFilterParameterValue">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="qualifiedName"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Char" name="prefix">
									<init>
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="qualifiedName"/>
											</target>
											<indices>
												<primitiveExpression value="0"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="name">
									<init>
										<methodInvokeExpression methodName="Substring">
											<target>
												<variableReferenceExpression name="qualifiedName"/>
											</target>
											<parameters>
												<primitiveExpression value="1"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="BooleanOr">
												<methodInvokeExpression methodName="Equals">
													<target>
														<variableReferenceExpression name="prefix"/>
													</target>
													<parameters>
														<primitiveExpression value="@" convertTo="Char"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Equals">
													<target>
														<variableReferenceExpression name="prefix"/>
													</target>
													<parameters>
														<primitiveExpression value=":" convertTo="Char"/>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="Contains">
													<target>
														<propertyReferenceExpression name="Parameters">
															<fieldReferenceExpression name="currentCommand"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<argumentReferenceExpression name="qualifiedName"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.Object" name="result">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<fieldReferenceExpression name="parameters"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<methodInvokeExpression methodName="ContainsKey">
														<target>
															<fieldReferenceExpression name="parameters"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="qualifiedName"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="result"/>
													<arrayIndexerExpression>
														<target>
															<fieldReferenceExpression name="parameters"/>
														</target>
														<indices>
															<variableReferenceExpression name="qualifiedName"/>
														</indices>
													</arrayIndexerExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<!--<variableDeclarationStatement type="IActionHandler" name="handler">
                          <init>
                            <methodInvokeExpression methodName="CreateActionHandler">
                              <target>
                                <fieldReferenceExpression name="config"/>
                              </target>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>-->
												<variableDeclarationStatement type="BusinessRules" name="rules">
													<init>
														<fieldReferenceExpression name="serverRules"/>
														<!--<methodInvokeExpression methodName="CreateBusinessRules">
                              <target>
                                <fieldReferenceExpression name="config"/>
                              </target>
                            </methodInvokeExpression>-->
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="rules"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="rules"/>
															<methodInvokeExpression methodName="CreateBusinessRules"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="result"/>
													<methodInvokeExpression  methodName="GetProperty">
														<target>
															<variableReferenceExpression name="rules"/>
														</target>
														<parameters>
															<variableReferenceExpression name="name"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<!--<conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="IdentityEquality">
                              <variableReferenceExpression name="handler"/>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <throwExceptionStatement>
                              <objectCreateExpression type="Exception">
                                <parameters>
                                  <stringFormatExpression>
                                    <xsl:attribute name="format"><![CDATA[View '{0}' uses a filter with '{2}' parameter. Business rules class of the controller must provide a value for this parameter. The filter is defined as {1}.]]></xsl:attribute>
                                    <fieldReferenceExpression name="viewId"/>
                                    <fieldReferenceExpression name="viewFilter"/>
                                    <variableReferenceExpression name="name"/>
                                  </stringFormatExpression>
                                </parameters>
                              </objectCreateExpression>
                            </throwExceptionStatement>
                          </trueStatements>
                        </conditionStatement>
                        <assignStatement>
                          <variableReferenceExpression name="result"/>
                          <methodInvokeExpression methodName="InvokeMember">
                            <target>
                              <methodInvokeExpression methodName="GetType">
                                <target>
                                  <variableReferenceExpression name="handler"/>
                                </target>
                              </methodInvokeExpression>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="name"/>
                              <binaryOperatorExpression operator="BitwiseOr">
                                <propertyReferenceExpression name="GetProperty">
                                  <typeReferenceExpression type="System.Reflection.BindingFlags"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="GetField">
                                  <typeReferenceExpression type="System.Reflection.BindingFlags"/>
                                </propertyReferenceExpression>
                              </binaryOperatorExpression>
                              <primitiveExpression value="null"/>
                              <variableReferenceExpression name="handler"/>
                              <arrayCreateExpression>
                                <createType type="System.Object"/>
                              </arrayCreateExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>-->
											</falseStatements>
										</conditionStatement>
										<variableDeclarationStatement type="IEnumerable" name="enumerable">
											<typeArguments>
												<typeReference type="System.Object"/>
											</typeArguments>
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression  methodName="IsInstanceOfType">
													<target>
														<typeofExpression type="IEnumerable">
															<typeArguments>
																<typeReference type="System.Object"/>
															</typeArguments>
														</typeofExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="result"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="enumerable"/>
													<castExpression targetType="IEnumerable">
														<typeArguments>
															<typeReference type="System.Object"/>
														</typeArguments>
														<variableReferenceExpression name="result"/>
													</castExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
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
												<methodInvokeExpression methodName="Append">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<primitiveExpression value="("/>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement type="System.Int32" name="parameterIndex">
													<init>
														<primitiveExpression value="0"/>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable type="System.Object" name="o"/>
													<target>
														<variableReferenceExpression name="enumerable"/>
													</target>
													<statements>
														<variableDeclarationStatement type="DbParameter" name="p">
															<init>
																<methodInvokeExpression methodName="CreateParameter">
																	<target>
																		<fieldReferenceExpression name="currentCommand"/>
																	</target>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<propertyReferenceExpression name="Parameters">
																	<fieldReferenceExpression name="currentCommand"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="p"/>
															</parameters>
														</methodInvokeExpression>
														<assignStatement>
															<propertyReferenceExpression name="ParameterName">
																<variableReferenceExpression name="p"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="qualifiedName"/>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<variableReferenceExpression name="parameterIndex"/>
																	</target>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="p"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="o"/>
														</assignStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="GreaterThan">
																	<variableReferenceExpression name="parameterIndex"/>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Append">
																	<target>
																		<variableReferenceExpression name="sb"/>
																	</target>
																	<parameters>
																		<primitiveExpression value=","/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="Append">
															<target>
																<variableReferenceExpression name="sb"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="ParameterName">
																	<variableReferenceExpression name="p"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<assignStatement>
															<variableReferenceExpression name="parameterIndex"/>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="parameterIndex"/>
																<primitiveExpression value="1"/>
															</binaryOperatorExpression>
														</assignStatement>
													</statements>
												</foreachStatement>
												<methodInvokeExpression methodName="Append">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<primitiveExpression value=")"/>
													</parameters>
												</methodInvokeExpression>
												<methodReturnStatement>
													<methodInvokeExpression methodName="ToString">
														<target>
															<variableReferenceExpression name="sb"/>
														</target>
													</methodInvokeExpression>
												</methodReturnStatement>
											</trueStatements>
											<falseStatements>
												<variableDeclarationStatement type="DbParameter" name="p">
													<init>
														<methodInvokeExpression methodName="CreateParameter">
															<target>
																<fieldReferenceExpression name="currentCommand"/>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<propertyReferenceExpression name="Parameters">
															<fieldReferenceExpression name="currentCommand"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="p"/>
													</parameters>
												</methodInvokeExpression>
												<assignStatement>
													<propertyReferenceExpression name="ParameterName">
														<variableReferenceExpression name="p"/>
													</propertyReferenceExpression>
													<variableReferenceExpression name="qualifiedName"/>
												</assignStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="result"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="result"/>
															<propertyReferenceExpression name="Value">
																<typeReferenceExpression type="DBNull"/>
															</propertyReferenceExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<assignStatement>
													<propertyReferenceExpression name="Value">
														<variableReferenceExpression name="p"/>
													</propertyReferenceExpression>
													<variableReferenceExpression name="result"/>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="qualifiedName"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property FilterExpressionRegex -->
						<memberField type="Regex" name="FilterExpressionRegex">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression value="(?'Alias'[\w\,\.]+):(?'Values'[\s\S]*)"/>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- property MatchinModeRegex -->
						<memberField type="Regex" name="MatchingModeRegex">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression>
											<xsl:attribute name="value"><![CDATA[^(?'Match'_match_|_donotmatch_)\:(?'Scope'\$all\$|\$any\$)$]]></xsl:attribute>
										</primitiveExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- property FilterValueRegex -->
						<memberField type="Regex" name="FilterValueRegex">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression>
											<xsl:attribute name="value"><![CDATA[(?'Operation'\*|\$\w+\$|=|~|<(=|>){0,1}|>={0,1})(?'Value'[\s\S]*?)(\0|$)]]></xsl:attribute>
										</primitiveExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- method AppendFilterExpressionsToWhere(StringBuilder, ViewPage, DbCommand, SelectClauseDictionary, string) -->
						<memberMethod name="AppendFilterExpressionsToWhere">
							<attributes family="true"/>
							<parameters>
								<parameter type="StringBuilder" name="sb"/>
								<parameter type="ViewPage" name="page"/>
								<parameter type="DbCommand" name="command"/>
								<parameter type="SelectClauseDictionary" name="expressions"/>
								<parameter type="System.String" name="whereClause"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="TrackAliases">
										<argumentReferenceExpression name="expressions"/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<variableDeclarationStatement type="System.String" name="quickFindHint">
									<init>
										<propertyReferenceExpression name="QuickFindHint">
											<argumentReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Boolean" name="firstCriteria">
									<init>
										<methodInvokeExpression methodName="IsNullOrEmpty">
											<target>
												<typeReferenceExpression type="String"/>
											</target>
											<parameters>
												<fieldReferenceExpression name="viewFilter"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<variableReferenceExpression name="firstCriteria"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="EnsureWhereKeyword">
											<parameters>
												<argumentReferenceExpression name="sb"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<argumentReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value="("/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Append">
											<target>
												<argumentReferenceExpression name="sb"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="ProcessViewFilter">
													<parameters>
														<argumentReferenceExpression name="page"/>
														<argumentReferenceExpression name="command"/>
														<argumentReferenceExpression name="expressions"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.Int32" name="matchListCount">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Boolean" name="firstDoNotMatch">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="logicalConcat">
									<init>
										<primitiveExpression value="and "/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Boolean" name="useExclusiveQuickFind">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="DataField" name="f"/>
									<target>
										<propertyReferenceExpression name="Fields">
											<variableReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<propertyReferenceExpression name="SearchOptions">
															<variableReferenceExpression name="f"/>
														</propertyReferenceExpression>
													</unaryOperatorExpression>
													<methodInvokeExpression methodName="IsMatch">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="SearchOptions">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
															<primitiveExpression value="\$quickfind(?!disabled)"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="useExclusiveQuickFind"/>
													<primitiveExpression value="true"/>
												</assignStatement>
												<breakStatement/>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Filter">
												<variableReferenceExpression name="page"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="System.String" name="filterExpression"/>
											<target>
												<propertyReferenceExpression name="Filter">
													<argumentReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<variableDeclarationStatement type="Match" name="matchingMode">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<propertyReferenceExpression name="MatchingModeRegex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="filterExpression"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="Success">
															<variableReferenceExpression name="matchingMode"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.Boolean" name="doNotMatch">
															<init>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Value">
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups">
																					<variableReferenceExpression name="matchingMode"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="Match"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																	<primitiveExpression value="_donotmatch_"/>
																</binaryOperatorExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<variableReferenceExpression name="doNotMatch"/>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<variableReferenceExpression name="firstDoNotMatch"/>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="firstDoNotMatch"/>
																			<primitiveExpression value="false"/>
																		</assignStatement>
																		<methodInvokeExpression methodName="EnsureWhereKeyword">
																			<parameters>
																				<argumentReferenceExpression name="sb"/>
																			</parameters>
																		</methodInvokeExpression>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<variableReferenceExpression name="firstCriteria"/>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="AppendLine">
																					<target>
																						<argumentReferenceExpression name="sb"/>
																					</target>
																					<parameters>
																						<primitiveExpression value=")"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="GreaterThan">
																					<variableReferenceExpression name="matchListCount"/>
																					<primitiveExpression value="0"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="AppendLine">
																					<target>
																						<argumentReferenceExpression name="sb"/>
																					</target>
																					<parameters>
																						<primitiveExpression value=")"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanOr">
																					<unaryOperatorExpression operator="Not">
																						<variableReferenceExpression name="firstCriteria"/>
																					</unaryOperatorExpression>
																					<binaryOperatorExpression operator="GreaterThan">
																						<variableReferenceExpression name="matchListCount"/>
																						<primitiveExpression value="0"/>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="AppendLine">
																					<target>
																						<argumentReferenceExpression name="sb"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="and"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<variableReferenceExpression name="matchListCount"/>
																			<primitiveExpression value="0"/>
																		</assignStatement>
																		<methodInvokeExpression methodName="AppendLine">
																			<target>
																				<argumentReferenceExpression name="sb"/>
																			</target>
																			<parameters>
																				<primitiveExpression value=" not"/>
																			</parameters>
																		</methodInvokeExpression>
																		<assignStatement>
																			<variableReferenceExpression name="firstCriteria"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="matchListCount"/>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="EnsureWhereKeyword">
																	<parameters>
																		<argumentReferenceExpression name="sb"/>
																	</parameters>
																</methodInvokeExpression>
																<!--<methodInvokeExpression methodName="AppendLine">
                                  <target>
                                    <argumentReferenceExpression name="sb"/>
                                  </target>
                                </methodInvokeExpression>-->
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<variableReferenceExpression name="firstCriteria"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Append">
																			<target>
																				<argumentReferenceExpression name="sb"/>
																			</target>
																			<parameters>
																				<primitiveExpression value=") and"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<comment>the list of matches begins</comment>
																<methodInvokeExpression methodName="AppendLine">
																	<target>
																		<argumentReferenceExpression name="sb"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="("/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<!--<methodInvokeExpression methodName="AppendLine">
                                  <target>
                                    <argumentReferenceExpression name="sb"/>
                                  </target>
                                </methodInvokeExpression>-->
																<methodInvokeExpression methodName="AppendLine">
																	<target>
																		<argumentReferenceExpression name="sb"/>
																	</target>
																	<parameters>
																		<primitiveExpression value=")"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="AppendLine">
																	<target>
																		<argumentReferenceExpression name="sb"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="or"/>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
														<comment>begin a list of conditions for the next match</comment>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Value">
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups">
																					<variableReferenceExpression name="matchingMode"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="Scope"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																	<primitiveExpression value="$all$"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="logicalConcat"/>
																	<primitiveExpression value=" and "/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<assignStatement>
																	<variableReferenceExpression name="logicalConcat"/>
																	<primitiveExpression value=" or "/>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
														<assignStatement>
															<variableReferenceExpression name="matchListCount"/>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="matchListCount"/>
																<primitiveExpression value="1"/>
															</binaryOperatorExpression>
														</assignStatement>
														<assignStatement>
															<variableReferenceExpression name="firstCriteria"/>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement type="Match" name="filterMatch">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<propertyReferenceExpression name="FilterExpressionRegex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="filterExpression"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="Success">
															<variableReferenceExpression name="filterMatch"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<comment>"ProductName:?g", "CategoryCategoryName:=Condiments\x00=Seafood"</comment>
														<variableDeclarationStatement type="System.Boolean" name="firstValue">
															<init>
																<primitiveExpression value="true"/>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="fieldOperator">
															<init>
																<primitiveExpression value=" or "/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="IsMatch">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="filterMatch"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="Values"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																		<primitiveExpression value=">|&lt;"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="fieldOperator"/>
																	<primitiveExpression value=" and "/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<variableDeclarationStatement type="Match" name="valueMatch">
															<init>
																<methodInvokeExpression methodName="Match">
																	<target>
																		<propertyReferenceExpression name="FilterValueRegex"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="filterMatch"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="Values"/>
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
																	<variableReferenceExpression name="valueMatch"/>
																</propertyReferenceExpression>
															</test>
															<statements>
																<variableDeclarationStatement type="System.String" name="fieldAlias">
																	<init>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="filterMatch"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="Alias"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="System.String" name="operation">
																	<init>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="valueMatch"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="Operation"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="System.String" name="paramValue">
																	<init>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="valueMatch"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="Value"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<binaryOperatorExpression operator="ValueEquality">
																				<variableReferenceExpression name="operation"/>
																				<primitiveExpression value="~"/>
																			</binaryOperatorExpression>
																			<binaryOperatorExpression operator="ValueEquality">
																				<variableReferenceExpression name="fieldAlias"/>
																				<primitiveExpression value="_quickfind_"/>
																			</binaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="fieldAlias"/>
																			<propertyReferenceExpression name="Name">
																				<arrayIndexerExpression>
																					<target>
																						<propertyReferenceExpression name="Fields">
																							<argumentReferenceExpression name="page"/>
																						</propertyReferenceExpression>
																					</target>
																					<indices>
																						<primitiveExpression value="0"/>
																					</indices>
																				</arrayIndexerExpression>
																			</propertyReferenceExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<variableDeclarationStatement type="System.Boolean" name="deepSearching">
																	<init>
																		<methodInvokeExpression methodName="Contains">
																			<target>
																				<variableReferenceExpression name="fieldAlias"/>
																			</target>
																			<parameters>
																				<primitiveExpression value=","/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="DataField" name="field">
																	<init>
																		<methodInvokeExpression methodName="FindField">
																			<target>
																				<argumentReferenceExpression name="page"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="fieldAlias"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<binaryOperatorExpression operator="IdentityEquality">
																				<variableReferenceExpression name="field"/>
																				<primitiveExpression value="null"/>
																			</binaryOperatorExpression>
																			<unaryOperatorExpression operator="Not">
																				<methodInvokeExpression methodName="StartsWith">
																					<target>
																						<variableReferenceExpression name="fieldAlias"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="_"/>
																					</parameters>
																				</methodInvokeExpression>
																			</unaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement name="fieldNav">
																			<init>
																				<methodInvokeExpression methodName="SelectSingleNode">
																					<target>
																						<propertyReferenceExpression name="Config"/>
																					</target>
																					<parameters>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[/c:dataController/c:fields/c:field[@name='{0}']]]></xsl:attribute>
																						</primitiveExpression>
																						<variableReferenceExpression name="fieldAlias"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityInequality">
																					<variableReferenceExpression name="fieldNav"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="field"/>
																					<objectCreateExpression type="DataField">
																						<parameters>
																							<variableReferenceExpression name="fieldNav"/>
																							<propertyReferenceExpression name="Resolver">
																								<propertyReferenceExpression name="Config"/>
																							</propertyReferenceExpression>
																						</parameters>
																					</objectCreateExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanOr">
																			<binaryOperatorExpression operator="BooleanAnd">
																				<binaryOperatorExpression operator="BooleanOr">
																					<binaryOperatorExpression operator="BooleanAnd" >
																						<binaryOperatorExpression operator="IdentityInequality">
																							<variableReferenceExpression name="field"/>
																							<primitiveExpression value="null"/>
																						</binaryOperatorExpression>
																						<propertyReferenceExpression name="AllowQBE">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																					</binaryOperatorExpression>
																					<binaryOperatorExpression operator="ValueEquality">
																						<variableReferenceExpression name="operation"/>
																						<primitiveExpression value="~"/>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																				<binaryOperatorExpression operator="BooleanOr">
																					<binaryOperatorExpression operator="BooleanOr">
																						<binaryOperatorExpression operator="BooleanOr">
																							<binaryOperatorExpression operator="ValueInequality">
																								<propertyReferenceExpression name="DistinctValueFieldName">
																									<argumentReferenceExpression name="page"/>
																								</propertyReferenceExpression>
																								<propertyReferenceExpression name="Name">
																									<variableReferenceExpression name="field"/>
																								</propertyReferenceExpression>
																							</binaryOperatorExpression>
																							<binaryOperatorExpression operator="GreaterThan">
																								<variableReferenceExpression name="matchListCount"/>
																								<primitiveExpression value="0"/>
																							</binaryOperatorExpression>
																						</binaryOperatorExpression>
																						<binaryOperatorExpression operator="ValueEquality">
																							<variableReferenceExpression name="operation"/>
																							<primitiveExpression value="~"/>
																						</binaryOperatorExpression>
																					</binaryOperatorExpression>
																					<binaryOperatorExpression operator="BooleanOr">
																						<propertyReferenceExpression name="AllowDistinctFieldInFilter">
																							<argumentReferenceExpression name="page"/>
																						</propertyReferenceExpression>
																						<methodInvokeExpression methodName="CustomFilteredBy">
																							<target>
																								<argumentReferenceExpression name="page"/>
																							</target>
																							<parameters>
																								<propertyReferenceExpression name="Name">
																									<variableReferenceExpression name="field"/>
																								</propertyReferenceExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</binaryOperatorExpression>
																			<variableReferenceExpression name="deepSearching"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<variableReferenceExpression name="firstValue"/>
																			</condition>
																			<trueStatements>
																				<conditionStatement>
																					<condition>
																						<variableReferenceExpression name="firstCriteria"/>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="EnsureWhereKeyword">
																							<parameters>
																								<argumentReferenceExpression name="sb"/>
																							</parameters>
																						</methodInvokeExpression>
																						<methodInvokeExpression methodName="AppendLine">
																							<target>
																								<argumentReferenceExpression name="sb"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="("/>
																							</parameters>
																						</methodInvokeExpression>
																						<assignStatement>
																							<variableReferenceExpression name="firstCriteria"/>
																							<primitiveExpression value="false"/>
																						</assignStatement>
																					</trueStatements>
																					<falseStatements>
																						<methodInvokeExpression methodName="Append">
																							<target>
																								<argumentReferenceExpression name="sb"/>
																							</target>
																							<parameters>
																								<!--<primitiveExpression value="and "/>-->
																								<variableReferenceExpression name="logicalConcat"/>
																							</parameters>
																						</methodInvokeExpression>
																					</falseStatements>
																				</conditionStatement>
																				<methodInvokeExpression methodName="Append">
																					<target>
																						<argumentReferenceExpression name="sb"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="("/>
																					</parameters>
																				</methodInvokeExpression>
																				<assignStatement>
																					<variableReferenceExpression name="firstValue"/>
																					<primitiveExpression value="false"/>
																				</assignStatement>
																			</trueStatements>
																			<falseStatements>
																				<methodInvokeExpression methodName="Append">
																					<target>
																						<argumentReferenceExpression name="sb"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="fieldOperator"/>
																					</parameters>
																				</methodInvokeExpression>
																			</falseStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<variableReferenceExpression name="deepSearching"/>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement type="System.String" name="deepSearchFieldName">
																					<init>
																						<methodInvokeExpression methodName="Substring">
																							<target>
																								<variableReferenceExpression name="fieldAlias"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="0"/>
																								<methodInvokeExpression methodName="IndexOf">
																									<target>
																										<variableReferenceExpression name="fieldAlias"/>
																									</target>
																									<parameters>
																										<primitiveExpression value="," convertTo="Char"/>
																									</parameters>
																								</methodInvokeExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<variableDeclarationStatement type="System.String" name="hint">
																					<init>
																						<methodInvokeExpression methodName="Substring">
																							<target>
																								<variableReferenceExpression name="fieldAlias"/>
																							</target>
																							<parameters>
																								<binaryOperatorExpression operator="Add">
																									<propertyReferenceExpression name="Length">
																										<variableReferenceExpression name="deepSearchFieldName"/>
																									</propertyReferenceExpression>
																									<primitiveExpression value="1"/>
																								</binaryOperatorExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<variableDeclarationStatement type="System.String" name="deepFilterExpression">
																					<init>
																						<binaryOperatorExpression operator="Add">
																							<variableReferenceExpression name="deepSearchFieldName"/>
																							<methodInvokeExpression methodName="Substring">
																								<target>
																									<variableReferenceExpression name="filterExpression"/>
																								</target>
																								<parameters>
																									<methodInvokeExpression methodName="IndexOf">
																										<target>
																											<variableReferenceExpression name="filterExpression"/>
																										</target>
																										<parameters>
																											<primitiveExpression value=":" convertTo="Char"/>
																										</parameters>
																									</methodInvokeExpression>
																								</parameters>
																							</methodInvokeExpression>
																						</binaryOperatorExpression>
																					</init>
																				</variableDeclarationStatement>
																				<methodInvokeExpression methodName="AppendDeepFilter">
																					<parameters>
																						<variableReferenceExpression name="hint"/>
																						<argumentReferenceExpression name="page"/>
																						<argumentReferenceExpression name="command"/>
																						<argumentReferenceExpression name="sb"/>
																						<variableReferenceExpression name="deepFilterExpression"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																			<falseStatements>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="ValueEquality">
																							<variableReferenceExpression name="operation"/>
																							<primitiveExpression value="~"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="paramValue"/>
																							<convertExpression to="String">
																								<methodInvokeExpression methodName="StringToValue">
																									<parameters>
																										<variableReferenceExpression name="paramValue"/>
																									</parameters>
																								</methodInvokeExpression>
																							</convertExpression>
																						</assignStatement>
																						<variableDeclarationStatement type="List" name="words">
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
																						<variableDeclarationStatement type="List" name="phrases">
																							<typeArguments>
																								<typeReference type="List">
																									<typeArguments>
																										<typeReference type="System.String"/>
																									</typeArguments>
																								</typeReference>
																							</typeArguments>
																							<init>
																								<objectCreateExpression type="List">
																									<typeArguments>
																										<typeReference type="List">
																											<typeArguments>
																												<typeReference type="System.String"/>
																											</typeArguments>
																										</typeReference>
																									</typeArguments>
																								</objectCreateExpression>
																							</init>
																						</variableDeclarationStatement>
																						<methodInvokeExpression methodName="Add">
																							<target>
																								<variableReferenceExpression name="phrases"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="words"/>
																							</parameters>
																						</methodInvokeExpression>
																						<variableDeclarationStatement type="CultureInfo" name="currentCulture">
																							<init>
																								<propertyReferenceExpression name="CurrentCulture">
																									<typeReferenceExpression type="CultureInfo"/>
																								</propertyReferenceExpression>
																							</init>
																						</variableDeclarationStatement>
																						<variableDeclarationStatement type="System.String" name="textDateNumber">
																							<init>
																								<binaryOperatorExpression operator="Add">
																									<primitiveExpression value="\p{{L}}\d"/>
																									<methodInvokeExpression methodName="Escape">
																										<target>
																											<typeReferenceExpression type="Regex"/>
																										</target>
																										<parameters>
																											<binaryOperatorExpression operator="Add">
																												<propertyReferenceExpression name="DateSeparator">
																													<propertyReferenceExpression name="DateTimeFormat">
																														<variableReferenceExpression name="currentCulture"/>
																													</propertyReferenceExpression>
																												</propertyReferenceExpression>
																												<binaryOperatorExpression operator="Add">
																													<propertyReferenceExpression name="TimeSeparator">
																														<propertyReferenceExpression name="DateTimeFormat">
																															<variableReferenceExpression name="currentCulture"/>
																														</propertyReferenceExpression>
																													</propertyReferenceExpression>
																													<propertyReferenceExpression name="NumberDecimalSeparator">
																														<propertyReferenceExpression name="NumberFormat">
																															<variableReferenceExpression name="currentCulture"/>
																														</propertyReferenceExpression>
																													</propertyReferenceExpression>
																												</binaryOperatorExpression>
																											</binaryOperatorExpression>
																										</parameters>
																									</methodInvokeExpression>
																								</binaryOperatorExpression>
																							</init>
																						</variableDeclarationStatement>
																						<variableDeclarationStatement type="System.String[]" name="removableNumericCharacters">
																							<init>
																								<arrayCreateExpression>
																									<createType type="System.String"/>
																									<initializers>
																										<propertyReferenceExpression name="NumberGroupSeparator">
																											<propertyReferenceExpression name="NumberFormat">
																												<variableReferenceExpression name="currentCulture"/>
																											</propertyReferenceExpression>
																										</propertyReferenceExpression>
																										<propertyReferenceExpression name="CurrencyGroupSeparator">
																											<propertyReferenceExpression name="NumberFormat">
																												<variableReferenceExpression name="currentCulture"/>
																											</propertyReferenceExpression>
																										</propertyReferenceExpression>
																										<propertyReferenceExpression name="CurrencySymbol">
																											<propertyReferenceExpression name="NumberFormat">
																												<variableReferenceExpression name="currentCulture"/>
																											</propertyReferenceExpression>
																										</propertyReferenceExpression>
																									</initializers>
																								</arrayCreateExpression>
																							</init>
																						</variableDeclarationStatement>
																						<variableDeclarationStatement type="Match" name="m">
																							<init>
																								<methodInvokeExpression methodName="Match">
																									<target>
																										<typeReferenceExpression type="Regex"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="paramValue"/>
																										<methodInvokeExpression methodName="Format">
																											<target>
																												<typeReferenceExpression type="String"/>
																											</target>
																											<parameters>
																												<primitiveExpression>
																													<xsl:attribute name="value"><![CDATA[\s*(?'Token'((?'Quote'")(?'Value'.+?)")|((?'Quote'\')(?'Value'.+?)\')|(,|;|(^|\s+)-)|(?'Value'[{0}]+))]]></xsl:attribute>
																												</primitiveExpression>
																												<variableReferenceExpression name="textDateNumber"/>
																											</parameters>
																										</methodInvokeExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</init>
																						</variableDeclarationStatement>
																						<variableDeclarationStatement type="System.Boolean" name="negativeSample">
																							<init>
																								<primitiveExpression value="false"/>
																							</init>
																						</variableDeclarationStatement>
																						<whileStatement>
																							<test>
																								<propertyReferenceExpression name="Success">
																									<variableReferenceExpression name="m"/>
																								</propertyReferenceExpression>
																							</test>
																							<statements>
																								<variableDeclarationStatement type="System.String" name="token">
																									<init>
																										<methodInvokeExpression methodName="Trim">
																											<target>
																												<propertyReferenceExpression name="Value">
																													<arrayIndexerExpression>
																														<target>
																															<propertyReferenceExpression name="Groups">
																																<variableReferenceExpression name="m"/>
																															</propertyReferenceExpression>
																														</target>
																														<indices>
																															<primitiveExpression value="Token"/>
																														</indices>
																													</arrayIndexerExpression>
																												</propertyReferenceExpression>
																											</target>
																										</methodInvokeExpression>
																									</init>
																								</variableDeclarationStatement>
																								<conditionStatement>
																									<condition>
																										<binaryOperatorExpression operator="BooleanOr">
																											<binaryOperatorExpression operator="ValueEquality">
																												<variableReferenceExpression name="token"/>
																												<primitiveExpression value=","/>
																											</binaryOperatorExpression>
																											<binaryOperatorExpression operator="ValueEquality">
																												<variableReferenceExpression name="token"/>
																												<primitiveExpression value=";"/>
																											</binaryOperatorExpression>
																										</binaryOperatorExpression>
																									</condition>
																									<trueStatements>
																										<assignStatement>
																											<variableReferenceExpression name="words"/>
																											<objectCreateExpression type="List">
																												<typeArguments>
																													<typeReference type="System.String"/>
																												</typeArguments>
																											</objectCreateExpression>
																										</assignStatement>
																										<methodInvokeExpression methodName="Add">
																											<target>
																												<variableReferenceExpression name="phrases"/>
																											</target>
																											<parameters>
																												<variableReferenceExpression name="words"/>
																											</parameters>
																										</methodInvokeExpression>
																										<assignStatement>
																											<variableReferenceExpression name="negativeSample"/>
																											<primitiveExpression value="false"/>
																										</assignStatement>
																									</trueStatements>
																									<falseStatements>
																										<conditionStatement>
																											<condition>
																												<binaryOperatorExpression operator="ValueEquality">
																													<variableReferenceExpression name="token"/>
																													<primitiveExpression value="-"/>
																												</binaryOperatorExpression>
																											</condition>
																											<trueStatements>
																												<assignStatement>
																													<variableReferenceExpression name="negativeSample"/>
																													<primitiveExpression value="true"/>
																												</assignStatement>
																											</trueStatements>
																											<falseStatements>
																												<variableDeclarationStatement type="System.String" name="exactFlag">
																													<init>
																														<primitiveExpression value="="/>
																													</init>
																												</variableDeclarationStatement>
																												<conditionStatement>
																													<condition>
																														<unaryOperatorExpression operator="IsNullOrEmpty">
																															<propertyReferenceExpression name="Value">
																																<arrayIndexerExpression>
																																	<target>
																																		<propertyReferenceExpression name="Groups">
																																			<variableReferenceExpression name="m"/>
																																		</propertyReferenceExpression>
																																	</target>
																																	<indices>
																																		<primitiveExpression value="Quote"/>
																																	</indices>
																																</arrayIndexerExpression>
																															</propertyReferenceExpression>
																														</unaryOperatorExpression>
																													</condition>
																													<trueStatements>
																														<assignStatement>
																															<variableReferenceExpression name="exactFlag"/>
																															<primitiveExpression value=" "/>
																														</assignStatement>
																													</trueStatements>
																												</conditionStatement>
																												<variableDeclarationStatement type="System.String" name="negativeFlag">
																													<init>
																														<primitiveExpression value=" "/>
																													</init>
																												</variableDeclarationStatement>
																												<conditionStatement>
																													<condition>
																														<variableReferenceExpression name="negativeSample"/>
																													</condition>
																													<trueStatements>
																														<assignStatement>
																															<variableReferenceExpression name="negativeFlag"/>
																															<primitiveExpression value="-"/>
																														</assignStatement>
																														<assignStatement>
																															<variableReferenceExpression name="negativeSample"/>
																															<primitiveExpression value="false"/>
																														</assignStatement>
																													</trueStatements>
																												</conditionStatement>
																												<methodInvokeExpression methodName="Add">
																													<target>
																														<variableReferenceExpression name="words"/>
																													</target>
																													<parameters>
																														<methodInvokeExpression methodName="Format">
																															<target>
																																<typeReferenceExpression type="String"/>
																															</target>
																															<parameters>
																																<primitiveExpression value="{{0}}{{1}}{{2}}"/>
																																<variableReferenceExpression name="negativeFlag"/>
																																<variableReferenceExpression name="exactFlag"/>
																																<propertyReferenceExpression name="Value">
																																	<arrayIndexerExpression>
																																		<target>
																																			<propertyReferenceExpression name="Groups">
																																				<variableReferenceExpression name="m"/>
																																			</propertyReferenceExpression>
																																		</target>
																																		<indices>
																																			<primitiveExpression value="Value"/>
																																		</indices>
																																	</arrayIndexerExpression>
																																</propertyReferenceExpression>
																															</parameters>
																														</methodInvokeExpression>
																													</parameters>
																												</methodInvokeExpression>
																											</falseStatements>
																										</conditionStatement>
																									</falseStatements>
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


																						<variableDeclarationStatement type="System.Boolean" name="firstPhrase">
																							<init>
																								<primitiveExpression value="true"/>
																							</init>
																						</variableDeclarationStatement>
																						<foreachStatement>
																							<variable type="List" name="phrase">
																								<typeArguments>
																									<typeReference type="String"/>
																								</typeArguments>
																							</variable>
																							<target>
																								<variableReferenceExpression name="phrases"/>
																							</target>
																							<statements>
																								<conditionStatement>
																									<condition>
																										<binaryOperatorExpression operator="GreaterThan">
																											<propertyReferenceExpression name="Count">
																												<variableReferenceExpression name="phrase"/>
																											</propertyReferenceExpression>
																											<primitiveExpression value="0"/>
																										</binaryOperatorExpression>
																									</condition>
																									<trueStatements>
																										<conditionStatement>
																											<condition>
																												<variableReferenceExpression name="firstPhrase"/>
																											</condition>
																											<trueStatements>
																												<assignStatement>
																													<variableReferenceExpression name="firstPhrase"/>
																													<primitiveExpression value="false"/>
																												</assignStatement>
																											</trueStatements>
																											<falseStatements>
																												<methodInvokeExpression methodName="AppendLine">
																													<target>
																														<argumentReferenceExpression name="sb"/>
																													</target>
																													<parameters>
																														<primitiveExpression value="or"/>
																													</parameters>
																												</methodInvokeExpression>
																											</falseStatements>
																										</conditionStatement>
																										<methodInvokeExpression methodName="AppendLine">
																											<target>
																												<variableReferenceExpression name="sb"/>
																											</target>
																											<parameters>
																												<primitiveExpression value="("/>
																											</parameters>
																										</methodInvokeExpression>
																										<variableDeclarationStatement type="System.Boolean" name="firstWord">
																											<init>
																												<primitiveExpression value="true"/>
																											</init>
																										</variableDeclarationStatement>
																										<variableDeclarationStatement type="System.DateTime" name="paramValueAsDate"/>
																										<foreachStatement>
																											<variable type="System.String" name="paramValueWord"/>
																											<target>
																												<variableReferenceExpression name="phrase"/>
																											</target>
																											<statements>
																												<variableDeclarationStatement type="System.Boolean" name="negativeFlag">
																													<init>
																														<binaryOperatorExpression operator="ValueEquality">
																															<arrayIndexerExpression>
																																<target>
																																	<variableReferenceExpression name="paramValueWord"/>
																																</target>
																																<indices>
																																	<primitiveExpression value="0"/>
																																</indices>
																															</arrayIndexerExpression>
																															<primitiveExpression convertTo="Char" value="-"/>
																														</binaryOperatorExpression>
																													</init>
																												</variableDeclarationStatement>
																												<variableDeclarationStatement type="System.Boolean" name="exactFlag">
																													<init>
																														<binaryOperatorExpression operator="ValueEquality">
																															<arrayIndexerExpression>
																																<target>
																																	<variableReferenceExpression name="paramValueWord"/>
																																</target>
																																<indices>
																																	<primitiveExpression value="1"/>
																																</indices>
																															</arrayIndexerExpression>
																															<primitiveExpression convertTo="Char" value="="/>
																														</binaryOperatorExpression>
																													</init>
																												</variableDeclarationStatement>
																												<variableDeclarationStatement type="System.String" name="comparisonOperator">
																													<init>
																														<primitiveExpression value="like"/>
																													</init>
																												</variableDeclarationStatement>
																												<conditionStatement>
																													<condition>
																														<variableReferenceExpression name="exactFlag"/>
																													</condition>
																													<trueStatements>
																														<assignStatement>
																															<variableReferenceExpression name="comparisonOperator"/>
																															<primitiveExpression value="="/>
																														</assignStatement>
																													</trueStatements>
																												</conditionStatement>
																												<variableDeclarationStatement type="System.String" name="pv">
																													<init>
																														<methodInvokeExpression methodName="Substring">
																															<target>
																																<variableReferenceExpression name="paramValueWord"/>
																															</target>
																															<parameters>
																																<primitiveExpression value="2"/>
																															</parameters>
																														</methodInvokeExpression>
																													</init>
																												</variableDeclarationStatement>
																												<variableDeclarationStatement type="System.String" name="fieldNameFilter">
																													<init>
																														<primitiveExpression value="null"/>
																													</init>
																												</variableDeclarationStatement>
																												<variableDeclarationStatement type="Match" name="complexParam">
																													<init>
																														<methodInvokeExpression methodName="Match">
																															<target>
																																<typeReferenceExpression type="Regex"/>
																															</target>
																															<parameters>
																																<variableReferenceExpression name="pv"/>
																																<primitiveExpression>
																																	<xsl:attribute name="value"><![CDATA[^(.+)\:(.+)$]]></xsl:attribute>
																																</primitiveExpression>
																															</parameters>
																														</methodInvokeExpression>
																													</init>
																												</variableDeclarationStatement>
																												<conditionStatement>
																													<condition>
																														<propertyReferenceExpression name="Success">
																															<variableReferenceExpression name="complexParam"/>
																														</propertyReferenceExpression>
																													</condition>
																													<trueStatements>
																														<assignStatement>
																															<variableReferenceExpression name="fieldNameFilter"/>
																															<propertyReferenceExpression name="Value">
																																<arrayIndexerExpression>
																																	<target>
																																		<propertyReferenceExpression name="Groups">
																																			<variableReferenceExpression name="complexParam"/>
																																		</propertyReferenceExpression>
																																	</target>
																																	<indices>
																																		<primitiveExpression value="1"/>
																																	</indices>
																																</arrayIndexerExpression>
																															</propertyReferenceExpression>
																														</assignStatement>
																														<variableDeclarationStatement type="System.Boolean" name="fieldIsMatched">
																															<init>
																																<primitiveExpression value="false"/>
																															</init>
																														</variableDeclarationStatement>
																														<foreachStatement>
																															<variable type="DataField" name="tf"/>
																															<target>
																																<propertyReferenceExpression name="Fields">
																																	<argumentReferenceExpression name="page"/>
																																</propertyReferenceExpression>
																															</target>
																															<statements>
																																<conditionStatement>
																																	<condition>
																																		<binaryOperatorExpression operator="BooleanAnd">
																																			<binaryOperatorExpression operator="BooleanAnd">
																																				<propertyReferenceExpression name="AllowQBE">
																																					<variableReferenceExpression name="tf"/>
																																				</propertyReferenceExpression>
																																				<unaryOperatorExpression operator="IsNullOrEmpty">
																																					<propertyReferenceExpression name="AliasName">
																																						<variableReferenceExpression name="tf"/>
																																					</propertyReferenceExpression>
																																				</unaryOperatorExpression>
																																			</binaryOperatorExpression>
																																			<binaryOperatorExpression operator="BooleanAnd">
																																				<unaryOperatorExpression operator="Not">
																																					<binaryOperatorExpression operator="BooleanAnd">
																																						<propertyReferenceExpression name="IsPrimaryKey">
																																							<variableReferenceExpression name="tf"/>
																																						</propertyReferenceExpression>
																																						<propertyReferenceExpression name="Hidden">
																																							<variableReferenceExpression name="tf"/>
																																						</propertyReferenceExpression>
																																					</binaryOperatorExpression>
																																				</unaryOperatorExpression>
																																				<methodInvokeExpression methodName="IsMatchedByName">
																																					<target>
																																						<variableReferenceExpression name="tf"/>
																																					</target>
																																					<parameters>
																																						<variableReferenceExpression name="fieldNameFilter"/>
																																					</parameters>
																																				</methodInvokeExpression>
																																			</binaryOperatorExpression>
																																		</binaryOperatorExpression>
																																	</condition>
																																	<trueStatements>
																																		<assignStatement>
																																			<variableReferenceExpression name="fieldIsMatched"/>
																																			<primitiveExpression value="true"/>
																																		</assignStatement>
																																		<breakStatement/>
																																	</trueStatements>
																																</conditionStatement>
																															</statements>
																														</foreachStatement>
																														<conditionStatement>
																															<condition>
																																<variableReferenceExpression name="fieldIsMatched"/>
																															</condition>
																															<trueStatements>
																																<assignStatement>
																																	<variableReferenceExpression name="pv"/>
																																	<propertyReferenceExpression name="Value">
																																		<arrayIndexerExpression>
																																			<target>
																																				<propertyReferenceExpression name="Groups">
																																					<variableReferenceExpression name="complexParam"/>
																																				</propertyReferenceExpression>
																																			</target>
																																			<indices>
																																				<primitiveExpression value="2"/>
																																			</indices>
																																		</arrayIndexerExpression>
																																	</propertyReferenceExpression>
																																</assignStatement>
																															</trueStatements>
																															<falseStatements>
																																<assignStatement>
																																	<variableReferenceExpression name="fieldNameFilter"/>
																																	<primitiveExpression value="null"/>
																																</assignStatement>
																															</falseStatements>
																														</conditionStatement>
																													</trueStatements>
																												</conditionStatement>
																												<variableDeclarationStatement type="System.Boolean" name="paramValueIsDate">
																													<init>
																														<methodInvokeExpression methodName="TryParseDate">
																															<target>
																																<typeReferenceExpression type="SqlStatement"/>
																															</target>
																															<parameters>
																																<methodInvokeExpression methodName="GetType">
																																	<target>
																																		<argumentReferenceExpression name="command"/>
																																	</target>
																																</methodInvokeExpression>
																																<variableReferenceExpression name="pv"/>
																																<directionExpression direction="Out">
																																	<variableReferenceExpression name="paramValueAsDate"/>
																																</directionExpression>
																															</parameters>
																														</methodInvokeExpression>
																													</init>
																												</variableDeclarationStatement>
																												<variableDeclarationStatement type="System.Boolean" name="firstTry">
																													<init>
																														<primitiveExpression value="true"/>
																													</init>
																												</variableDeclarationStatement>
																												<variableDeclarationStatement type="DbParameter" name="parameter">
																													<init>
																														<primitiveExpression value="null"/>
																													</init>
																												</variableDeclarationStatement>
																												<conditionStatement>
																													<condition>
																														<unaryOperatorExpression operator="Not">
																															<variableReferenceExpression name="paramValueIsDate"/>
																														</unaryOperatorExpression>
																													</condition>
																													<trueStatements>
																														<assignStatement>
																															<variableReferenceExpression name="pv"/>
																															<methodInvokeExpression methodName="EscapePattern">
																																<target>
																																	<typeReferenceExpression type="SqlStatement"/>
																																</target>
																																<parameters>
																																	<argumentReferenceExpression name="command"/>
																																	<variableReferenceExpression name="pv"/>
																																</parameters>
																															</methodInvokeExpression>
																														</assignStatement>
																													</trueStatements>
																												</conditionStatement>
																												<variableDeclarationStatement type="System.Double" name="paramValueAsNumber"/>
																												<variableDeclarationStatement type="System.String" name="testNumber">
																													<init>
																														<variableReferenceExpression name="pv"/>
																													</init>
																												</variableDeclarationStatement>
																												<foreachStatement>
																													<variable type="System.String" name="s"/>
																													<target>
																														<variableReferenceExpression name="removableNumericCharacters"/>
																													</target>
																													<statements>
																														<assignStatement>
																															<variableReferenceExpression name="testNumber"/>
																															<methodInvokeExpression methodName="Replace">
																																<target>
																																	<variableReferenceExpression name="testNumber"/>
																																</target>
																																<parameters>
																																	<variableReferenceExpression name="s"/>
																																	<propertyReferenceExpression name="Empty">
																																		<typeReferenceExpression type="System.String"/>
																																	</propertyReferenceExpression>
																																</parameters>
																															</methodInvokeExpression>
																														</assignStatement>
																													</statements>
																												</foreachStatement>
																												<variableDeclarationStatement type="System.Boolean" name="paramValueIsNumber">
																													<init>
																														<methodInvokeExpression methodName="TryParse">
																															<target>
																																<typeReferenceExpression type="System.Double"/>
																															</target>
																															<parameters>
																																<variableReferenceExpression name="testNumber"/>
																																<directionExpression direction="Out">
																																	<variableReferenceExpression name="paramValueAsNumber"/>
																																</directionExpression>
																															</parameters>
																														</methodInvokeExpression>
																													</init>
																												</variableDeclarationStatement>
																												<conditionStatement>
																													<condition>
																														<binaryOperatorExpression operator="BooleanAnd">
																															<unaryOperatorExpression operator="Not">
																																<variableReferenceExpression name="exactFlag"/>
																															</unaryOperatorExpression>
																															<unaryOperatorExpression operator="Not">
																																<methodInvokeExpression methodName="Contains">
																																	<target>
																																		<variableReferenceExpression name="pv"/>
																																	</target>
																																	<parameters>
																																		<primitiveExpression value="%"/>
																																	</parameters>
																																</methodInvokeExpression>
																															</unaryOperatorExpression>
																														</binaryOperatorExpression>
																													</condition>
																													<trueStatements>
																														<assignStatement>
																															<variableReferenceExpression name="pv"/>
																															<stringFormatExpression format="%{{0}}%">
																																<variableReferenceExpression name="pv"/>
																															</stringFormatExpression>
																														</assignStatement>
																													</trueStatements>
																												</conditionStatement>
																												<conditionStatement>
																													<condition>
																														<variableReferenceExpression name="firstWord"/>
																													</condition>
																													<trueStatements>
																														<assignStatement>
																															<variableReferenceExpression name="firstWord"/>
																															<primitiveExpression value="false"/>
																														</assignStatement>
																													</trueStatements>
																													<falseStatements>
																														<methodInvokeExpression methodName="Append">
																															<target>
																																<variableReferenceExpression name="sb"/>
																															</target>
																															<parameters>
																																<primitiveExpression value="and"/>
																															</parameters>
																														</methodInvokeExpression>
																													</falseStatements>
																												</conditionStatement>
																												<conditionStatement>
																													<condition>
																														<variableReferenceExpression name="negativeFlag"/>
																													</condition>
																													<trueStatements>
																														<methodInvokeExpression methodName="Append">
																															<target>
																																<variableReferenceExpression name="sb"/>
																															</target>
																															<parameters>
																																<primitiveExpression value=" not"/>
																															</parameters>
																														</methodInvokeExpression>
																													</trueStatements>
																												</conditionStatement>
																												<methodInvokeExpression methodName="Append">
																													<target>
																														<variableReferenceExpression name="sb"/>
																													</target>
																													<parameters>
																														<primitiveExpression value="("/>
																													</parameters>
																												</methodInvokeExpression>
																												<variableDeclarationStatement type="System.Boolean" name="hasTests">
																													<init>
																														<primitiveExpression value="false"/>
																													</init>
																												</variableDeclarationStatement>
																												<variableDeclarationStatement type="DbParameter" name="originalParameter">
																													<init>
																														<primitiveExpression value="null"/>
																													</init>
																												</variableDeclarationStatement>
																												<conditionStatement>
																													<condition>
																														<binaryOperatorExpression operator="BooleanOr">
																															<unaryOperatorExpression operator="IsNullOrEmpty">
																																<variableReferenceExpression name="quickFindHint"/>
																															</unaryOperatorExpression>
																															<unaryOperatorExpression operator="Not">
																																<methodInvokeExpression methodName="StartsWith">
																																	<target>
																																		<variableReferenceExpression name="quickFindHint"/>
																																	</target>
																																	<parameters>
																																		<primitiveExpression value=";"/>
																																	</parameters>
																																</methodInvokeExpression>
																															</unaryOperatorExpression>
																														</binaryOperatorExpression>
																													</condition>
																													<trueStatements>
																														<foreachStatement>
																															<variable type="DataField" name="tf"/>
																															<target>
																																<propertyReferenceExpression name="Fields">
																																	<argumentReferenceExpression name="page"/>
																																</propertyReferenceExpression>
																															</target>
																															<statements>
																																<conditionStatement>
																																	<condition>
																																		<binaryOperatorExpression operator="BooleanAnd">
																																			<binaryOperatorExpression operator="BooleanAnd">
																																				<propertyReferenceExpression name="AllowQBE">
																																					<variableReferenceExpression name="tf"/>
																																				</propertyReferenceExpression>
																																				<unaryOperatorExpression operator="IsNullOrEmpty">
																																					<propertyReferenceExpression name="AliasName">
																																						<variableReferenceExpression name="tf"/>
																																					</propertyReferenceExpression>
																																				</unaryOperatorExpression>
																																			</binaryOperatorExpression>
																																			<binaryOperatorExpression operator="BooleanAnd">
																																				<unaryOperatorExpression operator="Not">
																																					<binaryOperatorExpression operator="BooleanAnd">
																																						<propertyReferenceExpression name="IsPrimaryKey">
																																							<variableReferenceExpression name="tf"/>
																																						</propertyReferenceExpression>
																																						<propertyReferenceExpression name="Hidden">
																																							<variableReferenceExpression name="tf"/>
																																						</propertyReferenceExpression>
																																					</binaryOperatorExpression>
																																				</unaryOperatorExpression>
																																				<binaryOperatorExpression operator="BooleanOr">
																																					<unaryOperatorExpression operator="Not">
																																						<methodInvokeExpression methodName="StartsWith">
																																							<target>
																																								<propertyReferenceExpression name="Type">
																																									<variableReferenceExpression name="tf"/>
																																								</propertyReferenceExpression>
																																							</target>
																																							<parameters>
																																								<primitiveExpression value="Date"/>
																																							</parameters>
																																						</methodInvokeExpression>
																																					</unaryOperatorExpression>
																																					<variableReferenceExpression name="paramValueIsDate"/>
																																				</binaryOperatorExpression>
																																			</binaryOperatorExpression>
																																		</binaryOperatorExpression>
																																	</condition>
																																	<trueStatements>
																																		<conditionStatement>
																																			<condition>
																																				<binaryOperatorExpression operator="BooleanOr">
																																					<unaryOperatorExpression operator="IsNullOrEmpty">
																																						<variableReferenceExpression name="fieldNameFilter"/>
																																					</unaryOperatorExpression>
																																					<methodInvokeExpression methodName="IsMatchedByName">
																																						<target>
																																							<variableReferenceExpression name="tf"/>
																																						</target>
																																						<parameters>
																																							<variableReferenceExpression name="fieldNameFilter"/>
																																						</parameters>
																																					</methodInvokeExpression>
																																				</binaryOperatorExpression>
																																			</condition>
																																			<trueStatements>
																																				<conditionStatement>
																																					<condition>
																																						<binaryOperatorExpression operator="BooleanOr">
																																							<binaryOperatorExpression operator="BooleanAnd">
																																								<unaryOperatorExpression operator="Not">
																																									<variableReferenceExpression name="useExclusiveQuickFind"/>
																																								</unaryOperatorExpression>
																																								<binaryOperatorExpression operator="BooleanOr">
																																									<unaryOperatorExpression operator="IsNullOrEmpty">
																																										<propertyReferenceExpression name="SearchOptions">
																																											<variableReferenceExpression name="tf"/>
																																										</propertyReferenceExpression>
																																									</unaryOperatorExpression>
																																									<unaryOperatorExpression operator="Not">
																																										<methodInvokeExpression methodName="Contains">
																																											<target>
																																												<propertyReferenceExpression name="SearchOptions">
																																													<variableReferenceExpression name="tf"/>
																																												</propertyReferenceExpression>
																																											</target>
																																											<parameters>
																																												<primitiveExpression value="$quickfinddisabled"/>
																																											</parameters>
																																										</methodInvokeExpression>
																																									</unaryOperatorExpression>
																																								</binaryOperatorExpression>
																																							</binaryOperatorExpression>
																																							<binaryOperatorExpression operator="BooleanAnd">
																																								<variableReferenceExpression name="useExclusiveQuickFind"/>
																																								<binaryOperatorExpression operator="BooleanAnd">
																																									<unaryOperatorExpression operator="IsNotNullOrEmpty">
																																										<propertyReferenceExpression name="SearchOptions">
																																											<variableReferenceExpression name="tf"/>
																																										</propertyReferenceExpression>
																																									</unaryOperatorExpression>
																																									<methodInvokeExpression methodName="Contains">
																																										<target>
																																											<propertyReferenceExpression name="SearchOptions">
																																												<variableReferenceExpression name="tf"/>
																																											</propertyReferenceExpression>
																																										</target>
																																										<parameters>
																																											<primitiveExpression value="$quickfind"/>
																																										</parameters>
																																									</methodInvokeExpression>
																																								</binaryOperatorExpression>
																																							</binaryOperatorExpression>
																																						</binaryOperatorExpression>
																																					</condition>
																																					<trueStatements>
																																						<assignStatement>
																																							<variableReferenceExpression name="hasTests"/>
																																							<primitiveExpression value="true"/>
																																						</assignStatement>
																																						<conditionStatement>
																																							<condition>
																																								<binaryOperatorExpression operator="BooleanOr">
																																									<binaryOperatorExpression operator="IdentityEquality">
																																										<variableReferenceExpression name="parameter"/>
																																										<primitiveExpression value="null"/>
																																									</binaryOperatorExpression>
																																									<methodInvokeExpression methodName="Contains">
																																										<target>
																																											<propertyReferenceExpression name="FullName">
																																												<methodInvokeExpression methodName="GetType">
																																													<target>
																																														<argumentReferenceExpression name="command"/>
																																													</target>
																																												</methodInvokeExpression>
																																											</propertyReferenceExpression>
																																										</target>
																																										<parameters>
																																											<primitiveExpression value="ManagedDataAccess"/>
																																										</parameters>
																																									</methodInvokeExpression>
																																								</binaryOperatorExpression>
																																							</condition>
																																							<trueStatements>
																																								<assignStatement>
																																									<variableReferenceExpression name="parameter"/>
																																									<methodInvokeExpression methodName="CreateParameter">
																																										<target>
																																											<argumentReferenceExpression name="command"/>
																																										</target>
																																									</methodInvokeExpression>
																																								</assignStatement>
																																								<assignStatement>
																																									<propertyReferenceExpression name="ParameterName">
																																										<variableReferenceExpression name="parameter"/>
																																									</propertyReferenceExpression>
																																									<stringFormatExpression format="{{0}}p{{1}}">
																																										<fieldReferenceExpression name="parameterMarker"/>
																																										<propertyReferenceExpression name="Count">
																																											<propertyReferenceExpression name="Parameters">
																																												<argumentReferenceExpression name="command"/>
																																											</propertyReferenceExpression>
																																										</propertyReferenceExpression>
																																									</stringFormatExpression>
																																								</assignStatement>
																																								<assignStatement>
																																									<propertyReferenceExpression name="DbType">
																																										<variableReferenceExpression name="parameter"/>
																																									</propertyReferenceExpression>
																																									<propertyReferenceExpression name="String">
																																										<typeReferenceExpression type="DbType"/>
																																									</propertyReferenceExpression>
																																								</assignStatement>
																																								<methodInvokeExpression methodName="Add">
																																									<target>
																																										<propertyReferenceExpression name="Parameters">
																																											<argumentReferenceExpression name="command"/>
																																										</propertyReferenceExpression>
																																									</target>
																																									<parameters>
																																										<variableReferenceExpression name="parameter"/>
																																									</parameters>
																																								</methodInvokeExpression>
																																								<assignStatement>
																																									<propertyReferenceExpression name="Value">
																																										<variableReferenceExpression name="parameter"/>
																																									</propertyReferenceExpression>
																																									<variableReferenceExpression name="pv"/>
																																								</assignStatement>
																																								<conditionStatement>
																																									<condition>
																																										<binaryOperatorExpression operator="BooleanAnd">
																																											<variableReferenceExpression name="exactFlag"/>
																																											<variableReferenceExpression name="paramValueIsNumber"/>
																																										</binaryOperatorExpression>
																																									</condition>
																																									<trueStatements>
																																										<assignStatement>
																																											<propertyReferenceExpression name="DbType">
																																												<variableReferenceExpression name="parameter"/>
																																											</propertyReferenceExpression>
																																											<propertyReferenceExpression name="Double">
																																												<typeReferenceExpression type="DbType"/>
																																											</propertyReferenceExpression>
																																										</assignStatement>
																																										<assignStatement>
																																											<propertyReferenceExpression name="Value">
																																												<variableReferenceExpression name="parameter"/>
																																											</propertyReferenceExpression>
																																											<variableReferenceExpression name="paramValueAsNumber"/>
																																										</assignStatement>
																																									</trueStatements>
																																								</conditionStatement>
																																							</trueStatements>
																																						</conditionStatement>
																																						<conditionStatement>
																																							<condition>
																																								<unaryOperatorExpression operator="Not">
																																									<binaryOperatorExpression operator="BooleanAnd">
																																										<variableReferenceExpression name="exactFlag"/>
																																										<binaryOperatorExpression operator="BooleanOr">
																																											<binaryOperatorExpression operator="BooleanAnd">
																																												<unaryOperatorExpression operator="Not">
																																													<methodInvokeExpression methodName="Contains">
																																														<target>
																																															<propertyReferenceExpression name="Type">
																																																<variableReferenceExpression name="tf"/>
																																															</propertyReferenceExpression>
																																														</target>
																																														<parameters>
																																															<primitiveExpression value="String"/>
																																														</parameters>
																																													</methodInvokeExpression>
																																												</unaryOperatorExpression>
																																												<unaryOperatorExpression operator="Not">
																																													<variableReferenceExpression name="paramValueIsNumber"/>
																																												</unaryOperatorExpression>
																																											</binaryOperatorExpression>
																																											<binaryOperatorExpression operator="BooleanAnd">
																																												<methodInvokeExpression  methodName="Contains">
																																													<target>
																																														<propertyReferenceExpression name="Type">
																																															<variableReferenceExpression name="tf"/>
																																														</propertyReferenceExpression>
																																													</target>
																																													<parameters>
																																														<primitiveExpression value="String"/>
																																													</parameters>
																																												</methodInvokeExpression>
																																												<variableReferenceExpression name="paramValueIsNumber"/>
																																											</binaryOperatorExpression>
																																										</binaryOperatorExpression>
																																									</binaryOperatorExpression>
																																								</unaryOperatorExpression>
																																							</condition>
																																							<trueStatements>
																																								<conditionStatement>
																																									<condition>
																																										<variableReferenceExpression name="firstTry"/>
																																									</condition>
																																									<trueStatements>
																																										<assignStatement>
																																											<variableReferenceExpression name="firstTry"/>
																																											<primitiveExpression value="false"/>
																																										</assignStatement>
																																									</trueStatements>
																																									<falseStatements>
																																										<methodInvokeExpression methodName="Append">
																																											<target>
																																												<variableReferenceExpression name="sb"/>
																																											</target>
																																											<parameters>
																																												<primitiveExpression value=" or "/>
																																											</parameters>
																																										</methodInvokeExpression>
																																									</falseStatements>
																																								</conditionStatement>
																																								<conditionStatement>
																																									<condition>
																																										<methodInvokeExpression methodName="StartsWith">
																																											<target>
																																												<propertyReferenceExpression name="Type">
																																													<variableReferenceExpression name="tf"/>
																																												</propertyReferenceExpression>
																																											</target>
																																											<parameters>
																																												<primitiveExpression value="Date"/>
																																											</parameters>
																																										</methodInvokeExpression>
																																									</condition>
																																									<trueStatements>
																																										<variableDeclarationStatement type="DbParameter" name="dateParameter">
																																											<init>
																																												<methodInvokeExpression methodName="CreateParameter">
																																													<target>
																																														<variableReferenceExpression name="command"/>
																																													</target>
																																												</methodInvokeExpression>
																																											</init>
																																										</variableDeclarationStatement>
																																										<assignStatement>
																																											<propertyReferenceExpression name="ParameterName">
																																												<variableReferenceExpression name="dateParameter"/>
																																											</propertyReferenceExpression>
																																											<stringFormatExpression format="{{0}}p{{1}}">
																																												<fieldReferenceExpression name="parameterMarker"/>
																																												<propertyReferenceExpression name="Count">
																																													<propertyReferenceExpression name="Parameters">
																																														<argumentReferenceExpression name="command"/>
																																													</propertyReferenceExpression>
																																												</propertyReferenceExpression>
																																											</stringFormatExpression>
																																										</assignStatement>
																																										<assignStatement>
																																											<propertyReferenceExpression name="DbType">
																																												<variableReferenceExpression name="dateParameter"/>
																																											</propertyReferenceExpression>
																																											<propertyReferenceExpression name="DateTime">
																																												<typeReferenceExpression type="DbType"/>
																																											</propertyReferenceExpression>
																																										</assignStatement>
																																										<methodInvokeExpression methodName="Add">
																																											<target>
																																												<propertyReferenceExpression name="Parameters">
																																													<argumentReferenceExpression name="command"/>
																																												</propertyReferenceExpression>
																																											</target>
																																											<parameters>
																																												<variableReferenceExpression name="dateParameter"/>
																																											</parameters>
																																										</methodInvokeExpression>
																																										<assignStatement>
																																											<propertyReferenceExpression name="Value">
																																												<variableReferenceExpression name="dateParameter"/>
																																											</propertyReferenceExpression>
																																											<variableReferenceExpression name="paramValueAsDate"/>
																																										</assignStatement>
																																										<conditionStatement>
																																											<condition>
																																												<variableReferenceExpression name="negativeFlag"/>
																																											</condition>
																																											<trueStatements>
																																												<methodInvokeExpression methodName="AppendFormat">
																																													<target>
																																														<variableReferenceExpression name="sb"/>
																																													</target>
																																													<parameters>
																																														<primitiveExpression value="({{0}} is not null)and"/>
																																														<arrayIndexerExpression>
																																															<target>
																																																<argumentReferenceExpression name="expressions"/>
																																															</target>
																																															<indices>
																																																<methodInvokeExpression methodName="ExpressionName">
																																																	<target>
																																																		<variableReferenceExpression name="tf"/>
																																																	</target>
																																																</methodInvokeExpression>
																																															</indices>
																																														</arrayIndexerExpression>
																																													</parameters>
																																												</methodInvokeExpression>
																																											</trueStatements>
																																										</conditionStatement>
																																										<methodInvokeExpression methodName="AppendFormat">
																																											<target>
																																												<argumentReferenceExpression name="sb"/>
																																											</target>
																																											<parameters>
																																												<primitiveExpression value="({{0}} = {{1}})"/>
																																												<arrayIndexerExpression>
																																													<target>
																																														<argumentReferenceExpression name="expressions"/>
																																													</target>
																																													<indices>
																																														<methodInvokeExpression methodName="ExpressionName">
																																															<target>
																																																<variableReferenceExpression name="tf"/>
																																															</target>
																																														</methodInvokeExpression>
																																													</indices>
																																												</arrayIndexerExpression>
																																												<propertyReferenceExpression name="ParameterName">
																																													<variableReferenceExpression name="dateParameter"/>
																																												</propertyReferenceExpression>
																																											</parameters>
																																										</methodInvokeExpression>
																																									</trueStatements>
																																									<falseStatements>
																																										<variableDeclarationStatement type="System.Boolean" name="skipLike">
																																											<init>
																																												<primitiveExpression value="false"/>
																																											</init>
																																										</variableDeclarationStatement>
																																										<conditionStatement>
																																											<condition>
																																												<binaryOperatorExpression operator="BooleanAnd">
																																													<binaryOperatorExpression operator="ValueInequality">
																																														<variableReferenceExpression name="comparisonOperator"/>
																																														<primitiveExpression value="="/>
																																													</binaryOperatorExpression>
																																													<binaryOperatorExpression operator="BooleanAnd">
																																														<binaryOperatorExpression operator="ValueEquality">
																																															<propertyReferenceExpression name="Type">
																																																<variableReferenceExpression name="tf"/>
																																															</propertyReferenceExpression>
																																															<primitiveExpression value="String"/>
																																														</binaryOperatorExpression>
																																														<binaryOperatorExpression operator="BooleanAnd">
																																															<binaryOperatorExpression operator="GreaterThan">
																																																<propertyReferenceExpression name="Len">
																																																	<variableReferenceExpression name="tf"/>
																																																</propertyReferenceExpression>
																																																<primitiveExpression value="0"/>
																																															</binaryOperatorExpression>
																																															<binaryOperatorExpression operator="LessThan">
																																																<propertyReferenceExpression name="Len">
																																																	<variableReferenceExpression name="tf"/>
																																																</propertyReferenceExpression>
																																																<propertyReferenceExpression name="Length">
																																																	<variableReferenceExpression name="pv"/>
																																																</propertyReferenceExpression>
																																															</binaryOperatorExpression>
																																														</binaryOperatorExpression>
																																													</binaryOperatorExpression>
																																												</binaryOperatorExpression>
																																											</condition>
																																											<trueStatements>
																																												<variableDeclarationStatement type="System.String" name="pv2">
																																													<init>
																																														<variableReferenceExpression  name="pv"/>
																																													</init>
																																												</variableDeclarationStatement>
																																												<assignStatement>
																																													<variableReferenceExpression name="pv2"/>
																																													<methodInvokeExpression methodName="Substring">
																																														<target>
																																															<variableReferenceExpression name="pv2"/>
																																														</target>
																																														<parameters>
																																															<primitiveExpression value="1"/>
																																														</parameters>
																																													</methodInvokeExpression>
																																												</assignStatement>
																																												<conditionStatement>
																																													<condition>
																																														<binaryOperatorExpression operator="LessThan">
																																															<propertyReferenceExpression name="Len">
																																																<variableReferenceExpression name="tf"/>
																																															</propertyReferenceExpression>
																																															<propertyReferenceExpression name="Length">
																																																<variableReferenceExpression name="pv2"/>
																																															</propertyReferenceExpression>
																																														</binaryOperatorExpression>
																																													</condition>
																																													<trueStatements>
																																														<assignStatement>
																																															<variableReferenceExpression name="pv2"/>
																																															<methodInvokeExpression methodName="Substring">
																																																<target>
																																																	<variableReferenceExpression name="pv2"/>
																																																</target>
																																																<parameters>
																																																	<primitiveExpression value="0"/>
																																																	<binaryOperatorExpression operator="Subtract">
																																																		<propertyReferenceExpression name="Length">
																																																			<variableReferenceExpression name="pv2"/>
																																																		</propertyReferenceExpression>
																																																		<primitiveExpression value="1"/>
																																																	</binaryOperatorExpression>
																																																</parameters>
																																															</methodInvokeExpression>
																																														</assignStatement>
																																													</trueStatements>
																																												</conditionStatement>
																																												<conditionStatement>
																																													<condition>
																																														<binaryOperatorExpression operator="GreaterThan">
																																															<propertyReferenceExpression name="Length">
																																																<variableReferenceExpression name="pv2"/>
																																															</propertyReferenceExpression>
																																															<propertyReferenceExpression name="Len">
																																																<variableReferenceExpression name="tf"/>
																																															</propertyReferenceExpression>
																																														</binaryOperatorExpression>
																																													</condition>
																																													<trueStatements>
																																														<assignStatement>
																																															<variableReferenceExpression name="skipLike"/>
																																															<primitiveExpression value="true"/>
																																														</assignStatement>
																																													</trueStatements>
																																													<falseStatements>
																																														<assignStatement>
																																															<variableReferenceExpression name="originalParameter"/>
																																															<variableReferenceExpression name="parameter"/>
																																														</assignStatement>
																																														<assignStatement>
																																															<variableReferenceExpression name="parameter"/>
																																															<methodInvokeExpression methodName="CreateParameter">
																																																<target>
																																																	<argumentReferenceExpression name="command"/>
																																																</target>
																																															</methodInvokeExpression>
																																														</assignStatement>
																																														<assignStatement>
																																															<propertyReferenceExpression name="ParameterName">
																																																<variableReferenceExpression name="parameter"/>
																																															</propertyReferenceExpression>
																																															<stringFormatExpression format="{{0}}p{{1}}">
																																																<fieldReferenceExpression name="parameterMarker"/>
																																																<propertyReferenceExpression name="Count">
																																																	<propertyReferenceExpression name="Parameters">
																																																		<argumentReferenceExpression name="command"/>
																																																	</propertyReferenceExpression>
																																																</propertyReferenceExpression>
																																															</stringFormatExpression>
																																														</assignStatement>
																																														<assignStatement>
																																															<propertyReferenceExpression name="DbType">
																																																<argumentReferenceExpression name="parameter"/>
																																															</propertyReferenceExpression>
																																															<propertyReferenceExpression name="String">
																																																<typeReferenceExpression type="DbType"/>
																																															</propertyReferenceExpression>
																																														</assignStatement>
																																														<methodInvokeExpression methodName="Add">
																																															<target>
																																																<propertyReferenceExpression name="Parameters">
																																																	<argumentReferenceExpression name="command"/>
																																																</propertyReferenceExpression>
																																															</target>
																																															<parameters>
																																																<variableReferenceExpression name="parameter"/>
																																															</parameters>
																																														</methodInvokeExpression>
																																														<assignStatement>
																																															<propertyReferenceExpression name="Value">
																																																<variableReferenceExpression name="parameter"/>
																																															</propertyReferenceExpression>
																																															<variableReferenceExpression name="pv2"/>
																																														</assignStatement>
																																													</falseStatements>
																																												</conditionStatement>
																																											</trueStatements>
																																										</conditionStatement>
																																										<conditionStatement>
																																											<condition>
																																												<propertyReferenceExpression name="EnableResultSet">
																																													<fieldReferenceExpression name="serverRules"/>
																																												</propertyReferenceExpression>
																																											</condition>
																																											<trueStatements>
																																												<variableDeclarationStatement type="System.String" name="fieldNameExpression">
																																													<init>
																																														<arrayIndexerExpression>
																																															<target>
																																																<variableReferenceExpression name="expressions"/>
																																															</target>
																																															<indices>
																																																<methodInvokeExpression methodName="ExpressionName">
																																																	<target>
																																																		<variableReferenceExpression name="tf"/>
																																																	</target>
																																																</methodInvokeExpression>
																																															</indices>
																																														</arrayIndexerExpression>
																																													</init>
																																												</variableDeclarationStatement>
																																												<conditionStatement>
																																													<condition>
																																														<binaryOperatorExpression operator="BooleanOr">
																																															<binaryOperatorExpression operator="BooleanAnd">
																																																<binaryOperatorExpression operator="ValueInequality">
																																																	<propertyReferenceExpression name="Type">
																																																		<variableReferenceExpression name="tf"/>
																																																	</propertyReferenceExpression>
																																																	<primitiveExpression value="String"/>
																																																</binaryOperatorExpression>
																																																<unaryOperatorExpression operator="Not">
																																																	<variableReferenceExpression name="exactFlag"/>
																																																</unaryOperatorExpression>
																																															</binaryOperatorExpression>
																																															<binaryOperatorExpression operator="ValueEquality">
																																																<propertyReferenceExpression name="Type">
																																																	<variableReferenceExpression name="tf"/>
																																																</propertyReferenceExpression>
																																																<primitiveExpression value="Boolean"/>
																																															</binaryOperatorExpression>
																																														</binaryOperatorExpression>
																																													</condition>
																																													<trueStatements>
																																														<assignStatement>
																																															<variableReferenceExpression name="fieldNameExpression"/>
																																															<methodInvokeExpression methodName="Format">
																																																<target>
																																																	<typeReferenceExpression type="String"/>
																																																</target>
																																																<parameters>
																																																	<primitiveExpression value="convert({{0}}, 'System.String')"/>
																																																	<variableReferenceExpression name="fieldNameExpression"/>
																																																</parameters>
																																															</methodInvokeExpression>
																																														</assignStatement>
																																													</trueStatements>
																																												</conditionStatement>
																																												<conditionStatement>
																																													<condition>
																																														<variableReferenceExpression name="negativeFlag"/>
																																													</condition>
																																													<trueStatements>
																																														<methodInvokeExpression methodName="AppendFormat">
																																															<target>
																																																<variableReferenceExpression name="sb"/>
																																															</target>
																																															<parameters>
																																																<primitiveExpression value="({{0}} is not null)and"/>
																																																<variableReferenceExpression name="fieldNameExpression"/>
																																															</parameters>
																																														</methodInvokeExpression>
																																													</trueStatements>
																																												</conditionStatement>
																																												<methodInvokeExpression methodName="AppendFormat">
																																													<target>
																																														<variableReferenceExpression name="sb"/>
																																													</target>
																																													<parameters>
																																														<primitiveExpression value="({{0}} {{2}} {{1}})"/>
																																														<variableReferenceExpression name="fieldNameExpression"/>
																																														<propertyReferenceExpression name="ParameterName">
																																															<variableReferenceExpression name="parameter"/>
																																														</propertyReferenceExpression>
																																														<variableReferenceExpression name="comparisonOperator"/>
																																													</parameters>
																																												</methodInvokeExpression>
																																											</trueStatements>
																																											<falseStatements>
																																												<conditionStatement>
																																													<condition>
																																														<variableReferenceExpression name="skipLike"/>
																																													</condition>
																																													<trueStatements>
																																														<methodInvokeExpression methodName="Append">
																																															<target>
																																																<variableReferenceExpression name="sb"/>
																																															</target>
																																															<parameters>
																																																<primitiveExpression value="1=0"/>
																																															</parameters>
																																														</methodInvokeExpression>
																																													</trueStatements>
																																													<falseStatements>
																																														<conditionStatement>
																																															<condition>
																																																<variableReferenceExpression name="negativeFlag"/>
																																															</condition>
																																															<trueStatements>
																																																<methodInvokeExpression methodName="AppendFormat">
																																																	<target>
																																																		<variableReferenceExpression name="sb"/>
																																																	</target>
																																																	<parameters>
																																																		<primitiveExpression value="({{0}} is not null)and"/>
																																																		<arrayIndexerExpression>
																																																			<target>
																																																				<argumentReferenceExpression name="expressions"/>
																																																			</target>
																																																			<indices>
																																																				<methodInvokeExpression methodName="ExpressionName">
																																																					<target>
																																																						<variableReferenceExpression name="tf"/>
																																																					</target>
																																																				</methodInvokeExpression>
																																																			</indices>
																																																		</arrayIndexerExpression>
																																																	</parameters>
																																																</methodInvokeExpression>
																																															</trueStatements>
																																														</conditionStatement>
																																														<conditionStatement>
																																															<condition>
																																																<methodInvokeExpression methodName="DatabaseEngineIs">
																																																	<parameters>
																																																		<argumentReferenceExpression name="command"/>
																																																		<primitiveExpression value="Oracle"/>
																																																		<primitiveExpression value="DB2"/>
																																																		<primitiveExpression value="Firebird"/>
																																																	</parameters>
																																																</methodInvokeExpression>
																																															</condition>
																																															<trueStatements>
																																																<methodInvokeExpression methodName="AppendFormat">
																																																	<target>
																																																		<argumentReferenceExpression name="sb"/>
																																																	</target>
																																																	<parameters>
																																																		<primitiveExpression value="(upper({{0}}) {{2}} {{1}})"/>
																																																		<arrayIndexerExpression>
																																																			<target>
																																																				<argumentReferenceExpression name="expressions"/>
																																																			</target>
																																																			<indices>
																																																				<methodInvokeExpression methodName="ExpressionName">
																																																					<target>
																																																						<variableReferenceExpression name="tf"/>
																																																					</target>
																																																				</methodInvokeExpression>
																																																			</indices>
																																																		</arrayIndexerExpression>
																																																		<propertyReferenceExpression name="ParameterName">
																																																			<variableReferenceExpression name="parameter"/>
																																																		</propertyReferenceExpression>
																																																		<variableReferenceExpression name="comparisonOperator"/>
																																																	</parameters>
																																																</methodInvokeExpression>
																																																<assignStatement>
																																																	<propertyReferenceExpression name="Value">
																																																		<variableReferenceExpression name="parameter"/>
																																																	</propertyReferenceExpression>
																																																	<methodInvokeExpression methodName="ToUpper">
																																																		<target>
																																																			<methodInvokeExpression methodName="ToString">
																																																				<target>
																																																					<typeReferenceExpression type="Convert"/>
																																																				</target>
																																																				<parameters>
																																																					<propertyReferenceExpression name="Value">
																																																						<variableReferenceExpression name="parameter"/>
																																																					</propertyReferenceExpression>
																																																				</parameters>
																																																			</methodInvokeExpression>
																																																		</target>
																																																	</methodInvokeExpression>
																																																</assignStatement>
																																															</trueStatements>
																																															<falseStatements>
																																																<methodInvokeExpression methodName="AppendFormat">
																																																	<target>
																																																		<argumentReferenceExpression name="sb"/>
																																																	</target>
																																																	<parameters>
																																																		<primitiveExpression value="({{0}} {{2}} {{1}})"/>
																																																		<arrayIndexerExpression>
																																																			<target>
																																																				<argumentReferenceExpression name="expressions"/>
																																																			</target>
																																																			<indices>
																																																				<methodInvokeExpression methodName="ExpressionName">
																																																					<target>
																																																						<variableReferenceExpression name="tf"/>
																																																					</target>
																																																				</methodInvokeExpression>
																																																			</indices>
																																																		</arrayIndexerExpression>
																																																		<propertyReferenceExpression name="ParameterName">
																																																			<variableReferenceExpression name="parameter"/>
																																																		</propertyReferenceExpression>
																																																		<variableReferenceExpression name="comparisonOperator"/>
																																																	</parameters>
																																																</methodInvokeExpression>
																																															</falseStatements>
																																														</conditionStatement>
																																													</falseStatements>
																																												</conditionStatement>
																																											</falseStatements>
																																										</conditionStatement>
																																									</falseStatements>
																																								</conditionStatement>
																																							</trueStatements>
																																						</conditionStatement>
																																						<conditionStatement>
																																							<condition>
																																								<binaryOperatorExpression operator="IdentityInequality">
																																									<variableReferenceExpression name="originalParameter"/>
																																									<primitiveExpression value="null"/>
																																								</binaryOperatorExpression>
																																							</condition>
																																							<trueStatements>
																																								<assignStatement>
																																									<variableReferenceExpression name="parameter"/>
																																									<variableReferenceExpression name="originalParameter"/>
																																								</assignStatement>
																																								<assignStatement>
																																									<variableReferenceExpression name="originalParameter"/>
																																									<primitiveExpression value="null"/>
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
																														</foreachStatement>
																													</trueStatements>
																												</conditionStatement>
																												<conditionStatement>
																													<condition>
																														<binaryOperatorExpression operator="BooleanAnd">
																															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																																<variableReferenceExpression name="quickFindHint"/>
																															</unaryOperatorExpression>
																															<methodInvokeExpression methodName="Contains">
																																<target>
																																	<variableReferenceExpression name="quickFindHint"/>
																																</target>
																																<parameters>
																																	<primitiveExpression value=";"/>
																																</parameters>
																															</methodInvokeExpression>
																														</binaryOperatorExpression>
																													</condition>
																													<trueStatements>
																														<methodInvokeExpression methodName="AppendLine">
																															<target>
																																<variableReferenceExpression name="sb"/>
																															</target>
																														</methodInvokeExpression>
																														<conditionStatement>
																															<condition>
																																<variableReferenceExpression name="hasTests"/>
																															</condition>
																															<trueStatements>
																																<methodInvokeExpression methodName="AppendLine">
																																	<target>
																																		<argumentReferenceExpression name="sb"/>
																																	</target>
																																	<parameters>
																																		<primitiveExpression value="or"/>
																																	</parameters>
																																</methodInvokeExpression>
																															</trueStatements>
																															<falseStatements>
																																<assignStatement>
																																	<variableReferenceExpression name="hasTests"/>
																																	<primitiveExpression value="true"/>
																																</assignStatement>
																															</falseStatements>
																														</conditionStatement>
																														<methodInvokeExpression methodName="AppendLine">
																															<target>
																																<argumentReferenceExpression name="sb"/>
																															</target>
																															<parameters>
																																<primitiveExpression value="("/>
																															</parameters>
																														</methodInvokeExpression>
																														<variableDeclarationStatement type="System.Boolean" name="firstHint">
																															<init>
																																<primitiveExpression value="true"/>
																															</init>
																														</variableDeclarationStatement>
																														<foreachStatement>
																															<variable type="System.String" name="hint"/>
																															<target>
																																<methodInvokeExpression methodName="Split">
																																	<target>
																																		<methodInvokeExpression methodName="Substring">
																																			<target>
																																				<variableReferenceExpression name="quickFindHint"/>
																																			</target>
																																			<parameters>
																																				<binaryOperatorExpression operator="Add">
																																					<methodInvokeExpression methodName="IndexOf">
																																						<target>
																																							<variableReferenceExpression name="quickFindHint"/>
																																						</target>
																																						<parameters>
																																							<primitiveExpression value=";" convertTo="Char"/>
																																						</parameters>
																																					</methodInvokeExpression>
																																					<primitiveExpression value="1"/>
																																				</binaryOperatorExpression>
																																			</parameters>
																																		</methodInvokeExpression>
																																	</target>
																																	<parameters>
																																		<arrayCreateExpression>
																																			<createType type="System.Char"/>
																																			<initializers>
																																				<primitiveExpression value=";" convertTo="Char"/>
																																			</initializers>
																																		</arrayCreateExpression>
																																	</parameters>
																																</methodInvokeExpression>
																															</target>
																															<statements>
																																<conditionStatement>
																																	<condition>
																																		<variableReferenceExpression name="firstHint"/>
																																	</condition>
																																	<trueStatements>
																																		<assignStatement>
																																			<variableReferenceExpression name="firstHint"/>
																																			<primitiveExpression value="false"/>
																																		</assignStatement>
																																	</trueStatements>
																																	<falseStatements>
																																		<methodInvokeExpression methodName="AppendLine">
																																			<target>
																																				<argumentReferenceExpression name="sb"/>
																																			</target>
																																		</methodInvokeExpression>
																																		<methodInvokeExpression methodName="AppendLine">
																																			<target>
																																				<argumentReferenceExpression name="sb"/>
																																			</target>
																																			<parameters>
																																				<primitiveExpression value="or"/>
																																			</parameters>
																																		</methodInvokeExpression>
																																	</falseStatements>
																																</conditionStatement>
																																<methodInvokeExpression methodName="AppendLine">
																																	<target>
																																		<argumentReferenceExpression name="sb"/>
																																	</target>
																																	<parameters>
																																		<primitiveExpression value="("/>
																																	</parameters>
																																</methodInvokeExpression>
																																<variableDeclarationStatement type="System.String" name="newFilterExpression">
																																	<init>
																																		<variableReferenceExpression name="filterExpression"/>
																																	</init>
																																</variableDeclarationStatement>
																																<variableDeclarationStatement type="StringBuilder" name="reversedFilterExpression">
																																	<init>
																																		<objectCreateExpression type="StringBuilder"/>
																																	</init>
																																</variableDeclarationStatement>
																																<conditionStatement>
																																	<condition>
																																		<variableReferenceExpression name="negativeFlag"/>
																																	</condition>
																																	<trueStatements>
																																		<variableDeclarationStatement type="System.Boolean" name="firstExpressionPhrase">
																																			<init>
																																				<primitiveExpression value="true"/>
																																			</init>
																																		</variableDeclarationStatement>
																																		<foreachStatement>
																																			<variable type="List" name="ph">
																																				<typeArguments>
																																					<typeReference type="System.String"/>
																																				</typeArguments>
																																			</variable>
																																			<target>
																																				<variableReferenceExpression name="phrases"/>
																																			</target>
																																			<statements>
																																				<conditionStatement>
																																					<condition>
																																						<variableReferenceExpression name="firstExpressionPhrase"/>
																																					</condition>
																																					<trueStatements>
																																						<assignStatement>
																																							<variableReferenceExpression name="firstExpressionPhrase"/>
																																							<primitiveExpression value="false"/>
																																						</assignStatement>
																																					</trueStatements>
																																					<falseStatements>
																																						<methodInvokeExpression methodName="Append">
																																							<target>
																																								<variableReferenceExpression name="reversedFilterExpression"/>
																																							</target>
																																							<parameters>
																																								<primitiveExpression value=","/>
																																							</parameters>
																																						</methodInvokeExpression>
																																					</falseStatements>
																																				</conditionStatement>
																																				<variableDeclarationStatement type="System.Boolean" name="firstExpressionWord">
																																					<init>
																																						<primitiveExpression value="true"/>
																																					</init>
																																				</variableDeclarationStatement>
																																				<foreachStatement>
																																					<variable type="System.String" name="w"/>
																																					<target>
																																						<variableReferenceExpression name="ph"/>
																																					</target>
																																					<statements>
																																						<conditionStatement>
																																							<condition>
																																								<variableReferenceExpression name="firstExpressionWord"/>
																																							</condition>
																																							<trueStatements>
																																								<assignStatement>
																																									<variableReferenceExpression name="firstExpressionWord"/>
																																									<primitiveExpression value="false"/>
																																								</assignStatement>
																																							</trueStatements>
																																							<falseStatements>
																																								<methodInvokeExpression methodName="Append">
																																									<target>
																																										<variableReferenceExpression name="reversedFilterExpression"/>
																																									</target>
																																									<parameters>
																																										<primitiveExpression value=" "/>
																																									</parameters>
																																								</methodInvokeExpression>
																																							</falseStatements>
																																						</conditionStatement>
																																						<conditionStatement>
																																							<condition>
																																								<binaryOperatorExpression operator="ValueInequality">
																																									<arrayIndexerExpression>
																																										<target>
																																											<variableReferenceExpression name="w"/>
																																										</target>
																																										<indices>
																																											<primitiveExpression value="0"/>
																																										</indices>
																																									</arrayIndexerExpression>
																																									<primitiveExpression value="-" convertTo="Char"/>
																																								</binaryOperatorExpression>
																																							</condition>
																																							<trueStatements>
																																								<methodInvokeExpression methodName="Append">
																																									<target>
																																										<variableReferenceExpression name="reversedFilterExpression"/>
																																									</target>
																																									<parameters>
																																										<primitiveExpression value="-"/>
																																									</parameters>
																																								</methodInvokeExpression>
																																							</trueStatements>
																																						</conditionStatement>
																																						<conditionStatement>
																																							<condition>
																																								<binaryOperatorExpression operator="ValueEquality">
																																									<arrayIndexerExpression>
																																										<target>
																																											<variableReferenceExpression name="w"/>
																																										</target>
																																										<indices>
																																											<primitiveExpression value="1"/>
																																										</indices>
																																									</arrayIndexerExpression>
																																									<primitiveExpression value="=" convertTo="Char"/>
																																								</binaryOperatorExpression>
																																							</condition>
																																							<trueStatements>
																																								<methodInvokeExpression methodName="Append">
																																									<target>
																																										<variableReferenceExpression name="reversedFilterExpression"/>
																																									</target>
																																									<parameters>
																																										<primitiveExpression value="&quot;"/>
																																									</parameters>
																																								</methodInvokeExpression>
																																							</trueStatements>
																																						</conditionStatement>
																																						<methodInvokeExpression methodName="Append">
																																							<target>
																																								<variableReferenceExpression name="reversedFilterExpression"/>
																																							</target>
																																							<parameters>
																																								<methodInvokeExpression methodName="Substring">
																																									<target>
																																										<variableReferenceExpression name="w"/>
																																									</target>
																																									<parameters>
																																										<primitiveExpression value="2"/>
																																									</parameters>
																																								</methodInvokeExpression>
																																							</parameters>
																																						</methodInvokeExpression>
																																						<conditionStatement>
																																							<condition>
																																								<binaryOperatorExpression operator="ValueEquality">
																																									<arrayIndexerExpression>
																																										<target>
																																											<variableReferenceExpression name="w"/>
																																										</target>
																																										<indices>
																																											<primitiveExpression value="1"/>
																																										</indices>
																																									</arrayIndexerExpression>
																																									<primitiveExpression value="=" convertTo="Char"/>
																																								</binaryOperatorExpression>
																																							</condition>
																																							<trueStatements>
																																								<methodInvokeExpression methodName="Append">
																																									<target>
																																										<variableReferenceExpression name="reversedFilterExpression"/>
																																									</target>
																																									<parameters>
																																										<primitiveExpression value="&quot;"/>
																																									</parameters>
																																								</methodInvokeExpression>
																																							</trueStatements>
																																						</conditionStatement>
																																					</statements>
																																				</foreachStatement>
																																			</statements>
																																		</foreachStatement>
																																		<assignStatement>
																																			<variableReferenceExpression name="newFilterExpression"/>
																																			<binaryOperatorExpression operator="Add">
																																				<primitiveExpression value="_quickfind_:~"/>
																																				<methodInvokeExpression methodName="ValueToString">
																																					<parameters>
																																						<methodInvokeExpression methodName="ToString">
																																							<target>
																																								<variableReferenceExpression name="reversedFilterExpression"/>
																																							</target>
																																						</methodInvokeExpression>
																																					</parameters>
																																				</methodInvokeExpression>
																																			</binaryOperatorExpression>
																																		</assignStatement>
																																	</trueStatements>
																																</conditionStatement>
																																<methodInvokeExpression methodName="AppendDeepFilter">
																																	<parameters>
																																		<variableReferenceExpression name="hint"/>
																																		<argumentReferenceExpression name="page"/>
																																		<argumentReferenceExpression name="command"/>
																																		<argumentReferenceExpression name="sb"/>
																																		<variableReferenceExpression name="newFilterExpression"/>
																																	</parameters>
																																</methodInvokeExpression>
																																<methodInvokeExpression methodName="AppendLine">
																																	<target>
																																		<argumentReferenceExpression name="sb"/>
																																	</target>
																																	<parameters>
																																		<primitiveExpression value=")"/>
																																	</parameters>
																																</methodInvokeExpression>
																															</statements>
																														</foreachStatement>
																														<methodInvokeExpression methodName="AppendLine">
																															<target>
																																<argumentReferenceExpression name="sb"/>
																															</target>
																															<parameters>
																																<primitiveExpression value=")"/>
																															</parameters>
																														</methodInvokeExpression>
																													</trueStatements>
																												</conditionStatement>
																												<conditionStatement>
																													<condition>
																														<unaryOperatorExpression operator="Not">
																															<variableReferenceExpression name="hasTests"/>
																														</unaryOperatorExpression>
																													</condition>
																													<trueStatements>
																														<conditionStatement>
																															<condition>
																																<binaryOperatorExpression operator="BooleanAnd">
																																	<variableReferenceExpression name="negativeFlag"/>
																																	<methodInvokeExpression methodName="StartsWith">
																																		<target>
																																			<variableReferenceExpression name="quickFindHint"/>
																																		</target>
																																		<parameters>
																																			<primitiveExpression value=";"/>
																																		</parameters>
																																	</methodInvokeExpression>
																																</binaryOperatorExpression>
																															</condition>
																															<trueStatements>
																																<methodInvokeExpression methodName="Append">
																																	<target>
																																		<variableReferenceExpression name="sb"/>
																																	</target>
																																	<parameters>
																																		<primitiveExpression value="1=1"/>
																																	</parameters>
																																</methodInvokeExpression>
																															</trueStatements>
																															<falseStatements>
																																<methodInvokeExpression methodName="Append">
																																	<target>
																																		<variableReferenceExpression name="sb"/>
																																	</target>
																																	<parameters>
																																		<primitiveExpression value="1=0"/>
																																	</parameters>
																																</methodInvokeExpression>
																															</falseStatements>
																														</conditionStatement>
																													</trueStatements>
																												</conditionStatement>
																												<methodInvokeExpression methodName="Append">
																													<target>
																														<variableReferenceExpression name="sb"/>
																													</target>
																													<parameters>
																														<primitiveExpression value=")"/>
																													</parameters>
																												</methodInvokeExpression>
																											</statements>
																										</foreachStatement>
																										<!-- end of "or" processing for quick find-->
																										<methodInvokeExpression methodName="AppendLine">
																											<target>
																												<variableReferenceExpression name="sb"/>
																											</target>
																											<parameters>
																												<primitiveExpression value=")"/>
																											</parameters>
																										</methodInvokeExpression>
																									</trueStatements>
																								</conditionStatement>
																							</statements>
																						</foreachStatement>
																						<conditionStatement>
																							<condition>
																								<variableReferenceExpression name="firstPhrase"/>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="Append">
																									<target>
																										<argumentReferenceExpression name="sb"/>
																									</target>
																									<parameters>
																										<primitiveExpression value="1=1"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																					</trueStatements>
																					<falseStatements>
																						<conditionStatement>
																							<condition>
																								<methodInvokeExpression methodName="StartsWith">
																									<target>
																										<variableReferenceExpression name="operation"/>
																									</target>
																									<parameters>
																										<primitiveExpression value="$"/>
																									</parameters>
																								</methodInvokeExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="Append">
																									<target>
																										<variableReferenceExpression name="sb"/>
																									</target>
																									<parameters>
																										<methodInvokeExpression methodName="Replace">
																											<target>
																												<typeReferenceExpression type="FilterFunctions"/>
																											</target>
																											<parameters>
																												<argumentReferenceExpression name="command"/>
																												<argumentReferenceExpression name="expressions"/>
																												<stringFormatExpression format="{{0}}({{1}}$comma${{2}})">
																													<methodInvokeExpression methodName="TrimEnd">
																														<target>
																															<variableReferenceExpression name="operation"/>
																														</target>
																														<parameters>
																															<primitiveExpression value="$" convertTo="Char"/>
																														</parameters>
																													</methodInvokeExpression>
																													<variableReferenceExpression name="fieldAlias"/>
																													<methodInvokeExpression methodName="ToBase64String">
																														<target>
																															<typeReferenceExpression type="Convert"/>
																														</target>
																														<parameters>
																															<methodInvokeExpression methodName="GetBytes">
																																<target>
																																	<propertyReferenceExpression name="UTF8">
																																		<typeReferenceExpression type="Encoding"/>
																																	</propertyReferenceExpression>
																																</target>
																																<parameters>
																																	<variableReferenceExpression name="paramValue"/>
																																</parameters>
																															</methodInvokeExpression>
																														</parameters>
																													</methodInvokeExpression>
																												</stringFormatExpression>
																											</parameters>
																										</methodInvokeExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																							<falseStatements>
																								<variableDeclarationStatement type="DbParameter" name="parameter">
																									<init>
																										<methodInvokeExpression methodName="CreateParameter">
																											<target>
																												<argumentReferenceExpression name="command"/>
																											</target>
																										</methodInvokeExpression>
																									</init>
																								</variableDeclarationStatement>
																								<assignStatement>
																									<propertyReferenceExpression name="ParameterName">
																										<variableReferenceExpression name="parameter"/>
																									</propertyReferenceExpression>
																									<stringFormatExpression format="{{0}}p{{1}}">
																										<fieldReferenceExpression name="parameterMarker"/>
																										<propertyReferenceExpression name="Count">
																											<propertyReferenceExpression name="Parameters">
																												<argumentReferenceExpression name="command"/>
																											</propertyReferenceExpression>
																										</propertyReferenceExpression>
																									</stringFormatExpression>
																								</assignStatement>
																								<methodInvokeExpression methodName="AssignParameterDbType">
																									<parameters>
																										<variableReferenceExpression name="parameter"/>
																										<propertyReferenceExpression name="Type">
																											<variableReferenceExpression name="field"/>
																										</propertyReferenceExpression>
																									</parameters>
																								</methodInvokeExpression>
																								<methodInvokeExpression methodName="Append">
																									<target>
																										<argumentReferenceExpression name="sb"/>
																									</target>
																									<parameters>
																										<arrayIndexerExpression>
																											<target>
																												<argumentReferenceExpression name="expressions"/>
																											</target>
																											<indices>
																												<methodInvokeExpression methodName="ExpressionName">
																													<target>
																														<variableReferenceExpression name="field"/>
																													</target>
																												</methodInvokeExpression>
																											</indices>
																										</arrayIndexerExpression>
																									</parameters>
																								</methodInvokeExpression>
																								<variableDeclarationStatement type="System.Boolean" name="requiresRangeAdjustment">
																									<init>
																										<binaryOperatorExpression operator="BooleanAnd">
																											<binaryOperatorExpression operator="ValueEquality">
																												<variableReferenceExpression name="operation"/>
																												<primitiveExpression value="="/>
																											</binaryOperatorExpression>
																											<binaryOperatorExpression operator="BooleanAnd">
																												<methodInvokeExpression methodName="StartsWith">
																													<target>
																														<propertyReferenceExpression name="Type">
																															<variableReferenceExpression name="field"/>
																														</propertyReferenceExpression>
																													</target>
																													<parameters>
																														<primitiveExpression value="DateTime"/>
																													</parameters>
																												</methodInvokeExpression>
																												<unaryOperatorExpression operator="Not">
																													<methodInvokeExpression methodName="StringIsNull">
																														<parameters>
																															<variableReferenceExpression name="paramValue"/>
																														</parameters>
																													</methodInvokeExpression>
																												</unaryOperatorExpression>
																												<!--<binaryOperatorExpression operator="ValueInequality">
                                                      <variableReferenceExpression name="paramValue"/>
                                                      <primitiveExpression value="null" convertTo="String"/>
                                                    </binaryOperatorExpression>-->
																											</binaryOperatorExpression>
																										</binaryOperatorExpression>
																									</init>
																								</variableDeclarationStatement>
																								<conditionStatement>
																									<condition>
																										<binaryOperatorExpression operator="BooleanAnd">
																											<binaryOperatorExpression operator="ValueEquality">
																												<variableReferenceExpression name="operation"/>
																												<primitiveExpression value="&lt;>"/>
																											</binaryOperatorExpression>
																											<methodInvokeExpression methodName="StringIsNull">
																												<parameters>
																													<variableReferenceExpression name="paramValue"/>
																												</parameters>
																											</methodInvokeExpression>
																										</binaryOperatorExpression>
																									</condition>
																									<trueStatements>
																										<methodInvokeExpression methodName="Append">
																											<target>
																												<argumentReferenceExpression name="sb"/>
																											</target>
																											<parameters>
																												<primitiveExpression value=" is not null "/>
																											</parameters>
																										</methodInvokeExpression>
																									</trueStatements>
																									<falseStatements>
																										<conditionStatement>
																											<condition>
																												<binaryOperatorExpression operator="BooleanAnd">
																													<binaryOperatorExpression operator="ValueEquality">
																														<variableReferenceExpression name="operation"/>
																														<primitiveExpression value="="/>
																													</binaryOperatorExpression>
																													<methodInvokeExpression methodName="StringIsNull">
																														<parameters>
																															<variableReferenceExpression name="paramValue"/>
																														</parameters>
																													</methodInvokeExpression>
																												</binaryOperatorExpression>
																											</condition>
																											<trueStatements>
																												<methodInvokeExpression methodName="Append">
																													<target>
																														<argumentReferenceExpression name="sb"/>
																													</target>
																													<parameters>
																														<primitiveExpression value=" is null "/>
																													</parameters>
																												</methodInvokeExpression>
																											</trueStatements>
																											<falseStatements>
																												<conditionStatement>
																													<condition>
																														<binaryOperatorExpression operator="ValueEquality">
																															<variableReferenceExpression name="operation"/>
																															<primitiveExpression value="*"/>
																														</binaryOperatorExpression>
																													</condition>
																													<trueStatements>
																														<methodInvokeExpression methodName="Append">
																															<target>
																																<argumentReferenceExpression name="sb"/>
																															</target>
																															<parameters>
																																<primitiveExpression value=" like "/>
																															</parameters>
																														</methodInvokeExpression>
																														<assignStatement>
																															<propertyReferenceExpression name="DbType">
																																<variableReferenceExpression name="parameter"/>
																															</propertyReferenceExpression>
																															<propertyReferenceExpression name="String">
																																<typeReferenceExpression type="DbType"/>
																															</propertyReferenceExpression>
																														</assignStatement>
																														<conditionStatement>
																															<condition>
																																<unaryOperatorExpression operator="Not">
																																	<methodInvokeExpression methodName="Contains">
																																		<target>
																																			<variableReferenceExpression name="paramValue"/>
																																		</target>
																																		<parameters>
																																			<primitiveExpression value="%"/>
																																		</parameters>
																																	</methodInvokeExpression>
																																</unaryOperatorExpression>
																															</condition>
																															<trueStatements>
																																<assignStatement>
																																	<variableReferenceExpression name="paramValue"/>
																																	<binaryOperatorExpression operator="Add">
																																		<methodInvokeExpression methodName="EscapePattern">
																																			<target>
																																				<typeReferenceExpression type="SqlStatement"/>
																																			</target>
																																			<parameters>
																																				<argumentReferenceExpression name="command"/>
																																				<variableReferenceExpression name="paramValue"/>
																																			</parameters>
																																		</methodInvokeExpression>
																																		<primitiveExpression value="%"/>
																																	</binaryOperatorExpression>
																																</assignStatement>
																															</trueStatements>
																														</conditionStatement>
																													</trueStatements>
																													<falseStatements>
																														<conditionStatement>
																															<condition>
																																<variableReferenceExpression name="requiresRangeAdjustment"/>
																															</condition>
																															<trueStatements>
																																<methodInvokeExpression methodName="Append">
																																	<target>
																																		<argumentReferenceExpression name="sb"/>
																																	</target>
																																	<parameters>
																																		<primitiveExpression value=">="/>
																																	</parameters>
																																</methodInvokeExpression>
																															</trueStatements>
																															<falseStatements>
																																<methodInvokeExpression methodName="Append">
																																	<target>
																																		<argumentReferenceExpression name="sb"/>
																																	</target>
																																	<parameters>
																																		<variableReferenceExpression name="operation"/>
																																	</parameters>
																																</methodInvokeExpression>
																															</falseStatements>
																														</conditionStatement>
																													</falseStatements>
																												</conditionStatement>
																												<tryStatement>
																													<statements>
																														<assignStatement>
																															<propertyReferenceExpression name="Value">
																																<variableReferenceExpression name="parameter"/>
																															</propertyReferenceExpression>
																															<methodInvokeExpression methodName="StringToValue">
																																<parameters>
																																	<variableReferenceExpression name="field"/>
																																	<variableReferenceExpression name="paramValue"/>
																																</parameters>
																															</methodInvokeExpression>
																														</assignStatement>
																														<conditionStatement>
																															<condition>
																																<binaryOperatorExpression operator="BooleanAnd">
																																	<binaryOperatorExpression operator="ValueEquality">
																																		<propertyReferenceExpression name="DbType">
																																			<variableReferenceExpression name="parameter"/>
																																		</propertyReferenceExpression>
																																		<propertyReferenceExpression name="Binary">
																																			<typeReferenceExpression type="DbType"/>
																																		</propertyReferenceExpression>
																																	</binaryOperatorExpression>
																																	<binaryOperatorExpression operator="IsTypeOf">
																																		<propertyReferenceExpression name="Value">
																																			<variableReferenceExpression name="parameter"/>
																																		</propertyReferenceExpression>
																																		<typeReferenceExpression type="Guid"/>
																																	</binaryOperatorExpression>
																																</binaryOperatorExpression>
																															</condition>
																															<trueStatements>
																																<assignStatement>
																																	<propertyReferenceExpression name="Value">
																																		<variableReferenceExpression name="parameter"/>
																																	</propertyReferenceExpression>
																																	<methodInvokeExpression methodName="ToByteArray">
																																		<target>
																																			<castExpression targetType="Guid">
																																				<propertyReferenceExpression name="Value">
																																					<variableReferenceExpression name="parameter"/>
																																				</propertyReferenceExpression>
																																			</castExpression>
																																		</target>
																																	</methodInvokeExpression>
																																</assignStatement>
																															</trueStatements>
																														</conditionStatement>
																													</statements>
																													<catch exceptionType="Exception">
																														<assignStatement>
																															<propertyReferenceExpression name="Value">
																																<variableReferenceExpression name="parameter"/>
																															</propertyReferenceExpression>
																															<propertyReferenceExpression name="Value">
																																<typeReferenceExpression type="DBNull"/>
																															</propertyReferenceExpression>
																														</assignStatement>
																													</catch>
																												</tryStatement>
																												<methodInvokeExpression methodName="Append">
																													<target>
																														<argumentReferenceExpression name="sb"/>
																													</target>
																													<parameters>
																														<propertyReferenceExpression name="ParameterName">
																															<variableReferenceExpression name="parameter"/>
																														</propertyReferenceExpression>
																													</parameters>
																												</methodInvokeExpression>
																												<methodInvokeExpression methodName="Add">
																													<target>
																														<propertyReferenceExpression name="Parameters">
																															<argumentReferenceExpression name="command"/>
																														</propertyReferenceExpression>
																													</target>
																													<parameters>
																														<variableReferenceExpression name="parameter"/>
																													</parameters>
																												</methodInvokeExpression>
																												<conditionStatement>
																													<condition>
																														<variableReferenceExpression name="requiresRangeAdjustment"/>
																													</condition>
																													<trueStatements>
																														<variableDeclarationStatement type="DbParameter" name="rangeParameter">
																															<init>
																																<methodInvokeExpression methodName="CreateParameter">
																																	<target>
																																		<argumentReferenceExpression name="command"/>
																																	</target>
																																</methodInvokeExpression>
																															</init>
																														</variableDeclarationStatement>
																														<methodInvokeExpression methodName="AssignParameterDbType">
																															<parameters>
																																<variableReferenceExpression name="rangeParameter"/>
																																<propertyReferenceExpression name="Type">
																																	<variableReferenceExpression name="field"/>
																																</propertyReferenceExpression>
																															</parameters>
																														</methodInvokeExpression>
																														<assignStatement>
																															<propertyReferenceExpression name="ParameterName">
																																<variableReferenceExpression name="rangeParameter"/>
																															</propertyReferenceExpression>
																															<stringFormatExpression format="{{0}}p{{1}}">
																																<fieldReferenceExpression name="parameterMarker"/>
																																<propertyReferenceExpression name="Count">
																																	<propertyReferenceExpression name="Parameters">
																																		<argumentReferenceExpression name="command"/>
																																	</propertyReferenceExpression>
																																</propertyReferenceExpression>
																															</stringFormatExpression>
																														</assignStatement>
																														<methodInvokeExpression methodName="Append">
																															<target>
																																<argumentReferenceExpression name="sb"/>
																															</target>
																															<parameters>
																																<stringFormatExpression format=" and {{0}} &lt; {{1}}">
																																	<arrayIndexerExpression>
																																		<target>
																																			<argumentReferenceExpression name="expressions"/>
																																		</target>
																																		<indices>
																																			<methodInvokeExpression methodName="ExpressionName">
																																				<target>
																																					<variableReferenceExpression name="field"/>
																																				</target>
																																			</methodInvokeExpression>
																																		</indices>
																																	</arrayIndexerExpression>
																																	<propertyReferenceExpression name="ParameterName">
																																		<variableReferenceExpression name="rangeParameter"/>
																																	</propertyReferenceExpression>
																																</stringFormatExpression>
																															</parameters>
																														</methodInvokeExpression>
																														<conditionStatement>
																															<condition>
																																<binaryOperatorExpression operator="ValueEquality">
																																	<propertyReferenceExpression name="Type">
																																		<variableReferenceExpression name="field"/>
																																	</propertyReferenceExpression>
																																	<primitiveExpression value="DateTimeOffset"/>
																																</binaryOperatorExpression>
																															</condition>
																															<trueStatements>
																																<variableDeclarationStatement type="DateTime" name="dt">
																																	<init>
																																		<methodInvokeExpression methodName="ToDateTime">
																																			<target>
																																				<typeReferenceExpression type="Convert"/>
																																			</target>
																																			<parameters>
																																				<propertyReferenceExpression name="Value">
																																					<variableReferenceExpression name="parameter"/>
																																				</propertyReferenceExpression>
																																			</parameters>
																																		</methodInvokeExpression>
																																	</init>
																																</variableDeclarationStatement>
																																<assignStatement>
																																	<propertyReferenceExpression name="Value">
																																		<variableReferenceExpression name="parameter"/>
																																	</propertyReferenceExpression>
																																	<methodInvokeExpression methodName="AddHours">
																																		<target>
																																			<objectCreateExpression type="DateTimeOffset">
																																				<parameters>
																																					<variableReferenceExpression name="dt"/>
																																				</parameters>
																																			</objectCreateExpression>
																																		</target>
																																		<parameters>
																																			<primitiveExpression value="-14"/>
																																		</parameters>
																																	</methodInvokeExpression>
																																</assignStatement>
																																<assignStatement>
																																	<propertyReferenceExpression name="Value">
																																		<variableReferenceExpression name="rangeParameter"/>
																																	</propertyReferenceExpression>
																																	<methodInvokeExpression methodName="AddHours">
																																		<target>
																																			<methodInvokeExpression methodName="AddDays">
																																				<target>
																																					<objectCreateExpression type="DateTimeOffset">
																																						<parameters>
																																							<variableReferenceExpression name="dt"/>
																																						</parameters>
																																					</objectCreateExpression>
																																				</target>
																																				<parameters>
																																					<primitiveExpression value="1"/>
																																				</parameters>
																																			</methodInvokeExpression>
																																		</target>
																																		<parameters>
																																			<primitiveExpression value="14"/>
																																		</parameters>
																																	</methodInvokeExpression>
																																</assignStatement>
																															</trueStatements>
																															<falseStatements>
																																<assignStatement>
																																	<propertyReferenceExpression name="Value">
																																		<variableReferenceExpression name="rangeParameter"/>
																																	</propertyReferenceExpression>
																																	<methodInvokeExpression methodName="AddDays">
																																		<target>
																																			<methodInvokeExpression methodName="ToDateTime">
																																				<target>
																																					<typeReferenceExpression type="Convert"/>
																																				</target>
																																				<parameters>
																																					<propertyReferenceExpression name="Value">
																																						<variableReferenceExpression name="parameter"/>
																																					</propertyReferenceExpression>
																																				</parameters>
																																			</methodInvokeExpression>
																																		</target>
																																		<parameters>
																																			<primitiveExpression value="1"/>
																																		</parameters>
																																	</methodInvokeExpression>
																																</assignStatement>
																															</falseStatements>
																														</conditionStatement>
																														<methodInvokeExpression methodName="Add">
																															<target>
																																<propertyReferenceExpression name="Parameters">
																																	<argumentReferenceExpression name="command"/>
																																</propertyReferenceExpression>
																															</target>
																															<parameters>
																																<variableReferenceExpression name="rangeParameter"/>
																															</parameters>
																														</methodInvokeExpression>
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
																			</falseStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
																<assignStatement>
																	<variableReferenceExpression name="valueMatch"/>
																	<methodInvokeExpression methodName="NextMatch">
																		<target>
																			<variableReferenceExpression name="valueMatch"/>
																		</target>
																	</methodInvokeExpression>
																</assignStatement>
															</statements>
														</whileStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<variableReferenceExpression name="firstValue"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="AppendLine">
																	<target>
																		<argumentReferenceExpression name="sb"/>
																	</target>
																	<parameters>
																		<primitiveExpression value=")"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<variableReferenceExpression name="matchListCount"/>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<!--<methodInvokeExpression methodName="AppendLine">
                      <target>
                        <argumentReferenceExpression name="sb"/>
                      </target>
                    </methodInvokeExpression>-->
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<argumentReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value=")"/>
											</parameters>
										</methodInvokeExpression>
										<comment>the end of the "match" list</comment>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<argumentReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value=")"/>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<variableReferenceExpression name="firstCriteria"/>
											<primitiveExpression value="true"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<variableReferenceExpression name="firstCriteria"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<argumentReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value=")"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="IsNullOrEmpty">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="whereClause"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Append">
													<target>
														<argumentReferenceExpression name="sb"/>
													</target>
													<parameters>
														<primitiveExpression value="and "/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="IsNullOrEmpty">
												<target>
													<typeReferenceExpression type="String"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="whereClause"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<variableReferenceExpression name="matchListCount"/>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Append">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<primitiveExpression value="and"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<argumentReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value="("/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="whereClause"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<argumentReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value=")"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="TrackAliases">
										<argumentReferenceExpression name="expressions"/>
									</propertyReferenceExpression>
									<primitiveExpression value="false"/>
								</assignStatement>
							</statements>
						</memberMethod>
						<!-- field NegativeFilterOperations -->
						<memberField type="System.String[]" name="NegativeFilterOperations">
							<attributes static="true" public="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<primitiveExpression value="$notin$"/>
										<primitiveExpression value="$doesnotequal$"/>
										<primitiveExpression value="&lt;>"/>
										<primitiveExpression value="$doesnotbegingwith$>"/>
										<primitiveExpression value="$doesnotcontain$>"/>
										<primitiveExpression value="$doesnotendwith$>"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- field ReverseNegativeFilterOperations -->
						<memberField type="System.String[]" name="ReverseNegativeFilterOperations">
							<attributes static="true" public="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<primitiveExpression value="$in$"/>
										<primitiveExpression value="$equals$"/>
										<primitiveExpression value="="/>
										<primitiveExpression value="$beginswith$>"/>
										<primitiveExpression value="$contains$>"/>
										<primitiveExpression value="$endswith$>"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- method AppendDeepFilter(string, ViewPage, DbCommand, StringBuilder, string) -->
						<memberMethod name="AppendDeepFilter">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="hint"/>
								<parameter type="ViewPage" name="page"/>
								<parameter type="DbCommand" name="command"/>
								<parameter type="StringBuilder" name="sb"/>
								<parameter type="System.String" name="filter"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String[]" name="hintInfo">
									<init>
										<methodInvokeExpression methodName="Split">
											<target>
												<argumentReferenceExpression name="hint"/>
											</target>
											<parameters>
												<arrayCreateExpression>
													<createType type="System.Char"/>
													<initializers>
														<primitiveExpression value="." convertTo="Char"/>
													</initializers>
												</arrayCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Int32" name="index">
									<init>
										<methodInvokeExpression methodName="IndexOf">
											<target>
												<argumentReferenceExpression name="filter"/>
											</target>
											<parameters>
												<primitiveExpression value=":"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="fieldData">
									<init>
										<methodInvokeExpression methodName="Substring">
											<target>
												<argumentReferenceExpression name="filter"/>
											</target>
											<parameters>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="index"/>
													<primitiveExpression value="1"/>
												</binaryOperatorExpression>
											</parameters>
										</methodInvokeExpression>
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
												<propertyReferenceExpression name="NegativeFilterOperations"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="i"/>
									</increment>
									<statements>
										<variableDeclarationStatement type="System.String" name="negativeOperation">
											<init>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="NegativeFilterOperations"/>
													</target>
													<indices>
														<variableReferenceExpression name="i"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="StartsWith">
													<target>
														<variableReferenceExpression name="fieldData"/>
													</target>
													<parameters>
														<variableReferenceExpression name="negativeOperation"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Append">
													<target>
														<argumentReferenceExpression name="sb"/>
													</target>
													<parameters>
														<primitiveExpression value="not "/>
													</parameters>
												</methodInvokeExpression>
												<assignStatement>
													<argumentReferenceExpression name="filter"/>
													<binaryOperatorExpression operator="Add">
														<methodInvokeExpression methodName="Substring">
															<target>
																<argumentReferenceExpression name="filter"/>
															</target>
															<parameters>
																<primitiveExpression value="0"/>
																<binaryOperatorExpression operator="Add">
																	<variableReferenceExpression name="index"/>
																	<primitiveExpression value="1"/>
																</binaryOperatorExpression>
															</parameters>
														</methodInvokeExpression>
														<binaryOperatorExpression operator="Add">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="ReverseNegativeFilterOperations"/>
																</target>
																<indices>
																	<variableReferenceExpression name="i"/>
																</indices>
															</arrayIndexerExpression>
															<methodInvokeExpression methodName="Substring">
																<target>
																	<argumentReferenceExpression name="filter"/>
																</target>
																<parameters>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="index"/>
																		<binaryOperatorExpression operator="Add">
																			<primitiveExpression value="1"/>
																			<propertyReferenceExpression name="Length">
																				<variableReferenceExpression name="negativeOperation"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</binaryOperatorExpression>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</assignStatement>
												<breakStatement/>
											</trueStatements>
										</conditionStatement>
									</statements>
								</forStatement>
								<methodInvokeExpression methodName="Append">
									<target>
										<argumentReferenceExpression name="sb"/>
									</target>
									<parameters>
										<primitiveExpression value="exists("/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="PageRequest" name="r">
									<init>
										<objectCreateExpression type="PageRequest"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Controller">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<arrayIndexerExpression>
										<target>
											<variableReferenceExpression name="hintInfo"/>
										</target>
										<indices>
											<primitiveExpression value="0"/>
										</indices>
									</arrayIndexerExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="View">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<arrayIndexerExpression>
										<target>
											<variableReferenceExpression name="hintInfo"/>
										</target>
										<indices>
											<primitiveExpression value="1"/>
										</indices>
									</arrayIndexerExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Filter">
										<variableReferenceExpression name="r"/>
									</propertyReferenceExpression>
									<arrayCreateExpression>
										<createType type="System.String"/>
										<initializers>
											<argumentReferenceExpression name="filter"/>
										</initializers>
									</arrayCreateExpression>
								</assignStatement>
								<variableDeclarationStatement type="DataControllerBase" name="controller">
									<init>
										<castExpression targetType="DataControllerBase">
											<methodInvokeExpression methodName="CreateDataController">
												<target>
													<typeReferenceExpression type="ControllerFactory"/>
												</target>
											</methodInvokeExpression>
										</castExpression>
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
												<assignStatement>
													<propertyReferenceExpression name="InnerJoinPrimaryKey">
														<variableReferenceExpression name="r"/>
													</propertyReferenceExpression>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="resultset__."/>
														<propertyReferenceExpression name="Name">
															<variableReferenceExpression name="field"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</assignStatement>
												<assignStatement>
													<propertyReferenceExpression name="InnerJoinForeignKey">
														<variableReferenceExpression name="r"/>
													</propertyReferenceExpression>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="hintInfo"/>
														</target>
														<indices>
															<primitiveExpression value="2"/>
														</indices>
													</arrayIndexerExpression>
												</assignStatement>
												<breakStatement/>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodInvokeExpression methodName="ConfigureSelectExistingCommand">
									<target>
										<variableReferenceExpression name="controller"/>
									</target>
									<parameters>
										<variableReferenceExpression name="r"/>
										<argumentReferenceExpression name="command"/>
										<argumentReferenceExpression name="sb"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Append">
									<target>
										<argumentReferenceExpression name="sb"/>
									</target>
									<parameters>
										<primitiveExpression value=")"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ConfigureSelectExistingCommand(PageRequest, DbCommand, StringBuilder) -->
						<memberMethod name="ConfigureSelectExistingCommand">
							<attributes family="true"/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="DbCommand" name="command"/>
								<parameter type="StringBuilder" name="sb"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="controller">
									<init>
										<propertyReferenceExpression name="Controller">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="view">
									<init>
										<propertyReferenceExpression name="View">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="SelectView">
									<parameters>
										<variableReferenceExpression name="controller"/>
										<variableReferenceExpression name="view"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="AssignContext">
									<target>
										<argumentReferenceExpression name="request"/>
									</target>
									<parameters>
										<variableReferenceExpression name="controller"/>
										<fieldReferenceExpression name="viewId">
											<thisReferenceExpression/>
										</fieldReferenceExpression>
										<fieldReferenceExpression name="config"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="ViewPage" name="page">
									<init>
										<objectCreateExpression type="ViewPage">
											<parameters>
												<argumentReferenceExpression name="request"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="PlugIn">
												<fieldReferenceExpression name="config"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="PreProcessPageRequest">
											<target>
												<propertyReferenceExpression name="PlugIn">
													<fieldReferenceExpression name="config"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<argumentReferenceExpression name="request"/>
												<variableReferenceExpression name="page"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression  methodName="AssignDynamicExpressions">
									<target>
										<fieldReferenceExpression name="config"/>
									</target>
									<parameters>
										<variableReferenceExpression name="page"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="InitBusinessRules">
									<parameters>
										<argumentReferenceExpression name="request"/>
										<variableReferenceExpression name="page"/>
									</parameters>
								</methodInvokeExpression>
								<usingStatement>
									<variable type="DataConnection" name="connection">
										<init>
											<methodInvokeExpression methodName="CreateConnection">
												<parameters>
													<thisReferenceExpression/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variable>
									<statements>
										<variableDeclarationStatement type="DbCommand" name="selectCommand">
											<init>
												<methodInvokeExpression methodName="CreateCommand">
													<parameters>
														<variableReferenceExpression name="connection"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="selectCommand"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<propertyReferenceExpression name="EnableResultSet">
														<fieldReferenceExpression name="serverRules"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<comment>it is not possible to "deep" search in this controller</comment>
												<methodInvokeExpression methodName="AppendLine">
													<target>
														<argumentReferenceExpression name="sb"/>
													</target>
													<parameters>
														<primitiveExpression value="select 1"/>
													</parameters>
												</methodInvokeExpression>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="ConfigureCommand">
											<parameters>
												<variableReferenceExpression name="selectCommand"/>
												<variableReferenceExpression name="page"/>
												<propertyReferenceExpression name="SelectExisting">
													<typeReferenceExpression type="CommandConfigurationType"/>
												</propertyReferenceExpression>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</usingStatement>
								<variableDeclarationStatement type="System.String" name="commandText">
									<init>
										<propertyReferenceExpression name="CommandText">
											<fieldReferenceExpression name="currentCommand"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Int32" name="parameterIndex">
									<init>
										<binaryOperatorExpression operator="Subtract">
											<propertyReferenceExpression name="Count">
												<propertyReferenceExpression name="Parameters">
													<fieldReferenceExpression name="currentCommand"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="1"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<binaryOperatorExpression operator="GreaterThanOrEqual">
											<variableReferenceExpression name="parameterIndex"/>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</test>
									<statements>
										<variableDeclarationStatement type="DbParameter" name="p">
											<init>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Parameters">
															<fieldReferenceExpression name="currentCommand"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<variableReferenceExpression name="parameterIndex"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="newParameterName">
											<init>
												<binaryOperatorExpression operator="Add">
													<fieldReferenceExpression name="parameterMarker"/>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="cp"/>
														<methodInvokeExpression methodName="ToString">
															<target>
																<propertyReferenceExpression name="Count">
																	<propertyReferenceExpression name="Parameters">
																		<variableReferenceExpression name="command"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
														</methodInvokeExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="commandText"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<variableReferenceExpression name="commandText"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="ParameterName">
														<variableReferenceExpression name="p"/>
													</propertyReferenceExpression>
													<variableReferenceExpression name="newParameterName"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="ParameterName">
												<variableReferenceExpression name="p"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="newParameterName"/>
										</assignStatement>
										<methodInvokeExpression methodName="RemoveAt">
											<target>
												<propertyReferenceExpression name="Parameters">
													<fieldReferenceExpression name="currentCommand"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="parameterIndex"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Parameters">
													<variableReferenceExpression name="command"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="p"/>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<variableReferenceExpression name="parameterIndex"/>
											<binaryOperatorExpression operator="Subtract">
												<variableReferenceExpression name="parameterIndex"/>
												<primitiveExpression value="1"/>
											</binaryOperatorExpression>
										</assignStatement>
									</statements>
								</whileStatement>
								<variableDeclarationStatement type="System.Int32" name="resultSetIndex">
									<init>
										<methodInvokeExpression methodName="IndexOf">
											<target>
												<variableReferenceExpression name="commandText"/>
											</target>
											<parameters>
												<primitiveExpression value="resultset__"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Int32" name="resultSetLastIndex">
									<init>
										<methodInvokeExpression methodName="LastIndexOf">
											<target>
												<variableReferenceExpression name="commandText"/>
											</target>
											<parameters>
												<primitiveExpression value="resultset__"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="resultSetIndex"/>
											<variableReferenceExpression name="resultSetLastIndex"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="commandText"/>
											<binaryOperatorExpression operator="Add">
												<methodInvokeExpression methodName="Substring">
													<target>
														<variableReferenceExpression name="commandText"/>
													</target>
													<parameters>
														<primitiveExpression value="0"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="resultSetIndex"/>
															<primitiveExpression value="9"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="2" convertTo="String"/>
													<methodInvokeExpression methodName="Substring">
														<target>
															<variableReferenceExpression name="commandText"/>
														</target>
														<parameters>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="resultSetIndex"/>
																<primitiveExpression value="9"/>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="AppendLine">
									<target>
										<argumentReferenceExpression name="sb"/>
									</target>
									<parameters>
										<variableReferenceExpression name="commandText"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method AppendSystemFilter(ViewPage) -->
						<memberMethod name="AppendSystemFilter">
							<attributes family="true"/>
							<parameters>
								<parameter type="DbCommand" name="command"/>
								<parameter type="ViewPage" name="page"/>
								<parameter type="SelectClauseDictionary" name="expressions"/>
							</parameters>
							<statements>
								<xsl:if test="$IsPremium='true'">
									<variableDeclarationStatement type="System.String[]" name="systemFilter">
										<init>
											<propertyReferenceExpression name="SystemFilter">
												<argumentReferenceExpression name="page"/>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanOr">
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="RequiresHierarchy">
														<parameters>
															<argumentReferenceExpression name="page"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="systemFilter"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="LessThan">
														<propertyReferenceExpression name="Length">
															<variableReferenceExpression name="systemFilter"/>
														</propertyReferenceExpression>
														<primitiveExpression value="2"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement/>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<fieldReferenceExpression name="viewFilter"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="viewFilter"/>
												<stringFormatExpression format="({{0}})and">
													<fieldReferenceExpression name="viewFilter"/>
												</stringFormatExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="StringBuilder" name="sb">
										<init>
											<objectCreateExpression type="StringBuilder">
												<parameters>
													<fieldReferenceExpression name="viewFilter"/>
												</parameters>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="Append">
										<target>
											<variableReferenceExpression name="sb"/>
										</target>
										<parameters>
											<primitiveExpression value="("/>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="System.Boolean" name="collapse">
										<init>
											<binaryOperatorExpression operator="ValueEquality">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="systemFilter"/>
													</target>
													<indices>
														<primitiveExpression value="0"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="collapse-nodes"/>
											</binaryOperatorExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="DataField" name="parentField">
										<init>
											<primitiveExpression value="null"/>
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
													<methodInvokeExpression methodName="IsTagged">
														<target>
															<variableReferenceExpression name="field"/>
														</target>
														<parameters>
															<primitiveExpression value="hierarchy-parent"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="parentField"/>
														<variableReferenceExpression name="field"/>
													</assignStatement>
													<breakStatement/>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
									<variableDeclarationStatement type="System.String" name="parentFieldExpression">
										<init>
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="expressions"/>
												</target>
												<indices>
													<propertyReferenceExpression name="Name">
														<variableReferenceExpression name="parentField"/>
													</propertyReferenceExpression>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="AppendFormat">
										<target>
											<variableReferenceExpression name="sb"/>
										</target>
										<parameters>
											<primitiveExpression value="{{0}} is null or "/>
											<variableReferenceExpression name="parentFieldExpression"/>
										</parameters>
									</methodInvokeExpression>
									<conditionStatement>
										<condition>
											<variableReferenceExpression name="collapse"/>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Append">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
												<parameters>
													<primitiveExpression value="not("/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="AppendFormat">
										<target>
											<variableReferenceExpression name="sb"/>
										</target>
										<parameters>
											<primitiveExpression value="{{0}} in ("/>
											<argumentReferenceExpression name="parentFieldExpression"/>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="System.Boolean" name="first">
										<init>
											<primitiveExpression value="true"/>
										</init>
									</variableDeclarationStatement>
									<forStatement>
										<variable type="System.Int32" name="i">
											<init>
												<primitiveExpression value="1"/>
											</init>
										</variable>
										<test>
											<binaryOperatorExpression operator="LessThan">
												<variableReferenceExpression name="i"/>
												<propertyReferenceExpression name="Length">
													<variableReferenceExpression name="systemFilter"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</test>
										<increment>
											<variableReferenceExpression name="i"/>
										</increment>
										<statements>
											<variableDeclarationStatement type="System.Object" name="v">
												<init>
													<methodInvokeExpression methodName="StringToValue">
														<parameters>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="systemFilter"/>
																</target>
																<indices>
																	<variableReferenceExpression name="i"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="DbParameter" name="p">
												<init>
													<methodInvokeExpression methodName="CreateParameter">
														<target>
															<argumentReferenceExpression name="command"/>
														</target>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<propertyReferenceExpression name="ParameterName">
													<variableReferenceExpression name="p"/>
												</propertyReferenceExpression>
												<stringFormatExpression format="{{0}}p{{1}}">
													<fieldReferenceExpression name="parameterMarker"/>
													<propertyReferenceExpression name="Count">
														<propertyReferenceExpression name="Parameters">
															<argumentReferenceExpression name="command"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</stringFormatExpression>
											</assignStatement>
											<assignStatement>
												<propertyReferenceExpression name="Value">
													<variableReferenceExpression name="p"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="v"/>
											</assignStatement>
											<methodInvokeExpression methodName="Add">
												<target>
													<propertyReferenceExpression name="Parameters">
														<argumentReferenceExpression name="command"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="p"/>
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
												<falseStatements>
													<methodInvokeExpression methodName="Append">
														<target>
															<variableReferenceExpression name="sb"/>
														</target>
														<parameters>
															<primitiveExpression value=","/>
														</parameters>
													</methodInvokeExpression>
												</falseStatements>
											</conditionStatement>
											<methodInvokeExpression methodName="Append">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="ParameterName">
														<variableReferenceExpression name="p"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</forStatement>
									<conditionStatement>
										<condition>
											<variableReferenceExpression name="collapse"/>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Append">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
												<parameters>
													<primitiveExpression value=")"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="Append">
										<target>
											<variableReferenceExpression name="sb"/>
										</target>
										<parameters>
											<primitiveExpression value="))"/>
										</parameters>
									</methodInvokeExpression>
									<assignStatement>
										<fieldReferenceExpression name="viewFilter"/>
										<methodInvokeExpression methodName="ToString">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
										</methodInvokeExpression>
									</assignStatement>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- method AppendAccessControlRules(DbCommand, ViewPage, SelectClauseDictionary) -->
						<xsl:if test="$IsPremium='true'">
							<memberMethod name="AppendAccessControlRules">
								<attributes private="true"/>
								<parameters>
									<parameter type="DbCommand" name="command"/>
									<parameter type="ViewPage" name="page"/>
									<parameter type="SelectClauseDictionary" name="expressions"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="System.Object" name="handler">
										<init>
											<methodInvokeExpression methodName="CreateActionHandler">
												<target>
													<fieldReferenceExpression name="config"/>
												</target>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<binaryOperatorExpression operator="IsTypeOf">
													<variableReferenceExpression name="handler"/>
													<typeReferenceExpression type="BusinessRules"/>
												</binaryOperatorExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement/>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="BusinessRules" name="rules">
										<init>
											<fieldReferenceExpression name="serverRules"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="rules"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="handler"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="rules"/>
												<castExpression targetType="BusinessRules">
													<variableReferenceExpression name="handler"/>
												</castExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="rules"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="rules"/>
												<methodInvokeExpression methodName="CreateBusinessRules"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<propertyReferenceExpression name="TrackAliases">
											<argumentReferenceExpression name="expressions"/>
										</propertyReferenceExpression>
										<primitiveExpression value="true"/>
									</assignStatement>
									<variableDeclarationStatement name="accessControlFilter">
										<init>
											<methodInvokeExpression methodName="EnumerateAccessControlRules">
												<target>
													<variableReferenceExpression name="rules"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="command"/>
													<propertyReferenceExpression name="ControllerName">
														<fieldReferenceExpression name="config"/>
													</propertyReferenceExpression>
													<fieldReferenceExpression name="parameterMarker"/>
													<argumentReferenceExpression name="page"/>
													<argumentReferenceExpression name="expressions"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="TrackAliases">
											<argumentReferenceExpression name="expressions"/>
										</propertyReferenceExpression>
										<primitiveExpression value="false"/>
									</assignStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<variableReferenceExpression name="accessControlFilter"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement/>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<fieldReferenceExpression name="viewFilter"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="viewFilter"/>
												<binaryOperatorExpression operator="Add">
													<fieldReferenceExpression name="viewFilter"/>
													<primitiveExpression value=" and "/>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<fieldReferenceExpression name="viewFilter"/>
										<stringFormatExpression format="{{0}}/*Sql*/{{1}}/*Sql*/">
											<fieldReferenceExpression name="viewFilter"/>
											<variableReferenceExpression name="accessControlFilter"/>
										</stringFormatExpression>
										<!--<methodInvokeExpression methodName="Format">
                      <target>
                        <typeReferenceExpression type="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="{{0}}/*Sql*/{{1}}/*Sql*/"/>
                        <fieldReferenceExpression name="viewFilter"/>
                        <variableReferenceExpression name="accessControlFilter"/>
                      </parameters>
                    </methodInvokeExpression>-->
									</assignStatement>
								</statements>
							</memberMethod>
						</xsl:if>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>

</xsl:stylesheet>
