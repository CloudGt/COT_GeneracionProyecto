<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="Namespace" select="/a:project/a:namespace"/>

	<xsl:template match="/">

		<compileUnit namespace="{$Namespace}.Handlers">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Net"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Caching"/>
				<namespaceImport name="{$Namespace}.Data"/>
			</imports>
			<types>
				<!-- class ScriptHost -->
				<typeDeclaration name="ScriptHost">
					<baseTypes>
						<typeReference type="GenericHandlerBase"/>
						<typeReference type="IHttpHandler"/>
						<typeReference type="System.Web.SessionState.IRequiresSessionState"/>
					</baseTypes>
					<members>
						<!-- method ProcessRequest(HttpContext) -->
						<memberMethod name="ProcessRequest" privateImplementationType="IHttpHandler">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="HttpContext" name="context"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="context"/>
									<argumentReferenceExpression name="context"/>
								</assignStatement>
								<variableDeclarationStatement type="System.String" name="addInitKey">
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
												<primitiveExpression value="add_init"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="methodName">
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
												<primitiveExpression value="method"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="StringBuilder" name="sb">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="StringWriter" name="writer">
									<init>
										<objectCreateExpression type="StringWriter">
											<parameters>
												<variableReferenceExpression name="sb"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="methodName"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="{$Namespace}.Services.DataControllerService" name="service">
											<init>
												<objectCreateExpression type="{$Namespace}.Services.DataControllerService"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="sender">
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
														<primitiveExpression value="sender"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="cookie">
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
														<primitiveExpression value="cookie"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="sessionArgs">
											<init>
												<castExpression targetType="System.String">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Cache">
																<argumentReferenceExpression name="context"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<variableReferenceExpression name="cookie"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="Remove">
											<target>
												<propertyReferenceExpression name="Cache">
													<argumentReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="cookie"/>
											</parameters>
										</methodInvokeExpression>
										<variableDeclarationStatement type="System.String" name="args">
											<init>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="sessionArgs"/>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Params">
																<propertyReferenceExpression name="Request">
																	<argumentReferenceExpression name="context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="args"/>
														</indices>
													</arrayIndexerExpression>
												</binaryOperatorExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="contextParam">
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
														<primitiveExpression value="ctx"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<comment>#pragma warning disable 0618</comment>
										<comment>The class 'System.Web.Script.Serialization.JavaScriptSerializer.JavaScriptSerializer()' is obsolete.</comment>
										<comment>The recommended alternative is 'System.Runtime.Serialization.DataContractJsonSerializer'.</comment>
										<comment>The use of the recommended alternative requires numerous cosmetic WCF-specific changes to the application</comment>
										<comment>that  are not implemented in this release.</comment>
										<variableDeclarationStatement type="System.Web.Script.Serialization.JavaScriptSerializer" name="serializer">
											<init>
												<objectCreateExpression type="System.Web.Script.Serialization.JavaScriptSerializer"/>
											</init>
										</variableDeclarationStatement>
										<comment>#pragma warning disable 0618</comment>
										<comment>remove the last method script call from the header</comment>
										<methodInvokeExpression methodName="WriteLine">
											<target>
												<variableReferenceExpression name="writer"/>
											</target>
											<parameters>
												<primitiveExpression value="document.getElementsByTagName('head')[0].removeChild($get('__{{0}}_{{1}}_ScriptCallBack'));"/>
												<variableReferenceExpression name="sender"/>
												<variableReferenceExpression name="methodName"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Params">
																<propertyReferenceExpression name="Request">
																	<argumentReferenceExpression name="context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="c"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="1" convertTo="String"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<comment>keep building the json argument when the script url is longer then 2048</comment>
												<methodInvokeExpression methodName="Insert">
													<target>
														<propertyReferenceExpression name="Cache">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="cookie"/>
														<variableReferenceExpression name="args"/>
														<primitiveExpression value="null"/>
														<propertyReferenceExpression name="NoAbsoluteExpiration">
															<typeReferenceExpression type="Cache"/>
														</propertyReferenceExpression>
														<methodInvokeExpression methodName="FromSeconds">
															<target>
																<typeReferenceExpression type="TimeSpan"/>
															</target>
															<parameters>
																<primitiveExpression value="30"/>
															</parameters>
														</methodInvokeExpression>
														<propertyReferenceExpression name="AboveNormal">
															<typeReferenceExpression type="CacheItemPriority"/>
														</propertyReferenceExpression>
														<primitiveExpression value="null"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteLine">
													<target>
														<variableReferenceExpression name="writer"/>
													</target>
													<parameters>
														<primitiveExpression value="$find('{{0}}')._invoke('{{1}}',null,null,{{2}});"/>
														<variableReferenceExpression name="sender"/>
														<variableReferenceExpression name="methodName"/>
														<methodInvokeExpression methodName="Serialize">
															<target>
																<variableReferenceExpression name="serializer"/>
															</target>
															<parameters>
																<variableReferenceExpression name="contextParam"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<variableDeclarationStatement type="SortedDictionary" name="arguments">
													<typeArguments>
														<typeReference type="System.String"/>
														<typeReference type="System.Object"/>
													</typeArguments>
													<init>
														<methodInvokeExpression methodName="Deserialize">
															<typeArguments>
																<typeReference type="SortedDictionary">
																	<typeArguments>
																		<typeReference type="System.String"/>
																		<typeReference type="System.Object"/>
																	</typeArguments>
																</typeReference>
															</typeArguments>
															<target>
																<variableReferenceExpression name="serializer"/>
															</target>
															<parameters>
																<variableReferenceExpression name="args"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.Object" name="result">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<tryStatement>
													<statements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="methodName"/>
																	<primitiveExpression value="GetPage"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="PageRequest" name="request">
																	<init>
																		<methodInvokeExpression methodName="Deserialize">
																			<typeArguments>
																				<typeReference type="PageRequest"/>
																			</typeArguments>
																			<target>
																				<variableReferenceExpression name="serializer"/>
																			</target>
																			<parameters>
																				<methodInvokeExpression methodName="Serialize">
																					<target>
																						<variableReferenceExpression name="serializer"/>
																					</target>
																					<parameters>
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="arguments"/>
																							</target>
																							<indices>
																								<primitiveExpression value="request"/>
																							</indices>
																						</arrayIndexerExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<assignStatement>
																	<variableReferenceExpression name="result"/>
																	<methodInvokeExpression methodName="GetPage">
																		<target>
																			<variableReferenceExpression name="service"/>
																		</target>
																		<parameters>
																			<castExpression targetType="System.String">
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="arguments"/>
																					</target>
																					<indices>
																						<primitiveExpression value="controller"/>
																					</indices>
																				</arrayIndexerExpression>
																			</castExpression>
																			<castExpression targetType="System.String">
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="arguments"/>
																					</target>
																					<indices>
																						<primitiveExpression value="view"/>
																					</indices>
																				</arrayIndexerExpression>
																			</castExpression>
																			<variableReferenceExpression name="request"/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="methodName"/>
																			<primitiveExpression value="GetListOfValues"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="DistinctValueRequest" name="request">
																			<init>
																				<methodInvokeExpression methodName="Deserialize">
																					<typeArguments>
																						<typeReference type="DistinctValueRequest"/>
																					</typeArguments>
																					<target>
																						<variableReferenceExpression name="serializer"/>
																					</target>
																					<parameters>
																						<methodInvokeExpression methodName="Serialize">
																							<target>
																								<variableReferenceExpression name="serializer"/>
																							</target>
																							<parameters>
																								<arrayIndexerExpression>
																									<target>
																										<variableReferenceExpression name="arguments"/>
																									</target>
																									<indices>
																										<primitiveExpression value="request"/>
																									</indices>
																								</arrayIndexerExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<assignStatement>
																			<variableReferenceExpression name="result"/>
																			<methodInvokeExpression methodName="GetListOfValues">
																				<target>
																					<variableReferenceExpression name="service"/>
																				</target>
																				<parameters>
																					<castExpression targetType="System.String">
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="arguments"/>
																							</target>
																							<indices>
																								<primitiveExpression value="controller"/>
																							</indices>
																						</arrayIndexerExpression>
																					</castExpression>
																					<castExpression targetType="System.String">
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="arguments"/>
																							</target>
																							<indices>
																								<primitiveExpression value="view"/>
																							</indices>
																						</arrayIndexerExpression>
																					</castExpression>
																					<variableReferenceExpression name="request"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<variableDeclarationStatement type="ActionArgs" name="argsParam">
																			<init>
																				<methodInvokeExpression methodName="Deserialize">
																					<typeArguments>
																						<typeReference type="ActionArgs"/>
																					</typeArguments>
																					<target>
																						<variableReferenceExpression name="serializer"/>
																					</target>
																					<parameters>
																						<methodInvokeExpression methodName="Serialize">
																							<target>
																								<variableReferenceExpression name="serializer"/>
																							</target>
																							<parameters>
																								<arrayIndexerExpression>
																									<target>
																										<variableReferenceExpression name="arguments"/>
																									</target>
																									<indices>
																										<primitiveExpression value="args"/>
																									</indices>
																								</arrayIndexerExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<assignStatement>
																			<variableReferenceExpression name="result"/>
																			<methodInvokeExpression methodName="Execute">
																				<target>
																					<variableReferenceExpression name="service"/>
																				</target>
																				<parameters>
																					<castExpression targetType="System.String">
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="arguments"/>
																							</target>
																							<indices>
																								<primitiveExpression value="controller"/>
																							</indices>
																						</arrayIndexerExpression>
																					</castExpression>
																					<castExpression targetType="System.String">
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="arguments"/>
																							</target>
																							<indices>
																								<primitiveExpression value="view"/>
																							</indices>
																						</arrayIndexerExpression>
																					</castExpression>
																					<variableReferenceExpression name="argsParam"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
														<variableDeclarationStatement type="System.String" name="serializedResult">
															<init>
																<methodInvokeExpression methodName="Serialize">
																	<target>
																		<variableReferenceExpression name="serializer"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="result"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<variableReferenceExpression name="serializedResult"/>
															<methodInvokeExpression methodName="Replace">
																<target>
																	<typeReferenceExpression type="Regex"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="serializedResult"/>
																	<primitiveExpression value="(^|[^\\])\&quot;\\/Date\((-?[0-9]+)(?:[a-zA-Z]|(?:\+|-)[0-9]{{4}})?\)\\/\&quot;"/>
																	<primitiveExpression value="$1new Date($2)"/>
																	<!--<propertyReferenceExpression name="Compiled">
                                    <typeReferenceExpression type="RegexOptions"/>
                                  </propertyReferenceExpression>-->
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<methodInvokeExpression methodName="WriteLine">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="$find('{{0}}')._on{{1}}Complete({{2}},'{{3}}');"/>
																<variableReferenceExpression name="sender"/>
																<variableReferenceExpression name="methodName"/>
																<variableReferenceExpression name="serializedResult"/>
																<variableReferenceExpression name="contextParam"/>
															</parameters>
														</methodInvokeExpression>
													</statements>
													<catch exceptionType="Exception" localName="ex">
														<methodInvokeExpression methodName="WriteLine">
															<target>
																<variableReferenceExpression name="writer"/>
															</target>
															<parameters>
																<primitiveExpression value="$find('{{0}}')._onMethodFailed(new Sys.Net.WebServiceError(false, {{1}}, {{2}}, {{3}}), {{4}}, {{5}});"/>
																<variableReferenceExpression name="sender"/>
																<methodInvokeExpression methodName="Serialize">
																	<target>
																		<variableReferenceExpression name="serializer"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Message">
																			<variableReferenceExpression name="ex"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Serialize">
																	<target>
																		<variableReferenceExpression name="serializer"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="StackTrace">
																			<variableReferenceExpression name="ex"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Serialize">
																	<target>
																		<variableReferenceExpression name="serializer"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Name">
																			<methodInvokeExpression methodName="GetType">
																				<target>
																					<variableReferenceExpression name="ex"/>
																				</target>
																			</methodInvokeExpression>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Serialize">
																	<target>
																		<variableReferenceExpression name="serializer"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="methodName"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Serialize">
																	<target>
																		<variableReferenceExpression name="serializer"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="contextParam"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</catch>
												</tryStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="Execute">
											<target>
												<propertyReferenceExpression name="Server">
													<argumentReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Format">
													<target>
														<typeReferenceExpression type="String"/>
													</target>
													<parameters>
														<primitiveExpression value="~/{{0}}.aspx"/>
														<variableReferenceExpression name="PageName"/>
													</parameters>
												</methodInvokeExpression>
												<variableReferenceExpression name="writer"/>
												<primitiveExpression value="true"/>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="Close">
									<target>
										<variableReferenceExpression name="writer"/>
									</target>
								</methodInvokeExpression>
								<assignStatement>
									<propertyReferenceExpression name="ContentType">
										<propertyReferenceExpression name="Response">
											<argumentReferenceExpression name="context"/>
										</propertyReferenceExpression>
									</propertyReferenceExpression>
									<primitiveExpression value="text/javascript"/>
								</assignStatement>
								<methodInvokeExpression methodName="SetCacheability">
									<target>
										<propertyReferenceExpression name="Cache">
											<propertyReferenceExpression name="Response">
												<argumentReferenceExpression name="context"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<propertyReferenceExpression name="NoCache">
											<typeReferenceExpression type="HttpCacheability"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="System.String" name="output">
									<init>
										<methodInvokeExpression methodName="ToString">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="methodName"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="addInitKey"/>
												</unaryOperatorExpression>

											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="output"/>
													<methodInvokeExpression methodName="CreateSystemScripts">
														<parameters>
															<variableReferenceExpression name="output"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="output"/>
													<methodInvokeExpression methodName="CreateComponentScript">
														<parameters>
															<variableReferenceExpression name="output"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="Write">
									<target>
										<propertyReferenceExpression name="Response">
											<argumentReferenceExpression name="context"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<variableReferenceExpression name="output"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- property IsReusable -->
						<memberProperty type="System.Boolean" name="IsReusable" privateImplementationType="IHttpHandler">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Context -->
						<memberField type="HttpContext" name="context"/>
						<memberProperty type="HttpContext" name="Context">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="context"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property BasePath -->
						<memberField type="System.String" name="basePath"/>
						<memberProperty type="System.String" name="BasePath">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<fieldReferenceExpression name="basePath"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="basePath"/>
											<binaryOperatorExpression operator="Add">
												<binaryOperatorExpression operator="Add">
													<propertyReferenceExpression name="Scheme">
														<propertyReferenceExpression name="Url">
															<propertyReferenceExpression name="Request">
																<propertyReferenceExpression name="Context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="://"/>
												</binaryOperatorExpression>
												<propertyReferenceExpression name="Authority">
													<propertyReferenceExpression name="Url">
														<propertyReferenceExpression name="Request">
															<propertyReferenceExpression name="Context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="basePath"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property PageName -->
						<memberProperty type="System.String" name="PageName">
							<attributes family="true" final="true"/>
							<getStatements>
								<variableDeclarationStatement type="System.String" name="page">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="QueryString">
													<propertyReferenceExpression name="Request">
														<propertyReferenceExpression name="Context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="page"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="page"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="page"/>
											<primitiveExpression value="Default"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="page"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method CreateComponentScript(string) -->
						<memberMethod returnType="System.String" name="CreateComponentScript">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="text"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="Match" name="m">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="text"/>
												<primitiveExpression value="(?'AddInit'Sys.Application.add_init[\s\S]+?}}\);)"/>
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
										<variableDeclarationStatement type="StringBuilder" name="sb">
											<init>
												<objectCreateExpression type="StringBuilder"/>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<propertyReferenceExpression name="Success">
													<variableReferenceExpression name="m"/>
												</propertyReferenceExpression>
											</test>
											<statements>
												<methodInvokeExpression methodName="AppendLine">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<primitiveExpression value="if(!Sys.Application.__initialized) {{Sys.Application.initialize();Sys.Application.__initialized = true;}}"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="AppendLine">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="Replace">
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
																			<primitiveExpression value="AddInit"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
																<primitiveExpression value="&quot;(?'Property'(servicePath))&quot;:&quot;(?'Url'.+?)&quot;"/>
																<addressOfExpression>
																	<methodReferenceExpression methodName="ResolvePropertyUrl"/>
																</addressOfExpression>
																<!--<propertyReferenceExpression name="Compiled">
                                  <typeReferenceExpression type="RegexOptions"/>
                                </propertyReferenceExpression>-->
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
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
										<variableDeclarationStatement type="System.String" name="script">
											<init>
												<methodInvokeExpression methodName="ToString">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="System.String" name="paramKey"/>
											<target>
												<propertyReferenceExpression name="Keys">
													<propertyReferenceExpression name="QueryString">
														<propertyReferenceExpression name="Request">
															<propertyReferenceExpression name="Context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<statements>
												<variableDeclarationStatement type="System.String" name="paramValue">
													<init>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="QueryString">
																		<propertyReferenceExpression name="Request">
																			<propertyReferenceExpression name="Context"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<variableReferenceExpression name="paramKey"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
													</init>
												</variableDeclarationStatement>
												<assignStatement>
													<variableReferenceExpression name="script"/>
													<methodInvokeExpression methodName="Replace">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<variableReferenceExpression name="script"/>
															<methodInvokeExpression methodName="Format">
																<target>
																	<typeReferenceExpression type="String"/>
																</target>
																<parameters>
																	<primitiveExpression value="(?'Left'\$create\(([\w.]+),.+?&quot;{{0}}&quot;:&quot;{{{{0,1}}}})\w+(?'Right'&quot;{{{{0,1}}}}.+?\)\);)"/>
																	<variableReferenceExpression name="paramKey"/>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="Format">
																<target>
																	<typeReferenceExpression type="String"/>
																</target>
																<parameters>
																	<primitiveExpression value="${{{{Left}}}}{{0}}${{{{Right}}}}"/>
																	<variableReferenceExpression name="paramValue"/>
																</parameters>
															</methodInvokeExpression>
															<!--<propertyReferenceExpression name="Compiled">
                                <typeReferenceExpression type="RegexOptions"/>
                              </propertyReferenceExpression>-->
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</statements>
										</foreachStatement>
										<assignStatement>
											<variableReferenceExpression name="sb"/>
											<objectCreateExpression type="StringBuilder"/>
										</assignStatement>
										<methodInvokeExpression methodName="Append">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<variableReferenceExpression name="script"/>
											</parameters>
										</methodInvokeExpression>
										<variableDeclarationStatement type="Match" name="placeholder">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="script"/>
														<primitiveExpression value="\$create\(Web.DataView.+?\$get\(&quot;(\w+)&quot;\)\);"/>
														<!--<propertyReferenceExpression name="Compiled">
                              <typeReferenceExpression type="RegexOptions"/>
                            </propertyReferenceExpression>-->
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<propertyReferenceExpression name="Success">
													<variableReferenceExpression name="placeholder"/>
												</propertyReferenceExpression>
											</test>
											<statements>
												<methodInvokeExpression methodName="AppendFormat">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<primitiveExpression value="if(!document.getElementById('{{0}}'))document.write('&lt;div id=&quot;{{0}}&quot; class=&quot;DataViewPlaceholder&quot;&gt;&lt;/div&gt;');&#13;&#10;"/>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="placeholder"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="1"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
												<assignStatement>
													<variableReferenceExpression name="placeholder"/>
													<methodInvokeExpression methodName="NextMatch">
														<target>
															<variableReferenceExpression name="placeholder"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</statements>
										</whileStatement>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ToString">
												<target>
													<variableReferenceExpression name="sb"/>
												</target>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateSystemScripts(string) -->
						<memberMethod returnType="System.String" name="CreateSystemScripts">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="text"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="StringBuilder" name="sb">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<comment>generate standard library script links available in the page</comment>
								<variableDeclarationStatement type="Match" name="m">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="text"/>
												<primitiveExpression value="&lt;script src=&quot;(?'Url'.+?)&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;"/>
												<!--<propertyReferenceExpression name="Compiled">
                          <typeReferenceExpression type="RegexOptions"/>
                        </propertyReferenceExpression>-->
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="m"/>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<argumentReferenceExpression name="text"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<whileStatement>
									<test>
										<propertyReferenceExpression name="Success">
											<variableReferenceExpression name="m"/>
										</propertyReferenceExpression>
									</test>
									<statements>
										<variableDeclarationStatement type="System.String" name="src">
											<init>
												<methodInvokeExpression methodName="ResolveUrl">
													<parameters>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Url"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="AppendFormat">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value="document.write('&lt;script  type=&quot;text/javascript&quot; language=&quot;javascript&quot; src=&quot;{{0}}&quot;&gt;&lt;/script&gt;');&#13;&#10;"/>
												<variableReferenceExpression name="src"/>
											</parameters>
										</methodInvokeExpression>
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
								<comment>generate the script for ASP.NET AJAX components in the page </comment>
								<methodInvokeExpression methodName="AppendFormat">
									<target>
										<variableReferenceExpression name="sb"/>
									</target>
									<parameters>
										<primitiveExpression value="document.write('&lt;script  type=&quot;text/javascript&quot; language=&quot;javascript&quot; src=&quot;{{0}}?add_init={{1}}"/>
										<binaryOperatorExpression operator="Add">
											<propertyReferenceExpression name="BasePath"/>
											<propertyReferenceExpression name="Path">
												<propertyReferenceExpression name="Request">
													<propertyReferenceExpression name="Context"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
										<variableReferenceExpression name="PageName"/>
									</parameters>
								</methodInvokeExpression>
								<foreachStatement>
									<variable type="System.String" name="paramKey"/>
									<target>
										<propertyReferenceExpression name="Keys">
											<propertyReferenceExpression name="QueryString">
												<propertyReferenceExpression name="Request">
													<propertyReferenceExpression name="Context"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</target>
									<statements>
										<methodInvokeExpression methodName="AppendFormat">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value="&amp;{{0}}={{1}}"/>
												<variableReferenceExpression name="paramKey"/>
												<methodInvokeExpression methodName="UrlEncode">
													<target>
														<typeReferenceExpression type="HttpUtility"/>
													</target>
													<parameters>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="QueryString">
																	<propertyReferenceExpression name="Request">
																		<propertyReferenceExpression name="Context"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
															<indices>
																<variableReferenceExpression name="paramKey"/>
															</indices>
														</arrayIndexerExpression>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<methodInvokeExpression methodName="AppendLine">
									<target>
										<variableReferenceExpression name="sb"/>
									</target>
									<parameters>
										<primitiveExpression value="&quot;&gt;&lt;/script&gt;');"/>
									</parameters>
								</methodInvokeExpression>
								<comment>generate CSS links available in this page</comment>
								<assignStatement>
									<variableReferenceExpression name="m"/>
									<methodInvokeExpression methodName="Match">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="text"/>
											<primitiveExpression value="&lt;link[\s\S]*?/&gt;"/>
											<!--<propertyReferenceExpression name="Compiled">
                        <typeReferenceExpression type="RegexOptions"/>
                      </propertyReferenceExpression>-->
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<whileStatement>
									<test>
										<propertyReferenceExpression name="Success">
											<variableReferenceExpression name="m"/>
										</propertyReferenceExpression>
									</test>
									<statements>
										<variableDeclarationStatement type="Match" name="href">
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
																	<primitiveExpression value="0"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
														<primitiveExpression value="(.+href=&quot;)(.+?)(&quot;.+)"/>
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
													<variableReferenceExpression name="href"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="AppendFormat">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<primitiveExpression value="document.write('{{0}}{{1}}{{2}}');&#13;&#10;"/>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="href"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="1"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
														<methodInvokeExpression methodName="ResolveUrl">
															<parameters>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="href"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="2"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="href"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="3"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
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
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToString">
										<target>
											<variableReferenceExpression name="sb"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ResolvePropertyUrl(Match) -->
						<memberMethod returnType="System.String" name="ResolvePropertyUrl">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Format">
										<target>
											<typeReferenceExpression type="String"/>
										</target>
										<parameters>
											<primitiveExpression value="&quot;{{0}}&quot;:&quot;{{1}}&quot;"/>
											<propertyReferenceExpression name="Value">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Groups">
															<variableReferenceExpression name="m"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="Property"/>
													</indices>
												</arrayIndexerExpression>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ResolveUrl">
												<parameters>
													<propertyReferenceExpression name="Value">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<variableReferenceExpression name="m"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Url"/>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ResolveUrl(string)-->
						<memberMethod returnType="System.String" name="ResolveUrl">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="url"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<argumentReferenceExpression name="url"/>
											</target>
											<parameters>
												<primitiveExpression value="/"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="url"/>
											<binaryOperatorExpression operator="Add">
												<propertyReferenceExpression name="BasePath"/>
												<argumentReferenceExpression name="url"/>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<variableDeclarationStatement type="System.String" name="path">
											<init>
												<propertyReferenceExpression name="BasePath"/>
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
													<binaryOperatorExpression operator="Subtract">
														<propertyReferenceExpression name="Length">
															<propertyReferenceExpression name="Segments">
																<propertyReferenceExpression name="Url">
																	<propertyReferenceExpression name="Request">
																		<propertyReferenceExpression name="Context"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</test>
											<increment>
												<variableReferenceExpression name="i"/>
											</increment>
											<statements>
												<assignStatement>
													<variableReferenceExpression name="path"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="path"/>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Segments">
																	<propertyReferenceExpression name="Url">
																		<propertyReferenceExpression name="Request">
																			<propertyReferenceExpression name="Context"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
															<indices>
																<variableReferenceExpression name="i"/>
															</indices>
														</arrayIndexerExpression>
													</binaryOperatorExpression>
												</assignStatement>
											</statements>
										</forStatement>
										<assignStatement>
											<argumentReferenceExpression name="url"/>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="path"/>
												<argumentReferenceExpression name="url"/>
											</binaryOperatorExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="url"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
