<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:c="urn:schemas-codeontime-com:data-aquarium"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:csharp="urn:codeontime-customcode"
    exclude-result-prefixes="msxsl a c csharp"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="Namespace" select="a:project/a:namespace"/>
	<xsl:param name="ProviderName"/>
	<xsl:param name="IsPremium"/>
	<xsl:param name="IsUnlimited"/>
	<xsl:param name="SharedBusinessRules"/>
	<xsl:param name="SiteContentTableName"/>
	<xsl:param name="ActiveDirectory"/>
	<xsl:param name="MembershipDisplayRememberMe" />
	<xsl:param name="MembershipRememberMeSet" />

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Rules">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Net.Mail"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Services"/>
			</imports>
			<types>
				<!-- MyProfileBusinessRulesBase -->
				<typeDeclaration name="MyProfileBusinessRulesBase">
					<baseTypes>
						<xsl:choose>
							<xsl:when test="$SharedBusinessRules!='true'">
								<typeReference type="BusinessRules"/>
							</xsl:when>
							<xsl:otherwise>
								<typeReference type="SharedBusinessRules"/>
							</xsl:otherwise>
						</xsl:choose>
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
						<!-- static constructor MyProfileBusinessRulesBase()-->
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
						<!-- method InsertUser(string, string, string, string, string, string, bool, string, string) -->
						<memberMethod name="InsertUser">
							<attributes family="true" />
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
																	<propertyReferenceExpression name="CreateErrors"/>
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
						<!-- method SignUpUser(string, string, string, string, string, string) -->
						<memberMethod name="SignUpUser">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="MyProfile"/>
										<primitiveExpression value="signUpForm"/>
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
							</parameters>
							<statements>
								<methodInvokeExpression methodName="InsertUser">
									<parameters>
										<argumentReferenceExpression name="username"/>
										<argumentReferenceExpression name="password"/>
										<argumentReferenceExpression name="confirmPassword"/>
										<argumentReferenceExpression name="email"/>
										<argumentReferenceExpression name="passwordQuestion"/>
										<argumentReferenceExpression name="passwordAnswer"/>
										<primitiveExpression value="true"/>
										<methodInvokeExpression methodName="Localize">
											<parameters>
												<primitiveExpression value="SelfRegisteredUser"/>
												<primitiveExpression value="Self-registered user."/>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="Users"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method NewPasswordRequestRow() -->
						<memberMethod name="NewPasswordRequestRow">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="RowBuilder">
									<arguments>
										<primitiveExpression value="MyProfile"/>
										<primitiveExpression value="passwordRequestForm"/>
										<propertyReferenceExpression name="New">
											<typeReferenceExpression type="RowKind"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<statements>
								<methodInvokeExpression methodName="UpdateFieldValue">
									<parameters>
										<primitiveExpression value="UserName"/>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Session">
													<propertyReferenceExpression name="Context"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="IdentityConfirmation"/>
											</indices>
										</arrayIndexerExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method NewPasswordRequestRow() -->
						<memberMethod name="NewLoginFormRow">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="RowBuilder">
									<arguments>
										<primitiveExpression value="MyProfile"/>
										<primitiveExpression value="loginForm"/>
										<propertyReferenceExpression name="New">
											<typeReferenceExpression type="RowKind"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<statements>
								<xsl:choose>
									<xsl:when test="$MembershipDisplayRememberMe!='false'">
										<variableDeclarationStatement type="Uri" name="urlReferrer">
											<init>
												<propertyReferenceExpression name="UrlReferrer">
													<propertyReferenceExpression name="Request">
														<propertyReferenceExpression name="Context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="urlReferrer"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String" name="url">
													<init>
														<methodInvokeExpression methodName="ToString">
															<target>
																<variableReferenceExpression name="urlReferrer"/>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Contains">
															<target>
																<variableReferenceExpression name="url"/>
															</target>
															<parameters>
																<primitiveExpression value="/_invoke/getidentity"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="UpdateFieldValue">
															<parameters>
																<primitiveExpression value="DisplayRememberMe"/>
																<primitiveExpression value="false"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<xsl:if test="$MembershipRememberMeSet='true'">
											<methodInvokeExpression methodName="UpdateFieldValue">
												<parameters>
													<primitiveExpression value="RememberMe"/>
													<primitiveExpression value="true"/>
												</parameters>
											</methodInvokeExpression>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<methodInvokeExpression methodName="UpdateFieldValue">
											<parameters>
												<primitiveExpression value="DisplayRememberMe"/>
												<primitiveExpression value="false"/>
											</parameters>
										</methodInvokeExpression>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="$IsUnlimited='true'">
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="GreaterThan">
												<propertyReferenceExpression name="Count">
													<propertyReferenceExpression name="OAuthProviders"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="UpdateFieldValue">
												<parameters>
													<primitiveExpression value="OAuthEnabled"/>
													<primitiveExpression value="true"/>
												</parameters>
											</methodInvokeExpression>
											<!--<methodInvokeExpression methodName="UpdateFieldValue">
                        <parameters>
                          <primitiveExpression value="OAuthProvider"/>
                          <primitiveExpression value="other"/>
                        </parameters>
                      </methodInvokeExpression>-->
										</trueStatements>
									</conditionStatement>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- method PasswordRequest(string) -->
						<memberMethod name="PasswordRequest">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="MyProfile"/>
										<primitiveExpression value="passwordRequestForm"/>
										<primitiveExpression value="Custom"/>
										<primitiveExpression value="RequestPassword"/>
										<propertyReferenceExpression name="Execute">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<parameters>
								<parameter type="System.String" name="userName"/>
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
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="user"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="BooleanAnd">
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<propertyReferenceExpression name="Comment">
														<variableReferenceExpression name="user"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
												<methodInvokeExpression methodName="IsMatch">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Comment">
															<variableReferenceExpression name="user"/>
														</propertyReferenceExpression>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[Source:\s+\w+]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ShowAlert">
											<target>
												<typeReferenceExpression type="Result"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Localize">
													<parameters>
														<primitiveExpression value="UserNameDoesNotExist"/>
														<primitiveExpression value="User name does not exist."/>
													</parameters>
												</methodInvokeExpression>
												<primitiveExpression value="UserName"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Session">
														<propertyReferenceExpression name="Context"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="IdentityConfirmation"/>
												</indices>
											</arrayIndexerExpression>
											<argumentReferenceExpression name="userName"/>
										</assignStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="IsTouchClient">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="HideModal">
													<target>
														<propertyReferenceExpression name="Result"/>
													</target>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="ShowModal">
											<target>
												<propertyReferenceExpression name="Result"/>
											</target>
											<parameters>
												<primitiveExpression value="MyProfile"/>
												<primitiveExpression value="identityConfirmationForm"/>
												<primitiveExpression value="Edit"/>
												<primitiveExpression value="identityConfirmationForm"/>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- PrepareIdentityConfirmationRow()-->
						<memberMethod name="PrepareIdentityConfirmationRow">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="RowBuilder">
									<arguments>
										<primitiveExpression value="MyProfile"/>
										<primitiveExpression value="identityConfirmationForm"/>
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
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Session">
														<propertyReferenceExpression name="Context"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="IdentityConfirmation"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="UpdateFieldValue">
									<parameters>
										<primitiveExpression value="UserName"/>
										<propertyReferenceExpression name="userName"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="UpdateFieldValue">
									<parameters>
										<primitiveExpression value="PasswordAnswer"/>
										<primitiveExpression value="null"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="UpdateFieldValue">
									<parameters>
										<primitiveExpression value="PasswordQuestion"/>
										<propertyReferenceExpression name="PasswordQuestion">
											<methodInvokeExpression methodName="GetUser">
												<target>
													<typeReferenceExpression type="Membership"/>
												</target>
												<parameters>
													<variableReferenceExpression name="userName"/>
												</parameters>
											</methodInvokeExpression>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method IdentityConfirmation(string, string) -->
						<memberMethod name="IdentityConfirmation">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="MyProfile"/>
										<primitiveExpression value="identityConfirmationForm"/>
										<primitiveExpression value="Custom"/>
										<primitiveExpression value="ConfirmIdentity"/>
										<propertyReferenceExpression name="Execute">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<parameters>
								<parameter type="System.String" name="userName"/>
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
										<variableDeclarationStatement type="System.String" name="newPassword">
											<init>
												<methodInvokeExpression methodName="ResetPassword">
													<target>
														<variableReferenceExpression name="user"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="passwordAnswer"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<comment>create an email and send it to the user</comment>
										<variableDeclarationStatement type="MailMessage" name="message">
											<init>
												<objectCreateExpression type="MailMessage"/>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="To">
													<variableReferenceExpression name="message"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="Email">
													<variableReferenceExpression name="user"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<propertyReferenceExpression name="Subject">
												<variableReferenceExpression name="message"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="Format">
												<target>
													<typeReferenceExpression type="String"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="Localize">
														<parameters>
															<primitiveExpression value="NewPasswordSubject"/>
															<primitiveExpression value="New password for '{{0}}'."/>
														</parameters>
													</methodInvokeExpression>
													<argumentReferenceExpression name="userName"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Body">
												<variableReferenceExpression name="message"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="newPassword"/>
										</assignStatement>
										<tryStatement>
											<statements>
												<variableDeclarationStatement type="SmtpClient" name="client">
													<init>
														<objectCreateExpression type="SmtpClient"/>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="Send">
													<target>
														<variableReferenceExpression name="client"/>
													</target>
													<parameters>
														<variableReferenceExpression name="message"/>
													</parameters>
												</methodInvokeExpression>
												<comment>hide modal popup and display a confirmation</comment>
												<methodInvokeExpression methodName="ExecuteOnClient">
													<target>
														<propertyReferenceExpression name="Result"/>
													</target>
													<parameters>
														<primitiveExpression value="$app.alert('{{0}}', function () {{{{ window.history.go(-2); }}}})"/>
														<methodInvokeExpression methodName="Localize">
															<parameters>
																<primitiveExpression value="NewPasswordAlert"/>
																<primitiveExpression value="A new password has been emailed to the address on file."/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
											<catch exceptionType="Exception" localName="error">
												<methodInvokeExpression methodName="ShowAlert">
													<target>
														<propertyReferenceExpression name="Result"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Message">
															<variableReferenceExpression name="error"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</catch>
										</tryStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method PrepareCurrentUserRow() -->
						<memberMethod name="PrepareCurrentUserRow">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="RowBuilder">
									<arguments>
										<primitiveExpression value="MyProfile"/>
										<primitiveExpression value="myAccountForm"/>
										<propertyReferenceExpression name="Existing">
											<typeReferenceExpression type="RowKind"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<statements>
								<methodInvokeExpression methodName="UpdateFieldValue">
									<parameters>
										<primitiveExpression value="UserName"/>
										<propertyReferenceExpression name="UserName"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="UpdateFieldValue">
									<parameters>
										<primitiveExpression value="Email"/>
										<propertyReferenceExpression name="UserEmail"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="UpdateFieldValue">
									<parameters>
										<primitiveExpression value="PasswordQuestion"/>
										<propertyReferenceExpression name="PasswordQuestion">
											<methodInvokeExpression methodName="GetUser">
												<target>
													<propertyReferenceExpression name="Membership"/>
												</target>
											</methodInvokeExpression>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method BackToRequestPassword(string, string) -->
						<memberMethod name="BackToRequestPassword">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="MyProfile"/>
										<primitiveExpression value="identityConfirmationForm"/>
										<primitiveExpression value="Custom"/>
										<primitiveExpression value="BackToRequestPassword"/>
										<propertyReferenceExpression name="Execute">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<statements>
								<methodInvokeExpression methodName="PreventDefault"/>
								<methodInvokeExpression methodName="HideModal">
									<target>
										<propertyReferenceExpression name="Result"/>
									</target>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="IsTouchClient">
												<typeReferenceExpression type="ApplicationServices"/>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ShowModal">
											<target>
												<propertyReferenceExpression name="Result"/>
											</target>
											<parameters>
												<primitiveExpression value="MyProfile"/>
												<primitiveExpression value="passwordRequestForm"/>
												<primitiveExpression value="New"/>
												<primitiveExpression value="passwordRequestForm"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method UpdateMyAccount(string, string, string, string, string, string) -->
						<memberMethod name="UpdateMyAccount">
							<attributes family="true" />
							<customAttributes>
								<customAttribute name="ControllerAction">
									<arguments>
										<primitiveExpression value="MyProfile"/>
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
						<!-- method AccessControlValidation-->
						<memberMethod name="AccessControlValidation">
							<attributes public="true"/>
							<customAttributes>
								<customAttribute type="ControllerAction">
									<arguments>
										<primitiveExpression value="MyProfile"/>
										<primitiveExpression value="Select"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsAuthenticated">
											<propertyReferenceExpression name="Identity">
												<propertyReferenceExpression name="User">
													<propertyReferenceExpression name="Context"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<binaryOperatorExpression operator="BooleanOr">
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="View">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
														<primitiveExpression value="signUpForm"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="View">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
														<primitiveExpression value="passwordRequestForm"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="View">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
														<primitiveExpression value="identityConfirmationForm"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="View">
															<propertyReferenceExpression name="Request"/>
														</propertyReferenceExpression>
														<primitiveExpression value="loginForm"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="Exception">
												<parameters>
													<primitiveExpression value="Not authorized"/>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<xsl:if test="contains($ProviderName, 'Oracle')">
							<memberMethod name="BuildOracleDataRow">
								<attributes family="true" final="true"/>
								<customAttributes>
									<customAttribute type="RowBuilder">
										<arguments>
											<primitiveExpression value="MyProfile"/>
											<propertyReferenceExpression name="Existing">
												<typeReferenceExpression type="RowKind"/>
											</propertyReferenceExpression>
										</arguments>
									</customAttribute>
									<customAttribute type="RowBuilder">
										<arguments>
											<primitiveExpression value="MyProfile"/>
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
						<xsl:if test="$IsUnlimited='true'">
							<!-- member property OauthProviders -->
							<memberField type="SiteContentFileList" name="oauthProviders"/>
							<memberProperty type="SiteContentFileList" name="OAuthProviders">
								<attributes family="true"/>
								<getStatements>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<fieldReferenceExpression name="oauthProviders"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<propertyReferenceExpression name="IsSiteContentEnabled">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<fieldReferenceExpression name="oauthProviders"/>
														<methodInvokeExpression methodName="ReadSiteContent">
															<target>
																<propertyReferenceExpression name="Current">
																	<typeReferenceExpression type="ApplicationServices"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<primitiveExpression value="sys/saas"/>
																<primitiveExpression value="%"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
												<falseStatements>
													<assignStatement>
														<fieldReferenceExpression name="oauthProviders"/>
														<objectCreateExpression type="SiteContentFileList"/>
													</assignStatement>
												</falseStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<fieldReferenceExpression name="oauthProviders"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method SupportsVirtualization() -->
							<memberMethod name="SupportsVirtualization" returnType="System.Boolean">
								<attributes override="true" public="true"/>
								<parameters>
									<parameter type="System.String" name="controllerName"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="true"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method VirtualizeController(string)-->
							<memberMethod name="VirtualizeController">
								<attributes override="true" family="true"/>
								<parameters>
									<parameter type="System.String" name="controllerName"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="VirtualizeController">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<argumentReferenceExpression name="controllerName"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="SetTag">
										<target>
											<methodInvokeExpression methodName="SelectViews">
												<target>
													<methodInvokeExpression methodName="NodeSet"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<primitiveExpression value="odp-enabled-none"/>
										</parameters>
									</methodInvokeExpression>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="GreaterThan">
												<propertyReferenceExpression name="Count">
													<propertyReferenceExpression name="OAuthProviders"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<comment>customize login form when OAuth providers are detected in Site Content</comment>
											<methodInvokeExpression methodName="VisibleWhen">
												<target>
													<methodInvokeExpression methodName="SetHidden">
														<target>
															<methodInvokeExpression methodName="SelectDataFields">
																<target>
																	<methodInvokeExpression methodName="SetTag">
																		<target>
																			<methodInvokeExpression methodName="SelectDataField">
																				<target>
																					<methodInvokeExpression methodName="VisibleWhen">
																						<target>
																							<methodInvokeExpression methodName="SelectDataFields">
																								<target>
																									<methodInvokeExpression methodName="SelectViews">
																										<target>
																											<methodInvokeExpression methodName="WhenClientScript">
																												<target>
																													<methodInvokeExpression methodName="SelectCustomAction">
																														<target>
																															<methodInvokeExpression methodName="WhenClientScript">
																																<target>
																																	<methodInvokeExpression methodName="SelectCustomAction">
																																		<target>
																																			<methodInvokeExpression methodName="NodeSet"/>
																																		</target>
																																		<parameters>
																																			<primitiveExpression value="SignUp"/>
																																		</parameters>
																																	</methodInvokeExpression>
																																</target>
																																<parameters>
																																	<primitiveExpression value="$row.OAuthProvider== 'other'"/>
																																</parameters>
																															</methodInvokeExpression>
																														</target>
																														<parameters>
																															<primitiveExpression value="ForgotPassword"/>
																														</parameters>
																													</methodInvokeExpression>
																												</target>
																												<parameters>
																													<primitiveExpression value="$row.OAuthProvider== 'other'"/>
																												</parameters>
																											</methodInvokeExpression>
																										</target>
																										<parameters>
																											<primitiveExpression value="loginForm"/>
																										</parameters>
																									</methodInvokeExpression>
																								</target>
																								<parameters>
																									<primitiveExpression value="UserName"/>
																									<primitiveExpression value="Password"/>
																									<primitiveExpression value="RememberMe"/>
																								</parameters>
																							</methodInvokeExpression>
																						</target>
																						<parameters>
																							<primitiveExpression value="$row.OAuthProvider=='other'"/>
																						</parameters>
																					</methodInvokeExpression>
																				</target>
																				<parameters>
																					<primitiveExpression value="UserName"/>
																				</parameters>
																			</methodInvokeExpression>
																		</target>
																		<parameters>
																			<primitiveExpression value="focus-auto"/>
																		</parameters>
																	</methodInvokeExpression>
																</target>
																<parameters>
																	<primitiveExpression value="OAuthProvider"/>
																</parameters>
															</methodInvokeExpression>
														</target>
														<parameters>
															<primitiveExpression value="false"/>
														</parameters>
													</methodInvokeExpression>
												</target>
												<parameters>
													<primitiveExpression value="$row.OAuthEnabled"/>
												</parameters>
											</methodInvokeExpression>
											<comment>customize OAuth provider items</comment>
											<variableDeclarationStatement type="List" name="items">
												<typeArguments>
													<typeReference type="XPathNavigator"/>
												</typeArguments>
												<init>
													<propertyReferenceExpression name="Nodes">
														<methodInvokeExpression methodName="SelectItems">
															<target>
																<methodInvokeExpression methodName="SelectField">
																	<target>
																		<methodInvokeExpression methodName="NodeSet"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="OAuthProvider"/>
																	</parameters>
																</methodInvokeExpression>
															</target>
														</methodInvokeExpression>
													</propertyReferenceExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="Count">
															<variableReferenceExpression name="items"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement type="List" name="supportedProviders">
														<init>
															<objectCreateExpression type="List">
																<typeArguments>
																	<typeReference type="System.String"/>
																</typeArguments>
															</objectCreateExpression>
														</init>
													</variableDeclarationStatement>
													<foreachStatement>
														<variable type="SiteContentFile" name="file"/>
														<target>
															<propertyReferenceExpression name="OAuthProviders"/>
														</target>
														<statements>
															<methodInvokeExpression methodName="Add">
																<target>
																	<variableReferenceExpression name="supportedProviders"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="file"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</statements>
													</foreachStatement>
													<foreachStatement>
														<variable type="XPathNavigator" name="item"/>
														<target>
															<variableReferenceExpression name="items"/>
														</target>
														<statements>
															<variableDeclarationStatement type="System.String" name="provider">
																<init>
																	<methodInvokeExpression methodName="GetAttribute">
																		<target>
																			<variableReferenceExpression name="item"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="value"/>
																			<stringEmptyExpression/>
																		</parameters>
																	</methodInvokeExpression>
																</init>
															</variableDeclarationStatement>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="ValueEquality">
																		<variableReferenceExpression name="provider"/>
																		<primitiveExpression value="other"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<variableDeclarationStatement type="XPathNavigator" name="otherItemText">
																		<init>
																			<methodInvokeExpression methodName="SelectSingleNode">
																				<target>
																					<variableReferenceExpression name="item"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="@text"/>
																				</parameters>
																			</methodInvokeExpression>
																		</init>
																	</variableDeclarationStatement>
																	<conditionStatement>
																		<condition>
																			<binaryOperatorExpression operator="BooleanAnd">
																				<binaryOperatorExpression operator="IdentityInequality">
																					<variableReferenceExpression name="otherItemText"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																				<binaryOperatorExpression operator="ValueEquality">
																					<propertyReferenceExpression name="Value">
																						<variableReferenceExpression name="otherItemText"/>
																					</propertyReferenceExpression>
																					<primitiveExpression value="Other"/>
																				</binaryOperatorExpression>
																			</binaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<methodInvokeExpression methodName="SetValue">
																				<target>
																					<variableReferenceExpression name="otherItemText"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="DisplayName">
																						<propertyReferenceExpression name="Current">
																							<typeReferenceExpression type="ApplicationServicesBase"/>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</trueStatements>
																	</conditionStatement>
																</trueStatements>
																<falseStatements>
																	<conditionStatement>
																		<condition>
																			<unaryOperatorExpression operator="Not">
																				<methodInvokeExpression methodName="Contains">
																					<target>
																						<variableReferenceExpression name="supportedProviders"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="provider"/>
																					</parameters>
																				</methodInvokeExpression>
																			</unaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<methodInvokeExpression methodName="DeleteSelf">
																				<target>
																					<variableReferenceExpression name="item"/>
																				</target>
																			</methodInvokeExpression>
																		</trueStatements>
																	</conditionStatement>
																</falseStatements>
															</conditionStatement>
														</statements>
													</foreachStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
						</xsl:if>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
