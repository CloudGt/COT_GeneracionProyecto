<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>

	<xsl:variable name="CodeDomProvider">
		<xsl:value-of select="/a:project/@codeDomProvider"/>
	</xsl:variable>

	<xsl:template match="/">
		<compileUnit namespace="{a:project/a:namespace}.Data">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Data.Common"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Reflection"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Xml.XPath"/>
			</imports>
			<types>
				<!-- class RuleAttribute-->
				<typeDeclaration name="RuleAttribute" >
					<comment>
						<![CDATA[
    /// <summary>
    /// Links a data controller business rule to a method with its implementation.
    /// </summary>
    ]]>
					</comment>
					<customAttributes>
						<customAttribute name="AttributeUsage">
							<arguments>
								<propertyReferenceExpression name="Method">
									<typeReferenceExpression type="AttributeTargets"/>
								</propertyReferenceExpression>
								<attributeArgument name="AllowMultiple">
									<primitiveExpression value="true"/>
								</attributeArgument>
								<attributeArgument name="Inherited">
									<primitiveExpression value="true"/>
								</attributeArgument>
							</arguments>
						</customAttribute>
					</customAttributes>
					<baseTypes>
						<typeReference type="Attribute"/>
					</baseTypes>
					<members>
						<!-- property Id -->
						<memberProperty type="System.String" name="Id">
							<comment>
								<![CDATA[
        /// <summary>
        /// The Id of the data controller business rule.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- constructor (string) -->
						<constructor>
							<comment>
								<![CDATA[
        /// <summary>
        /// Links the method to the business rule by its Id.
        /// </summary>
        /// <param name="id">The Id of the data controller business rule.</param>
              ]]>
							</comment>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="id"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="Id">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="id"/>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>
				<!-- class ActionHandlerBase -->
				<typeDeclaration name="ActionHandlerBase">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="System.Object"/>
						<typeReference type="{a:project/a:namespace}.Data.IActionHandler"/>
					</baseTypes>
					<members>
						<!-- property Arguments -->
						<memberProperty type="ActionArgs" name="Arguments">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Result -->
						<memberField type="ActionResult" name="result"/>
						<memberProperty type="ActionResult" name="Result">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="result"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="result"/>
											<objectCreateExpression type="ActionResult"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
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
						<!-- method PreventDefault()-->
						<memberMethod name="PreventDefault">
							<attributes public="true" final="true"/>
							<statements>
								<methodInvokeExpression methodName="PreventDefault">
									<parameters>
										<primitiveExpression value="false"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method PreventDefault(bool) -->
						<memberMethod name="PreventDefault">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.Boolean" name="cancelSelectedValues"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="result"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Canceled">
												<fieldReferenceExpression name="result"/>
											</propertyReferenceExpression>
											<primitiveExpression value="true"/>
										</assignStatement>
										<conditionStatement>
											<condition>
												<argumentReferenceExpression name="cancelSelectedValues"/>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="CanceledSelectedValues">
														<fieldReferenceExpression name="result"/>
													</propertyReferenceExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- property Whitelist -->
						<memberField name="whitelist" type="List">
							<typeArguments>
								<typeReference type="System.String"/>
							</typeArguments>
						</memberField>
						<memberProperty type="System.String" name="Whitelist">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="whitelist"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<stringEmptyExpression/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Join">
										<target>
											<typeReferenceExpression type="System.String"/>
										</target>
										<parameters>
											<primitiveExpression value=","/>
											<methodInvokeExpression methodName="ToArray">
												<target>
													<fieldReferenceExpression name="whitelist"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="whitelist"/>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
										<parameters>
											<methodInvokeExpression methodName="Split">
												<target>
													<argumentReferenceExpression name="value"/>
												</target>
												<parameters>
													<primitiveExpression value="," convertTo="Char"/>
													<primitiveExpression value=";" convertTo="Char"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</objectCreateExpression>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property Blacklist -->
						<memberField name="blacklist" type="List">
							<typeArguments>
								<typeReference type="System.String"/>
							</typeArguments>
						</memberField>
						<memberProperty type="System.String" name="Blacklist">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="blacklist"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<stringEmptyExpression/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Join">
										<target>
											<typeReferenceExpression type="System.String"/>
										</target>
										<parameters>
											<primitiveExpression value=","/>
											<methodInvokeExpression methodName="ToArray">
												<target>
													<fieldReferenceExpression name="blacklist"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="blacklist"/>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
										<parameters>
											<methodInvokeExpression methodName="Split">
												<target>
													<argumentReferenceExpression name="value"/>
												</target>
												<parameters>
													<primitiveExpression value="," convertTo="Char"/>
													<primitiveExpression value=";" convertTo="Char"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</objectCreateExpression>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- method ClearBlackAndWhiteLists()-->
						<memberMethod name="ClearBlackAndWhiteLists">
							<attributes public="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="whitelist"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Clear">
											<target>
												<fieldReferenceExpression name="whitelist"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="blacklist"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Clear">
											<target>
												<fieldReferenceExpression name="blacklist"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method AddToWhitelist(string) -->
						<memberMethod name="AddToWhitelist">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="rule"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="whitelist"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="whitelist"/>
											<objectCreateExpression type="List">
												<typeArguments>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="Contains">
												<target>
													<fieldReferenceExpression name="whitelist"/>
												</target>
												<parameters>
													<variableReferenceExpression name="rule"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<fieldReferenceExpression name="whitelist"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="rule"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method RemoveFromWhitelist(string) -->
						<memberMethod name="RemoveFromWhitelist">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="rule"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="whitelist"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Remove">
											<target>
												<fieldReferenceExpression name="whitelist"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="rule"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method RuleInWhitelist(string)-->
						<memberMethod returnType="System.Boolean" name="RuleInWhitelist">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="rule"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanOr">
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="whitelist"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="Count">
													<fieldReferenceExpression name="whitelist"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
											<methodInvokeExpression methodName="Contains">
												<target>
													<fieldReferenceExpression name="whitelist"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="rule"/>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AddToBlacklist(string) -->
						<memberMethod name="AddToBlacklist">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="rule"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="blacklist"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="blacklist"/>
											<objectCreateExpression type="List">
												<typeArguments>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="Contains">
												<target>
													<fieldReferenceExpression name="blacklist"/>
												</target>
												<parameters>
													<variableReferenceExpression name="rule"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<fieldReferenceExpression name="blacklist"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="rule"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method RemoveFromBlacklist(string) -->
						<memberMethod name="RemoveFromBlacklist">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="rule"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="blacklist"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Remove">
											<target>
												<fieldReferenceExpression name="blacklist"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="rule"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method RuleInBlacklist(string)-->
						<memberMethod returnType="System.Boolean" name="RuleInBlacklist">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="rule"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanAnd">
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="blacklist"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
										<methodInvokeExpression methodName="Contains">
											<target>
												<fieldReferenceExpression name="blacklist"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="rule"/>
											</parameters>
										</methodInvokeExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ExecuteMethod(ActionArgs, ActionResult, ActionPhase) -->
						<memberMethod name="ExecuteMethod">
							<attributes family="true"/>
							<customAttributes>
								<customAttribute name="System.Diagnostics.DebuggerStepThrough"/>
							</customAttributes>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
								<parameter type="ActionPhase" name="phase"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Boolean" name="match">
									<init>
										<methodInvokeExpression methodName="InternalExecuteMethod">
											<parameters>
												<argumentReferenceExpression name="args"/>
												<argumentReferenceExpression name="result"/>
												<argumentReferenceExpression name="phase"/>
												<primitiveExpression value="true"/>
												<primitiveExpression value="true"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<variableReferenceExpression name="match"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="match"/>
											<methodInvokeExpression methodName="InternalExecuteMethod">
												<parameters>
													<argumentReferenceExpression name="args"/>
													<argumentReferenceExpression name="result"/>
													<argumentReferenceExpression name="phase"/>
													<primitiveExpression value="true"/>
													<primitiveExpression value="false"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<variableReferenceExpression name="match"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="match"/>
											<methodInvokeExpression methodName="InternalExecuteMethod">
												<parameters>
													<argumentReferenceExpression name="args"/>
													<argumentReferenceExpression name="result"/>
													<argumentReferenceExpression name="phase"/>
													<primitiveExpression value="false"/>
													<primitiveExpression value="true"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<variableReferenceExpression name="match"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="InternalExecuteMethod">
											<parameters>
												<argumentReferenceExpression name="args"/>
												<argumentReferenceExpression name="result"/>
												<argumentReferenceExpression name="phase"/>
												<primitiveExpression value="false"/>
												<primitiveExpression value="false"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method InternalExecuteMethod(ActionArgs, ActionResult, ActionPhase) -->
						<memberMethod returnType="System.Boolean" name="InternalExecuteMethod">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
								<parameter type="ActionPhase" name="phase"/>
								<parameter type="System.Boolean" name="viewMatch"/>
								<parameter type="System.Boolean" name="argumentMatch"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="arguments"/>
									<argumentReferenceExpression name="args"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="result"/>
									<argumentReferenceExpression name="result"/>
								</assignStatement>
								<variableDeclarationStatement type="System.Boolean" name="success">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="MethodInfo[]" name="methods">
									<init>
										<methodInvokeExpression methodName="GetMethods">
											<target>
												<methodInvokeExpression methodName="GetType"/>
											</target>
											<parameters>
												<binaryOperatorExpression operator="BitwiseOr">
													<propertyReferenceExpression name="Public">
														<typeReferenceExpression type="BindingFlags"/>
													</propertyReferenceExpression>
													<binaryOperatorExpression operator="BitwiseOr">
														<propertyReferenceExpression name="NonPublic">
															<typeReferenceExpression type="BindingFlags"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="Instance">
															<typeReferenceExpression type="BindingFlags"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="MethodInfo" name="method"/>
									<target>
										<variableReferenceExpression name="methods"/>
									</target>
									<statements>
										<variableDeclarationStatement type="System.Object[]" name="filters">
											<init>
												<methodInvokeExpression methodName="GetCustomAttributes">
													<target>
														<variableReferenceExpression name="method"/>
													</target>
													<parameters>
														<typeofExpression type="ControllerActionAttribute"/>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="ControllerActionAttribute" name="action" var="false"/>
											<target>
												<variableReferenceExpression name="filters"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="BooleanOr">
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Controller">
																		<variableReferenceExpression name="action"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="Controller">
																		<argumentReferenceExpression name="args"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
																<binaryOperatorExpression operator="BooleanAnd">
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<propertyReferenceExpression name="Controller">
																			<variableReferenceExpression name="args"/>
																		</propertyReferenceExpression>
																	</unaryOperatorExpression>
																	<methodInvokeExpression methodName="IsMatch">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Controller">
																				<variableReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="Controller">
																				<variableReferenceExpression name="action"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanOr">
																<binaryOperatorExpression operator="BooleanAnd">
																	<unaryOperatorExpression operator="Not">
																		<argumentReferenceExpression name="viewMatch"/>
																	</unaryOperatorExpression>
																	<unaryOperatorExpression operator="IsNullOrEmpty">
																		<propertyReferenceExpression name="View">
																			<variableReferenceExpression name="action"/>
																		</propertyReferenceExpression>
																	</unaryOperatorExpression>
																</binaryOperatorExpression>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="View">
																		<variableReferenceExpression name="action"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="View">
																		<argumentReferenceExpression name="args"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="ValueEquality">
																		<propertyReferenceExpression name="CommandName">
																			<variableReferenceExpression name="action"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="CommandName">
																			<argumentReferenceExpression name="args"/>
																		</propertyReferenceExpression>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="BooleanOr">
																		<binaryOperatorExpression operator="BooleanAnd">
																			<unaryOperatorExpression operator="Not">
																				<argumentReferenceExpression name="argumentMatch"/>
																			</unaryOperatorExpression>
																			<unaryOperatorExpression operator="IsNullOrEmpty">
																				<propertyReferenceExpression name="CommandArgument">
																					<variableReferenceExpression name="action"/>
																				</propertyReferenceExpression>
																			</unaryOperatorExpression>
																		</binaryOperatorExpression>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="CommandArgument">
																				<variableReferenceExpression name="action"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="CommandArgument">
																				<argumentReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="Phase">
																				<variableReferenceExpression name="action"/>
																			</propertyReferenceExpression>
																			<argumentReferenceExpression name="phase"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="ParameterInfo[]" name="parameters">
																			<init>
																				<methodInvokeExpression methodName="GetParameters">
																					<target>
																						<variableReferenceExpression name="method"/>
																					</target>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanAnd">
																					<binaryOperatorExpression operator="ValueEquality">
																						<propertyReferenceExpression name="Length">
																							<variableReferenceExpression name="parameters"/>
																						</propertyReferenceExpression>
																						<primitiveExpression value="2"/>
																					</binaryOperatorExpression>
																					<binaryOperatorExpression operator="BooleanAnd">
																						<binaryOperatorExpression operator="IdentityEquality">
																							<propertyReferenceExpression name="ParameterType">
																								<arrayIndexerExpression>
																									<target>
																										<variableReferenceExpression name="parameters"/>
																									</target>
																									<indices>
																										<primitiveExpression value="0"/>
																									</indices>
																								</arrayIndexerExpression>
																							</propertyReferenceExpression>
																							<typeofExpression type="ActionArgs"/>
																						</binaryOperatorExpression>
																						<binaryOperatorExpression operator="IdentityEquality">
																							<propertyReferenceExpression name="ParameterType">
																								<arrayIndexerExpression>
																									<target>
																										<variableReferenceExpression name="parameters"/>
																									</target>
																									<indices>
																										<primitiveExpression value="1"/>
																									</indices>
																								</arrayIndexerExpression>
																							</propertyReferenceExpression>
																							<typeofExpression type="ActionResult"/>
																						</binaryOperatorExpression>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Invoke">
																					<target>
																						<variableReferenceExpression name="method"/>
																					</target>
																					<parameters>
																						<thisReferenceExpression/>
																						<arrayCreateExpression>
																							<createType type="System.Object"/>
																							<initializers>
																								<argumentReferenceExpression name="args"/>
																								<argumentReferenceExpression name="result"/>
																							</initializers>
																						</arrayCreateExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																			<falseStatements>
																				<variableDeclarationStatement type="System.Object[]" name="arguments">
																					<init>
																						<arrayCreateExpression>
																							<createType type="System.Object"/>
																							<sizeExpression>
																								<propertyReferenceExpression name="Length">
																									<variableReferenceExpression name="parameters"/>
																								</propertyReferenceExpression>
																							</sizeExpression>
																						</arrayCreateExpression>
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
																								<variableReferenceExpression name="parameters"/>
																							</propertyReferenceExpression>
																						</binaryOperatorExpression>
																					</test>
																					<increment>
																						<variableReferenceExpression name="i"/>
																					</increment>
																					<statements>
																						<variableDeclarationStatement type="ParameterInfo" name="p">
																							<init>
																								<arrayIndexerExpression>
																									<target>
																										<variableReferenceExpression name="parameters"/>
																									</target>
																									<indices>
																										<variableReferenceExpression name="i"/>
																									</indices>
																								</arrayIndexerExpression>
																							</init>
																						</variableDeclarationStatement>
																						<variableDeclarationStatement type="FieldValue" name="v">
																							<init>
																								<!--<arrayIndexerExpression>
                                                  <target>
                                                    <argumentReferenceExpression name="args"/>
                                                  </target>
                                                  <indices>
                                                    <propertyReferenceExpression name="Name">
                                                      <variableReferenceExpression name="p"/>
                                                    </propertyReferenceExpression>
                                                  </indices>
                                                </arrayIndexerExpression>-->
																								<methodInvokeExpression methodName="SelectFieldValueObject">
																									<parameters>
																										<propertyReferenceExpression name="Name">
																											<variableReferenceExpression name="p"/>
																										</propertyReferenceExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</init>
																						</variableDeclarationStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="IdentityInequality">
																									<variableReferenceExpression name="v"/>
																									<primitiveExpression value="null"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<conditionStatement>
																									<condition>
																										<methodInvokeExpression methodName="Equals">
																											<target>
																												<propertyReferenceExpression name="ParameterType">
																													<variableReferenceExpression name="p"/>
																												</propertyReferenceExpression>
																											</target>
																											<parameters>
																												<typeofExpression type="FieldValue"/>
																											</parameters>
																										</methodInvokeExpression>
																									</condition>
																									<trueStatements>
																										<assignStatement>
																											<arrayIndexerExpression>
																												<target>
																													<variableReferenceExpression name="arguments"/>
																												</target>
																												<indices>
																													<variableReferenceExpression name="i"/>
																												</indices>
																											</arrayIndexerExpression>
																											<variableReferenceExpression name="v"/>
																										</assignStatement>
																									</trueStatements>
																									<falseStatements>
																										<tryStatement>
																											<statements>
																												<assignStatement>
																													<arrayIndexerExpression>
																														<target>
																															<variableReferenceExpression name="arguments"/>
																														</target>
																														<indices>
																															<variableReferenceExpression name="i"/>
																														</indices>
																													</arrayIndexerExpression>
																													<methodInvokeExpression methodName="ConvertToType">
																														<target>
																															<typeReferenceExpression type="DataControllerBase"/>
																														</target>
																														<parameters>
																															<propertyReferenceExpression name="ParameterType">
																																<variableReferenceExpression name="p"/>
																															</propertyReferenceExpression>
																															<propertyReferenceExpression name="Value">
																																<variableReferenceExpression name="v"/>
																															</propertyReferenceExpression>
																														</parameters>
																													</methodInvokeExpression>
																												</assignStatement>
																												<!--<conditionStatement>
                                                          <condition>
                                                            <methodInvokeExpression methodName="Equals">
                                                              <target>
                                                                <propertyReferenceExpression name="ParameterType">
                                                                  <variableReferenceExpression name="p"/>
                                                                </propertyReferenceExpression>
                                                              </target>
                                                              <parameters>
                                                                <typeofExpression type="Guid"/>
                                                              </parameters>
                                                            </methodInvokeExpression>
                                                          </condition>
                                                          <trueStatements>
                                                            <assignStatement>
                                                              <arrayIndexerExpression>
                                                                <target>
                                                                  <variableReferenceExpression name="arguments"/>
                                                                </target>
                                                                <indices>
                                                                  <variableReferenceExpression name="i"/>
                                                                </indices>
                                                              </arrayIndexerExpression>
                                                              <objectCreateExpression type="Guid">
                                                                <parameters>
                                                                  <methodInvokeExpression methodName="ToString">
                                                                    <target>
                                                                      <typeReferenceExpression type="Convert"/>
                                                                    </target>
                                                                    <parameters>
                                                                      <propertyReferenceExpression name="Value">
                                                                        <variableReferenceExpression name="v"/>
                                                                      </propertyReferenceExpression>
                                                                    </parameters>
                                                                  </methodInvokeExpression>
                                                                </parameters>
                                                              </objectCreateExpression>
                                                            </assignStatement>
                                                          </trueStatements>
                                                          <falseStatements>
                                                            <conditionStatement>
                                                              <condition>
                                                                <propertyReferenceExpression name="IsGenericType">
                                                                  <propertyReferenceExpression name="ParameterType">
                                                                    <variableReferenceExpression name="p"/>
                                                                  </propertyReferenceExpression>
                                                                </propertyReferenceExpression>
                                                              </condition>
                                                              <trueStatements>
                                                                <variableDeclarationStatement type="System.Object" name="argumentValue">
                                                                  <init>
                                                                    <propertyReferenceExpression name="Value">
                                                                      <variableReferenceExpression name="v"/>
                                                                    </propertyReferenceExpression>
                                                                  </init>
                                                                </variableDeclarationStatement>
                                                                -->
																												<!-- 
																														p.ParameterType.GetProperty("Value").PropertyType
																														-->
																												<!--
                                                                <conditionStatement>
                                                                  <condition>
                                                                    <binaryOperatorExpression operator="IsTypeOf">
                                                                      <variableReferenceExpression name="argumentValue"/>
                                                                      <typeReferenceExpression type="IConvertible"/>
                                                                    </binaryOperatorExpression>
                                                                  </condition>
                                                                  <trueStatements>
                                                                    <assignStatement>
                                                                      <variableReferenceExpression name="argumentValue"/>
                                                                      <methodInvokeExpression methodName="ChangeType">
                                                                        <target>
                                                                          <typeReferenceExpression type="Convert"/>
                                                                        </target>
                                                                        <parameters>
                                                                          <variableReferenceExpression name="argumentValue"/>
                                                                          <propertyReferenceExpression name="PropertyType">
                                                                            <methodInvokeExpression methodName="GetProperty">
                                                                              <target>
                                                                                <propertyReferenceExpression name="ParameterType">
                                                                                  <variableReferenceExpression name="p"/>
                                                                                </propertyReferenceExpression>
                                                                              </target>
                                                                              <parameters>
                                                                                <primitiveExpression value="Value"/>
                                                                              </parameters>
                                                                            </methodInvokeExpression>
                                                                          </propertyReferenceExpression>
                                                                        </parameters>
                                                                      </methodInvokeExpression>
                                                                    </assignStatement>
                                                                  </trueStatements>
                                                                </conditionStatement>
                                                                <assignStatement>
                                                                  <arrayIndexerExpression>
                                                                    <target>
                                                                      <variableReferenceExpression name="arguments"/>
                                                                    </target>
                                                                    <indices>
                                                                      <variableReferenceExpression name="i"/>
                                                                    </indices>
                                                                  </arrayIndexerExpression>
                                                                  <variableReferenceExpression name="argumentValue"/>
                                                                </assignStatement>
                                                              </trueStatements>
                                                              <falseStatements>
                                                                <variableDeclarationStatement type="System.Object" name="argumentValue">
                                                                  <init>
                                                                    <propertyReferenceExpression name="Value">
                                                                      <variableReferenceExpression name="v"/>
                                                                    </propertyReferenceExpression>
                                                                  </init>
                                                                </variableDeclarationStatement>
                                                                <conditionStatement>
                                                                  <condition>
                                                                    <binaryOperatorExpression operator="IsTypeOf">
                                                                      <variableReferenceExpression name="argumentValue"/>
                                                                      <typeReferenceExpression type="IConvertible"/>
                                                                    </binaryOperatorExpression>
                                                                  </condition>
                                                                  <trueStatements>
                                                                    <assignStatement>
                                                                      <variableReferenceExpression name="argumentValue"/>
                                                                      <methodInvokeExpression methodName="ChangeType">
                                                                        <target>
                                                                          <typeReferenceExpression type="Convert"/>
                                                                        </target>
                                                                        <parameters>
                                                                          <variableReferenceExpression name="argumentValue"/>
                                                                          <propertyReferenceExpression name="ParameterType">
                                                                            <variableReferenceExpression name="p"/>
                                                                          </propertyReferenceExpression>
                                                                        </parameters>
                                                                      </methodInvokeExpression>
                                                                    </assignStatement>
                                                                  </trueStatements>
                                                                </conditionStatement>
                                                                <assignStatement>
                                                                  <arrayIndexerExpression>
                                                                    <target>
                                                                      <variableReferenceExpression name="arguments"/>
                                                                    </target>
                                                                    <indices>
                                                                      <variableReferenceExpression name="i"/>
                                                                    </indices>
                                                                  </arrayIndexerExpression>
                                                                  <variableReferenceExpression name="argumentValue"/>
                                                                </assignStatement>
                                                              </falseStatements>
                                                            </conditionStatement>
                                                          </falseStatements>
                                                        </conditionStatement>-->
																											</statements>
																											<catch exceptionType="Exception"></catch>
																										</tryStatement>
																									</falseStatements>
																								</conditionStatement>
																							</trueStatements>
																						</conditionStatement>
																					</statements>
																				</forStatement>
																				<methodInvokeExpression methodName="Invoke">
																					<target>
																						<variableReferenceExpression name="method"/>
																					</target>
																					<parameters>
																						<thisReferenceExpression/>
																						<variableReferenceExpression name="arguments"/>
																					</parameters>
																				</methodInvokeExpression>
																				<assignStatement>
																					<variableReferenceExpression name="success"/>
																					<primitiveExpression value="true"/>
																				</assignStatement>
																			</falseStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="success"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method BeforeSqlAction(ActionArgs, ActionResult) -->
						<memberMethod name="BeforeSqlAction">
							<attributes family="true" />
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
							<statements>
							</statements>
						</memberMethod>
						<!-- method AfterSqlAction(ActionArgs, ActionResult) -->
						<memberMethod name="AfterSqlAction">
							<attributes family="true" />
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
						</memberMethod>
						<!-- method BeforeSqlAction(ActionArgs, ActionResult) -->
						<memberMethod name="ExecuteAction">
							<attributes family="true" />
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
						</memberMethod>
						<!-- method IActionHandler.BeforeSqlAction(ActionArgs, ActionResult) -->
						<memberMethod name="BeforeSqlAction" privateImplementationType="IActionHandler">
							<attributes />
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteMethod">
									<parameters>
										<argumentReferenceExpression name="args"/>
										<argumentReferenceExpression name="result"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="BeforeSqlAction">
									<parameters>
										<argumentReferenceExpression name="args"/>
										<argumentReferenceExpression name="result"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method IActionHandler.AfterSqlAction(ActionArgs, ActionResult) -->
						<memberMethod name="AfterSqlAction" privateImplementationType="IActionHandler">
							<attributes />
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteMethod">
									<parameters>
										<argumentReferenceExpression name="args"/>
										<argumentReferenceExpression name="result"/>
										<propertyReferenceExpression name="After">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="AfterSqlAction">
									<parameters>
										<argumentReferenceExpression name="args"/>
										<argumentReferenceExpression name="result"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method IActionHandler.ExecuteAction(ActionArgs, ActionResult) -->
						<memberMethod name="ExecuteAction" privateImplementationType="IActionHandler">
							<attributes />
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteMethod">
									<parameters>
										<argumentReferenceExpression name="args"/>
										<argumentReferenceExpression name="result"/>
										<propertyReferenceExpression name="Execute">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="ExecuteAction">
									<parameters>
										<argumentReferenceExpression name="args"/>
										<argumentReferenceExpression name="result"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method SelectFieldValueObject(string) -->
						<memberMethod returnType="FieldValue" name="SelectFieldValueObject">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method BuildingDataRows() -->
						<memberMethod returnType="System.Boolean" name="BuildingDataRows">
							<attributes family="true"/>
							<statements>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ExecuteRule(XPathNavigator) -->
						<memberMethod name="ExecuteRule">
							<attributes family="true" />
							<parameters>
								<parameter type="XPathNavigator" name="rule"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteRule">
									<parameters>
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="rule"/>
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
							</statements>
						</memberMethod>
						<!-- method BlockRule(string) -->
						<memberMethod name="BlockRule">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="id"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="BuildingDataRows"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AddToBlacklist">
											<parameters>
												<argumentReferenceExpression name="id"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ExecuteRule(string) -->
						<memberMethod name="ExecuteRule">
							<attributes family="true" />
							<parameters>
								<parameter type="System.String" name="ruleId"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="MethodInfo[]" name="methods">
									<init>
										<methodInvokeExpression methodName="GetMethods">
											<target>
												<methodInvokeExpression methodName="GetType"/>
											</target>
											<parameters>
												<binaryOperatorExpression operator="BitwiseOr">
													<propertyReferenceExpression name="Public">
														<typeReferenceExpression type="BindingFlags"/>
													</propertyReferenceExpression>
													<binaryOperatorExpression operator="BitwiseOr">
														<propertyReferenceExpression name="NonPublic">
															<typeReferenceExpression type="BindingFlags"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="Instance">
															<typeReferenceExpression type="BindingFlags"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="MethodInfo" name="method"/>
									<target>
										<variableReferenceExpression name="methods"/>
									</target>
									<statements>
										<variableDeclarationStatement type="System.Object[]" name="ruleBindings">
											<init>
												<methodInvokeExpression methodName="GetCustomAttributes">
													<target>
														<variableReferenceExpression name="method"/>
													</target>
													<parameters>
														<typeofExpression type="RuleAttribute"/>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="RuleAttribute" name="ra" var="false"/>
											<target>
												<variableReferenceExpression name="ruleBindings"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="Id">
																<variableReferenceExpression name="ra"/>
															</propertyReferenceExpression>
															<argumentReferenceExpression name="ruleId"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="BlockRule">
															<parameters>
																<argumentReferenceExpression name="ruleId"/>
															</parameters>
														</methodInvokeExpression>

														<variableDeclarationStatement type="ParameterInfo[]" name="parameters">
															<init>
																<methodInvokeExpression methodName="GetParameters">
																	<target>
																		<variableReferenceExpression name="method"/>
																	</target>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Object[]" name="arguments">
															<init>
																<arrayCreateExpression>
																	<createType type="System.Object"/>
																	<sizeExpression>
																		<propertyReferenceExpression name="Length">
																			<variableReferenceExpression name="parameters"/>
																		</propertyReferenceExpression>
																	</sizeExpression>
																</arrayCreateExpression>
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
																		<variableReferenceExpression name="parameters"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</test>
															<increment>
																<variableReferenceExpression name="i"/>
															</increment>
															<statements>
																<variableDeclarationStatement type="ParameterInfo" name="p">
																	<init>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="parameters"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="i"/>
																			</indices>
																		</arrayIndexerExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="IsSubclassOf">
																			<target>
																				<propertyReferenceExpression name="ParameterType">
																					<variableReferenceExpression name="p"/>
																				</propertyReferenceExpression>
																			</target>
																			<parameters>
																				<typeofExpression type="BusinessRulesObjectModel"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="System.Object" name="self">
																			<init>
																				<methodInvokeExpression methodName="CreateInstance">
																					<target>
																						<propertyReferenceExpression name="Assembly">
																							<propertyReferenceExpression name="ParameterType">
																								<variableReferenceExpression name="p"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="FullName">
																							<propertyReferenceExpression name="ParameterType">
																								<variableReferenceExpression name="p"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																						<primitiveExpression value="true"/>
																						<propertyReferenceExpression name="CreateInstance">
																							<typeReferenceExpression type="BindingFlags"/>
																						</propertyReferenceExpression>
																						<primitiveExpression value="null"/>
																						<arrayCreateExpression>
																							<createType type="System.Object"/>
																							<initializers>
																								<thisReferenceExpression/>
																							</initializers>
																						</arrayCreateExpression>
																						<propertyReferenceExpression name="CurrentCulture">
																							<typeReferenceExpression type="System.Globalization.CultureInfo"/>
																						</propertyReferenceExpression>
																						<primitiveExpression value="null"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<variableDeclarationStatement type="System.Reflection.FieldInfo[]" name="fields">
																			<init>
																				<methodInvokeExpression methodName="GetFields">
																					<target>
																						<methodInvokeExpression methodName="GetType">
																							<target>
																								<variableReferenceExpression name="self"/>
																							</target>
																						</methodInvokeExpression>
																					</target>
																					<parameters>
																						<binaryOperatorExpression operator="BitwiseOr">
																							<propertyReferenceExpression name="Instance">
																								<typeReferenceExpression type="BindingFlags"/>
																							</propertyReferenceExpression>
																							<propertyReferenceExpression name="NonPublic">
																								<typeReferenceExpression type="BindingFlags"/>
																							</propertyReferenceExpression>
																						</binaryOperatorExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<foreachStatement>
																			<variable type="System.Reflection.FieldInfo" name="fi"/>
																			<target>
																				<variableReferenceExpression name="fields"/>
																			</target>
																			<statements>
																				<variableDeclarationStatement name="index">
																					<init>
																						<binaryOperatorExpression operator="Add">
																							<methodInvokeExpression methodName="IndexOf">
																								<target>
																									<propertyReferenceExpression name="Name">
																										<variableReferenceExpression name="fi"/>
																									</propertyReferenceExpression>
																								</target>
																								<parameters>
																									<primitiveExpression value="_"/>
																								</parameters>
																							</methodInvokeExpression>
																							<primitiveExpression value="1"/>
																						</binaryOperatorExpression>
																					</init>
																				</variableDeclarationStatement>
																				<variableDeclarationStatement type="System.String" name="fieldName">
																					<init>
																						<methodInvokeExpression methodName="Substring">
																							<target>
																								<propertyReferenceExpression name="Name">
																									<variableReferenceExpression name="fi"/>
																								</propertyReferenceExpression>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="index"/>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="ValueEquality">
																							<propertyReferenceExpression name="Length">
																								<variableReferenceExpression name="fieldName"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="1"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="fieldName"/>
																							<methodInvokeExpression methodName="ToUpper">
																								<target>
																									<variableReferenceExpression name="fieldName"/>
																								</target>
																							</methodInvokeExpression>
																						</assignStatement>
																					</trueStatements>
																					<falseStatements>
																						<assignStatement>
																							<variableReferenceExpression name="fieldName"/>
																							<binaryOperatorExpression operator="Add">
																								<methodInvokeExpression methodName="ToUpperInvariant">
																									<target>
																										<typeReferenceExpression type="System.Char"/>
																									</target>
																									<parameters>
																										<arrayIndexerExpression>
																											<target>
																												<variableReferenceExpression name="fieldName"/>
																											</target>
																											<indices>
																												<primitiveExpression value="0"/>
																											</indices>
																										</arrayIndexerExpression>
																									</parameters>
																								</methodInvokeExpression>
																								<methodInvokeExpression methodName="Substring">
																									<target>
																										<variableReferenceExpression name="fieldName"/>
																									</target>
																									<parameters>
																										<primitiveExpression value="1"/>
																									</parameters>
																								</methodInvokeExpression>
																							</binaryOperatorExpression>
																						</assignStatement>
																					</falseStatements>
																				</conditionStatement>
																				<variableDeclarationStatement type="FieldValue" name="v">
																					<init>
																						<methodInvokeExpression methodName="SelectFieldValueObject">
																							<parameters>
																								<variableReferenceExpression name="fieldName"/>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="IdentityInequality">
																							<variableReferenceExpression name="v"/>
																							<primitiveExpression value="null"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<tryStatement>
																							<statements>
																								<methodInvokeExpression methodName="InvokeMember">
																									<target>
																										<methodInvokeExpression methodName="GetType">
																											<target>
																												<variableReferenceExpression name="self"/>
																											</target>
																										</methodInvokeExpression>
																									</target>
																									<parameters>
																										<propertyReferenceExpression name="Name">
																											<variableReferenceExpression name="fi"/>
																										</propertyReferenceExpression>
																										<binaryOperatorExpression operator="BitwiseOr">
																											<propertyReferenceExpression name="SetField">
																												<typeReferenceExpression type="BindingFlags"/>
																											</propertyReferenceExpression>
																											<binaryOperatorExpression operator="BitwiseOr">
																												<propertyReferenceExpression name="Instance">
																													<typeReferenceExpression type="BindingFlags"/>
																												</propertyReferenceExpression>
																												<propertyReferenceExpression name="NonPublic">
																													<typeReferenceExpression type="BindingFlags"/>
																												</propertyReferenceExpression>
																											</binaryOperatorExpression>
																										</binaryOperatorExpression>
																										<primitiveExpression value="null"/>
																										<variableReferenceExpression name="self"/>
																										<arrayCreateExpression>
																											<createType type="System.Object"/>
																											<initializers>
																												<methodInvokeExpression methodName="ConvertToType">
																													<target>
																														<typeReferenceExpression type="DataControllerBase"/>
																													</target>
																													<parameters>
																														<propertyReferenceExpression name="FieldType">
																															<variableReferenceExpression name="fi"/>
																														</propertyReferenceExpression>
																														<propertyReferenceExpression name="Value">
																															<variableReferenceExpression name="v"/>
																														</propertyReferenceExpression>
																													</parameters>
																												</methodInvokeExpression>
																											</initializers>
																										</arrayCreateExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</statements>
																							<catch></catch>
																						</tryStatement>
																					</trueStatements>
																				</conditionStatement>
																			</statements>
																		</foreachStatement>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="arguments"/>
																				</target>
																				<indices>
																					<variableReferenceExpression name="i"/>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="self"/>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<variableDeclarationStatement type="FieldValue" name="v">
																			<init>
																				<methodInvokeExpression methodName="SelectFieldValueObject">
																					<parameters>
																						<propertyReferenceExpression name="Name">
																							<variableReferenceExpression name="p"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityInequality">
																					<variableReferenceExpression name="v"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<conditionStatement>
																					<condition>
																						<methodInvokeExpression methodName="Equals">
																							<target>
																								<propertyReferenceExpression name="ParameterType">
																									<variableReferenceExpression name="p"/>
																								</propertyReferenceExpression>
																							</target>
																							<parameters>
																								<typeofExpression type="FieldValue"/>
																							</parameters>
																						</methodInvokeExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="arguments"/>
																								</target>
																								<indices>
																									<variableReferenceExpression name="i"/>
																								</indices>
																							</arrayIndexerExpression>
																							<variableReferenceExpression name="v"/>
																						</assignStatement>
																					</trueStatements>
																					<falseStatements>
																						<tryStatement>
																							<statements>
																								<assignStatement>
																									<arrayIndexerExpression>
																										<target>
																											<variableReferenceExpression name="arguments"/>
																										</target>
																										<indices>
																											<variableReferenceExpression name="i"/>
																										</indices>
																									</arrayIndexerExpression>
																									<methodInvokeExpression methodName="ConvertToType">
																										<target>
																											<typeReferenceExpression type="DataControllerBase"/>
																										</target>
																										<parameters>
																											<propertyReferenceExpression name="ParameterType">
																												<variableReferenceExpression name="p"/>
																											</propertyReferenceExpression>
																											<propertyReferenceExpression name="Value">
																												<variableReferenceExpression name="v"/>
																											</propertyReferenceExpression>
																										</parameters>
																									</methodInvokeExpression>
																								</assignStatement>
																							</statements>
																							<catch exceptionType="Exception">

																							</catch>
																						</tryStatement>
																					</falseStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</statements>
														</forStatement>
														<methodInvokeExpression methodName="Invoke">
															<target>
																<variableReferenceExpression name="method"/>
															</target>
															<parameters>
																<thisReferenceExpression/>
																<argumentReferenceExpression name="arguments"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
						<!-- method ValidateInput() -->
						<memberMethod returnType="System.Boolean" name="ValidateInput">
							<comment>
								<![CDATA[
        /// <summary>
        /// Returns True if there are no field values with errors.
        /// </summary>
        /// <returns>True if all field values have a blank 'Error' property.</returns>
              ]]>
							</comment>
							<attributes family="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Arguments"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="FieldValue" name="v"/>
											<target>
												<propertyReferenceExpression name="Values">
													<propertyReferenceExpression name="Arguments"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<propertyReferenceExpression name="Error">
																<variableReferenceExpression name="v"/>
															</propertyReferenceExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="false"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class BusinessRulesObjectModel -->
				<typeDeclaration name="BusinessRulesObjectModel">
					<attributes public="true"/>
					<members>
						<memberField type="BusinessRules" name="rules">
							<customAttributes>
								<customAttribute type="System.Diagnostics.DebuggerBrowsable">
									<arguments>
										<propertyReferenceExpression name="Never">
											<typeReferenceExpression type="System.Diagnostics.DebuggerBrowsableState"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
						</memberField>
						<!-- property this[string]-->
						<memberProperty type="FieldValue" name="Item">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="rules"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="FieldValue" name="fv">
									<init>
										<methodInvokeExpression methodName="SelectFieldValueObject">
											<target>
												<fieldReferenceExpression name="rules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="name"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="fv"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="fv"/>
											<objectCreateExpression type="FieldValue">
												<parameters>
													<argumentReferenceExpression name="name"/>
													<primitiveExpression value="null"/>
													<primitiveExpression value="null"/>
													<primitiveExpression value="true"/>
												</parameters>
											</objectCreateExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Error">
												<variableReferenceExpression name="fv"/>
											</propertyReferenceExpression>
											<primitiveExpression value="This field is missing in the arguments."/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="fv"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- constructor () -->
						<constructor>
							<attributes public="true"/>
						</constructor>
						<!-- constructor (BusinessRules) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="BusinessRules" name="rules"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="rules">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="rules"/>
								</assignStatement>
							</statements>
						</constructor>
						<!-- method UpdateFieldValue(string, object) -->
						<memberMethod name="UpdateFieldValue">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="System.Object" name="value"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="rules">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="UpdateFieldValue">
											<target>
												<fieldReferenceExpression name="rules">
													<thisReferenceExpression/>
												</fieldReferenceExpression>
											</target>
											<parameters>
												<argumentReferenceExpression name="fieldName"/>
												<argumentReferenceExpression name="value"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- T CreateInstance<T)>(parms object[]) -->
						<memberMethod returnType="T" name="CreateInstance">
							<typeParameters>
								<typeParameter name="T"/>
							</typeParameters>
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="params System.Object[]" name="values"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="BusinessObjectParameters" name="parameters">
									<init>
										<objectCreateExpression type="BusinessObjectParameters">
											<parameters>
												<argumentReferenceExpression name="values"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="T" name="instance">
									<init>
										<castExpression targetType="T">
											<methodInvokeExpression methodName="CreateInstance">
												<target>
													<typeReferenceExpression type="Activator"/>
												</target>
												<parameters>
													<typeofExpression type="T"/>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="Type" name="instanceType">
									<init>
										<methodInvokeExpression methodName="GetType">
											<target>
												<variableReferenceExpression name="instance"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="name"/>
									<target>
										<propertyReferenceExpression name="Keys">
											<variableReferenceExpression name="parameters"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<variableDeclarationStatement type="PropertyInfo" name="pi">
											<init>
												<methodInvokeExpression methodName="GetProperty">
													<target>
														<variableReferenceExpression name="instanceType"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="Substring">
															<target>
																<variableReferenceExpression name="name"/>
															</target>
															<parameters>
																<primitiveExpression value="1"/>
															</parameters>
														</methodInvokeExpression>
														<binaryOperatorExpression operator="BitwiseOr">
															<propertyReferenceExpression name="IgnoreCase">
																<typeReferenceExpression type="BindingFlags"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="BitwiseOr">
																<propertyReferenceExpression name="Public">
																	<typeReferenceExpression type="BindingFlags"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Instance">
																	<typeReferenceExpression type="BindingFlags"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="pi"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<tryStatement>
													<statements>
														<variableDeclarationStatement type="System.Object" name="v">
															<init>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="parameters"/>
																	</target>
																	<indices>
																		<variableReferenceExpression name="name"/>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="IdentityInequality">
																		<variableReferenceExpression name="v"/>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																	<propertyReferenceExpression name="IsGenericType">
																		<propertyReferenceExpression name="PropertyType">
																			<variableReferenceExpression name="pi"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="v"/>
																	<methodInvokeExpression methodName="ChangeType">
																		<target>
																			<typeReferenceExpression type="Convert"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="v"/>
																			<methodInvokeExpression methodName="GetUnderlyingType">
																				<target>
																					<typeReferenceExpression type="Nullable"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="PropertyType">
																						<variableReferenceExpression name="pi"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="SetValue">
															<target>
																<variableReferenceExpression name="pi"/>
															</target>
															<parameters>
																<variableReferenceExpression name="instance"/>
																<variableReferenceExpression name="v"/>
															</parameters>
														</methodInvokeExpression>
													</statements>
													<catch exceptionType="Exception" localName="ex">
														<throwExceptionStatement>
															<objectCreateExpression type="Exception">
																<parameters>
																	<stringFormatExpression format="{{0}}.{{1}}: {{2}}">
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="instanceType"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="pi"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Message">
																			<variableReferenceExpression name="ex"/>
																		</propertyReferenceExpression>
																	</stringFormatExpression>
																</parameters>
															</objectCreateExpression>
														</throwExceptionStatement>
													</catch>
												</tryStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="instance"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
