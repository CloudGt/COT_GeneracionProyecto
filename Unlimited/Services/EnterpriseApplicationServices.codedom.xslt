<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsUnlimited"/>
	<xsl:variable name="MembershipEnabled" select="a:project/a:membership/@enabled"/>
	<xsl:variable name="CustomSecurity" select="a:project/a:membership/@customSecurity"/>

	<xsl:template match="/">
		<compileUnit namespace="{a:project/a:namespace}.Services">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Globalization"/>
				<namespaceImport name="System.Net"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Routing"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Xml"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
				<namespaceImport name="{a:project/a:namespace}.Data"/>
				<!--<namespaceImport name="{a:project/a:namespace}.Security"/>-->
			</imports>
			<types>
				<!-- class EnterpriseApplicationServices -->
				<typeDeclaration name="EnterpriseApplicationServices" isPartial="true">
					<baseTypes>
						<typeReference type="EnterpriseApplicationServicesBase"/>
					</baseTypes>
					<members>
					</members>
				</typeDeclaration>
				<!-- class EnterpriseApplicationServicesBase -->
				<typeDeclaration name="EnterpriseApplicationServicesBase">
					<baseTypes>
						<typeReference type="ApplicationServicesBase"/>
					</baseTypes>
					<members>
						<!-- property AppServicesRegex -->
						<memberField type="Regex" name="AppServicesRegex">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression value="/appservices/(?'Controller'\w+?)(/|$)"/>
										<propertyReferenceExpression name="IgnoreCase">
											<typeReferenceExpression type="RegexOptions"/>
										</propertyReferenceExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- property DynamicResourceRegex -->
						<memberField type="Regex" name="DynamicResourceRegex">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression value="(\.js$|^_(invoke|authenticate)$)"/>
										<propertyReferenceExpression name="IgnoreCase">
											<typeReferenceExpression type="RegexOptions"/>
										</propertyReferenceExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- property DynamicWebResourceRegex -->
						<memberField type="Regex" name="DynamicWebResourceRegex">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression value="\.(js|css)$"/>
										<propertyReferenceExpression name="IgnoreCase">
											<typeReferenceExpression type="RegexOptions"/>
										</propertyReferenceExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- method RegisterServices() -->
						<memberMethod name="RegisterServices">
							<attributes public="true" override="true"/>
							<statements>
								<methodInvokeExpression methodName="RegisterREST"/>
								<methodInvokeExpression methodName="RegisterServices">
									<target>
										<baseReferenceExpression/>
									</target>
								</methodInvokeExpression>
								<assignStatement>
									<propertyReferenceExpression name="SecurityProtocol">
										<typeReferenceExpression type="ServicePointManager"/>
									</propertyReferenceExpression>
									<binaryOperatorExpression operator="BitwiseOr">
										<propertyReferenceExpression name="SecurityProtocol">
											<typeReferenceExpression type="ServicePointManager"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Tls12">
											<typeReferenceExpression type="SecurityProtocolType"/>
										</propertyReferenceExpression>
									</binaryOperatorExpression>
								</assignStatement>
								<xsl:if test="$MembershipEnabled='true' or $CustomSecurity='true'">
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Handlers">
												<typeReferenceExpression type="OAuthHandlerFactoryBase"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<primitiveExpression value="facebook"/>
											<typeofExpression type="FacebookOAuthHandler"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Handlers">
												<typeReferenceExpression type="OAuthHandlerFactoryBase"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<primitiveExpression value="google"/>
											<typeofExpression type="GoogleOAuthHandler"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Handlers">
												<typeReferenceExpression type="OAuthHandlerFactoryBase"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<primitiveExpression value="msgraph"/>
											<typeofExpression type="MSGraphOAuthHandler"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Handlers">
												<typeReferenceExpression type="OAuthHandlerFactoryBase"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<primitiveExpression value="linkedin"/>
											<typeofExpression type="LinkedInOAuthHandler"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Handlers">
												<typeReferenceExpression type="OAuthHandlerFactoryBase"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<primitiveExpression value="windowslive"/>
											<typeofExpression type="WindowsLiveOAuthHandler"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Handlers">
												<typeReferenceExpression type="OAuthHandlerFactoryBase"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<primitiveExpression value="sharepoint"/>
											<typeofExpression type="SharePointOAuthHandler"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Add">
										<target>
											<propertyReferenceExpression name="Handlers">
												<typeReferenceExpression type="OAuthHandlerFactoryBase"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<primitiveExpression value="identityserver"/>
											<typeofExpression type="IdentityServerOAuthHandler"/>
										</parameters>
									</methodInvokeExpression>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- method RegisterREST() -->
						<memberMethod name="RegisterREST">
							<attributes public="true"/>
							<statements>
								<variableDeclarationStatement type="RouteCollection" name="routes">
									<init>
										<propertyReferenceExpression name="Routes">
											<propertyReferenceExpression name="RouteTable"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="RouteExistingFiles">
										<variableReferenceExpression name="routes"/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<methodInvokeExpression methodName="Map">
									<target>
										<typeReferenceExpression type="GenericRoute"/>
									</target>
									<parameters>
										<variableReferenceExpression name="routes"/>
										<objectCreateExpression type="RepresentationalStateTransfer"/>
										<primitiveExpression value="appservices/{{Controller}}/{{Segment1}}/{{Segment2}}/{{Segment3}}/{{Segment4}}"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Map">
									<target>
										<typeReferenceExpression type="GenericRoute"/>
									</target>
									<parameters>
										<variableReferenceExpression name="routes"/>
										<objectCreateExpression type="RepresentationalStateTransfer"/>
										<primitiveExpression value="appservices/{{Controller}}/{{Segment1}}/{{Segment2}}/{{Segment3}}"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Map">
									<target>
										<typeReferenceExpression type="GenericRoute"/>
									</target>
									<parameters>
										<variableReferenceExpression name="routes"/>
										<objectCreateExpression type="RepresentationalStateTransfer"/>
										<primitiveExpression value="appservices/{{Controller}}/{{Segment1}}/{{Segment2}}"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Map">
									<target>
										<typeReferenceExpression type="GenericRoute"/>
									</target>
									<parameters>
										<variableReferenceExpression name="routes"/>
										<objectCreateExpression type="RepresentationalStateTransfer"/>
										<primitiveExpression value="appservices/{{Controller}}/{{Segment1}}"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Map">
									<target>
										<typeReferenceExpression type="GenericRoute"/>
									</target>
									<parameters>
										<variableReferenceExpression name="routes"/>
										<objectCreateExpression type="RepresentationalStateTransfer"/>
										<primitiveExpression value="appservices/{{Controller}}"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method RequiresAuthentication(HttpRequest) -->
						<memberMethod returnType="System.Boolean" name="RequiresAuthentication">
							<attributes public="true" override="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Boolean" name="result">
									<init>
										<methodInvokeExpression methodName="RequiresAuthentication">
											<target>
												<baseReferenceExpression/>
											</target>
											<parameters>
												<argumentReferenceExpression name="request"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<variableReferenceExpression name="result"/>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="Match" name="m">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<propertyReferenceExpression name="AppServicesRegex"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Path">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
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
										<variableDeclarationStatement type="ControllerConfiguration" name="config">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<tryStatement>
											<statements>
												<variableDeclarationStatement type="System.String" name="controllerName">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Controller"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanOr">
															<binaryOperatorExpression operator="ValueEquality">
																<variableReferenceExpression name="controllerName"/>
																<primitiveExpression value="_authenticate"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="ValueEquality">
																<variableReferenceExpression name="controllerName"/>
																<primitiveExpression value="saas"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="false"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="IsMatch">
																<target>
																	<propertyReferenceExpression name="DynamicResourceRegex"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="controllerName"/>
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
																	<variableReferenceExpression name="controllerName"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
											<catch exceptionType="Exception">
											</catch>
										</tryStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="config"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="IsMatch">
															<target>
																<propertyReferenceExpression name="DynamicWebResourceRegex"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Path">
																	<variableReferenceExpression name="request"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<methodInvokeExpression methodName="RequiresRESTAuthentication">
												<parameters>
													<argumentReferenceExpression name="request"/>
													<variableReferenceExpression name="config"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method RequiresAuthentication(HttpRequest, ControllerConfiguration) -->
						<memberMethod returnType="System.Boolean" name="RequiresRESTAuthentication">
							<attributes public="true"/>
							<parameters>
								<parameter type="HttpRequest" name="request"/>
								<parameter type="ControllerConfiguration" name="config"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="RequiresAuthentication">
										<target>
											<typeReferenceExpression type="UriRestConfig"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="request"/>
											<argumentReferenceExpression name="config"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class ScheduleStatus -->
				<typeDeclaration name="ScheduleStatus">
					<attributes public="true"/>
					<members>
						<!-- property Schedule -->
						<memberProperty type="System.String" name="Schedule">
							<comment>The definition of the schedule.</comment>
							<attributes public="true"/>
						</memberProperty>
						<!-- property Exceptions -->
						<memberProperty type="System.String" name="Exceptions">
							<comment>The defintion of excepetions to the schedule. Exceptions are expressed as another schedule.</comment>
							<attributes public="true"/>
						</memberProperty>
						<!-- property Success-->
						<memberProperty type="System.Boolean" name="Success">
							<comment>True if the schedule is valid at this time.</comment>
							<attributes public="true"/>
						</memberProperty>
						<!-- property NextTestDate -->
						<memberProperty type="DateTime" name="NextTestDate">
							<comment>The next date and time when the schedule is invalid.</comment>
							<attributes public="true"/>
						</memberProperty>
						<!-- property Expired -->
						<memberProperty type="System.Boolean" name="Expired">
							<comment>True if the schedule has expired. For internal use only.</comment>
							<attributes public="true"/>
						</memberProperty>
						<!-- property Precision -->
						<memberProperty type="System.String" name="Precision">
							<comment>The precision of the schedule. For internal use only.</comment>
							<attributes public="true"/>
						</memberProperty>
					</members>
				</typeDeclaration>
				<!-- class Scheduler -->
				<typeDeclaration name="Scheduler" isPartial="true">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="SchedulerBase"/>
					</baseTypes>
				</typeDeclaration>
				<!-- class Scheduler-->
				<typeDeclaration name="SchedulerBase">
					<attributes public="true"/>
					<members>
						<!--
        private static Regex _nodeMatchRegex = new Regex("(?\'Depth\'\\++)\\s*(?\'NodeType\'\\S+)\\s*(?\'Properties\'[^\\+]*)");

        private static Regex _propertyMatchRegex = new Regex("\\s*(?\'Name\'[a-zA-Z]*)\\s*[:=]?\\s*(?\'Value\'.+?)(\n|;|$)");
            -->
						<!-- field nodeMatchRegex-->
						<memberField type="Regex" name="NodeMatchRegex">
							<attributes static="true" public="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression>
											<xsl:attribute name="value"><![CDATA[(?'Depth'\++)\s*(?'NodeType'\S+)\s*(?'Properties'[^\+]*)]]></xsl:attribute>
										</primitiveExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- field propertyMatchRegex-->
						<memberField type="Regex" name="PropertyMatchRegex">
							<attributes static="true" public="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression>
											<xsl:attribute name="value"><![CDATA[\s*(?'Name'[a-zA-Z]*)\s*[:=]?\s*(?'Value'.+?)(\n|;|$)]]></xsl:attribute>
										</primitiveExpression>
										<!--<propertyReferenceExpression name="Multiline">
                      <typeReferenceExpression type="RegexOptions"/>
                    </propertyReferenceExpression>-->
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- field nodeTypes-->
						<memberField type="System.String[]" name="nodeTypes">
							<attributes static="true" private="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<primitiveExpression value="yearly"/>
										<primitiveExpression value="monthly"/>
										<primitiveExpression value="weekly"/>
										<primitiveExpression value="daily"/>
										<primitiveExpression value="once"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- property TestDate-->
						<memberProperty type="DateTime" name="TestDate">
							<attributes public="true"/>
						</memberProperty>
						<!-- method Test(string)-->
						<memberMethod returnType="ScheduleStatus" name="Test">
							<comment>Check if a free form text schedule is valid now.</comment>
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="schedule"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Test">
										<parameters>
											<argumentReferenceExpression name="schedule"/>
											<primitiveExpression value="null"/>
											<propertyReferenceExpression name="Now">
												<typeReferenceExpression type="DateTime"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Test(string, DateTime)-->
						<memberMethod returnType="ScheduleStatus" name="Test">
							<comment>Check if a free form text schedule is valid on the testDate.</comment>
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="schedule"/>
								<parameter type="DateTime" name="testDate"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Test">
										<parameters>
											<argumentReferenceExpression name="schedule"/>
											<primitiveExpression value="null"/>
											<argumentReferenceExpression name="testDate"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Test(string, string)-->
						<memberMethod returnType="ScheduleStatus" name="Test">
							<comment>Check if a free form text schedule with exceptions is valid now.</comment>
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="schedule"/>
								<parameter type="System.String" name="exceptions"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Test">
										<parameters>
											<argumentReferenceExpression name="schedule"/>
											<argumentReferenceExpression name="exceptions"/>
											<propertyReferenceExpression name="Now">
												<typeReferenceExpression type="DateTime"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Test(string, string, DateTime)-->
						<memberMethod returnType="ScheduleStatus" name="Test">
							<comment>Check if a free form text schedule with exceptions is valid on the testDate.</comment>
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="schedule"/>
								<parameter type="System.String" name="exceptions"/>
								<parameter type="DateTime" name="testDate"/>
							</parameters>
							<statements>
								<!-- 
            Scheduler s = new Scheduler();
            s.TestDate = testDate;
            ScheduleStatus status = s.CheckSchedule(schedule, exceptions);
            status.Schedule = schedule;
            status.Exceptions = exceptions;
            return status;
                -->
								<variableDeclarationStatement type="Scheduler" name="s">
									<init>
										<objectCreateExpression type="Scheduler"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="TestDate">
										<variableReferenceExpression name="s"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="testDate"/>
								</assignStatement>
								<variableDeclarationStatement type="ScheduleStatus" name="status">
									<init>
										<methodInvokeExpression methodName="CheckSchedule">
											<target>
												<variableReferenceExpression name="s"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="schedule"/>
												<argumentReferenceExpression name="exceptions"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Schedule">
										<variableReferenceExpression name="status"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="schedule"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Exceptions">
										<variableReferenceExpression name="status"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="exceptions"/>
								</assignStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="status"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CheckSchedule(string) -->
						<memberMethod returnType="ScheduleStatus" name="CheckSchedule">
							<attributes public="true" />
							<parameters>
								<parameter type="System.String" name="schedule"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="CheckSchedule">
										<parameters>
											<methodInvokeExpression methodName="StringToXml">
												<parameters>
													<argumentReferenceExpression name="schedule"/>
												</parameters>
											</methodInvokeExpression>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CheckSchedule(string,string) -->
						<memberMethod returnType="ScheduleStatus" name="CheckSchedule">
							<attributes public="true" />
							<parameters>
								<parameter type="System.String" name="schedule"/>
								<parameter type="System.String" name="exceptions"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="CheckSchedule">
										<parameters>
											<methodInvokeExpression methodName="StringToXml">
												<parameters>
													<argumentReferenceExpression name="schedule"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="StringToXml">
												<parameters>
													<argumentReferenceExpression name="exceptions"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CheckSchedule(Stream) -->
						<memberMethod returnType="ScheduleStatus" name="CheckSchedule">
							<comment>Check an XML schedule.</comment>
							<attributes public="true" />
							<parameters>
								<parameter type="Stream" name="schedule"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="CheckSchedule">
										<parameters>
											<argumentReferenceExpression name="schedule"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CheckSchedule(Stream,Stream) -->
						<memberMethod returnType="ScheduleStatus" name="CheckSchedule">
							<comment>Check an XML schedule with exceptions.</comment>
							<attributes public="true" />
							<parameters>
								<parameter type="Stream" name="schedule"/>
								<parameter type="Stream" name="exceptions"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ScheduleStatus" name="sched">
									<init>
										<objectCreateExpression type="ScheduleStatus"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Precision">
										<variableReferenceExpression name="sched"/>
									</propertyReferenceExpression>
									<stringEmptyExpression/>
								</assignStatement>
								<variableDeclarationStatement type="ScheduleStatus" name="xSched">
									<init>
										<objectCreateExpression type="ScheduleStatus"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Precision">
										<variableReferenceExpression name="xSched"/>
									</propertyReferenceExpression>
									<stringEmptyExpression/>
								</assignStatement>
								<variableDeclarationStatement type="XPathNavigator" name="nav">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="XPathNavigator" name="xNav">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="IdentityEquality">
												<argumentReferenceExpression name="schedule"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<methodInvokeExpression methodName="Equals">
												<target>
													<argumentReferenceExpression name="schedule"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Null">
														<typeReferenceExpression type="Stream"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="sched"/>
											</propertyReferenceExpression>
											<primitiveExpression value="true"/>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<variableDeclarationStatement type="XPathDocument" name="doc">
											<init>
												<objectCreateExpression type="XPathDocument">
													<parameters>
														<argumentReferenceExpression name="schedule"/>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="nav"/>
											<methodInvokeExpression methodName="CreateNavigator">
												<target>
													<variableReferenceExpression name="doc"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="MoveToChild">
															<target>
																<variableReferenceExpression name="nav"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Element">
																	<typeReferenceExpression type="XPathNodeType"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
													<binaryOperatorExpression operator="ValueInequality">
														<propertyReferenceExpression name="Name">
															<variableReferenceExpression name="nav"/>
														</propertyReferenceExpression>
														<primitiveExpression value="schedule"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Success">
														<variableReferenceExpression name="sched"/>
													</propertyReferenceExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="CheckNode">
													<parameters>
														<variableReferenceExpression name="nav"/>
														<propertyReferenceExpression name="Now">
															<typeReferenceExpression type="DateTime"/>
														</propertyReferenceExpression>
														<directionExpression direction="Ref">
															<variableReferenceExpression name="sched"/>
														</directionExpression>
													</parameters>
												</methodInvokeExpression>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<argumentReferenceExpression name="exceptions"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="Equals">
													<target>
														<argumentReferenceExpression name="exceptions"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Null">
															<typeReferenceExpression type="Stream"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="XPathDocument" name="xDoc">
											<init>
												<objectCreateExpression type="XPathDocument">
													<parameters>
														<argumentReferenceExpression name="exceptions"/>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="xNav"/>
											<methodInvokeExpression methodName="CreateNavigator">
												<target>
													<variableReferenceExpression name="xDoc"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="MoveToChild">
															<target>
																<variableReferenceExpression name="xNav"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Element">
																	<typeReferenceExpression type="XPathNodeType"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
													<binaryOperatorExpression operator="ValueInequality">
														<propertyReferenceExpression name="Name">
															<variableReferenceExpression name="xNav"/>
														</propertyReferenceExpression>
														<primitiveExpression value="schedule"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Success">
														<variableReferenceExpression name="xSched"/>
													</propertyReferenceExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="CheckNode">
													<parameters>
														<variableReferenceExpression name="xNav"/>
														<propertyReferenceExpression name="Now">
															<typeReferenceExpression type="DateTime"/>
														</propertyReferenceExpression>
														<directionExpression direction="Ref">
															<variableReferenceExpression name="xSched"/>
														</directionExpression>
													</parameters>
												</methodInvokeExpression>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Success">
											<variableReferenceExpression name="xSched"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="sched"/>
											</propertyReferenceExpression>
											<primitiveExpression value="false"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="UsePreciseProbe"/>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="sched"/>
											<methodInvokeExpression methodName="ProbeScheduleExact">
												<parameters>
													<variableReferenceExpression name="nav"/>
													<variableReferenceExpression name="xNav"/>
													<variableReferenceExpression name="sched"/>
													<variableReferenceExpression name="xSched"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<assignStatement>
											<variableReferenceExpression name="sched"/>
											<methodInvokeExpression methodName="ProbeSchedule">
												<parameters>
													<variableReferenceExpression name="nav"/>
													<variableReferenceExpression name="xNav"/>
													<variableReferenceExpression name="sched"/>
													<variableReferenceExpression name="xSched"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="sched"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method StringToXml(string)-->
						<memberMethod returnType="Stream" name="StringToXml">
							<comment>Converts plain text schedule format into XML stream.</comment>
							<attributes private="true"/>
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
								<comment>check for shorthand "start"</comment>
								<variableDeclarationStatement type="DateTime" name="testDate">
									<init>
										<propertyReferenceExpression name="Now">
											<typeReferenceExpression type="DateTime"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="TryParse">
											<target>
												<typeReferenceExpression type="DateTime"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="text"/>
												<directionExpression direction="Out">
													<variableReferenceExpression name="testDate"/>
												</directionExpression>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<stringFormatExpression format="+once start: {{0}}">
											<argumentReferenceExpression name="text"/>
										</stringFormatExpression>
									</trueStatements>
								</conditionStatement>
								<comment>compose XML document</comment>
								<variableDeclarationStatement type="XmlDocument" name="doc">
									<init>
										<objectCreateExpression type="XmlDocument"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="XmlDeclaration" name="dec">
									<init>
										<methodInvokeExpression methodName="CreateXmlDeclaration">
											<target>
												<variableReferenceExpression name="doc"/>
											</target>
											<parameters>
												<primitiveExpression value="1.0" convertTo="String"/>
												<primitiveExpression value="null"/>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="AppendChild">
									<target>
										<variableReferenceExpression name="doc"/>
									</target>
									<parameters>
										<variableReferenceExpression name="dec"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="XmlNode" name="schedule">
									<init>
										<methodInvokeExpression methodName="CreateNode">
											<target>
												<variableReferenceExpression name="doc"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Element">
													<typeReferenceExpression type="XmlNodeType"/>
												</propertyReferenceExpression>
												<primitiveExpression value="schedule"/>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="AppendChild">
									<target>
										<variableReferenceExpression name="doc"/>
									</target>
									<parameters>
										<variableReferenceExpression name="schedule"/>
									</parameters>
								</methodInvokeExpression>
								<comment>configure nodes</comment>
								<variableDeclarationStatement type="MatchCollection" name="nodes">
									<init>
										<methodInvokeExpression methodName="Matches">
											<target>
												<propertyReferenceExpression name="NodeMatchRegex"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="text"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="XmlNode" name="lastNode">
									<init>
										<variableReferenceExpression name="schedule"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Int32" name="lastDepth">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="Match" name="node" var="false"/>
									<target>
										<variableReferenceExpression name="nodes"/>
									</target>
									<statements>
										<variableDeclarationStatement type="System.String" name="nodeType">
											<init>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<variableReferenceExpression name="node"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="NodeType"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Int32" name="depth">
											<init>
												<propertyReferenceExpression name="Length">
													<propertyReferenceExpression name="Value">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Groups">
																	<variableReferenceExpression name="node"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="Depth"/>
															</indices>
														</arrayIndexerExpression>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="properties">
											<init>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<variableReferenceExpression name="node"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="Properties"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Contains">
													<target>
														<fieldReferenceExpression name="nodeTypes"/>
													</target>
													<parameters>
														<variableReferenceExpression name="nodeType"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="XmlNode" name="newNode">
													<init>
														<methodInvokeExpression methodName="CreateNode">
															<target>
																<variableReferenceExpression name="doc"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Element">
																	<typeReferenceExpression type="XmlNodeType"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="nodeType"/>
																<primitiveExpression value="null"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="MatchCollection" name="propertyMatches">
													<init>
														<methodInvokeExpression methodName="Matches">
															<target>
																<propertyReferenceExpression name="PropertyMatchRegex"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="node"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Properties"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<comment>populate attributes</comment>
												<foreachStatement>
													<variable type="Match" name="property" var="false"/>
													<target>
														<variableReferenceExpression name="propertyMatches"/>
													</target>
													<statements>
														<variableDeclarationStatement type="System.String" name="name">
															<init>
																<methodInvokeExpression methodName="Trim">
																	<target>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="property"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="Name"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																	</target>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="val">
															<init>
																<methodInvokeExpression methodName="Trim">
																	<target>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="property"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="Value"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																	</target>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<comment>group value</comment>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNullOrEmpty">
																	<variableReferenceExpression name="name"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="name"/>
																	<primitiveExpression value="value"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<variableDeclarationStatement type="XmlAttribute" name="attr">
															<init>
																<methodInvokeExpression methodName="CreateAttribute">
																	<target>
																		<variableReferenceExpression name="doc"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="name"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="attr"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="val"/>
														</assignStatement>
														<methodInvokeExpression methodName="Append">
															<target>
																<propertyReferenceExpression name="Attributes">
																	<variableReferenceExpression name="newNode"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="attr"/>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
												<comment>insert node</comment>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="GreaterThan">
															<variableReferenceExpression name="depth"/>
															<variableReferenceExpression name="lastDepth"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="AppendChild">
															<target>
																<variableReferenceExpression name="lastNode"/>
															</target>
															<parameters>
																<variableReferenceExpression name="newNode"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="LessThan">
																	<variableReferenceExpression name="depth"/>
																	<variableReferenceExpression name="lastDepth"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<whileStatement>
																	<test>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<binaryOperatorExpression operator="ValueInequality">
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="lastNode"/>
																				</propertyReferenceExpression>
																				<primitiveExpression value="schedule"/>
																			</binaryOperatorExpression>
																			<binaryOperatorExpression operator="ValueInequality">
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="lastNode"/>
																				</propertyReferenceExpression>
																				<variableReferenceExpression name="nodeType"/>
																			</binaryOperatorExpression>
																		</binaryOperatorExpression>
																	</test>
																	<statements>
																		<assignStatement>
																			<variableReferenceExpression name="lastNode"/>
																			<propertyReferenceExpression name="ParentNode">
																				<variableReferenceExpression name="lastNode"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																	</statements>
																</whileStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="Name">
																				<variableReferenceExpression name="lastNode"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="nodeType"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="lastNode"/>
																			<propertyReferenceExpression name="ParentNode">
																				<variableReferenceExpression name="lastNode"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="AppendChild">
																	<target>
																		<variableReferenceExpression name="lastNode"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="newNode"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="AppendChild">
																	<target>
																		<propertyReferenceExpression name="ParentNode">
																			<variableReferenceExpression name="lastNode"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="newNode"/>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="lastNode"/>
													<variableReferenceExpression name="newNode"/>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="lastDepth"/>
													<variableReferenceExpression name="depth"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<comment>save and return</comment>
								<variableDeclarationStatement type="MemoryStream" name="stream">
									<init>
										<objectCreateExpression type="MemoryStream"/>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="Save">
									<target>
										<variableReferenceExpression name="doc"/>
									</target>
									<parameters>
										<variableReferenceExpression name="stream"/>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<propertyReferenceExpression name="Position">
										<variableReferenceExpression name="stream"/>
									</propertyReferenceExpression>
									<primitiveExpression value="0"/>
								</assignStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="stream"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CheckNode(XPathNavigator, DateTime, ref ScheduleStatus)-->
						<memberMethod returnType="System.Boolean" name="CheckNode">
							<comment>Checks the current navigator if the current nodes define an active schedule. An empty schedule will set Match to true.</comment>
							<attributes  private="true"/>
							<parameters>
								<parameter type="XPathNavigator" name="nav"/>
								<parameter type="DateTime" name="checkDate"/>
								<parameter type="ScheduleStatus" name="sched" direction="Ref"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<argumentReferenceExpression name="nav"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="Precision">
										<argumentReferenceExpression name="sched"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="Name">
										<argumentReferenceExpression name="nav"/>
									</propertyReferenceExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="MoveToFirstChild">
												<target>
													<argumentReferenceExpression name="nav"/>
												</target>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<comment>no schedule limitation</comment>
										<assignStatement>
											<propertyReferenceExpression name="Success">
												<argumentReferenceExpression name="sched"/>
											</propertyReferenceExpression>
											<primitiveExpression value="true"/>
										</assignStatement>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<whileStatement>
									<test>
										<primitiveExpression value="true"/>
									</test>
									<statements>
										<comment>ignore comments</comment>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Equals">
														<target>
															<propertyReferenceExpression name="NodeType">
																<argumentReferenceExpression name="nav"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<propertyReferenceExpression name="Comment">
																<typeReferenceExpression type="XPathNodeType"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String" name="name">
													<init>
														<propertyReferenceExpression name="Name">
															<argumentReferenceExpression name="nav"/>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="name"/>
															<primitiveExpression value="once"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="CheckInterval">
																	<parameters>
																		<argumentReferenceExpression name="nav"/>
																		<argumentReferenceExpression name="checkDate"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="Success">
																		<argumentReferenceExpression name="sched"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="true"/>
																</assignStatement>
															</trueStatements>
															<!--<falseStatements>
                                <assignStatement>
                                  <propertyReferenceExpression name="Expired">
                                    <argumentReferenceExpression name="sched"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="true"/>
                                </assignStatement>
                              </falseStatements>-->
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="CheckInterval">
																	<parameters>
																		<argumentReferenceExpression name="nav"/>
																		<argumentReferenceExpression name="checkDate"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>

																<variableDeclarationStatement type="System.String" name="value">
																	<init>
																		<methodInvokeExpression methodName="GetAttribute">
																			<target>
																				<argumentReferenceExpression name="nav"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="value"/>
																				<stringEmptyExpression/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="System.String" name="every">
																	<init>
																		<methodInvokeExpression methodName="GetAttribute">
																			<target>
																				<argumentReferenceExpression name="nav"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="every"/>
																				<stringEmptyExpression/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="System.Int32" name="check">
																	<init>
																		<primitiveExpression value="0"/>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="name"/>
																			<primitiveExpression value="yearly"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="check"/>
																			<propertyReferenceExpression name="Year">
																				<argumentReferenceExpression name="checkDate"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<variableReferenceExpression name="name"/>
																					<primitiveExpression value="monthly"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="check"/>
																					<propertyReferenceExpression name="Month">
																						<argumentReferenceExpression name="checkDate"/>
																					</propertyReferenceExpression>
																				</assignStatement>
																			</trueStatements>
																			<falseStatements>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="ValueEquality">
																							<variableReferenceExpression name="name"/>
																							<primitiveExpression value="weekly"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="check"/>
																							<methodInvokeExpression methodName="GetWeekOfMonth">
																								<parameters>
																									<argumentReferenceExpression name="checkDate"/>
																								</parameters>
																							</methodInvokeExpression>
																						</assignStatement>
																					</trueStatements>
																					<falseStatements>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="name"/>
																									<primitiveExpression value="daily"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<assignStatement>
																									<variableReferenceExpression name="check"/>
																									<castExpression targetType="System.Int32">
																										<propertyReferenceExpression name="DayOfWeek">
																											<argumentReferenceExpression name="checkDate"/>
																										</propertyReferenceExpression>
																									</castExpression>
																								</assignStatement>
																							</trueStatements>
																						</conditionStatement>
																					</falseStatements>
																				</conditionStatement>
																			</falseStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="CheckNumberInterval">
																			<parameters>
																				<variableReferenceExpression name="value"/>
																				<variableReferenceExpression name="check"/>
																				<variableReferenceExpression name="every"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="CheckNode">
																			<parameters>
																				<argumentReferenceExpression name="nav"/>
																				<argumentReferenceExpression name="checkDate"/>
																				<directionExpression direction="Ref">
																					<argumentReferenceExpression name="sched"/>
																				</directionExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<comment>found a match</comment>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanOr">
															<propertyReferenceExpression name="Expired">
																<argumentReferenceExpression name="sched"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Success">
																<argumentReferenceExpression name="sched"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<breakStatement/>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<comment>no more nodes</comment>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="MoveToNext">
														<target>
															<argumentReferenceExpression name="nav"/>
														</target>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<breakStatement/>
											</trueStatements>
										</conditionStatement>
									</statements>
								</whileStatement>
								<methodReturnStatement>
									<propertyReferenceExpression name="Success">
										<variableReferenceExpression name="sched"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CheckNumberInterval(string, int, string)-->
						<memberMethod returnType="System.Boolean" name="CheckNumberInterval">
							<comment>Checks to see if a series of comma-separated numbers and/or dash-separated intervals contain a specific number</comment>
							<attributes private="true" />
							<parameters>
								<parameter type="System.String" name="interval"/>
								<parameter type="System.Int32" name="number"/>
								<parameter type="System.String" name="every"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<argumentReferenceExpression name="interval"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<comment>process numbers and number ranges</comment>
								<variableDeclarationStatement type="System.String[]" name="strings">
									<init>
										<methodInvokeExpression methodName="Split">
											<target>
												<argumentReferenceExpression name="interval"/>
											</target>
											<parameters>
												<primitiveExpression value="," convertTo="Char"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="List" name="numbers">
									<typeArguments>
										<typeReference type="System.Int32"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.Int32"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="s"/>
									<target>
										<variableReferenceExpression name="strings"/>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Contains">
													<target>
														<variableReferenceExpression name="s"/>
													</target>
													<parameters>
														<primitiveExpression value="-" convertTo="Char"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String[]" name="intervalString">
													<init>
														<methodInvokeExpression methodName="Split">
															<target>
																<variableReferenceExpression name="s"/>
															</target>
															<parameters>
																<primitiveExpression value="-" convertTo="Char"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.Int32" name="interval1">
													<init>
														<convertExpression to="Int32">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="intervalString"/>
																</target>
																<indices>
																	<primitiveExpression value="0"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.Int32" name="interval2">
													<init>
														<convertExpression to="Int32">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="intervalString"/>
																</target>
																<indices>
																	<primitiveExpression value="1"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</init>
												</variableDeclarationStatement>
												<forStatement>
													<variable type="System.Int32" name="i">
														<init>
															<variableReferenceExpression name="interval1"/>
														</init>
													</variable>
													<test>
														<binaryOperatorExpression operator="LessThanOrEqual">
															<variableReferenceExpression name="i"/>
															<variableReferenceExpression name="interval2"/>
														</binaryOperatorExpression>
													</test>
													<increment>
														<variableReferenceExpression name="i"/>
													</increment>
													<statements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="numbers"/>
															</target>
															<parameters>
																<variableReferenceExpression name="i"/>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</forStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="s"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="numbers"/>
															</target>
															<parameters>
																<convertExpression to="Int32">
																	<variableReferenceExpression name="s"/>
																</convertExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodInvokeExpression methodName="Sort">
									<target>
										<variableReferenceExpression name="numbers"/>
									</target>
								</methodInvokeExpression>
								<comment>check if "every" used</comment>
								<variableDeclarationStatement type="System.Int32" name="everyNum">
									<init>
										<primitiveExpression value="1"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="every"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="everyNum"/>
											<convertExpression to="Int32">
												<argumentReferenceExpression name="every"/>
											</convertExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<variableReferenceExpression name="everyNum"/>
											<primitiveExpression value="1"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<comment>if "every" is greater than available numbers</comment>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThanOrEqual">
													<variableReferenceExpression name="everyNum"/>
													<propertyReferenceExpression name="Count">
														<variableReferenceExpression name="numbers"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<methodInvokeExpression methodName="Equals">
														<target>
															<methodInvokeExpression methodName="First">
																<target>
																	<variableReferenceExpression name="numbers"/>
																</target>
															</methodInvokeExpression>
														</target>
														<parameters>
															<argumentReferenceExpression name="number"/>
														</parameters>
													</methodInvokeExpression>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="List" name="allNumbers">
											<typeArguments>
												<typeReference type="System.Int32"/>
											</typeArguments>
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="System.Int32"/>
													</typeArguments>
													<parameters>
														<variableReferenceExpression name="numbers"/>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="Clear">
											<target>
												<variableReferenceExpression name="numbers"/>
											</target>
										</methodInvokeExpression>
										<forStatement>
											<variable type="System.Int32" name="i">
												<init>
													<primitiveExpression value="0"/>
												</init>
											</variable>
											<test>
												<binaryOperatorExpression operator="LessThanOrEqual">
													<variableReferenceExpression name="i"/>
													<binaryOperatorExpression operator="Divide">
														<propertyReferenceExpression name="Count">
															<variableReferenceExpression name="allNumbers"/>
														</propertyReferenceExpression>
														<variableReferenceExpression name="everyNum"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</test>
											<increment>
												<variableReferenceExpression name="i"/>
											</increment>
											<statements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="numbers"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="ElementAt">
															<target>
																<variableReferenceExpression name="allNumbers"/>
															</target>
															<parameters>
																<binaryOperatorExpression operator="Multiply">
																	<variableReferenceExpression name="i"/>
																	<variableReferenceExpression name="everyNum"/>
																</binaryOperatorExpression>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</forStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Contains">
										<target>
											<variableReferenceExpression name="numbers"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="number"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CheckInterval(XPathNavigator, DateTime)-->
						<memberMethod returnType="System.Boolean" name="CheckInterval">
							<comment>Checks to see if the current node's start and end attributes are valid.</comment>
							<attributes private="true" />
							<parameters>
								<parameter type="XPathNavigator" name="nav"/>
								<parameter type="DateTime" name="checkDate"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="DateTime" name="startDate">
									<init>
										<argumentReferenceExpression name="checkDate"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="DateTime" name="endDate">
									<init>
										<argumentReferenceExpression name="checkDate"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="TryParse">
												<target>
													<typeReferenceExpression type="DateTime"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="GetAttribute">
														<target>
															<argumentReferenceExpression name="nav"/>
														</target>
														<parameters>
															<primitiveExpression value="start"/>
															<stringEmptyExpression/>
														</parameters>
													</methodInvokeExpression>
													<directionExpression direction="Out">
														<variableReferenceExpression name="startDate"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="startDate"/>
											<methodInvokeExpression methodName="StartOfDay">
												<parameters>
													<propertyReferenceExpression name="TestDate"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="TryParse">
												<target>
													<typeReferenceExpression type="DateTime"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="GetAttribute">
														<target>
															<argumentReferenceExpression name="nav"/>
														</target>
														<parameters>
															<primitiveExpression value="end"/>
															<stringEmptyExpression/>
														</parameters>
													</methodInvokeExpression>
													<directionExpression direction="Out">
														<variableReferenceExpression name="endDate"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="endDate"/>
											<propertyReferenceExpression name="MaxValue">
												<typeReferenceExpression type="DateTime"/>
											</propertyReferenceExpression>
											<!--<methodInvokeExpression methodName="EndOfDay">
                        <parameters>
                          <variableReferenceExpression name="startDate"/>
                        </parameters>
                      </methodInvokeExpression>-->
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="LessThanOrEqual">
													<variableReferenceExpression name="startDate"/>
													<argumentReferenceExpression name="checkDate"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="LessThanOrEqual">
													<argumentReferenceExpression name="checkDate"/>
													<variableReferenceExpression name="endDate"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<memberProperty type="System.Boolean" name="UsePreciseProbe">
							<attributes public="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method ProbeScheduleExact(XPathNavigator, XPathNavigator, ScheduleStatus, ScheduleStatus) -->
						<memberMethod returnType="ScheduleStatus" name="ProbeSchedule">
							<attributes private="true" />
							<parameters>
								<parameter type="XPathNavigator" name="document"/>
								<parameter type="XPathNavigator" name="exceptionsDocument"/>
								<parameter type="ScheduleStatus" name="schedule"/>
								<parameter type="ScheduleStatus" name="exceptionsSchedule"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ScheduleStatus" name="testSched">
									<init>
										<objectCreateExpression type="ScheduleStatus"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="ScheduleStatus" name="testExceptionSched">
									<init>
										<objectCreateExpression type="ScheduleStatus"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="DateTime" name="nextDate">
									<init>
										<propertyReferenceExpression name="Now">
											<typeReferenceExpression type="DateTime"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Boolean" name="initialState">
									<init>
										<propertyReferenceExpression name="Success">
											<argumentReferenceExpression name="schedule"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<forStatement>
									<variable type="System.Int32" name="probeCount">
										<init>
											<primitiveExpression value="0"/>
										</init>
									</variable>
									<test>
										<binaryOperatorExpression operator="LessThanOrEqual">
											<variableReferenceExpression name="probeCount"/>
											<primitiveExpression value="30"/>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="probeCount"/>
									</increment>
									<statements>
										<assignStatement>
											<variableReferenceExpression name="nextDate"/>
											<methodInvokeExpression methodName="AddSeconds">
												<target>
													<propertyReferenceExpression name="nextDate"/>
												</target>
												<parameters>
													<primitiveExpression value="1"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<comment>reset variables</comment>
										<assignStatement>
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="testSched"/>
											</propertyReferenceExpression>
											<primitiveExpression value="false"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Expired">
												<variableReferenceExpression name="testSched"/>
											</propertyReferenceExpression>
											<primitiveExpression value="false"/>
										</assignStatement>
										<methodInvokeExpression methodName="MoveToRoot">
											<target>
												<variableReferenceExpression name="document"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="MoveToFirstChild">
											<target>
												<variableReferenceExpression name="document"/>
											</target>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<argumentReferenceExpression name="exceptionsDocument"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="MoveToRoot">
													<target>
														<variableReferenceExpression name="exceptionsDocument"/>
													</target>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="MoveToFirstChild">
													<target>
														<variableReferenceExpression name="exceptionsDocument"/>
													</target>
												</methodInvokeExpression>
												<assignStatement>
													<propertyReferenceExpression name="Success">
														<variableReferenceExpression name="testExceptionSched"/>
													</propertyReferenceExpression>
													<primitiveExpression value="false"/>
												</assignStatement>
												<assignStatement>
													<propertyReferenceExpression name="Expired">
														<variableReferenceExpression name="testExceptionSched"/>
													</propertyReferenceExpression>
													<primitiveExpression value="false"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="System.Boolean" name="valid">
											<init>
												<binaryOperatorExpression operator="BooleanAnd">
													<methodInvokeExpression methodName="CheckNode">
														<parameters>
															<argumentReferenceExpression name="document"/>
															<variableReferenceExpression name="nextDate"/>
															<directionExpression direction="Ref">
																<variableReferenceExpression name="testSched"/>
															</directionExpression>
														</parameters>
													</methodInvokeExpression>
													<binaryOperatorExpression operator="BooleanOr">
														<binaryOperatorExpression operator="IdentityEquality">
															<argumentReferenceExpression name="exceptionsDocument"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="CheckNode">
																<parameters>
																	<argumentReferenceExpression name="exceptionsDocument"/>
																	<variableReferenceExpression name="nextDate"/>
																	<directionExpression direction="Ref">
																		<variableReferenceExpression name="testExceptionSched"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueInequality">
													<variableReferenceExpression name="valid"/>
													<variableReferenceExpression name="initialState"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<argumentReferenceExpression name="schedule"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<propertyReferenceExpression name="NextTestDate">
												<argumentReferenceExpression name="schedule"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="nextDate"/>
										</assignStatement>
									</statements>
								</forStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="schedule"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ProbeScheduleExact(XPathNavigator, XPathNavigator, ScheduleStatus, ScheduleStatus) -->
						<memberMethod returnType="ScheduleStatus" name="ProbeScheduleExact">
							<attributes private="true" />
							<parameters>
								<parameter type="XPathNavigator" name="document"/>
								<parameter type="XPathNavigator" name="exceptionsDocument"/>
								<parameter type="ScheduleStatus" name="schedule"/>
								<parameter type="ScheduleStatus" name="exceptionsSchedule"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ScheduleStatus" name="testSched">
									<init>
										<objectCreateExpression type="ScheduleStatus"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="ScheduleStatus" name="testExceptionSched">
									<init>
										<objectCreateExpression type="ScheduleStatus"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Int32" name="sign">
									<init>
										<primitiveExpression value="1"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="DateTime" name="nextDate">
									<init>
										<propertyReferenceExpression name="Now">
											<typeReferenceExpression type="DateTime"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Boolean" name="initialState">
									<init>
										<propertyReferenceExpression name="Success">
											<argumentReferenceExpression name="schedule"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Int32" name="jump">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<methodInvokeExpression methodName="Equals">
												<target>
													<propertyReferenceExpression name="Precision">
														<argumentReferenceExpression name="schedule"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<primitiveExpression value="daily"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="Equals">
												<target>
													<propertyReferenceExpression name="Precision">
														<argumentReferenceExpression name="exceptionsSchedule"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<primitiveExpression value="daily"/>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="jump"/>
											<binaryOperatorExpression operator="Multiply">
												<primitiveExpression value="6"/>
												<primitiveExpression value="60"/>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<methodInvokeExpression methodName="Equals">
														<target>
															<propertyReferenceExpression name="Precision">
																<argumentReferenceExpression name="schedule"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="weekly"/>
														</parameters>
													</methodInvokeExpression>
													<methodInvokeExpression methodName="Equals">
														<target>
															<propertyReferenceExpression name="Precision">
																<argumentReferenceExpression name="exceptionsSchedule"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="weekly"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="jump"/>
													<binaryOperatorExpression operator="Multiply">
														<primitiveExpression value="72"/>
														<primitiveExpression value="60"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanOr">
															<methodInvokeExpression methodName="Equals">
																<target>
																	<propertyReferenceExpression name="Precision">
																		<argumentReferenceExpression name="schedule"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="monthly"/>
																</parameters>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="Equals">
																<target>
																	<propertyReferenceExpression name="Precision">
																		<argumentReferenceExpression name="exceptionsSchedule"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="monthly"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="jump"/>
															<binaryOperatorExpression operator="Multiply">
																<primitiveExpression value="360"/>
																<primitiveExpression value="60"/>
															</binaryOperatorExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanOr">
																	<methodInvokeExpression methodName="Equals">
																		<target>
																			<propertyReferenceExpression name="Precision">
																				<argumentReferenceExpression name="schedule"/>
																			</propertyReferenceExpression>
																		</target>
																		<parameters>
																			<primitiveExpression value="yearly"/>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="Equals">
																		<target>
																			<propertyReferenceExpression name="Precision">
																				<argumentReferenceExpression name="exceptionsSchedule"/>
																			</propertyReferenceExpression>
																		</target>
																		<parameters>
																			<primitiveExpression value="yearly"/>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="jump"/>
																	<binaryOperatorExpression operator="Multiply">
																		<binaryOperatorExpression operator="Multiply">
																			<primitiveExpression value="720"/>
																			<primitiveExpression value="6"/>
																		</binaryOperatorExpression>
																		<primitiveExpression value="60"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<assignStatement>
																	<variableReferenceExpression name="jump"/>
																	<binaryOperatorExpression operator="Multiply">
																		<primitiveExpression value="6"/>
																		<primitiveExpression value="60"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<forStatement>
									<variable type="System.Int32" name="probeCount">
										<init>
											<primitiveExpression value="1"/>
										</init>
									</variable>
									<test>
										<binaryOperatorExpression operator="LessThanOrEqual">
											<variableReferenceExpression name="probeCount"/>
											<primitiveExpression value="20"/>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="probeCount"/>
									</increment>
									<statements>
										<comment>reset variables</comment>
										<assignStatement>
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="testSched"/>
											</propertyReferenceExpression>
											<primitiveExpression value="false"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Expired">
												<variableReferenceExpression name="testSched"/>
											</propertyReferenceExpression>
											<primitiveExpression value="false"/>
										</assignStatement>
										<methodInvokeExpression methodName="MoveToRoot">
											<target>
												<variableReferenceExpression name="document"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="MoveToFirstChild">
											<target>
												<variableReferenceExpression name="document"/>
											</target>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<argumentReferenceExpression name="exceptionsDocument"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="MoveToRoot">
													<target>
														<variableReferenceExpression name="exceptionsDocument"/>
													</target>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="MoveToFirstChild">
													<target>
														<variableReferenceExpression name="exceptionsDocument"/>
													</target>
												</methodInvokeExpression>
												<assignStatement>
													<propertyReferenceExpression name="Success">
														<variableReferenceExpression name="testExceptionSched"/>
													</propertyReferenceExpression>
													<primitiveExpression value="false"/>
												</assignStatement>
												<assignStatement>
													<propertyReferenceExpression name="Expired">
														<variableReferenceExpression name="testExceptionSched"/>
													</propertyReferenceExpression>
													<primitiveExpression value="false"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<comment>set next date to check</comment>
										<assignStatement>
											<variableReferenceExpression name="nextDate"/>
											<methodInvokeExpression methodName="AddMinutes">
												<target>
													<variableReferenceExpression name="nextDate"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Multiply">
														<variableReferenceExpression name="jump"/>
														<variableReferenceExpression name="sign"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<variableDeclarationStatement type="System.Boolean" name="valid">
											<init>
												<binaryOperatorExpression operator="BooleanAnd">
													<methodInvokeExpression methodName="CheckNode">
														<parameters>
															<argumentReferenceExpression name="document"/>
															<variableReferenceExpression name="nextDate"/>
															<directionExpression direction="Ref">
																<variableReferenceExpression name="testSched"/>
															</directionExpression>
														</parameters>
													</methodInvokeExpression>
													<binaryOperatorExpression operator="BooleanOr">
														<binaryOperatorExpression operator="IdentityEquality">
															<argumentReferenceExpression name="exceptionsDocument"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="CheckNode">
																<parameters>
																	<argumentReferenceExpression name="exceptionsDocument"/>
																	<variableReferenceExpression name="nextDate"/>
																	<directionExpression direction="Ref">
																		<variableReferenceExpression name="testExceptionSched"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="valid"/>
													<variableReferenceExpression name="initialState"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="sign"/>
													<primitiveExpression value="1"/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="sign"/>
													<primitiveExpression value="-1"/>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
										<comment>keep moving forward and expand jump if no border found, otherwise narrow jump</comment>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="sign"/>
													<primitiveExpression value="-1"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="jump"/>
													<binaryOperatorExpression operator="Divide">
														<variableReferenceExpression name="jump"/>
														<primitiveExpression value="2"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="jump"/>
													<binaryOperatorExpression operator="Multiply">
														<variableReferenceExpression name="jump"/>
														<primitiveExpression value="2"/>
													</binaryOperatorExpression>
												</assignStatement>
												<decrementStatement>
													<variableReferenceExpression name="probeCount"/>
												</decrementStatement>
											</falseStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="LessThan">
													<variableReferenceExpression name="jump"/>
													<primitiveExpression value="5"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<incrementStatement>
													<variableReferenceExpression name="jump"/>
												</incrementStatement>
											</trueStatements>
										</conditionStatement>
										<comment>no border found</comment>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<variableReferenceExpression name="nextDate"/>
													<methodInvokeExpression methodName="AddYears">
														<target>
															<propertyReferenceExpression name="Now">
																<typeReferenceExpression type="DateTime"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="5"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<breakStatement/>
											</trueStatements>
										</conditionStatement>
									</statements>
								</forStatement>
								<assignStatement>
									<propertyReferenceExpression name="NextTestDate">
										<argumentReferenceExpression name="schedule"/>
									</propertyReferenceExpression>
									<methodInvokeExpression methodName="AddMinutes">
										<target>
											<variableReferenceExpression name="nextDate"/>
										</target>
										<parameters>
											<binaryOperatorExpression operator="Multiply">
												<variableReferenceExpression name="jump"/>
												<primitiveExpression value="-1"/>
											</binaryOperatorExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="schedule"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetWeekofMonth(DateTime)-->
						<memberMethod returnType="System.Int32" name="GetWeekOfMonth">
							<attributes private="true" />
							<parameters>
								<parameter type="DateTime" name="date"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="DateTime" name="beginningOfMonth">
									<init>
										<objectCreateExpression type="DateTime">
											<parameters>
												<propertyReferenceExpression name="Year">
													<argumentReferenceExpression name="date"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="Month">
													<argumentReferenceExpression name="date"/>
												</propertyReferenceExpression>
												<primitiveExpression value="1"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<binaryOperatorExpression operator="ValueInequality">
											<propertyReferenceExpression name="DayOfWeek">
												<methodInvokeExpression methodName="AddDays">
													<target>
														<propertyReferenceExpression name="Date">
															<argumentReferenceExpression name="date"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="1"/>
													</parameters>
												</methodInvokeExpression>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="FirstDayOfWeek">
												<propertyReferenceExpression name="DateTimeFormat">
													<propertyReferenceExpression name="CurrentCulture">
														<typeReferenceExpression type="CultureInfo"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</test>
									<statements>
										<assignStatement>
											<argumentReferenceExpression name="date"/>
											<methodInvokeExpression methodName="AddDays">
												<target>
													<argumentReferenceExpression name="date"/>
												</target>
												<parameters>
													<primitiveExpression value="1"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</statements>
								</whileStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="Add">
										<castExpression targetType="System.Int32">
											<binaryOperatorExpression operator="Divide">
												<castExpression targetType="System.Double">
													<propertyReferenceExpression name="TotalDays">
														<methodInvokeExpression methodName="Subtract">
															<target>
																<argumentReferenceExpression name="date"/>
															</target>
															<parameters>
																<variableReferenceExpression name="beginningOfMonth"/>
															</parameters>
														</methodInvokeExpression>
													</propertyReferenceExpression>
												</castExpression>
												<primitiveExpression value="7"/>
											</binaryOperatorExpression>
										</castExpression>
										<primitiveExpression value="1"/>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method StartOfDay(DateTime)-->
						<memberMethod returnType="DateTime" name="StartOfDay">
							<attributes private="true" />
							<parameters>
								<parameter type="DateTime" name="date"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<objectCreateExpression type="DateTime">
										<parameters>
											<propertyReferenceExpression name="Year">
												<argumentReferenceExpression name="date"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="Month">
												<argumentReferenceExpression name="date"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="Day">
												<argumentReferenceExpression name="date"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
											<primitiveExpression value="0"/>
											<primitiveExpression value="0"/>
											<primitiveExpression value="0"/>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method EndOfDay(DateTime)-->
						<memberMethod returnType="DateTime" name="EndOfDay">
							<attributes private="true" />
							<parameters>
								<parameter type="DateTime" name="date"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<objectCreateExpression type="DateTime">
										<parameters>
											<propertyReferenceExpression name="Year">
												<argumentReferenceExpression name="date"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="Month">
												<argumentReferenceExpression name="date"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="Day">
												<argumentReferenceExpression name="date"/>
											</propertyReferenceExpression>
											<primitiveExpression value="23"/>
											<primitiveExpression value="59"/>
											<primitiveExpression value="59"/>
											<primitiveExpression value="999"/>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class AutoFillGeocode -->
				<typeDeclaration name="AutoFillGeocode" isPartial="true">
					<baseTypes>
						<typeReference type="AutoFillGeocodeBase"/>
					</baseTypes>
				</typeDeclaration>
				<!-- class AutoFillGeocodeBase -->
				<typeDeclaration name="AutoFillGeocodeBase" >
					<baseTypes>
						<typeReference type="AutoFillAddress"/>
					</baseTypes>
					<members>
						<!-- method CreateRequestUrl(BusinessRulesBase, JObject) -->
						<memberMethod returnType="System.String" name="CreateRequestUrl">
							<attributes override="true" family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="pb">
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<comment>latitude</comment>
								<variableDeclarationStatement name="lat">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="latitude"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="lat"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="pb"/>
											</target>
											<parameters>
												<variableReferenceExpression name="lat"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<comment>longitude</comment>
								<variableDeclarationStatement name="lng">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="longitude"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="lng"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="pb"/>
											</target>
											<parameters>
												<variableReferenceExpression name="lng"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<stringFormatExpression>
										<xsl:attribute name="format"><![CDATA[https://maps.googleapis.com/maps/api/geocode/json?latlng={0}&key={1}]]></xsl:attribute>
										<methodInvokeExpression methodName="UrlEncode">
											<target>
												<typeReferenceExpression type="HttpUtility"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Replace">
													<target>
														<methodInvokeExpression methodName="Join">
															<target>
																<typeReferenceExpression type="System.String"/>
															</target>
															<parameters>
																<primitiveExpression value=","/>
																<methodInvokeExpression methodName="ToArray">
																	<target>
																		<variableReferenceExpression name="pb"/>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</target>
													<parameters>
														<primitiveExpression value=" "/>
														<primitiveExpression value="+"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Settings">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.geocoding.google.key"/>
											</parameters>
										</methodInvokeExpression>
									</stringFormatExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class AutoFillAddress -->
				<typeDeclaration name="AutoFillAddress" isPartial="true">
					<baseTypes>
						<typeReference type="AutoFillAddressBase"/>
					</baseTypes>
					<members>
						<!-- constructor -->
						<typeConstructor>
							<statements>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="address1_AU"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{street_number} {route} {when /^\\d/ in subpremise then #}{subpremise}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="address1_CA"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{street_number} {route} {when /^\\d/ in subpremise then #}{subpremise}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="address1_DE"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{route}{when /./ in street_number then  }{street_number}{when /./ in subpremise then , }{when /./ in subpremise then subpremise}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="address1_GB"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{street_number} {route} {when /^\\d/ in subpremise then #}{subpremise}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="address1_US"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{street_number} {route} {when /^\d/ in subpremise then #}{subpremise}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="address1"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{route}{when /./ in street_number then , }{street_number}{when /./ in subpremise then , }{when /./ in subpremise then subpremise}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="city"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{postal_town,sublocality,neighborhood,locality}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="postalcode"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{postal_code}{when /./ in postal_code_suffix then -}{when /./ in postal_code_suffix then postal_code_suffix}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="region_ES"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{administrative_area_level_1_long,administrative_area_level_2_long}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="region_IT"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{administrative_area_level_2,administrative_area_level_1}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="region"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{administrative_area_level_1,administrative_area_level_2}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Formats"/>
										</target>
										<indices>
											<primitiveExpression value="country"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression>
										<xsl:attribute name="value"><![CDATA[{country_long}]]></xsl:attribute>
									</primitiveExpression>
								</assignStatement>
							</statements>
						</typeConstructor>
					</members>
				</typeDeclaration>
				<!-- class AutoFillAddressBase -->
				<typeDeclaration name="AutoFillAddressBase">
					<baseTypes>
						<typeReference type="AutoFill"/>
					</baseTypes>
					<members>
						<!-- field Formats -->
						<memberField type="SortedDictionary" name="Formats">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="SortedDictionary">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="System.String"/>
									</typeArguments>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- method CreateRequestUrl(BusinessRulesBase, JObject) -->
						<memberMethod returnType="System.String" name="CreateRequestUrl">
							<attributes virtual="true" family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="components">
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="pb">
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<comment>address 1</comment>
								<variableDeclarationStatement name="addr1">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="address1"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="addr1"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="pb"/>
											</target>
											<parameters>
												<variableReferenceExpression name="addr1"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<!--<comment>address 2</comment>
                <variableDeclarationStatement name="addr2">
                  <init>
                    <castExpression targetType="System.String">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="autofill"/>
                        </target>
                        <indices>
                          <primitiveExpression value="address2"/>
                        </indices>
                      </arrayIndexerExpression>
                    </castExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <variableReferenceExpression name="addr2"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="pb"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="addr2"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <comment>address 3</comment>
                <variableDeclarationStatement name="addr3">
                  <init>
                    <castExpression targetType="System.String">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="autofill"/>
                        </target>
                        <indices>
                          <primitiveExpression value="address3"/>
                        </indices>
                      </arrayIndexerExpression>
                    </castExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <variableReferenceExpression name="addr3"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="pb"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="addr3"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>-->
								<comment>city</comment>
								<variableDeclarationStatement name="city">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="city"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="city"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="pb"/>
											</target>
											<parameters>
												<variableReferenceExpression name="city"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<comment>region</comment>
								<variableDeclarationStatement name="region">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="region"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="region"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="pb"/>
											</target>
											<parameters>
												<variableReferenceExpression name="region"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<comment>postalcode</comment>
								<variableDeclarationStatement name="postalCode">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="postalcode"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="postalCode"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="postalCode"/>
											<castExpression targetType="System.String">
												<methodInvokeExpression methodName="GetValue">
													<target>
														<argumentReferenceExpression name="autofill"/>
													</target>
													<parameters>
														<primitiveExpression value="componentpostalcode"/>
														<propertyReferenceExpression name="OrdinalIgnoreCase">
															<typeReferenceExpression type="StringComparison"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</castExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="postalCode"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="components"/>
											</target>
											<parameters>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="postal_code:"/>
													<variableReferenceExpression name="postalCode"/>
												</binaryOperatorExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<comment>country</comment>
								<variableDeclarationStatement name="country">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="country"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<!--<conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <variableReferenceExpression name="country"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="country"/>
                      <propertyReferenceExpression name="TwoLetterISORegionName">
                        <objectCreateExpression type="RegionInfo">
                          <parameters>
                            <propertyReferenceExpression name="LCID">
                              <propertyReferenceExpression name="CurrentUICulture">
                                <typeReferenceExpression type="CultureInfo"/>
                              </propertyReferenceExpression>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>-->
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="country"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="Length">
															<variableReferenceExpression name="country"/>
														</propertyReferenceExpression>
														<primitiveExpression value="2"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="BooleanOr">
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="postalCode"/>
														</unaryOperatorExpression>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="region"/>
														</unaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="allCultures">
													<init>
														<methodInvokeExpression methodName="GetCultures">
															<target>
																<typeReferenceExpression type="CultureInfo"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="SpecificCultures">
																	<typeReferenceExpression type="CultureTypes"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable type="CultureInfo" name="ci"/>
													<target>
														<variableReferenceExpression name="allCultures"/>
													</target>
													<statements>
														<variableDeclarationStatement name="ri">
															<init>
																<objectCreateExpression type="RegionInfo">
																	<parameters>
																		<propertyReferenceExpression name="LCID">
																			<variableReferenceExpression name="ci"/>
																		</propertyReferenceExpression>
																	</parameters>
																</objectCreateExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanOr">
																	<methodInvokeExpression methodName="Equals">
																		<target>
																			<propertyReferenceExpression name="EnglishName">
																				<variableReferenceExpression name="ri"/>
																			</propertyReferenceExpression>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="country"/>
																			<propertyReferenceExpression name="CurrentCultureIgnoreCase">
																				<typeReferenceExpression type="StringComparison"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="Equals">
																		<target>
																			<propertyReferenceExpression name="NativeName">
																				<variableReferenceExpression name="ri"/>
																			</propertyReferenceExpression>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="country"/>
																			<propertyReferenceExpression name="CurrentCultureIgnoreCase">
																				<typeReferenceExpression type="StringComparison"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="country"/>
																	<propertyReferenceExpression name="TwoLetterISORegionName">
																		<variableReferenceExpression name="ri"/>
																	</propertyReferenceExpression>
																</assignStatement>
																<breakStatement/>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="country"/>
													</propertyReferenceExpression>
													<primitiveExpression value="2"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="components"/>
													</target>
													<parameters>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="country:"/>
															<variableReferenceExpression name="country"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="pb"/>
													</target>
													<parameters>
														<variableReferenceExpression name="country"/>
													</parameters>
												</methodInvokeExpression>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="requestUrl">
									<init>
										<stringFormatExpression>
											<xsl:attribute name="format"><![CDATA[https://maps.googleapis.com/maps/api/geocode/json?address={0}&key={1}]]></xsl:attribute>
											<methodInvokeExpression methodName="UrlEncode">
												<target>
													<typeReferenceExpression type="HttpUtility"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="Replace">
														<target>
															<methodInvokeExpression methodName="Join">
																<target>
																	<typeReferenceExpression type="System.String"/>
																</target>
																<parameters>
																	<primitiveExpression value=","/>
																	<methodInvokeExpression methodName="ToArray">
																		<target>
																			<variableReferenceExpression name="pb"/>
																		</target>
																	</methodInvokeExpression>
																</parameters>
															</methodInvokeExpression>
														</target>
														<parameters>
															<primitiveExpression value=" "/>
															<primitiveExpression value="+"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="Settings">
												<target>
													<typeReferenceExpression type="ApplicationServicesBase"/>
												</target>
												<parameters>
													<primitiveExpression value="server.geocoding.google.key"/>
												</parameters>
											</methodInvokeExpression>
										</stringFormatExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Count">
												<variableReferenceExpression name="components"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="requestUrl"/>
											<stringFormatExpression format="{{0}}&amp;components={{1}}">
												<variableReferenceExpression name="requestUrl"/>
												<methodInvokeExpression methodName="UrlEncode">
													<target>
														<typeReferenceExpression type="HttpUtility"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="Replace">
															<target>
																<methodInvokeExpression methodName="Join">
																	<target>
																		<typeReferenceExpression type="System.String"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="|"/>
																		<methodInvokeExpression methodName="ToArray">
																			<target>
																				<variableReferenceExpression name="components"/>
																			</target>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</target>
															<parameters>
																<primitiveExpression value=" "/>
																<primitiveExpression value="+"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</stringFormatExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="requestUrl"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Supports(bool) -->
						<memberMethod returnType="System.Boolean" name="Supports">
							<attributes override="true" family="true"/>
							<parameters>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="enabled">
									<init>
										<methodInvokeExpression methodName="Settings">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.geocoding.google.address"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanOr">
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="enabled"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
										<castExpression targetType="System.Boolean">
											<variableReferenceExpression name="enabled"/>
										</castExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Process(BusinessRulesBase, JObject) -->
						<memberMethod returnType="JToken" name="Process">
							<attributes override="true" family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="requestUrl">
									<init>
										<methodInvokeExpression methodName="CreateRequestUrl">
											<parameters>
												<argumentReferenceExpression name="rules"/>
												<argumentReferenceExpression name="autofill"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="outputAddressList">
									<init>
										<objectCreateExpression type="JArray"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<convertExpression to="String">
												<methodInvokeExpression methodName="Settings">
													<target>
														<typeReferenceExpression type="ApplicationServicesBase"/>
													</target>
													<parameters>
														<primitiveExpression value="server.geocoding.google.key"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<usingStatement>
											<variable name="client">
												<init>
													<objectCreateExpression type="WebClient"/>
												</init>
											</variable>
											<statements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Headers">
																<variableReferenceExpression name="client"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="Accept-Language"/>
														</indices>
													</arrayIndexerExpression>
													<methodInvokeExpression methodName="Language"/>
												</assignStatement>
												<variableDeclarationStatement name="addressJson">
													<init>
														<methodInvokeExpression methodName="Parse">
															<target>
																<typeReferenceExpression type="JObject"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="GetString">
																	<target>
																		<propertyReferenceExpression name="UTF8">
																			<typeReferenceExpression type="Encoding"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="DownloadData">
																			<target>
																				<variableReferenceExpression name="client"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="requestUrl"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="addressList">
													<init>
														<castExpression targetType="JArray">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="addressJson"/>
																</target>
																<indices>
																	<primitiveExpression value="results"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable type="JToken" name="address" var="false"/>
													<target>
														<variableReferenceExpression name="addressList"/>
													</target>
													<statements>
														<variableDeclarationStatement name="componentList">
															<init>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="address"/>
																	</target>
																	<indices>
																		<primitiveExpression value="address_components"/>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="addressComponents">
															<init>
																<objectCreateExpression type="JObject"/>
															</init>
														</variableDeclarationStatement>
														<foreachStatement>
															<variable name="component"/>
															<target>
																<variableReferenceExpression name="componentList"/>
															</target>
															<statements>
																<variableDeclarationStatement name="types">
																	<init>
																		<castExpression targetType="System.String[]">
																			<methodInvokeExpression methodName="ToObject">
																				<target>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="component"/>
																						</target>
																						<indices>
																							<primitiveExpression value="types"/>
																						</indices>
																					</arrayIndexerExpression>
																				</target>
																				<parameters>
																					<typeofExpression type="System.String[]"/>
																				</parameters>
																			</methodInvokeExpression>
																		</castExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="shortName">
																	<init>
																		<castExpression targetType="System.String">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="component"/>
																				</target>
																				<indices>
																					<primitiveExpression value="short_name"/>
																				</indices>
																			</arrayIndexerExpression>
																		</castExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="longName">
																	<init>
																		<castExpression targetType="System.String">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="component"/>
																				</target>
																				<indices>
																					<primitiveExpression value="long_name"/>
																				</indices>
																			</arrayIndexerExpression>
																		</castExpression>
																	</init>
																</variableDeclarationStatement>
																<foreachStatement>
																	<variable name="componentType"/>
																	<target>
																		<variableReferenceExpression name="types"/>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueInequality">
																					<variableReferenceExpression name="componentType"/>
																					<primitiveExpression value="political"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="addressComponents"/>
																						</target>
																						<indices>
																							<variableReferenceExpression name="componentType"/>
																						</indices>
																					</arrayIndexerExpression>
																					<variableReferenceExpression name="shortName"/>
																				</assignStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="addressComponents"/>
																						</target>
																						<indices>
																							<binaryOperatorExpression operator="Add">
																								<variableReferenceExpression name="componentType"/>
																								<primitiveExpression value="_long"/>
																							</binaryOperatorExpression>
																						</indices>
																					</arrayIndexerExpression>
																					<variableReferenceExpression name="longName"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
															</statements>
														</foreachStatement>
														<variableDeclarationStatement name="normalizedAddressComponents">
															<init>
																<objectCreateExpression type="JObject"/>
															</init>
														</variableDeclarationStatement>
														<foreachStatement>
															<variable name="p"/>
															<target>
																<variableReferenceExpression name="addressComponents"/>
															</target>
															<statements>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="normalizedAddressComponents"/>
																		</target>
																		<indices>
																			<methodInvokeExpression methodName="Replace">
																				<target>
																					<propertyReferenceExpression name="Key">
																						<variableReferenceExpression name="p"/>
																					</propertyReferenceExpression>
																				</target>
																				<parameters>
																					<primitiveExpression value="_"/>
																					<stringEmptyExpression/>
																				</parameters>
																			</methodInvokeExpression>
																		</indices>
																	</arrayIndexerExpression>
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																</assignStatement>
															</statements>
														</foreachStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="outputAddressList"/>
															</target>
															<parameters>
																<objectCreateExpression type="JObject">
																	<parameters>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="name"/>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="address"/>
																					</target>
																					<indices>
																						<primitiveExpression value="formatted_address"/>
																					</indices>
																				</arrayIndexerExpression>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="address1"/>
																				<methodInvokeExpression methodName="Format">
																					<parameters>
																						<primitiveExpression value="address1"/>
																						<variableReferenceExpression name="addressComponents"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="address2"/>
																				<methodInvokeExpression methodName="Format">
																					<parameters>
																						<primitiveExpression value="address2"/>
																						<variableReferenceExpression name="addressComponents"/>
																						<castExpression targetType="System.String">
																							<arrayIndexerExpression>
																								<target>
																									<argumentReferenceExpression name="autofill"/>
																								</target>
																								<indices>
																									<primitiveExpression value="address2"/>
																								</indices>
																							</arrayIndexerExpression>
																						</castExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="address3"/>
																				<methodInvokeExpression methodName="Format">
																					<parameters>
																						<primitiveExpression value="address3"/>
																						<variableReferenceExpression name="addressComponents"/>
																						<castExpression targetType="System.String">
																							<arrayIndexerExpression>
																								<target>
																									<argumentReferenceExpression name="autofill"/>
																								</target>
																								<indices>
																									<primitiveExpression value="address3"/>
																								</indices>
																							</arrayIndexerExpression>
																						</castExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="city"/>
																				<methodInvokeExpression methodName="Format">
																					<parameters>
																						<primitiveExpression value="city"/>
																						<variableReferenceExpression name="addressComponents"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="region"/>
																				<methodInvokeExpression methodName="Format">
																					<parameters>
																						<primitiveExpression value="region"/>
																						<variableReferenceExpression name="addressComponents"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="postalcode"/>
																				<methodInvokeExpression methodName="Format">
																					<parameters>
																						<primitiveExpression value="postalcode"/>
																						<variableReferenceExpression name="addressComponents"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="country"/>
																				<methodInvokeExpression methodName="Format">
																					<parameters>
																						<primitiveExpression value="country"/>
																						<variableReferenceExpression name="addressComponents"/>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="type"/>
																				<arrayIndexerExpression>
																					<target>
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="address"/>
																							</target>
																							<indices>
																								<primitiveExpression value="types"/>
																							</indices>
																						</arrayIndexerExpression>
																					</target>
																					<indices>
																						<primitiveExpression value="0"/>
																					</indices>
																				</arrayIndexerExpression>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="latitude"/>
																				<arrayIndexerExpression>
																					<target>
																						<arrayIndexerExpression>
																							<target>
																								<arrayIndexerExpression>
																									<target>
																										<variableReferenceExpression name="address"/>
																									</target>
																									<indices>
																										<primitiveExpression value="geometry"/>
																									</indices>
																								</arrayIndexerExpression>
																							</target>
																							<indices>
																								<primitiveExpression value="location"/>
																							</indices>
																						</arrayIndexerExpression>
																					</target>
																					<indices>
																						<primitiveExpression value="lat"/>
																					</indices>
																				</arrayIndexerExpression>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="longitude"/>
																				<arrayIndexerExpression>
																					<target>
																						<arrayIndexerExpression>
																							<target>
																								<arrayIndexerExpression>
																									<target>
																										<variableReferenceExpression name="address"/>
																									</target>
																									<indices>
																										<primitiveExpression value="geometry"/>
																									</indices>
																								</arrayIndexerExpression>
																							</target>
																							<indices>
																								<primitiveExpression value="location"/>
																							</indices>
																						</arrayIndexerExpression>
																					</target>
																					<indices>
																						<primitiveExpression value="lng"/>
																					</indices>
																				</arrayIndexerExpression>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="components"/>
																				<variableReferenceExpression name="normalizedAddressComponents"/>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="rawAddress"/>
																				<variableReferenceExpression name="address"/>
																			</parameters>
																		</objectCreateExpression>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
											</statements>
										</usingStatement>
									</trueStatements>
								</conditionStatement>
								<tryStatement>
									<statements>
										<methodInvokeExpression methodName="ConfirmResult">
											<parameters>
												<argumentReferenceExpression name="rules"/>
												<variableReferenceExpression name="outputAddressList"/>
												<argumentReferenceExpression name="autofill"/>
											</parameters>
										</methodInvokeExpression>
									</statements>
									<catch exceptionType="Exception">
										<comment>do nothing</comment>
									</catch>
								</tryStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="outputAddressList"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToComponentValue(JObject, string) -->
						<memberMethod returnType="System.String" name="ToComponentValue">
							<attributes family="true"/>
							<parameters>
								<parameter type="JObject" name="components"/>
								<parameter type="System.String" name="expression"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="m">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="expression"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[\b(\w+?)\b]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<propertyReferenceExpression name="Success">
											<variableReferenceExpression name="m"/>
										</propertyReferenceExpression>
									</test>
									<statements>
										<variableDeclarationStatement name="v">
											<init>
												<castExpression targetType="System.String">
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="components"/>
														</target>
														<indices>
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
														</indices>
													</arrayIndexerExpression>
												</castExpression>
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
												<methodReturnStatement>
													<variableReferenceExpression name="v"/>
												</methodReturnStatement>
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
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Format(string, JObject) -->
						<memberMethod returnType="System.String" name="Format">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="type"/>
								<parameter type="JObject" name="components"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Format">
										<parameters>
											<argumentReferenceExpression name="type"/>
											<argumentReferenceExpression name="components"/>
											<stringEmptyExpression/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Format(string, JObject, string) -->
						<memberMethod returnType="System.String" name="Format">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="type"/>
								<parameter type="JObject" name="components"/>
								<parameter type="System.String" name="defaultValue"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="s">
									<init>
										<stringEmptyExpression/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="country">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="components"/>
												</target>
												<indices>
													<primitiveExpression value="country"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<propertyReferenceExpression name="Formats"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Add">
														<argumentReferenceExpression name="type"/>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="_"/>
															<variableReferenceExpression name="country"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
													<directionExpression direction="Out">
														<variableReferenceExpression name="s"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="TryGetValue">
														<target>
															<propertyReferenceExpression name="Formats"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="type"/>
															<directionExpression direction="Out">
																<variableReferenceExpression name="s"/>
															</directionExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<argumentReferenceExpression name="defaultValue"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<whileStatement>
									<test>
										<primitiveExpression value="true"/>
									</test>
									<statements>
										<variableDeclarationStatement name="m">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="s"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[\{(.+?)\}]]></xsl:attribute>
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
												<variableDeclarationStatement name="name">
													<init>
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
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="v">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="ift">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="name"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[^when\s\/(?'RegEx'.+?)/\sin\s(?'Component'.+?)\s+then\s(?'Result'.+)$]]></xsl:attribute>
																</primitiveExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="Success">
															<variableReferenceExpression name="ift"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="componentValue">
															<init>
																<methodInvokeExpression methodName="ToComponentValue">
																	<parameters>
																		<variableReferenceExpression name="components"/>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="ift"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="Component"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="componentValue"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="test">
																	<init>
																		<objectCreateExpression type="Regex">
																			<parameters>
																				<propertyReferenceExpression name="Value">
																					<arrayIndexerExpression>
																						<target>
																							<propertyReferenceExpression name="Groups">
																								<variableReferenceExpression name="ift"/>
																							</propertyReferenceExpression>
																						</target>
																						<indices>
																							<primitiveExpression value="RegEx"/>
																						</indices>
																					</arrayIndexerExpression>
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
																				<variableReferenceExpression name="test"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="componentValue"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="v"/>
																			<methodInvokeExpression methodName="ToComponentValue">
																				<parameters>
																					<argumentReferenceExpression name="components"/>
																					<propertyReferenceExpression name="Value">
																						<arrayIndexerExpression>
																							<target>
																								<propertyReferenceExpression name="Groups">
																									<variableReferenceExpression name="ift"/>
																								</propertyReferenceExpression>
																							</target>
																							<indices>
																								<primitiveExpression value="Result"/>
																							</indices>
																						</arrayIndexerExpression>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityEquality">
																					<variableReferenceExpression name="v"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="v"/>
																					<propertyReferenceExpression name="Value">
																						<arrayIndexerExpression>
																							<target>
																								<propertyReferenceExpression name="Groups">
																									<variableReferenceExpression name="ift"/>
																								</propertyReferenceExpression>
																							</target>
																							<indices>
																								<primitiveExpression value="Result"/>
																							</indices>
																						</arrayIndexerExpression>
																					</propertyReferenceExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<assignStatement>
															<variableReferenceExpression name="v"/>
															<methodInvokeExpression methodName="ToComponentValue">
																<parameters>
																	<argumentReferenceExpression name="components"/>
																	<variableReferenceExpression name="name"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="v"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="v"/>
															<stringEmptyExpression/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<assignStatement>
													<variableReferenceExpression name="s"/>
													<binaryOperatorExpression operator="Add">
														<methodInvokeExpression methodName="Substring">
															<target>
																<variableReferenceExpression name="s"/>
															</target>
															<parameters>
																<primitiveExpression value="0"/>
																<propertyReferenceExpression name="Index">
																	<variableReferenceExpression name="m"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="v"/>
															<methodInvokeExpression methodName="Substring">
																<target>
																	<variableReferenceExpression name="s"/>
																</target>
																<parameters>
																	<binaryOperatorExpression operator="Add">
																		<propertyReferenceExpression name="Index">
																			<variableReferenceExpression name="m"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Length">
																			<variableReferenceExpression name="m"/>
																		</propertyReferenceExpression>
																	</binaryOperatorExpression>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<breakStatement/>
											</falseStatements>
										</conditionStatement>
									</statements>
								</whileStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Trim">
										<target>
											<variableReferenceExpression name="s"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ConfirmResult(BusinessRulesBase rules, string, JArray) -->
						<memberMethod name="ConfirmResult">
							<attributes family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JArray" name="addresses"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<comment>confirm with USPS</comment>
								<variableDeclarationStatement name="userName">
									<init>
										<castExpression targetType="System.String">
											<methodInvokeExpression methodName="Settings">
												<target>
													<typeReferenceExpression type="ApplicationServicesBase"/>
												</target>
												<parameters>
													<primitiveExpression value="server.geocoding.usps.userName"/>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="userName"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="removeIfNoMatch">
											<init>
												<primitiveExpression value="false"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Count">
														<argumentReferenceExpression name="addresses"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="removeIfNoMatch"/>
													<primitiveExpression value="true"/>
												</assignStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="autofill"/>
														</target>
														<indices>
															<primitiveExpression value="state"/>
														</indices>
													</arrayIndexerExpression>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="autofill"/>
														</target>
														<indices>
															<primitiveExpression value="region"/>
														</indices>
													</arrayIndexerExpression>
												</assignStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="autofill"/>
														</target>
														<indices>
															<primitiveExpression value="components"/>
														</indices>
													</arrayIndexerExpression>
													<objectCreateExpression type="JObject">
														<parameters>
															<objectCreateExpression type="JProperty">
																<parameters>
																	<primitiveExpression value="country"/>
																	<primitiveExpression value="US"/>
																</parameters>
															</objectCreateExpression>
														</parameters>
													</objectCreateExpression>
												</assignStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<argumentReferenceExpression name="addresses"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="autofill"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<foreachStatement>
											<variable type="JToken" name="address" var="false"/>
											<target>
												<argumentReferenceExpression name="addresses"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<castExpression targetType="System.String">
																<arrayIndexerExpression>
																	<target>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="address"/>
																			</target>
																			<indices>
																				<primitiveExpression value="components"/>
																			</indices>
																		</arrayIndexerExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="country"/>
																	</indices>
																</arrayIndexerExpression>
															</castExpression>
															<primitiveExpression value="US"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<comment>try enhancing address by verifying it with USPS</comment>
														<variableDeclarationStatement name="address1">
															<init>
																<castExpression targetType="System.String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="address"/>
																		</target>
																		<indices>
																			<primitiveExpression value="address1"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="canSearch">
															<init>
																<binaryOperatorExpression operator="BooleanOr">
																	<unaryOperatorExpression operator="Not">
																		<binaryOperatorExpression operator="BooleanOr">
																			<unaryOperatorExpression operator="IsNullOrEmpty">
																				<convertExpression to="String">
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="address"/>
																						</target>
																						<indices>
																							<primitiveExpression value="state"/>
																						</indices>
																					</arrayIndexerExpression>
																				</convertExpression>
																			</unaryOperatorExpression>
																			<unaryOperatorExpression operator="IsNullOrEmpty">
																				<convertExpression to="String">
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="address"/>
																						</target>
																						<indices>
																							<primitiveExpression value="city"/>
																						</indices>
																					</arrayIndexerExpression>
																				</convertExpression>
																			</unaryOperatorExpression>
																		</binaryOperatorExpression>
																	</unaryOperatorExpression>
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<convertExpression to="String">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="address"/>
																				</target>
																				<indices>
																					<primitiveExpression value="postalcode"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</unaryOperatorExpression>
																</binaryOperatorExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<variableReferenceExpression name="address1"/>
																	</unaryOperatorExpression>
																	<variableReferenceExpression name="canSearch"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="uspsRequest">
																	<init>
																		<objectCreateExpression type="StringBuilder"/>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="settings">
																	<init>
																		<objectCreateExpression type="XmlWriterSettings"/>
																	</init>
																</variableDeclarationStatement>
																<assignStatement>
																	<propertyReferenceExpression name="OmitXmlDeclaration">
																		<variableReferenceExpression name="settings"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="true"/>
																</assignStatement>
																<variableDeclarationStatement name="writer">
																	<init>
																		<methodInvokeExpression methodName="Create">
																			<target>
																				<typeReferenceExpression type="XmlWriter"/>
																			</target>
																			<parameters>
																				<objectCreateExpression type="StringWriter">
																					<parameters>
																						<variableReferenceExpression name="uspsRequest"/>
																					</parameters>
																				</objectCreateExpression>
																				<variableReferenceExpression name="settings"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<methodInvokeExpression methodName="WriteStartElement">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="AddressValidateRequest"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteAttributeString">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="USERID"/>
																		<variableReferenceExpression name="userName"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteElementString">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="Revision"/>
																		<primitiveExpression value="1" convertTo="String"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteStartElement">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="Address"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteAttributeString">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="ID"/>
																		<primitiveExpression value="0" convertTo="String"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteElementString">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="Address1"/>
																		<convertExpression to="String">
																			<arrayIndexerExpression>
																				<target>
																					<argumentReferenceExpression name="address"/>
																				</target>
																				<indices>
																					<primitiveExpression value="address2"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteElementString">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="Address2"/>
																		<variableReferenceExpression name="address1"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteElementString">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="City"/>
																		<convertExpression to="String">
																			<arrayIndexerExpression>
																				<target>
																					<argumentReferenceExpression name="address"/>
																				</target>
																				<indices>
																					<primitiveExpression value="city"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteElementString">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="State"/>
																		<convertExpression to="String">
																			<arrayIndexerExpression>
																				<target>
																					<argumentReferenceExpression name="address"/>
																				</target>
																				<indices>
																					<primitiveExpression value="state"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteElementString">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="Zip5"/>
																		<convertExpression to="String">
																			<arrayIndexerExpression>
																				<target>
																					<argumentReferenceExpression name="address"/>
																				</target>
																				<indices>
																					<primitiveExpression value="postalcode"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteStartElement">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="Zip4"/>
																	</parameters>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteEndElement">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteEndElement">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="WriteEndElement">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="Close">
																	<target>
																		<variableReferenceExpression name="writer"/>
																	</target>
																</methodInvokeExpression>
																<usingStatement>
																	<variable name="client">
																		<init>
																			<objectCreateExpression type="WebClient"/>
																		</init>
																	</variable>
																	<statements>
																		<variableDeclarationStatement name="uspsResponseText">
																			<init>
																				<methodInvokeExpression methodName="DownloadString">
																					<target>
																						<variableReferenceExpression name="client"/>
																					</target>
																					<parameters>
																						<binaryOperatorExpression operator="Add">
																							<primitiveExpression>
																								<xsl:attribute name="value"><![CDATA[https://secure.shippingapis.com/ShippingAPI.dll?API=Verify&XML=]]></xsl:attribute>
																							</primitiveExpression>
																							<methodInvokeExpression methodName="UrlEncode">
																								<target>
																									<typeReferenceExpression type="HttpUtility"/>
																								</target>
																								<parameters>
																									<methodInvokeExpression methodName="ToString">
																										<target>
																											<variableReferenceExpression name="uspsRequest"/>
																										</target>
																									</methodInvokeExpression>
																								</parameters>
																							</methodInvokeExpression>
																						</binaryOperatorExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<variableDeclarationStatement name="uspsResponse">
																			<init>
																				<methodInvokeExpression methodName="SelectSingleNode">
																					<target>
																						<methodInvokeExpression methodName="CreateNavigator">
																							<target>
																								<objectCreateExpression type="XPathDocument">
																									<parameters>
																										<objectCreateExpression type="StringReader">
																											<parameters>
																												<variableReferenceExpression name="uspsResponseText"/>
																											</parameters>
																										</objectCreateExpression>
																									</parameters>
																								</objectCreateExpression>
																							</target>
																						</methodInvokeExpression>
																					</target>
																					<parameters>
																						<primitiveExpression value="/AddressValidateResponse/Address"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanAnd">
																					<binaryOperatorExpression operator="IdentityInequality">
																						<variableReferenceExpression name="uspsResponse"/>
																						<primitiveExpression value="null"/>
																					</binaryOperatorExpression>
																					<binaryOperatorExpression operator="IdentityEquality">
																						<methodInvokeExpression methodName="SelectSingleNode">
																							<target>
																								<variableReferenceExpression name="uspsResponse"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="Error"/>
																							</parameters>
																						</methodInvokeExpression>
																						<primitiveExpression value="null"/>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="address"/>
																						</target>
																						<indices>
																							<primitiveExpression value="address1"/>
																						</indices>
																					</arrayIndexerExpression>
																					<propertyReferenceExpression name="Value">
																						<methodInvokeExpression methodName="SelectSingleNode">
																							<target>
																								<variableReferenceExpression name="uspsResponse"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="Address2"/>
																							</parameters>
																						</methodInvokeExpression>
																					</propertyReferenceExpression>
																				</assignStatement>
																				<variableDeclarationStatement name="validatedAddress1">
																					<init>
																						<methodInvokeExpression methodName="SelectSingleNode">
																							<target>
																								<variableReferenceExpression name="uspsResponse"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="Address1"/>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="IdentityInequality">
																							<variableReferenceExpression name="validatedAddress1"/>
																							<primitiveExpression value="null"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="address"/>
																								</target>
																								<indices>
																									<primitiveExpression value="address2"/>
																								</indices>
																							</arrayIndexerExpression>
																							<propertyReferenceExpression name="Value">
																								<variableReferenceExpression name="validatedAddress1"/>
																							</propertyReferenceExpression>
																						</assignStatement>
																					</trueStatements>
																					<falseStatements>
																						<assignStatement>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="address"/>
																								</target>
																								<indices>
																									<primitiveExpression value="address2"/>
																								</indices>
																							</arrayIndexerExpression>
																							<primitiveExpression value="null"/>
																						</assignStatement>
																					</falseStatements>
																				</conditionStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="address"/>
																						</target>
																						<indices>
																							<primitiveExpression value="city"/>
																						</indices>
																					</arrayIndexerExpression>
																					<propertyReferenceExpression name="Value">
																						<methodInvokeExpression methodName="SelectSingleNode">
																							<target>
																								<variableReferenceExpression name="uspsResponse"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="City"/>
																							</parameters>
																						</methodInvokeExpression>
																					</propertyReferenceExpression>
																				</assignStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="address"/>
																						</target>
																						<indices>
																							<primitiveExpression value="region"/>
																						</indices>
																					</arrayIndexerExpression>
																					<propertyReferenceExpression name="Value">
																						<methodInvokeExpression methodName="SelectSingleNode">
																							<target>
																								<variableReferenceExpression name="uspsResponse"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="State"/>
																							</parameters>
																						</methodInvokeExpression>
																					</propertyReferenceExpression>
																				</assignStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="address"/>
																						</target>
																						<indices>
																							<primitiveExpression value="postalcode"/>
																						</indices>
																					</arrayIndexerExpression>
																					<stringFormatExpression format="{{0}}-{{1}}">
																						<propertyReferenceExpression name="Value">
																							<methodInvokeExpression methodName="SelectSingleNode">
																								<target>
																									<variableReferenceExpression name="uspsResponse"/>
																								</target>
																								<parameters>
																									<primitiveExpression value="Zip5"/>
																								</parameters>
																							</methodInvokeExpression>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="Value">
																							<methodInvokeExpression methodName="SelectSingleNode">
																								<target>
																									<variableReferenceExpression name="uspsResponse"/>
																								</target>
																								<parameters>
																									<primitiveExpression value="Zip4"/>
																								</parameters>
																							</methodInvokeExpression>
																						</propertyReferenceExpression>
																					</stringFormatExpression>
																				</assignStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="address"/>
																								</target>
																								<indices>
																									<primitiveExpression value="components"/>
																								</indices>
																							</arrayIndexerExpression>
																						</target>
																						<indices>
																							<primitiveExpression value="postalcode"/>
																						</indices>
																					</arrayIndexerExpression>
																					<propertyReferenceExpression name="Value">
																						<methodInvokeExpression methodName="SelectSingleNode">
																							<target>
																								<variableReferenceExpression name="uspsResponse"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="Zip5"/>
																							</parameters>
																						</methodInvokeExpression>
																					</propertyReferenceExpression>
																				</assignStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="address"/>
																								</target>
																								<indices>
																									<primitiveExpression value="components"/>
																								</indices>
																							</arrayIndexerExpression>
																						</target>
																						<indices>
																							<primitiveExpression value="postalcodesuffix"/>
																						</indices>
																					</arrayIndexerExpression>
																					<propertyReferenceExpression name="Value">
																						<methodInvokeExpression methodName="SelectSingleNode">
																							<target>
																								<variableReferenceExpression name="uspsResponse"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="Zip4"/>
																							</parameters>
																						</methodInvokeExpression>
																					</propertyReferenceExpression>
																				</assignStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="address"/>
																						</target>
																						<indices>
																							<primitiveExpression value="country"/>
																						</indices>
																					</arrayIndexerExpression>
																					<methodInvokeExpression methodName="ToUpper">
																						<target>
																							<convertExpression to="String">
																								<arrayIndexerExpression>
																									<target>
																										<argumentReferenceExpression name="address"/>
																									</target>
																									<indices>
																										<primitiveExpression value="country"/>
																									</indices>
																								</arrayIndexerExpression>
																							</convertExpression>
																						</target>
																					</methodInvokeExpression>
																				</assignStatement>
																				<variableDeclarationStatement name="address2">
																					<init>
																						<convertExpression to="String">
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="address"/>
																								</target>
																								<indices>
																									<primitiveExpression value="address2"/>
																								</indices>
																							</arrayIndexerExpression>
																						</convertExpression>/init>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="GreaterThan">
																							<propertyReferenceExpression name="Length">
																								<variableReferenceExpression name="address2"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="0"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="address2"/>
																							<binaryOperatorExpression operator="Add">
																								<primitiveExpression value=" "/>
																								<variableReferenceExpression name="address2"/>
																							</binaryOperatorExpression>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="address"/>
																						</target>
																						<indices>
																							<primitiveExpression value="name"/>
																						</indices>
																					</arrayIndexerExpression>
																					<stringFormatExpression>
																						<xsl:attribute name="format"><![CDATA[{0}{1}, {2}, {3} {4}]]></xsl:attribute>
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="address"/>
																							</target>
																							<indices>
																								<primitiveExpression value="address1"/>
																							</indices>
																						</arrayIndexerExpression>
																						<variableReferenceExpression name="address2"/>
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="address"/>
																							</target>
																							<indices>
																								<primitiveExpression value="city"/>
																							</indices>
																						</arrayIndexerExpression>
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="address"/>
																							</target>
																							<indices>
																								<primitiveExpression value="region"/>
																							</indices>
																						</arrayIndexerExpression>
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="address"/>
																							</target>
																							<indices>
																								<primitiveExpression value="postalcode"/>
																							</indices>
																						</arrayIndexerExpression>
																					</stringFormatExpression>
																				</assignStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="address"/>
																						</target>
																						<indices>
																							<primitiveExpression value="country"/>
																						</indices>
																					</arrayIndexerExpression>
																					<primitiveExpression value="USA"/>
																				</assignStatement>
																				<assignStatement>
																					<variableReferenceExpression name="removeIfNoMatch"/>
																					<primitiveExpression value="false"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</usingStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<conditionStatement>
											<condition>
												<variableReferenceExpression name="removeIfNoMatch"/>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Clear">
													<target>
														<argumentReferenceExpression name="addresses"/>
													</target>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class AutoFill -->
				<typeDeclaration name="AutoFill">
					<members>
						<!-- field Handlers -->
						<memberField type="SortedDictionary" name="Handlers">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="AutoFill"/>
							</typeArguments>
							<attributes static="true" public="true"/>
							<init>
								<objectCreateExpression type="SortedDictionary">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="AutoFill"/>
									</typeArguments>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- static constructor -->
						<typeConstructor>
							<attributes public="true" />
							<statements>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Handlers"/>
										</target>
										<indices>
											<primitiveExpression value="address"/>
										</indices>
									</arrayIndexerExpression>
									<objectCreateExpression type="AutoFillAddress"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Handlers"/>
										</target>
										<indices>
											<primitiveExpression value="geocode"/>
										</indices>
									</arrayIndexerExpression>
									<objectCreateExpression type="AutoFillGeocode"/>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Handlers"/>
										</target>
										<indices>
											<primitiveExpression value="map"/>
										</indices>
									</arrayIndexerExpression>
									<objectCreateExpression type="AutoFillMap"/>
								</assignStatement>
							</statements>
						</typeConstructor>
						<!-- method Evaluate(BusinessRulesBase) -->
						<memberMethod name="Evaluate">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="args">
									<init>
										<propertyReferenceExpression name="Arguments">
											<argumentReferenceExpression name="rules"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="CommandName">
													<variableReferenceExpression name="args"/>
												</propertyReferenceExpression>
												<primitiveExpression value="AutoFill"/>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<propertyReferenceExpression name="View">
													<variableReferenceExpression name="rules"/>
												</propertyReferenceExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="autofill">
											<init>
												<methodInvokeExpression methodName="Parse">
													<target>
														<typeReferenceExpression type="JObject"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Trigger">
															<variableReferenceExpression name="args"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="AutoFill" name="handler">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<methodInvokeExpression methodName="TryGetValue">
														<target>
															<propertyReferenceExpression name="Handlers"/>
														</target>
														<parameters>
															<castExpression targetType="System.String">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="autofill"/>
																	</target>
																	<indices>
																		<primitiveExpression value="autofill"/>
																	</indices>
																</arrayIndexerExpression>
															</castExpression>
															<directionExpression direction="Out">
																<variableReferenceExpression name="handler"/>
															</directionExpression>
														</parameters>
													</methodInvokeExpression>
													<methodInvokeExpression methodName="Supports">
														<target>
															<variableReferenceExpression name="handler"/>
														</target>
														<parameters>
															<variableReferenceExpression name="autofill"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="result">
													<init>
														<methodInvokeExpression methodName="Process">
															<target>
																<variableReferenceExpression name="handler"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="rules"/>
																<argumentReferenceExpression name="autofill"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<propertyReferenceExpression name="Values">
															<propertyReferenceExpression name="Result">
																<argumentReferenceExpression name="rules"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<objectCreateExpression type="FieldValue">
															<parameters>
																<primitiveExpression value="AutoFill"/>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<variableReferenceExpression name="result"/>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method Process(BusinessRulesBase rules, Object) -->
						<memberMethod returnType="JToken" name="Process">
							<attributes family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autoFill"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Supports(bool) -->
						<memberMethod returnType="System.Boolean" name="Supports">
							<attributes family="true"/>
							<parameters>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Language() -->
						<memberMethod returnType="System.String" name="Language">
							<attributes family="true"/>
							<statements>
								<methodReturnStatement>
									<propertyReferenceExpression name="Name">
										<propertyReferenceExpression name="CurrentUICulture">
											<typeReferenceExpression type="CultureInfo"/>
										</propertyReferenceExpression>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class AutoFillMap -->
				<typeDeclaration name="AutoFillMap" isPartial="true">
					<attributes public ="true"/>
					<baseTypes>
						<typeReference type="AutoFillMapBase"/>
					</baseTypes>
				</typeDeclaration>
				<!-- class AutoFillMap -->
				<typeDeclaration name="AutoFillMapBase">
					<attributes public ="true"/>
					<baseTypes>
						<typeReference type="AutoFill"/>
					</baseTypes>
					<members>
						<!-- method ToSize(BusinessRulesBase, JObject) -->
						<memberMethod returnType="System.String" name="ToSize">
							<attributes family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="width">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<methodInvokeExpression methodName="Property">
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<parameters>
													<primitiveExpression value="width"/>
												</parameters>
											</methodInvokeExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="width"/>
											<castExpression targetType="System.Int32">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="autofill"/>
													</target>
													<indices>
														<primitiveExpression value="width"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="width"/>
											<primitiveExpression value="180"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="width"/>
											<primitiveExpression value="180"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="height">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<methodInvokeExpression methodName="Property">
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<parameters>
													<primitiveExpression value="height"/>
												</parameters>
											</methodInvokeExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="height"/>
											<castExpression targetType="System.Int32">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="autofill"/>
													</target>
													<indices>
														<primitiveExpression value="height"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="height"/>
											<primitiveExpression value="180"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="height"/>
											<primitiveExpression value="180"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<stringFormatExpression format="{{0}}x{{1}}">
										<variableReferenceExpression name="width"/>
										<variableReferenceExpression name="height"/>
									</stringFormatExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToSize(BusinessRulesBase, JObject) -->
						<memberMethod returnType="System.String" name="ToMapType">
							<attributes family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="mapType">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="mapType"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="mapType"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="mapType"/>
											<primitiveExpression value="roadmap"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="mapType"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToScale(BusinessRulesBase, JObject) -->
						<memberMethod returnType="System.String" name="ToScale">
							<attributes family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="scale">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="scale"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="scale"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="scale"/>
											<primitiveExpression value="1" convertTo="String"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="scale"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToZoom(BusinessRulesBase, JObject) -->
						<memberMethod returnType="System.String" name="ToZoom">
							<attributes family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="zoom">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="zoom"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="zoom"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="zoom"/>
											<primitiveExpression value="16" convertTo="String"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="zoom"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToMarkerSize(BusinessRulesBase, JObject) -->
						<memberMethod returnType="System.String" name="ToMarkerSize">
							<attributes family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="size">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="markerSize"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="size"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="size"/>
											<primitiveExpression value="mid"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="size"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToMarkerColor(BusinessRulesBase, JObject) -->
						<memberMethod returnType="System.String" name="ToMarkerColor">
							<attributes family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="color">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="markerColor"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="color"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="color"/>
											<primitiveExpression value="red"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="color"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToMarkerList(BusinessRulesBase, JObject) -->
						<memberMethod returnType="System.String" name="ToMarkerList">
							<attributes family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<comment>try lat &amp; lng</comment>
								<variableDeclarationStatement name="lat">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="latitude"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="lng">
									<init>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="autofill"/>
												</target>
												<indices>
													<primitiveExpression value="longitude"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="lat"/>
											</unaryOperatorExpression>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="lng"/>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<stringFormatExpression format="{{0}},{{1}}">
												<variableReferenceExpression name="lat"/>
												<variableReferenceExpression name="lng"/>
											</stringFormatExpression>
										</methodReturnStatement>
									</trueStatements>
									<falseStatements>
										<variableDeclarationStatement name="mb">
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="System.String"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<comment>address 1</comment>
										<variableDeclarationStatement name="addr1">
											<init>
												<castExpression targetType="System.String">
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="autofill"/>
														</target>
														<indices>
															<primitiveExpression value="address1"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="addr1"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="mb"/>
													</target>
													<parameters>
														<variableReferenceExpression name="addr1"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<comment>city</comment>
										<variableDeclarationStatement name="city">
											<init>
												<castExpression targetType="System.String">
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="autofill"/>
														</target>
														<indices>
															<primitiveExpression value="city"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="city"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="mb"/>
													</target>
													<parameters>
														<variableReferenceExpression name="city"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<comment>region</comment>
										<variableDeclarationStatement name="region">
											<init>
												<castExpression targetType="System.String">
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="autofill"/>
														</target>
														<indices>
															<primitiveExpression value="region"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="region"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="mb"/>
													</target>
													<parameters>
														<variableReferenceExpression name="region"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<comment>postalcode</comment>
										<variableDeclarationStatement name="postalCode">
											<init>
												<castExpression targetType="System.String">
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="autofill"/>
														</target>
														<indices>
															<primitiveExpression value="postalcode"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="postalCode"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="postalCode"/>
													<castExpression targetType="System.String">
														<methodInvokeExpression methodName="GetValue">
															<target>
																<argumentReferenceExpression name="autofill"/>
															</target>
															<parameters>
																<primitiveExpression value="componentpostalcode"/>
																<propertyReferenceExpression name="OrdinalIgnoreCase">
																	<typeReferenceExpression type="StringComparison"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</castExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="postalCode"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="mb"/>
													</target>
													<parameters>
														<variableReferenceExpression name="postalCode"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<comment>country</comment>
										<variableDeclarationStatement name="country">
											<init>
												<castExpression targetType="System.String">
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="autofill"/>
														</target>
														<indices>
															<primitiveExpression value="country"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="country"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="mb"/>
													</target>
													<parameters>
														<variableReferenceExpression name="country"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<methodInvokeExpression methodName="Replace">
												<target>
													<methodInvokeExpression methodName="Join">
														<target>
															<typeReferenceExpression type="System.String"/>
														</target>
														<parameters>
															<primitiveExpression value=","/>
															<methodInvokeExpression methodName="ToArray">
																<target>
																	<variableReferenceExpression name="mb"/>
																</target>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</target>
												<parameters>
													<primitiveExpression value=" "/>
													<primitiveExpression value="+"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ToMarkers(BusinessRulesBase, JObject) -->
						<memberMethod returnType="System.String" name="ToMarkers">
							<attributes family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<comment>size:mid|color:red|San Francisco,CA|Oakland,CA|San Jose,CA</comment>
								<methodReturnStatement>
									<methodInvokeExpression methodName="UrlEncode">
										<target>
											<typeReferenceExpression type="HttpUtility"/>
										</target>
										<parameters>
											<stringFormatExpression format="size:{{0}}|color:{{1}}|{{2}}">
												<methodInvokeExpression methodName="ToMarkerSize">
													<parameters>
														<argumentReferenceExpression name="rules"/>
														<argumentReferenceExpression name="autofill"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="ToMarkerColor">
													<parameters>
														<argumentReferenceExpression name="rules"/>
														<argumentReferenceExpression name="autofill"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="ToMarkerList">
													<parameters>
														<argumentReferenceExpression name="rules"/>
														<argumentReferenceExpression name="autofill"/>
													</parameters>
												</methodInvokeExpression>
											</stringFormatExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateRequestUrl(BusinessRulesBase, JObject) -->
						<memberMethod returnType="System.String" name="CreateRequestUrl">
							<attributes family="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<comment><![CDATA[size=512x512&maptype=roadma&markers=size:mid|color:red|San Francisco,CA|Oakland,CA|San Jose,CA&key=737dk343kjfld83lkjfdlk]]></comment>
								<methodReturnStatement>
									<stringFormatExpression>
										<xsl:attribute name="format"><![CDATA[https://maps.googleapis.com/maps/api/staticmap?size={0}&scale={1}&maptype={2}&zoom={3}&markers={4}&key={5}]]></xsl:attribute>
										<methodInvokeExpression methodName="ToSize">
											<parameters>
												<argumentReferenceExpression name="rules"/>
												<argumentReferenceExpression name="autofill"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="ToScale">
											<parameters>
												<argumentReferenceExpression name="rules"/>
												<argumentReferenceExpression name="autofill"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="ToMapType">
											<parameters>
												<argumentReferenceExpression name="rules"/>
												<argumentReferenceExpression name="autofill"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="ToZoom">
											<parameters>
												<argumentReferenceExpression name="rules"/>
												<argumentReferenceExpression name="autofill"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="ToMarkers">
											<parameters>
												<argumentReferenceExpression name="rules"/>
												<argumentReferenceExpression name="autofill"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Settings">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.geocoding.google.key"/>
											</parameters>
										</methodInvokeExpression>
									</stringFormatExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Supports(bool) -->
						<memberMethod returnType="System.Boolean" name="Supports">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="enabled">
									<init>
										<methodInvokeExpression methodName="Settings">
											<target>
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</target>
											<parameters>
												<primitiveExpression value="server.geocoding.google.map"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanOr">
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="enabled"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
										<castExpression targetType="System.Boolean">
											<variableReferenceExpression name="enabled"/>
										</castExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method Process(BusinessRules, JObject)-->
						<memberMethod returnType="JToken" name="Process">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="BusinessRulesBase" name="rules"/>
								<parameter type="JObject" name="autofill"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="requestUrl">
									<init>
										<methodInvokeExpression methodName="CreateRequestUrl">
											<parameters>
												<argumentReferenceExpression name="rules"/>
												<argumentReferenceExpression name="autofill"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="result">
									<init>
										<objectCreateExpression type="JObject"/>
									</init>
								</variableDeclarationStatement>
								<usingStatement>
									<variable name="client">
										<init>
											<objectCreateExpression type="WebClient"/>
										</init>
									</variable>
									<statements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Headers">
														<variableReferenceExpression name="client"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="Accept-Language"/>
												</indices>
											</arrayIndexerExpression>
											<methodInvokeExpression methodName="Language"/>
										</assignStatement>
										<variableDeclarationStatement name="data">
											<init>
												<methodInvokeExpression methodName="ToBase64String">
													<target>
														<typeReferenceExpression type="Convert"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="DownloadData">
															<target>
																<variableReferenceExpression name="client"/>
															</target>
															<parameters>
																<variableReferenceExpression name="requestUrl"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="contentType">
											<init>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="ResponseHeaders">
															<variableReferenceExpression name="client"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<propertyReferenceExpression name="ContentType">
															<typeReferenceExpression type="HttpResponseHeader"/>
														</propertyReferenceExpression>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="StartsWith">
													<target>
														<variableReferenceExpression name="contentType"/>
													</target>
													<parameters>
														<primitiveExpression value="image"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="result"/>
														</target>
														<indices>
															<primitiveExpression value="image"/>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="data"/>
												</assignStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="result"/>
														</target>
														<indices>
															<primitiveExpression value="contentType"/>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="contentType"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</usingStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
