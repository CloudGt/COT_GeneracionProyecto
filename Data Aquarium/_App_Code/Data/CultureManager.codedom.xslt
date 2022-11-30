<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:cm="urn:schema-codeontime-com:culture-manager"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a cm"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="SupportedCultures"/>
	<xsl:param name="IsUnlimited"/>
	<xsl:param name="Host"/>

	<msxsl:script language="C#" implements-prefix="cm">
		<![CDATA[
   public string Trim(string s) {
    return s.Trim();
   }
  ]]>
	</msxsl:script>

	<xsl:template match="/">
		<compileUnit namespace="{a:project/a:namespace}.Data">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Globalization"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Reflection"/>
				<namespaceImport name="System.Threading"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.UI.HtmlControls"/>
				<namespaceImport name="{a:project/a:namespace}.Services"/>
			</imports>
			<types>
				<!-- class CultureManager -->
				<typeDeclaration name="CultureManager">
					<members>
						<memberField type="System.String" name="AutoDetectCulture">
							<attributes const="true" public="true"/>
							<init>
								<primitiveExpression value="Detect,Detect"/>
							</init>
						</memberField>
						<memberField type="System.String[]" name="SupportedCultures">
							<attributes public="true" static="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<xsl:call-template name="ListCulture"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- method Initialize() -->
						<xsl:choose>
							<xsl:when test="$Host!=''">
								<memberMethod name="Initialize">
									<attributes public="true" static="true"/>
								</memberMethod>
							</xsl:when>
							<xsl:otherwise>
								<memberMethod name="Initialize">
									<attributes public="true" static="true"/>
									<statements>
										<variableDeclarationStatement type="HttpContext" name="ctx">
											<init>
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="ctx"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="IdentityInequality">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Items">
																	<variableReferenceExpression name="ctx"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="CultureManager_Initialized"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Items">
														<variableReferenceExpression name="ctx"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="CultureManager_Initialized"/>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="true"/>
										</assignStatement>
										<variableDeclarationStatement type="HttpCookie" name="cultureCookie">
											<init>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Cookies">
															<propertyReferenceExpression name="Request">
																<variableReferenceExpression name="ctx"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value=".COTCULTURE"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="culture">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="cultureCookie"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="culture"/>
													<propertyReferenceExpression name="Value">
														<variableReferenceExpression name="cultureCookie"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<unaryOperatorExpression operator="IsNullOrEmpty">
														<variableReferenceExpression name="culture"/>
													</unaryOperatorExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<variableReferenceExpression name="culture"/>
														<propertyReferenceExpression name="AutoDetectCulture">
															<typeReferenceExpression type="CultureManager"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<propertyReferenceExpression name="UserLanguages">
																<propertyReferenceExpression name="Request">
																	<variableReferenceExpression name="ctx"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<foreachStatement>
															<variable type="System.String" name="l"/>
															<target>
																<propertyReferenceExpression name="UserLanguages">
																	<propertyReferenceExpression name="Request">
																		<variableReferenceExpression name="ctx"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
															<statements>
																<variableDeclarationStatement type="System.String[]" name="languageInfo">
																	<init>
																		<methodInvokeExpression methodName="Split">
																			<target>
																				<variableReferenceExpression name="l"/>
																			</target>
																			<parameters>
																				<primitiveExpression value=";" convertTo="Char"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<foreachStatement>
																	<variable type="System.String" name="c"/>
																	<target>
																		<propertyReferenceExpression name="SupportedCultures"/>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="StartsWith">
																					<target>
																						<variableReferenceExpression name="c"/>
																					</target>
																					<parameters>
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="languageInfo"/>
																							</target>
																							<indices>
																								<primitiveExpression value="0"/>
																							</indices>
																						</arrayIndexerExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="culture"/>
																					<variableReferenceExpression name="c"/>
																				</assignStatement>
																				<breakStatement/>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="culture"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<breakStatement/>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
													</trueStatements>
													<falseStatements>
														<assignStatement>
															<variableReferenceExpression name="culture"/>
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="SupportedCultures"/>
																</target>
																<indices>
																	<primitiveExpression value="0"/>
																</indices>
															</arrayIndexerExpression>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="culture"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.Int32" name="cultureIndex">
													<init>
														<methodInvokeExpression methodName="IndexOf">
															<target>
																<typeReferenceExpression type="Array"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="SupportedCultures"/>
																<variableReferenceExpression name="culture"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueInequality">
															<variableReferenceExpression name="cultureIndex"/>
															<primitiveExpression value="-1"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.String[]" name="ci">
															<init>
																<methodInvokeExpression methodName="Split">
																	<target>
																		<variableReferenceExpression name="culture"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="," convertTo="Char"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<propertyReferenceExpression name="CurrentCulture">
																<propertyReferenceExpression name="CurrentThread">
																	<typeReferenceExpression type="Thread"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<methodInvokeExpression methodName="CreateSpecificCulture">
																<target>
																	<typeReferenceExpression type="CultureInfo"/>
																</target>
																<parameters>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="ci"/>
																		</target>
																		<indices>
																			<primitiveExpression value="0"/>
																		</indices>
																	</arrayIndexerExpression>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<xsl:if test="contains($SupportedCultures, 'th-TH')">
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="ValueEquality">
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="ci"/>
																			</target>
																			<indices>
																				<primitiveExpression value="0"/>
																			</indices>
																		</arrayIndexerExpression>
																		<primitiveExpression value="th-TH"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<propertyReferenceExpression name="Calendar">
																			<propertyReferenceExpression name="DateTimeFormat">
																				<propertyReferenceExpression name="CurrentCulture">
																					<propertyReferenceExpression name="CurrentThread">
																						<typeReferenceExpression type="Thread"/>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																		<objectCreateExpression type="GregorianCalendar"/>
																	</assignStatement>
																</trueStatements>
															</conditionStatement>
														</xsl:if>
														<assignStatement>
															<propertyReferenceExpression name="CurrentUICulture">
																<propertyReferenceExpression name="CurrentThread">
																	<typeReferenceExpression type="Thread"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<objectCreateExpression type="CultureInfo">
																<parameters>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="ci"/>
																		</target>
																		<indices>
																			<primitiveExpression value="1"/>
																		</indices>
																	</arrayIndexerExpression>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
														<xsl:if test="contains($SupportedCultures, 'th-TH')">
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="ValueEquality">
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="ci"/>
																			</target>
																			<indices>
																				<primitiveExpression value="1"/>
																			</indices>
																		</arrayIndexerExpression>
																		<primitiveExpression value="th-TH"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<propertyReferenceExpression name="Calendar">
																			<propertyReferenceExpression name="DateTimeFormat">
																				<propertyReferenceExpression name="CurrentUICulture">
																					<propertyReferenceExpression name="CurrentThread">
																						<typeReferenceExpression type="Thread"/>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																		<objectCreateExpression type="GregorianCalendar"/>
																	</assignStatement>
																</trueStatements>
															</conditionStatement>
														</xsl:if>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IsTypeOf">
																	<propertyReferenceExpression name="Handler">
																		<variableReferenceExpression name="ctx"/>
																	</propertyReferenceExpression>
																	<typeReferenceExpression type="Page"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="Page" name="p">
																	<init>
																		<castExpression targetType="Page">
																			<propertyReferenceExpression name="Handler">
																				<variableReferenceExpression name="ctx"/>
																			</propertyReferenceExpression>
																		</castExpression>
																	</init>
																</variableDeclarationStatement>
																<assignStatement>
																	<propertyReferenceExpression name="Culture">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="ci"/>
																		</target>
																		<indices>
																			<primitiveExpression value="0"/>
																		</indices>
																	</arrayIndexerExpression>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="UICulture">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="ci"/>
																		</target>
																		<indices>
																			<primitiveExpression value="1"/>
																		</indices>
																	</arrayIndexerExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="cultureCookie"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<propertyReferenceExpression name="Value">
																						<variableReferenceExpression name="cultureCookie"/>
																					</propertyReferenceExpression>
																					<propertyReferenceExpression name="AutoDetectCulture">
																						<typeReferenceExpression type="CultureManager"/>
																					</propertyReferenceExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<propertyReferenceExpression name="Expires">
																						<variableReferenceExpression name="cultureCookie"/>
																					</propertyReferenceExpression>
																					<methodInvokeExpression methodName="AddDays">
																						<target>
																							<propertyReferenceExpression name="Now">
																								<typeReferenceExpression type="DateTime"/>
																							</propertyReferenceExpression>
																						</target>
																						<parameters>
																							<primitiveExpression value="-14"/>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																			</trueStatements>
																			<falseStatements>
																				<assignStatement>
																					<propertyReferenceExpression name="Expires">
																						<variableReferenceExpression name="cultureCookie"/>
																					</propertyReferenceExpression>
																					<methodInvokeExpression methodName="AddDays">
																						<target>
																							<propertyReferenceExpression name="Now">
																								<typeReferenceExpression type="DateTime"/>
																							</propertyReferenceExpression>
																						</target>
																						<parameters>
																							<primitiveExpression value="14"/>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																			</falseStatements>
																		</conditionStatement>
																		<methodInvokeExpression methodName="AppendCookie">
																			<target>
																				<typeReferenceExpression type="ApplicationServices"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="cultureCookie"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>

													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</memberMethod>
							</xsl:otherwise>
						</xsl:choose>
						<!-- method ResolveEmbeddedResourceName(string, string) -->
						<memberMethod returnType="System.String" name="ResolveEmbeddedResourceName">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="resourceName"/>
								<parameter type="System.String" name="culture"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ResolveEmbeddedResourceName">
										<parameters>
											<propertyReferenceExpression name="Assembly">
												<typeofExpression type="CultureManager"/>
											</propertyReferenceExpression>
											<argumentReferenceExpression name="resourceName"/>
											<argumentReferenceExpression name="culture"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ResolveEmbeddedResourceName(string) -->
						<memberMethod returnType="System.String" name="ResolveEmbeddedResourceName">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="resourceName"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ResolveEmbeddedResourceName">
										<parameters>
											<propertyReferenceExpression name="Assembly">
												<typeofExpression type="CultureManager"/>
											</propertyReferenceExpression>
											<argumentReferenceExpression name="resourceName"/>
											<propertyReferenceExpression name="Name">
												<propertyReferenceExpression name="CurrentUICulture">
													<propertyReferenceExpression name="CurrentThread">
														<typeReferenceExpression type="Thread"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ResolveEmbeddedResourceName(Assembly, string, string) -->
						<memberMethod returnType="System.String" name="ResolveEmbeddedResourceName">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="Assembly" name="a"/>
								<parameter type="System.String" name="resourceName"/>
								<parameter type="System.String" name="culture"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="extension">
									<init>
										<methodInvokeExpression methodName="GetExtension">
											<target>
												<typeReferenceExpression type="Path"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="resourceName"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="fileName">
									<init>
										<methodInvokeExpression methodName="GetFileNameWithoutExtension">
											<target>
												<typeReferenceExpression type="Path"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="resourceName"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="localizedResourceName">
									<init>
										<methodInvokeExpression methodName="Format">
											<target>
												<typeReferenceExpression type="String"/>
											</target>
											<parameters>
												<primitiveExpression value="{{0}}.{{1}}{{2}}"/>
												<variableReferenceExpression name="fileName"/>
												<methodInvokeExpression methodName="Replace">
													<target>
														<variableReferenceExpression name="culture"/>
													</target>
													<parameters>
														<primitiveExpression value="-"/>
														<primitiveExpression value="_"/>
													</parameters>
												</methodInvokeExpression>
												<variableReferenceExpression name="extension"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="ManifestResourceInfo" name="mri">
									<init>
										<methodInvokeExpression methodName="GetManifestResourceInfo">
											<target>
												<argumentReferenceExpression name="a"/>
											</target>
											<parameters>
												<variableReferenceExpression name="localizedResourceName"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression  operator="IdentityEquality">
											<variableReferenceExpression name="mri"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Contains">
													<target>
														<variableReferenceExpression name="culture"/>
													</target>
													<parameters>
														<primitiveExpression value="-"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="localizedResourceName"/>
													<methodInvokeExpression methodName="Format">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<primitiveExpression value="{{0}}.{{1}}_{{2}}"/>
															<variableReferenceExpression name="fileName"/>
															<methodInvokeExpression methodName="Replace">
																<target>
																	<methodInvokeExpression methodName="Substring">
																		<target>
																			<variableReferenceExpression name="culture"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="0"/>
																			<methodInvokeExpression methodName="LastIndexOf">
																				<target>
																					<variableReferenceExpression name="culture"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="-"/>
																				</parameters>
																			</methodInvokeExpression>
																		</parameters>
																	</methodInvokeExpression>
																</target>
																<parameters>
																	<primitiveExpression value="-"/>
																	<primitiveExpression value="_"/>
																</parameters>
															</methodInvokeExpression>
															<variableReferenceExpression name="extension"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="localizedResourceName"/>
													<methodInvokeExpression methodName="Format">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<primitiveExpression value="{{0}}.{{1}}_{{2}}"/>
															<variableReferenceExpression name="fileName"/>
															<variableReferenceExpression name="culture"/>
															<variableReferenceExpression name="extension"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="mri"/>
											<methodInvokeExpression methodName="GetManifestResourceInfo">
												<target>
													<argumentReferenceExpression name="a"/>
												</target>
												<parameters>
													<variableReferenceExpression name="localizedResourceName"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="mri"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="localizedResourceName"/>
											<argumentReferenceExpression name="resourceName"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="localizedResourceName"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class GenericHandlerBase -->
				<typeDeclaration name="GenericHandlerBase">
					<members>
						<!-- constructor -->
						<constructor>
							<attributes public="true"/>
							<statements>
								<methodInvokeExpression methodName="Initialize">
									<target>
										<typeReferenceExpression type="CultureManager"/>
									</target>
								</methodInvokeExpression>
							</statements>
						</constructor>
						<!-- GenerateOutputFileName(ActionArgs, string) -->
						<memberMethod returnType="System.String" name="GenerateOutputFileName">
							<attributes family="true"/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="System.String" name="outputFileName"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="CommandArgument">
										<argumentReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="CommandName">
										<argumentReferenceExpression name="args"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="CommandName">
										<argumentReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<primitiveExpression value="FileName"/>
								</assignStatement>
								<variableDeclarationStatement type="List" name="values">
									<typeArguments>
										<typeReference type="FieldValue"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="FieldValue"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<variableReferenceExpression name="values"/>
									</target>
									<parameters>
										<objectCreateExpression type="FieldValue">
											<parameters>
												<primitiveExpression value="FileName"/>
												<argumentReferenceExpression name="outputFileName"/>
											</parameters>
										</objectCreateExpression>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<propertyReferenceExpression name="Values">
										<argumentReferenceExpression name="args"/>
									</propertyReferenceExpression>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="values"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement type="ActionResult" name="result">
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
												<propertyReferenceExpression name="Controller">
													<variableReferenceExpression name="args"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="View">
													<argumentReferenceExpression name="args"/>
												</propertyReferenceExpression>
												<argumentReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="FieldValue" name="v"/>
									<target>
										<propertyReferenceExpression name="Values">
											<variableReferenceExpression name="result"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Name">
														<variableReferenceExpression name="v"/>
													</propertyReferenceExpression>
													<primitiveExpression value="FileName"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="outputFileName"/>
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
								<methodReturnStatement>
									<argumentReferenceExpression name="outputFileName"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AppendDownloadTokenCookie() -->
						<memberMethod name="AppendDownloadTokenCookie">
							<attributes family="true"/>
							<statements>
								<variableDeclarationStatement type="HttpContext" name="context">
									<init>
										<propertyReferenceExpression name="Current">
											<typeReferenceExpression type="HttpContext"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="downloadToken">
									<init>
										<primitiveExpression value="APPFACTORYDOWNLOADTOKEN"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="HttpCookie" name="tokenCookie">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Cookies">
													<propertyReferenceExpression name="Request">
														<variableReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<indices>
												<variableReferenceExpression name="downloadToken"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="tokenCookie"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Value">
												<variableReferenceExpression name="tokenCookie"/>
											</propertyReferenceExpression>
											<stringFormatExpression format="{{0}},{{1}}">
												<propertyReferenceExpression name="Value">
													<variableReferenceExpression name="tokenCookie"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="NewGuid">
													<target>
														<typeReferenceExpression type="Guid"/>
													</target>
												</methodInvokeExpression>
											</stringFormatExpression>
										</assignStatement>
										<methodInvokeExpression methodName="AppendCookie">
											<target>
												<typeReferenceExpression type="ApplicationServices"/>
											</target>
											<parameters>
												<variableReferenceExpression name="tokenCookie"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>

	<xsl:template name="ListCulture">
		<xsl:param name="List" select="$SupportedCultures"/>
		<xsl:variable name="Head" select="substring-before($List, ';')"/>
		<xsl:variable name="Tail" select="substring-after($List, ';')"/>
		<primitiveExpression value="{cm:Trim($Head)}"/>
		<xsl:if test="$Head!=$Tail and contains($Tail, ';')">
			<xsl:call-template name="ListCulture">
				<xsl:with-param name="List" select="$Tail"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
