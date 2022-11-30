<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="Namespace" select="a:project/a:namespace"/>
	<xsl:param name="ProviderName"/>

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Security">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Net.Mail"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Services"/>
			</imports>
			<types>
				<!-- MembershipBusinessRules -->
				<typeDeclaration name="MembershipBusinessRules" isPartial="true">
					<baseTypes>
						<typeReference type="MembershipBusinessRulesBase"/>
					</baseTypes>
				</typeDeclaration>
				<!-- MembershipBusinessRulesBase -->
				<typeDeclaration name="MembershipBusinessRulesBase">
					<baseTypes>
						<typeReference type="BusinessRules"/>
					</baseTypes>
					<members>
						<!-- field CreateErrors -->
						<memberField type="SortedDictionary" name="CreateErrors">
							<typeArguments>
								<typeReference type="MembershipCreateStatus"/>
								<typeReference type="System.String"/>
							</typeArguments>
							<attributes static="true" public="true"/>
							<init>
								<objectCreateExpression type="SortedDictionary">
									<typeArguments>
										<typeReference type="MembershipCreateStatus"/>
										<typeReference type="System.String"/>
									</typeArguments>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- static constructor MembershipBusinessRulesBase()-->
						<typeConstructor>
							<statements>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="CreateErrors"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="DuplicateEmail">
											<typeReferenceExpression type="MembershipCreateStatus"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Duplicate email address."/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="CreateErrors"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="DuplicateProviderUserKey">
											<typeReferenceExpression type="MembershipCreateStatus"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Duplicate provider key."/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="CreateErrors"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="DuplicateUserName">
											<typeReferenceExpression type="MembershipCreateStatus"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Duplicate user name."/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="CreateErrors"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="InvalidAnswer">
											<typeReferenceExpression type="MembershipCreateStatus"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Invalid password recovery answer."/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="CreateErrors"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="InvalidEmail">
											<typeReferenceExpression type="MembershipCreateStatus"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Invalid email address."/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="CreateErrors"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="InvalidPassword">
											<typeReferenceExpression type="MembershipCreateStatus"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Invalid password."/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="CreateErrors"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="InvalidProviderUserKey">
											<typeReferenceExpression type="MembershipCreateStatus"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Invalid provider user key."/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="CreateErrors"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="InvalidQuestion">
											<typeReferenceExpression type="MembershipCreateStatus"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Invalid password recovery question."/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="CreateErrors"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="InvalidUserName">
											<typeReferenceExpression type="MembershipCreateStatus"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Invalid user name."/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="CreateErrors"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="ProviderError">
											<typeReferenceExpression type="MembershipCreateStatus"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Provider error."/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="CreateErrors"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="UserRejected">
											<typeReferenceExpression type="MembershipCreateStatus"/>
										</propertyReferenceExpression>
										<primitiveExpression value="User has been rejected."/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</typeConstructor>
						<!-- method AccessControlValidation-->
						<memberMethod name="AccessControlValidation">
							<attributes public="true"/>
							<customAttributes>
								<customAttribute type="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Membership"/>
										<primitiveExpression value="Select"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
								<customAttribute type="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Membership"/>
										<primitiveExpression value="Update"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
								<customAttribute type="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Membership"/>
										<primitiveExpression value="Insert"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
								<customAttribute type="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Membership"/>
										<primitiveExpression value="Delete"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
								<customAttribute type="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Roles"/>
										<primitiveExpression value="Select"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
								<customAttribute type="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Roles"/>
										<primitiveExpression value="Insert"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
								<customAttribute type="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Roles"/>
										<primitiveExpression value="Update"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
								<customAttribute type="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Roles"/>
										<primitiveExpression value="Delete"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="IsAuthenticated">
												<propertyReferenceExpression name="Identity">
													<propertyReferenceExpression name="User">
														<propertyReferenceExpression name="Context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="Exception">
												<parameters>
													<primitiveExpression value="Not Authorized."/>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="UserIsInRole">
													<parameters>
														<primitiveExpression value="Administrators"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<propertyReferenceExpression name="Request"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="View">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
														<primitiveExpression value="lookup"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="Exception">
												<parameters>
													<primitiveExpression value="Not Authorized."/>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method DeleteUser(System.Object) -->
						<memberMethod name="DeleteUser">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Membership"/>
										<primitiveExpression value="Delete"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<parameters>
								<parameter name="userId">
									<xsl:attribute name="type">
										<xsl:choose>
											<xsl:when test="contains($ProviderName, 'MySql')">
												<xsl:text>System.Int32</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>Guid</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:attribute>
								</parameter>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="PreventDefault"/>
								<variableDeclarationStatement type="MembershipUser" name="user">
									<init>
										<methodInvokeExpression methodName="GetUser">
											<target>
												<typeReferenceExpression type="Membership"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="userId"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="DeleteUser">
									<target>
										<typeReferenceExpression type="Membership"/>
									</target>
									<parameters>
										<propertyReferenceExpression name="UserName">
											<variableReferenceExpression name="user"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="IsTouchClient">
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ShowLastView">
											<target>
												<propertyReferenceExpression name="Result"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="ShowMessage">
											<target>
												<propertyReferenceExpression name="Result"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Format">
													<target>
														<typeReferenceExpression type="String"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="Localize">
															<parameters>
																<primitiveExpression value="UserHasBeenDeleted"/>
																<primitiveExpression value="User '{{0}}' has been deleted."/>
															</parameters>
														</methodInvokeExpression>
														<propertyReferenceExpression name="UserName">
															<variableReferenceExpression name="user"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method UpdateUser(Guid, FieldValue, FieldValue, FieldValue, FieldValue, FieldValue) -->
						<memberMethod name="UpdateUser">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Membership"/>
										<primitiveExpression value="Update"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<parameters>
								<parameter name="userId">
									<xsl:attribute name="type">
										<xsl:choose>
											<xsl:when test="contains($ProviderName, 'MySql')">
												<xsl:text>System.Int32</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>Guid</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:attribute>
								</parameter>
								<parameter type="FieldValue" name="email"/>
								<parameter type="FieldValue" name="isApproved"/>
								<parameter type="FieldValue" name="isLockedOut"/>
								<parameter type="FieldValue" name="comment"/>
								<parameter type="FieldValue" name="roles"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="PreventDefault"/>
								<variableDeclarationStatement type="MembershipUser" name="user">
									<init>
										<methodInvokeExpression methodName="GetUser">
											<target>
												<typeReferenceExpression type="Membership"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="userId"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<comment>update user information</comment>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Modified">
											<argumentReferenceExpression name="email"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Email">
												<variableReferenceExpression name="user"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToString">
												<target>
													<typeReferenceExpression type="Convert"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Value">
														<argumentReferenceExpression name="email"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<methodInvokeExpression methodName="UpdateUser">
											<target>
												<typeReferenceExpression type="Membership"/>
											</target>
											<parameters>
												<variableReferenceExpression name="user"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Modified">
											<argumentReferenceExpression name="isApproved"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="IsApproved">
												<variableReferenceExpression name="user"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToBoolean">
												<target>
													<typeReferenceExpression type="Convert"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Value">
														<argumentReferenceExpression name="isApproved"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<methodInvokeExpression methodName="UpdateUser">
											<target>
												<typeReferenceExpression type="Membership"/>
											</target>
											<parameters>
												<variableReferenceExpression name="user"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Modified">
											<argumentReferenceExpression name="isLockedOut"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="ToBoolean">
													<target>
														<typeReferenceExpression type="Convert"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Value">
															<argumentReferenceExpression name="isLockedOut"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Focus">
													<target>
														<propertyReferenceExpression name="Result"/>
													</target>
													<parameters>
														<primitiveExpression value="IsLockedOut"/>
														<methodInvokeExpression methodName="Localize">
															<parameters>
																<primitiveExpression value="UserCannotBeLockedOut"/>
																<primitiveExpression value="User cannot be locked out. If you want to prevent this user from being able to login then simply mark user as 'not-approved'."/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
												<throwExceptionStatement>
													<objectCreateExpression type="Exception">
														<parameters>
															<methodInvokeExpression methodName="Localize">
																<parameters>
																	<primitiveExpression value="ErrorSavingUser"/>
																	<primitiveExpression value="Error saving user account."/>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</objectCreateExpression>
												</throwExceptionStatement>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="UnlockUser">
											<target>
												<variableReferenceExpression name="user"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Modified">
											<variableReferenceExpression name="comment"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Comment">
												<variableReferenceExpression name="user"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToString">
												<target>
													<typeReferenceExpression type="Convert"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Value">
														<argumentReferenceExpression name="comment"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<methodInvokeExpression methodName="UpdateUser">
											<target>
												<typeReferenceExpression type="Membership"/>
											</target>
											<parameters>
												<variableReferenceExpression name="user"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<argumentReferenceExpression name="roles"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<propertyReferenceExpression name="Modified">
												<argumentReferenceExpression name="roles"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String[]" name="newRoles">
											<init>
												<methodInvokeExpression methodName="Split">
													<target>
														<methodInvokeExpression methodName="ToString">
															<target>
																<typeReferenceExpression type="Convert"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Value">
																	<argumentReferenceExpression name="roles"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</target>
													<parameters>
														<primitiveExpression value="," convertTo="Char"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String[]" name="oldRoles">
											<init>
												<methodInvokeExpression methodName="GetRolesForUser">
													<target>
														<typeReferenceExpression type="System.Web.Security.Roles"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="UserName">
															<variableReferenceExpression name="user"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="System.String" name="role"/>
											<target>
												<variableReferenceExpression name="oldRoles"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="role"/>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="ValueEquality">
																<methodInvokeExpression methodName="IndexOf">
																	<target>
																		<typeReferenceExpression type="Array"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="newRoles"/>
																		<variableReferenceExpression name="role"/>
																	</parameters>
																</methodInvokeExpression>
																<primitiveExpression value="-1"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="RemoveUserFromRole">
															<target>
																<typeReferenceExpression type="System.Web.Security.Roles"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="UserName">
																	<variableReferenceExpression name="user"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="role"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<foreachStatement>
											<variable type="System.String" name="role"/>
											<target>
												<variableReferenceExpression name="newRoles"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="role"/>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="ValueEquality">
																<methodInvokeExpression methodName="IndexOf">
																	<target>
																		<typeReferenceExpression type="Array"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="oldRoles"/>
																		<variableReferenceExpression name="role"/>
																	</parameters>
																</methodInvokeExpression>
																<primitiveExpression value="-1"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="AddUserToRole">
															<target>
																<typeReferenceExpression type="System.Web.Security.Roles"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="UserName">
																	<variableReferenceExpression name="user"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="role"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method InsertUser(string, string, string, string, string, string, bool, string, string) -->
						<memberMethod name="InsertUser">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Membership"/>
										<primitiveExpression value="Insert"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="System.String" name="password"/>
								<parameter type="System.String" name="confirmPassword"/>
								<parameter type="System.String" name="email"/>
								<parameter type="System.String" name="passwordQuestion"/>
								<parameter type="System.String" name="passwordAnswer"/>
								<parameter type="System.Boolean" name="isApproved"/>
								<parameter type="System.String" name="comment"/>
								<parameter type="System.String" name="roles"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="PreventDefault"/>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<argumentReferenceExpression name="password"/>
											<argumentReferenceExpression name="confirmPassword"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="Exception">
												<parameters>
													<methodInvokeExpression methodName="Localize">
														<parameters>
															<primitiveExpression value="PasswordAndConfirmationDoNotMatch"/>
															<primitiveExpression value="Password and confirmation do not match."/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</trueStatements>
								</conditionStatement>
								<comment>create a user</comment>
								<variableDeclarationStatement type="MembershipCreateStatus" name="status"/>
								<methodInvokeExpression methodName="CreateUser">
									<target>
										<typeReferenceExpression type="Membership"/>
									</target>
									<parameters>
										<argumentReferenceExpression name="username"/>
										<argumentReferenceExpression name="password"/>
										<argumentReferenceExpression name="email"/>
										<argumentReferenceExpression name="passwordQuestion"/>
										<argumentReferenceExpression name="passwordAnswer"/>
										<argumentReferenceExpression name="isApproved"/>
										<directionExpression direction="Out">
											<variableReferenceExpression name="status"/>
										</directionExpression>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<variableReferenceExpression name="status"/>
											<propertyReferenceExpression name="Success">
												<typeReferenceExpression type="MembershipCreateStatus"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="Exception">
												<parameters>
													<methodInvokeExpression methodName="Localize">
														<parameters>
															<methodInvokeExpression methodName="ToString">
																<target>
																	<variableReferenceExpression name="status"/>
																</target>
															</methodInvokeExpression>
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="CreateErrors">
																		<typeReferenceExpression type="MembershipBusinessRules"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<variableReferenceExpression name="status"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</trueStatements>
								</conditionStatement>
								<comment>retrieve the primary key of the new user account</comment>
								<variableDeclarationStatement type="MembershipUser" name="newUser">
									<init>
										<methodInvokeExpression methodName="GetUser">
											<target>
												<typeReferenceExpression type="Membership"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="username"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Object" name="providerUserKey">
									<init>
										<propertyReferenceExpression name="ProviderUserKey">
											<variableReferenceExpression name="newUser"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<methodInvokeExpression methodName="GetType">
												<target>
													<variableReferenceExpression name="providerUserKey"/>
												</target>
											</methodInvokeExpression>
											<typeofExpression type="System.Byte[]"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="providerUserKey"/>
											<objectCreateExpression type="Guid">
												<parameters>
													<castExpression targetType="System.Byte[]">
														<variableReferenceExpression name="providerUserKey"/>
													</castExpression>
												</parameters>
											</objectCreateExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<propertyReferenceExpression name="Values">
											<propertyReferenceExpression name="Result"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<objectCreateExpression type="FieldValue">
											<parameters>
												<primitiveExpression value="UserId"/>
												<variableReferenceExpression name="providerUserKey"/>
											</parameters>
										</objectCreateExpression>
									</parameters>
								</methodInvokeExpression>
								<comment>update a comment</comment>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<argumentReferenceExpression name="comment"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Comment">
												<variableReferenceExpression name="newUser"/>
											</propertyReferenceExpression>
											<argumentReferenceExpression name="comment"/>
										</assignStatement>
										<methodInvokeExpression methodName="UpdateUser">
											<target>
												<typeReferenceExpression type="Membership"/>
											</target>
											<parameters>
												<variableReferenceExpression name="newUser"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="roles"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="System.String" name="role"/>
											<target>
												<methodInvokeExpression methodName="Split">
													<target>
														<variableReferenceExpression name="roles"/>
													</target>
													<parameters>
														<primitiveExpression value="," convertTo="Char"/>
													</parameters>
												</methodInvokeExpression>
											</target>
											<statements>
												<methodInvokeExpression methodName="AddUserToRole">
													<target>
														<typeReferenceExpression type="System.Web.Security.Roles"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="username"/>
														<variableReferenceExpression name="role"/>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method NewUserRow() -->
						<memberMethod name="NewUserRow">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="RowBuilder">
									<arguments>
										<primitiveExpression value="aspnet_Membership"/>
										<primitiveExpression value="createForm1"/>
										<propertyReferenceExpression name="New">
											<typeReferenceExpression type="RowKind"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<statements>
								<methodInvokeExpression methodName="UpdateFieldValue">
									<parameters>
										<primitiveExpression value="IsApproved"/>
										<primitiveExpression value="true"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method PrepareUserRow() -->
						<memberMethod name="PrepareUserRow">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="RowBuilder">
									<arguments>
										<primitiveExpression value="aspnet_Membership"/>
										<primitiveExpression value="editForm1"/>
										<propertyReferenceExpression name="Existing">
											<typeReferenceExpression type="RowKind"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<statements>
								<variableDeclarationStatement type="System.String" name="userName">
									<init>
										<castExpression targetType="System.String">
											<methodInvokeExpression methodName="SelectFieldValue">
												<parameters>
													<primitiveExpression value="UserUserName"/>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="StringBuilder" name="sb">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="role"/>
									<target>
										<methodInvokeExpression methodName="GetRolesForUser">
											<target>
												<typeReferenceExpression type="System.Web.Security.Roles"/>
											</target>
											<parameters>
												<variableReferenceExpression name="userName"/>
											</parameters>
										</methodInvokeExpression>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="sb"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Append">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<primitiveExpression value="," convertTo="Char"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="Append">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<variableReferenceExpression name="role"/>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<methodInvokeExpression methodName="UpdateFieldValue">
									<parameters>
										<primitiveExpression value="Roles"/>
										<methodInvokeExpression methodName="ToString">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="DateTime" name="dt">
									<init>
										<castExpression targetType="DateTime">
											<methodInvokeExpression methodName="SelectFieldValue">
												<parameters>
													<primitiveExpression value="LastLockoutDate"/>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Equals">
											<target>
												<variableReferenceExpression name="dt"/>
											</target>
											<parameters>
												<objectCreateExpression type="DateTime">
													<parameters>
														<primitiveExpression value="1754"/>
														<primitiveExpression value="1"/>
														<primitiveExpression value="1"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="UpdateFieldValue">
											<parameters>
												<primitiveExpression value="LastLockoutDate"/>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<variableReferenceExpression name="dt"/>
									<castExpression targetType="DateTime">
										<methodInvokeExpression methodName="SelectFieldValue">
											<parameters>
												<xsl:choose>
													<xsl:when test="contains($ProviderName, 'Oracle')">
														<primitiveExpression value="PwdAttemptWindowStart"/>
													</xsl:when>
													<xsl:otherwise>
														<primitiveExpression value="FailedPasswordAttemptWindowStart"/>
													</xsl:otherwise>
												</xsl:choose>
											</parameters>
										</methodInvokeExpression>
									</castExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Equals">
											<target>
												<variableReferenceExpression name="dt"/>
											</target>
											<parameters>
												<objectCreateExpression type="DateTime">
													<parameters>
														<primitiveExpression value="1754"/>
														<primitiveExpression value="1"/>
														<primitiveExpression value="1"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="UpdateFieldValue">
											<parameters>
												<xsl:choose>
													<xsl:when test="contains($ProviderName, 'Oracle')">
														<primitiveExpression value="PwdAttemptWindowStart"/>
													</xsl:when>
													<xsl:otherwise>
														<primitiveExpression value="FailedPasswordAttemptWindowStart"/>
													</xsl:otherwise>
												</xsl:choose>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<variableReferenceExpression name="dt"/>
									<castExpression targetType="DateTime">
										<methodInvokeExpression methodName="SelectFieldValue">
											<parameters>
												<xsl:choose>
													<xsl:when test="contains($ProviderName, 'Oracle')">
														<primitiveExpression value="PwdAnsAttemptWindowStart"/>
													</xsl:when>
													<xsl:otherwise>
														<primitiveExpression value="FailedPasswordAnswerAttemptWindowStart"/>
													</xsl:otherwise>
												</xsl:choose>
											</parameters>
										</methodInvokeExpression>
									</castExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Equals">
											<target>
												<variableReferenceExpression name="dt"/>
											</target>
											<parameters>
												<objectCreateExpression type="DateTime">
													<parameters>
														<primitiveExpression value="1754"/>
														<primitiveExpression value="1"/>
														<primitiveExpression value="1"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="UpdateFieldValue">
											<parameters>
												<xsl:choose>
													<xsl:when test="contains($ProviderName, 'Oracle')">
														<primitiveExpression value="PwdAnsAttemptWindowStart"/>
													</xsl:when>
													<xsl:otherwise>
														<primitiveExpression value="FailedPasswordAnswerAttemptWindowStart"/>
													</xsl:otherwise>
												</xsl:choose>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method InsertRole(string) -->
						<memberMethod name="InsertRole">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Roles"/>
										<primitiveExpression value="Insert"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<parameters>
								<parameter type="System.String" name="roleName"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="PreventDefault"/>
								<methodInvokeExpression methodName="CreateRole">
									<target>
										<typeReferenceExpression type="System.Web.Security.Roles"/>
									</target>
									<parameters>
										<argumentReferenceExpression name="roleName"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method UpdateRole(string) -->
						<memberMethod name="UpdateRole">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Roles"/>
										<primitiveExpression value="Update"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<parameters>
								<parameter type="System.String" name="roleName"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="UpdateFieldValue">
									<parameters>
										<primitiveExpression value="LoweredRoleName"/>
										<methodInvokeExpression methodName="ToLower">
											<target>
												<variableReferenceExpression name="roleName"/>
											</target>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method DeleteRole(string)-->
						<memberMethod name="DeleteRole">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Roles"/>
										<primitiveExpression value="Delete"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<parameters>
								<parameter type="System.String" name="roleName"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="PreventDefault"/>
								<methodInvokeExpression methodName="DeleteRole">
									<target>
										<typeReferenceExpression type="System.Web.Security.Roles"/>
									</target>
									<parameters>
										<argumentReferenceExpression name="roleName"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<memberMethod name="UpdateMyAccount">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="aspnet_Membership"/>
										<primitiveExpression value="myAccountForm"/>
										<primitiveExpression value="Update"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<parameters>
								<parameter type="System.String" name="userName"/>
								<parameter type="System.String" name="oldPassword"/>
								<parameter type="System.String" name="password"/>
								<parameter type="System.String" name="confirmPassword"/>
								<parameter type="System.String" name="email"/>
								<parameter type="System.String" name="passwordQuestion"/>
								<parameter type="System.String" name="passwordAnswer"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="PreventDefault"/>
								<variableDeclarationStatement type="MembershipUser" name="user">
									<init>
										<methodInvokeExpression methodName="GetUser">
											<target>
												<typeReferenceExpression type="Membership"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="userName"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="user"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<argumentReferenceExpression name="oldPassword"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ShowAlert">
													<target>
														<propertyReferenceExpression name="Result"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="Localize">
															<parameters>
																<primitiveExpression value="EnterCurrentPassword"/>
																<primitiveExpression value="Please enter your current password."/>
															</parameters>
														</methodInvokeExpression>
														<primitiveExpression value="OldPassword"/>
													</parameters>
												</methodInvokeExpression>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="ValidateUser">
														<target>
															<typeReferenceExpression type="Membership"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="userName"/>
															<argumentReferenceExpression name="oldPassword"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ShowAlert">
													<target>
														<propertyReferenceExpression name="Result"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="Localize">
															<parameters>
																<primitiveExpression value="PasswordDoesNotMatchRecords"/>
																<primitiveExpression value="Your password does not match our records."/>
															</parameters>
														</methodInvokeExpression>
														<primitiveExpression value="OldPassword"/>
													</parameters>
												</methodInvokeExpression>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<argumentReferenceExpression name="password"/>
													</unaryOperatorExpression>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<argumentReferenceExpression name="confirmPassword"/>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueInequality">
															<argumentReferenceExpression name="password"/>
															<argumentReferenceExpression name="confirmPassword"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ShowAlert">
															<target>
																<propertyReferenceExpression name="Result"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="Localize">
																	<parameters>
																		<primitiveExpression value="NewPasswordAndConfirmatinDoNotMatch"/>
																		<primitiveExpression value="New password and confirmation do not match."/>
																	</parameters>
																</methodInvokeExpression>
																<primitiveExpression value="Password"/>
															</parameters>
														</methodInvokeExpression>
														<methodReturnStatement/>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="ChangePassword">
																<target>
																	<variableReferenceExpression name="user"/>
																</target>
																<parameters>
																	<argumentReferenceExpression name="oldPassword"/>
																	<argumentReferenceExpression name="password"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ShowAlert">
															<target>
																<propertyReferenceExpression name="Result"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="Localize">
																	<parameters>
																		<primitiveExpression value="NewPasswordInvalid"/>
																		<primitiveExpression value="Your new password is invalid."/>
																	</parameters>
																</methodInvokeExpression>
																<primitiveExpression value="Password"/>
															</parameters>
														</methodInvokeExpression>
														<methodReturnStatement/>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueInequality">
													<argumentReferenceExpression name="email"/>
													<propertyReferenceExpression name="Email">
														<variableReferenceExpression name="user"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Email">
														<variableReferenceExpression name="user"/>
													</propertyReferenceExpression>
													<argumentReferenceExpression name="email"/>
												</assignStatement>
												<methodInvokeExpression methodName="UpdateUser">
													<target>
														<typeReferenceExpression type="Membership"/>
													</target>
													<parameters>
														<variableReferenceExpression name="user"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="ValueInequality">
														<propertyReferenceExpression name="PasswordQuestion">
															<variableReferenceExpression name="user"/>
														</propertyReferenceExpression>
														<argumentReferenceExpression name="passwordQuestion"/>
													</binaryOperatorExpression>
													<unaryOperatorExpression operator="IsNullOrEmpty">
														<argumentReferenceExpression name="passwordAnswer"/>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ShowAlert">
													<target>
														<propertyReferenceExpression name="Result"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="Localize">
															<parameters>
																<primitiveExpression value="EnterPasswordAnswer"/>
																<primitiveExpression value="Please enter a password answer."/>
															</parameters>
														</methodInvokeExpression>
														<primitiveExpression value="PasswordAnswer"/>
													</parameters>
												</methodInvokeExpression>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<argumentReferenceExpression name="passwordAnswer"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ChangePasswordQuestionAndAnswer">
													<target>
														<variableReferenceExpression name="user"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="oldPassword"/>
														<argumentReferenceExpression name="passwordQuestion"/>
														<argumentReferenceExpression name="passwordAnswer"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="UpdateUser">
													<target>
														<typeReferenceExpression type="Membership"/>
													</target>
													<parameters>
														<variableReferenceExpression name="user"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="HideModal">
											<target>
												<propertyReferenceExpression name="Result"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="ShowAlert">
											<target>
												<propertyReferenceExpression name="Result"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Localize">
													<parameters>
														<primitiveExpression value="UserNotFound"/>
														<primitiveExpression value="User not found."/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method CreateStandardMembershipAccounts() -->
						<memberMethod name="CreateStandardMembershipAccounts">
							<attributes public="true" static="true"/>
							<statements>
								<methodInvokeExpression methodName="RegisterStandardMembershipAccounts">
									<target>
										<typeReferenceExpression type="ApplicationServices"/>
									</target>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<xsl:if test="contains($ProviderName, 'Oracle')">
							<memberMethod name="BuildOracleDataRow">
								<attributes family="true" final="true"/>
								<customAttributes>
									<customAttribute type="RowBuilder">
										<arguments>
											<primitiveExpression value="aspnet_Membership"/>
											<propertyReferenceExpression name="Existing">
												<typeReferenceExpression type="RowKind"/>
											</propertyReferenceExpression>
										</arguments>
									</customAttribute>
									<customAttribute type="RowBuilder">
										<arguments>
											<primitiveExpression value="aspnet_Membership"/>
											<propertyReferenceExpression name="New">
												<typeReferenceExpression type="RowKind"/>
											</propertyReferenceExpression>
										</arguments>
									</customAttribute>
								</customAttributes>
								<statements>
									<methodInvokeExpression methodName="UpdateFieldValue">
										<parameters>
											<primitiveExpression value="IsApproved"/>
											<binaryOperatorExpression operator="ValueEquality">
												<convertExpression to="String">
													<methodInvokeExpression methodName="SelectFieldValue">
														<parameters>
															<primitiveExpression value="IsApproved"/>
														</parameters>
													</methodInvokeExpression>
												</convertExpression>
												<primitiveExpression value="1" convertTo="String"/>
											</binaryOperatorExpression>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="UpdateFieldValue">
										<parameters>
											<primitiveExpression value="IsLockedOut"/>
											<binaryOperatorExpression operator="ValueEquality">
												<convertExpression to="String">
													<methodInvokeExpression methodName="SelectFieldValue">
														<parameters>
															<primitiveExpression value="IsLockedOut"/>
														</parameters>
													</methodInvokeExpression>
												</convertExpression>
												<primitiveExpression value="1" convertTo="String"/>
											</binaryOperatorExpression>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
						</xsl:if>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
