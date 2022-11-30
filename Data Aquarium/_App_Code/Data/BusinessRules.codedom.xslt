<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ontime="urn:codeontime-com"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a ontime"
>
	<xsl:output method="xml" indent="yes"/>

	<xsl:param name="Namespace" select="a:project/a:namespace"/>
	<xsl:param name="IsPremium"/>
	<xsl:param name="IsUnlimited"/>
	<xsl:param name="Host"/>
	<xsl:param name="UrlHashing"/>
	<xsl:variable name="HostPath" select="a:project/a:host/@path"/>
	<xsl:variable name="PageImplementation" select="a:project/@pageImplementation"/>

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Data">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Configuration"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Data.Common"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Net"/>
				<namespaceImport name="System.Net.Mail"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Threading"/>
				<namespaceImport name="System.Reflection"/>
				<namespaceImport name="System.Xml"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Caching"/>
				<xsl:if test="$HostPath=''">
					<namespaceImport name="System.Web.Security"/>
				</xsl:if>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
				<namespaceImport name="{$Namespace}.Handlers"/>
				<namespaceImport name="{$Namespace}.Services"/>
				<namespaceImport name="{$Namespace}.Web"/>
			</imports>
			<types>
				<!-- enum ActionPhase -->
				<typeDeclaration name="ActionPhase" isEnum="true">
					<members>
						<memberField name="Execute">
							<attributes public="true"/>
						</memberField>
						<memberField name="Before">
							<attributes public="true"/>
						</memberField>
						<memberField name="After">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- class OverrideWhenAttribute -->
				<typeDeclaration name="OverrideWhenAttribute">
					<attributes public="true"/>
					<customAttributes>
						<customAttribute name="AttributeUsage">
							<arguments>
								<propertyReferenceExpression name="Property">
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
						<!-- property Controller -->
						<memberProperty type="System.String" name="Controller">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property View  -->
						<memberProperty type="System.String" name="View">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property View  -->
						<memberProperty type="System.String" name="VirtualView">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- constructor OverrideWhenAttribute(string, string, string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="virtualView"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="controller"/>
									<argumentReferenceExpression name="controller"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="view"/>
									<argumentReferenceExpression name="view"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="virtualView"/>
									<argumentReferenceExpression name="virtualView"/>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>
				<!-- class ControllerActionAttribute -->
				<typeDeclaration name="ControllerActionAttribute">
					<comment>
						<![CDATA[
    /// <summary>
    /// Specifies the data controller, view, action command name, and other parameters that will cause execution of the method.
    /// Method arguments will have a value if the argument name is matched to a field value passed from the client.
    /// </summary>
    ]]>
					</comment>
					<attributes public="true"/>
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
						<!-- property CommandName -->
						<memberField type="System.String" name="commandName"/>
						<memberProperty type="System.String" name="CommandName">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="commandName"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property CommandArgument -->
						<memberField type="System.String" name="commandArgument"/>
						<memberProperty type="System.String" name="CommandArgument">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="commandArgument"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Controller -->
						<memberField type="System.String" name="controller"/>
						<memberProperty type="System.String" name="Controller">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="controller"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property View -->
						<memberField type="System.String" name="view"/>
						<memberProperty type="System.String" name="View">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="view"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Phase -->
						<memberField type="ActionPhase" name="phase"/>
						<memberProperty type="ActionPhase" name="Phase">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="phase"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- constructor (string, string, string ) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="commandName"/>
								<parameter type="System.String" name="commandArgument"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="controller"/>
								<primitiveExpression value="null"/>
								<argumentReferenceExpression name="commandName"/>
								<argumentReferenceExpression name="commandArgument"/>
								<propertyReferenceExpression name="Execute">
									<typeReferenceExpression type="ActionPhase"/>
								</propertyReferenceExpression>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor (string, string, ActionPhase ) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="commandName"/>
								<parameter type="ActionPhase" name="phase"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="controller"/>
								<primitiveExpression value="null"/>
								<argumentReferenceExpression name="commandName"/>
								<argumentReferenceExpression name="phase"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor (string, string, string, ActionPhase ) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="commandName"/>
								<parameter type="ActionPhase" name="phase"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="controller"/>
								<argumentReferenceExpression name="view"/>
								<argumentReferenceExpression name="commandName"/>
								<propertyReferenceExpression name="Empty">
									<typeReferenceExpression type="String"/>
								</propertyReferenceExpression>
								<argumentReferenceExpression name="phase"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor (string, string, string, string, ActionPhase ) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="commandName"/>
								<parameter type="System.String" name="commandArgument"/>
								<parameter type="ActionPhase" name="phase"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="controller">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="controller"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="view">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="view"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="commandName">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="commandName"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="commandArgument">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="commandArgument"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="phase">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="phase"/>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>
				<!-- enum RowKind -->
				<typeDeclaration name="RowKind" isEnum="true">
					<members>
						<memberField name="New">
							<attributes public="true"/>
						</memberField>
						<memberField name="Existing">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- class RowBuilderAttribute -->
				<typeDeclaration name="RowBuilderAttribute">
					<attributes public="true"/>
					<customAttributes>
						<customAttribute name="AttributeUsage">
							<arguments>
								<propertyReferenceExpression name="Method">
									<typeReferenceExpression type="AttributeTargets"/>
								</propertyReferenceExpression>
								<attributeArgument name="AllowMultiple">
									<primitiveExpression value="true"/>
								</attributeArgument>
							</arguments>
						</customAttribute>
					</customAttributes>
					<baseTypes>
						<typeReference type="Attribute"/>
					</baseTypes>
					<members>
						<!-- property Controller -->
						<memberField type="System.String" name="controller"/>
						<memberProperty type="System.String" name="Controller">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="controller"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property View -->
						<memberField type="System.String" name="view"/>
						<memberProperty type="System.String" name="View">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="view"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Kind -->
						<memberField type="RowKind" name="kind"/>
						<memberProperty type="RowKind" name="Kind">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="kind"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- constructor (string, RowKind) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="RowKind" name="kind"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="controller"/>
								<primitiveExpression value="null"/>
								<argumentReferenceExpression name="kind"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor (string, string, RowKind) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="RowKind" name="kind"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="controller">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="controller"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="view">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="view"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="kind">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="kind"/>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>
				<!-- enum RowFilterOperation-->
				<typeDeclaration name="RowFilterOperation" isEnum="true">
					<members>
						<memberField name="None">
							<attributes public="true"/>
						</memberField>
						<memberField name="Equals">
							<attributes public="true"/>
						</memberField>
						<memberField name="DoesNotEqual">
							<attributes public="true"/>
						</memberField>
						<memberField name="Equal">
							<attributes public="true"/>
						</memberField>
						<memberField name="NotEqual">
							<attributes public="true"/>
						</memberField>
						<memberField name="LessThan">
							<attributes public="true"/>
						</memberField>
						<memberField name="LessThanOrEqual">
							<attributes public="true"/>
						</memberField>
						<memberField name="GreaterThan">
							<attributes public="true"/>
						</memberField>
						<memberField name="GreaterThanOrEqual">
							<attributes public="true"/>
						</memberField>
						<memberField name="Between">
							<attributes public="true"/>
						</memberField>
						<memberField name="Like">
							<attributes public="true"/>
						</memberField>

						<memberField name="IsEmpty">
							<attributes public="true"/>
						</memberField>
						<memberField name="IsNotEmpty">
							<attributes public="true"/>
						</memberField>

						<memberField name="Contains">
							<attributes public="true"/>
						</memberField>
						<memberField name="BeginsWith">
							<attributes public="true"/>
						</memberField>
						<memberField name="Includes">
							<attributes public="true"/>
						</memberField>
						<memberField name="DoesNotInclude">
							<attributes public="true"/>
						</memberField>
						<memberField name="DoesNotBeginWith">
							<attributes public="true"/>
						</memberField>
						<memberField name="DoesNotContain">
							<attributes public="true"/>
						</memberField>
						<memberField name="EndsWith">
							<attributes public="true"/>
						</memberField>
						<memberField name="DoesNotEndWith">
							<attributes public="true"/>
						</memberField>

						<memberField name="True">
							<attributes public="true"/>
						</memberField>
						<memberField name="False">
							<attributes public="true"/>
						</memberField>

						<memberField name="Tomorrow">
							<attributes public="true"/>
						</memberField>
						<memberField name="Today">
							<attributes public="true"/>
						</memberField>
						<memberField name="Yesterday">
							<attributes public="true"/>
						</memberField>
						<memberField name="NextWeek">
							<attributes public="true"/>
						</memberField>
						<memberField name="ThisWeek">
							<attributes public="true"/>
						</memberField>
						<memberField name="LastWeek">
							<attributes public="true"/>
						</memberField>
						<memberField name="NextMonth">
							<attributes public="true"/>
						</memberField>
						<memberField name="ThisMonth">
							<attributes public="true"/>
						</memberField>
						<memberField name="LastMonth">
							<attributes public="true"/>
						</memberField>
						<memberField name="NextQuarter">
							<attributes public="true"/>
						</memberField>
						<memberField name="ThisQuarter">
							<attributes public="true"/>
						</memberField>
						<memberField name="LastQuarter">
							<attributes public="true"/>
						</memberField>
						<memberField name="NextYear">
							<attributes public="true"/>
						</memberField>
						<memberField name="ThisYear">
							<attributes public="true"/>
						</memberField>
						<memberField name="YearToDate">
							<attributes public="true"/>
						</memberField>
						<memberField name="LastYear">
							<attributes public="true"/>
						</memberField>
						<memberField name="Past">
							<attributes public="true"/>
						</memberField>
						<memberField name="Future">
							<attributes public="true"/>
						</memberField>
						<memberField name="Quarter1">
							<attributes public="true"/>
						</memberField>
						<memberField name="Quarter2">
							<attributes public="true"/>
						</memberField>
						<memberField name="Quarter3">
							<attributes public="true"/>
						</memberField>
						<memberField name="Quarter4">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month1">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month2">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month3">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month4">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month5">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month6">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month7">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month8">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month9">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month10">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month11">
							<attributes public="true"/>
						</memberField>
						<memberField name="Month12">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- class RowFilterAttribute -->
				<typeDeclaration name="RowFilterAttribute">
					<attributes public="true"/>
					<customAttributes>
						<customAttribute name="AttributeUsage">
							<arguments>
								<propertyReferenceExpression name="Property">
									<typeReferenceExpression type="AttributeTargets"/>
								</propertyReferenceExpression>
								<attributeArgument name="AllowMultiple">
									<primitiveExpression value="true"/>
								</attributeArgument>
							</arguments>
						</customAttribute>
					</customAttributes>
					<baseTypes>
						<typeReference type="Attribute"/>
					</baseTypes>
					<members>
						<!-- static field ComparisonOperations -->
						<memberField type="System.String[]" name="ComparisonOperations">
							<attributes public="true" static="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<propertyReferenceExpression name="Empty">
											<typeReferenceExpression type="String"/>
										</propertyReferenceExpression>
										<primitiveExpression value="="/>
										<primitiveExpression value="&lt;>"/>
										<primitiveExpression value="="/>
										<primitiveExpression value="&lt;>"/>
										<primitiveExpression value="&lt;"/>
										<primitiveExpression value="&lt;="/>
										<primitiveExpression value=">"/>
										<primitiveExpression value=">="/>
										<primitiveExpression value="$between$"/>
										<primitiveExpression value="*"/>

										<primitiveExpression value="$isempty$"/>
										<primitiveExpression value="$isnotempty$"/>

										<primitiveExpression value="$contains$"/>
										<primitiveExpression value="$beginswith$"/>
										<primitiveExpression value="$in$"/>
										<primitiveExpression value="$notin$"/>
										<primitiveExpression value="$doesnotbeginwith$"/>
										<primitiveExpression value="$doesnotcontain$"/>
										<primitiveExpression value="$endswith$"/>
										<primitiveExpression value="$doesnotendwith$"/>

										<primitiveExpression value="$true$"/>
										<primitiveExpression value="$false$"/>

										<primitiveExpression value="$tomorrow$"/>
										<primitiveExpression value="$today$"/>
										<primitiveExpression value="$yesterday$"/>
										<primitiveExpression value="$nextweek$"/>
										<primitiveExpression value="$thisweek$"/>
										<primitiveExpression value="$lastweek$"/>
										<primitiveExpression value="$nextmonth$"/>
										<primitiveExpression value="$thismonth$"/>
										<primitiveExpression value="$lastmonth$"/>
										<primitiveExpression value="$nextquarter$"/>
										<primitiveExpression value="$thisquarter$"/>
										<primitiveExpression value="$lastquarter$"/>
										<primitiveExpression value="$nextyear$"/>
										<primitiveExpression value="$thisyear$"/>
										<primitiveExpression value="$yeartodate$"/>
										<primitiveExpression value="$lastyear$"/>
										<primitiveExpression value="$past$"/>
										<primitiveExpression value="$future$"/>
										<primitiveExpression value="$quarter1$"/>
										<primitiveExpression value="$quarter2$"/>
										<primitiveExpression value="$quarter3$"/>
										<primitiveExpression value="$quarter4$"/>
										<primitiveExpression value="$month1$"/>
										<primitiveExpression value="$month2$"/>
										<primitiveExpression value="$month3$"/>
										<primitiveExpression value="$month4$"/>
										<primitiveExpression value="$month5$"/>
										<primitiveExpression value="$month6$"/>
										<primitiveExpression value="$month7$"/>
										<primitiveExpression value="$month8$"/>
										<primitiveExpression value="$month9$"/>
										<primitiveExpression value="$month10$"/>
										<primitiveExpression value="$month11$"/>
										<primitiveExpression value="$month12$"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- property Controller -->
						<memberField type="System.String" name="controller"/>
						<memberProperty type="System.String" name="Controller">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="controller"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property View -->
						<memberField type="System.String" name="view"/>
						<memberProperty type="System.String" name="View">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="view"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property FieldName -->
						<memberField type="System.String" name="fieldName"/>
						<memberProperty type="System.String" name="FieldName">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="fieldName"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Operation -->
						<memberField type="RowFilterOperation" name="operation"/>
						<memberProperty type="RowFilterOperation" name="Operation">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="operation"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- constructor(string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="controller"/>
								<argumentReferenceExpression name="view"/>
								<primitiveExpression value="null"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor (string, string, string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="fieldName"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="controller"/>
								<argumentReferenceExpression name="view"/>
								<argumentReferenceExpression name="fieldName"/>
								<propertyReferenceExpression name="Equal">
									<typeReferenceExpression type="RowFilterOperation"/>
								</propertyReferenceExpression>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor(string, string, string, RowFilterOperation)-->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="RowFilterOperation" name="operation"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="controller">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="controller"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="view">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="view"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="fieldName">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="fieldName"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="operation"/>
									<argumentReferenceExpression name="operation"/>
								</assignStatement>
							</statements>
						</constructor>
						<!-- method OperationAsText() -->
						<memberMethod returnType="System.String" name="OperationAsText">
							<attributes public="true" final="true"/>
							<statements>
								<methodReturnStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="ComparisonOperations"/>
										</target>
										<indices>
											<!--<methodInvokeExpression methodName="ToInt32">
                        <target>
                          <typeReferenceExpression type="Convert"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="Operation"/>
                        </parameters>
                      </methodInvokeExpression>-->
											<convertExpression to="Int32">
												<propertyReferenceExpression name="Operation"/>
											</convertExpression>
										</indices>
									</arrayIndexerExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- type ParameterValue -->
				<typeDeclaration name="ParameterValue">
					<members>
						<!-- property Name -->
						<memberProperty type="System.String" name="Name">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Value -->
						<memberProperty type="System.Object" name="Value">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- constructor (string, object) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
								<parameter type="System.Object" name="value"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="Name">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="name"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Value">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="value"/>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>
				<!-- class FilterValue -->
				<typeDeclaration name="FilterValue">
					<members>
						<!-- property FilterOperation -->
						<memberField type="System.String" name="filterOperation">
							<customAttributes>
								<customAttribute name="System.Diagnostics.DebuggerBrowsable">
									<arguments>
										<propertyReferenceExpression name="Never">
											<typeReferenceExpression type="System.Diagnostics.DebuggerBrowsableState"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
						</memberField>
						<memberProperty type="RowFilterOperation" name="FilterOperation">
							<attributes public="true" final="true"/>
							<getStatements>
								<variableDeclarationStatement type="System.Int32" name="index">
									<init>
										<methodInvokeExpression methodName="IndexOf">
											<target>
												<typeReferenceExpression type="Array"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="ComparisonOperations">
													<typeReferenceExpression type="RowFilterAttribute"/>
												</propertyReferenceExpression>
												<fieldReferenceExpression name="filterOperation"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="index"/>
											<primitiveExpression value="-1"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="index"/>
											<primitiveExpression value="0"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<castExpression targetType="RowFilterOperation">
										<variableReferenceExpression name="index"/>
									</castExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Name -->
						<memberField type="System.String" name="name">
							<customAttributes>
								<customAttribute name="System.Diagnostics.DebuggerBrowsable">
									<arguments>
										<propertyReferenceExpression name="Never">
											<typeReferenceExpression type="System.Diagnostics.DebuggerBrowsableState"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
						</memberField>
						<memberProperty type="System.String" name="Name">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<fieldReferenceExpression name="filterOperation">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<primitiveExpression value="~"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="name"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- constructor (string, RowFilterOperation) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="RowFilterOperation" name="operation"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="fieldName"/>
								<argumentReferenceExpression name="operation"/>
								<propertyReferenceExpression name="Value">
									<typeReferenceExpression type="DBNull"/>
								</propertyReferenceExpression>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor (string, RowFilterOperation, object) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="RowFilterOperation" name="operation"/>
								<parameter type="params System.Object[]" name="value"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="fieldName"/>
								<arrayIndexerExpression>
									<target>
										<propertyReferenceExpression name="ComparisonOperations">
											<typeReferenceExpression type="RowFilterAttribute"/>
										</propertyReferenceExpression>
									</target>
									<indices>
										<castExpression targetType="System.Int32">
											<argumentReferenceExpression name="operation"/>
										</castExpression>
									</indices>
								</arrayIndexerExpression>
								<argumentReferenceExpression name="value"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor(string, string, object) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="System.String" name="operation"/>
								<parameter type="System.Object" name="value"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="name">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="fieldName"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="filterOperation">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="operation"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="values"/>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="System.Object"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<argumentReferenceExpression name="value"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="BooleanAnd">
												<methodInvokeExpression methodName="IsInstanceOfType">
													<target>
														<typeofExpression type="System.Collections.IEnumerable"/>
													</target>
													<parameters>
														<variableReferenceExpression name="value"/>
													</parameters>
												</methodInvokeExpression>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="IsInstanceOfType">
														<target>
															<typeofExpression type="System.String"/>
														</target>
														<parameters>
															<variableReferenceExpression name="value"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AddRange">
											<target>
												<fieldReferenceExpression name="values"/>
											</target>
											<parameters>
												<castExpression targetType="IEnumerable">
													<typeArguments>
														<typeReference type="System.Object"/>
													</typeArguments>
													<argumentReferenceExpression name="value"/>
												</castExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<fieldReferenceExpression name="values"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="value"/>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</constructor>
						<!-- property Value -->
						<memberProperty type="System.Object" name="Value">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="values"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Values"/>
										</target>
										<indices>
											<primitiveExpression value="0"/>
										</indices>
									</arrayIndexerExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Values[] -->
						<memberField type="List" name="values">
							<typeArguments>
								<typeReference type="System.Object"/>
							</typeArguments>
							<customAttributes>
								<customAttribute name="System.Diagnostics.DebuggerBrowsable">
									<arguments>
										<propertyReferenceExpression name="Never">
											<typeReferenceExpression type="System.Diagnostics.DebuggerBrowsableState"/>
										</propertyReferenceExpression>
									</arguments>
								</customAttribute>
							</customAttributes>
						</memberField>
						<memberProperty type="System.Object[]" name="Values">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<fieldReferenceExpression name="values">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method AddValue(object) -->
						<memberMethod name="AddValue">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.Object" name="value"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="values"/>
									</target>
									<parameters>
										<argumentReferenceExpression name="value"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method Clear() -->
						<memberMethod name="Clear">
							<attributes public="true" final="true"/>
							<statements>
								<methodInvokeExpression methodName="Clear">
									<target>
										<fieldReferenceExpression name="values"/>
									</target>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- RowFilterContext -->
				<typeDeclaration name="RowFilterContext">
					<attributes public="true"/>
					<members>
						<!-- property Controller -->
						<memberField type="System.String" name="controller"/>
						<memberProperty type="System.String" name="Controller">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="controller"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="controller"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property View -->
						<memberField type="System.String" name="view"/>
						<memberProperty type="System.String" name="View">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="view"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="view"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property LookupContextController -->
						<memberField type="System.String" name="lookupContextController"/>
						<memberProperty type="System.String" name="LookupContextController">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="lookupContextController"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="lookupContextController"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property LookupContextView -->
						<memberField type="System.String" name="lookupContextView"/>
						<memberProperty type="System.String" name="LookupContextView">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="lookupContextView"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="lookupContextView"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property LookupContextFieldName -->
						<memberField type="System.String" name="lookupContextFieldName"/>
						<memberProperty type="System.String" name="LookupContextFieldName">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="lookupContextFieldName"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="lookupContextFieldName"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property Canceled -->
						<memberField type="System.Boolean" name="canceled"/>
						<memberProperty type="System.Boolean" name="Canceled">
							<attributes public="true" final="true" />
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="canceled"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="canceled"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- constructor RowFilterContext(string, string, string, string, string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="lookupContextController"/>
								<parameter type="System.String" name="lookupContextView"/>
								<parameter type="System.String" name="lookupContextFieldName"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="Controller">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="controller"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="View">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="view"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="LookupContextController">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="lookupContextController"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="LookupContextView">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="lookupContextView"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="LookupContextFieldName">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="lookupContextFieldName"/>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>
				<!-- enum AccessPermission -->
				<typeDeclaration name="AccessPermission" isEnum="true">
					<members>
						<memberField name="Allow">
							<attributes public="true"/>
						</memberField>
						<memberField name="Deny">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- class AccessControlAttribute -->
				<typeDeclaration name="AccessControlAttribute">
					<customAttributes>
						<customAttribute type="AttributeUsage">
							<arguments>
								<propertyReferenceExpression name="Method">
									<typeReferenceExpression type="AttributeTargets"/>
								</propertyReferenceExpression>
								<attributeArgument name="AllowMultiple">
									<primitiveExpression value="true"/>
								</attributeArgument>
							</arguments>
						</customAttribute>
					</customAttributes>
					<baseTypes>
						<typeReference type="Attribute"/>
					</baseTypes>
					<members>
						<!-- property Controller -->
						<memberProperty type="System.String" name="Controller">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property FieldName -->
						<memberProperty type="System.String" name="FieldName">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Permission -->
						<memberProperty type="AccessPermission" name="Permission">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Sql -->
						<memberProperty type="System.String" name="Sql">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Parameters-->
						<memberProperty type="List" name="Parameters">
							<typeArguments>
								<typeReference type="SqlParam"/>
							</typeArguments>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Restrictions -->
						<memberProperty type="List" name="Restrictions">
							<typeArguments>
								<typeReference type="System.Object"/>
							</typeArguments>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- constructor(string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
							</parameters>
							<chainedConstructorArgs>
								<propertyReferenceExpression name="Empty">
									<typeReferenceExpression type="String"/>
								</propertyReferenceExpression>
								<argumentReferenceExpression name="fieldName"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor(string, AccessPermission) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="AccessPermission" name="permission"/>
							</parameters>
							<chainedConstructorArgs>
								<propertyReferenceExpression name="Empty">
									<typeReferenceExpression type="String"/>
								</propertyReferenceExpression>
								<argumentReferenceExpression name="fieldName"/>
								<argumentReferenceExpression name="permission"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor(string, string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="fieldName"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="controller"/>
								<argumentReferenceExpression name="fieldName"/>
								<propertyReferenceExpression name="Allow">
									<typeReferenceExpression type="AccessPermission"/>
								</propertyReferenceExpression>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor(string, string, AccessPermission) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="AccessPermission" name="permission"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="controller"/>
								<argumentReferenceExpression name="fieldName"/>
								<propertyReferenceExpression name="Empty">
									<typeReferenceExpression type="String"/>
								</propertyReferenceExpression>
								<argumentReferenceExpression name="permission"/>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor(string, string, string) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="System.String" name="sql"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="controller"/>
								<argumentReferenceExpression name="fieldName"/>
								<argumentReferenceExpression name="sql"/>
								<propertyReferenceExpression name="Allow">
									<typeReferenceExpression type="AccessPermission"/>
								</propertyReferenceExpression>
							</chainedConstructorArgs>
						</constructor>
						<!-- constructor(string, string, string, AccessPermission) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="System.String" name="sql"/>
								<parameter type="AccessPermission" name="permission"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="controller">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="controller"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="fieldName">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="fieldName"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="permission">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="permission"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="sql">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="sql"/>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>
				<xsl:if test="$IsPremium='true'">
					<!-- public class AccessControlRule -->
					<typeDeclaration name="AccessControlRule">
						<members>
							<!-- property AccessControl -->
							<memberProperty type="AccessControlAttribute" name="AccessControl">
								<attributes public="true" final="true"/>
							</memberProperty>
							<!-- property Method -->
							<memberProperty type="MethodInfo" name="Method">
								<attributes public="true" final="true"/>
							</memberProperty>
							<!-- constructor(AccessControlAttribute, MethodInfo) -->
							<constructor>
								<attributes public="true"/>
								<parameters>
									<parameter type="AccessControlAttribute" name="accessControl"/>
									<parameter type="MethodInfo" name="method"/>
								</parameters>
								<statements>
									<assignStatement>
										<fieldReferenceExpression name="accessControl">
											<thisReferenceExpression/>
										</fieldReferenceExpression>
										<argumentReferenceExpression name="accessControl"/>
									</assignStatement>
									<assignStatement>
										<fieldReferenceExpression name="method">
											<thisReferenceExpression/>
										</fieldReferenceExpression>
										<argumentReferenceExpression name="method"/>
									</assignStatement>
								</statements>
							</constructor>
						</members>
					</typeDeclaration>
					<!-- class AccessControlRuleDictionary -->
					<typeDeclaration name="AccessControlRuleDictionary">
						<baseTypes>
							<typeReference type="SortedDictionary">
								<typeArguments>
									<typeReference type="System.String"/>
									<typeReference type="List">
										<typeArguments>
											<typeReference type="AccessControlRule"/>
										</typeArguments>
									</typeReference>
								</typeArguments>
							</typeReference>
						</baseTypes>
					</typeDeclaration>
					<!-- class DynamicAccessControlList-->
					<typeDeclaration name="DynamicAccessControlList">
						<baseTypes>
							<typeReference type="List">
								<typeArguments>
									<typeReference type="DynamicAccessControlRule"/>
								</typeArguments>
							</typeReference>
						</baseTypes>
						<members>
							<!-- field RuleRegex-->
							<memberField type="Regex" name="RuleRegex">
								<attributes public="true" static="true"/>
								<init>
									<objectCreateExpression type="Regex">
										<parameters>
											<primitiveExpression value="(?'ParamList'^(\s*([\w\-]+)\s*(\:|\=)\s*(.+?)\n)+)"/>
											<propertyReferenceExpression name="Multiline">
												<typeReferenceExpression type="RegexOptions"/>
											</propertyReferenceExpression>
										</parameters>
									</objectCreateExpression>
								</init>
							</memberField>
							<!-- field ParamRegex-->
							<memberField type="Regex" name="ParamRegex">
								<attributes public="true" static="true"/>
								<init>
									<objectCreateExpression type="Regex">
										<parameters>
											<primitiveExpression value="^(?'Name'[\w\-]+)\s*(\:|\=)\s*(?'Value'.+)$"/>
											<propertyReferenceExpression name="Multiline">
												<typeReferenceExpression type="RegexOptions"/>
											</propertyReferenceExpression>
										</parameters>
									</objectCreateExpression>
								</init>
							</memberField>
							<!-- method Parse-->
							<memberMethod name="Parse">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="fileName"/>
									<parameter type="System.String" name="rules"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="SortedDictionary" name="parameters">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="System.String"/>
										</typeArguments>
										<init>
											<objectCreateExpression type="SortedDictionary">
												<typeArguments>
													<typeReference type="System.String"/>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="Match" name="ruleMatch">
										<init>
											<methodInvokeExpression methodName="Match">
												<target>
													<propertyReferenceExpression name="RuleRegex"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="rules"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<whileStatement>
										<test>
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="ruleMatch"/>
											</propertyReferenceExpression>
										</test>
										<statements>
											<methodInvokeExpression methodName="Clear">
												<target>
													<variableReferenceExpression name="parameters"/>
												</target>
											</methodInvokeExpression>
											<variableDeclarationStatement type="Match" name="paramMatch">
												<init>
													<methodInvokeExpression methodName="Match">
														<target>
															<propertyReferenceExpression name="ParamRegex"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Value">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Groups">
																			<variableReferenceExpression name="ruleMatch"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="ParamList"/>
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
														<variableReferenceExpression name="paramMatch"/>
													</propertyReferenceExpression>
												</test>
												<statements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="parameters"/>
															</target>
															<indices>
																<methodInvokeExpression methodName="Replace">
																	<target>
																		<methodInvokeExpression methodName="ToLower">
																			<target>
																				<propertyReferenceExpression name="Value">
																					<arrayIndexerExpression>
																						<target>
																							<propertyReferenceExpression name="Groups">
																								<variableReferenceExpression name="paramMatch"/>
																							</propertyReferenceExpression>
																						</target>
																						<indices>
																							<primitiveExpression value="Name"/>
																						</indices>
																					</arrayIndexerExpression>
																				</propertyReferenceExpression>
																			</target>
																		</methodInvokeExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="-"/>
																		<stringEmptyExpression />
																	</parameters>
																</methodInvokeExpression>
															</indices>
														</arrayIndexerExpression>
														<methodInvokeExpression methodName="Trim">
															<target>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="paramMatch"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Value"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</target>
														</methodInvokeExpression>
													</assignStatement>
													<assignStatement>
														<variableReferenceExpression name="paramMatch"/>
														<methodInvokeExpression methodName="NextMatch">
															<target>
																<variableReferenceExpression name="paramMatch"/>
															</target>
														</methodInvokeExpression>
													</assignStatement>
												</statements>
											</whileStatement>
											<variableDeclarationStatement type="System.String" name="v">
												<init>
													<primitiveExpression value="null"/>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="TryGetValue">
														<target>
															<variableReferenceExpression name="parameters"/>
														</target>
														<parameters>
															<primitiveExpression value="field"/>
															<directionExpression direction="Out">
																<variableReferenceExpression name="v"/>
															</directionExpression>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement type="DynamicAccessControlRule" name="r">
														<init>
															<objectCreateExpression type="DynamicAccessControlRule"/>
														</init>
													</variableDeclarationStatement>
													<assignStatement>
														<propertyReferenceExpression name="Field">
															<variableReferenceExpression name="r"/>
														</propertyReferenceExpression>
														<variableReferenceExpression name="v"/>
													</assignStatement>
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="TryGetValue">
																<target>
																	<variableReferenceExpression name="parameters"/>
																</target>
																<parameters>
																	<primitiveExpression value="controller"/>
																	<directionExpression direction="Out">
																		<variableReferenceExpression name="v"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<propertyReferenceExpression name="Controller">
																	<variableReferenceExpression name="r"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="v"/>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="TryGetValue">
																<target>
																	<variableReferenceExpression name="parameters"/>
																</target>
																<parameters>
																	<primitiveExpression value="tags"/>
																	<directionExpression direction="Out">
																		<variableReferenceExpression name="v"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<propertyReferenceExpression name="Tags">
																	<variableReferenceExpression name="r"/>
																</propertyReferenceExpression>
																<methodInvokeExpression methodName="Split">
																	<target>
																		<propertyReferenceExpression name="ListRegex">
																			<typeReferenceExpression type="BusinessRules"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="v"/>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="TryGetValue">
																<target>
																	<variableReferenceExpression name="parameters"/>
																</target>
																<parameters>
																	<primitiveExpression value="roles"/>
																	<directionExpression direction="Out">
																		<variableReferenceExpression name="v"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<propertyReferenceExpression name="Roles">
																	<variableReferenceExpression name="r"/>
																</propertyReferenceExpression>
																<methodInvokeExpression methodName="Split">
																	<target>
																		<propertyReferenceExpression name="ListRegex">
																			<typeReferenceExpression type="BusinessRules"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="v"/>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="TryGetValue">
																<target>
																	<variableReferenceExpression name="parameters"/>
																</target>
																<parameters>
																	<primitiveExpression value="roleexceptions"/>
																	<directionExpression direction="Out">
																		<variableReferenceExpression name="v"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<propertyReferenceExpression name="RoleExceptions">
																	<variableReferenceExpression name="r"/>
																</propertyReferenceExpression>
																<methodInvokeExpression methodName="Split">
																	<target>
																		<propertyReferenceExpression name="ListRegex">
																			<typeReferenceExpression type="BusinessRules"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="v"/>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="TryGetValue">
																<target>
																	<variableReferenceExpression name="parameters"/>
																</target>
																<parameters>
																	<primitiveExpression value="users"/>
																	<directionExpression direction="Out">
																		<variableReferenceExpression name="v"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<propertyReferenceExpression name="Users">
																	<variableReferenceExpression name="r"/>
																</propertyReferenceExpression>
																<methodInvokeExpression methodName="Split">
																	<target>
																		<propertyReferenceExpression name="ListRegex">
																			<typeReferenceExpression type="BusinessRules"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="v"/>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="TryGetValue">
																<target>
																	<variableReferenceExpression name="parameters"/>
																</target>
																<parameters>
																	<primitiveExpression value="userexceptions"/>
																	<directionExpression direction="Out">
																		<variableReferenceExpression name="v"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<propertyReferenceExpression name="UserExceptions">
																	<variableReferenceExpression name="r"/>
																</propertyReferenceExpression>
																<methodInvokeExpression methodName="Split">
																	<target>
																		<propertyReferenceExpression name="ListRegex">
																			<typeReferenceExpression type="BusinessRules"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="v"/>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<methodInvokeExpression methodName="TryGetValue">
														<target>
															<variableReferenceExpression name="parameters"/>
														</target>
														<parameters>
															<primitiveExpression value="type"/>
															<directionExpression direction="Out">
																<variableReferenceExpression name="v"/>
															</directionExpression>
														</parameters>
													</methodInvokeExpression>
													<variableDeclarationStatement type="System.Int32" name="index">
														<init>
															<binaryOperatorExpression operator="Add">
																<propertyReferenceExpression name="Index">
																	<variableReferenceExpression name="ruleMatch"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Length">
																	<variableReferenceExpression name="ruleMatch"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</init>
													</variableDeclarationStatement>
													<variableDeclarationStatement type="System.Int32" name="nextIndex">
														<init>
															<propertyReferenceExpression name="Length">
																<variableReferenceExpression name="rules"/>
															</propertyReferenceExpression>
														</init>
													</variableDeclarationStatement>
													<assignStatement>
														<variableReferenceExpression name="ruleMatch"/>
														<methodInvokeExpression methodName="NextMatch">
															<target>
																<variableReferenceExpression name="ruleMatch"/>
															</target>
														</methodInvokeExpression>
													</assignStatement>
													<conditionStatement>
														<condition>
															<propertyReferenceExpression name="Success">
																<variableReferenceExpression name="ruleMatch"/>
															</propertyReferenceExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="nextIndex"/>
																<propertyReferenceExpression name="Index">
																	<variableReferenceExpression name="ruleMatch"/>
																</propertyReferenceExpression>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<variableDeclarationStatement type="System.String" name="sql">
														<init>
															<methodInvokeExpression methodName="Trim">
																<target>
																	<methodInvokeExpression methodName="Substring">
																		<target>
																			<variableReferenceExpression name="rules"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="index"/>
																			<binaryOperatorExpression operator="Subtract">
																				<variableReferenceExpression name="nextIndex"/>
																				<variableReferenceExpression name="index"/>
																			</binaryOperatorExpression>
																		</parameters>
																	</methodInvokeExpression>
																</target>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="Equals">
																<target>
																	<primitiveExpression value="deny"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="v"/>
																	<propertyReferenceExpression name="OrdinalIgnoreCase">
																		<typeReferenceExpression type="StringComparison"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<propertyReferenceExpression name="DenySql">
																	<variableReferenceExpression name="r"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="sql"/>
															</assignStatement>
														</trueStatements>
														<falseStatements>
															<assignStatement>
																<propertyReferenceExpression name="AllowSql">
																	<variableReferenceExpression name="r"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="sql"/>
															</assignStatement>
														</falseStatements>
													</conditionStatement>
													<methodInvokeExpression methodName="Add">
														<parameters>
															<variableReferenceExpression name="r"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
												<falseStatements>
													<assignStatement>
														<variableReferenceExpression name="ruleMatch"/>
														<methodInvokeExpression methodName="NextMatch">
															<target>
																<variableReferenceExpression name="ruleMatch"/>
															</target>
														</methodInvokeExpression>
													</assignStatement>
												</falseStatements>
											</conditionStatement>
										</statements>
									</whileStatement>
									<!--<assignStatement>
                    <variableReferenceExpression name="rules"/>
                    <methodInvokeExpression methodName="Replace">
                      <target>
                        <variableReferenceExpression name="rules"/>
                      </target>
                      <parameters>
                        <primitiveExpression>
                          <xsl:attribute name="value"><![CDATA[<accessControl>]]></xsl:attribute>
                        </primitiveExpression>
                        <primitiveExpression>
                          <xsl:attribute name="value"><![CDATA[<accessControl xmlns="urn:schemas-codeontime-com:data-aquarium">]]></xsl:attribute>
                        </primitiveExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </assignStatement>
                  <variableDeclarationStatement type="XPathNavigator" name="rulesNav">
                    <init>
                      <methodInvokeExpression methodName="CreateNavigator">
                        <target>
                          <objectCreateExpression type="XPathDocument">
                            <parameters>
                              <objectCreateExpression type="StringReader">
                                <parameters>
                                  <argumentReferenceExpression name="rules"/>
                                </parameters>
                              </objectCreateExpression>
                            </parameters>
                          </objectCreateExpression>
                        </target>
                      </methodInvokeExpression>
                    </init>
                  </variableDeclarationStatement>
                  <variableDeclarationStatement type="XmlNamespaceManager" name="nm">
                    <init>
                      <objectCreateExpression type="XmlNamespaceManager">
                        <parameters>
                          <propertyReferenceExpression name="NameTable">
                            <variableReferenceExpression name="rulesNav"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </objectCreateExpression>
                    </init>
                  </variableDeclarationStatement>
                  <methodInvokeExpression methodName="AddNamespace">
                    <target>
                      <variableReferenceExpression name="nm"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="r"/>
                      <primitiveExpression value="urn:schemas-codeontime-com:data-aquarium"/>
                    </parameters>
                  </methodInvokeExpression>
                  <variableDeclarationStatement type="XPathNodeIterator" name="ifIterator">
                    <init>
                      <methodInvokeExpression methodName="Select">
                        <target>
                          <variableReferenceExpression name="rulesNav"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="/r:accessControl/r:if"/>
                          <variableReferenceExpression name="nm"/>
                        </parameters>
                      </methodInvokeExpression>
                    </init>
                  </variableDeclarationStatement>
                  <whileStatement>
                    <test>
                      <methodInvokeExpression methodName="MoveNext">
                        <target>
                          <variableReferenceExpression name="ifIterator"/>
                        </target>
                      </methodInvokeExpression>
                    </test>
                    <statements>
                      <variableDeclarationStatement type="DynamicAccessControlRule" name="r">
                        <init>
                          <objectCreateExpression type="DynamicAccessControlRule"/>
                        </init>
                      </variableDeclarationStatement>
                      <assignStatement>
                        <propertyReferenceExpression name="FileName">
                          <variableReferenceExpression name="r"/>
                        </propertyReferenceExpression>
                        <argumentReferenceExpression name="fileName"/>
                      </assignStatement>
                      <assignStatement>
                        <propertyReferenceExpression name="Field">
                          <variableReferenceExpression name="r"/>
                        </propertyReferenceExpression>
                        <methodInvokeExpression methodName="GetAttribute">
                          <target>
                            <propertyReferenceExpression name="Current">
                              <variableReferenceExpression name="ifIterator"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="field"/>
                            <stringEmptyExpression/>
                          </parameters>
                        </methodInvokeExpression>
                      </assignStatement>
                      <assignStatement>
                        <propertyReferenceExpression name="Controller">
                          <variableReferenceExpression name="r"/>
                        </propertyReferenceExpression>
                        <methodInvokeExpression methodName="GetAttribute">
                          <target>
                            <propertyReferenceExpression name="Current">
                              <variableReferenceExpression name="ifIterator"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="controller"/>
                            <stringEmptyExpression/>
                          </parameters>
                        </methodInvokeExpression>
                      </assignStatement>
                      <variableDeclarationStatement type="System.String" name="list">
                        <init>
                          <methodInvokeExpression methodName="GetAttribute">
                            <target>
                              <propertyReferenceExpression name="Current">
                                <variableReferenceExpression name="ifIterator"/>
                              </propertyReferenceExpression>
                            </target>
                            <parameters>
                              <primitiveExpression value="roles"/>
                              <stringEmptyExpression/>
                            </parameters>
                          </methodInvokeExpression>
                        </init>
                      </variableDeclarationStatement>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="IsNotNullOrEmpty">
                            <variableReferenceExpression name="list"/>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <propertyReferenceExpression name="Roles">
                              <variableReferenceExpression name="r"/>
                            </propertyReferenceExpression>
                            <methodInvokeExpression methodName="Split">
                              <target>
                                <typeReferenceExpression type="Regex"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="list"/>
                                <primitiveExpression value="\s*,\s*"/>
                              </parameters>
                            </methodInvokeExpression>
                          </assignStatement>
                        </trueStatements>
                      </conditionStatement>
                      <assignStatement>
                        <variableReferenceExpression name="list"/>
                        <methodInvokeExpression methodName="GetAttribute">
                          <target>
                            <propertyReferenceExpression name="Current">
                              <variableReferenceExpression name="ifIterator"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="roleExceptions"/>
                            <stringEmptyExpression/>
                          </parameters>
                        </methodInvokeExpression>
                      </assignStatement>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="IsNotNullOrEmpty">
                            <variableReferenceExpression name="list"/>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <propertyReferenceExpression name="RoleExceptions">
                              <variableReferenceExpression name="r"/>
                            </propertyReferenceExpression>
                            <methodInvokeExpression methodName="Split">
                              <target>
                                <typeReferenceExpression type="Regex"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="list"/>
                                <primitiveExpression value="\s*,\s*"/>
                              </parameters>
                            </methodInvokeExpression>
                          </assignStatement>
                        </trueStatements>
                      </conditionStatement>
                      <assignStatement>
                        <variableReferenceExpression name="list"/>
                        <methodInvokeExpression methodName="GetAttribute">
                          <target>
                            <propertyReferenceExpression name="Current">
                              <variableReferenceExpression name="ifIterator"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="users"/>
                            <stringEmptyExpression/>
                          </parameters>
                        </methodInvokeExpression>
                      </assignStatement>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="IsNotNullOrEmpty">
                            <variableReferenceExpression name="list"/>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <propertyReferenceExpression name="Users">
                              <variableReferenceExpression name="r"/>
                            </propertyReferenceExpression>
                            <methodInvokeExpression methodName="Split">
                              <target>
                                <typeReferenceExpression type="Regex"/>
                              </target>
                              <parameters>
                                <methodInvokeExpression methodName="ToLower">
                                  <target>
                                    <variableReferenceExpression name="list"/>
                                  </target>
                                </methodInvokeExpression>
                                <primitiveExpression value="\s*,\s*"/>
                              </parameters>
                            </methodInvokeExpression>
                          </assignStatement>
                        </trueStatements>
                      </conditionStatement>
                      <assignStatement>
                        <variableReferenceExpression name="list"/>
                        <methodInvokeExpression methodName="GetAttribute">
                          <target>
                            <propertyReferenceExpression name="Current">
                              <variableReferenceExpression name="ifIterator"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="userExceptions"/>
                            <stringEmptyExpression/>
                          </parameters>
                        </methodInvokeExpression>
                      </assignStatement>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="IsNotNullOrEmpty">
                            <variableReferenceExpression name="list"/>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <propertyReferenceExpression name="UserExceptions">
                              <variableReferenceExpression name="r"/>
                            </propertyReferenceExpression>
                            <methodInvokeExpression methodName="Split">
                              <target>
                                <typeReferenceExpression type="Regex"/>
                              </target>
                              <parameters>
                                <methodInvokeExpression methodName="ToLower">
                                  <target>
                                    <variableReferenceExpression name="list"/>
                                  </target>
                                </methodInvokeExpression>
                                <primitiveExpression value="\s*,\s*"/>
                              </parameters>
                            </methodInvokeExpression>
                          </assignStatement>
                        </trueStatements>
                      </conditionStatement>
                      <variableDeclarationStatement type="XPathNavigator" name="allow">
                        <init>
                          <methodInvokeExpression methodName="SelectSingleNode">
                            <target>
                              <propertyReferenceExpression name="Current">
                                <variableReferenceExpression name="ifIterator"/>
                              </propertyReferenceExpression>
                            </target>
                            <parameters>
                              <primitiveExpression value="r:allow"/>
                              <variableReferenceExpression name="nm"/>
                            </parameters>
                          </methodInvokeExpression>
                        </init>
                      </variableDeclarationStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="IdentityInequality">
                            <variableReferenceExpression name="allow"/>
                            <primitiveExpression value="null"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <propertyReferenceExpression name="AllowSql">
                              <variableReferenceExpression name="r"/>
                            </propertyReferenceExpression>
                            <propertyReferenceExpression name="Value">
                              <variableReferenceExpression name="allow"/>
                            </propertyReferenceExpression>
                          </assignStatement>
                        </trueStatements>
                      </conditionStatement>
                      <variableDeclarationStatement type="XPathNavigator" name="deny">
                        <init>
                          <methodInvokeExpression methodName="SelectSingleNode">
                            <target>
                              <propertyReferenceExpression name="Current">
                                <variableReferenceExpression name="ifIterator"/>
                              </propertyReferenceExpression>
                            </target>
                            <parameters>
                              <primitiveExpression value="r:deny"/>
                              <variableReferenceExpression name="nm"/>
                            </parameters>
                          </methodInvokeExpression>
                        </init>
                      </variableDeclarationStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="IdentityInequality">
                            <variableReferenceExpression name="deny"/>
                            <primitiveExpression value="null"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <propertyReferenceExpression name="DenySql">
                              <variableReferenceExpression name="r"/>
                            </propertyReferenceExpression>
                            <propertyReferenceExpression name="Value">
                              <variableReferenceExpression name="deny"/>
                            </propertyReferenceExpression>
                          </assignStatement>
                        </trueStatements>
                      </conditionStatement>
                      <methodInvokeExpression methodName="Add">
                        <parameters>
                          <variableReferenceExpression name="r"/>
                        </parameters>
                      </methodInvokeExpression>
                    </statements>
                  </whileStatement>-->
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- class DynamicAccessControlRule-->
					<typeDeclaration name="DynamicAccessControlRule">
						<attributes public="true"/>
						<members>
							<!-- property Field-->
							<memberProperty type="System.String" name="Field">
								<attributes public="true"/>
							</memberProperty>
							<!-- property Controller-->
							<memberProperty type="System.String" name="Controller">
								<attributes public="true"/>
							</memberProperty>
							<!-- property Tags-->
							<memberProperty type="System.String[]" name="Tags">
								<attributes public="true"/>
							</memberProperty>
							<!-- property Roles-->
							<memberProperty type="System.String[]" name="Roles">
								<attributes public="true"/>
							</memberProperty>
							<!-- property RoleExceptions-->
							<memberProperty type="System.String[]" name="RoleExceptions">
								<attributes public="true"/>
							</memberProperty>
							<!-- property Users-->
							<memberProperty type="System.String[]" name="Users">
								<attributes public="true"/>
							</memberProperty>
							<!-- property UserExceptions-->
							<memberProperty type="System.String[]" name="UserExceptions">
								<attributes public="true"/>
							</memberProperty>
							<!-- property AllowSql-->
							<memberProperty type="System.String" name="AllowSql">
								<attributes public="true"/>
							</memberProperty>
							<!-- property DenySql-->
							<memberProperty type="System.String" name="DenySql">
								<attributes public="true"/>
							</memberProperty>
							<!-- property FileName-->
							<memberProperty type="System.String" name="FileName">
								<attributes public="true"/>
							</memberProperty>
							<!-- constructor DynamicAccessControlRules-->
							<!-- method ToString()-->
							<memberMethod returnType="System.String" name="ToString">
								<attributes public="true" override="true"/>
								<statements>
									<variableDeclarationStatement type="System.String" name="mode">
										<init>
											<primitiveExpression value="allow"/>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="sql">
										<init>
											<propertyReferenceExpression name="AllowSql"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<propertyReferenceExpression name="AllowSql"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="sql"/>
												<propertyReferenceExpression name="DenySql"/>
											</assignStatement>
											<assignStatement>
												<variableReferenceExpression name="mode"/>
												<primitiveExpression value="deny"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="trigger">
										<init>
											<propertyReferenceExpression name="Controller"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="trigger"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="trigger"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="trigger"/>
													<primitiveExpression value="."/>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<variableReferenceExpression name="trigger"/>
										<binaryOperatorExpression operator="Add">
											<variableReferenceExpression name="trigger"/>
											<propertyReferenceExpression name="Field"/>
										</binaryOperatorExpression>
									</assignStatement>
									<methodReturnStatement>
										<stringFormatExpression format="{{0}} ({{1}}) -> {{2}}">
											<variableReferenceExpression name="trigger"/>
											<variableReferenceExpression name="mode"/>
											<methodInvokeExpression methodName="Trim">
												<target>
													<variableReferenceExpression name="sql"/>
												</target>
											</methodInvokeExpression>
										</stringFormatExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
				</xsl:if>
				<!-- class BusinessRules -->
				<typeDeclaration name="BusinessRules" isPartial="true">
					<baseTypes>
						<typeReference type="BusinessRulesBase"/>
					</baseTypes>
					<members>
						<!-- field ListRegex-->
						<memberField type="Regex" name="ListRegex">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression value="\s*,\s*"/>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- 
        public static string StartUrl
        {
            get
            {
                HttpContext context = HttpContext.Current;
                var startUrl = context.Request.Headers["X-Start-Url"];
                if (String.IsNullOrEmpty(startUrl))
                    startUrl = context.Request.Headers["Referer"];
                return startUrl;
            }
        }          -->
						<!-- property StartUrl -->
						<memberProperty type="System.String" name="StartUrl">
							<attributes public="true" static="true"/>
							<getStatements>
								<variableDeclarationStatement type="HttpContext" name="context">
									<init>
										<propertyReferenceExpression name="Current">
											<typeReferenceExpression type="HttpContext"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="url">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<propertyReferenceExpression name="Request">
														<variableReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="X-Start-Url"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="url"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="url"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Headers">
														<propertyReferenceExpression name="Request">
															<variableReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="Referer"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="url"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="url"/>
											<stringEmptyExpression/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="url"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
					</members>
				</typeDeclaration>
				<!-- class BusinessRulesBase -->
				<typeDeclaration name="BusinessRulesBase">
					<attributes public="true"/>
					<baseTypes>
						<typeReference type="ActionHandlerBase"/>
						<typeReference type="{$Namespace}.Data.IRowHandler"/>
						<typeReference type="{$Namespace}.Data.IDataFilter"/>
						<typeReference type="{$Namespace}.Data.IDataFilter2"/>
					</baseTypes>
					<members>
						<xsl:if test="a:project/@targetFramework='3.5'">
							<memberField type="Regex" name="GuidRegex">
								<attributes public="true" static="true"/>
								<init>
									<objectCreateExpression type="Regex">
										<parameters>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[^\{?([\da-f]{8}-[\da-f]{4}-[\da-f]{4}-[\da-f]{4}-[\da-f]{12})\}?$]]></xsl:attribute>
											</primitiveExpression>
											<propertyReferenceExpression name="IgnoreCase">
												<typeReferenceExpression type="RegexOptions"/>
											</propertyReferenceExpression>
										</parameters>
									</objectCreateExpression>
								</init>
							</memberField>
							<memberMethod returnType="System.Boolean" name="TryParseGuid">
								<attributes public="true" static="true"/>
								<parameters>
									<parameter type="System.String" name="s"/>
									<parameter type="Guid" name="value" direction="Out"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="Match" name="m">
										<init>
											<methodInvokeExpression methodName="Match">
												<target>
													<typeReferenceExpression type="GuidRegex"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="s"/>
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
											<assignStatement>
												<argumentReferenceExpression name="value"/>
												<objectCreateExpression type="Guid">
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
												</objectCreateExpression>
											</assignStatement>
											<methodReturnStatement>
												<primitiveExpression value="true"/>
											</methodReturnStatement>
										</trueStatements>
										<falseStatements>
											<assignStatement>
												<variableReferenceExpression name="value"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="Guid"/>
												</propertyReferenceExpression>
											</assignStatement>
										</falseStatements>
									</conditionStatement>
									<methodReturnStatement>
										<propertyReferenceExpression name="Success">
											<variableReferenceExpression name="m"/>
										</propertyReferenceExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</xsl:if>
						<memberField type="MethodInfo[]" name="newRow"/>
						<memberField type="MethodInfo[]" name="prepareRow"/>
						<!-- property ResultSetArray -->
						<memberField type="IEnumerable" name="resultSetArray">
							<typeArguments>
								<typeReference type="System.Object"/>
							</typeArguments>
						</memberField>
						<memberProperty type="IEnumerable" name="ResultSetArray">
							<typeArguments>
								<typeReference type="System.object"/>
							</typeArguments>
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="resultSetArray"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="resultSetArray"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<propertySetValueReferenceExpression/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="ResultSet"/>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<variableDeclarationStatement type="DataTable" name="table">
											<init>
												<objectCreateExpression type="DataTable"/>
											</init>
										</variableDeclarationStatement>
										<usingStatement>
											<variable type="IEnumerator" name="enumerator">
												<typeArguments>
													<typeReference type="System.Object"/>
												</typeArguments>
												<init>
													<methodInvokeExpression methodName="GetEnumerator">
														<target>
															<propertySetValueReferenceExpression/>
														</target>
													</methodInvokeExpression>
												</init>
											</variable>
											<statements>
												<variableDeclarationStatement type="List" name="propertyList">
													<typeArguments>
														<typeReference type="PropertyInfo"/>
													</typeArguments>
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<whileStatement>
													<test>
														<methodInvokeExpression methodName="MoveNext">
															<target>
																<variableReferenceExpression name="enumerator"/>
															</target>
														</methodInvokeExpression>
													</test>
													<statements>
														<variableDeclarationStatement type="System.Object" name="instance">
															<init>
																<propertyReferenceExpression name="Current">
																	<variableReferenceExpression name="enumerator"/>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="instance"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityEquality">
																			<variableReferenceExpression name="propertyList"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="propertyList"/>
																			<objectCreateExpression type="List">
																				<typeArguments>
																					<typeReference type="PropertyInfo"/>
																				</typeArguments>
																			</objectCreateExpression>
																		</assignStatement>
																		<foreachStatement>
																			<variable type="PropertyInfo" name="pi"/>
																			<target>
																				<methodInvokeExpression methodName="GetProperties">
																					<target>
																						<methodInvokeExpression methodName="GetType">
																							<target>
																								<variableReferenceExpression name="instance"/>
																							</target>
																						</methodInvokeExpression>
																					</target>
																				</methodInvokeExpression>
																			</target>
																			<statements>
																				<variableDeclarationStatement type="Type" name="propertyType">
																					<init>
																						<propertyReferenceExpression name="PropertyType">
																							<variableReferenceExpression name="pi"/>
																						</propertyReferenceExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="BooleanAnd">
																							<binaryOperatorExpression operator="ValueEquality">
																								<propertyReferenceExpression name="Length">
																									<methodInvokeExpression methodName="GetIndexParameters">
																										<target>
																											<variableReferenceExpression name="pi"/>
																										</target>
																									</methodInvokeExpression>
																								</propertyReferenceExpression>
																								<primitiveExpression value="0"/>
																							</binaryOperatorExpression>
																							<methodInvokeExpression methodName="Equals">
																								<target>
																									<propertyReferenceExpression name="Namespace">
																										<variableReferenceExpression name="propertyType"/>
																									</propertyReferenceExpression>
																								</target>
																								<parameters>
																									<primitiveExpression value="System"/>
																								</parameters>
																							</methodInvokeExpression>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="Add">
																							<target>
																								<variableReferenceExpression name="propertyList"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="pi"/>
																							</parameters>
																						</methodInvokeExpression>
																						<conditionStatement>
																							<condition>
																								<propertyReferenceExpression name="IsGenericType">
																									<variableReferenceExpression name="propertyType"/>
																								</propertyReferenceExpression>
																							</condition>
																							<trueStatements>
																								<assignStatement>
																									<variableReferenceExpression name="propertyType"/>
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
																								</assignStatement>
																							</trueStatements>
																						</conditionStatement>
																						<methodInvokeExpression methodName="Add">
																							<target>
																								<propertyReferenceExpression name="Columns">
																									<variableReferenceExpression name="table"/>
																								</propertyReferenceExpression>
																							</target>
																							<parameters>
																								<propertyReferenceExpression name="Name">
																									<variableReferenceExpression name="pi"/>
																								</propertyReferenceExpression>
																								<variableReferenceExpression name="propertyType"/>
																							</parameters>
																						</methodInvokeExpression>
																					</trueStatements>
																				</conditionStatement>
																			</statements>
																		</foreachStatement>
																	</trueStatements>
																</conditionStatement>
																<variableDeclarationStatement type="DataRow" name="r">
																	<init>
																		<methodInvokeExpression methodName="NewRow">
																			<target>
																				<variableReferenceExpression name="table"/>
																			</target>
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
																			<propertyReferenceExpression name="Count">
																				<variableReferenceExpression name="propertyList"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</test>
																	<increment>
																		<variableReferenceExpression name="i"/>
																	</increment>
																	<statements>
																		<variableDeclarationStatement type="PropertyInfo" name="pi">
																			<init>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="propertyList"/>
																					</target>
																					<indices>
																						<variableReferenceExpression name="i"/>
																					</indices>
																				</arrayIndexerExpression>
																			</init>
																		</variableDeclarationStatement>
																		<variableDeclarationStatement type="System.Object" name="v">
																			<init>
																				<methodInvokeExpression methodName="GetValue">
																					<target>
																						<variableReferenceExpression name="pi"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="instance"/>
																						<primitiveExpression value="null"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
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
																						<typeReferenceExpression type="DBNull"/>
																					</propertyReferenceExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="r"/>
																				</target>
																				<indices>
																					<variableReferenceExpression name="i"/>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="v"/>
																		</assignStatement>
																	</statements>
																</forStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<propertyReferenceExpression name="Rows">
																			<variableReferenceExpression name="table"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="r"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</statements>
												</whileStatement>
											</statements>
										</usingStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Count">
														<propertyReferenceExpression name="Columns">
															<variableReferenceExpression name="table"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="ResultSet"/>
													<primitiveExpression value="null"/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<propertyReferenceExpression name="ResultSet"/>
													<variableReferenceExpression name="table"/>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
							</setStatements>
						</memberProperty>
						<!-- property ResultSetObject -->
						<memberProperty type="System.Object" name="ResultSetObject">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="resultSetArray"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="enumerator">
									<init>
										<methodInvokeExpression methodName="GetEnumerator">
											<target>
												<fieldReferenceExpression name="resultSetArray"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="MoveNext">
											<target>
												<variableReferenceExpression name="enumerator"/>
											</target>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Current">
												<variableReferenceExpression name="enumerator"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
									<falseStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</falseStatements>
								</conditionStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<propertyReferenceExpression name="ResultSetArray"/>
									<arrayCreateExpression >
										<createType type="System.Object"/>
										<initializers>
											<propertySetValueReferenceExpression/>
										</initializers>
									</arrayCreateExpression>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property EnableResultSet -->
						<memberProperty type="System.Boolean" name="EnableResultSet">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ResultSet -->
						<memberProperty type="DataTable" name="ResultSet">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="resultSet"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="resultSet">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<variableReferenceExpression name="value"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="EnableResultSet"/>
									<primitiveExpression value="true"/>
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
											<primitiveExpression value="BusinessRules_ResultSet"/>
										</indices>
									</arrayIndexerExpression>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<memberField type="DataTable" name="resultSet"/>
						<!-- property ResultSetSize -->
						<memberProperty type="System.Int32" name="ResultSetSize">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ResultSetCacheDuration -->
						<memberField type="System.Int32" name="resultSetCacheDuration"/>
						<memberProperty type="System.Int32" name="ResultSetCacheDuration">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="resultSetCacheDuration"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="resultSetCacheDuration">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="value"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="EnableResultSet"/>
									<primitiveExpression value="true"/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property ResultSetTableName -->
						<!--<memberProperty type="System.String" name="ResultSetTableName">
              <attributes public="true" final="true"/>
            </memberProperty>-->
						<!-- propert EnableEmailMessages -->
						<memberProperty type="System.Boolean" name="EnableEmailMessages">
							<attributes public="true" final="true"/>
						</memberProperty>
						<xsl:if test="$IsPremium='true'">
							<!-- property EmailMessages -->
							<memberField type="DataTable" name="emailMessages"/>
							<memberProperty type="DataTable" name="EmailMessages">
								<attributes public="true" final="true"/>
								<getStatements>
									<methodReturnStatement>
										<fieldReferenceExpression name="emailMessages"/>
									</methodReturnStatement>
								</getStatements>
								<setStatements>
									<assignStatement>
										<propertyReferenceExpression name="EnableEmailMessages"/>
										<primitiveExpression value="true"/>
									</assignStatement>
									<assignStatement>
										<fieldReferenceExpression name="emailMessages"/>
										<propertySetValueReferenceExpression/>
									</assignStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<propertySetValueReferenceExpression/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<foreachStatement>
												<variable type="DataRow" name="message" var="false"/>
												<target>
													<propertyReferenceExpression name="Rows">
														<propertySetValueReferenceExpression/>
													</propertyReferenceExpression>
												</target>
												<statements>
													<methodInvokeExpression methodName="Email">
														<parameters>
															<variableReferenceExpression name="message"/>
														</parameters>
													</methodInvokeExpression>
												</statements>
											</foreachStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<propertyReferenceExpression name="EnableEmailMessages"/>
										<primitiveExpression value="false"/>
									</assignStatement>
								</setStatements>
							</memberProperty>
						</xsl:if>
						<!-- property Config -->
						<memberProperty type="ControllerConfiguration" name="Config">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ControllerName -->
						<memberField type="System.String" name="controllerName"/>
						<memberProperty type="System.String" name="ControllerName">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="controllerName"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="controllerName"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property Row -->
						<memberField type="System.Object[]" name="row"/>
						<memberProperty type="System.Object[]" name="Row">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="row"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Request -->
						<memberField type="PageRequest" name="request"/>
						<memberProperty type="PageRequest" name="Request">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="request"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Page -->
						<memberProperty type="ViewPage" name="Page">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Context -->
						<memberProperty type="System.Web.HttpContext" name="Context">
							<attributes family="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<propertyReferenceExpression name="Current">
										<typeReferenceExpression type="System.Web.HttpContext"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property RowFilter -->
						<memberField type="RowFilterContext" name="rowFilter"/>
						<memberProperty type="RowFilterContext" name="RowFilter">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="rowFilter"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property LookupContextController -->
						<memberProperty type="System.String" name="LookupContextController">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="PageRequest"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="LookupContextController">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="PageRequest"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="DistinctValueRequest"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="LookupContextController">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="DistinctValueRequest"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property LookupContextView -->
						<memberProperty type="System.String" name="LookupContextView">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="PageRequest"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="LookupContextView">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="PageRequest"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="DistinctValueRequest"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="LookupContextView">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="DistinctValueRequest"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property LookupContextFieldName -->
						<memberProperty type="System.String" name="LookupContextFieldName">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="PageRequest"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="LookupContextFieldName">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="PageRequest"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="DistinctValueRequest"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="LookupContextFieldName">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="DistinctValueRequest"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method Localize(string, string) -->
						<memberMethod returnType="System.String" name="Localize">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="token"/>
								<parameter type="System.String" name="text"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Localizer"/>
										</target>
										<parameters>
											<primitiveExpression value="Controllers"/>
											<binaryOperatorExpression operator="Add">
												<propertyReferenceExpression name="ControllerName"/>
												<primitiveExpression value=".xml"/>
											</binaryOperatorExpression>
											<argumentReferenceExpression name="token"/>
											<argumentReferenceExpression name="text"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IsOverrideApplicable(string, string, string) -->
						<memberMethod returnType="System.Boolean" name="IsOverrideApplicable">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="virtualView"/>
							</parameters>
							<statements>
								<foreachStatement>
									<variable type="PropertyInfo" name="p"/>
									<target>
										<methodInvokeExpression methodName="GetProperties">
											<target>
												<methodInvokeExpression methodName="GetType"/>
											</target>
											<parameters>
												<binaryOperatorExpression operator="BitwiseOr">
													<binaryOperatorExpression operator="BitwiseOr">
														<propertyReferenceExpression name="Public">
															<typeReferenceExpression type="BindingFlags"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="NonPublic">
															<typeReferenceExpression type="BindingFlags"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
													<propertyReferenceExpression name="Instance">
														<typeReferenceExpression type="BindingFlags"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</parameters>
										</methodInvokeExpression>
									</target>
									<statements>
										<foreachStatement>
											<variable type="OverrideWhenAttribute" name="filter" var="false"/>
											<target>
												<methodInvokeExpression methodName="GetCustomAttributes">
													<target>
														<variableReferenceExpression name="p"/>
													</target>
													<parameters>
														<typeofExpression type="OverrideWhenAttribute"/>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="BooleanAnd">
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Controller">
																		<variableReferenceExpression name="filter"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="controller"/>
																</binaryOperatorExpression>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="View">
																		<variableReferenceExpression name="filter"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="view"/>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="ValueEquality">
																<propertyReferenceExpression name="VirtualView">
																	<variableReferenceExpression name="filter"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="virtualView"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.Object" name="v">
															<init>
																<methodInvokeExpression methodName="GetValue">
																	<target>
																		<variableReferenceExpression name="p"/>
																	</target>
																	<parameters>
																		<thisReferenceExpression/>
																		<primitiveExpression value="null"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<methodReturnStatement>
															<binaryOperatorExpression operator="BooleanAnd">
																<binaryOperatorExpression operator="IsTypeOf">
																	<variableReferenceExpression name="v"/>
																	<typeReferenceExpression type="System.Boolean"/>
																</binaryOperatorExpression>
																<castExpression targetType="System.Boolean">
																	<variableReferenceExpression name="v"/>
																</castExpression>
															</binaryOperatorExpression>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method FindRowHandler(PageRequest, RowKind) -->
						<memberMethod returnType="MethodInfo[]" name="FindRowHandler">
							<attributes final="true" private="true"/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="RowKind" name="kind"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="List" name="list">
									<typeArguments>
										<typeReference type="MethodInfo"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="MethodInfo"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="MethodInfo" name="method"/>
									<target>
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
									</target>
									<statements>
										<foreachStatement>
											<variable type="RowBuilderAttribute" name="filter" var="false"/>
											<target>
												<methodInvokeExpression methodName="GetCustomAttributes">
													<target>
														<variableReferenceExpression name="method"/>
													</target>
													<parameters>
														<typeofExpression type="RowBuilderAttribute"/>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="Kind">
																<variableReferenceExpression name="filter"/>
															</propertyReferenceExpression>
															<argumentReferenceExpression name="kind"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="BooleanOr">
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="Controller">
																				<argumentReferenceExpression name="request"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="Controller">
																				<variableReferenceExpression name="filter"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																		<methodInvokeExpression methodName="IsMatch">
																			<target>
																				<typeReferenceExpression type="Regex"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Controller">
																					<argumentReferenceExpression name="request"/>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="Controller">
																					<variableReferenceExpression name="filter"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="BooleanOr">
																		<unaryOperatorExpression operator="IsNullOrEmpty">
																			<propertyReferenceExpression name="View">
																				<variableReferenceExpression name="filter"/>
																			</propertyReferenceExpression>
																		</unaryOperatorExpression>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="View">
																				<argumentReferenceExpression name="request"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="View">
																				<variableReferenceExpression name="filter"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="list"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="method"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="list"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IRowHandler.SupportsNewRow(PageRequest) -->
						<memberMethod returnType ="System.Boolean" name="SupportsNewRow" privateImplementationType="IRowHandler">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="newRow"/>
									<methodInvokeExpression methodName="FindRowHandler">
										<parameters>
											<argumentReferenceExpression name="request"/>
											<propertyReferenceExpression name="New">
												<typeReferenceExpression type="RowKind"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="GreaterThan">
										<propertyReferenceExpression name="Length">
											<fieldReferenceExpression name="newRow"/>
										</propertyReferenceExpression>
										<primitiveExpression value="0"/>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IRowHandler.NewRow(PageRequest, ViewPage, object[]) -->
						<memberMethod name="NewRow" privateImplementationType="IRowHandler">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
								<parameter type="System.Object[]" name="row"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="newRow"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="request">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<argumentReferenceExpression name="request"/>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="page">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<argumentReferenceExpression name="page"/>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="row">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<argumentReferenceExpression name="row"/>
										</assignStatement>
										<foreachStatement>
											<variable type="MethodInfo" name="method"/>
											<target>
												<fieldReferenceExpression name="newRow"/>
											</target>
											<statements>
												<methodInvokeExpression methodName="Invoke">
													<target>
														<variableReferenceExpression name="method"/>
													</target>
													<parameters>
														<thisReferenceExpression/>
														<arrayCreateExpression>
															<createType type="System.Object"/>
														</arrayCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method IRowHandler.SupportsPrepareRow(PageRequest) -->
						<memberMethod returnType="System.Boolean" name="SupportsPrepareRow" privateImplementationType="IRowHandler">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="prepareRow"/>
									<methodInvokeExpression methodName="FindRowHandler">
										<parameters>
											<argumentReferenceExpression name="request"/>
											<propertyReferenceExpression name="Existing">
												<typeReferenceExpression type="RowKind"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="GreaterThan">
										<propertyReferenceExpression name="Length">
											<fieldReferenceExpression name="prepareRow"/>
										</propertyReferenceExpression>
										<primitiveExpression value="0"/>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IRowHandler.PrepareRow(PageRequest, ViewPage, object[]) -->
						<memberMethod name="PrepareRow" privateImplementationType="IRowHandler">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
								<parameter type="System.Object[]" name="row"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="prepareRow"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="request">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<argumentReferenceExpression name="request"/>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="page">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<argumentReferenceExpression name="page"/>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="row">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<argumentReferenceExpression name="row"/>
										</assignStatement>
										<foreachStatement>
											<variable type="MethodInfo" name="method"/>
											<target>
												<fieldReferenceExpression name="prepareRow"/>
											</target>
											<statements>
												<methodInvokeExpression methodName="Invoke">
													<target>
														<variableReferenceExpression name="method"/>
													</target>
													<parameters>
														<thisReferenceExpression/>
														<arrayCreateExpression>
															<createType type="System.Object"/>
														</arrayCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ProcessPageRequest(PageRequest, ViewPage) -->
						<memberMethod name="ProcessPageRequest">
							<attributes public="true" />
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
							</statements>
						</memberMethod>
						<!-- method ValueToList(string) -->
						<memberMethod returnType="List" name="ValueToList">
							<typeArguments>
								<typeReference type="System.String"/>
							</typeArguments>
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="v"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<argumentReferenceExpression name="v"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<objectCreateExpression type="List">
												<typeArguments>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
										<parameters>
											<methodInvokeExpression methodName="Split">
												<target>
													<argumentReferenceExpression name="v"/>
												</target>
												<parameters>
													<primitiveExpression value="," convertTo="Char"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SelectFieldValue(string) -->
						<memberMethod returnType="System.Object" name="SelectFieldValue">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="SelectFieldValue">
										<parameters>
											<argumentReferenceExpression name="name"/>
											<primitiveExpression value="true"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ListsAreEqual(List<string>, List<string>) -->
						<memberMethod returnType="System.Boolean" name="ListsAreEqual">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="List" name="list1">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
								</parameter>
								<parameter type="List" name="list2">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
								</parameter>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<propertyReferenceExpression name="Count">
												<argumentReferenceExpression name="list1"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="Count">
												<argumentReferenceExpression name="list2"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<foreachStatement>
									<variable type="System.String" name="s"/>
									<target>
										<argumentReferenceExpression name="list1"/>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Contains">
														<target>
															<argumentReferenceExpression name="list2"/>
														</target>
														<parameters>
															<variableReferenceExpression name="s"/>
														</parameters>
													</methodInvokeExpression>
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
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ListsAreEqual(string, string) -->
						<memberMethod returnType="System.Boolean" name="ListsAreEqual">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="list1"/>
								<parameter type="System.String" name="list2"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ListsAreEqual">
										<parameters>
											<methodInvokeExpression methodName="ValueToList">
												<parameters>
													<argumentReferenceExpression name="list1"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="ValueToList">
												<parameters>
													<argumentReferenceExpression name="list2"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SelectFieldValue(string, bool) -->
						<memberMethod returnType="System.Object" name="SelectFieldValue">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
								<parameter type="System.Boolean" name="useExternalValues"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Object" name="v">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<fieldReferenceExpression name="page"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="IdentityInequality">
												<fieldReferenceExpression name="row"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="v"/>
											<methodInvokeExpression methodName="SelectFieldValue">
												<target>
													<fieldReferenceExpression name="page"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="name"/>
													<fieldReferenceExpression name="row"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="Arguments"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable type="FieldValue" name="av"/>
													<target>
														<propertyReferenceExpression name="Values">
															<propertyReferenceExpression name="Arguments"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="Equals">
																	<target>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="av"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<argumentReferenceExpression name="name"/>
																		<propertyReferenceExpression name="InvariantCultureIgnoreCase">
																			<typeReferenceExpression type="StringComparison"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<methodReturnStatement>
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="av"/>
																	</propertyReferenceExpression>
																</methodReturnStatement>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="v"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<argumentReferenceExpression name="useExternalValues"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="v"/>
											<methodInvokeExpression methodName="SelectExternalFilterFieldValue">
												<parameters>
													<variableReferenceExpression name="name"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="v"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method BuildingDataRows() -->
						<memberMethod returnType="System.Boolean" name="BuildingDataRows">
							<attributes family="true" override="true"/>
							<statements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanAnd">
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="page"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="row"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SelectFieldValueObject(string) -->
						<memberMethod returnType="FieldValue" name="SelectFieldValueObject">
							<attributes public="true" override="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="FieldValue" name="result">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Arguments">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="result"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Arguments">
														<thisReferenceExpression/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<argumentReferenceExpression name="name"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="result"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<methodInvokeExpression methodName="BuildingDataRows"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="Request">
														<thisReferenceExpression/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="Inserting">
														<propertyReferenceExpression name="Request">
															<thisReferenceExpression/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="result"/>
											<methodInvokeExpression methodName="SelectFieldValueObject">
												<target>
													<fieldReferenceExpression name="page"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="name"/>
													<fieldReferenceExpression name="row"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<!--<conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <propertyReferenceExpression name="Arguments"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <foreachStatement >
                      <variable type="FieldValue" name="v"/>
                      <target>
                        <propertyReferenceExpression name="Values">
                          <propertyReferenceExpression name="Arguments"/>
                        </propertyReferenceExpression>
                      </target>
                      <statements>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="Equals">
                              <target>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="v"/>
                                </propertyReferenceExpression>
                              </target>
                              <parameters>
                                <argumentReferenceExpression name="name"/>
                                <propertyReferenceExpression name="InvariantCultureIgnoreCase">
                                  <typeReferenceExpression type="StringComparison"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <methodReturnStatement>
                              <variableReferenceExpression name="v"/>
                            </methodReturnStatement>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </foreachStatement>
                  </trueStatements>
                </conditionStatement>-->
									</trueStatements>
								</conditionStatement>
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
											<methodInvokeExpression methodName="SelectExternalFilterFieldValueObject">
												<parameters>
													<argumentReferenceExpression name="name"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method UpdateMasterFieldValue(string, object) -->
						<memberMethod name="UpdateMasterFieldValue">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
								<parameter type="System.Object" name="value"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Equals">
											<target>
												<propertyReferenceExpression name="Value">
													<typeReferenceExpression type="DBNull"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<argumentReferenceExpression name="value"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="value"/>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Result"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="fvo">
											<init>
												<objectCreateExpression type="FieldValue">
													<parameters>
														<argumentReferenceExpression name="name"/>
														<argumentReferenceExpression name="value"/>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="Scope">
												<variableReferenceExpression name="fvo"/>
											</propertyReferenceExpression>
											<primitiveExpression value="master"/>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Values">
													<propertyReferenceExpression name="Result"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="fvo"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method UpdateFieldValue(string, object) -->
						<memberMethod name="UpdateFieldValue">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
								<parameter type="System.Object" name="value"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Equals">
											<target>
												<propertyReferenceExpression name="Value">
													<typeReferenceExpression type="DBNull"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<argumentReferenceExpression name="value"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="value"/>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<fieldReferenceExpression name="page"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="IdentityInequality">
												<fieldReferenceExpression name="row"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="UpdateFieldValue">
											<target>
												<fieldReferenceExpression name="page"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="name"/>
												<fieldReferenceExpression name="row"/>
												<argumentReferenceExpression name="value"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="Result"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<propertyReferenceExpression name="Values">
															<propertyReferenceExpression name="Result"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<objectCreateExpression type="FieldValue">
															<parameters>
																<argumentReferenceExpression name="name"/>
																<argumentReferenceExpression name="value"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="Arguments"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="FieldValue" name="v">
													<init>
														<methodInvokeExpression methodName="SelectFieldValueObject">
															<parameters>
																<argumentReferenceExpression name="name"/>
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
														<assignStatement>
															<propertyReferenceExpression name="NewValue">
																<variableReferenceExpression name="v"/>
															</propertyReferenceExpression>
															<argumentReferenceExpression name="value"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Modified">
																<variableReferenceExpression name="v"/>
															</propertyReferenceExpression>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method SelectExternalFilterFieldValue(string) -->
						<memberMethod returnType="System.Object" name="SelectExternalFilterFieldValue">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="FieldValue" name="v">
									<init>
										<methodInvokeExpression methodName="SelectExternalFilterFieldValueObject">
											<parameters>
												<argumentReferenceExpression name="name"/>
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
										<methodReturnStatement>
											<propertyReferenceExpression name="Value">
												<variableReferenceExpression name="v"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SelectExternalFilterFieldValueObject(string) -->
						<memberMethod returnType="FieldValue" name="SelectExternalFilterFieldValueObject">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="FieldValue[]" name="values">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Request"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="values"/>
											<propertyReferenceExpression name="ExternalFilter">
												<propertyReferenceExpression name="Request"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="Arguments"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="values"/>
													<propertyReferenceExpression name="ExternalFilter">
														<propertyReferenceExpression name="Arguments"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="values"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="values"/>
											<fieldReferenceExpression name="requestExternalFilter">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="values"/>
											<primitiveExpression value="null"/>
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
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="values"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</test>
											<increment>
												<variableReferenceExpression name="i"/>
											</increment>
											<statements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Equals">
															<target>
																<propertyReferenceExpression name="Name">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="values"/>
																		</target>
																		<indices>
																			<variableReferenceExpression name="i"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<argumentReferenceExpression name="name"/>
																<propertyReferenceExpression name="InvariantCultureIgnoreCase">
																	<typeReferenceExpression type="StringComparison"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="values"/>
																</target>
																<indices>
																	<variableReferenceExpression name="i"/>
																</indices>
															</arrayIndexerExpression>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</forStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method PopulateManyToManyField(string, string, string, string, string)-->
						<memberMethod name="PopulateManyToManyField">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="System.String" name="primaryKeyField"/>
								<parameter type="System.String" name="targetController"/>
								<parameter type="System.String" name="targetForeignKey1"/>
								<parameter type="System.String" name="targetForeignKey2"/>
							</parameters>
							<statements>
								<comment>Deprecated in 8.5.9.0. See DataControllerBase.PopulateManyToManyFields()</comment>
							</statements>
						</memberMethod>
						<!-- method UpdateManyToManyField(string, string, string, string, string)-->
						<memberMethod name="UpdateManyToManyField">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="System.String" name="primaryKeyField"/>
								<parameter type="System.String" name="targetController"/>
								<parameter type="System.String" name="targetForeignKey1"/>
								<parameter type="System.String" name="targetForeignKey2"/>
							</parameters>
							<statements>
								<comment>Deprecated in 8.5.9.0. See DataControllerBase.ProcessManyToManyFields()</comment>
							</statements>
						</memberMethod>
						<!-- method ClearManyToManyField(string, string, string, string, string)-->
						<memberMethod name="ClearManyToManyField">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="System.String" name="primaryKeyField"/>
								<parameter type="System.String" name="targetController"/>
								<parameter type="System.String" name="targetForeignKey1"/>
								<parameter type="System.String" name="targetForeignKey2"/>
							</parameters>
							<statements>
								<comment>Deprecated in 8.5.9.0. See DataControllerBase.ProcessManyToManyFields()</comment>
							</statements>
						</memberMethod>
						<!-- method UpdateGeoFields()-->
						<memberMethod name="UpdateGeoFields">
							<attributes private="true"/>
							<statements>
								<variableDeclarationStatement type="XPathNodeIterator" name="geoFields">
									<init>
										<methodInvokeExpression methodName="Select">
											<target>
												<propertyReferenceExpression name="Config"/>
											</target>
											<parameters>
												<primitiveExpression value="/c:dataController/c:views/c:view[@id='{{0}}']/c:categories/c:category/c:dataFields/c:dataField[contains(@tag, 'geocode-')]"/>
												<propertyReferenceExpression name="View"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Count">
												<variableReferenceExpression name="geoFields"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<comment>build address</comment>
										<variableDeclarationStatement name="wasModified" type="System.Boolean">
											<init>
												<primitiveExpression value="false"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="latitudeField" type="System.String">
											<init>
												<stringEmptyExpression/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="longitudeField" type="System.String">
											<init>
												<stringEmptyExpression/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="values" type="Dictionary">
											<typeArguments>
												<typeReference type="System.String"/>
												<typeReference type="System.String"/>
											</typeArguments>
											<init>
												<objectCreateExpression type="Dictionary">
													<typeArguments>
														<typeReference type="System.String"/>
														<typeReference type="System.String"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="values"/>
											</target>
											<parameters>
												<primitiveExpression value="address"/>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="values"/>
											</target>
											<parameters>
												<primitiveExpression value="city"/>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="values"/>
											</target>
											<parameters>
												<primitiveExpression value="state"/>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="values"/>
											</target>
											<parameters>
												<primitiveExpression value="region"/>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="values"/>
											</target>
											<parameters>
												<primitiveExpression value="zip"/>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="values"/>
											</target>
											<parameters>
												<primitiveExpression value="country"/>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
										<foreachStatement>
											<variable type="XPathNavigator" name="nav" var="false"/>
											<target>
												<variableReferenceExpression name="geoFields"/>
											</target>
											<statements>
												<variableDeclarationStatement type="System.String" name="tag">
													<init>
														<methodInvokeExpression methodName="GetAttribute">
															<target>
																<variableReferenceExpression name="nav"/>
															</target>
															<parameters>
																<primitiveExpression value="tag"/>
																<stringEmptyExpression/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="fieldName">
													<init>
														<methodInvokeExpression methodName="GetAttribute">
															<target>
																<variableReferenceExpression name="nav"/>
															</target>
															<parameters>
																<primitiveExpression value="fieldName"/>
																<stringEmptyExpression/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="m" type="Match">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="tag"/>
																<primitiveExpression value="(\s|^)geocode-(?'Type'\w+)(\s|$)"/>
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
														<variableDeclarationStatement name="type" type="System.String">
															<init>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="m"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Type"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="type"/>
																	<primitiveExpression value="latitude"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="latitudeField"/>
																	<variableReferenceExpression name="fieldName"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="type"/>
																			<primitiveExpression value="longitude"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="longitudeField"/>
																			<variableReferenceExpression name="fieldName"/>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanOr">
																					<binaryOperatorExpression operator="ValueEquality">
																						<variableReferenceExpression name="type"/>
																						<primitiveExpression value="zipcode"/>
																					</binaryOperatorExpression>
																					<binaryOperatorExpression operator="ValueEquality">
																						<variableReferenceExpression name="type"/>
																						<primitiveExpression value="postalcode"/>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="type"/>
																					<primitiveExpression value="zip"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<variableDeclarationStatement name="fvo" type="FieldValue">
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
																					<variableReferenceExpression name="fvo"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<conditionStatement>
																					<condition>
																						<propertyReferenceExpression name="Modified">
																							<variableReferenceExpression name="fvo"/>
																						</propertyReferenceExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="wasModified"/>
																							<primitiveExpression value="true"/>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="values"/>
																						</target>
																						<indices>
																							<variableReferenceExpression name="type"/>
																						</indices>
																					</arrayIndexerExpression>
																					<convertExpression to="String">
																						<propertyReferenceExpression name="Value">
																							<variableReferenceExpression name="fvo"/>
																						</propertyReferenceExpression>
																					</convertExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<comment>geocode address</comment>
										<variableDeclarationStatement type="System.String" name="address">
											<init>
												<methodInvokeExpression methodName="Join">
													<target>
														<typeReferenceExpression type="System.String"/>
													</target>
													<parameters>
														<primitiveExpression value=","/>
														<methodInvokeExpression methodName="ToArray">
															<target>
																<methodInvokeExpression methodName="Distinct">
																	<target>
																		<propertyReferenceExpression name="Values">
																			<variableReferenceExpression name="values"/>
																		</propertyReferenceExpression>
																	</target>
																</methodInvokeExpression>
															</target>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<variableReferenceExpression name="wasModified"/>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<primitiveExpression value="address"/>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.Decimal" name="latitude"/>
												<variableDeclarationStatement type="System.Decimal" name="longitude"/>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Geocode">
															<parameters>
																<variableReferenceExpression name="address"/>
																<directionExpression direction="Out">
																	<variableReferenceExpression name="latitude"/>
																</directionExpression>
																<directionExpression direction="Out">
																	<variableReferenceExpression name="longitude"/>
																</directionExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<variableReferenceExpression name="latitudeField"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="UpdateFieldValue">
																	<parameters>
																		<variableReferenceExpression name="latitudeField"/>
																		<variableReferenceExpression name="latitude"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<variableReferenceExpression name="longitudeField"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="UpdateFieldValue">
																	<parameters>
																		<variableReferenceExpression name="longitudeField"/>
																		<variableReferenceExpression name="longitude"/>
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
						<!-- method Geocode(address, out latitude, out longitude)-->
						<memberMethod name="Geocode" returnType="System.Boolean">
							<comment>
								<![CDATA[
        /// <summary>
        /// Queries Google Geocode API for Latitude and Longitude of the requested Address.
        /// The Google Maps API Identifier must be defined within the Project Wizard.
        /// Please note the Google Maps APIs Terms of Service: https://developers.google.com/maps/premium/support#terms-of-use
        /// </summary>
        /// <param name="address">Address to query.</param>
        /// <param name="latitude">The returned Latitude. Will return 0 if request failed.</param>
        /// <param name="longitude">The returned Longitude. Will return 0 if request failed.</param>
        /// <returns>True if the geocode request succeeded.</returns>
        ]]>
							</comment>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="address"/>
								<parameter direction="Out" type="System.Decimal" name="latitude"/>
								<parameter direction="Out" type="System.Decimal" name="longitude"/>
							</parameters>
							<statements>
								<xsl:if test="$Host=''">
									<comment>send request</comment>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<stringFormatExpression format="https://maps.googleapis.com/maps/api/geocode/json?address={{0}}&amp;{{1}}">
														<methodInvokeExpression methodName="UrlEncode">
															<target>
																<typeReferenceExpression type="HttpUtility"/>
															</target>
															<parameters>
																<variableReferenceExpression name="address"/>
															</parameters>
														</methodInvokeExpression>
														<propertyReferenceExpression name="MapsApiIdentifier">
															<typeReferenceExpression type="ApplicationServices"/>
														</propertyReferenceExpression>
													</stringFormatExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="WebResponse" name="response">
										<init>
											<methodInvokeExpression methodName="GetResponse">
												<target>
													<variableReferenceExpression name="request"/>
												</target>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="json">
										<init>
											<stringEmptyExpression/>
										</init>
									</variableDeclarationStatement>
									<usingStatement>
										<variable type="StreamReader" name="sr">
											<init>
												<objectCreateExpression type="StreamReader">
													<parameters>
														<methodInvokeExpression methodName="GetResponseStream">
															<target>
																<variableReferenceExpression name="response"/>
															</target>
														</methodInvokeExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variable>
										<statements>
											<assignStatement>
												<variableReferenceExpression name="json"/>
												<methodInvokeExpression methodName="ReadToEnd">
													<target>
														<variableReferenceExpression name="sr"/>
													</target>
												</methodInvokeExpression>
											</assignStatement>
										</statements>
									</usingStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="json"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="Match" name="m">
												<init>
													<methodInvokeExpression methodName="Match">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<variableReferenceExpression name="json"/>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA["location"\s*:\s*{\s*"lat"\s*:\s(?'Latitude'-?\d+.\d+),\s*"lng"\s*:\s*(?'Longitude'-?\d+.\d+)]]></xsl:attribute>
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
													<assignStatement>
														<argumentReferenceExpression name="latitude"/>
														<methodInvokeExpression methodName="Parse">
															<target>
																<typeReferenceExpression type="System.Decimal"/>
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
																			<primitiveExpression value="Latitude"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
													<assignStatement>
														<argumentReferenceExpression name="longitude"/>
														<methodInvokeExpression methodName="Parse">
															<target>
																<typeReferenceExpression type="System.Decimal"/>
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
																			<primitiveExpression value="Longitude"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
													<methodReturnStatement>
														<primitiveExpression value="true"/>
													</methodReturnStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<assignStatement>
									<variableReferenceExpression name="latitude"/>
									<primitiveExpression value="0"/>
								</assignStatement>
								<assignStatement>
									<variableReferenceExpression name="longitude"/>
									<primitiveExpression value="0"/>
								</assignStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CalculateDistance(string origin, string destination)-->
						<memberMethod returnType="System.Int32" name="CalculateDistance">
							<comment>
								<![CDATA[
        /// <summary>
        /// Queries Google Distance Matrix API to fetch the estimated driving distance between the origin and destination.
        /// The Google Maps API Identifier must be defined within the Project Wizard.
        /// Please note the Google Maps APIs Terms of Service: https://developers.google.com/maps/premium/support#terms-of-use
        /// </summary>
        /// <param name="origin">The origin address.</param>
        /// <param name="destination">The destination address.</param>
        /// <returns>Returns the distance in meters. Will return 0 if the request has failed.</returns>]]>
							</comment>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="origin"/>
								<parameter type="System.String" name="destination"/>
							</parameters>
							<statements>
								<xsl:if test="$Host=''">
									<comment>send request</comment>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<stringFormatExpression format="https://maps.googleapis.com/maps/api/distancematrix/json?origins={{0}}&amp;destinations={{1}}&amp;{{2}}">
														<methodInvokeExpression methodName="UrlEncode">
															<target>
																<typeReferenceExpression type="HttpUtility"/>
															</target>
															<parameters>
																<variableReferenceExpression name="origin"/>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="UrlEncode">
															<target>
																<typeReferenceExpression type="HttpUtility"/>
															</target>
															<parameters>
																<variableReferenceExpression name="destination"/>
															</parameters>
														</methodInvokeExpression>
														<propertyReferenceExpression name="MapsApiIdentifier">
															<typeReferenceExpression type="ApplicationServices"/>
														</propertyReferenceExpression>
													</stringFormatExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="WebResponse" name="response">
										<init>
											<methodInvokeExpression methodName="GetResponse">
												<target>
													<variableReferenceExpression name="request"/>
												</target>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="json">
										<init>
											<stringEmptyExpression/>
										</init>
									</variableDeclarationStatement>
									<usingStatement>
										<variable type="StreamReader" name="sr">
											<init>
												<objectCreateExpression type="StreamReader">
													<parameters>
														<methodInvokeExpression methodName="GetResponseStream">
															<target>
																<variableReferenceExpression name="response"/>
															</target>
														</methodInvokeExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variable>
										<statements>
											<assignStatement>
												<variableReferenceExpression name="json"/>
												<methodInvokeExpression methodName="ReadToEnd">
													<target>
														<variableReferenceExpression name="sr"/>
													</target>
												</methodInvokeExpression>
											</assignStatement>
										</statements>
									</usingStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="json"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="Match" name="m">
												<init>
													<methodInvokeExpression methodName="Match">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<variableReferenceExpression name="json"/>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA["distance"\s*:\s*{\s*"text"\s*:\s*"[\w\d\s\.]+",\s*"value"\s+:\s+(?'Distance'\d+)\s*}]]></xsl:attribute>
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
													<methodReturnStatement>
														<methodInvokeExpression methodName="Parse">
															<target>
																<typeReferenceExpression type="System.Int32"/>
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
																			<primitiveExpression value="Distance"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</methodReturnStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<methodReturnStatement>
									<primitiveExpression value="0"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IDataFilter.Filter(SortedDictionary<string, string>) -->
						<memberMethod name="Filter" privateImplementationType="IDataFilter">
							<attributes/>
							<parameters>
								<parameter type="SortedDictionary" name="filter">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="System.Object"/>
									</typeArguments>
								</parameter>
							</parameters>
							<statements>
								<comment>do nothing</comment>
							</statements>
						</memberMethod>
						<!-- method IDataFilter2.Filter(string, string, SortedDictionary<string, string>) -->
						<memberMethod name="Filter" privateImplementationType="IDataFilter2">
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
							<statements>
								<methodInvokeExpression methodName="Filter">
									<target>
										<thisReferenceExpression/>
									</target>
									<parameters>
										<argumentReferenceExpression name="controller"/>
										<argumentReferenceExpression name="view"/>
										<argumentReferenceExpression name="filter"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method Filter(string, string, SortedDictionary<string, string>) -->
						<memberMethod name="Filter">
							<attributes family="true"/>
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
							<statements>
								<foreachStatement>
									<variable type="PropertyInfo" name="p"/>
									<target>
										<methodInvokeExpression methodName="GetProperties">
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
									</target>
									<statements>
										<foreachStatement>
											<variable type="RowFilterAttribute" name="rowFilter" var="false"/>
											<target>
												<methodInvokeExpression methodName="GetCustomAttributes">
													<target>
														<variableReferenceExpression name="p"/>
													</target>
													<parameters>
														<typeofExpression type="RowFilterAttribute"/>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="ValueEquality">
																<argumentReferenceExpression name="controller"/>
																<propertyReferenceExpression name="Controller">
																	<variableReferenceExpression name="rowFilter"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanOr">
																<unaryOperatorExpression operator="IsNullOrEmpty">
																	<propertyReferenceExpression name="View">
																		<variableReferenceExpression name="rowFilter"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
																<binaryOperatorExpression operator="ValueEquality">
																	<argumentReferenceExpression name="view"/>
																	<propertyReferenceExpression name="View">
																		<variableReferenceExpression name="rowFilter"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="Canceled">
																<propertyReferenceExpression name="RowFilter">
																	<thisReferenceExpression/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<primitiveExpression value="false"/>
														</assignStatement>
														<variableDeclarationStatement type="System.Object" name="v">
															<init>
																<methodInvokeExpression methodName="GetValue">
																	<target>
																		<variableReferenceExpression name="p"/>
																	</target>
																	<parameters>
																		<thisReferenceExpression/>
																		<primitiveExpression value="null"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="fieldName">
															<init>
																<propertyReferenceExpression name="FieldName">
																	<variableReferenceExpression name="rowFilter"/>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNullOrEmpty">
																	<variableReferenceExpression name="fieldName"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="fieldName"/>
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression>
																	<propertyReferenceExpression name="Canceled">
																		<propertyReferenceExpression name="RowFilter">
																			<thisReferenceExpression/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<methodInvokeExpression  methodName="IsInstanceOfType">
																				<target>
																					<typeofExpression type="System.Collections.IEnumerable"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="v"/>
																				</parameters>
																			</methodInvokeExpression>
																			<unaryOperatorExpression operator="Not">
																				<methodInvokeExpression methodName="IsInstanceOfType">
																					<target>
																						<typeofExpression type="String"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="v"/>
																					</parameters>
																				</methodInvokeExpression>
																			</unaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="StringBuilder" name="sb">
																			<init>
																				<objectCreateExpression type="StringBuilder"/>
																			</init>
																		</variableDeclarationStatement>
																		<foreachStatement>
																			<variable type="System.Object" name="item"/>
																			<target>
																				<castExpression targetType="System.Collections.IEnumerable">
																					<variableReferenceExpression name="v"/>
																				</castExpression>
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
																						<methodInvokeExpression methodName="AppendFormat">
																							<target>
																								<variableReferenceExpression name="sb"/>
																							</target>
																							<parameters>
																								<methodInvokeExpression methodName="OperationAsText">
																									<target>
																										<variableReferenceExpression name="rowFilter"/>
																									</target>
																								</methodInvokeExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</trueStatements>
																				</conditionStatement>
																				<methodInvokeExpression methodName="Append">
																					<target>
																						<variableReferenceExpression name="sb"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="item"/>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="Append">
																					<target>
																						<variableReferenceExpression name="sb"/>
																					</target>
																					<parameters>
																						<convertExpression to="Char">
																							<primitiveExpression value="0"/>
																						</convertExpression>
																						<!--<methodInvokeExpression methodName="ToChar">
                                              <target>
                                                <typeReferenceExpression type="Convert"/>
                                              </target>
                                              <parameters>
                                                <primitiveExpression value="0"/>
                                              </parameters>
                                            </methodInvokeExpression>-->
																					</parameters>
																				</methodInvokeExpression>
																			</statements>
																		</foreachStatement>
																		<assignStatement>
																			<variableReferenceExpression name="v"/>
																			<methodInvokeExpression methodName="ToString">
																				<target>
																					<variableReferenceExpression name="sb"/>
																				</target>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
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
																			<primitiveExpression value="null" convertTo="String"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<variableDeclarationStatement type="System.String" name="filterExpression">
																	<init>
																		<methodInvokeExpression methodName="Format">
																			<target>
																				<typeReferenceExpression type="String"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="{{0}}{{1}}"/>
																				<methodInvokeExpression methodName="OperationAsText">
																					<target>
																						<variableReferenceExpression name="rowFilter"/>
																					</target>
																				</methodInvokeExpression>
																				<variableReferenceExpression name="v"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="ContainsKey">
																				<target>
																					<argumentReferenceExpression name="filter"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="fieldName"/>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<argumentReferenceExpression name="filter"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="fieldName"/>
																				<variableReferenceExpression name="filterExpression"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<argumentReferenceExpression name="filter"/>
																				</target>
																				<indices>
																					<variableReferenceExpression name="fieldName"/>
																				</indices>
																			</arrayIndexerExpression>
																			<methodInvokeExpression methodName="Format">
																				<target>
																					<typeReferenceExpression type="String"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="{{0}}{{1}}{{2}}"/>
																					<arrayIndexerExpression>
																						<target>
																							<argumentReferenceExpression name="filter"/>
																						</target>
																						<indices>
																							<variableReferenceExpression name="fieldName"/>
																						</indices>
																					</arrayIndexerExpression>
																					<convertExpression to="Char">
																						<primitiveExpression value="0"/>
																					</convertExpression>
																					<!--<methodInvokeExpression methodName="ToChar">
                                            <target>
                                              <typeReferenceExpression type="Convert"/>
                                            </target>
                                            <parameters>
                                              <primitiveExpression value="0"/>
                                            </parameters>
                                          </methodInvokeExpression>-->
																					<variableReferenceExpression name="filterExpression"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
						<!-- method IDataFilter2.AssignContext(string, string, string, string, string) -->
						<memberMethod name="AssignContext" privateImplementationType="IDataFilter2">
							<attributes/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="lookupContextController"/>
								<parameter type="System.String" name="lookupContextView"/>
								<parameter type="System.String" name="lookupContextFieldName"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="rowFilter"/>
									<objectCreateExpression type="RowFilterContext">
										<parameters>
											<argumentReferenceExpression name="controller"/>
											<argumentReferenceExpression name="view"/>
											<argumentReferenceExpression name="lookupContextController"/>
											<argumentReferenceExpression name="lookupContextView"/>
											<argumentReferenceExpression name="lookupContextFieldName"/>
										</parameters>
									</objectCreateExpression>
								</assignStatement>
							</statements>
						</memberMethod>
						<!-- method LastEnteredValue(string, string) -->
						<memberMethod returnType="System.Object" name="LastEnteredValue" >
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="fieldName"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<propertyReferenceExpression name="Context"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="FieldValue[]" name="values">
									<init>
										<castExpression targetType="FieldValue[]">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Session">
														<propertyReferenceExpression name="Context"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<methodInvokeExpression methodName="Format">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<primitiveExpression value="{{0}}$LEVs"/>
															<argumentReferenceExpression name="controller"/>
														</parameters>
													</methodInvokeExpression>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="values"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="FieldValue" name="v"/>
											<target>
												<variableReferenceExpression name="values"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Equals">
															<target>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="v"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<argumentReferenceExpression name="fieldName"/>
																<propertyReferenceExpression name="InvariantCultureIgnoreCase">
																	<typeReferenceExpression type="StringComparison"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="v"/>
															</propertyReferenceExpression>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AssignDefaultPivotColumnValues() -->
						<!--<memberMethod name="AssignDefaultPivotColumnValues">
              <attributes public="true"/>
              <statements>
                <variableDeclarationStatement type="DataTable" name="pivotColumns">
                  <init>
                    <methodInvokeExpression methodName="EnumeratePivotColumns">
                      <target>
                        <propertyReferenceExpression name="Page"/>
                      </target>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement>
                  <variable type="DataField" name="field"/>
                  <target>
                    <propertyReferenceExpression name="Fields">
                      <propertyReferenceExpression name="Page"/>
                    </propertyReferenceExpression>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Pivot">
                            <variableReferenceExpression name="field"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="ColumnKey"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <variableDeclarationStatement type="Match" name="m">
                          <init>
                            <methodInvokeExpression methodName="Match">
                              <target>
                                <typeReferenceExpression type="Regex"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="field"/>
                                </propertyReferenceExpression>
                                <primitiveExpression value="^PivotCol(\d+)_(\w+)$"/>
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
                            <variableDeclarationStatement type="System.Int32" name="rowIndex">
                              <init>
                                <convertExpression to="Int32">
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
                                </convertExpression>
                                -->
						<!--<methodInvokeExpression methodName="ToInt32">
                                  <target>
                                    <typeReferenceExpression type="Convert"/>
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
                                </methodInvokeExpression>-->
						<!--
                              </init>
                            </variableDeclarationStatement>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="LessThan">
                                  <variableReferenceExpression name="rowIndex"/>
                                  <propertyReferenceExpression name="Count">
                                    <propertyReferenceExpression name="Rows">
                                      <variableReferenceExpression name="pivotColumns"/>
                                    </propertyReferenceExpression>
                                  </propertyReferenceExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <methodInvokeExpression methodName="UpdateFieldValue">
                                  <parameters>
                                    <propertyReferenceExpression name="Name">
                                      <variableReferenceExpression name="field"/>
                                    </propertyReferenceExpression>
                                    <arrayIndexerExpression>
                                      <target>
                                        <arrayIndexerExpression>
                                          <target>
                                            <propertyReferenceExpression name="Rows">
                                              <variableReferenceExpression name="pivotColumns"/>
                                            </propertyReferenceExpression>
                                          </target>
                                          <indices>
                                            <variableReferenceExpression name="rowIndex"/>
                                          </indices>
                                        </arrayIndexerExpression>
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
                                              <primitiveExpression value="2"/>
                                            </indices>
                                          </arrayIndexerExpression>
                                        </propertyReferenceExpression>
                                      </indices>
                                    </arrayIndexerExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </trueStatements>
                            </conditionStatement>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
              </statements>
            </memberMethod>-->
						<!-- method UserIsInRole(params string[]) -->
						<memberMethod returnType="System.Boolean" name="UserIsInRole">
							<attributes family="true" />
							<parameters>
								<parameter type="params System.String[]" name="rules"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="UserIsInRole">
										<target>
											<typeReferenceExpression type="DataControllerBase"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="rules"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<xsl:if test="$IsPremium='true'">
							<!-- method NodeSet() -->
							<memberMethod returnType="ControllerNodeSet" name="NodeSet">
								<comment>
									<![CDATA[
        /// <summary>
        /// Creates a controller node set to manipulate the XML definition of data controller.
        /// </summary>
        /// <returns>Returns an empty node set.</returns>
        ]]>
								</comment>
								<attributes public="true" final="true"/>
								<statements>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<propertyReferenceExpression name="Navigator"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<objectCreateExpression type="ControllerNodeSet">
													<parameters>
														<propertyReferenceExpression name="Navigator">
															<propertyReferenceExpression name="Config"/>
														</propertyReferenceExpression>
														<castExpression targetType="XmlNamespaceManager">
															<propertyReferenceExpression name="Resolver">
																<propertyReferenceExpression name="Config"/>
															</propertyReferenceExpression>
														</castExpression>
													</parameters>
												</objectCreateExpression>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<objectCreateExpression type="ControllerNodeSet">
											<parameters>
												<propertyReferenceExpression name="Navigator"/>
												<propertyReferenceExpression name="Resolver"/>
											</parameters>
										</objectCreateExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method NodeSet(string, params string[]) -->
							<memberMethod returnType="ControllerNodeSet" name="NodeSet">
								<comment>
									<![CDATA[
        /// <summary>
        /// Creates a controller node set matched to XPath selector. Controller node set allows manipulating the XML definition of data controller.
        /// </summary>
        ///<param name="selector">XPath expression evaluated against the definition of the data controller. May contain variables.</param>
        ///<param name="args">Optional values of variables. If variables are specified then the expression is evaluated for each variable or group of variables specified in the selector.</param>
        ///<example>field[@name=$name]</example>
        ///<returns>A node set containing selected data controller nodes.</returns>
        ]]>
								</comment>
								<attributes family="true" final="true"/>
								<parameters>
									<parameter type="System.String" name="selector"/>
									<parameter type="params System.String[]" name="args"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Select">
											<target>
												<objectCreateExpression type="ControllerNodeSet">
													<parameters>
														<propertyReferenceExpression name="Navigator"/>
														<propertyReferenceExpression name="Resolver"/>
													</parameters>
												</objectCreateExpression>
											</target>
											<parameters>
												<argumentReferenceExpression name="selector"/>
												<argumentReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- field applyAccessControlRule-->
							<memberField type="System.Boolean" name="applyAccessControlRule">
								<init>
									<primitiveExpression value="false"/>
								</init>
							</memberField>
							<!-- field accessControlRestrictions -->
							<memberField type="List" name="accessControlRestrictions">
								<typeArguments>
									<typeReference type="System.Object"/>
								</typeArguments>
							</memberField>
							<!-- field accessControlCommand -->
							<memberField type="DbCommand" name="accessControlCommand"/>
							<!-- method UnrestrictedAccess() -->
							<memberMethod name="UnrestrictedAccess">
								<attributes family="true" final="true"/>
								<statements>
									<assignStatement>
										<fieldReferenceExpression name="applyAccessControlRule"/>
										<primitiveExpression value="false"/>
									</assignStatement>
								</statements>
							</memberMethod>
							<!-- method RestrictAccess()-->
							<memberMethod name="RestrictAccess">
								<attributes family="true" final="true"/>
								<statements>
									<assignStatement>
										<fieldReferenceExpression name="applyAccessControlRule"/>
										<primitiveExpression value="true"/>
									</assignStatement>
								</statements>
							</memberMethod>
							<!-- method RestrictAccess(object )-->
							<memberMethod name="RestrictAccess">
								<attributes family="true" final="true"/>
								<parameters>
									<parameter type="System.Object" name="value"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="Add">
										<target>
											<fieldReferenceExpression name="accessControlRestrictions"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="value"/>
										</parameters>
									</methodInvokeExpression>
									<assignStatement>
										<fieldReferenceExpression name="applyAccessControlRule"/>
										<primitiveExpression value="true"/>
									</assignStatement>
								</statements>
							</memberMethod>
							<!-- method RestrictAccess(string, object) -->
							<memberMethod name="RestrictAccess">
								<attributes family="true" final="true"/>
								<parameters>
									<parameter type="System.String" name="parameterName"/>
									<parameter type="System.Object" name="value"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="DbParameter" name="parameter">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<foreachStatement>
										<variable type="DbParameter" name="p" var="false"/>
										<target>
											<propertyReferenceExpression name="Parameters">
												<fieldReferenceExpression name="accessControlCommand"/>
											</propertyReferenceExpression>
										</target>
										<statements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="ParameterName">
															<variableReferenceExpression name="p"/>
														</propertyReferenceExpression>
														<argumentReferenceExpression name="parameterName"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="parameter"/>
														<variableReferenceExpression name="p"/>
													</assignStatement>
													<breakStatement/>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="parameter"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="parameter"/>
												<methodInvokeExpression methodName="CreateParameter">
													<target>
														<fieldReferenceExpression name="accessControlCommand"/>
													</target>
												</methodInvokeExpression>
											</assignStatement>
											<assignStatement>
												<propertyReferenceExpression name="ParameterName">
													<variableReferenceExpression name="parameter"/>
												</propertyReferenceExpression>
												<argumentReferenceExpression name="parameterName"/>
											</assignStatement>
											<methodInvokeExpression methodName="Add">
												<target>
													<propertyReferenceExpression name="Parameters">
														<fieldReferenceExpression name="accessControlCommand"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="parameter"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<propertyReferenceExpression name="Value">
											<variableReferenceExpression name="parameter"/>
										</propertyReferenceExpression>
										<argumentReferenceExpression name="value"/>
									</assignStatement>
									<assignStatement>
										<fieldReferenceExpression name="applyAccessControlRule"/>
										<primitiveExpression value="true"/>
									</assignStatement>
								</statements>
							</memberMethod>
							<!-- field DynamicAccessControlRules -->
							<memberField type="AccessControlRuleDictionary" name="dynamicAccessControlRules"/>
							<!-- method CreateDynamicAccessControlAttribute(string) -->
							<memberMethod returnType="AccessControlAttribute" name="CreateDynamicAccessControlAttribute">
								<attributes final="true" private="true"/>
								<parameters>
									<parameter type="System.String" name="fieldName"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<fieldReferenceExpression name="dynamicAccessControlRules"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="dynamicAccessControlRules"/>
												<objectCreateExpression type="AccessControlRuleDictionary"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="AccessControlAttribute" name="a">
										<init>
											<objectCreateExpression type="AccessControlAttribute">
												<parameters>
													<argumentReferenceExpression name="fieldName"/>
												</parameters>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="List" name="attributes">
										<typeArguments>
											<typeReference type="AccessControlRule"/>
										</typeArguments>
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="TryGetValue">
													<target>
														<fieldReferenceExpression name="dynamicAccessControlRules"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="fieldName"/>
														<directionExpression direction="Out">
															<variableReferenceExpression name="attributes"/>
														</directionExpression>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="attributes"/>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="AccessControlRule"/>
													</typeArguments>
												</objectCreateExpression>
											</assignStatement>
											<methodInvokeExpression methodName="Add">
												<target>
													<fieldReferenceExpression name="dynamicAccessControlRules"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="fieldName"/>
													<variableReferenceExpression name="attributes"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="Add">
										<target>
											<variableReferenceExpression name="attributes"/>
										</target>
										<parameters>
											<objectCreateExpression type="AccessControlRule">
												<parameters>
													<variableReferenceExpression name="a"/>
													<primitiveExpression value="null"/>
												</parameters>
											</objectCreateExpression>
										</parameters>
									</methodInvokeExpression>
									<methodReturnStatement>
										<variableReferenceExpression name="a"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>

							<!-- method RegisterAccessControlRule(string, string, AccessPermission, params SqlParam[]) -->
							<memberMethod name="RegisterAccessControlRule">
								<comment>
									<![CDATA[
        /// <summary>
        /// Registers the access control rule that will be active only while processing the current request. 
        /// </summary>
        /// <param name="fieldName">The name of the data field that must be present in the data view for the rule to be activated.</param>
        /// <param name="sql">The arbitrary SQL expression that will filter data. Names of the data fields can be referenced if enclosed in square brackets.</param>
        /// <param name="permission">The permission to allow or deny access to data. Access control rules are combined according to this formula: (List of  “Allow” restrictions) and Not (List of “Deny” restrictions).</param>
        /// <param name="parameters">Properties of this object are converted into parameters matched by name to the parameter references in the expression specified as 'sql' argument of this method.</param>
                ]]>
								</comment>
								<attributes family="true" final="true"/>
								<parameters>
									<parameter type="System.String" name="fieldName"/>
									<parameter type="System.String" name="sql"/>
									<parameter type="AccessPermission" name="permission"/>
									<parameter type="System.Object" name="parameters"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="BusinessObjectParameters" name="paramList">
										<init>
											<objectCreateExpression type="BusinessObjectParameters"/>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="Assign">
										<target>
											<variableReferenceExpression name="paramList"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="parameters"/>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="List" name="sqlParamList">
										<typeArguments>
											<typeReference type="SqlParam"/>
										</typeArguments>
										<init>
											<objectCreateExpression type="List">
												<typeArguments>
													<typeReference type="SqlParam"/>
												</typeArguments>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<foreachStatement>
										<variable type="System.String" name="paramName"/>
										<target>
											<propertyReferenceExpression name="Keys">
												<variableReferenceExpression name="paramList"/>
											</propertyReferenceExpression>
										</target>
										<statements>
											<methodInvokeExpression methodName="Add">
												<target>
													<variableReferenceExpression name="sqlParamList"/>
												</target>
												<parameters>
													<objectCreateExpression type="SqlParam">
														<parameters>
															<variableReferenceExpression name="paramName"/>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="paramList"/>
																</target>
																<indices>
																	<variableReferenceExpression name="paramName"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</objectCreateExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</foreachStatement>
									<methodInvokeExpression methodName="RegisterAccessControlRule">
										<parameters>
											<argumentReferenceExpression name="fieldName"/>
											<argumentReferenceExpression name="sql"/>
											<argumentReferenceExpression name="permission"/>
											<methodInvokeExpression methodName="ToArray">
												<target>
													<variableReferenceExpression name="sqlParamList"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method RegisterAccessControlRule(string, string, AccessPermission, params SqlParam[]) -->
							<memberMethod name="RegisterAccessControlRule">
								<comment>
									<![CDATA[
        /// <summary>
        /// Registers the access control rule that will be active only while processing the current request. 
        /// </summary>
        /// <param name="fieldName">The name of the data field that must be present in the data view for the rule to be activated.</param>
        /// <param name="sql">The arbitrary SQL expression that will filter data. Names of the data fields can be referenced if enclosed in square brackets.</param>
        /// <param name="permission">The permission to allow or deny access to data. Access control rules are combined according to this formula: (List of  “Allow” restrictions) and Not (List of “Deny” restrictions).</param>
        /// <param name="parameters">Values of parameters references in SQL expression.</param>
                ]]>
								</comment>
								<attributes family="true" final="true"/>
								<parameters>
									<parameter type="System.String" name="fieldName"/>
									<parameter type="System.String" name="sql"/>
									<parameter type="AccessPermission" name="permission"/>
									<parameter type="params SqlParam[]" name="parameters"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="ContainsField">
													<target>
														<fieldReferenceExpression name="page"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="fieldName"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement/>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="AccessControlAttribute" name="a">
										<init>
											<methodInvokeExpression methodName="CreateDynamicAccessControlAttribute">
												<parameters>
													<argumentReferenceExpression name="fieldName"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Sql">
											<variableReferenceExpression name="a"/>
										</propertyReferenceExpression>
										<argumentReferenceExpression name="sql"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="Permission">
											<variableReferenceExpression name="a"/>
										</propertyReferenceExpression>
										<argumentReferenceExpression name="permission"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="Parameters">
											<variableReferenceExpression name="a"/>
										</propertyReferenceExpression>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="SqlParam"/>
											</typeArguments>
										</objectCreateExpression>
									</assignStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="Length">
													<argumentReferenceExpression name="parameters"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<usingStatement>
												<variable type="SqlText" name="query">
													<init>
														<objectCreateExpression type="SqlText">
															<parameters>
																<argumentReferenceExpression name="sql"/>
															</parameters>
														</objectCreateExpression>
													</init>
												</variable>
												<statements>
													<variableDeclarationStatement type="Match" name="m">
														<init>
															<methodInvokeExpression methodName="Match">
																<target>
																	<objectCreateExpression type="Regex">
																		<parameters>
																			<binaryOperatorExpression operator="Add">
																				<methodInvokeExpression methodName="Escape">
																					<target>
																						<typeReferenceExpression type="Regex"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="ParameterMarker">
																							<variableReferenceExpression name="query"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[([\w_]+)]]></xsl:attribute>
																				</primitiveExpression>
																			</binaryOperatorExpression>
																		</parameters>
																	</objectCreateExpression>
																</target>
																<parameters>
																	<argumentReferenceExpression name="sql"/>
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
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="Not">
																		<methodInvokeExpression methodName="Contains">
																			<target>
																				<propertyReferenceExpression name="Parameters">
																					<variableReferenceExpression name="query"/>
																				</propertyReferenceExpression>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Value">
																					<variableReferenceExpression name="m"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<methodInvokeExpression methodName="IsSystemSqlParameter">
																		<parameters>
																			<variableReferenceExpression name="query"/>
																			<propertyReferenceExpression name="Value">
																				<variableReferenceExpression name="m"/>
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
													<foreachStatement>
														<variable type="DbParameter" name="p" var="false"/>
														<target>
															<propertyReferenceExpression name="Parameters">
																<variableReferenceExpression name="query"/>
															</propertyReferenceExpression>
														</target>
														<statements>
															<methodInvokeExpression methodName="Add">
																<target>
																	<propertyReferenceExpression name="Parameters">
																		<variableReferenceExpression name="a"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<objectCreateExpression type="SqlParam">
																		<parameters>
																			<propertyReferenceExpression name="ParameterName">
																				<variableReferenceExpression name="p"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="Value">
																				<variableReferenceExpression name="p"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</objectCreateExpression>
																</parameters>
															</methodInvokeExpression>
														</statements>
													</foreachStatement>
												</statements>
											</usingStatement>
										</trueStatements>
										<falseStatements>
											<foreachStatement>
												<variable type="SqlParam" name="p"/>
												<target>
													<argumentReferenceExpression name="parameters"/>
												</target>
												<statements>
													<methodInvokeExpression methodName="Add">
														<target>
															<propertyReferenceExpression name="Parameters">
																<variableReferenceExpression name="a"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<variableReferenceExpression name="p"/>
														</parameters>
													</methodInvokeExpression>
												</statements>
											</foreachStatement>
										</falseStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method RegisterAccessControlRule(string, AccessPermission, params object[]) -->
							<memberMethod name="RegisterAccessControlRule">
								<comment>
									<![CDATA[
        /// <summary>
        /// Registers the access control rule that will be active only while processing the current request.
        /// </summary>
        /// <param name="fieldName">The name of the data field that must be present in the data view for the rule to be activated.</param>
        /// <param name="permission">The permission to allow or deny access to data. Access control rules are combined according to this formula: (List of  “Allow” restrictions) and Not (List of “Deny” restrictions).</param>
        /// <param name="values">The list of values that will be matched to the SQL expression corresponding to the name of the field triggering the activation of the access control rule.</param>
                ]]>
								</comment>
								<attributes family="true" final="true"/>
								<parameters>
									<parameter type="System.String" name="fieldName"/>
									<parameter type="AccessPermission" name="permission"/>
									<parameter type="params System.Object[]" name="values"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="ContainsField">
													<target>
														<fieldReferenceExpression name="page"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="fieldName"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement/>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="AccessControlAttribute" name="a">
										<init>
											<methodInvokeExpression methodName="CreateDynamicAccessControlAttribute">
												<parameters>
													<argumentReferenceExpression name="fieldName"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Permission">
											<variableReferenceExpression name="a"/>
										</propertyReferenceExpression>
										<argumentReferenceExpression name="permission"/>
									</assignStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<argumentReferenceExpression name="values"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<argumentReferenceExpression name="values"/>
												<arrayCreateExpression>
													<createType type="System.Object[]"/>
													<initializers>
														<primitiveExpression value="null"/>
													</initializers>
												</arrayCreateExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<propertyReferenceExpression name="Restrictions">
											<variableReferenceExpression name="a"/>
										</propertyReferenceExpression>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.Object"/>
											</typeArguments>
											<parameters>
												<argumentReferenceExpression name="values"/>
											</parameters>
										</objectCreateExpression>
									</assignStatement>
								</statements>
							</memberMethod>
							<!-- method EnumerateDynamicAccessControlRules(string) -->
							<memberMethod name="EnumerateDynamicAccessControlRules">
								<comment>
									<![CDATA[
        /// <summary>
        /// Enumerates the list of all access control rules that must be activated when processing the current request.
        /// </summary>
        /// <param name="controllerName">The name of the data controller that is requiring processing via the business rules.</param>
                ]]>
								</comment>
								<attributes family="true"/>
								<parameters>
									<parameter type="System.String" name="controllerName"/>
								</parameters>
								<statements>
									<xsl:if test="$IsPremium='true'">
										<comment>perform static access check and create "always false" data access control rule if permission to read is not granted.</comment>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="IsSystemController">
														<parameters>
															<argumentReferenceExpression name="controllerName"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="acl">
													<init>
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="AccessControlList"/>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="Enabled">
															<variableReferenceExpression name="acl"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<comment>deny access to data if "read" permission is not granted</comment>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="PermissionGranted">
																		<target>
																			<variableReferenceExpression name="acl"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Controller">
																				<typeReferenceExpression type="PermissionKind"/>
																			</propertyReferenceExpression>
																			<argumentReferenceExpression name="controllerName"/>
																			<primitiveExpression value="read"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="DataField" name="triggerField">
																	<init>
																		<primitiveExpression value="null"/>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="GreaterThan">
																			<propertyReferenceExpression name="Count">
																				<propertyReferenceExpression name="Fields">
																					<propertyReferenceExpression name="Page"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																			<primitiveExpression value="0"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="triggerField"/>
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Fields">
																						<variableReferenceExpression name="Page"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="0"/>
																				</indices>
																			</arrayIndexerExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<foreachStatement>
																	<variable name="field"/>
																	<target>
																		<propertyReferenceExpression name="Fields">
																			<propertyReferenceExpression name="Page"/>
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
																					<variableReferenceExpression name="triggerField"/>
																					<variableReferenceExpression name="field"/>
																				</assignStatement>
																				<breakStatement/>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
																<methodInvokeExpression methodName="RegisterAccessControlRule">
																	<parameters>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="triggerField"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="1=0"/>
																		<propertyReferenceExpression name="Allow">
																			<typeReferenceExpression type="AccessPermission"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<comment>register custom access rules</comment>
														<foreachStatement>
															<variable name="ap"/>
															<target>
																<propertyReferenceExpression name="AccessRules">
																	<variableReferenceExpression name="acl"/>
																</propertyReferenceExpression>
															</target>
															<statements>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="PermissionGranted">
																			<target>
																				<variableReferenceExpression name="acl"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Key">
																					<variableReferenceExpression name="ap"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="IsNotNullOrEmpty">
																					<propertyReferenceExpression name="Allow">
																						<propertyReferenceExpression name="Value">
																							<variableReferenceExpression name="ap"/>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="RegisterAccessControlRule">
																					<parameters>
																						<propertyReferenceExpression name="ParameterName">
																							<propertyReferenceExpression name="Value">
																								<variableReferenceExpression name="ap"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="Allow">
																							<propertyReferenceExpression name="Value">
																								<variableReferenceExpression name="ap"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="Allow">
																							<typeReferenceExpression type="AccessPermission"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																	<falseStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="IsNotNullOrEmpty">
																					<propertyReferenceExpression name="Deny">
																						<propertyReferenceExpression name="Value">
																							<variableReferenceExpression name="ap"/>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="RegisterAccessControlRule">
																					<parameters>
																						<propertyReferenceExpression name="ParameterName">
																							<propertyReferenceExpression name="Value">
																								<variableReferenceExpression name="ap"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="Deny">
																							<propertyReferenceExpression name="Value">
																								<variableReferenceExpression name="ap"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="Allow">
																							<typeReferenceExpression type="AccessPermission"/>
																						</propertyReferenceExpression>
																					</parameters>
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
									</xsl:if>
								</statements>
							</memberMethod>
							<!-- method CreateAppDacl(string) -->
							<memberMethod returnType="DynamicAccessControlList" name="CreateAppDacl">
								<attributes family="true"/>
								<parameters>
									<parameter type="System.String" name="controllerName"/>
								</parameters>
								<statements>
									<xsl:choose>
										<xsl:when test="$HostPath!=''">
											<methodReturnStatement>
												<objectCreateExpression type="DynamicAccessControlList"/>
											</methodReturnStatement>
										</xsl:when>
										<xsl:otherwise>
											<variableDeclarationStatement type="DynamicAccessControlList" name="dacl">
												<init>
													<castExpression targetType="DynamicAccessControlList">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Cache">
																	<propertyReferenceExpression name="Context"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="DynamicAccessControlList"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="dacl"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement type="System.String" name="rulesPath">
														<init>
															<methodInvokeExpression methodName="MapPath">
																<target>
																	<propertyReferenceExpression name="Server">
																		<propertyReferenceExpression name="Context"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="~/dacl"/>
																</parameters>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<assignStatement>
														<variableReferenceExpression name="dacl"/>
														<objectCreateExpression type="DynamicAccessControlList"/>
													</assignStatement>
													<variableDeclarationStatement type="System.String[]" name="files">
														<init>
															<primitiveExpression value="null"/>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="Exists">
																<target>
																	<typeReferenceExpression type="Directory"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="rulesPath"/>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="files"/>
																<methodInvokeExpression methodName="GetFiles">
																	<target>
																		<typeReferenceExpression type="Directory"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="rulesPath"/>
																		<primitiveExpression value="*.txt"/>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
															<foreachStatement>
																<variable type="System.String" name="fileName"/>
																<target>
																	<variableReferenceExpression name="files"/>
																</target>
																<statements>
																	<methodInvokeExpression methodName="Parse">
																		<target>
																			<variableReferenceExpression name="dacl"/>
																		</target>
																		<parameters>
																			<methodInvokeExpression methodName="GetFileName">
																				<target>
																					<typeReferenceExpression type="Path"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="fileName"/>
																				</parameters>
																			</methodInvokeExpression>
																			<methodInvokeExpression methodName="ReadAllText">
																				<target>
																					<typeReferenceExpression type="File"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="fileName"/>
																				</parameters>
																			</methodInvokeExpression>
																		</parameters>
																	</methodInvokeExpression>
																</statements>
															</foreachStatement>
														</trueStatements>
														<falseStatements>
															<assignStatement>
																<variableReferenceExpression name="files"/>
																<arrayCreateExpression>
																	<createType type="System.String"/>
																	<initializers>
																		<variableReferenceExpression name="rulesPath"/>
																	</initializers>
																</arrayCreateExpression>
															</assignStatement>
														</falseStatements>
													</conditionStatement>
													<methodInvokeExpression methodName="Add">
														<target>
															<propertyReferenceExpression name="Cache">
																<propertyReferenceExpression name="Context"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="DynamicAccessControlList"/>
															<variableReferenceExpression name="dacl"/>
															<objectCreateExpression type="CacheDependency">
																<parameters>
																	<variableReferenceExpression name="files"/>
																</parameters>
															</objectCreateExpression>
															<propertyReferenceExpression name="NoAbsoluteExpiration">
																<typeReferenceExpression type="Cache"/>
															</propertyReferenceExpression>
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
											<methodReturnStatement>
												<variableReferenceExpression name="dacl"/>
											</methodReturnStatement>
										</xsl:otherwise>
									</xsl:choose>
								</statements>
							</memberMethod>
							<!-- method CreateDbDacl(string) -->
							<xsl:if test="$PageImplementation='html'">
								<memberMethod returnType="DynamicAccessControlList" name="CreateDbDacl">
									<attributes family="true"/>
									<parameters>
										<parameter type="System.String" name="controllerName"/>
									</parameters>
									<statements>
										<variableDeclarationStatement type="DynamicAccessControlList" name="dacl">
											<init>
												<castExpression targetType="DynamicAccessControlList">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Items">
																<propertyReferenceExpression name="Context"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="DbDacl"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="dacl"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="dacl"/>
													<objectCreateExpression type="DynamicAccessControlList"/>
												</assignStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Items">
																<propertyReferenceExpression name="Context"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="DbDacl"/>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="dacl"/>
												</assignStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="IsSiteContentEnabled">
															<typeReferenceExpression type="ApplicationServices"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="SiteContentFileList" name="files">
															<init>
																<methodInvokeExpression methodName="ReadSiteContent">
																	<target>
																		<propertyReferenceExpression name="Current">
																			<typeReferenceExpression type="ApplicationServices"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="sys/dacl%"/>
																		<primitiveExpression value="%"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<foreachStatement>
															<variable type="SiteContentFile" name="f"/>
															<target>
																<variableReferenceExpression name="files"/>
															</target>
															<statements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<propertyReferenceExpression name="Data">
																				<variableReferenceExpression name="f"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Parse">
																			<target>
																				<variableReferenceExpression name="dacl"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="PhysicalName">
																					<variableReferenceExpression name="f"/>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="Text">
																					<variableReferenceExpression name="f"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<variableReferenceExpression name="dacl"/>
										</methodReturnStatement>
									</statements>
								</memberMethod>
							</xsl:if>
							<!-- method EnumerateRulesFromDACL(string)-->
							<memberMethod name="EnumerateRulesFromDACL">
								<attributes family="true"/>
								<parameters>
									<parameter type="System.String" name="controllerName"/>
								</parameters>
								<statements>
									<xsl:if test="$PageImplementation='html'">
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsSafeMode">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
									</xsl:if>
									<variableDeclarationStatement type="SortedDictionary" name="fields">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="DataField"/>
										</typeArguments>
										<init>
											<objectCreateExpression type="SortedDictionary">
												<typeArguments>
													<typeReference type="System.String"/>
													<typeReference type="DataField"/>
												</typeArguments>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<foreachStatement>
										<variable type="DataField" name="field"/>
										<target>
											<propertyReferenceExpression name="Fields">
												<fieldReferenceExpression name="page"/>
											</propertyReferenceExpression>
										</target>
										<statements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="fields"/>
													</target>
													<indices>
														<propertyReferenceExpression name="Name">
															<variableReferenceExpression name="field"/>
														</propertyReferenceExpression>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="field"/>
											</assignStatement>
										</statements>
									</foreachStatement>
									<comment>create DACL</comment>
									<variableDeclarationStatement type="DynamicAccessControlList" name="dacl">
										<init>
											<objectCreateExpression type="DynamicAccessControlList"/>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="AddRange">
										<target>
											<variableReferenceExpression name="dacl"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="CreateAppDacl">
												<parameters>
													<argumentReferenceExpression name="controllerName"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
									<xsl:if test="$PageImplementation='html'">
										<methodInvokeExpression methodName="AddRange">
											<target>
												<variableReferenceExpression name="dacl"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="CreateDbDacl">
													<parameters>
														<variableReferenceExpression name="controllerName"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</xsl:if>
									<comment>evaluate rules for this user</comment>
									<variableDeclarationStatement type="System.String" name="userName">
										<init>
											<stringEmptyExpression/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<propertyReferenceExpression name="User">
													<propertyReferenceExpression name="Context"/>
												</propertyReferenceExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="userName"/>
												<methodInvokeExpression methodName="ToLower">
													<target>
														<propertyReferenceExpression name="Name">
															<propertyReferenceExpression name="Identity">
																<propertyReferenceExpression name="User">
																	<propertyReferenceExpression name="Context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<foreachStatement>
										<variable type="DynamicAccessControlRule" name="r"/>
										<target>
											<variableReferenceExpression name="dacl"/>
										</target>
										<statements>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="ContainsKey">
														<target>
															<variableReferenceExpression name="fields"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Field">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="BooleanOr">
																<unaryOperatorExpression operator="IsNullOrEmpty">
																	<propertyReferenceExpression name="Controller">
																		<variableReferenceExpression name="r"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
																<methodInvokeExpression methodName="Equals">
																	<target>
																		<propertyReferenceExpression name="Controller">
																			<variableReferenceExpression name="r"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="controllerName"/>
																		<propertyReferenceExpression name="OrdinalIgnoreCase">
																			<typeReferenceExpression type="StringComparison"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="BooleanOr">
																		<binaryOperatorExpression operator="IdentityEquality">
																			<propertyReferenceExpression name="Tags">
																				<variableReferenceExpression name="r"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																		<methodInvokeExpression methodName="IsTagged">
																			<parameters>
																				<propertyReferenceExpression name="Tags">
																					<variableReferenceExpression name="r"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<conditionStatement>
																		<condition>
																			<binaryOperatorExpression operator="BooleanOr">
																				<binaryOperatorExpression operator="IdentityEquality">
																					<propertyReferenceExpression name="Users">
																						<variableReferenceExpression name="r"/>
																					</propertyReferenceExpression>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																				<binaryOperatorExpression operator="ValueInequality">
																					<methodInvokeExpression methodName="IndexOf">
																						<target>
																							<typeReferenceExpression type="Array"/>
																						</target>
																						<parameters>
																							<propertyReferenceExpression name="Users">
																								<variableReferenceExpression name="r"/>
																							</propertyReferenceExpression>
																							<variableReferenceExpression name="userName"/>
																						</parameters>
																					</methodInvokeExpression>
																					<primitiveExpression value="-1"/>
																				</binaryOperatorExpression>
																			</binaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<conditionStatement>
																				<condition>
																					<binaryOperatorExpression operator="BooleanOr">
																						<binaryOperatorExpression operator="IdentityEquality">
																							<propertyReferenceExpression name="Roles">
																								<variableReferenceExpression name="r"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="null"/>
																						</binaryOperatorExpression>
																						<methodInvokeExpression methodName="UserIsInRole">
																							<parameters>
																								<propertyReferenceExpression name="Roles">
																									<variableReferenceExpression name="r"/>
																								</propertyReferenceExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</binaryOperatorExpression>
																				</condition>
																				<trueStatements>
																					<conditionStatement>
																						<condition>
																							<binaryOperatorExpression operator="BooleanOr">
																								<binaryOperatorExpression operator="IdentityEquality">
																									<propertyReferenceExpression name="RoleExceptions">
																										<variableReferenceExpression name="r"/>
																									</propertyReferenceExpression>
																									<primitiveExpression value="null"/>
																								</binaryOperatorExpression>
																								<unaryOperatorExpression operator="Not">
																									<methodInvokeExpression methodName="UserIsInRole">
																										<parameters>
																											<propertyReferenceExpression name="RoleExceptions">
																												<variableReferenceExpression name="r"/>
																											</propertyReferenceExpression>
																										</parameters>
																									</methodInvokeExpression>
																								</unaryOperatorExpression>
																							</binaryOperatorExpression>
																						</condition>
																						<trueStatements>
																							<conditionStatement>
																								<condition>
																									<binaryOperatorExpression operator="BooleanOr">
																										<binaryOperatorExpression operator="IdentityEquality">
																											<propertyReferenceExpression name="UserExceptions">
																												<variableReferenceExpression name="r"/>
																											</propertyReferenceExpression>
																											<primitiveExpression value="null"/>
																										</binaryOperatorExpression>
																										<binaryOperatorExpression operator="ValueEquality">
																											<methodInvokeExpression methodName="IndexOf">
																												<target>
																													<typeReferenceExpression type="Array"/>
																												</target>
																												<parameters>
																													<propertyReferenceExpression name="UserExceptions">
																														<variableReferenceExpression name="r"/>
																													</propertyReferenceExpression>
																													<variableReferenceExpression name="userName"/>
																												</parameters>
																											</methodInvokeExpression>
																											<primitiveExpression value="-1"/>
																										</binaryOperatorExpression>
																									</binaryOperatorExpression>
																								</condition>
																								<trueStatements>
																									<conditionStatement>
																										<condition>
																											<unaryOperatorExpression operator="IsNotNullOrEmpty">
																												<propertyReferenceExpression name="AllowSql">
																													<variableReferenceExpression name="r"/>
																												</propertyReferenceExpression>
																											</unaryOperatorExpression>
																										</condition>
																										<trueStatements>
																											<methodInvokeExpression methodName="RegisterAccessControlRule">
																												<parameters>
																													<propertyReferenceExpression name="Field">
																														<variableReferenceExpression name="r"/>
																													</propertyReferenceExpression>
																													<propertyReferenceExpression name="AllowSql">
																														<variableReferenceExpression name="r"/>
																													</propertyReferenceExpression>
																													<propertyReferenceExpression name="Allow">
																														<typeReferenceExpression type="AccessPermission"/>
																													</propertyReferenceExpression>
																												</parameters>
																											</methodInvokeExpression>
																										</trueStatements>
																									</conditionStatement>
																									<conditionStatement>
																										<condition>
																											<unaryOperatorExpression operator="IsNotNullOrEmpty">
																												<propertyReferenceExpression name="DenySql">
																													<variableReferenceExpression name="r"/>
																												</propertyReferenceExpression>
																											</unaryOperatorExpression>
																										</condition>
																										<trueStatements>
																											<methodInvokeExpression methodName="RegisterAccessControlRule">
																												<parameters>
																													<propertyReferenceExpression name="Field">
																														<variableReferenceExpression name="r"/>
																													</propertyReferenceExpression>
																													<propertyReferenceExpression name="DenySql">
																														<variableReferenceExpression name="r"/>
																													</propertyReferenceExpression>
																													<propertyReferenceExpression name="Deny">
																														<typeReferenceExpression type="AccessPermission"/>
																													</propertyReferenceExpression>
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
								</statements>
							</memberMethod>
							<!-- method EnumerateAccessControlRules(DbCommand, string, string, ViewPage, SelectClauseDictionary) -->
							<memberMethod returnType="System.String" name="EnumerateAccessControlRules">
								<attributes public="true" final="true"/>
								<parameters>
									<parameter type="DbCommand" name="command"/>
									<parameter type="System.String" name="controllerName"/>
									<parameter type="System.String" name="parameterMarker"/>
									<parameter type="ViewPage" name="page"/>
									<parameter type="SelectClauseDictionary" name="expressions"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="AccessControlRuleDictionary" name="rules">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<foreachStatement>
										<variable type="MethodInfo" name="m"/>
										<target>
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
										</target>
										<statements>
											<foreachStatement>
												<variable type="AccessControlAttribute" name="accessControl" var="false"/>
												<target>
													<methodInvokeExpression methodName="GetCustomAttributes">
														<target>
															<variableReferenceExpression name="m"/>
														</target>
														<parameters>
															<typeofExpression type="AccessControlAttribute"/>
															<primitiveExpression value="true"/>
														</parameters>
													</methodInvokeExpression>
												</target>
												<statements>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="BooleanOr">
																<binaryOperatorExpression operator="BooleanOr">
																	<binaryOperatorExpression operator="ValueEquality">
																		<variableReferenceExpression name="controllerName"/>
																		<propertyReferenceExpression name="Controller">
																			<variableReferenceExpression name="accessControl"/>
																		</propertyReferenceExpression>
																	</binaryOperatorExpression>
																	<methodInvokeExpression methodName="IsMatch">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="controllerName"/>
																			<propertyReferenceExpression name="Controller">
																				<variableReferenceExpression name="accessControl"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
																<unaryOperatorExpression operator="IsNullOrEmpty">
																	<propertyReferenceExpression name="Controller">
																		<variableReferenceExpression name="accessControl"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<conditionStatement>
																<condition>
																	<methodInvokeExpression methodName="ContainsField">
																		<target>
																			<variableReferenceExpression name="page"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="FieldName">
																				<variableReferenceExpression name="accessControl"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</condition>
																<trueStatements>
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
																				<objectCreateExpression type="AccessControlRuleDictionary"/>
																			</assignStatement>
																		</trueStatements>
																	</conditionStatement>
																	<variableDeclarationStatement type="List" name="attributes">
																		<typeArguments>
																			<typeReference type="AccessControlRule"/>
																		</typeArguments>
																		<init>
																			<primitiveExpression value="null"/>
																		</init>
																	</variableDeclarationStatement>
																	<conditionStatement>
																		<condition>
																			<unaryOperatorExpression operator="Not">
																				<methodInvokeExpression methodName="TryGetValue">
																					<target>
																						<variableReferenceExpression name="rules"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="FieldName">
																							<variableReferenceExpression name="accessControl"/>
																						</propertyReferenceExpression>
																						<directionExpression direction="Out">
																							<variableReferenceExpression name="attributes"/>
																						</directionExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</unaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<assignStatement>
																				<variableReferenceExpression name="attributes"/>
																				<objectCreateExpression type="List">
																					<typeArguments>
																						<typeReference type="AccessControlRule"/>
																					</typeArguments>
																				</objectCreateExpression>
																			</assignStatement>
																			<methodInvokeExpression methodName="Add">
																				<target>
																					<variableReferenceExpression name="rules"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="FieldName">
																						<variableReferenceExpression name="accessControl"/>
																					</propertyReferenceExpression>
																					<variableReferenceExpression name="attributes"/>
																				</parameters>
																			</methodInvokeExpression>
																		</trueStatements>
																	</conditionStatement>
																	<methodInvokeExpression methodName="Add">
																		<target>
																			<variableReferenceExpression name="attributes"/>
																		</target>
																		<parameters>
																			<objectCreateExpression type="AccessControlRule">
																				<parameters>
																					<variableReferenceExpression name="accessControl"/>
																					<variableReferenceExpression name="m"/>
																				</parameters>
																			</objectCreateExpression>
																		</parameters>
																	</methodInvokeExpression>
																</trueStatements>
															</conditionStatement>
														</trueStatements>
													</conditionStatement>
												</statements>
											</foreachStatement>
										</statements>
									</foreachStatement>
									<assignStatement>
										<fieldReferenceExpression name="page">
											<thisReferenceExpression/>
										</fieldReferenceExpression>
										<argumentReferenceExpression name="page"/>
									</assignStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="Supports">
												<target>
													<methodInvokeExpression methodName="Create">
														<target>
															<typeReferenceExpression type="ApplicationServicesBase"/>
														</target>
													</methodInvokeExpression>
												</target>
												<parameters>
													<propertyReferenceExpression name="DynamicAccessControlList">
														<typeReferenceExpression type="ApplicationFeature"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="EnumerateRulesFromDACL">
												<parameters>
													<argumentReferenceExpression name="controllerName"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="EnumerateDynamicAccessControlRules">
										<parameters>
											<argumentReferenceExpression name="controllerName"/>
										</parameters>
									</methodInvokeExpression>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<fieldReferenceExpression name="dynamicAccessControlRules"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
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
														<fieldReferenceExpression name="dynamicAccessControlRules"/>
													</assignStatement>
												</trueStatements>
												<falseStatements>
													<foreachStatement>
														<variable type="System.String" name="fieldName"/>
														<target>
															<propertyReferenceExpression name="Keys">
																<fieldReferenceExpression name="dynamicAccessControlRules"/>
															</propertyReferenceExpression>
														</target>
														<statements>
															<conditionStatement>
																<condition>
																	<methodInvokeExpression methodName="ContainsField">
																		<target>
																			<argumentReferenceExpression name="page"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="fieldName"/>
																		</parameters>
																	</methodInvokeExpression>
																</condition>
																<trueStatements>
																	<variableDeclarationStatement type="List" name="attributes">
																		<typeArguments>
																			<typeReference type="AccessControlRule"/>
																		</typeArguments>
																		<init>
																			<primitiveExpression value="null"/>
																		</init>
																	</variableDeclarationStatement>
																	<conditionStatement>
																		<condition>
																			<unaryOperatorExpression operator="Not">
																				<methodInvokeExpression methodName="TryGetValue">
																					<target>
																						<variableReferenceExpression name="rules"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="fieldName"/>
																						<directionExpression direction="Out">
																							<variableReferenceExpression name="attributes"/>
																						</directionExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</unaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<assignStatement>
																				<variableReferenceExpression name="attributes"/>
																				<objectCreateExpression type="List">
																					<typeArguments>
																						<typeReference type="AccessControlRule"/>
																					</typeArguments>
																				</objectCreateExpression>
																			</assignStatement>
																			<methodInvokeExpression methodName="Add">
																				<target>
																					<variableReferenceExpression name="rules"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="fieldName"/>
																					<variableReferenceExpression name="attributes"/>
																				</parameters>
																			</methodInvokeExpression>
																		</trueStatements>
																	</conditionStatement>
																	<methodInvokeExpression methodName="AddRange">
																		<target>
																			<variableReferenceExpression name="attributes"/>
																		</target>
																		<parameters>
																			<arrayIndexerExpression>
																				<target>
																					<fieldReferenceExpression name="dynamicAccessControlRules"/>
																				</target>
																				<indices>
																					<variableReferenceExpression name="fieldName"/>
																				</indices>
																			</arrayIndexerExpression>
																		</parameters>
																	</methodInvokeExpression>
																</trueStatements>
															</conditionStatement>
														</statements>
													</foreachStatement>
												</falseStatements>
											</conditionStatement>
											<assignStatement>
												<fieldReferenceExpression name="dynamicAccessControlRules"/>
												<primitiveExpression value="null"/>
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
											<methodReturnStatement>
												<primitiveExpression value="null"/>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="StringBuilder" name="allowRules">
										<init>
											<objectCreateExpression type="StringBuilder"/>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="ProcessAccessControlList">
										<parameters>
											<variableReferenceExpression name="rules"/>
											<propertyReferenceExpression name="Allow">
												<typeReferenceExpression type="AccessPermission"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="allowRules"/>
											<argumentReferenceExpression name="command"/>
											<argumentReferenceExpression name="parameterMarker"/>
											<argumentReferenceExpression name="page"/>
											<argumentReferenceExpression name="expressions"/>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="StringBuilder" name="denyRules">
										<init>
											<objectCreateExpression type="StringBuilder"/>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="ProcessAccessControlList">
										<parameters>
											<variableReferenceExpression name="rules"/>
											<propertyReferenceExpression name="Deny">
												<typeReferenceExpression type="AccessPermission"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="denyRules"/>
											<argumentReferenceExpression name="command"/>
											<argumentReferenceExpression name="parameterMarker"/>
											<argumentReferenceExpression name="page"/>
											<argumentReferenceExpression name="expressions"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Clear">
										<target>
											<variableReferenceExpression name="rules"/>
										</target>
									</methodInvokeExpression>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="Length">
													<variableReferenceExpression name="allowRules"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="Length">
															<variableReferenceExpression name="denyRules"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodReturnStatement>
														<propertyReferenceExpression name="Empty">
															<typeReferenceExpression type="String"/>
														</propertyReferenceExpression>
													</methodReturnStatement>
												</trueStatements>
												<falseStatements>
													<methodReturnStatement>
														<methodInvokeExpression methodName="Format">
															<target>
																<typeReferenceExpression type="String"/>
															</target>
															<parameters>
																<primitiveExpression value="not({{0}})"/>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<variableReferenceExpression name="denyRules"/>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</methodReturnStatement>
												</falseStatements>
											</conditionStatement>
										</trueStatements>
										<falseStatements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="Length">
															<variableReferenceExpression name="denyRules"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodReturnStatement>
														<methodInvokeExpression methodName="ToString">
															<target>
																<variableReferenceExpression name="allowRules"/>
															</target>
														</methodInvokeExpression>
													</methodReturnStatement>
												</trueStatements>
												<falseStatements>
													<methodReturnStatement>
														<methodInvokeExpression methodName="Format">
															<target>
																<typeReferenceExpression type="String"/>
															</target>
															<parameters>
																<primitiveExpression value="({{0}})and not({{1}})"/>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<variableReferenceExpression name="allowRules"/>
																	</target>
																</methodInvokeExpression>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<variableReferenceExpression name="denyRules"/>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</methodReturnStatement>
												</falseStatements>
											</conditionStatement>
										</falseStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ValidateSql(string, SelectClauseDictionary) -->
							<memberField type="SelectClauseDictionary" name="expressions"/>
							<memberField type="Regex" name="FieldNameRegex">
								<attributes public="true" static="true"/>
								<init>
									<objectCreateExpression type="Regex">
										<parameters>
											<primitiveExpression value="\[(\w+)\]"/>
										</parameters>
									</objectCreateExpression>
								</init>
							</memberField>
							<memberField type="System.Boolean" name="sqlIsValid"/>
							<memberMethod returnType="System.String" name="ValidateSql">
								<attributes family="true" final="true"/>
								<parameters>
									<parameter type="System.String" name="sql"/>
									<parameter type="SelectClauseDictionary" name="expressions"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<argumentReferenceExpression name="sql"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<primitiveExpression value="null"/>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<fieldReferenceExpression name="expressions"/>
										<argumentReferenceExpression name="expressions"/>
									</assignStatement>
									<assignStatement>
										<fieldReferenceExpression name="sqlIsValid"/>
										<primitiveExpression value="true"/>
									</assignStatement>
									<assignStatement>
										<argumentReferenceExpression name="sql"/>
										<methodInvokeExpression methodName="Replace">
											<target>
												<propertyReferenceExpression name="FieldNameRegex"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="sql"/>
												<addressOfExpression>
													<methodReferenceExpression methodName="DoReplaceFieldNames"/>
												</addressOfExpression>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<fieldReferenceExpression name="sqlIsValid"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<primitiveExpression value="null"/>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<argumentReferenceExpression name="sql"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method DoReplaceFieldNames(Match) -->
							<memberMethod returnType="System.String" name="DoReplaceFieldNames">
								<attributes private="true" final="true"/>
								<parameters>
									<parameter type="Match" name="m"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="System.String" name="s">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<fieldReferenceExpression name="expressions"/>
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
																<primitiveExpression value="1"/>
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
										<falseStatements>
											<assignStatement>
												<fieldReferenceExpression name="sqlIsValid"/>
												<primitiveExpression value="false"/>
											</assignStatement>
										</falseStatements>
									</conditionStatement>
									<methodReturnStatement>
										<propertyReferenceExpression name="Value">
											<argumentReferenceExpression name="m"/>
										</propertyReferenceExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method ProcessAccessControlList(AccessControlRuleDictionary, AccessPermission, StringBuilder, DbCommand, string, ViewPage, SelectClauseDictionary) -->
							<memberField type="Regex" name="SelectDetectionRegex">
								<attributes public="true" static="true"/>
								<init>
									<objectCreateExpression type="Regex">
										<parameters>
											<primitiveExpression value="^\s*select\s+"/>
											<propertyReferenceExpression name="IgnoreCase">
												<typeReferenceExpression type="RegexOptions"/>
											</propertyReferenceExpression>
										</parameters>
									</objectCreateExpression>
								</init>
							</memberField>
							<memberMethod name="ProcessAccessControlList">
								<attributes private="true"/>
								<parameters>
									<parameter type="AccessControlRuleDictionary" name="rules"/>
									<parameter type="AccessPermission" name="permission"/>
									<parameter type="StringBuilder" name="sb"/>
									<parameter type="DbCommand" name="command"/>
									<parameter type="System.String" name="parameterMarker"/>
									<parameter type="ViewPage" name="page"/>
									<parameter type="SelectClauseDictionary" name="expressions"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="System.Boolean" name="firstField">
										<init>
											<primitiveExpression value="true"/>
										</init>
									</variableDeclarationStatement>
									<foreachStatement>
										<variable type="System.String" name="fieldName"/>
										<target>
											<propertyReferenceExpression name="Keys">
												<variableReferenceExpression name="rules"/>
											</propertyReferenceExpression>
										</target>
										<statements>
											<variableDeclarationStatement type="System.String" name="fieldExpression">
												<init>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="expressions"/>
														</target>
														<indices>
															<methodInvokeExpression methodName="ExpressionName">
																<target>
																	<methodInvokeExpression methodName="FindField">
																		<target>
																			<argumentReferenceExpression name="page"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="fieldName"/>
																		</parameters>
																	</methodInvokeExpression>
																</target>
															</methodInvokeExpression>
														</indices>
													</arrayIndexerExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="List" name="accessControlList">
												<typeArguments>
													<typeReference type="AccessControlRule"/>
												</typeArguments>
												<init>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="rules"/>
														</target>
														<indices>
															<variableReferenceExpression name="fieldName"/>
														</indices>
													</arrayIndexerExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="System.Boolean" name="firstRule">
												<init>
													<primitiveExpression value="true"/>
												</init>
											</variableDeclarationStatement>
											<foreachStatement>
												<variable type="AccessControlRule" name="info"/>
												<target>
													<variableReferenceExpression name="accessControlList"/>
												</target>
												<statements>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueEquality">
																<propertyReferenceExpression name="Permission">
																	<propertyReferenceExpression name="AccessControl">
																		<variableReferenceExpression name="info"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
																<argumentReferenceExpression name="permission"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<fieldReferenceExpression name="applyAccessControlRule">
																	<thisReferenceExpression/>
																</fieldReferenceExpression>
																<primitiveExpression value="false"/>
															</assignStatement>
															<assignStatement>
																<fieldReferenceExpression name="accessControlRestrictions">
																	<thisReferenceExpression/>
																</fieldReferenceExpression>
																<objectCreateExpression type="List">
																	<typeArguments>
																		<typeReference type="System.Object"/>
																	</typeArguments>
																</objectCreateExpression>
															</assignStatement>
															<assignStatement>
																<fieldReferenceExpression name="accessControlCommand">
																	<thisReferenceExpression/>
																</fieldReferenceExpression>
																<argumentReferenceExpression name="command"/>
															</assignStatement>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="IdentityEquality">
																		<propertyReferenceExpression name="Method">
																			<variableReferenceExpression name="info"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<conditionStatement>
																		<condition>
																			<binaryOperatorExpression operator="IdentityInequality">
																				<propertyReferenceExpression name="Restrictions">
																					<propertyReferenceExpression name="AccessControl">
																						<variableReferenceExpression name="info"/>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																				<primitiveExpression value="null"/>
																			</binaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<methodInvokeExpression methodName="AddRange">
																				<target>
																					<fieldReferenceExpression name="accessControlRestrictions"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="Restrictions">
																						<propertyReferenceExpression name="AccessControl">
																							<variableReferenceExpression name="info"/>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</trueStatements>
																		<falseStatements>
																			<conditionStatement>
																				<condition>
																					<binaryOperatorExpression operator="IdentityInequality">
																						<propertyReferenceExpression name="Parameters">
																							<propertyReferenceExpression name="AccessControl">
																								<variableReferenceExpression name="info"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																						<primitiveExpression value="null"/>
																					</binaryOperatorExpression>
																				</condition>
																				<trueStatements>
																					<foreachStatement>
																						<variable type="SqlParam" name="p"/>
																						<target>
																							<propertyReferenceExpression name="Parameters">
																								<propertyReferenceExpression name="AccessControl">
																									<variableReferenceExpression name="info"/>
																								</propertyReferenceExpression>
																							</propertyReferenceExpression>
																						</target>
																						<statements>
																							<methodInvokeExpression methodName="RestrictAccess">
																								<parameters>
																									<propertyReferenceExpression name="Name">
																										<variableReferenceExpression name="p"/>
																									</propertyReferenceExpression>
																									<propertyReferenceExpression name="Value">
																										<variableReferenceExpression name="p"/>
																									</propertyReferenceExpression>
																								</parameters>
																							</methodInvokeExpression>
																						</statements>
																					</foreachStatement>
																				</trueStatements>
																			</conditionStatement>
																		</falseStatements>
																	</conditionStatement>
																	<assignStatement>
																		<fieldReferenceExpression name="applyAccessControlRule"/>
																		<primitiveExpression value="true"/>
																	</assignStatement>
																</trueStatements>
																<falseStatements>
																	<methodInvokeExpression methodName="Invoke">
																		<target>
																			<propertyReferenceExpression name="Method">
																				<variableReferenceExpression name="info"/>
																			</propertyReferenceExpression>
																		</target>
																		<parameters>
																			<thisReferenceExpression/>
																			<arrayCreateExpression>
																				<createType type="System.Object"/>
																			</arrayCreateExpression>
																		</parameters>
																	</methodInvokeExpression>
																</falseStatements>
															</conditionStatement>
															<variableDeclarationStatement type="System.String" name="sql">
																<init>
																	<methodInvokeExpression methodName="ValidateSql">
																		<parameters>
																			<propertyReferenceExpression name="Sql">
																				<propertyReferenceExpression name="AccessControl">
																					<variableReferenceExpression name="info"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																			<argumentReferenceExpression name="expressions"/>
																		</parameters>
																	</methodInvokeExpression>
																</init>
															</variableDeclarationStatement>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="BooleanAnd">
																		<fieldReferenceExpression name="applyAccessControlRule">
																			<thisReferenceExpression/>
																		</fieldReferenceExpression>
																		<binaryOperatorExpression operator="BooleanOr">
																			<binaryOperatorExpression operator="GreaterThan">
																				<propertyReferenceExpression name="Count">
																					<fieldReferenceExpression name="accessControlRestrictions"/>
																				</propertyReferenceExpression>
																				<primitiveExpression value="0"/>
																			</binaryOperatorExpression>
																			<unaryOperatorExpression operator="IsNotNullOrEmpty">
																				<variableReferenceExpression name="sql"/>
																			</unaryOperatorExpression>
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
																			<methodInvokeExpression methodName="Append">
																				<target>
																					<argumentReferenceExpression name="sb"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="("/>
																				</parameters>
																			</methodInvokeExpression>
																		</trueStatements>
																		<falseStatements>
																			<conditionStatement>
																				<condition>
																					<variableReferenceExpression name="firstRule"/>
																				</condition>
																				<trueStatements>
																					<methodInvokeExpression methodName="Append">
																						<target>
																							<argumentReferenceExpression name="sb"/>
																						</target>
																						<parameters>
																							<primitiveExpression value="and"/>
																						</parameters>
																					</methodInvokeExpression>
																				</trueStatements>
																			</conditionStatement>
																		</falseStatements>
																	</conditionStatement>
																	<conditionStatement>
																		<condition>
																			<variableReferenceExpression name="firstRule"/>
																		</condition>
																		<trueStatements>
																			<assignStatement>
																				<variableReferenceExpression name="firstRule"/>
																				<primitiveExpression value="false"/>
																			</assignStatement>
																			<methodInvokeExpression methodName="Append">
																				<target>
																					<argumentReferenceExpression name="sb"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="("/>
																				</parameters>
																			</methodInvokeExpression>
																		</trueStatements>
																		<falseStatements>
																			<methodInvokeExpression methodName="Append">
																				<target>
																					<argumentReferenceExpression name="sb"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="or"/>
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
																	<conditionStatement>
																		<condition>
																			<unaryOperatorExpression operator="IsNotNullOrEmpty">
																				<variableReferenceExpression name="sql"/>
																			</unaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<conditionStatement>
																				<condition>
																					<methodInvokeExpression methodName="IsMatch">
																						<target>
																							<propertyReferenceExpression name="SelectDetectionRegex"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="sql"/>
																						</parameters>
																					</methodInvokeExpression>
																				</condition>
																				<trueStatements>
																					<methodInvokeExpression methodName="AppendFormat">
																						<target>
																							<argumentReferenceExpression name="sb"/>
																						</target>
																						<parameters>
																							<primitiveExpression value="{{0}} in({{1}})"/>
																							<variableReferenceExpression name="fieldExpression"/>
																							<variableReferenceExpression name="sql"/>
																						</parameters>
																					</methodInvokeExpression>
																				</trueStatements>
																				<falseStatements>
																					<methodInvokeExpression methodName="Append">
																						<target>
																							<argumentReferenceExpression name="sb"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="sql"/>
																						</parameters>
																					</methodInvokeExpression>
																				</falseStatements>
																			</conditionStatement>
																		</trueStatements>
																		<falseStatements>
																			<conditionStatement>
																				<condition>
																					<binaryOperatorExpression operator="GreaterThan">
																						<propertyReferenceExpression name="Count">
																							<fieldReferenceExpression name="accessControlRestrictions"/>
																						</propertyReferenceExpression>
																						<primitiveExpression value="1"/>
																					</binaryOperatorExpression>
																				</condition>
																				<trueStatements>
																					<variableDeclarationStatement type="System.Boolean" name="hasNull">
																						<init>
																							<primitiveExpression value="false"/>
																						</init>
																					</variableDeclarationStatement>
																					<variableDeclarationStatement type="System.Boolean" name="firstRestriction">
																						<init>
																							<primitiveExpression value="true"/>
																						</init>
																					</variableDeclarationStatement>
																					<foreachStatement>
																						<variable type="System.Object" name="item"/>
																						<target>
																							<fieldReferenceExpression name="accessControlRestrictions"/>
																						</target>
																						<statements>
																							<conditionStatement>
																								<condition>
																									<binaryOperatorExpression operator="BooleanOr">
																										<binaryOperatorExpression operator="IdentityEquality">
																											<variableReferenceExpression name="item"/>
																											<primitiveExpression value="null"/>
																										</binaryOperatorExpression>
																										<methodInvokeExpression methodName="Equals">
																											<target>
																												<propertyReferenceExpression name="Value">
																													<typeReferenceExpression type="DBNull"/>
																												</propertyReferenceExpression>
																											</target>
																											<parameters>
																												<variableReferenceExpression name="item"/>
																											</parameters>
																										</methodInvokeExpression>
																									</binaryOperatorExpression>
																								</condition>
																								<trueStatements>
																									<assignStatement>
																										<variableReferenceExpression name="hasNull"/>
																										<primitiveExpression value="true"/>
																									</assignStatement>
																								</trueStatements>
																								<falseStatements>
																									<conditionStatement>
																										<condition>
																											<variableReferenceExpression name="firstRestriction"/>
																										</condition>
																										<trueStatements>
																											<assignStatement>
																												<variableReferenceExpression name="firstRestriction"/>
																												<primitiveExpression value="false"/>
																											</assignStatement>
																											<methodInvokeExpression methodName="AppendFormat">
																												<target>
																													<argumentReferenceExpression name="sb"/>
																												</target>
																												<parameters>
																													<primitiveExpression value="{{0}} in("/>
																													<variableReferenceExpression name="fieldExpression"/>
																												</parameters>
																											</methodInvokeExpression>
																										</trueStatements>
																										<falseStatements>
																											<methodInvokeExpression methodName="Append">
																												<target>
																													<argumentReferenceExpression name="sb"/>
																												</target>
																												<parameters>
																													<primitiveExpression value=","/>
																												</parameters>
																											</methodInvokeExpression>
																										</falseStatements>
																									</conditionStatement>
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
																										<methodInvokeExpression methodName="Format">
																											<target>
																												<typeReferenceExpression type="String"/>
																											</target>
																											<parameters>
																												<primitiveExpression value="{{0}}p{{1}}"/>
																												<argumentReferenceExpression name="parameterMarker"/>
																												<propertyReferenceExpression name="Count">
																													<propertyReferenceExpression name="Parameters">
																														<argumentReferenceExpression name="command"/>
																													</propertyReferenceExpression>
																												</propertyReferenceExpression>
																											</parameters>
																										</methodInvokeExpression>
																									</assignStatement>
																									<assignStatement>
																										<propertyReferenceExpression name="Value">
																											<variableReferenceExpression name="p"/>
																										</propertyReferenceExpression>
																										<variableReferenceExpression name="item"/>
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
																									<methodInvokeExpression methodName="Append">
																										<target>
																											<argumentReferenceExpression name="sb"/>
																										</target>
																										<parameters>
																											<propertyReferenceExpression name="ParameterName">
																												<variableReferenceExpression name="p"/>
																											</propertyReferenceExpression>
																										</parameters>
																									</methodInvokeExpression>
																								</falseStatements>
																							</conditionStatement>
																						</statements>
																					</foreachStatement>
																					<conditionStatement>
																						<condition>
																							<unaryOperatorExpression operator="Not">
																								<variableReferenceExpression name="firstRestriction"/>
																							</unaryOperatorExpression>
																						</condition>
																						<trueStatements>
																							<methodInvokeExpression methodName="Append">
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
																							<variableReferenceExpression name="hasNull"/>
																						</condition>
																						<trueStatements>
																							<conditionStatement>
																								<condition>
																									<unaryOperatorExpression operator="Not">
																										<variableReferenceExpression name="firstRestriction"/>
																									</unaryOperatorExpression>
																								</condition>
																								<trueStatements>
																									<methodInvokeExpression methodName="AppendFormat">
																										<target>
																											<argumentReferenceExpression name="sb"/>
																										</target>
																										<parameters>
																											<primitiveExpression value="or {{0}}"/>
																											<variableReferenceExpression name="fieldExpression"/>
																										</parameters>
																									</methodInvokeExpression>
																								</trueStatements>
																								<falseStatements>
																									<methodInvokeExpression methodName="Append">
																										<target>
																											<variableReferenceExpression name="sb"/>
																										</target>
																										<parameters>
																											<variableReferenceExpression name="fieldExpression"/>
																										</parameters>
																									</methodInvokeExpression>
																								</falseStatements>
																							</conditionStatement>
																							<methodInvokeExpression methodName="Append">
																								<target>
																									<argumentReferenceExpression name="sb"/>
																								</target>
																								<parameters>
																									<primitiveExpression value=" is null"/>
																								</parameters>
																							</methodInvokeExpression>
																						</trueStatements>
																					</conditionStatement>
																				</trueStatements>
																				<falseStatements>
																					<variableDeclarationStatement type="System.Object" name="item">
																						<init>
																							<arrayIndexerExpression>
																								<target>
																									<fieldReferenceExpression name="accessControlRestrictions"/>
																								</target>
																								<indices>
																									<primitiveExpression value="0"/>
																								</indices>
																							</arrayIndexerExpression>
																						</init>
																					</variableDeclarationStatement>
																					<conditionStatement>
																						<condition>
																							<binaryOperatorExpression operator="BooleanOr">
																								<binaryOperatorExpression operator="IdentityEquality">
																									<variableReferenceExpression name="item"/>
																									<primitiveExpression value="null"/>
																								</binaryOperatorExpression>
																								<methodInvokeExpression methodName="Equals">
																									<target>
																										<propertyReferenceExpression name="Value">
																											<typeReferenceExpression type="DBNull"/>
																										</propertyReferenceExpression>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="item"/>
																									</parameters>
																								</methodInvokeExpression>
																							</binaryOperatorExpression>
																						</condition>
																						<trueStatements>
																							<methodInvokeExpression methodName="AppendFormat">
																								<target>
																									<variableReferenceExpression name="sb"/>
																								</target>
																								<parameters>
																									<primitiveExpression value="{{0}} is null"/>
																									<variableReferenceExpression name="fieldExpression"/>
																								</parameters>
																							</methodInvokeExpression>
																						</trueStatements>
																						<falseStatements>
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
																								<methodInvokeExpression methodName="Format">
																									<target>
																										<typeReferenceExpression type="String"/>
																									</target>
																									<parameters>
																										<primitiveExpression value="{{0}}p{{1}}"/>
																										<argumentReferenceExpression name="parameterMarker"/>
																										<propertyReferenceExpression name="Count">
																											<propertyReferenceExpression name="Parameters">
																												<argumentReferenceExpression name="command"/>
																											</propertyReferenceExpression>
																										</propertyReferenceExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</assignStatement>
																							<assignStatement>
																								<propertyReferenceExpression name="Value">
																									<variableReferenceExpression name="p"/>
																								</propertyReferenceExpression>
																								<variableReferenceExpression name="item"/>
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
																							<methodInvokeExpression methodName="AppendFormat">
																								<target>
																									<argumentReferenceExpression name="sb"/>
																								</target>
																								<parameters>
																									<primitiveExpression value="{{0}}={{1}}"/>
																									<variableReferenceExpression name="fieldExpression"/>
																									<propertyReferenceExpression name="ParameterName">
																										<variableReferenceExpression name="p"/>
																									</propertyReferenceExpression>
																								</parameters>
																							</methodInvokeExpression>
																						</falseStatements>
																					</conditionStatement>
																				</falseStatements>
																			</conditionStatement>
																		</falseStatements>
																	</conditionStatement>
																	<methodInvokeExpression methodName="Append">
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
																<fieldReferenceExpression name="accessControlCommand"/>
																<primitiveExpression value="null"/>
															</assignStatement>
															<methodInvokeExpression methodName="Clear">
																<target>
																	<fieldReferenceExpression name="accessControlRestrictions"/>
																</target>
															</methodInvokeExpression>
														</trueStatements>
													</conditionStatement>
												</statements>
											</foreachStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="Not">
														<variableReferenceExpression name="firstRule"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="Append">
														<target>
															<argumentReferenceExpression name="sb"/>
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
											<unaryOperatorExpression operator="Not">
												<variableReferenceExpression name="firstField"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Append">
												<target>
													<argumentReferenceExpression name="sb"/>
												</target>
												<parameters>
													<primitiveExpression value=")"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method SupportsVirtualization(string) -->
							<memberMethod returnType="System.Boolean" name="SupportsVirtualization">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="controllerName"/>
								</parameters>
								<statements>
									<xsl:if test="$IsPremium='true'">
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="IsSystemController">
															<parameters>
																<argumentReferenceExpression name="controllerName"/>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
													<propertyReferenceExpression name="Enabled">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="AccessControlList"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="true"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</xsl:if>
									<methodReturnStatement>
										<xsl:choose>
											<xsl:when test="$HostPath='' and $PageImplementation='html'">
												<propertyReferenceExpression name="IsSiteContentEnabled">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</xsl:when>
											<xsl:otherwise>
												<primitiveExpression value="false"/>
											</xsl:otherwise>
										</xsl:choose>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- property Navigator -->
							<memberProperty type="XPathNavigator" name="Navigator">
								<attributes final="true" family="true"/>
							</memberProperty>
							<!-- property Resolver -->
							<memberProperty type="XmlNamespaceManager" name="Resolver">
								<attributes final="true" family="true"/>
							</memberProperty>
							<!-- method VirtualizeController(string) -->
							<memberMethod name="VirtualizeController">
								<attributes family="true"/>
								<parameters>
									<parameter type="System.String" name="controllerName"/>
								</parameters>
								<xsl:if test="$IsPremium='true'">
									<statements>
										<comment>remove corresponding actions if persmissions (create|update|delete) are not not granted</comment>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="IsSystemController">
														<parameters>
															<argumentReferenceExpression name="controllerName"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="acl">
													<init>
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="AccessControlList"/>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="Enabled">
															<variableReferenceExpression name="acl"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="PermissionGranted">
																		<target>
																			<variableReferenceExpression name="acl"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Controller">
																				<typeReferenceExpression type="PermissionKind"/>
																			</propertyReferenceExpression>
																			<argumentReferenceExpression name="controllerName"/>
																			<primitiveExpression value="create"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Delete">
																	<target>
																		<methodInvokeExpression methodName="SelectActions">
																			<target>
																				<methodInvokeExpression methodName="NodeSet"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="New"/>
																				<primitiveExpression value="Duplicate"/>
																				<primitiveExpression value="Insert"/>
																				<primitiveExpression value="Import"/>
																			</parameters>
																		</methodInvokeExpression>
																	</target>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="PermissionGranted">
																		<target>
																			<variableReferenceExpression name="acl"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Controller">
																				<typeReferenceExpression type="PermissionKind"/>
																			</propertyReferenceExpression>
																			<argumentReferenceExpression name="controllerName"/>
																			<primitiveExpression value="update"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Delete">
																	<target>
																		<methodInvokeExpression methodName="SelectActions">
																			<target>
																				<methodInvokeExpression methodName="NodeSet"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="Edit"/>
																				<primitiveExpression value="Update"/>
																				<primitiveExpression value="BatchEdit"/>
																			</parameters>
																		</methodInvokeExpression>
																	</target>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="PermissionGranted">
																		<target>
																			<variableReferenceExpression name="acl"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Controller">
																				<typeReferenceExpression type="PermissionKind"/>
																			</propertyReferenceExpression>
																			<argumentReferenceExpression name="controllerName"/>
																			<primitiveExpression value="delete"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Delete">
																	<target>
																		<methodInvokeExpression methodName="SelectActions">
																			<target>
																				<methodInvokeExpression methodName="NodeSet"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="Delete"/>
																			</parameters>
																		</methodInvokeExpression>
																	</target>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<comment>prevent "create new" for lookups based on data controllers</comment>
														<variableDeclarationStatement name="lookupIterator">
															<init>
																<methodInvokeExpression methodName="Select">
																	<target>
																		<propertyReferenceExpression name="Navigator"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="/c:dataController/c:fields/c:field/c:items[@dataController!='']"/>
																		<propertyReferenceExpression name="Resolver"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<whileStatement>
															<test>
																<methodInvokeExpression methodName="MoveNext">
																	<target>
																		<variableReferenceExpression name="lookupIterator"/>
																	</target>
																</methodInvokeExpression>
															</test>
															<statements>
																<variableDeclarationStatement name="lookupController">
																	<init>
																		<methodInvokeExpression methodName="GetAttribute">
																			<target>
																				<propertyReferenceExpression name="Current">
																					<variableReferenceExpression name="lookupIterator"/>
																				</propertyReferenceExpression>
																			</target>
																			<parameters>
																				<primitiveExpression value="dataController"/>
																				<stringEmptyExpression/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="newDataView">
																	<init>
																		<methodInvokeExpression methodName="SelectSingleNode">
																			<target>
																				<propertyReferenceExpression name="Current">
																					<variableReferenceExpression name="lookupIterator"/>
																				</propertyReferenceExpression>
																			</target>
																			<parameters>
																				<primitiveExpression value="@newDataView"/>
																				<propertyReferenceExpression name="Resolver"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<binaryOperatorExpression operator="BooleanAnd">
																				<binaryOperatorExpression operator="IdentityInequality">
																					<variableReferenceExpression name="newDataView"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																				<unaryOperatorExpression operator="IsNotNullOrEmpty">
																					<propertyReferenceExpression name="Value">
																						<variableReferenceExpression name="newDataView"/>
																					</propertyReferenceExpression>
																				</unaryOperatorExpression>
																			</binaryOperatorExpression>
																			<unaryOperatorExpression operator="Not">
																				<methodInvokeExpression methodName="PermissionGranted">
																					<target>
																						<variableReferenceExpression name="acl"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="Controller">
																							<typeReferenceExpression type="PermissionKind"/>
																						</propertyReferenceExpression>
																						<primitiveExpression value="create"/>
																					</parameters>
																				</methodInvokeExpression>
																			</unaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="SetValue">
																			<target>
																				<variableReferenceExpression name="newDataView"/>
																			</target>
																			<parameters>
																				<stringEmptyExpression/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</whileStatement>
														<comment> apply custom permissions</comment>
														<foreachStatement>
															<variable name="alteration"/>
															<target>
																<propertyReferenceExpression name="Alterations">
																	<variableReferenceExpression name="acl"/>
																</propertyReferenceExpression>
															</target>
															<statements>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="IsMatch">
																			<target>
																				<propertyReferenceExpression name="Value">
																					<variableReferenceExpression name="alteration"/>
																				</propertyReferenceExpression>
																			</target>
																			<parameters>
																				<argumentReferenceExpression name="controllerName"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="PermissionGranted">
																					<target>
																						<variableReferenceExpression name="acl"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="Key">
																							<variableReferenceExpression name="alteration"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<conditionStatement>
																					<condition>
																						<unaryOperatorExpression operator="IsNotNullOrEmpty">
																							<propertyReferenceExpression name="Allow">
																								<propertyReferenceExpression name="Value">
																									<variableReferenceExpression name="alteration"/>
																								</propertyReferenceExpression>
																							</propertyReferenceExpression>
																						</unaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="AlterControllerWith">
																							<parameters>
																								<propertyReferenceExpression name="Allow">
																									<propertyReferenceExpression name="Value">
																										<variableReferenceExpression name="alteration"/>
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
																						<unaryOperatorExpression operator="IsNotNullOrEmpty">
																							<propertyReferenceExpression name="Deny">
																								<propertyReferenceExpression name="Value">
																									<variableReferenceExpression name="alteration"/>
																								</propertyReferenceExpression>
																							</propertyReferenceExpression>
																						</unaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="AlterControllerWith">
																							<parameters>
																								<propertyReferenceExpression name="Deny">
																									<propertyReferenceExpression name="Value">
																										<variableReferenceExpression name="alteration"/>
																									</propertyReferenceExpression>
																								</propertyReferenceExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</trueStatements>
																				</conditionStatement>
																			</falseStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</xsl:if>
							</memberMethod>
							<!-- method VirtualizeControllerConditionally(string) -->
							<memberMethod returnType="System.Boolean" name="VirtualizeControllerConditionally">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="controllerName"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="false"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method VirtualizeController(string, XPathNavigator, XmlNamespaceManager) -->
							<memberMethod name="VirtualizeController">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="controllerName"/>
									<parameter type="XPathNavigator" name="navigator"/>
									<parameter type="XmlNamespaceManager" name="resolver"/>
								</parameters>
								<statements>
									<assignStatement>
										<propertyReferenceExpression name="Navigator">
											<thisReferenceExpression/>
										</propertyReferenceExpression>
										<argumentReferenceExpression name="navigator"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="Resolver">
											<thisReferenceExpression/>
										</propertyReferenceExpression>
										<argumentReferenceExpression name="resolver"/>
									</assignStatement>
									<xsl:if test="$HostPath='' and $PageImplementation='html'">
										<methodInvokeExpression methodName="AlterController">
											<parameters>
												<argumentReferenceExpression name="controllerName"/>
											</parameters>
										</methodInvokeExpression>
									</xsl:if>
									<methodInvokeExpression methodName="VirtualizeController">
										<parameters>
											<argumentReferenceExpression name="controllerName"/>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
						</xsl:if>
						<!-- method CompleteConfiguration() -->
						<memberMethod returnType="System.Boolean" name="CompleteConfiguration">
							<attributes public="true"/>
							<statements>
								<variableDeclarationStatement type="System.Boolean" name="result">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<xsl:if test="$IsPremium='true'">
									<variableDeclarationStatement type="System.Object[]" name="saveRow">
										<init>
											<fieldReferenceExpression name="row"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<propertyReferenceExpression name="NewRow">
													<propertyReferenceExpression name="Page"/>
												</propertyReferenceExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="row"/>
												<propertyReferenceExpression name="NewRow">
													<propertyReferenceExpression name="Page"/>
												</propertyReferenceExpression>
											</assignStatement>
										</trueStatements>
										<falseStatements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="IdentityInequality">
															<propertyReferenceExpression name="Rows">
																<propertyReferenceExpression name="Page"/>
															</propertyReferenceExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="GreaterThan">
															<propertyReferenceExpression name="Count">
																<propertyReferenceExpression name="Rows">
																	<propertyReferenceExpression name="Page"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
															<primitiveExpression value="0"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<fieldReferenceExpression name="row"/>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Rows">
																	<propertyReferenceExpression name="Page"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<primitiveExpression value="0"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</falseStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="VirtualizeControllerConditionally">
												<parameters>
													<propertyReferenceExpression name="Controller">
														<propertyReferenceExpression name="Page"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="result"/>
												<primitiveExpression value="true"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<xsl:if test="$PageImplementation='html' and $IsPremium='true'">
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="PendingAlterations">
														<propertyReferenceExpression name="Config"/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="result"/>
													<methodInvokeExpression methodName="AlterController">
														<parameters>
															<propertyReferenceExpression name="PendingAlterations">
																<propertyReferenceExpression name="Config"/>
															</propertyReferenceExpression>
															<primitiveExpression value="true"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</xsl:if>
									<assignStatement>
										<fieldReferenceExpression name="row"/>
										<variableReferenceExpression name="saveRow"/>
									</assignStatement>
								</xsl:if>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property EnableDccTest -->
						<memberProperty type="System.Boolean" name="EnableDccTest">
							<attributes public="true" final="true"/>
						</memberProperty>
						<xsl:if test="$PageImplementation='html'">
							<!-- property PendingAlterations -->
							<memberProperty type="SiteContentFileList" name="PendingAlterations">
								<attributes public="true" final="true"/>
							</memberProperty>
							<!-- property TestPendingAlterRegex -->
							<memberField type="Regex" name="TestPendingAlterRegex">
								<attributes public="true" static="true"/>
								<init>
									<objectCreateExpression type="Regex">
										<parameters>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[\b(when\-?(view|test|sql))\b]]></xsl:attribute>
											</primitiveExpression>
											<propertyReferenceExpression name="IgnoreCase">
												<typeReferenceExpression type="RegexOptions"/>
											</propertyReferenceExpression>
										</parameters>
									</objectCreateExpression>
								</init>
							</memberField>
							<!-- method AlterController(string) -->
							<memberMethod name="AlterController">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="controllerName"/>
								</parameters>
								<statements>
									<!-- 
&& ApplicationServicesBase.Create().Supports(ApplicationFeature.DynamicControllerCustomization)                  -->
									<xsl:if test="$IsPremium='true'">
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<propertyReferenceExpression name="IsSiteContentEnabled">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
													<binaryOperatorExpression operator="BooleanAnd">
														<binaryOperatorExpression operator="ValueInequality">
															<argumentReferenceExpression name="controllerName"/>
															<propertyReferenceExpression name="SiteContentControllerName">
																<typeReferenceExpression type="ApplicationServices"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
														<methodInvokeExpression methodName="Supports">
															<target>
																<methodInvokeExpression methodName="Create">
																	<target>
																		<typeReferenceExpression type="ApplicationServices"/>
																	</target>
																</methodInvokeExpression>
															</target>
															<parameters>
																<propertyReferenceExpression name="DynamicControllerCustomization">
																	<typeReferenceExpression type="ApplicationFeature"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="SiteContentFileList" name="alterations">
													<init>
														<methodInvokeExpression methodName="ReadSiteContent">
															<target>
																<propertyReferenceExpression name="Current">
																	<typeReferenceExpression type="ApplicationServices"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<primitiveExpression value="sys/controllers%"/>
																<binaryOperatorExpression operator="Add">
																	<argumentReferenceExpression name="controllerName"/>
																	<primitiveExpression value=".Alter%"/>
																</binaryOperatorExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="AlterController">
													<parameters>
														<variableReferenceExpression name="alterations"/>
														<primitiveExpression value="false"/>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement type="SiteContentFileList" name="rules">
													<init>
														<methodInvokeExpression methodName="ReadSiteContent">
															<target>
																<propertyReferenceExpression name="Current">
																	<typeReferenceExpression type="ApplicationServices"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<binaryOperatorExpression operator="Add">
																	<primitiveExpression value="sys/rules/"/>
																	<argumentReferenceExpression name="controllerName"/>
																</binaryOperatorExpression>
																<primitiveExpression value="%"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable type="SiteContentFile" name="r"/>
													<target>
														<variableReferenceExpression name="rules"/>
													</target>
													<statements>
														<methodInvokeExpression methodName="AddBusinessRule">
															<parameters>
																<propertyReferenceExpression name="Text">
																	<variableReferenceExpression name="r"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
									</xsl:if>
								</statements>
							</memberMethod>
							<!-- method AlterController(SiteContentFileList, bool) -->
							<memberMethod returnType="System.Boolean" name="AlterController">
								<attributes public="true"/>
								<parameters>
									<parameter type="SiteContentFileList" name="alterations"/>
									<parameter type="System.Boolean" name="immediately"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="System.Boolean" name="changed">
										<init>
											<primitiveExpression value="false"/>
										</init>
									</variableDeclarationStatement>
									<xsl:if test="$IsPremium='true'">
										<foreachStatement>
											<variable type="SiteContentFile" name="f"/>
											<target>
												<variableReferenceExpression name="alterations"/>
											</target>
											<statements>
												<variableDeclarationStatement type="System.String" name="alter">
													<init>
														<propertyReferenceExpression name="Text">
															<variableReferenceExpression name="f"/>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="alter"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<unaryOperatorExpression operator="Not">
																		<argumentReferenceExpression name="immediately"/>
																	</unaryOperatorExpression>
																	<methodInvokeExpression methodName="IsMatch">
																		<target>
																			<propertyReferenceExpression name="TestPendingAlterRegex"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="alter"/>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityEquality">
																			<propertyReferenceExpression name="PendingAlterations"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="PendingAlterations"/>
																			<objectCreateExpression type="SiteContentFileList"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<propertyReferenceExpression name="PendingAlterations"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="f"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="AlterControllerWith">
																			<parameters>
																				<variableReferenceExpression name="alter"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="changed"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</xsl:if>
									<methodReturnStatement>
										<variableReferenceExpression name="changed"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method AddBusinessRule(string) -->
							<memberMethod name="AddBusinessRule">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="rule"/>
								</parameters>
								<statements>
									<xsl:if test="$IsPremium='true'">
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<argumentReferenceExpression name="rule"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
										<tryStatement>
											<statements>
												<variableDeclarationStatement type="JObject" name="json">
													<init>
														<methodInvokeExpression methodName="Parse">
															<target>
																<typeReferenceExpression type="JObject"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="rule"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="CreateBusinessRule">
													<target>
														<methodInvokeExpression methodName="NodeSet"/>
													</target>
													<parameters>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="json"/>
																</target>
																<indices>
																	<primitiveExpression value="type"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="json"/>
																</target>
																<indices>
																	<primitiveExpression value="phase"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="json"/>
																</target>
																<indices>
																	<primitiveExpression value="command"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="json"/>
																</target>
																<indices>
																	<primitiveExpression value="argument"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
														<stringEmptyExpression/>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="json"/>
																</target>
																<indices>
																	<primitiveExpression value="script"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
											<catch exceptionType="Exception"></catch>
										</tryStatement>
									</xsl:if>
								</statements>
							</memberMethod>
						</xsl:if>
						<xsl:if test="$IsPremium='true'">
							<!-- property AlterMethodRegex -->
							<memberField type="Regex" name="AlterMethodRegex">
								<attributes public="true" static="true"/>
								<init>
									<objectCreateExpression type="Regex">
										<parameters>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[\s*(?'Method'[\w\-]+)\s*\((?'Parameters'[\s\S]*?)\)\s*(?'Terminator'\.|;|$)]]></xsl:attribute>
											</primitiveExpression>
										</parameters>
									</objectCreateExpression>
								</init>
							</memberField>
							<!-- property AlterParametersRegex -->
							<memberField type="Regex" name="AlterParametersRegex">
								<attributes public="true" static="true"/>
								<init>
									<objectCreateExpression type="Regex">
										<parameters>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[\s*("|\')(?'Argument'[\s\S]*?)("|\')(\s*(,|$))]]></xsl:attribute>
											</primitiveExpression>
										</parameters>
									</objectCreateExpression>
								</init>
							</memberField>
							<!-- method AlterControllerWith(string) -->
							<memberMethod returnType="System.Boolean" name="AlterControllerWith">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="alter"/>
								</parameters>
								<statements>
									<variableDeclarationStatement name="changed">
										<init>
											<primitiveExpression value="false"/>
										</init>
									</variableDeclarationStatement>
									<xsl:if test="$IsPremium='true'">
										<variableDeclarationStatement name="nodeSet">
											<init>
												<methodInvokeExpression methodName="NodeSet">
													<target>
														<thisReferenceExpression/>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="Match" name="m">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<propertyReferenceExpression name="AlterMethodRegex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="alter"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Boolean" name="skipInvoke">
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
												<variableDeclarationStatement type="System.String" name="method">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Method"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="parameters">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Parameters"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="terminator">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Terminator"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="StringBuilder" name="sb">
													<init>
														<objectCreateExpression type="StringBuilder"/>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable type="System.String" name="s"/>
													<target>
														<methodInvokeExpression methodName="Split">
															<target>
																<variableReferenceExpression name="method"/>
															</target>
															<parameters>
																<arrayCreateExpression>
																	<createType type="System.Char"/>
																	<initializers>
																		<primitiveExpression value="-" convertTo="Char"/>
																	</initializers>
																</arrayCreateExpression>
																<propertyReferenceExpression name="RemoveEmptyEntries">
																	<typeReferenceExpression type="StringSplitOptions"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</target>
													<statements>
														<methodInvokeExpression methodName="Append">
															<target>
																<variableReferenceExpression name="sb"/>
															</target>
															<parameters>
																<binaryOperatorExpression operator="Add">
																	<methodInvokeExpression methodName="ToUpper">
																		<target>
																			<typeReferenceExpression type="Char"/>
																		</target>
																		<parameters>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="s"/>
																				</target>
																				<indices>
																					<primitiveExpression value="0"/>
																				</indices>
																			</arrayIndexerExpression>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="Substring">
																		<target>
																			<variableReferenceExpression name="s"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="1"/>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
												<assignStatement>
													<variableReferenceExpression name="method"/>
													<methodInvokeExpression methodName="ToString">
														<target>
															<variableReferenceExpression name="sb"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
												<variableDeclarationStatement type="List" name="args">
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
												<variableDeclarationStatement type="Match" name="p">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<propertyReferenceExpression name="AlterParametersRegex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="parameters"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<whileStatement>
													<test>
														<propertyReferenceExpression name="Success">
															<variableReferenceExpression name="p"/>
														</propertyReferenceExpression>
													</test>
													<statements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="args"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="p"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Argument"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<assignStatement>
															<variableReferenceExpression name="p"/>
															<methodInvokeExpression methodName="NextMatch">
																<target>
																	<variableReferenceExpression name="p"/>
																</target>
															</methodInvokeExpression>
														</assignStatement>
													</statements>
												</whileStatement>
												<tryStatement>
													<statements>
														<variableDeclarationStatement type="System.Boolean" name="tested">
															<init>
																<primitiveExpression value="false"/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="GreaterThan">
																	<propertyReferenceExpression name="Count">
																		<variableReferenceExpression name="args"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="method"/>
																			<primitiveExpression value="WhenTagged"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<methodInvokeExpression methodName="IsTagged">
																						<parameters>
																							<methodInvokeExpression methodName="ToArray">
																								<target>
																									<variableReferenceExpression name="args"/>
																								</target>
																							</methodInvokeExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="skipInvoke"/>
																					<primitiveExpression value="true"/>
																				</assignStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="ValueEquality">
																							<variableReferenceExpression name="terminator"/>
																							<primitiveExpression value=";"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<breakStatement/>
																					</trueStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<variableReferenceExpression name="tested"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="method"/>
																			<primitiveExpression value="WhenUrl"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="Regex" name="urlRegex">
																			<init>
																				<objectCreateExpression type="Regex">
																					<parameters>
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="args"/>
																							</target>
																							<indices>
																								<primitiveExpression value="0"/>
																							</indices>
																						</arrayIndexerExpression>
																						<propertyReferenceExpression name="IgnoreCase">
																							<typeReferenceExpression type="RegexOptions"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</objectCreateExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanAnd">
																					<binaryOperatorExpression operator="IdentityInequality">
																						<propertyReferenceExpression name="UrlReferrer">
																							<propertyReferenceExpression name="Request">
																								<propertyReferenceExpression name="Context"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																						<primitiveExpression value="null"/>
																					</binaryOperatorExpression>
																					<unaryOperatorExpression operator="Not">
																						<methodInvokeExpression methodName="IsMatch">
																							<target>
																								<variableReferenceExpression name="urlRegex"/>
																							</target>
																							<parameters>
																								<methodInvokeExpression methodName="ToString">
																									<target>
																										<propertyReferenceExpression name="UrlReferrer">
																											<propertyReferenceExpression name="Request">
																												<propertyReferenceExpression name="Context"/>
																											</propertyReferenceExpression>
																										</propertyReferenceExpression>
																									</target>
																								</methodInvokeExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</unaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="skipInvoke"/>
																					<primitiveExpression value="true"/>
																				</assignStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="ValueEquality">
																							<variableReferenceExpression name="terminator"/>
																							<primitiveExpression value=";"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<breakStatement/>
																					</trueStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<variableReferenceExpression name="tested"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="method"/>
																			<primitiveExpression value="WhenUserInterface"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="System.String" name="userInterface">
																			<init>
																				<methodInvokeExpression methodName="ToLower">
																					<target>
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="args"/>
																							</target>
																							<indices>
																								<primitiveExpression value="0"/>
																							</indices>
																						</arrayIndexerExpression>
																					</target>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanOr">
																					<binaryOperatorExpression operator="BooleanAnd">
																						<binaryOperatorExpression operator="ValueEquality">
																							<variableReferenceExpression name="userInterface"/>
																							<primitiveExpression value="touch"/>
																						</binaryOperatorExpression>
																						<unaryOperatorExpression operator="Not">
																							<propertyReferenceExpression name="IsTouchClient">
																								<typeReferenceExpression type="ApplicationServices"/>
																							</propertyReferenceExpression>
																						</unaryOperatorExpression>
																					</binaryOperatorExpression>
																					<binaryOperatorExpression operator="BooleanAnd">
																						<binaryOperatorExpression operator="ValueEquality">
																							<variableReferenceExpression name="userInterface"/>
																							<primitiveExpression value="desktop"/>
																						</binaryOperatorExpression>
																						<propertyReferenceExpression name="IsTouchClient">
																							<typeReferenceExpression type="ApplicationServices"/>
																						</propertyReferenceExpression>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="skipInvoke"/>
																					<primitiveExpression value="true"/>
																				</assignStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="ValueEquality">
																							<variableReferenceExpression name="terminator"/>
																							<primitiveExpression value=";"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<breakStatement/>
																					</trueStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<variableReferenceExpression name="tested"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="method"/>
																			<primitiveExpression value="WhenView"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<variableReferenceExpression name="skipInvoke"/>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement type="Regex" name="viewRegex">
																					<init>
																						<objectCreateExpression type="Regex">
																							<parameters>
																								<arrayIndexerExpression>
																									<target>
																										<variableReferenceExpression name="args"/>
																									</target>
																									<indices>
																										<primitiveExpression value="0"/>
																									</indices>
																								</arrayIndexerExpression>
																								<propertyReferenceExpression name="IgnoreCase">
																									<typeReferenceExpression type="RegexOptions"/>
																								</propertyReferenceExpression>
																							</parameters>
																						</objectCreateExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="BooleanOr">
																							<binaryOperatorExpression operator="IdentityEquality">
																								<propertyReferenceExpression name="View">
																									<thisReferenceExpression/>
																								</propertyReferenceExpression>
																								<primitiveExpression value="null"/>
																							</binaryOperatorExpression>
																							<unaryOperatorExpression operator="Not">
																								<methodInvokeExpression methodName="IsMatch">
																									<target>
																										<variableReferenceExpression name="viewRegex"/>
																									</target>
																									<parameters>
																										<propertyReferenceExpression name="View">
																											<thisReferenceExpression/>
																										</propertyReferenceExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</unaryOperatorExpression>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="skipInvoke"/>
																							<primitiveExpression value="true"/>
																						</assignStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="terminator"/>
																									<primitiveExpression value=";"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<breakStatement/>
																							</trueStatements>
																						</conditionStatement>
																					</trueStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<variableReferenceExpression name="tested"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="method"/>
																			<primitiveExpression value="WhenTest"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<variableReferenceExpression name="skipInvoke"/>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement type="DataTable" name="dt">
																					<init>
																						<methodInvokeExpression methodName="ToDataTable">
																							<target>
																								<propertyReferenceExpression name="Page"/>
																							</target>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="RowFilter">
																						<propertyReferenceExpression name="DefaultView">
																							<variableReferenceExpression name="dt"/>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																					<methodInvokeExpression methodName="Trim">
																						<target>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="args"/>
																								</target>
																								<indices>
																									<primitiveExpression value="0"/>
																								</indices>
																							</arrayIndexerExpression>
																						</target>
																					</methodInvokeExpression>
																				</assignStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="ValueEquality">
																							<propertyReferenceExpression name="Count">
																								<propertyReferenceExpression name="DefaultView">
																									<variableReferenceExpression name="dt"/>
																								</propertyReferenceExpression>
																							</propertyReferenceExpression>
																							<primitiveExpression value="0"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="skipInvoke"/>
																							<primitiveExpression value="true"/>
																						</assignStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="terminator"/>
																									<primitiveExpression value=";"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<breakStatement/>
																							</trueStatements>
																						</conditionStatement>
																					</trueStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<variableReferenceExpression name="tested"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="method"/>
																			<primitiveExpression value="WhenSql"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression  operator="Not">
																					<variableReferenceExpression name="skipInvoke"/>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement type="System.String" name="q">
																					<init>
																						<methodInvokeExpression methodName="Trim">
																							<target>
																								<arrayIndexerExpression>
																									<target>
																										<variableReferenceExpression name="args"/>
																									</target>
																									<indices>
																										<primitiveExpression value="0"/>
																									</indices>
																								</arrayIndexerExpression>
																							</target>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<variableDeclarationStatement type="System.String" name="sqlText">
																					<init>
																						<primitiveExpression value="select 1"/>
																					</init>
																				</variableDeclarationStatement>
																				<variableDeclarationStatement type="ConnectionStringSettings" name="css">
																					<init>
																						<methodInvokeExpression methodName="Create">
																							<target>
																								<typeReferenceExpression type="ConnectionStringSettingsFactory"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="null"/>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<methodInvokeExpression methodName="Contains">
																							<target>
																								<propertyReferenceExpression name="ProviderName">
																									<variableReferenceExpression name="css"/>
																								</propertyReferenceExpression>
																							</target>
																							<parameters>
																								<primitiveExpression value="Oracle"/>
																							</parameters>
																						</methodInvokeExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="sqlText"/>
																							<binaryOperatorExpression operator="Add">
																								<variableReferenceExpression name="sqlText"/>
																								<primitiveExpression value=" from dual"/>
																							</binaryOperatorExpression>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																				<assignStatement>
																					<variableReferenceExpression name="sqlText"/>
																					<binaryOperatorExpression operator="Add">
																						<variableReferenceExpression name="sqlText"/>
																						<binaryOperatorExpression operator="Add">
																							<primitiveExpression value=" where "/>
																							<variableReferenceExpression name="q"/>
																						</binaryOperatorExpression>
																					</binaryOperatorExpression>
																				</assignStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="EnableDccTest"/>
																					<primitiveExpression value="true"/>
																				</assignStatement>
																				<assignStatement>
																					<variableReferenceExpression name="skipInvoke"/>
																					<binaryOperatorExpression operator="ValueEquality">
																						<methodInvokeExpression methodName="Sql">
																							<parameters>
																								<variableReferenceExpression name="sqlText"/>
																							</parameters>
																						</methodInvokeExpression>
																						<primitiveExpression value="0"/>
																					</binaryOperatorExpression>
																				</assignStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="EnableDccTest"/>
																					<primitiveExpression value="false"/>
																				</assignStatement>
																				<conditionStatement>
																					<condition>
																						<variableReferenceExpression name="skipInvoke"/>
																					</condition>
																					<trueStatements>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="terminator"/>
																									<primitiveExpression value=";"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<breakStatement/>
																							</trueStatements>
																						</conditionStatement>
																					</trueStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<variableReferenceExpression name="tested"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<unaryOperatorExpression operator="Not">
																		<variableReferenceExpression name="skipInvoke"/>
																	</unaryOperatorExpression>
																	<unaryOperatorExpression operator="Not">
																		<variableReferenceExpression name="tested"/>
																	</unaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="nodeSet"/>
																	<castExpression targetType="ControllerNodeSet">
																		<methodInvokeExpression methodName="InvokeMember">
																			<target>
																				<methodInvokeExpression methodName="GetType">
																					<target>
																						<variableReferenceExpression name="nodeSet"/>
																					</target>
																				</methodInvokeExpression>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="method"/>
																				<propertyReferenceExpression name="InvokeMethod">
																					<typeReferenceExpression type="BindingFlags"/>
																				</propertyReferenceExpression>
																				<primitiveExpression value="null"/>
																				<variableReferenceExpression name="nodeSet"/>
																				<methodInvokeExpression methodName="ToArray">
																					<target>
																						<variableReferenceExpression name="args"/>
																					</target>
																				</methodInvokeExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</assignStatement>
																<assignStatement>
																	<variableReferenceExpression name="changed"/>
																	<primitiveExpression value="true"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</statements>
													<catch exceptionType="Exception" localName="ex">
														<throwExceptionStatement>
															<objectCreateExpression type="Exception">
																<parameters>
																	<stringFormatExpression format="{{0}}){{1}}: {{2}}">
																		<variableReferenceExpression name="method"/>
																		<variableReferenceExpression name="parameters"/>
																		<propertyReferenceExpression name="Message">
																			<variableReferenceExpression name="ex"/>
																		</propertyReferenceExpression>
																	</stringFormatExpression>
																</parameters>
															</objectCreateExpression>
														</throwExceptionStatement>
													</catch>
												</tryStatement>
												<assignStatement>
													<variableReferenceExpression name="m"/>
													<methodInvokeExpression methodName="NextMatch">
														<target>
															<variableReferenceExpression name="m"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="terminator"/>
															<primitiveExpression value=";"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="nodeSet"/>
															<methodInvokeExpression methodName="NodeSet">
																<target>
																	<thisReferenceExpression/>
																</target>
															</methodInvokeExpression>
														</assignStatement>
														<assignStatement>
															<variableReferenceExpression name="skipInvoke"/>
															<primitiveExpression value="false"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</whileStatement>
									</xsl:if>
									<methodReturnStatement>
										<variableReferenceExpression name="changed"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</xsl:if>
						<!-- property TagList -->
						<memberProperty type="System.String[]" name="TagList">
							<attributes family="true" final="true"/>
							<getStatements>
								<variableDeclarationStatement type="System.String" name="t">
									<init>
										<propertyReferenceExpression name="Tags"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="t"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="t"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Split">
										<target>
											<variableReferenceExpression name="t"/>
										</target>
										<parameters>
											<arrayCreateExpression>
												<createType type="System.Char"/>
												<initializers>
													<primitiveExpression value="," convertTo="Char"/>
													<primitiveExpression value=" " convertTo="Char"/>
												</initializers>
											</arrayCreateExpression>
											<propertyReferenceExpression name="RemoveEmptyEntries">
												<typeReferenceExpression type="StringSplitOptions"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<variableDeclarationStatement type="StringBuilder" name="sb">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertySetValueReferenceExpression/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="System.String" name="s"/>
											<target>
												<propertySetValueReferenceExpression/>
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
														<variableReferenceExpression name="s"/>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="Tags"/>
									<methodInvokeExpression methodName="ToString">
										<target>
											<variableReferenceExpression name="sb"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- method IsTagged(params string[]) -->
						<memberMethod returnType="System.Boolean" name="IsTagged">
							<comment>
								<![CDATA[
        /// <summary>
        /// Returns true if the data view on the page is tagged with any of the values specified in the arguments.
        /// </summary>
        /// <param name="tags">The collection of string values representing tag names.</param>
        /// <returns>Returns true if at least one tag specified in the arguments is assigned to the data view.</returns>
              ]]>
							</comment>
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="params System.String[]" name="tags"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String[]" name="list">
									<init>
										<propertyReferenceExpression name="TagList"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="t"/>
									<target>
										<argumentReferenceExpression name="tags"/>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThanOrEqual">
													<methodInvokeExpression methodName="IndexOf">
														<target>
															<typeReferenceExpression type="Array"/>
														</target>
														<parameters>
															<variableReferenceExpression name="list"/>
															<variableReferenceExpression name="t"/>
														</parameters>
													</methodInvokeExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="true"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AddTag(params string[]) -->
						<memberMethod name="AddTag">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="params System.String[]" name="tags"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="List" name="list">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
											<parameters>
												<propertyReferenceExpression name="TagList"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="t"/>
									<target>
										<variableReferenceExpression name="tags"/>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="list"/>
														</target>
														<parameters>
															<variableReferenceExpression name="t"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="list"/>
													</target>
													<parameters>
														<variableReferenceExpression name="t"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<assignStatement>
									<propertyReferenceExpression name="TagList"/>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="list"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
							</statements>
						</memberMethod>
						<!-- method RemoveTag(params string[]) -->
						<memberMethod name="RemoveTag">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="params System.String[]" name="tags"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="List" name="list">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
											<parameters>
												<propertyReferenceExpression name="TagList"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="t"/>
									<target>
										<variableReferenceExpression name="tags"/>
									</target>
									<statements>
										<methodInvokeExpression methodName="Remove">
											<target>
												<variableReferenceExpression name="list"/>
											</target>
											<parameters>
												<variableReferenceExpression name="t"/>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<assignStatement>
									<propertyReferenceExpression name="TagList"/>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="list"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
							</statements>
						</memberMethod>
						<!-- method AddFieldValue(FieldValue) -->
						<memberMethod name="AddFieldValue">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="FieldValue" name="v"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Arguments"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="List" name="values">
											<typeArguments>
												<typeReference type="FieldValue"/>
											</typeArguments>
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="FieldValue"/>
													</typeArguments>
													<parameters>
														<propertyReferenceExpression name="Values">
															<propertyReferenceExpression name="Arguments"/>
														</propertyReferenceExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="values"/>
											</target>
											<parameters>
												<variableReferenceExpression name="v"/>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<propertyReferenceExpression name="Values">
												<propertyReferenceExpression name="Arguments"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToArray">
												<target>
													<variableReferenceExpression name="values"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method AddFieldValue(string, object) -->
						<memberMethod name="AddFieldValue">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
								<parameter type="System.Object" name="newValue"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="AddFieldValue">
									<parameters>
										<objectCreateExpression type="FieldValue">
											<parameters>
												<argumentReferenceExpression name="name"/>
												<argumentReferenceExpression name="newValue"/>
											</parameters>
										</objectCreateExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<xsl:if test="$HostPath!=''">
							<!-- property ObjectQualifier -->
							<memberProperty type="System.String" name="ObjectQualifier">
								<attributes private="true" static="true"/>
								<getStatements>
									<variableDeclarationStatement type="System.String" name="qualifier">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Cache">
															<typeReferenceExpression type="System.Web.HttpRuntime"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="DotNetNuke_ObjectQualifier"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<variableReferenceExpression name="qualifier"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="ConnectionStringSettings" name="settings">
												<init>
													<methodInvokeExpression methodName="Create">
														<target>
															<typeReferenceExpression type="ConnectionStringSettingsFactory"/>
														</target>
														<parameters>
															<primitiveExpression value="SiteSqlServer"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="DbProviderFactory" name="factory">
												<init>
													<methodInvokeExpression methodName="GetFactory">
														<target>
															<typeReferenceExpression type="DbProviderFactories"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="ProviderName">
																<variableReferenceExpression name="settings"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="DbConnection" name="connection">
												<init>
													<methodInvokeExpression methodName="CreateConnection">
														<target>
															<variableReferenceExpression name="factory"/>
														</target>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<propertyReferenceExpression name="ConnectionString">
													<variableReferenceExpression name="connection"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="ConnectionString">
													<variableReferenceExpression name="settings"/>
												</propertyReferenceExpression>
											</assignStatement>
											<methodInvokeExpression methodName="Open">
												<target>
													<variableReferenceExpression name="connection"/>
												</target>
											</methodInvokeExpression>
											<variableDeclarationStatement type="DataTable" name="tables">
												<init>
													<methodInvokeExpression methodName="GetSchema">
														<target>
															<variableReferenceExpression name="connection"/>
														</target>
														<parameters>
															<primitiveExpression value="Tables"/>
															<arrayCreateExpression>
																<createType type="System.String"/>
																<initializers>
																	<primitiveExpression value="null"/>
																	<primitiveExpression value="null"/>
																	<primitiveExpression value="null"/>
																	<primitiveExpression value="BASE TABLE"/>
																</initializers>
															</arrayCreateExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<methodInvokeExpression methodName="Close">
												<target>
													<variableReferenceExpression name="connection"/>
												</target>
											</methodInvokeExpression>
											<foreachStatement>
												<variable type="DataRow" name="r"/>
												<target>
													<propertyReferenceExpression name="Rows">
														<variableReferenceExpression name="tables"/>
													</propertyReferenceExpression>
												</target>
												<statements>
													<variableDeclarationStatement type="System.String" name="name">
														<init>
															<castExpression targetType="System.String">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="r"/>
																	</target>
																	<indices>
																		<primitiveExpression value="TABLE_NAME"/>
																	</indices>
																</arrayIndexerExpression>
															</castExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="EndsWith">
																<target>
																	<variableReferenceExpression name="name"/>
																</target>
																<parameters>
																	<primitiveExpression value="_DesktopModules"/>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="qualifier"/>
																<methodInvokeExpression methodName="Substring">
																	<target>
																		<variableReferenceExpression name="name"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="0"/>
																		<binaryOperatorExpression operator="Subtract">
																			<binaryOperatorExpression operator="Add">
																				<propertyReferenceExpression name="Length">
																					<variableReferenceExpression name="name"/>
																				</propertyReferenceExpression>
																				<primitiveExpression value="1"/>
																			</binaryOperatorExpression>
																			<propertyReferenceExpression name="Length">
																				<primitiveExpression value="_DesktopModules"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
															<assignStatement>
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Cache">
																			<typeReferenceExpression type="System.Web.HttpRuntime"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="DotNetNuke_ObjectQualifier"/>
																	</indices>
																</arrayIndexerExpression>
																<variableReferenceExpression name="qualifier"/>
															</assignStatement>
															<breakStatement/>
														</trueStatements>
													</conditionStatement>
												</statements>
											</foreachStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="qualifier"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- property PortalId -->
							<memberProperty type="System.Int32" name="PortalId">
								<attributes public="true" static="true"/>
								<getStatements>
									<variableDeclarationStatement type="System.String" name="sql">
										<init>
											<stringFormatExpression format="select up.PortalId from {{0}}UserPortals up inner join {{0}}Users u on up.UserId=u.UserID where u.Username=@UserName">
												<propertyReferenceExpression name="ObjectQualifier"/>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<usingStatement>
										<variable type="SqlText" name="findPortalId">
											<init>
												<objectCreateExpression type="SqlText">
													<parameters>
														<variableReferenceExpression name="sql"/>
														<primitiveExpression value="SiteSqlServer"/>
													</parameters>
												</objectCreateExpression>
											</init>
										</variable>
										<statements>
											<methodInvokeExpression methodName="AddParameter">
												<target>
													<variableReferenceExpression name="findPortalId"/>
												</target>
												<parameters>
													<primitiveExpression value="@UserName"/>
													<propertyReferenceExpression name="UserName"/>
												</parameters>
											</methodInvokeExpression>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="Read">
														<target>
															<variableReferenceExpression name="findPortalId"/>
														</target>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<methodReturnStatement>
														<convertExpression to="Int32">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="findPortalId"/>
																</target>
																<indices>
																	<primitiveExpression value="0"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
														<!--<methodInvokeExpression methodName="ToInt32">
                              <target>
                                <typeReferenceExpression type="Convert"/>
                              </target>
                              <parameters>
                                <arrayIndexerExpression>
                                  <target>
                                    <variableReferenceExpression name="findPortalId"/>
                                  </target>
                                  <indices>
                                    <primitiveExpression value="0"/>
                                  </indices>
                                </arrayIndexerExpression>
                              </parameters>
                            </methodInvokeExpression>-->
													</methodReturnStatement>
												</trueStatements>
											</conditionStatement>
											<methodReturnStatement>
												<primitiveExpression value="-1"/>
											</methodReturnStatement>
										</statements>
									</usingStatement>
								</getStatements>
							</memberProperty>
						</xsl:if>
						<!-- propert UserName -->
						<memberProperty type="System.String" name="UserName">
							<attributes public="true" static="true"/>
							<getStatements>
								<methodReturnStatement>
									<propertyReferenceExpression name="Name">
										<propertyReferenceExpression name="Identity">
											<propertyReferenceExpression name="User">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="System.Web.HttpContext"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property UserEmail -->
						<memberField type="System.String" name="userEmail"/>
						<memberProperty type="System.String" name="UserEmail">
							<attributes public="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<fieldReferenceExpression name="userEmail"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<fieldReferenceExpression name="userEmail"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<xsl:choose>
									<xsl:when test="$HostPath!=''">
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<propertyReferenceExpression name="UserName"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="null"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="System.String" name="sql">
											<init>
												<stringFormatExpression format="select u.Email from {{0}}Users u where u.Username=@UserName">
													<propertyReferenceExpression name="ObjectQualifier"/>
												</stringFormatExpression>
											</init>
										</variableDeclarationStatement>
										<usingStatement>
											<variable type="SqlText" name="findUserEmail">
												<init>
													<objectCreateExpression type="SqlText">
														<parameters>
															<variableReferenceExpression name="sql"/>
															<primitiveExpression value="SiteSqlServer"/>
														</parameters>
													</objectCreateExpression>
												</init>
											</variable>
											<statements>
												<methodInvokeExpression methodName="AddParameter">
													<target>
														<variableReferenceExpression name="findUserEmail"/>
													</target>
													<parameters>
														<primitiveExpression value="@UserName"/>
														<propertyReferenceExpression name="UserName"/>
													</parameters>
												</methodInvokeExpression>
												<methodReturnStatement>
													<convertExpression to="String">
														<methodInvokeExpression methodName="ExecuteScalar">
															<target>
																<variableReferenceExpression name="findUserEmail"/>
															</target>
														</methodInvokeExpression>
													</convertExpression>
												</methodReturnStatement>
											</statements>
										</usingStatement>
									</xsl:when>
									<xsl:otherwise>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<binaryOperatorExpression operator="IdentityEquality">
														<methodInvokeExpression methodName="GetType">
															<target>
																<propertyReferenceExpression name="Identity">
																	<propertyReferenceExpression name="User">
																		<propertyReferenceExpression name="Current">
																			<typeReferenceExpression type="System.Web.HttpContext"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</target>
														</methodInvokeExpression>
														<typeofExpression type="System.Security.Principal.WindowsIdentity"/>
													</binaryOperatorExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<propertyReferenceExpression name="Email">
														<methodInvokeExpression methodName="GetUser">
															<target>
																<typeReferenceExpression type="System.Web.Security.Membership"/>
															</target>
														</methodInvokeExpression>
													</propertyReferenceExpression>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</xsl:otherwise>
								</xsl:choose>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="userEmail"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<xsl:if test="$HostPath=''">
							<!-- property UserRoles-->
							<memberProperty type="System.String" name="UserRoles">
								<attributes public="true"/>
								<getStatements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="Join">
											<target>
												<typeReferenceExpression type="System.String"/>
											</target>
											<parameters>
												<primitiveExpression value=","/>
												<methodInvokeExpression methodName="GetRolesForUser">
													<target>
														<typeReferenceExpression type="Roles"/>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
						</xsl:if>
						<!-- proprety UserId -->
						<memberProperty type="System.Object" name="UserId">
							<attributes public="true" static="true"/>
							<getStatements>
								<xsl:choose>
									<xsl:when test="$HostPath!=''">
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<propertyReferenceExpression name="UserName"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="-1"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="System.String" name="sql">
											<init>
												<stringFormatExpression format="select u.UserId from {{0}}Users u where u.Username=@UserName">
													<propertyReferenceExpression name="ObjectQualifier"/>
												</stringFormatExpression>
											</init>
										</variableDeclarationStatement>
										<usingStatement>
											<variable type="SqlText" name="findUserId">
												<init>
													<objectCreateExpression type="SqlText">
														<parameters>
															<variableReferenceExpression name="sql"/>
															<primitiveExpression value="SiteSqlServer"/>
														</parameters>
													</objectCreateExpression>
												</init>
											</variable>
											<statements>
												<methodInvokeExpression methodName="AddParameter">
													<target>
														<variableReferenceExpression name="findUserId"/>
													</target>
													<parameters>
														<primitiveExpression value="@UserName"/>
														<propertyReferenceExpression name="UserName"/>
													</parameters>
												</methodInvokeExpression>
												<methodReturnStatement>
													<convertExpression to="Int32">
														<methodInvokeExpression methodName="ExecuteScalar">
															<target>
																<variableReferenceExpression name="findUserId"/>
															</target>
														</methodInvokeExpression>
													</convertExpression>
												</methodReturnStatement>
											</statements>
										</usingStatement>
									</xsl:when>
									<xsl:otherwise>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<methodInvokeExpression methodName="GetType">
														<target>
															<propertyReferenceExpression name="Identity">
																<propertyReferenceExpression name="User">
																	<propertyReferenceExpression name="Current">
																		<typeReferenceExpression type="System.Web.HttpContext"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</target>
													</methodInvokeExpression>
													<typeofExpression type="System.Security.Principal.WindowsIdentity"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<propertyReferenceExpression name="Value">
														<propertyReferenceExpression name="User">
															<methodInvokeExpression methodName="GetCurrent">
																<target>
																	<typeReferenceExpression type="System.Security.Principal.WindowsIdentity"/>
																</target>
															</methodInvokeExpression>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</methodReturnStatement>
											</trueStatements>
											<falseStatements>
												<variableDeclarationStatement type="MembershipUser" name="user">
													<init>
														<methodInvokeExpression methodName="GetUser">
															<target>
																<typeReferenceExpression type="Membership"/>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="user"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="null"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
												<methodReturnStatement>
													<propertyReferenceExpression name="ProviderUserKey">
														<variableReferenceExpression name="user"/>
													</propertyReferenceExpression>
												</methodReturnStatement>
											</falseStatements>
										</conditionStatement>
									</xsl:otherwise>
								</xsl:choose>
							</getStatements>
						</memberProperty>
						<!-- method BeforeSelect(DisitnctValueRequest) -->
						<memberMethod name="BeforeSelect">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="DistinctValueRequest" name="request"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteServerRules">
									<parameters>
										<argumentReferenceExpression name="request"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="ExecuteSelect">
									<parameters>
										<propertyReferenceExpression name="Controller">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="View">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Filter">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="ExternalFilter">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
										<primitiveExpression value="SelectDistinct"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method AfterSelect(DistinctValueRequest) -->
						<memberMethod name="AfterSelect">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="DistinctValueRequest" name="request"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteServerRules">
									<parameters>
										<argumentReferenceExpression name="request"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="ExecuteSelect">
									<parameters>
										<propertyReferenceExpression name="Controller">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="View">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Filter">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="ExternalFilter">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="After">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
										<primitiveExpression value="SelectDistinct"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method BeforeSelect(PageRequest) -->
						<memberMethod name="BeforeSelect">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteServerRules">
									<parameters>
										<argumentReferenceExpression name="request"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="ExecuteSelect">
									<parameters>
										<propertyReferenceExpression name="Controller">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="View">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Filter">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="ExternalFilter">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Select"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method AfterSelect(PageRequest) -->
						<memberMethod name="AfterSelect">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteServerRules">
									<parameters>
										<argumentReferenceExpression name="request"/>
										<propertyReferenceExpression name="After">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="ExecuteSelect">
									<parameters>
										<propertyReferenceExpression name="Controller">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="View">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Filter">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="ExternalFilter">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="After">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Select"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method IsFiltered(string, RowFilterOperation) -->
						<memberMethod returnType="System.Boolean" name="IsFiltered">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="params RowFilterOperation[]" name="operations"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="FilterValue" name="fvo">
									<init>
										<methodInvokeExpression methodName="SelectFilterValue">
											<parameters>
												<argumentReferenceExpression name="fieldName"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="fvo"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="RowFilterOperation" name="op"/>
											<target>
												<argumentReferenceExpression name="operations"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="FilterOperation">
																<variableReferenceExpression name="fvo"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="op"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="true"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="IdentityInequality">
										<variableReferenceExpression name="fvo"/>
										<primitiveExpression value="null"/>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property QuickFindFilter -->
						<memberProperty type="System.String" name="QuickFindFilter">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="requestFilter">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="System.String" name="filterExpression"/>
											<target>
												<fieldReferenceExpression name="requestFilter">
													<thisReferenceExpression/>
												</fieldReferenceExpression>
											</target>
											<statements>
												<variableDeclarationStatement type="Match" name="filterMatch">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<propertyReferenceExpression name="FilterExpressionRegex">
																	<typeReferenceExpression type="Controller"/>
																</propertyReferenceExpression>
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
														<variableDeclarationStatement type="Match" name="valueMatch">
															<init>
																<methodInvokeExpression methodName="Match">
																	<target>
																		<propertyReferenceExpression name="FilterValueRegex">
																			<typeReferenceExpression type="Controller"/>
																		</propertyReferenceExpression>
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
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<propertyReferenceExpression name="Success">
																		<variableReferenceExpression name="valueMatch"/>
																	</propertyReferenceExpression>
																	<binaryOperatorExpression operator="ValueEquality">
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
																		<primitiveExpression value="~"/>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodReturnStatement>
																	<convertExpression to="String">
																		<methodInvokeExpression methodName="StringToValue">
																			<target>
																				<typeReferenceExpression type="Controller"/>
																			</target>
																			<parameters>
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
																			</parameters>
																		</methodInvokeExpression>
																	</convertExpression>
																	<!--<methodInvokeExpression methodName="ToString">
                                    <target>
                                      <typeReferenceExpression type="Convert"/>
                                    </target>
                                    <parameters>
                                      <methodInvokeExpression methodName="StringToValue">
                                        <target>
                                          <typeReferenceExpression type="Controller"/>
                                        </target>
                                        <parameters>
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
                                        </parameters>
                                      </methodInvokeExpression>
                                    </parameters>
                                  </methodInvokeExpression>-->
																</methodReturnStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method SelectFilterValue(string) -->
						<memberMethod returnType="FilterValue" name="SelectFilterValue">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="FilterValue" name="fvo">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String[]" name="filters">
									<init>
										<fieldReferenceExpression name="requestFilter"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="filters"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="Length">
													<variableReferenceExpression name="filters"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="filters"/>
											<propertyReferenceExpression name="Filter">
												<propertyReferenceExpression name="Result"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="filters"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="System.String" name="filterExpression"/>
											<target>
												<variableReferenceExpression name="filters"/>
											</target>
											<statements>
												<variableDeclarationStatement type="Match" name="filterMatch">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<propertyReferenceExpression name="FilterExpressionRegex">
																	<typeReferenceExpression type="Controller"/>
																</propertyReferenceExpression>
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
														<variableDeclarationStatement type="Match" name="valueMatch">
															<init>
																<methodInvokeExpression methodName="Match">
																	<target>
																		<propertyReferenceExpression name="FilterValueRegex">
																			<typeReferenceExpression type="Controller"/>
																		</propertyReferenceExpression>
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
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<propertyReferenceExpression name="Success">
																		<variableReferenceExpression name="valueMatch"/>
																	</propertyReferenceExpression>
																	<binaryOperatorExpression operator="BooleanAnd">
																		<methodInvokeExpression methodName="Equals">
																			<target>
																				<variableReferenceExpression name="fieldAlias"/>
																			</target>
																			<parameters>
																				<argumentReferenceExpression name="fieldName"/>
																				<propertyReferenceExpression name="InvariantCultureIgnoreCase">
																					<typeReferenceExpression type="StringComparison"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																		<binaryOperatorExpression operator="ValueInequality">
																			<variableReferenceExpression name="operation"/>
																			<primitiveExpression value="~"/>
																		</binaryOperatorExpression>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="System.String" name="filterValue">
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
																<variableDeclarationStatement type="System.Object" name="v">
																	<init>
																		<primitiveExpression value="null"/>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="StringIsNull">
																				<target>
																					<typeReferenceExpression type="Controller"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="filterValue"/>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="IsMatch">
																					<target>
																						<typeReferenceExpression type="Regex"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="filterValue"/>
																						<primitiveExpression value="\$(or|and)\$"/>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement type="System.String[]" name="list">
																					<init>
																						<methodInvokeExpression methodName="Split">
																							<target>
																								<variableReferenceExpression name="filterValue"/>
																							</target>
																							<parameters>
																								<arrayCreateExpression>
																									<createType type="System.String"/>
																									<initializers>
																										<primitiveExpression value="$or$"/>
																										<primitiveExpression value="$and$"/>
																									</initializers>
																								</arrayCreateExpression>
																								<propertyReferenceExpression name="RemoveEmptyEntries">
																									<typeReferenceExpression type="StringSplitOptions"/>
																								</propertyReferenceExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<variableDeclarationStatement type="List" name="values">
																					<typeArguments>
																						<typeReference type="System.Object"/>
																					</typeArguments>
																					<init>
																						<objectCreateExpression type="List">
																							<typeArguments>
																								<typeReference type="System.Object"/>
																							</typeArguments>
																						</objectCreateExpression>
																					</init>
																				</variableDeclarationStatement>
																				<foreachStatement>
																					<variable type="System.String" name="s"/>
																					<target>
																						<variableReferenceExpression name="list"/>
																					</target>
																					<statements>
																						<conditionStatement>
																							<condition>
																								<methodInvokeExpression methodName="StringIsNull">
																									<target>
																										<typeReferenceExpression type="Controller"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="s"/>
																									</parameters>
																								</methodInvokeExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="Add">
																									<target>
																										<variableReferenceExpression name="values"/>
																									</target>
																									<parameters>
																										<primitiveExpression value="null"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																							<falseStatements>
																								<methodInvokeExpression methodName="Add">
																									<target>
																										<variableReferenceExpression name="values"/>
																									</target>
																									<parameters>
																										<methodInvokeExpression methodName="StringToValue">
																											<target>
																												<typeReferenceExpression type="Controller"/>
																											</target>
																											<parameters>
																												<variableReferenceExpression name="s"/>
																											</parameters>
																										</methodInvokeExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</falseStatements>
																						</conditionStatement>
																					</statements>
																				</foreachStatement>
																				<assignStatement>
																					<variableReferenceExpression name="v"/>
																					<methodInvokeExpression methodName="ToArray">
																						<target>
																							<variableReferenceExpression name="values"/>
																						</target>
																					</methodInvokeExpression>
																				</assignStatement>
																			</trueStatements>
																			<falseStatements>
																				<assignStatement>
																					<variableReferenceExpression name="v"/>
																					<methodInvokeExpression methodName="StringToValue">
																						<target>
																							<typeReferenceExpression type="Controller"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="filterValue"/>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																			</falseStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
																<assignStatement>
																	<variableReferenceExpression name="fvo"/>
																	<objectCreateExpression type="FilterValue">
																		<parameters>
																			<variableReferenceExpression name="fieldAlias"/>
																			<variableReferenceExpression name="operation"/>
																			<variableReferenceExpression name="v"/>
																		</parameters>
																	</objectCreateExpression>
																</assignStatement>
																<breakStatement/>
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
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="fvo"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="IdentityInequality">
												<fieldReferenceExpression name="requestExternalFilter"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="FieldValue" name="v"/>
											<target>
												<fieldReferenceExpression name="requestExternalFilter"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Equals">
															<target>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="v"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<argumentReferenceExpression name="fieldName"/>
																<propertyReferenceExpression name="InvariantCultureIgnoreCase">
																	<typeReferenceExpression type="StringComparison"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="fvo"/>
															<objectCreateExpression type="FilterValue">
																<parameters>
																	<argumentReferenceExpression name="fieldName"/>
																	<primitiveExpression value="="/>
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="v"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
														<breakStatement/>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="fvo"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ExecuteSelect(string, string, string[[], fieldValue[], string) -->
						<memberField type="System.String[]" name="requestFilter"/>
						<memberField type="FieldValue[]" name="requestExternalFilter"/>
						<memberMethod name="ExecuteSelect">
							<attributes final="true" private="true"/>
							<parameters>
								<parameter type="System.String" name="controllerName"/>
								<parameter type="System.String" name="viewId"/>
								<parameter type="System.String[]" name="filter"/>
								<parameter type="FieldValue[]" name="externalFilter"/>
								<parameter type="ActionPhase" name="phase"/>
								<parameter type="System.String" name="commandName"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="requestFilter">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="filter"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="requestExternalFilter">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="externalFilter"/>
								</assignStatement>
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
																<unaryOperatorExpression operator="IsNullOrEmpty">
																	<propertyReferenceExpression name="Controller">
																		<variableReferenceExpression name="action"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
																<binaryOperatorExpression operator="BooleanOr">
																	<binaryOperatorExpression operator="ValueEquality">
																		<propertyReferenceExpression name="Controller">
																			<variableReferenceExpression name="action"/>
																		</propertyReferenceExpression>
																		<argumentReferenceExpression name="controllerName"/>
																	</binaryOperatorExpression>
																	<methodInvokeExpression methodName="IsMatch">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<argumentReferenceExpression name="controllerName"/>
																			<propertyReferenceExpression name="Controller">
																				<variableReferenceExpression name="action"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanOr">
																<unaryOperatorExpression operator="IsNullOrEmpty">
																	<propertyReferenceExpression name="View">
																		<variableReferenceExpression name="action"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
																<binaryOperatorExpression operator="BooleanOr">
																	<binaryOperatorExpression operator="ValueEquality">
																		<propertyReferenceExpression name="View">
																			<variableReferenceExpression name="action"/>
																		</propertyReferenceExpression>
																		<argumentReferenceExpression name="viewId"/>
																	</binaryOperatorExpression>
																	<methodInvokeExpression methodName="IsMatch">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<argumentReferenceExpression name="viewId"/>
																			<propertyReferenceExpression name="View">
																				<argumentReferenceExpression name="action"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
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
																		<argumentReferenceExpression name="commandName"/>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="ValueEquality">
																		<propertyReferenceExpression name="Phase">
																			<variableReferenceExpression name="action"/>
																		</propertyReferenceExpression>
																		<argumentReferenceExpression name="phase"/>
																	</binaryOperatorExpression>
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
																		<variableDeclarationStatement type="FilterValue" name="fvo">
																			<init>
																				<methodInvokeExpression methodName="SelectFilterValue">
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
																					<variableReferenceExpression name="fvo"/>
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
																								<typeofExpression type="FilterValue"/>
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
																							<variableReferenceExpression name="fvo"/>
																						</assignStatement>
																					</trueStatements>
																					<falseStatements>
																						<tryStatement>
																							<statements>
																								<conditionStatement>
																									<condition>
																										<propertyReferenceExpression name="IsArray">
																											<propertyReferenceExpression name="ParameterType">
																												<variableReferenceExpression name="p"/>
																											</propertyReferenceExpression>
																										</propertyReferenceExpression>
																									</condition>
																									<trueStatements>
																										<variableDeclarationStatement type="ArrayList" name="list">
																											<init>
																												<objectCreateExpression type="ArrayList"/>
																											</init>
																										</variableDeclarationStatement>
																										<foreachStatement>
																											<variable type="System.Object" name="o"/>
																											<target>
																												<propertyReferenceExpression name="Values">
																													<variableReferenceExpression name="fvo"/>
																												</propertyReferenceExpression>
																											</target>
																											<statements>
																												<variableDeclarationStatement type="System.Object" name="elemValue">
																													<init>
																														<primitiveExpression value="null"/>
																													</init>
																												</variableDeclarationStatement>
																												<tryStatement>
																													<statements>
																														<assignStatement>
																															<variableReferenceExpression name="elemValue"/>
																															<methodInvokeExpression methodName="ConvertToType">
																																<target>
																																	<typeReferenceExpression type="Controller"/>
																																</target>
																																<parameters>
																																	<methodInvokeExpression methodName="GetElementType">
																																		<target>
																																			<propertyReferenceExpression name="ParameterType">
																																				<variableReferenceExpression name="p"/>
																																			</propertyReferenceExpression>
																																		</target>
																																	</methodInvokeExpression>
																																	<variableReferenceExpression name="o"/>
																																</parameters>
																															</methodInvokeExpression>
																														</assignStatement>
																													</statements>
																													<catch exceptionType="Exception">
																													</catch>
																												</tryStatement>
																												<methodInvokeExpression methodName="Add">
																													<target>
																														<variableReferenceExpression name="list"/>
																													</target>
																													<parameters>
																														<variableReferenceExpression name="elemValue"/>
																													</parameters>
																												</methodInvokeExpression>
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
																											<methodInvokeExpression methodName="ToArray">
																												<target>
																													<variableReferenceExpression name="list"/>
																												</target>
																												<parameters>
																													<methodInvokeExpression methodName="GetElementType">
																														<target>
																															<propertyReferenceExpression name="ParameterType">
																																<variableReferenceExpression name="p"/>
																															</propertyReferenceExpression>
																														</target>
																													</methodInvokeExpression>
																												</parameters>
																											</methodInvokeExpression>
																										</assignStatement>
																									</trueStatements>
																									<falseStatements>
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
																													<typeReferenceExpression type="Controller"/>
																												</target>
																												<parameters>
																													<propertyReferenceExpression name="ParameterType">
																														<variableReferenceExpression name="p"/>
																													</propertyReferenceExpression>
																													<propertyReferenceExpression name="Value">
																														<variableReferenceExpression name="fvo"/>
																													</propertyReferenceExpression>
																												</parameters>
																											</methodInvokeExpression>
																										</assignStatement>
																									</falseStatements>
																								</conditionStatement>
																							</statements>
																							<catch exceptionType="Exception">
																							</catch>
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
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
						<!-- method ChangeFilter(params FilterValue[]) -->
						<memberMethod name="ChangeFilter">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="params FilterValue[]" name="filter"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ApplyFilter">
									<parameters>
										<primitiveExpression value="false"/>
										<argumentReferenceExpression name="filter"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method AssignFilter(params FilterValue[]) -->
						<memberMethod name="AssignFilter">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="params FilterValue[]" name="filter"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ApplyFilter">
									<parameters>
										<primitiveExpression value="true"/>
										<argumentReferenceExpression name="filter"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ApplyFilter(params FilterValue[]) -->
						<memberMethod name="ApplyFilter">
							<attributes private="true"/>
							<parameters>
								<parameter type="System.Boolean" name="replace"/>
								<parameter type="params FilterValue[]" name="filter"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="List" name="newFilter">
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
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<argumentReferenceExpression name="replace"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="List" name="currentFilter">
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
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<propertyReferenceExpression name="Page"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="IdentityInequality">
														<propertyReferenceExpression name="Filter">
															<propertyReferenceExpression name="Page"/>
														</propertyReferenceExpression>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="AddRange">
													<target>
														<variableReferenceExpression name="currentFilter"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Filter">
															<propertyReferenceExpression name="Page"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="IdentityInequality">
																<propertyReferenceExpression name="Result"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="IdentityInequality">
																<propertyReferenceExpression name="Filter">
																	<propertyReferenceExpression name="Result"/>
																</propertyReferenceExpression>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="AddRange">
															<target>
																<variableReferenceExpression name="currentFilter"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Filter">
																	<propertyReferenceExpression name="Result"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
										<foreachStatement>
											<variable type="FilterValue" name="fvo"/>
											<target>
												<argumentReferenceExpression name="filter"/>
											</target>
											<statements>
												<variableDeclarationStatement type="System.Int32" name="i">
													<init>
														<primitiveExpression value="0"/>
													</init>
												</variableDeclarationStatement>
												<whileStatement>
													<test>
														<binaryOperatorExpression operator="LessThan">
															<variableReferenceExpression name="i"/>
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="currentFilter"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</test>
													<statements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="StartsWith">
																	<target>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="currentFilter"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="i"/>
																			</indices>
																		</arrayIndexerExpression>
																	</target>
																	<parameters>
																		<binaryOperatorExpression operator="Add">
																			<propertyReferenceExpression name="Name">
																				<variableReferenceExpression name="fvo"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value=":"/>
																		</binaryOperatorExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="RemoveAt">
																	<target>
																		<variableReferenceExpression name="currentFilter"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="i"/>
																	</parameters>
																</methodInvokeExpression>
																<breakStatement/>
															</trueStatements>
															<falseStatements>
																<assignStatement>
																	<variableReferenceExpression name="i"/>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="i"/>
																		<primitiveExpression value="1"/>
																	</binaryOperatorExpression>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
													</statements>
												</whileStatement>
												<assignStatement>
													<variableReferenceExpression name="newFilter"/>
													<objectCreateExpression type="List">
														<typeArguments>
															<typeReference type="System.String"/>
														</typeArguments>
														<parameters>
															<variableReferenceExpression name="currentFilter"/>
														</parameters>
													</objectCreateExpression>
												</assignStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<foreachStatement>
									<variable type="FilterValue" name="fvo"/>
									<target>
										<argumentReferenceExpression name="filter"/>
									</target>
									<statements>
										<variableDeclarationStatement type="System.String" name="filterValue">
											<init>
												<primitiveExpression value="%js%null"/>
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
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="fvo"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="StringBuilder" name="sb">
													<init>
														<objectCreateExpression type="StringBuilder"/>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="separator">
													<init>
														<primitiveExpression value="$or$"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="FilterOperation">
																<variableReferenceExpression name="fvo"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Between">
																<typeReferenceExpression type="RowFilterOperation"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="separator"/>
															<primitiveExpression value="$and$"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<foreachStatement>
													<variable type="System.Object" name="o"/>
													<target>
														<propertyReferenceExpression name="Values">
															<variableReferenceExpression name="fvo"/>
														</propertyReferenceExpression>
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
																		<variableReferenceExpression name="separator"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="Append">
															<target>
																<variableReferenceExpression name="sb"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ValueToString">
																	<target>
																		<typeReferenceExpression type="Controller"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="o"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
												<assignStatement>
													<variableReferenceExpression name="filterValue"/>
													<methodInvokeExpression methodName="ToString">
														<target>
															<variableReferenceExpression name="sb"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="newFilter"/>
											</target>
											<parameters>
												<stringFormatExpression format="{{0}}:{{1}}{{2}}">
													<propertyReferenceExpression name="Name">
														<variableReferenceExpression name="fvo"/>
													</propertyReferenceExpression>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="ComparisonOperations">
																<typeReferenceExpression type="RowFilterAttribute"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<castExpression targetType="System.Int32">
																<propertyReferenceExpression name="FilterOperation">
																	<variableReferenceExpression name="fvo"/>
																</propertyReferenceExpression>
															</castExpression>
														</indices>
													</arrayIndexerExpression>
													<variableReferenceExpression name="filterValue"/>
												</stringFormatExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="requestExternalFilter"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="FieldValue" name="v"/>
											<target>
												<fieldReferenceExpression name="requestExternalFilter"/>
											</target>
											<statements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="newFilter"/>
													</target>
													<parameters>
														<stringFormatExpression format="{{0}}:={{1}}">
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="v"/>
															</propertyReferenceExpression>
															<methodInvokeExpression methodName="ValueToString">
																<target>
																	<typeReferenceExpression type="Controller"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="v"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</stringFormatExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Page"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ChangeFilter">
											<target>
												<propertyReferenceExpression name="Page"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="ToArray">
													<target>
														<variableReferenceExpression name="newFilter"/>
													</target>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<fieldReferenceExpression name="requestFilter"/>
											<propertyReferenceExpression name="Filter">
												<propertyReferenceExpression name="Page"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Result"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Filter">
												<propertyReferenceExpression name="Result"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToArray">
												<target>
													<variableReferenceExpression name="newFilter"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- property Tags -->
						<memberProperty type="System.String" name="Tags">
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Page"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Tag">
												<propertyReferenceExpression name="Page"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Arguments"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<propertyReferenceExpression name="Tag">
														<propertyReferenceExpression name="Result"/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Tag">
														<propertyReferenceExpression name="Result"/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="Tag">
														<propertyReferenceExpression name="Arguments"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<propertyReferenceExpression name="Tag">
												<propertyReferenceExpression name="Result"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="DistinctValueRequest"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Tag">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="DistinctValueRequest"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="PageRequest"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Tag">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="PageRequest"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Page"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Tag">
												<propertyReferenceExpression name="Page"/>
											</propertyReferenceExpression>
											<propertySetValueReferenceExpression/>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="Result"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Tag">
														<propertyReferenceExpression name="Result"/>
													</propertyReferenceExpression>
													<propertySetValueReferenceExpression/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
							</setStatements>
						</memberProperty>
						<!-- method Create(ControllerConfiguration) -->
						<memberMethod returnType="BusinessRules" name="Create">
							<attributes static="true" public="true"/>
							<parameters>
								<parameter type="ControllerConfiguration" name="config"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="Type" name="t">
									<init>
										<typeofExpression type="BusinessRules"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="BusinessRules" name="rules">
									<init>
										<castExpression targetType="BusinessRules">
											<methodInvokeExpression methodName="CreateInstance">
												<target>
													<propertyReferenceExpression name="Assembly">
														<variableReferenceExpression name="t"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<propertyReferenceExpression name="FullName">
														<variableReferenceExpression name="t"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Config">
										<variableReferenceExpression name="rules"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="config"/>
								</assignStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="rules"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ResolveFieldValuesForMultipleSelection(ActionArgs) -->
						<memberMethod returnType="System.Boolean" name="ResolveFieldValuesForMultipleSelection">
							<attributes family="true"/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<unaryOperatorExpression operator="Not">
										<methodInvokeExpression methodName="IsMatch">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="CommandName">
													<variableReferenceExpression name="args"/>
												</propertyReferenceExpression>
												<primitiveExpression value="^(Report|Export)"/>
											</parameters>
										</methodInvokeExpression>
									</unaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ProcessSpecialActions(ActionArgs, ActionResult) -->
						<memberMethod name="ProcessSpecialActions">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="Arguments">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="args"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Result">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="result"/>
								</assignStatement>
								<variableDeclarationStatement type="System.Boolean" name="multipleSelection">
									<init>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Length">
												<propertyReferenceExpression name="SelectedValues">
													<argumentReferenceExpression name="args"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="1"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="List" name="fields">
									<typeArguments>
										<typeReference type="DataField"/>
									</typeArguments>
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<variableReferenceExpression name="multipleSelection"/>
											<unaryOperatorExpression operator="Not">
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="LastCommandName">
															<argumentReferenceExpression name="args"/>
														</propertyReferenceExpression>
														<primitiveExpression value="Edit"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="LastCommandName">
															<argumentReferenceExpression name="args"/>
														</propertyReferenceExpression>
														<primitiveExpression value="New"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="List" name="keyFields">
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
										<variableDeclarationStatement type="XPathNodeIterator" name="keyFieldIterator">
											<init>
												<methodInvokeExpression methodName="Select">
													<target>
														<propertyReferenceExpression name="Config"/>
													</target>
													<parameters>
														<primitiveExpression value="/c:dataController/c:fields/c:field[@isPrimaryKey='true']/@name"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<methodInvokeExpression methodName="MoveNext">
													<target>
														<variableReferenceExpression name="keyFieldIterator"/>
													</target>
												</methodInvokeExpression>
											</test>
											<statements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="keyFields"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Value">
															<propertyReferenceExpression name="Current">
																<variableReferenceExpression name="keyFieldIterator"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</whileStatement>
										<foreachStatement>
											<variable type="System.String" name="key"/>
											<target>
												<propertyReferenceExpression name="SelectedValues">
													<argumentReferenceExpression name="args"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<methodInvokeExpression methodName="ClearBlackAndWhiteLists"/>
												<variableDeclarationStatement type="System.String[]" name="keyValues">
													<init>
														<methodInvokeExpression methodName="Split">
															<target>
																<variableReferenceExpression name="key"/>
															</target>
															<parameters>
																<primitiveExpression value="," convertTo="Char"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="List" name="filter">
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
												<variableDeclarationStatement type="System.Int32" name="index">
													<init>
														<primitiveExpression value="0"/>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable type="System.String" name="fieldName"/>
													<target>
														<variableReferenceExpression name="keyFields"/>
													</target>
													<statements>
														<variableDeclarationStatement type="FieldValue" name="fvo">
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
																	<variableReferenceExpression name="fvo"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="NewValue">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="keyValues"/>
																		</target>
																		<indices>
																			<variableReferenceExpression name="index"/>
																		</indices>
																	</arrayIndexerExpression>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="OldValue">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="NewValue">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="Modified">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="false"/>
																</assignStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="filter"/>
																	</target>
																	<parameters>
																		<stringFormatExpression format="{{0}}:={{1}}">
																			<variableReferenceExpression name="fieldName"/>
																			<methodInvokeExpression methodName="ValueToString">
																				<target>
																					<typeReferenceExpression type="DataControllerBase"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="Value">
																						<variableReferenceExpression name="fvo"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</stringFormatExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<assignStatement>
															<variableReferenceExpression name="index"/>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="index"/>
																<primitiveExpression value="1"/>
															</binaryOperatorExpression>
														</assignStatement>
													</statements>
												</foreachStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<variableReferenceExpression name="multipleSelection"/>
															<methodInvokeExpression methodName="ResolveFieldValuesForMultipleSelection">
																<parameters>
																	<argumentReferenceExpression name="args"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="PageRequest" name="r">
															<init>
																<objectCreateExpression type="PageRequest">
																	<parameters>
																		<primitiveExpression value="0"/>
																		<primitiveExpression value="1"/>
																		<stringEmptyExpression/>
																		<methodInvokeExpression methodName="ToArray">
																			<target>
																				<variableReferenceExpression name="filter"/>
																			</target>
																		</methodInvokeExpression>
																	</parameters>
																</objectCreateExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<propertyReferenceExpression name="Controller">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Controller">
																<argumentReferenceExpression name="args"/>
															</propertyReferenceExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="View">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="View">
																<argumentReferenceExpression name="args"/>
															</propertyReferenceExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Tag">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Tag">
																<argumentReferenceExpression name="args"/>
															</propertyReferenceExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="RequiresMetaData">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="IdentityEquality">
																<variableReferenceExpression name="fields"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="DisableJSONCompatibility">
																<variableReferenceExpression name="r"/>
															</propertyReferenceExpression>
															<primitiveExpression value="true"/>
														</assignStatement>
														<variableDeclarationStatement type="ViewPage" name="p">
															<init>
																<methodInvokeExpression methodName="GetPage">
																	<target>
																		<methodInvokeExpression methodName="CreateDataController">
																			<target>
																				<typeReferenceExpression type="ControllerFactory"/>
																			</target>
																		</methodInvokeExpression>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Controller">
																			<variableReferenceExpression name="r"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="View">
																			<variableReferenceExpression name="r"/>
																		</propertyReferenceExpression>
																		<variableReferenceExpression name="r"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityEquality">
																	<variableReferenceExpression name="fields"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="fields"/>
																	<propertyReferenceExpression name="Fields">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Count">
																		<propertyReferenceExpression name="Rows">
																			<variableReferenceExpression name="p"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																	<primitiveExpression value="1"/>
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
																				<variableReferenceExpression name="fields"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</test>
																	<increment>
																		<variableReferenceExpression name="i"/>
																	</increment>
																	<statements>
																		<variableDeclarationStatement type="DataField" name="f">
																			<init>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="fields"/>
																					</target>
																					<indices>
																						<variableReferenceExpression name="i"/>
																					</indices>
																				</arrayIndexerExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<propertyReferenceExpression name="IsPrimaryKey">
																						<variableReferenceExpression name="f"/>
																					</propertyReferenceExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement type="FieldValue" name="fvo">
																					<init>
																						<methodInvokeExpression methodName="SelectFieldValueObject">
																							<parameters>
																								<propertyReferenceExpression name="Name">
																									<variableReferenceExpression name="f"/>
																								</propertyReferenceExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="IdentityInequality">
																							<variableReferenceExpression name="fvo"/>
																							<primitiveExpression value="null"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<propertyReferenceExpression name="NewValue">
																								<variableReferenceExpression name="fvo"/>
																							</propertyReferenceExpression>
																							<arrayIndexerExpression>
																								<target>
																									<arrayIndexerExpression>
																										<target>
																											<propertyReferenceExpression name="Rows">
																												<variableReferenceExpression name="p"/>
																											</propertyReferenceExpression>
																										</target>
																										<indices>
																											<primitiveExpression value="0"/>
																										</indices>
																									</arrayIndexerExpression>
																								</target>
																								<indices>
																									<variableReferenceExpression name="i"/>
																								</indices>
																							</arrayIndexerExpression>
																						</assignStatement>
																						<assignStatement>
																							<propertyReferenceExpression name="OldValue">
																								<variableReferenceExpression name="fvo"/>
																							</propertyReferenceExpression>
																							<propertyReferenceExpression name="NewValue">
																								<variableReferenceExpression name="fvo"/>
																							</propertyReferenceExpression>
																						</assignStatement>
																						<assignStatement>
																							<propertyReferenceExpression name="Modified">
																								<variableReferenceExpression name="fvo"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="false"/>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</forStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="ProcessSpecialActions">
													<parameters>
														<argumentReferenceExpression name="args"/>
													</parameters>
												</methodInvokeExpression>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="CanceledSelectedValues">
															<argumentReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<breakStatement/>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="ProcessSpecialActions">
											<parameters>
												<argumentReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ProcessSpecialActions(ActionArgs) -->
						<memberMethod name="ProcessSpecialActions">
							<attributes family="true" />
							<parameters>
								<parameter type="ActionArgs" name="args"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IgnoreBusinessRules">
											<argumentReferenceExpression name="args"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<xsl:if test="$IsUnlimited='true'">
									<methodInvokeExpression methodName="Evaluate">
										<target>
											<typeReferenceExpression type="AutoFill"/>
										</target>
										<parameters>
											<thisReferenceExpression/>
										</parameters>
									</methodInvokeExpression>
								</xsl:if>
								<methodInvokeExpression methodName="ExecuteServerRules">
									<parameters>
										<argumentReferenceExpression name="args"/>
										<propertyReferenceExpression name="Result"/>
										<propertyReferenceExpression name="Before">
											<typeReferenceExpression type="ActionPhase"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="Canceled">
												<propertyReferenceExpression name="Result"/>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<!--<methodInvokeExpression methodName="ExecuteServerRules">
                      <parameters>
                        <argumentReferenceExpression name="args"/>
                        <propertyReferenceExpression name="Result"/>
                        <propertyReferenceExpression name="Execute">
                          <typeReferenceExpression type="ActionPhase"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>-->
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<propertyReferenceExpression name="ActionData"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<propertyReferenceExpression name="CommandName">
																<argumentReferenceExpression name="args"/>
															</propertyReferenceExpression>
															<primitiveExpression value="SQL"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Sql">
															<parameters>
																<propertyReferenceExpression name="ActionData"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<xsl:if test="$IsPremium='true'">
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueEquality">
																<propertyReferenceExpression name="CommandName">
																	<argumentReferenceExpression name="args"/>
																</propertyReferenceExpression>
																<primitiveExpression value="Email"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<methodInvokeExpression methodName="Email">
																<parameters>
																	<propertyReferenceExpression name="ActionData"/>
																</parameters>
															</methodInvokeExpression>
														</trueStatements>
													</conditionStatement>
												</xsl:if>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="ExecuteServerRules">
											<parameters>
												<argumentReferenceExpression name="args"/>
												<propertyReferenceExpression name="Result"/>
												<propertyReferenceExpression name="After">
													<typeReferenceExpression type="ActionPhase"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method Sql(string, params ParameterValue[])-->
						<memberMethod returnType="System.Int32" name="Sql">
							<comment>
								<![CDATA[
/// <summary>
        /// Executes the SQL statements specified in the 'text' argument. Any parameter referenced in the text is provided with a value if the parameter name is matched to the name of a data field. 
        /// </summary>
        /// <param name="text">The text composed of valid SQL statements.  
        /// Parameter names can reference data fields as @FieldName, @FieldName_Value, @FieldName_OldValue, and @FieldName_NewValue. 
        /// Use the parameter marker supported by the database server.</param>
        /// <param name="parameters">Optional list of parameter values used if a matching data field is not found.</param>
        /// <returns>The number of records affected by execute of SQL statements</returns>
        ]]>
							</comment>
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="text"/>
								<parameter type="params ParameterValue[]" name="parameters"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Sql">
										<parameters>
											<argumentReferenceExpression name="text"/>
											<!-- Config.ConnectionStringName-->
											<propertyReferenceExpression name="ConnectionStringName">
												<propertyReferenceExpression name="Config"/>
											</propertyReferenceExpression>
											<argumentReferenceExpression name="parameters"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateSqlParameter(SqlText, string, object, string, string) -->
						<memberMethod name="CreateSqlParameter">
							<attributes family="true"/>
							<parameters>
								<parameter type="SqlText" name="query"/>
								<parameter type="System.String" name="parameterName"/>
								<parameter type="System.Object" name="parameterValue"/>
								<parameter type="System.String" name="fieldType"/>
								<parameter type="System.String" name="fieldLen"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="DbParameter" name="p">
									<init>
										<methodInvokeExpression methodName="AddParameter">
											<target>
												<argumentReferenceExpression name="query"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="parameterName"/>
												<argumentReferenceExpression name="parameterValue"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<argumentReferenceExpression name="fieldType"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Direction">
												<variableReferenceExpression name="p"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="InputOutput">
												<typeReferenceExpression type="ParameterDirection"/>
											</propertyReferenceExpression>
										</assignStatement>
										<methodInvokeExpression methodName="AssignParameterValue">
											<target>
												<typeReferenceExpression type="DataControllerBase"/>
											</target>
											<parameters>
												<variableReferenceExpression name="p"/>
												<argumentReferenceExpression name="fieldType"/>
												<argumentReferenceExpression name="parameterValue"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<argumentReferenceExpression name="fieldLen"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Size">
														<variableReferenceExpression name="p"/>
													</propertyReferenceExpression>
													<convertExpression to="Int32">
														<argumentReferenceExpression name="fieldLen"/>
													</convertExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<argumentReferenceExpression name="fieldType"/>
															<primitiveExpression value="String"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="Direction">
																<variableReferenceExpression name="p"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Input">
																<typeReferenceExpression type="ParameterDirection"/>
															</propertyReferenceExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<argumentReferenceExpression name="fieldType"/>
																	<primitiveExpression value="Decimal"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="Precision">
																		<castExpression targetType="IDbDataParameter">
																			<variableReferenceExpression name="p"/>
																		</castExpression>
																	</propertyReferenceExpression>
																	<primitiveExpression value="38"/>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="Scale">
																		<castExpression targetType="IDbDataParameter">
																			<variableReferenceExpression name="p"/>
																		</castExpression>
																	</propertyReferenceExpression>
																	<primitiveExpression value="10"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method Sql(string, string, params ParameterValue[]) -->
						<memberField type="Regex" name="SqlFieldFilterOperationRegex">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression>
											<xsl:attribute name="value"><![CDATA[^(?'Name'\w+?)_Filter_((?'Operation'\w+?)(?'Index'\d*))?$]]></xsl:attribute>
										</primitiveExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<memberMethod returnType="System.Int32" name="Sql">
							<comment>
								<![CDATA[
        /// <summary>
        /// Executes the SQL statements specified in the 'text' argument. Any parameter referenced in the text is provided with a value if the parameter name is matched to the name of a data field. 
        /// </summary>
        /// <param name="text">The text composed of valid SQL statements.  
        /// Parameter names can reference data fields as @FieldName, @FieldName_Value, @FieldName_OldValue, and @FieldName_NewValue. 
        /// Use the parameter marker supported by the database server.</param>
        /// <param name="connectionStringName">The name of the database connection string.</param>
        /// <param name="parameters">Optional list of parameter values used if a matching data field is not found.</param>
        /// <returns>The number of records affected by execute of SQL statements</returns>
              ]]>
							</comment>
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="text"/>
								<parameter type="System.String" name="connectionStringName"/>
								<parameter type="params ParameterValue[]" name="parameters"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="resultSetCacheVar">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="Not">
												<propertyReferenceExpression name="EnableResultSet"/>
											</unaryOperatorExpression>
											<methodInvokeExpression methodName="Contains">
												<target>
													<argumentReferenceExpression name="text"/>
												</target>
												<parameters>
													<primitiveExpression value="BusinessRules_EnableResultSet"/>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="EnableResultSet"/>
											<primitiveExpression value="true"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<propertyReferenceExpression name="EnableResultSet"/>
											<binaryOperatorExpression operator="GreaterThan">
												<propertyReferenceExpression name="ResultSetCacheDuration"/>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="resultSetCacheVar"/>
											<binaryOperatorExpression operator="Add">
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="ResultSet_"/>
													<propertyReferenceExpression name="Controller">
														<fieldReferenceExpression name="page"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="_"/>
													<propertyReferenceExpression name="View">
														<fieldReferenceExpression name="page"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="ResultSet"/>
											<castExpression targetType="DataTable">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Cache">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<variableReferenceExpression name="resultSetCacheVar"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="ResultSet"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="0"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<argumentReferenceExpression name="text"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="text"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[(^|\n).*?Debug\s+([\s\S]+?)End Debug(\s+|$)]]></xsl:attribute>
											</primitiveExpression>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="IgnoreCase">
												<typeReferenceExpression type="RegexOptions"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement type="System.Boolean" name="buildingRow">
									<init>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<fieldReferenceExpression name="page"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="IdentityInequality">
												<fieldReferenceExpression name="row"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="List" name="names">
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
								<usingStatement >
									<variable type="SqlText" name="query">
										<init>
											<objectCreateExpression type="SqlText">
												<parameters>
													<argumentReferenceExpression name="text"/>
													<argumentReferenceExpression name="connectionStringName"/>
												</parameters>
											</objectCreateExpression>
										</init>
									</variable>
									<statements>
										<variableDeclarationStatement type="Regex" name="paramRegex">
											<init>
												<objectCreateExpression type="Regex">
													<parameters>
														<stringFormatExpression format="({{0}}(?'FieldName'\w+?)_(?'ValueType'OldValue|NewValue|Value|Modified|FilterValue\d?|FilterOperation|Filter_\w+))|({{0}}(?'FieldName'\w+))">
															<methodInvokeExpression methodName="Escape">
																<target>
																	<typeReferenceExpression type="Regex"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="ParameterMarker">
																		<variableReferenceExpression name="query"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</stringFormatExpression>
														<propertyReferenceExpression name="IgnoreCase">
															<typeReferenceExpression type="RegexOptions"/>
														</propertyReferenceExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="Match" name="m">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<variableReferenceExpression name="paramRegex"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="text"/>
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
												<variableDeclarationStatement type="System.String" name="fieldName">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="FieldName"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="valueType">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="m"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="ValueType"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="paramName">
													<init>
														<propertyReferenceExpression name="Value">
															<variableReferenceExpression name="m"/>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Contains">
																<target>
																	<variableReferenceExpression name="names"/>
																</target>
																<parameters>
																	<methodInvokeExpression methodName="ToLower">
																		<target>
																			<variableReferenceExpression name="paramName"/>
																		</target>
																	</methodInvokeExpression>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="names"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ToLower">
																	<target>
																		<variableReferenceExpression name="paramName"/>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<variableDeclarationStatement type="System.String" name="fieldType">
															<init>
																<primitiveExpression value="null"/>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.String" name="fieldLen">
															<init>
																<primitiveExpression value="null"/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<propertyReferenceExpression name="Config"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="XPathNavigator" name="fieldNav">
																	<init>
																		<methodInvokeExpression methodName="SelectSingleNode">
																			<target>
																				<propertyReferenceExpression name="Config"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="/c:dataController/c:fields/c:field[@name='{{0}}']"/>
																				<variableReferenceExpression name="fieldName"/>
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
																			<variableReferenceExpression name="fieldType"/>
																			<methodInvokeExpression methodName="GetAttribute">
																				<target>
																					<variableReferenceExpression name="fieldNav"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="type"/>
																					<propertyReferenceExpression name="Empty">
																						<typeReferenceExpression type="String"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																		<assignStatement>
																			<variableReferenceExpression name="fieldLen"/>
																			<methodInvokeExpression methodName="GetAttribute">
																				<target>
																					<variableReferenceExpression name="fieldNav"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="length"/>
																					<propertyReferenceExpression name="Empty">
																						<typeReferenceExpression type="String"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="StartsWith">
																	<target>
																		<variableReferenceExpression name="fieldName"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="Parameters_"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="System.Object" name="v">
																	<init>
																		<primitiveExpression value="null"/>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="FieldValue" name="fvo">
																	<init>
																		<methodInvokeExpression methodName="SelectFieldValueObject">
																			<parameters>
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
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="fvo"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="v"/>
																			<propertyReferenceExpression name="Value">
																				<variableReferenceExpression name="fvo"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<variableReferenceExpression name="fieldType"/>
																			<primitiveExpression value="String"/>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="CreateSqlParameter">
																	<parameters>
																		<variableReferenceExpression name="query"/>
																		<variableReferenceExpression name="paramName"/>
																		<variableReferenceExpression name="v"/>
																		<variableReferenceExpression name="fieldType"/>
																		<primitiveExpression value="null"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<methodInvokeExpression methodName="StartsWith">
																				<target>
																					<variableReferenceExpression name="valueType"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="Filter"/>
																				</parameters>
																			</methodInvokeExpression>
																			<unaryOperatorExpression operator="IsNotNullOrEmpty">
																				<variableReferenceExpression name="fieldType"/>
																			</unaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="System.Object" name="v">
																			<init>
																				<primitiveExpression value="null"/>
																			</init>
																		</variableDeclarationStatement>
																		<variableDeclarationStatement type="FilterValue" name="filter">
																			<init>
																				<methodInvokeExpression methodName="SelectFilterValue">
																					<parameters>
																						<variableReferenceExpression name="fieldName"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityInequality">
																					<variableReferenceExpression name="filter"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="BooleanOr">
																							<binaryOperatorExpression operator="ValueEquality">
																								<variableReferenceExpression name="valueType"/>
																								<primitiveExpression value="FilterValue"/>
																							</binaryOperatorExpression>
																							<binaryOperatorExpression operator="ValueEquality">
																								<variableReferenceExpression name="valueType"/>
																								<primitiveExpression value="FilterValue1"/>
																							</binaryOperatorExpression>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="v"/>
																							<propertyReferenceExpression name="Value">
																								<variableReferenceExpression name="filter"/>
																							</propertyReferenceExpression>
																						</assignStatement>
																					</trueStatements>
																					<falseStatements>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="BooleanAnd">
																									<binaryOperatorExpression operator="ValueEquality">
																										<variableReferenceExpression name="valueType"/>
																										<primitiveExpression value="FilterValue2"/>
																									</binaryOperatorExpression>
																									<binaryOperatorExpression operator="GreaterThan">
																										<propertyReferenceExpression name="Length">
																											<propertyReferenceExpression name="Values">
																												<variableReferenceExpression name="filter"/>
																											</propertyReferenceExpression>
																										</propertyReferenceExpression>
																										<primitiveExpression value="1"/>
																									</binaryOperatorExpression>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<assignStatement>
																									<variableReferenceExpression name="v"/>
																									<arrayIndexerExpression>
																										<target>
																											<propertyReferenceExpression name="Values">
																												<variableReferenceExpression name="filter"/>
																											</propertyReferenceExpression>
																										</target>
																										<indices>
																											<primitiveExpression value="1"/>
																										</indices>
																									</arrayIndexerExpression>
																								</assignStatement>
																							</trueStatements>
																							<falseStatements>
																								<conditionStatement>
																									<condition>
																										<binaryOperatorExpression operator="ValueEquality">
																											<variableReferenceExpression name="valueType"/>
																											<primitiveExpression value="FilterOperation"/>
																										</binaryOperatorExpression>
																									</condition>
																									<trueStatements>
																										<assignStatement>
																											<variableReferenceExpression name="v"/>
																											<convertExpression to="String">
																												<propertyReferenceExpression name="FilterOperation">
																													<variableReferenceExpression name="filter"/>
																												</propertyReferenceExpression>
																											</convertExpression>
																										</assignStatement>
																									</trueStatements>
																								</conditionStatement>
																							</falseStatements>
																						</conditionStatement>
																					</falseStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																		<methodInvokeExpression methodName="CreateSqlParameter">
																			<parameters>
																				<variableReferenceExpression name="query"/>
																				<variableReferenceExpression name="paramName"/>
																				<variableReferenceExpression name="v"/>
																				<variableReferenceExpression name="fieldType"/>
																				<variableReferenceExpression name="fieldLen"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																	<falseStatements>
																		<variableDeclarationStatement type="FieldValue" name="fvo">
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
																					<variableReferenceExpression name="fvo"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement type="System.Object" name="v">
																					<init>
																						<propertyReferenceExpression name="Value">
																							<variableReferenceExpression name="fvo"/>
																						</propertyReferenceExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="ValueEquality">
																							<variableReferenceExpression name="valueType"/>
																							<primitiveExpression value="OldValue"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="v"/>
																							<propertyReferenceExpression name="OldValue">
																								<variableReferenceExpression name="fvo"/>
																							</propertyReferenceExpression>
																						</assignStatement>
																					</trueStatements>
																					<falseStatements>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="valueType"/>
																									<primitiveExpression value="NewValue"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<assignStatement>
																									<variableReferenceExpression name="v"/>
																									<propertyReferenceExpression name="NewValue">
																										<variableReferenceExpression name="fvo"/>
																									</propertyReferenceExpression>
																								</assignStatement>
																							</trueStatements>
																							<falseStatements>
																								<conditionStatement>
																									<condition>
																										<binaryOperatorExpression operator="ValueEquality">
																											<variableReferenceExpression name="valueType"/>
																											<primitiveExpression value="Modified"/>
																										</binaryOperatorExpression>
																									</condition>
																									<trueStatements>
																										<assignStatement>
																											<variableReferenceExpression name="fieldType"/>
																											<primitiveExpression value="Boolean"/>
																										</assignStatement>
																										<assignStatement>
																											<variableReferenceExpression name="fieldLen"/>
																											<primitiveExpression value="null"/>
																										</assignStatement>
																										<assignStatement>
																											<variableReferenceExpression name="v"/>
																											<propertyReferenceExpression name="Modified">
																												<variableReferenceExpression name="fvo"/>
																											</propertyReferenceExpression>
																										</assignStatement>
																									</trueStatements>
																								</conditionStatement>
																							</falseStatements>
																						</conditionStatement>
																					</falseStatements>
																				</conditionStatement>
																				<methodInvokeExpression methodName="CreateSqlParameter">
																					<parameters>
																						<variableReferenceExpression name="query"/>
																						<variableReferenceExpression name="paramName"/>
																						<variableReferenceExpression name="v"/>
																						<variableReferenceExpression name="fieldType"/>
																						<variableReferenceExpression name="fieldLen"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																			<falseStatements>
																				<conditionStatement>
																					<condition>
																						<methodInvokeExpression methodName="StartsWith">
																							<target>
																								<variableReferenceExpression name="fieldName"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="Context_"/>
																							</parameters>
																						</methodInvokeExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="CreateSqlParameter">
																							<parameters>
																								<variableReferenceExpression name="query"/>
																								<variableReferenceExpression name="paramName"/>
																								<primitiveExpression value="null"/>
																								<variableReferenceExpression name="fieldType"/>
																								<variableReferenceExpression name="fieldLen"/>
																							</parameters>
																						</methodInvokeExpression>
																					</trueStatements>
																					<falseStatements>
																						<variableDeclarationStatement type="DataField" name="field">
																							<init>
																								<primitiveExpression value="null"/>
																							</init>
																						</variableDeclarationStatement>
																						<conditionStatement>
																							<condition>
																								<variableReferenceExpression name="buildingRow"/>
																							</condition>
																							<trueStatements>
																								<assignStatement>
																									<variableReferenceExpression name="field"/>
																									<methodInvokeExpression methodName="FindField">
																										<target>
																											<propertyReferenceExpression name="Page"/>
																										</target>
																										<parameters>
																											<variableReferenceExpression name="fieldName"/>
																										</parameters>
																									</methodInvokeExpression>
																								</assignStatement>
																								<conditionStatement>
																									<condition>
																										<binaryOperatorExpression operator="IdentityInequality">
																											<variableReferenceExpression name="field"/>
																											<primitiveExpression value="null"/>
																										</binaryOperatorExpression>
																									</condition>
																									<trueStatements>
																										<methodInvokeExpression methodName="CreateSqlParameter">
																											<parameters>
																												<variableReferenceExpression name="query"/>
																												<variableReferenceExpression name="paramName"/>
																												<arrayIndexerExpression>
																													<target>
																														<fieldReferenceExpression name="row"/>
																													</target>
																													<indices>
																														<methodInvokeExpression methodName="IndexOf">
																															<target>
																																<propertyReferenceExpression name="Fields">
																																	<propertyReferenceExpression name="Page"/>
																																</propertyReferenceExpression>
																															</target>
																															<parameters>
																																<variableReferenceExpression name="field"/>
																															</parameters>
																														</methodInvokeExpression>
																													</indices>
																												</arrayIndexerExpression>
																												<variableReferenceExpression name="fieldType"/>
																												<variableReferenceExpression name="fieldLen"/>
																											</parameters>
																										</methodInvokeExpression>
																									</trueStatements>
																								</conditionStatement>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="BooleanAnd">
																									<binaryOperatorExpression operator="IdentityEquality">
																										<variableReferenceExpression name="field"/>
																										<primitiveExpression value="null"/>
																									</binaryOperatorExpression>
																									<unaryOperatorExpression operator="Not">
																										<methodInvokeExpression methodName="IsSystemSqlParameter">
																											<parameters>
																												<variableReferenceExpression name="query"/>
																												<variableReferenceExpression name="paramName"/>
																											</parameters>
																										</methodInvokeExpression>
																									</unaryOperatorExpression>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<foreachStatement>
																									<variable type="ParameterValue" name="pvo"/>
																									<target>
																										<argumentReferenceExpression name="parameters"/>
																									</target>
																									<statements>
																										<conditionStatement>
																											<condition>
																												<methodInvokeExpression methodName="Equals">
																													<target>
																														<propertyReferenceExpression name="Name">
																															<variableReferenceExpression name="pvo"/>
																														</propertyReferenceExpression>
																														<propertyReferenceExpression name="InvariantCultureIgnoreCase">
																															<typeReferenceExpression type="StringComparison"/>
																														</propertyReferenceExpression>
																													</target>
																													<parameters>
																														<variableReferenceExpression name="paramName"/>
																													</parameters>
																												</methodInvokeExpression>
																											</condition>
																											<trueStatements>
																												<assignStatement>
																													<propertyReferenceExpression name="Direction">
																														<methodInvokeExpression methodName="AddParameter">
																															<target>
																																<variableReferenceExpression name="query"/>
																															</target>
																															<parameters>
																																<propertyReferenceExpression name="Name">
																																	<variableReferenceExpression name="pvo"/>
																																</propertyReferenceExpression>
																																<propertyReferenceExpression name="Value">
																																	<variableReferenceExpression name="pvo"/>
																																</propertyReferenceExpression>
																															</parameters>
																														</methodInvokeExpression>
																													</propertyReferenceExpression>
																													<propertyReferenceExpression name="InputOutput">
																														<typeReferenceExpression type="ParameterDirection"/>
																													</propertyReferenceExpression>
																												</assignStatement>
																												<breakStatement/>
																											</trueStatements>
																										</conditionStatement>
																									</statements>
																								</foreachStatement>
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
										<methodInvokeExpression methodName="ConfigureSqlQuery">
											<parameters>
												<variableReferenceExpression name="query"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="EnableDccTest"/>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Read">
															<target>
																<variableReferenceExpression name="query"/>
															</target>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="1"/>
														</methodReturnStatement>
													</trueStatements>
													<falseStatements>
														<methodReturnStatement>
															<primitiveExpression value="0"/>
														</methodReturnStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="EnableResultSet"/>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="ResultSet"/>
															<objectCreateExpression type="DataTable"/>
														</assignStatement>
														<methodInvokeExpression methodName="Load">
															<target>
																<propertyReferenceExpression name="ResultSet"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ExecuteReader">
																	<target>
																		<variableReferenceExpression name="query"/>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
														<foreachStatement>
															<variable type="DataColumn" name="c" var="false"/>
															<target>
																<propertyReferenceExpression name="Columns">
																	<propertyReferenceExpression name="ResultSet"/>
																</propertyReferenceExpression>
															</target>
															<statements>
																<variableDeclarationStatement type="System.String" name="columnName">
																	<init>
																		<propertyReferenceExpression name="ColumnName">
																			<variableReferenceExpression name="c"/>
																		</propertyReferenceExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="IsLetter">
																				<target>
																					<typeReferenceExpression type="Char"/>
																				</target>
																				<parameters>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="columnName"/>
																						</target>
																						<indices>
																							<primitiveExpression value="0"/>
																						</indices>
																					</arrayIndexerExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="columnName"/>
																			<binaryOperatorExpression operator="Add">
																				<primitiveExpression value="n"/>
																				<variableReferenceExpression name="columnName"/>
																			</binaryOperatorExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<assignStatement>
																	<variableReferenceExpression name="columnName"/>
																	<methodInvokeExpression methodName="Replace">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="columnName"/>
																			<primitiveExpression value="\W"/>
																			<primitiveExpression value=""/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="ColumnName">
																		<variableReferenceExpression name="c"/>
																	</propertyReferenceExpression>
																	<variableReferenceExpression name="columnName"/>
																</assignStatement>
															</statements>
														</foreachStatement>
														<assignStatement>
															<propertyReferenceExpression name="ResultSetSize"/>
															<propertyReferenceExpression name="Count">
																<propertyReferenceExpression name="Rows">
																	<propertyReferenceExpression name="ResultSet"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</assignStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="GreaterThan">
																	<propertyReferenceExpression name="ResultSetCacheDuration"/>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<propertyReferenceExpression name="Cache">
																			<propertyReferenceExpression name="Current">
																				<typeReferenceExpression type="HttpContext"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="resultSetCacheVar"/>
																		<methodInvokeExpression methodName="Copy">
																			<target>
																				<propertyReferenceExpression name="ResultSet"/>
																			</target>
																		</methodInvokeExpression>
																		<primitiveExpression value="null"/>
																		<methodInvokeExpression methodName="AddSeconds">
																			<target>
																				<propertyReferenceExpression name="Now">
																					<typeReferenceExpression type="DateTime"/>
																				</propertyReferenceExpression>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="ResultSetCacheDuration"/>
																			</parameters>
																		</methodInvokeExpression>
																		<propertyReferenceExpression name="NoSlidingExpiration">
																			<typeReferenceExpression type="Cache"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Normal">
																			<propertyReferenceExpression name="CacheItemPriority">
																				<propertyReferenceExpression name="Caching">
																					<propertyReferenceExpression name="Web">
																						<typeReferenceExpression type="System"/>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																		<primitiveExpression value="null"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="SqlResolveOutputParameters">
															<parameters>
																<variableReferenceExpression name="query"/>
																<variableReferenceExpression name="buildingRow"/>
																<variableReferenceExpression name="parameters"/>
															</parameters>
														</methodInvokeExpression>
														<methodReturnStatement>
															<primitiveExpression value="0"/>
														</methodReturnStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<propertyReferenceExpression name="EnableEmailMessages"/>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="DataTable" name="messages">
																	<init>
																		<objectCreateExpression type="DataTable"/>
																	</init>
																</variableDeclarationStatement>
																<methodInvokeExpression methodName="Load">
																	<target>
																		<variableReferenceExpression name="messages"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="ExecuteReader">
																			<target>
																				<variableReferenceExpression name="query"/>
																			</target>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
																<assignStatement>
																	<propertyReferenceExpression name="EmailMessages"/>
																	<variableReferenceExpression name="messages"/>
																</assignStatement>
																<methodInvokeExpression methodName="SqlResolveOutputParameters">
																	<parameters>
																		<variableReferenceExpression name="query"/>
																		<variableReferenceExpression name="buildingRow"/>
																		<variableReferenceExpression name="parameters"/>
																	</parameters>
																</methodInvokeExpression>
																<methodReturnStatement>
																	<primitiveExpression value="0"/>
																</methodReturnStatement>
															</trueStatements>
															<falseStatements>
																<variableDeclarationStatement type="System.Int32" name="rowsAffected">
																	<init>
																		<methodInvokeExpression methodName="ExecuteNonQuery">
																			<target>
																				<variableReferenceExpression name="query"/>
																			</target>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<methodInvokeExpression methodName="SqlResolveOutputParameters">
																	<parameters>
																		<variableReferenceExpression name="query"/>
																		<variableReferenceExpression name="buildingRow"/>
																		<variableReferenceExpression name="parameters"/>
																	</parameters>
																</methodInvokeExpression>
																<methodReturnStatement>
																	<variableReferenceExpression name="rowsAffected"/>
																</methodReturnStatement>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</statements>
								</usingStatement>
							</statements>
						</memberMethod>
						<!-- method SqlResolveOutputParameters(SqlText, bool, ParameterValue[]) -->
						<memberMethod name="SqlResolveOutputParameters">
							<attributes family="true"/>
							<parameters>
								<parameter type="SqlText" name="query"/>
								<parameter type="System.Boolean" name="buildingRow"/>
								<parameter type="ParameterValue[]" name="parameters"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="List" name="clearedFilters">
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
								<foreachStatement>
									<variable type="DbParameter" name="p" var="false"/>
									<target>
										<propertyReferenceExpression name="Parameters">
											<variableReferenceExpression name="query"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<variableDeclarationStatement type="System.String" name="fieldName">
											<init>
												<methodInvokeExpression methodName="Substring">
													<target>
														<propertyReferenceExpression name="ParameterName">
															<variableReferenceExpression name="p"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="1"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="Match" name="fm">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<propertyReferenceExpression name="SqlFieldFilterOperationRegex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="fieldName"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="Success">
													<variableReferenceExpression name="fm"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String" name="name">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="fm"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Name"/>
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
																		<variableReferenceExpression name="fm"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="Operation"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.Object" name="value">
													<init>
														<propertyReferenceExpression name="Value">
															<variableReferenceExpression name="p"/>
														</propertyReferenceExpression>
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
																	<variableReferenceExpression name="value"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<!--<conditionStatement>
                                          <condition>
                                            <binaryOperatorExpression operator="IsTypeOf">
                                              <variableReferenceExpression name="value"/>
                                              <typeReferenceExpression type="System.DateTime"/>
                                            </binaryOperatorExpression>
                                          </condition>
                                          <trueStatements>
                                            <assignStatement>
                                              <variableReferenceExpression name="value"/>
                                              <methodInvokeExpression methodName="AddMinutes">
                                                <target>
                                                  <castExpression targetType="System.DateTime">
                                                    <variableReferenceExpression name="value"/>
                                                  </castExpression>
                                                </target>
                                                <parameters>
                                                  <propertyReferenceExpression name="UtcOffsetInMinutes">
                                                    <typeReferenceExpression type="ControllerUtilities"/>
                                                  </propertyReferenceExpression>
                                                </parameters>
                                              </methodInvokeExpression>
                                            </assignStatement>
                                          </trueStatements>
                                        </conditionStatement>-->
														<variableDeclarationStatement type="FilterValue" name="filter">
															<init>
																<methodInvokeExpression methodName="SelectFilterValue">
																	<parameters>
																		<variableReferenceExpression name="name"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="Equals">
																	<target>
																		<primitiveExpression value="null" convertTo="String"/>
																	</target>
																	<parameters>
																		<convertExpression to="String">
																			<variableReferenceExpression name="value"/>
																		</convertExpression>
																		<propertyReferenceExpression name="OrdinalIgnoreCase">
																			<typeReferenceExpression type="StringComparison"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="value"/>
																	<primitiveExpression value="null"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="filter"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="Contains">
																				<target>
																					<variableReferenceExpression name="clearedFilters"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="Name">
																						<variableReferenceExpression name="filter"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Clear">
																			<target>
																				<variableReferenceExpression name="filter"/>
																			</target>
																		</methodInvokeExpression>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<variableReferenceExpression name="clearedFilters"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="filter"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="AddValue">
																	<target>
																		<variableReferenceExpression name="filter"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="value"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<assignStatement>
																	<variableReferenceExpression name="filter"/>
																	<objectCreateExpression type="FilterValue">
																		<parameters>
																			<variableReferenceExpression name="name"/>
																			<castExpression targetType="RowFilterOperation">
																				<methodInvokeExpression methodName="ConvertFromString">
																					<target>
																						<methodInvokeExpression methodName="GetConverter">
																							<target>
																								<typeReferenceExpression type="TypeDescriptor"/>
																							</target>
																							<parameters>
																								<typeofExpression type="RowFilterOperation"/>
																							</parameters>
																						</methodInvokeExpression>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="operation"/>
																					</parameters>
																				</methodInvokeExpression>
																			</castExpression>
																			<variableReferenceExpression name="value"/>
																		</parameters>
																	</objectCreateExpression>
																</assignStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="clearedFilters"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="filter"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="ChangeFilter">
															<parameters>
																<variableReferenceExpression name="filter"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="EndsWith">
															<target>
																<variableReferenceExpression name="fieldName"/>
															</target>
															<parameters>
																<primitiveExpression value="_Modified"/>
																<propertyReferenceExpression name="OrdinalIgnoreCase">
																	<typeReferenceExpression type="StringComparison"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="fieldName"/>
															<methodInvokeExpression methodName="Substring">
																<target>
																	<variableReferenceExpression name="fieldName"/>
																</target>
																<parameters>
																	<primitiveExpression value="0"/>
																	<binaryOperatorExpression operator="Subtract">
																		<propertyReferenceExpression name="Length">
																			<variableReferenceExpression name="fieldName"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="9"/>
																	</binaryOperatorExpression>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<variableDeclarationStatement type="FieldValue" name="fvo">
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
																	<variableReferenceExpression name="fvo"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="Modified">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																	<convertExpression to="Boolean">
																		<propertyReferenceExpression name="Value">
																			<argumentReferenceExpression name="p"/>
																		</propertyReferenceExpression>
																	</convertExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<variableDeclarationStatement type="FieldValue" name="fvo">
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
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="IdentityInequality">
																		<variableReferenceExpression name="fvo"/>
																		<primitiveExpression  value="null"/>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="IdentityInequality">
																		<convertExpression to="String">
																			<propertyReferenceExpression name="Value">
																				<variableReferenceExpression name="fvo"/>
																			</propertyReferenceExpression>
																		</convertExpression>
																		<!--<methodInvokeExpression methodName="ToString">
                                  <target>
                                    <typeReferenceExpression type="Convert"/>
                                  </target>
                                  <parameters>
                                    <propertyReferenceExpression name="Value">
                                      <variableReferenceExpression name="fvo"/>
                                    </propertyReferenceExpression>
                                  </parameters>
                                </methodInvokeExpression>-->
																		<convertExpression to="String">
																			<propertyReferenceExpression name="Value">
																				<variableReferenceExpression name="p"/>
																			</propertyReferenceExpression>
																		</convertExpression>
																		<!--<methodInvokeExpression methodName="ToString">
                                  <target>
                                    <typeReferenceExpression type="Convert"/>
                                  </target>
                                  <parameters>
                                    <propertyReferenceExpression name="Value">
                                      <variableReferenceExpression name="p"/>
                                    </propertyReferenceExpression>
                                  </parameters>
                                </methodInvokeExpression>-->
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="UpdateFieldValue">
																	<parameters>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="fvo"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="p"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<variableDeclarationStatement type="DataField" name="field">
															<init>
																<primitiveExpression value="null"/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<variableReferenceExpression name="buildingRow"/>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="field"/>
																	<methodInvokeExpression methodName="FindField">
																		<target>
																			<propertyReferenceExpression name="Page"/>
																		</target>
																		<parameters>
																			<argumentReferenceExpression name="fieldName"/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="field"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="System.Object" name="v">
																			<init>
																				<propertyReferenceExpression name="Value">
																					<variableReferenceExpression name="p"/>
																				</propertyReferenceExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
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
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="v"/>
																					<primitiveExpression value="null"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<fieldReferenceExpression name="row"/>
																				</target>
																				<indices>
																					<methodInvokeExpression methodName="IndexOf">
																						<target>
																							<propertyReferenceExpression name="Fields">
																								<propertyReferenceExpression name="Page"/>
																							</propertyReferenceExpression>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="field"/>
																						</parameters>
																					</methodInvokeExpression>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="v"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="IdentityEquality">
																		<variableReferenceExpression name="field"/>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																	<unaryOperatorExpression operator="Not">
																		<methodInvokeExpression methodName="ProcessSystemSqlParameter">
																			<parameters>
																				<variableReferenceExpression name="query"/>
																				<propertyReferenceExpression name="ParameterName">
																					<variableReferenceExpression name="p"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</unaryOperatorExpression>

																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<foreachStatement>
																	<variable type="ParameterValue" name="pvo"/>
																	<target>
																		<argumentReferenceExpression name="parameters"/>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="Equals">
																					<target>
																						<propertyReferenceExpression name="Name">
																							<variableReferenceExpression name="pvo"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="ParameterName">
																							<variableReferenceExpression name="p"/>
																						</propertyReferenceExpression>
																						<propertyReferenceExpression name="InvariantCultureIgnoreCase">
																							<typeReferenceExpression type="StringComparison"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<propertyReferenceExpression name="Value">
																						<variableReferenceExpression name="pvo"/>
																					</propertyReferenceExpression>
																					<propertyReferenceExpression name="Value">
																						<variableReferenceExpression name="p"/>
																					</propertyReferenceExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
						<!-- field string[] SystemSqlParameters -->
						<memberField type="System.String[]" name="SystemSqlParameters">
							<attributes public="true" static="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<primitiveExpression value="BusinessRules_PreventDefault"/>
										<primitiveExpression value="Result_Continue"/>
										<primitiveExpression value="Result_Refresh"/>
										<primitiveExpression value="Result_RefreshChildren"/>
										<primitiveExpression value="Result_ClearSelection"/>
										<primitiveExpression value="Result_KeepSelection"/>
										<primitiveExpression value="Result_Master"/>
										<primitiveExpression value="Result_ShowAlert"/>
										<primitiveExpression value="Result_ShowMessage"/>
										<primitiveExpression value="Result_ShowViewMessage"/>
										<primitiveExpression value="Result_Focus"/>
										<primitiveExpression value="Result_Error"/>
										<primitiveExpression value="Result_ExecuteOnClient"/>
										<primitiveExpression value="Result_NavigateUrl"/>
										<primitiveExpression value="Result_ReturnValue"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<!-- property RequiresRowCount -->
						<memberProperty type="System.Boolean" name="RequiresRowCount">
							<comment>
								<![CDATA[
        /// <summary>
        /// Specfies if the the currently processed "Select" action must calculate the number of available data rows.
        /// </summary>
             ]]>
							</comment>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property View -->
						<memberProperty type="System.String" name="View">
							<comment>
								<![CDATA[
        /// <summary>
        /// Returns the name of the View that was active when the currently processed action has been invoked.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<fieldReferenceExpression name="request"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="View">
												<fieldReferenceExpression name="request"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Arguments"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="View">
												<propertyReferenceExpression name="Arguments"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method MaximumSizeOfSqlParameter(string) -->
						<memberMethod returnType="System.Int32" name="MaximumSizeOfSqlParameter">
							<comment>
								<![CDATA[
        /// <summary>
        /// Returns the maximum length of SQL Parameter
        /// </summary>
        /// <param name="parameterName">The name of SQL parameter without a leading "parameter marker" symbol.</param>
        /// <returns>The integer value representing the maximum size of SQL parameter.</returns>
        ]]>
							</comment>
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="parameterName"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<argumentReferenceExpression name="parameterName"/>
											</target>
											<parameters>
												<primitiveExpression value="Result_"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="512"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="255"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IsSystemSqlProperty(string) -->
						<memberField type="Regex" name="SystemSqlPropertyRegex">
							<attributes public="true" static=""/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression>
											<xsl:attribute name="value"><![CDATA[^(BusinessRules|Session|Url|Arguments|Profile)_]]></xsl:attribute>
										</primitiveExpression>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<memberMethod returnType="System.Boolean" name="IsSystemSqlProperty">
							<attributes private="true"/>
							<parameters>
								<parameter type="System.String" name="propertyName"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="IsMatch">
										<target>
											<propertyReferenceExpression name="SystemSqlPropertyRegex"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="propertyName"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetProperty(string) -->
						<memberMethod returnType="System.Object" name="GetProperty">
							<comment>
								<![CDATA[
         /// <summary>
        ///Gets a property of a business rule class instance, session variable, or URL parameter.
        ///</summary>
        ///<param name="propertyName">The name of a business rule property, session variable, or URL parameter.</param>
        ///<returns>The value of the property.</returns>
        ]]>
							</comment>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="propertyName"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<argumentReferenceExpression name="propertyName"/>
											</target>
											<parameters>
												<primitiveExpression value="Parameters_"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="SelectFieldValue">
												<parameters>
													<argumentReferenceExpression name="propertyName"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<argumentReferenceExpression name="propertyName"/>
											</target>
											<parameters>
												<primitiveExpression value="ContextFields_"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="SelectExternalFilterFieldValue">
												<parameters>
													<methodInvokeExpression methodName="Substring">
														<target>
															<argumentReferenceExpression name="propertyName"/>
														</target>
														<parameters>
															<primitiveExpression value="14"/>
														</parameters>
													</methodInvokeExpression>

												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<argumentReferenceExpression name="propertyName"/>
											</target>
											<parameters>
												<primitiveExpression value="Url_"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="propertyName"/>
											<methodInvokeExpression methodName="Substring">
												<target>
													<argumentReferenceExpression name="propertyName"/>
												</target>
												<parameters>
													<primitiveExpression value="4"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<variableDeclarationStatement type="System.String" name="query">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="UrlReferrer">
														<propertyReferenceExpression name="Request">
															<propertyReferenceExpression name="Context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="query"/>
													<propertyReferenceExpression name="Query">
														<propertyReferenceExpression name="UrlReferrer">
															<propertyReferenceExpression name="Request">
																<propertyReferenceExpression name="Context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="query"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="query"/>
													<propertyReferenceExpression name="Query">
														<propertyReferenceExpression name="Url">
															<propertyReferenceExpression name="Request">
																<propertyReferenceExpression name="Context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="query"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<xsl:if test="$UrlHashing='true'">
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="StartsWith">
																<target>
																	<variableReferenceExpression name="query"/>
																</target>
																<parameters>
																	<primitiveExpression value="?_link="/>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="query"/>
																<binaryOperatorExpression operator="Add">
																	<primitiveExpression value="?"/>
																	<methodInvokeExpression methodName="Decrypt">
																		<target>
																			<objectCreateExpression type="StringEncryptor"/>
																		</target>
																		<parameters>
																			<methodInvokeExpression methodName="Substring">
																				<target>
																					<variableReferenceExpression name="query"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="7"/>
																				</parameters>
																			</methodInvokeExpression>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
												</xsl:if>
												<!-- TODO url hashing-->
												<variableDeclarationStatement type="Match" name="m">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="query"/>
																<stringFormatExpression>
																	<xsl:attribute name="format"><![CDATA[(\?|&){0}=(?'Value'.*?)(&|$)]]></xsl:attribute>
																	<argumentReferenceExpression name="propertyName"/>
																</stringFormatExpression>
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
														<methodReturnStatement>
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
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="StartsWith">
													<target>
														<argumentReferenceExpression name="propertyName"/>
													</target>
													<parameters>
														<primitiveExpression value="Session_"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="propertyName"/>
													<methodInvokeExpression methodName="Substring">
														<target>
															<argumentReferenceExpression name="propertyName"/>
														</target>
														<parameters>
															<primitiveExpression value="8"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<methodReturnStatement>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Session">
																<propertyReferenceExpression name="Context"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<variableReferenceExpression name="propertyName"/>
														</indices>
													</arrayIndexerExpression>
												</methodReturnStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="StartsWith">
															<target>
																<argumentReferenceExpression name="propertyName"/>
															</target>
															<parameters>
																<primitiveExpression value="Profile_"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<xsl:if test="$PageImplementation='html'">
															<conditionStatement>
																<condition>
																	<propertyReferenceExpression name="IsSiteContentEnabled">
																		<typeReferenceExpression type="ApplicationServices"/>
																	</propertyReferenceExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<variableReferenceExpression name="propertyName"/>
																		<methodInvokeExpression methodName="Substring">
																			<target>
																				<variableReferenceExpression name="propertyName"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="8"/>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																	<variableDeclarationStatement type="JObject" name="profile">
																		<init>
																			<castExpression targetType="JObject">
																				<arrayIndexerExpression>
																					<target>
																						<propertyReferenceExpression name="Items">
																							<propertyReferenceExpression name="Current">
																								<typeReferenceExpression type="HttpContext"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																					</target>
																					<indices>
																						<primitiveExpression value="profile"/>
																					</indices>
																				</arrayIndexerExpression>
																			</castExpression>
																		</init>
																	</variableDeclarationStatement>
																	<conditionStatement>
																		<condition>
																			<binaryOperatorExpression operator="IdentityEquality">
																				<variableReferenceExpression name="profile"/>
																				<primitiveExpression value="null"/>
																			</binaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<assignStatement>
																				<variableReferenceExpression name="profile"/>
																				<methodInvokeExpression methodName="ReadJson">
																					<target>
																						<typeReferenceExpression type="SiteContentFile"/>
																					</target>
																					<parameters>
																						<binaryOperatorExpression operator="Add">
																							<binaryOperatorExpression operator="Add">
																								<primitiveExpression value="sys/users/"/>
																								<propertyReferenceExpression name="UserName"/>
																							</binaryOperatorExpression>
																							<primitiveExpression value=".json"/>
																						</binaryOperatorExpression>
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
																						<primitiveExpression value="profile"/>
																					</indices>
																				</arrayIndexerExpression>
																				<variableReferenceExpression name="profile"/>
																			</assignStatement>
																		</trueStatements>
																	</conditionStatement>
																	<conditionStatement>
																		<condition>
																			<binaryOperatorExpression operator="IdentityInequality">
																				<variableReferenceExpression name="profile"/>
																				<primitiveExpression value="null"/>
																			</binaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<foreachStatement>
																				<variable type="KeyValuePair" name="kvp">
																					<typeArguments>
																						<typeReference type="System.String"/>
																						<typeReference type="JToken"/>
																					</typeArguments>
																				</variable>
																				<target>
																					<variableReferenceExpression name="profile"/>
																				</target>
																				<statements>
																					<conditionStatement>
																						<condition>
																							<binaryOperatorExpression operator="ValueEquality">
																								<methodInvokeExpression methodName="Replace">
																									<target>
																										<propertyReferenceExpression name="Key">
																											<variableReferenceExpression name="kvp"/>
																										</propertyReferenceExpression>
																									</target>
																									<parameters>
																										<primitiveExpression value=":" convertTo="Char"/>
																										<primitiveExpression value="_" convertTo="Char"/>
																									</parameters>
																								</methodInvokeExpression>
																								<variableReferenceExpression name="propertyName"/>
																							</binaryOperatorExpression>
																						</condition>
																						<trueStatements>
																							<methodReturnStatement>
																								<methodInvokeExpression methodName="ToString">
																									<target>
																										<propertyReferenceExpression name="Value">
																											<variableReferenceExpression name="kvp"/>
																										</propertyReferenceExpression>
																									</target>
																								</methodInvokeExpression>
																							</methodReturnStatement>
																						</trueStatements>
																					</conditionStatement>
																				</statements>
																			</foreachStatement>
																		</trueStatements>
																	</conditionStatement>
																</trueStatements>
															</conditionStatement>
														</xsl:if>
														<methodReturnStatement>
															<primitiveExpression value="null"/>
														</methodReturnStatement>
													</trueStatements>
													<falseStatements>
														<variableDeclarationStatement type="Type" name="t">
															<init>
																<methodInvokeExpression methodName="GetType"/>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Object" name="target" var="false">
															<init>
																<thisReferenceExpression/>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="StartsWith">
																	<target>
																		<argumentReferenceExpression name="propertyName"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="BusinessRules_"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<argumentReferenceExpression name="propertyName"/>
																	<methodInvokeExpression methodName="Substring">
																		<target>
																			<variableReferenceExpression name="propertyName"/>
																		</target>
																		<parameters>
																			<primitiveExpression value="14"/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="StartsWith">
																			<target>
																				<argumentReferenceExpression name="propertyName"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="Arguments_"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<argumentReferenceExpression name="propertyName"/>
																			<methodInvokeExpression methodName="Substring">
																				<target>
																					<variableReferenceExpression name="propertyName"/>
																				</target>
																				<parameters>
																					<primitiveExpression value="10"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																		<assignStatement>
																			<variableReferenceExpression name="t"/>
																			<typeofExpression type="ActionArgs"/>
																		</assignStatement>
																		<assignStatement>
																			<variableReferenceExpression name="target"/>
																			<propertyReferenceExpression name="Arguments">
																				<thisReferenceExpression/>
																			</propertyReferenceExpression>
																		</assignStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityEquality">
																					<variableReferenceExpression name="target"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodReturnStatement>
																					<primitiveExpression value="null"/>
																				</methodReturnStatement>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
														<methodReturnStatement>
															<methodInvokeExpression methodName="InvokeMember">
																<target>
																	<variableReferenceExpression name="t"/>
																</target>
																<parameters>
																	<argumentReferenceExpression name="propertyName"/>
																	<binaryOperatorExpression operator="BitwiseOr">
																		<binaryOperatorExpression operator="BitwiseOr">
																			<binaryOperatorExpression operator="BitwiseOr">
																				<propertyReferenceExpression name="GetProperty">
																					<typeReferenceExpression type="BindingFlags"/>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="GetField">
																					<typeReferenceExpression type="BindingFlags"/>
																				</propertyReferenceExpression>
																			</binaryOperatorExpression>
																			<propertyReferenceExpression name="Public">
																				<typeReferenceExpression type="BindingFlags"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																		<binaryOperatorExpression operator="BitwiseOr">
																			<binaryOperatorExpression operator="BitwiseOr">
																				<binaryOperatorExpression operator="BitwiseOr">
																					<propertyReferenceExpression name="Instance">
																						<typeReferenceExpression type="BindingFlags"/>
																					</propertyReferenceExpression>
																					<propertyReferenceExpression name="Static">
																						<typeReferenceExpression type="BindingFlags"/>
																					</propertyReferenceExpression>
																				</binaryOperatorExpression>
																				<propertyReferenceExpression name="FlattenHierarchy">
																					<typeReferenceExpression type="BindingFlags"/>
																				</propertyReferenceExpression>
																			</binaryOperatorExpression>
																			<propertyReferenceExpression name="IgnoreCase">
																				<typeReferenceExpression type="BindingFlags"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</binaryOperatorExpression>
																	<primitiveExpression value="null"/>
																	<variableReferenceExpression name="target"/>
																	<arrayCreateExpression>
																		<createType type="System.Object"/>
																		<sizeExpression>
																			<primitiveExpression value="0"/>
																		</sizeExpression>
																	</arrayCreateExpression>
																</parameters>
															</methodInvokeExpression>
														</methodReturnStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method SetProperty(string, objecct) -->
						<memberMethod name="SetProperty">
							<comment>
								<![CDATA[
        /// <summary>
        ///Sets the property of the business rule class instance or the session variable value.
        ///</summary>
        ///<param name="propertyName">The name of the property or session variable.</param>
        ///<param name="value">The value of the property.</param>
              ]]>
							</comment>
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="propertyName"/>
								<parameter type="System.Object" name="value"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<argumentReferenceExpression name="propertyName"/>
											</target>
											<parameters>
												<primitiveExpression value="Url_"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<comment>URL properties are read-only.</comment>
										<methodReturnStatement/>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<methodInvokeExpression methodName="StartsWith">
														<target>
															<argumentReferenceExpression name="propertyName"/>
														</target>
														<parameters>
															<primitiveExpression value="Session_"/>
														</parameters>
													</methodInvokeExpression>
													<methodInvokeExpression methodName="StartsWith">
														<target>
															<argumentReferenceExpression name="propertyName"/>
														</target>
														<parameters>
															<primitiveExpression value="Arguments_"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="propertyName"/>
													<methodInvokeExpression methodName="Substring">
														<target>
															<argumentReferenceExpression name="propertyName"/>
														</target>
														<parameters>
															<primitiveExpression value="8"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IsTypeOf">
															<variableReferenceExpression name="value"/>
															<typeReferenceExpression type="System.String"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.String" name="s">
															<init>
																<castExpression targetType="System.String">
																	<argumentReferenceExpression name="value"/>
																</castExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="Guid" name="tempGuid"/>
														<conditionStatement>
															<condition>
																<methodInvokeExpression>
																	<xsl:choose >
																		<xsl:when test="a:project/@targetFramework='3.5'">
																			<xsl:attribute name="methodName">TryParseGuid</xsl:attribute>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:attribute name="methodName">TryParse</xsl:attribute>
																			<target>
																				<typeReferenceExpression type="Guid"/>
																			</target>
																		</xsl:otherwise>
																	</xsl:choose>
																	<parameters>
																		<variableReferenceExpression name="s"/>
																		<directionExpression direction="Out">
																			<variableReferenceExpression name="tempGuid"/>
																		</directionExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<argumentReferenceExpression name="value"/>
																	<variableReferenceExpression name="tempGuid"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<variableDeclarationStatement type="System.Int32" name="tempInt"/>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="TryParse">
																			<target>
																				<typeReferenceExpression type="System.Int32"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="s"/>
																				<directionExpression direction="Out">
																					<variableReferenceExpression name="tempInt"/>
																				</directionExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<argumentReferenceExpression name="value"/>
																			<variableReferenceExpression name="tempInt"/>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<variableDeclarationStatement type="System.Double" name="tempDouble"/>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="TryParse">
																					<target>
																						<typeReferenceExpression type="System.Double"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="s"/>
																						<directionExpression direction="Out">
																							<variableReferenceExpression name="tempDouble"/>
																						</directionExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<argumentReferenceExpression name="value"/>
																					<variableReferenceExpression name="tempDouble"/>
																				</assignStatement>
																			</trueStatements>
																			<falseStatements>
																				<variableDeclarationStatement type="System.DateTime" name="tempDateTime"/>
																				<conditionStatement>
																					<condition>
																						<methodInvokeExpression methodName="TryParse">
																							<target>
																								<typeReferenceExpression type="DateTime"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="s"/>
																								<directionExpression direction="Out">
																									<variableReferenceExpression name="tempDateTime"/>
																								</directionExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<argumentReferenceExpression name="value"/>
																							<variableReferenceExpression name="tempDateTime"/>
																						</assignStatement>
																					</trueStatements>
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
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Session">
																<propertyReferenceExpression name="Context"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<variableReferenceExpression name="propertyName"/>
														</indices>
													</arrayIndexerExpression>
													<argumentReferenceExpression name="value"/>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="StartsWith">
															<target>
																<argumentReferenceExpression name="propertyName"/>
															</target>
															<parameters>
																<primitiveExpression value="BusinessRules_"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<argumentReferenceExpression name="propertyName"/>
															<methodInvokeExpression methodName="Substring">
																<target>
																	<variableReferenceExpression name="propertyName"/>
																</target>
																<parameters>
																	<primitiveExpression value="14"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="InvokeMember">
													<target>
														<methodInvokeExpression methodName="GetType"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="propertyName"/>
														<binaryOperatorExpression operator="BitwiseOr">
															<binaryOperatorExpression operator="BitwiseOr">
																<binaryOperatorExpression operator="BitwiseOr">
																	<propertyReferenceExpression name="SetProperty">
																		<typeReferenceExpression type="BindingFlags"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="SetField">
																		<typeReferenceExpression type="BindingFlags"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
																<propertyReferenceExpression name="Public">
																	<typeReferenceExpression type="BindingFlags"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="BitwiseOr">
																<binaryOperatorExpression operator="BitwiseOr">
																	<binaryOperatorExpression operator="BitwiseOr">
																		<propertyReferenceExpression name="Instance">
																			<typeReferenceExpression type="BindingFlags"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Static">
																			<typeReferenceExpression type="BindingFlags"/>
																		</propertyReferenceExpression>
																	</binaryOperatorExpression>
																	<propertyReferenceExpression name="FlattenHierarchy">
																		<typeReferenceExpression type="BindingFlags"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
																<propertyReferenceExpression name="IgnoreCase">
																	<typeReferenceExpression type="BindingFlags"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
														<primitiveExpression value="null"/>
														<thisReferenceExpression/>
														<arrayCreateExpression>
															<createType type="System.Object"/>
															<sizeExpression>
																<primitiveExpression value="0"/>
															</sizeExpression>
															<initializers>
																<argumentReferenceExpression name="value"/>
															</initializers>
														</arrayCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ToNameWithoutDbType(string) -->
						<memberMethod returnType="System.String" name="ToNameWithoutDbType">
							<attributes family="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="type">
									<init>
										<propertyReferenceExpression name="String">
											<typeReferenceExpression type="DbType"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToNameWithoutDbType">
										<parameters>
											<argumentReferenceExpression name="name"/>
											<directionExpression direction="Out">
												<variableReferenceExpression name="type"/>
											</directionExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToNameWithoutDbType(string, out DbType) -->
						<memberMethod returnType="System.String" name="ToNameWithoutDbType">
							<attributes family="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
								<parameter type="DbType" name="type" direction="Out"/>
							</parameters>
							<statements>
								<assignStatement>
									<argumentReferenceExpression name="type"/>
									<propertyReferenceExpression name="String">
										<typeReferenceExpression type="DbType"/>
									</propertyReferenceExpression>
								</assignStatement>
								<variableDeclarationStatement name="m">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="name"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[^(.+)_As(AnsiString|Binary|Byte|Boolean|Currency|Date|DateTime|Decimal|Double|Guid|Int16|Int32|Int64|Object|SByte|Single|Time|UInt16|UInt32|UInt64|VarNumeric|AnsiStringFixedLength|StringFixedLength|StringFixedLength|Xml|DateTime2|DateTimeOffset)$]]></xsl:attribute>
												</primitiveExpression>
												<propertyReferenceExpression name="IgnoreCase">
													<typeReferenceExpression type="RegexOptions"/>
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
										<assignStatement>
											<variableReferenceExpression name="type"/>
											<castExpression targetType="DbType">
												<methodInvokeExpression methodName="ConvertFromString">
													<target>
														<methodInvokeExpression methodName="GetConverter">
															<target>
																<typeReferenceExpression type="TypeDescriptor"/>
															</target>
															<parameters>
																<typeofExpression type="DbType"/>
															</parameters>
														</methodInvokeExpression>
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
																	<primitiveExpression value="2"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</castExpression>
										</assignStatement>
										<assignStatement>
											<argumentReferenceExpression name="name"/>
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
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="name"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IsSystemSqlParameter(SqlText, string) -->
						<memberMethod returnType="System.Boolean" name="IsSystemSqlParameter">
							<attributes family="true"/>
							<parameters>
								<parameter type="SqlText" name="sql"/>
								<parameter type="System.String" name="parameterName"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="nameWithoutMarker">
									<init>
										<methodInvokeExpression methodName="Substring">
											<target>
												<argumentReferenceExpression name="parameterName"/>
											</target>
											<parameters>
												<primitiveExpression value="1"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="isProperty">
									<init>
										<methodInvokeExpression methodName="IsSystemSqlProperty">
											<parameters>
												<variableReferenceExpression name="nameWithoutMarker"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="testName">
									<init>
										<variableReferenceExpression name="nameWithoutMarker"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="inputOutputDbType">
									<init>
										<propertyReferenceExpression name="Int32">
											<typeReferenceExpression type="DbType"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<variableReferenceExpression name="testName"/>
											</target>
											<parameters>
												<primitiveExpression value="Result_Master_"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="testName"/>
											<primitiveExpression value="Result_Master"/>
										</assignStatement>
										<methodInvokeExpression methodName="ToNameWithoutDbType">
											<parameters>
												<variableReferenceExpression name="nameWithoutMarker"/>
												<directionExpression direction="Out">
													<variableReferenceExpression name="inputOutputDbType"/>
												</directionExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="systemParameterIndex">
									<init>
										<methodInvokeExpression methodName="IndexOf">
											<target>
												<typeReferenceExpression type="Array"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="SystemSqlParameters"/>
												<variableReferenceExpression name="testName"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="ValueEquality">
												<variableReferenceExpression name="systemParameterIndex"/>
												<primitiveExpression value="-1"/>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<variableReferenceExpression name="isProperty"/>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<comment>system bool parameters between BusinessRules_PreventDefault and Result_KeepSelection</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="GreaterThanOrEqual">
												<variableReferenceExpression name="systemParameterIndex"/>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="LessThanOrEqual">
												<variableReferenceExpression name="systemParameterIndex"/>
												<primitiveExpression value="6"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.Object" name="v">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="inputOutputDbType"/>
													<propertyReferenceExpression name="Int32">
														<typeReferenceExpression type="DbType"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="v"/>
													<primitiveExpression value="0"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="p">
											<init>
												<methodInvokeExpression methodName="AddParameter">
													<target>
														<argumentReferenceExpression name="sql"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="parameterName"/>
														<variableReferenceExpression name="v"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="Direction">
												<variableReferenceExpression name="p"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="InputOutput">
												<typeReferenceExpression type="ParameterDirection"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="DbType">
												<variableReferenceExpression name="p"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="inputOutputDbType"/>
										</assignStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Contains">
													<target>
														<methodInvokeExpression methodName="ToString">
															<target>
																<variableReferenceExpression name="inputOutputDbType"/>
															</target>
														</methodInvokeExpression>
													</target>
													<parameters>
														<primitiveExpression value="String"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Size">
														<variableReferenceExpression name="p"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="MaximumSizeOfSqlParameter">
														<parameters>
															<variableReferenceExpression name="nameWithoutMarker"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<variableDeclarationStatement type="System.Object" name="value" var="false">
											<init>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<variableReferenceExpression name="isProperty"/>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="value"/>
													<methodInvokeExpression methodName="GetProperty">
														<parameters>
															<variableReferenceExpression name="nameWithoutMarker"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="DbParameter" name="p">
											<init>
												<methodInvokeExpression methodName="AddParameter">
													<target>
														<argumentReferenceExpression name="sql"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="parameterName"/>
														<variableReferenceExpression name="value"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<methodInvokeExpression methodName="IsSystemSqlProperty">
														<parameters>
															<variableReferenceExpression name="nameWithoutMarker"/>
														</parameters>
													</methodInvokeExpression>
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="value"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="value"/>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="value"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="Equals">
															<target>
																<propertyReferenceExpression name="Value">
																	<typeReferenceExpression type="DBNull"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="value"/>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="Direction">
														<variableReferenceExpression name="p"/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="InputOutput">
														<typeReferenceExpression type="ParameterDirection"/>
													</propertyReferenceExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="IsTypeOf">
																<variableReferenceExpression name="value"/>
																<typeReferenceExpression type="System.String"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="LessThan">
																<propertyReferenceExpression name="Length">
																	<castExpression targetType="System.String">
																		<variableReferenceExpression name="value"/>
																	</castExpression>
																</propertyReferenceExpression>
																<methodInvokeExpression methodName="MaximumSizeOfSqlParameter">
																	<parameters>
																		<variableReferenceExpression name="nameWithoutMarker"/>
																	</parameters>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="Size">
																<variableReferenceExpression name="p"/>
															</propertyReferenceExpression>
															<methodInvokeExpression methodName="MaximumSizeOfSqlParameter">
																<parameters>
																	<variableReferenceExpression name="nameWithoutMarker"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ProcessSystemSqlParameter(SqlText, string) -->
						<memberMethod returnType="System.Boolean" name="ProcessSystemSqlParameter">
							<attributes family="true"/>
							<parameters>
								<parameter type="SqlText" name="sql"/>
								<parameter type="System.String" name="parameterName"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="nameWithoutMarker">
									<init>
										<methodInvokeExpression methodName="Substring">
											<target>
												<argumentReferenceExpression name="parameterName"/>
											</target>
											<parameters>
												<primitiveExpression value="1"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="testName">
									<init>
										<variableReferenceExpression name="nameWithoutMarker"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<variableReferenceExpression name="testName"/>
											</target>
											<parameters>
												<primitiveExpression value="Result_Master_"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="testName"/>
											<primitiveExpression value="Result_Master"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="isProperty">
									<init>
										<methodInvokeExpression methodName="IsSystemSqlProperty">
											<parameters>
												<argumentReferenceExpression name="testName"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="ValueEquality">
												<methodInvokeExpression methodName="IndexOf">
													<target>
														<typeReferenceExpression type="Array"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="SystemSqlParameters"/>
														<variableReferenceExpression name="testName"/>
													</parameters>
												</methodInvokeExpression>
												<primitiveExpression value="-1"/>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<variableReferenceExpression name="isProperty"/>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="DbParameter" name="p">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Parameters">
													<argumentReferenceExpression name="sql"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<argumentReferenceExpression name="parameterName"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="nameWithoutMarker"/>
											<primitiveExpression value="BusinessRules_PreventDefault"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<comment>prevent standard processing</comment>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Equals">
														<target>
															<primitiveExpression value="0"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="p"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="PreventDefault"/>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="nameWithoutMarker"/>
													<primitiveExpression value="Result_ClearSelection"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Equals">
																<target>
																	<primitiveExpression value="0"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="ClearSelection">
																<propertyReferenceExpression name="Result"/>
															</propertyReferenceExpression>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="nameWithoutMarker"/>
															<primitiveExpression value="Result_KeepSelection"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="Equals">
																		<target>
																			<primitiveExpression value="0"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Value">
																				<variableReferenceExpression name="p"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="KeepSelection">
																		<propertyReferenceExpression name="Result"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="true"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="nameWithoutMarker"/>
																	<primitiveExpression value="Result_Continue"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<comment>continue standard processing on the client</comment>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="Equals">
																				<target>
																					<primitiveExpression value="0"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="Value">
																						<variableReferenceExpression name="p"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Continue">
																			<target>
																				<propertyReferenceExpression name="Result"/>
																			</target>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<variableReferenceExpression name="isProperty"/>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="System.Object" name="currentValue">
																			<init>
																				<methodInvokeExpression methodName="GetProperty">
																					<parameters>
																						<variableReferenceExpression name="nameWithoutMarker"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueInequality">
																					<convertExpression to="String">
																						<variableReferenceExpression name="currentValue"/>
																					</convertExpression>
																					<convertExpression to="String">
																						<propertyReferenceExpression name="Value">
																							<variableReferenceExpression name="p"/>
																						</propertyReferenceExpression>
																					</convertExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="SetProperty">
																					<parameters>
																						<variableReferenceExpression name="nameWithoutMarker"/>
																						<propertyReferenceExpression name="Value">
																							<variableReferenceExpression name="p"/>
																						</propertyReferenceExpression>
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
																						<variableReferenceExpression name="nameWithoutMarker"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="Result_Master_"/>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement name="masterFieldName">
																					<init>
																						<methodInvokeExpression methodName="Substring">
																							<target>
																								<variableReferenceExpression name="nameWithoutMarker"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="14"/>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<methodInvokeExpression methodName="UpdateMasterFieldValue">
																					<parameters>
																						<methodInvokeExpression methodName="ToNameWithoutDbType">
																							<parameters>
																								<variableReferenceExpression name="masterFieldName"/>
																							</parameters>
																						</methodInvokeExpression>
																						<propertyReferenceExpression name="Value">
																							<variableReferenceExpression name="p"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																			<falseStatements>
																				<variableDeclarationStatement type="System.String" name="s">
																					<init>
																						<convertExpression to="String">
																							<propertyReferenceExpression name="Value">
																								<variableReferenceExpression name="p"/>
																							</propertyReferenceExpression>
																						</convertExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<unaryOperatorExpression operator="IsNotNullOrEmpty">
																							<variableReferenceExpression name="s"/>
																						</unaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="nameWithoutMarker"/>
																									<primitiveExpression value="Result_Focus"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<variableDeclarationStatement type="Match" name="m">
																									<init>
																										<methodInvokeExpression methodName="Match">
																											<target>
																												<typeReferenceExpression type="Regex"/>
																											</target>
																											<parameters>
																												<variableReferenceExpression name="s"/>
																												<primitiveExpression>
																													<xsl:attribute name="value"><![CDATA[^\s*(?'FieldName'\w+)\s*(,\s*(?'Message'.+))?$]]></xsl:attribute>
																												</primitiveExpression>
																											</parameters>
																										</methodInvokeExpression>
																									</init>
																								</variableDeclarationStatement>
																								<methodInvokeExpression methodName="Focus">
																									<target>
																										<propertyReferenceExpression name="Result"/>
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
																													<primitiveExpression value="FieldName"/>
																												</indices>
																											</arrayIndexerExpression>
																										</propertyReferenceExpression>
																										<propertyReferenceExpression name="Value">
																											<arrayIndexerExpression>
																												<target>
																													<propertyReferenceExpression name="Groups">
																														<variableReferenceExpression name="m"/>
																													</propertyReferenceExpression>
																												</target>
																												<indices>
																													<primitiveExpression value="Message"/>
																												</indices>
																											</arrayIndexerExpression>
																										</propertyReferenceExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="nameWithoutMarker"/>
																									<primitiveExpression value="Result_ShowViewMessage"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="ShowViewMessage">
																									<target>
																										<propertyReferenceExpression name="Result"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="s"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="nameWithoutMarker"/>
																									<primitiveExpression value="Result_ShowMessage"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="ShowMessage">
																									<target>
																										<propertyReferenceExpression name="Result"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="s"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="nameWithoutMarker"/>
																									<primitiveExpression value="Result_ShowAlert"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="ShowAlert">
																									<target>
																										<propertyReferenceExpression name="Result"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="s"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="nameWithoutMarker"/>
																									<primitiveExpression value="Result_Error"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<throwExceptionStatement>
																									<objectCreateExpression type="Exception">
																										<parameters>
																											<variableReferenceExpression name="s"/>
																										</parameters>
																									</objectCreateExpression>
																								</throwExceptionStatement>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="nameWithoutMarker"/>
																									<primitiveExpression value="Result_ExecuteOnClient"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="ExecuteOnClient">
																									<target>
																										<propertyReferenceExpression name="Result"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="s"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="nameWithoutMarker"/>
																									<primitiveExpression value="Result_NavigateUrl"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<assignStatement>
																									<propertyReferenceExpression name="NavigateUrl">
																										<propertyReferenceExpression name="Result"/>
																									</propertyReferenceExpression>
																									<variableReferenceExpression name="s"/>
																								</assignStatement>
																								<!--<methodInvokeExpression methodName="Continue">
                                              <target>
                                                <variableReferenceExpression name="Result"/>
                                              </target>
                                            </methodInvokeExpression>-->
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="nameWithoutMarker"/>
																									<primitiveExpression value="Result_Refresh"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="Refresh">
																									<target>
																										<propertyReferenceExpression name="Result"/>
																									</target>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="nameWithoutMarker"/>
																									<primitiveExpression value="Result_RefreshChildren"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="RefreshChildren">
																									<target>
																										<propertyReferenceExpression name="Result"/>
																									</target>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="nameWithoutMarker"/>
																									<primitiveExpression value="Result_ReturnValue"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<variableDeclarationStatement name="v">
																									<init>
																										<propertyReferenceExpression name="Value">
																											<variableReferenceExpression name="p"/>
																										</propertyReferenceExpression>
																									</init>
																								</variableDeclarationStatement>
																								<conditionStatement>
																									<condition>
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
																									</condition>
																									<trueStatements>
																										<assignStatement>
																											<variableReferenceExpression name="v"/>
																											<primitiveExpression value="null"/>
																										</assignStatement>
																									</trueStatements>
																									<falseStatements>
																										<variableDeclarationStatement name="stringValue">
																											<init>
																												<convertExpression to="String">
																													<variableReferenceExpression name="v"/>
																												</convertExpression>
																											</init>
																										</variableDeclarationStatement>
																										<variableDeclarationStatement type="System.Int64" name="longValue" var="false">
																											<init>
																												<primitiveExpression value="0"/>
																											</init>
																										</variableDeclarationStatement>
																										<variableDeclarationStatement type="System.Double" name="doubleValue" var="false">
																											<init>
																												<primitiveExpression value="0"/>
																											</init>
																										</variableDeclarationStatement>
																										<variableDeclarationStatement name="boolValue">
																											<init>
																												<primitiveExpression value="false"/>
																											</init>
																										</variableDeclarationStatement>
																										<variableDeclarationStatement type="DateTime" name="dateTimeValue"/>
																										<conditionStatement>
																											<condition>
																												<methodInvokeExpression methodName="TryParse">
																													<target>
																														<typeReferenceExpression type="System.Int64"/>
																													</target>
																													<parameters>
																														<variableReferenceExpression name="stringValue"/>
																														<directionExpression direction="Out">
																															<variableReferenceExpression name="longValue"/>
																														</directionExpression>
																													</parameters>
																												</methodInvokeExpression>
																											</condition>
																											<trueStatements>
																												<assignStatement>
																													<variableReferenceExpression name="v"/>
																													<variableReferenceExpression name="longValue"/>
																												</assignStatement>
																											</trueStatements>
																											<falseStatements>
																												<conditionStatement>
																													<condition>
																														<methodInvokeExpression methodName="TryParse">
																															<target>
																																<typeReferenceExpression type="System.Double"/>
																															</target>
																															<parameters>
																																<variableReferenceExpression name="stringValue"/>
																																<directionExpression direction="Out">
																																	<variableReferenceExpression name="doubleValue"/>
																																</directionExpression>
																															</parameters>
																														</methodInvokeExpression>
																													</condition>
																													<trueStatements>
																														<assignStatement>
																															<variableReferenceExpression name="v"/>
																															<variableReferenceExpression name="doubleValue"/>
																														</assignStatement>
																													</trueStatements>
																													<falseStatements>
																														<conditionStatement>
																															<condition>
																																<methodInvokeExpression methodName="TryParse">
																																	<target>
																																		<typeReferenceExpression type="System.Boolean"/>
																																	</target>
																																	<parameters>
																																		<variableReferenceExpression name="stringValue"/>
																																		<directionExpression direction="Out">
																																			<variableReferenceExpression name="boolValue"/>
																																		</directionExpression>
																																	</parameters>
																																</methodInvokeExpression>
																															</condition>
																															<trueStatements>
																																<assignStatement>
																																	<variableReferenceExpression name="v"/>
																																	<variableReferenceExpression name="boolValue"/>
																																</assignStatement>
																															</trueStatements>
																															<falseStatements>
																																<conditionStatement>
																																	<condition>
																																		<methodInvokeExpression methodName="TryParse">
																																			<target>
																																				<typeReferenceExpression type="DateTime"/>
																																			</target>
																																			<parameters>
																																				<variableReferenceExpression name="stringValue"/>
																																				<directionExpression direction="Out">
																																					<variableReferenceExpression name="dateTimeValue"/>
																																				</directionExpression>
																																			</parameters>
																																		</methodInvokeExpression>
																																	</condition>
																																	<trueStatements>
																																		<assignStatement>
																																			<variableReferenceExpression name="v"/>
																																			<methodInvokeExpression methodName="ToString">
																																				<target>
																																					<variableReferenceExpression name="dateTimeValue"/>
																																				</target>
																																				<parameters>
																																					<primitiveExpression value="o"/>
																																				</parameters>
																																			</methodInvokeExpression>
																																		</assignStatement>
																																	</trueStatements>
																																</conditionStatement>
																															</falseStatements>
																														</conditionStatement>
																													</falseStatements>
																												</conditionStatement>
																											</falseStatements>
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
																														<primitiveExpression value="ReturnValue"/>
																														<variableReferenceExpression name="v"/>
																													</parameters>
																												</objectCreateExpression>
																											</parameters>
																										</methodInvokeExpression>
																									</falseStatements>
																								</conditionStatement>
																							</trueStatements>
																						</conditionStatement>
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
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ExecuteMethod(ActionArgs, ActionResult, ActionPhase) -->
						<memberMethod name="ExecuteMethod" >
							<attributes override="true" family="true"/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
								<parameter type="ActionPhase" name="phase"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteServerRules">
									<parameters>
										<argumentReferenceExpression name="args"/>
										<argumentReferenceExpression name="result"/>
										<argumentReferenceExpression name="phase"/>
									</parameters>
								</methodInvokeExpression>
								<!--<methodInvokeExpression methodName="ExecuteMethod">
                  <target>
                    <baseReferenceExpression/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="args"/>
                    <argumentReferenceExpression name="result"/>
                    <argumentReferenceExpression name="phase"/>
                  </parameters>
                </methodInvokeExpression>-->
							</statements>
						</memberMethod>
						<!-- method ExecuteServerRules(ActionArgs, ActionResult, ActionPhase) -->
						<memberMethod name="ExecuteServerRules">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
								<parameter type="ActionPhase" name="phase"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<propertyReferenceExpression name="Canceled">
												<propertyReferenceExpression name="Result"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="IgnoreBusinessRules">
												<argumentReferenceExpression name="args"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="Arguments">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="args"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Result">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="result"/>
								</assignStatement>
								<methodInvokeExpression methodName="ExecuteServerRules">
									<parameters>
										<argumentReferenceExpression name="phase"/>
										<propertyReferenceExpression name="View">
											<argumentReferenceExpression name="args"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="CommandName">
											<argumentReferenceExpression name="args"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="CommandArgument">
											<argumentReferenceExpression name="args"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="ValueEquality">
												<argumentReferenceExpression name="phase"/>
												<propertyReferenceExpression name="Before">
													<typeReferenceExpression type="ActionPhase"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<propertyReferenceExpression name="Canceled">
													<propertyReferenceExpression name="Result"/>
												</propertyReferenceExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ExecuteServerRules">
											<parameters>
												<propertyReferenceExpression name="Execute">
													<typeReferenceExpression type="ActionPhase"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="View">
													<argumentReferenceExpression name="args"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="CommandName">
													<argumentReferenceExpression name="args"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="CommandArgument">
													<argumentReferenceExpression name="args"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ExecuteServerRules(PageRequest, ActionPhase) -->
						<memberMethod name="ExecuteServerRules">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ActionPhase" name="phase"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteServerRules">
									<parameters>
										<argumentReferenceExpression name="request"/>
										<argumentReferenceExpression name="phase"/>
										<primitiveExpression value="Select"/>
										<primitiveExpression value="null"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ExecuteServerRules(PageRequest, ActionPhase, string, object[]) -->
						<memberMethod name="ExecuteServerRules">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ActionPhase" name="phase"/>
								<parameter type="System.String" name="commandName"/>
								<parameter type="System.Object[]" name="row"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="request"/>
									<argumentReferenceExpression name="request"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="requestFilter"/>
									<propertyReferenceExpression name="Filter">
										<argumentReferenceExpression name="request"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="requestExternalFilter"/>
									<propertyReferenceExpression name="ExternalFilter">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="row"/>
									<argumentReferenceExpression name="row"/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="ValueEquality">
												<argumentReferenceExpression name="phase"/>
												<propertyReferenceExpression name="Execute">
													<propertyReferenceExpression name="ActionPhase"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<argumentReferenceExpression name="commandName"/>
												<primitiveExpression value="Select"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="InitializeRow">
											<target>
												<propertyReferenceExpression name="BlobAdapterFactory"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Page">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
												<argumentReferenceExpression name="row"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="ExecuteServerRules">
									<parameters>
										<argumentReferenceExpression name="phase"/>
										<propertyReferenceExpression name="View">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<argumentReferenceExpression name="commandName"/>
										<propertyReferenceExpression name="Empty">
											<typeReferenceExpression type="String"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ExecuteServerRules(DistinctValueRequest, ActionPhase) -->
						<memberMethod name="ExecuteServerRules">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="DistinctValueRequest" name="request"/>
								<parameter type="ActionPhase" name="phase"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="requestFilter"/>
									<propertyReferenceExpression name="Filter">
										<argumentReferenceExpression name="request"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="requestExternalFilter"/>
									<propertyReferenceExpression name="ExternalFilter">
										<argumentReferenceExpression name="request"/>
									</propertyReferenceExpression>
								</assignStatement>
								<methodInvokeExpression methodName="ExecuteServerRules">
									<parameters>
										<argumentReferenceExpression name="phase"/>
										<propertyReferenceExpression name="View">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="Select"/>
										<propertyReferenceExpression name="Empty">
											<typeReferenceExpression type="String"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ExecuteServerRules(ActionPhase, string, string, string) -->
						<memberMethod name="ExecuteServerRules">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="ActionPhase" name="phase"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="commandName"/>
								<parameter type="System.String" name="commandArgument"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="InternalExecuteServerRules">
									<parameters>
										<argumentReferenceExpression name="phase"/>
										<argumentReferenceExpression name="view"/>
										<argumentReferenceExpression name="commandName"/>
										<argumentReferenceExpression name="commandArgument"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method SupportsCommand(string, string) -->
						<memberMethod returnType="System.Boolean" name="SupportsCommand">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="type"/>
								<parameter type="System.String" name="commandName"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String[]" name="types">
									<init>
										<methodInvokeExpression methodName="Split">
											<target>
												<argumentReferenceExpression name="type"/>
											</target>
											<parameters>
												<arrayCreateExpression>
													<createType type="System.Char"/>
													<initializers>
														<primitiveExpression value="|" convertTo="Char"/>
													</initializers>
												</arrayCreateExpression>
												<propertyReferenceExpression name="RemoveEmptyEntries">
													<typeReferenceExpression type="StringSplitOptions"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String[]" name="commandNames">
									<init>
										<methodInvokeExpression methodName="Split">
											<target>
												<argumentReferenceExpression name="commandName"/>
											</target>
											<parameters>
												<arrayCreateExpression>
													<createType type="System.Char"/>
													<initializers>
														<primitiveExpression value="|" convertTo="Char"/>
													</initializers>
												</arrayCreateExpression>
												<propertyReferenceExpression name="RemoveEmptyEntries">
													<typeReferenceExpression type="StringSplitOptions"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="t"/>
									<target>
										<argumentReferenceExpression name="types"/>
									</target>
									<statements>
										<foreachStatement>
											<variable type="System.String" name="c"/>
											<target>
												<variableReferenceExpression name="commandNames"/>
											</target>
											<statements>
												<variableDeclarationStatement type="XPathNodeIterator" name="ruleIterator">
													<init>
														<methodInvokeExpression methodName="Select">
															<target>
																<propertyReferenceExpression name="Config"/>
															</target>
															<parameters>
																<primitiveExpression value="/c:dataController/c:businessRules/c:rule[@type='{{0}}']"/>
																<variableReferenceExpression name="t"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<whileStatement>
													<test>
														<methodInvokeExpression methodName="MoveNext">
															<target>
																<variableReferenceExpression name="ruleIterator"/>
															</target>
														</methodInvokeExpression>
													</test>
													<statements>
														<variableDeclarationStatement type="System.String" name="ruleCommandName">
															<init>
																<methodInvokeExpression methodName="GetAttribute">
																	<target>
																		<propertyReferenceExpression name="Current">
																			<variableReferenceExpression name="ruleIterator"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="commandName"/>
																		<propertyReferenceExpression name="Empty">
																			<typeReferenceExpression type="String"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanOr">
																	<binaryOperatorExpression operator="ValueEquality">
																		<variableReferenceExpression name="ruleCommandName"/>
																		<variableReferenceExpression name="c"/>
																	</binaryOperatorExpression>
																	<methodInvokeExpression methodName="IsMatch">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="c"/>
																			<variableReferenceExpression name="ruleCommandName"/>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodReturnStatement>
																	<primitiveExpression value="true"/>
																</methodReturnStatement>
															</trueStatements>
														</conditionStatement>
													</statements>
												</whileStatement>
												<!--<conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="IdentityInequality">
                              <methodInvokeExpression methodName="SelectSingleNode">
                                <target>
                                  <propertyReferenceExpression name="Config"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="/c:dataController/c:businessRules/c:rule[@type='{{0}}' and @commandName='{{1}}']"/>
                                  <variableReferenceExpression name="t"/>
                                  <variableReferenceExpression name="c"/>
                                </parameters>
                              </methodInvokeExpression>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodReturnStatement>
                              <primitiveExpression value="true"/>
                            </methodReturnStatement>
                          </trueStatements>
                        </conditionStatement>-->
											</statements>
										</foreachStatement>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="commandName"/>
											<primitiveExpression value="Select"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<binaryOperatorExpression operator="IdentityInequality">
												<methodInvokeExpression methodName="SelectSingleNode">
													<target>
														<propertyReferenceExpression name="Config"/>
													</target>
													<parameters>
														<primitiveExpression value="/c:dataController/c:fields/c:field[@onDemandHandler!='']"/>
													</parameters>
												</methodInvokeExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method InternalExecuteServerRules(ActionPhase, string, string, string) -->
						<memberMethod name="InternalExecuteServerRules">
							<attributes family="true"/>
							<parameters>
								<parameter type="ActionPhase" name="phase"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="commandName"/>
								<parameter type="System.String" name="commandArgument"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<argumentReferenceExpression name="view"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="view"/>
											<stringEmptyExpression/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Arguments">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ExecuteMethod">
											<target>
												<baseReferenceExpression/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Arguments">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="Result">
													<thisReferenceExpression/>
												</propertyReferenceExpression>
												<argumentReferenceExpression name="phase"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="XPathNodeIterator" name="iterator">
									<init>
										<methodInvokeExpression methodName="Select">
											<target>
												<propertyReferenceExpression name="Config"/>
											</target>
											<parameters>
												<primitiveExpression value="/c:dataController/c:businessRules/c:rule[@phase='{{0}}']"/>
												<argumentReferenceExpression name="phase"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<whileStatement>
									<test>
										<methodInvokeExpression methodName="MoveNext">
											<target>
												<variableReferenceExpression name="iterator"/>
											</target>
										</methodInvokeExpression>
									</test>
									<statements>
										<variableDeclarationStatement type="System.String" name="ruleType">
											<init>
												<methodInvokeExpression methodName="GetAttribute">
													<target>
														<propertyReferenceExpression name="Current">
															<variableReferenceExpression name="iterator"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="type"/>
														<propertyReferenceExpression name="Empty">
															<typeReferenceExpression type="String"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="ruleView">
											<init>
												<methodInvokeExpression methodName="GetAttribute">
													<target>
														<propertyReferenceExpression name="Current">
															<variableReferenceExpression name="iterator"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="view"/>
														<propertyReferenceExpression name="Empty">
															<typeReferenceExpression type="String"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="ruleCommandName">
											<init>
												<methodInvokeExpression methodName="GetAttribute">
													<target>
														<propertyReferenceExpression name="Current">
															<variableReferenceExpression name="iterator"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="commandName"/>
														<propertyReferenceExpression name="Empty">
															<typeReferenceExpression type="String"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="ruleCommandArgument">
											<init>
												<methodInvokeExpression methodName="GetAttribute">
													<target>
														<propertyReferenceExpression name="Current">
															<variableReferenceExpression name="iterator"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="commandArgument"/>
														<propertyReferenceExpression name="Empty">
															<typeReferenceExpression type="String"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="ruleName">
											<init>
												<methodInvokeExpression methodName="GetAttribute">
													<target>
														<propertyReferenceExpression name="Current">
															<variableReferenceExpression name="iterator"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="name"/>
														<propertyReferenceExpression name="Empty">
															<typeReferenceExpression type="String"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="ruleName"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="ruleName"/>
													<methodInvokeExpression methodName="GetAttribute">
														<target>
															<propertyReferenceExpression name="Current">
																<variableReferenceExpression name="iterator"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<primitiveExpression value="id"/>
															<propertyReferenceExpression name="Empty">
																<typeReferenceExpression type="String"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="System.Boolean" name="skip">
											<init>
												<primitiveExpression value="false"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<binaryOperatorExpression operator="BooleanOr">
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="ruleView"/>
														</unaryOperatorExpression>
														<binaryOperatorExpression operator="BooleanOr">
															<binaryOperatorExpression operator="ValueEquality">
																<variableReferenceExpression name="ruleView"/>
																<argumentReferenceExpression name="view"/>
															</binaryOperatorExpression>
															<methodInvokeExpression methodName="IsMatch">
																<target>
																	<typeReferenceExpression type="Regex"/>
																</target>
																<parameters>
																	<argumentReferenceExpression name="view"/>
																	<variableReferenceExpression name="ruleView"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="skip"/>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<binaryOperatorExpression operator="BooleanOr">
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="ruleCommandName"/>
														</unaryOperatorExpression>
														<binaryOperatorExpression operator="BooleanOr">
															<binaryOperatorExpression operator="ValueEquality">
																<variableReferenceExpression name="ruleCommandName"/>
																<argumentReferenceExpression name="commandName"/>
															</binaryOperatorExpression>
															<methodInvokeExpression methodName="IsMatch">
																<target>
																	<typeReferenceExpression type="Regex"/>
																</target>
																<parameters>
																	<argumentReferenceExpression name="commandName"/>
																	<variableReferenceExpression name="ruleCommandName"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="skip"/>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<binaryOperatorExpression operator="BooleanOr">
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="ruleCommandArgument"/>
														</unaryOperatorExpression>
														<binaryOperatorExpression operator="BooleanOr">
															<binaryOperatorExpression operator="ValueEquality">
																<variableReferenceExpression name="ruleCommandArgument"/>
																<argumentReferenceExpression name="commandArgument"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanAnd">
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<argumentReferenceExpression name="commandArgument"/>
																</unaryOperatorExpression>
																<methodInvokeExpression methodName="IsMatch">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<argumentReferenceExpression name="commandArgument"/>
																		<variableReferenceExpression name="ruleCommandArgument"/>
																	</parameters>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="skip"/>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<unaryOperatorExpression operator="Not">
														<variableReferenceExpression name="skip"/>
													</unaryOperatorExpression>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="ruleName"/>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="RuleInWhitelist">
																<parameters>
																	<variableReferenceExpression name="ruleName"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="skip"/>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="RuleInBlacklist">
															<parameters>
																<variableReferenceExpression name="ruleName"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="skip"/>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<variableReferenceExpression name="skip"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="ruleType"/>
															<primitiveExpression value="Sql"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Sql">
															<parameters>
																<propertyReferenceExpression name="Value">
																	<propertyReferenceExpression name="Current">
																		<variableReferenceExpression name="iterator"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="ruleType"/>
															<primitiveExpression value="Code"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="ExecuteRule">
															<parameters>
																<propertyReferenceExpression name="Current">
																	<variableReferenceExpression name="iterator"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<xsl:if test="$IsPremium='true'">
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueEquality">
																<variableReferenceExpression name="ruleType"/>
																<primitiveExpression value="Email"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<methodInvokeExpression methodName="Email">
																<parameters>
																	<propertyReferenceExpression name="Value">
																		<propertyReferenceExpression name="Current">
																			<variableReferenceExpression name="iterator"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</trueStatements>
													</conditionStatement>
												</xsl:if>
												<methodInvokeExpression methodName="BlockRule">
													<parameters>
														<variableReferenceExpression name="ruleName"/>
													</parameters>
												</methodInvokeExpression>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="Canceled">
															<propertyReferenceExpression name="Result"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<breakStatement/>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</whileStatement>
							</statements>
						</memberMethod>
						<!-- method ReplaceFieldNamesWithValues(string) -->
						<memberMethod returnType="System.String" name="ReplaceFieldNamesWithValues">
							<attributes private="true"/>
							<parameters>
								<parameter type="System.String" name="text"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Replace">
										<target>
											<typeReferenceExpression type="Regex"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="text"/>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[\{(?'ParameterMarker':|@)?(?'Name'\w+)(\s*,\s*(?'Format'.+?)\s*)?\}]]></xsl:attribute>
											</primitiveExpression>
											<addressOfExpression>
												<methodReferenceExpression methodName="DoReplaceFieldNameInText"/>
											</addressOfExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method DoRepalceFieldNameInText(Match) -->
						<memberMethod returnType="System.String" name="DoReplaceFieldNameInText">
							<attributes private="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Object" name="v">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="name">
									<init>
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
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<propertyReferenceExpression name="Value">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Groups">
															<argumentReferenceExpression name="m"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="ParameterMarker"/>
													</indices>
												</arrayIndexerExpression>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="v"/>
											<methodInvokeExpression methodName="GetProperty">
												<parameters>
													<variableReferenceExpression name="name"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<variableDeclarationStatement type="Match" name="m2">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="name"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[^(?'Name'\w+?)(_(?'ValueType'NewValue|OldValue|Value|Modified))?$]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="name"/>
											<propertyReferenceExpression name="Value">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Groups">
															<variableReferenceExpression name="m2"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="Name"/>
													</indices>
												</arrayIndexerExpression>
											</propertyReferenceExpression>
										</assignStatement>
										<variableDeclarationStatement type="System.String" name="valueType">
											<init>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<variableReferenceExpression name="m2"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="ValueType"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="FieldValue" name="fvo">
											<init>
												<methodInvokeExpression methodName="SelectFieldValueObject">
													<parameters>
														<variableReferenceExpression name="name"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="fvo"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<propertyReferenceExpression name="Value">
														<argumentReferenceExpression name="m"/>
													</propertyReferenceExpression>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="v"/>
											<propertyReferenceExpression name="Value">
												<variableReferenceExpression name="fvo"/>
											</propertyReferenceExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="valueType"/>
													<primitiveExpression value="NewValue"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="v"/>
													<propertyReferenceExpression name="NewValue">
														<variableReferenceExpression name="fvo"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="valueType"/>
															<primitiveExpression value="OldValue"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="v"/>
															<propertyReferenceExpression name="OldValue">
																<variableReferenceExpression name="fvo"/>
															</propertyReferenceExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="valueType"/>
																	<primitiveExpression value="Modified"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="v"/>
																	<propertyReferenceExpression name="Modified">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.String" name="format">
									<init>
										<propertyReferenceExpression name="Value">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Groups">
														<argumentReferenceExpression name="m"/>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="Format"/>
												</indices>
											</arrayIndexerExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="format"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="format"/>
														</target>
														<parameters>
															<primitiveExpression value="}}"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="format"/>
													<stringFormatExpression>
														<xsl:attribute name="format"><![CDATA[{{0:{0}}}]]></xsl:attribute>
														<methodInvokeExpression methodName="Trim">
															<target>
																<variableReferenceExpression name="format"/>
															</target>
														</methodInvokeExpression>
													</stringFormatExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<methodInvokeExpression methodName="Format">
												<target>
													<typeReferenceExpression type="String"/>
												</target>
												<parameters>
													<variableReferenceExpression name="format"/>
													<variableReferenceExpression name="v"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<convertExpression to="String">
										<variableReferenceExpression name="v"/>
									</convertExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property ActionParameters -->
						<memberField type="SortedDictionary" name="actionParameters">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
						</memberField>
						<memberField type="System.String" name="actionParametersData"/>
						<memberProperty type="SortedDictionary" name="ActionParameters">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="actionParameters"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="actionParameters"/>
											<objectCreateExpression type="SortedDictionary">
												<typeArguments>
													<typeReference type="System.String"/>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</assignStatement>
										<variableDeclarationStatement type="System.String" name="data">
											<init>
												<fieldReferenceExpression name="actionParametersData"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="data"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="data"/>
													<propertyReferenceExpression name="ActionData"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="data"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="data"/>
													<methodInvokeExpression methodName="ReplaceFieldNamesWithValues">
														<parameters>
															<methodInvokeExpression methodName="Replace">
																<target>
																	<typeReferenceExpression type="Regex"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="data"/>
																	<primitiveExpression>
																		<xsl:attribute name="value"><![CDATA[^(?'Name'[\w-]+)\s*:\s*(?'Value'.+?)\s*$]]></xsl:attribute>
																	</primitiveExpression>
																	<addressOfExpression>
																		<methodReferenceExpression methodName="DoReplaceActionParameter"/>
																	</addressOfExpression>
																	<propertyReferenceExpression name="Multiline">
																		<typeReferenceExpression type="RegexOptions"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<fieldReferenceExpression name="actionParameters"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Empty">
															<typeReferenceExpression type="String"/>
														</propertyReferenceExpression>
														<methodInvokeExpression methodName="Trim">
															<target>
																<variableReferenceExpression name="data"/>
															</target>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<fieldReferenceExpression name="actionParameters"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method DoReplaceActionParameter(Match) -->
						<memberMethod returnType="System.String" name="DoReplaceActionParameter">
							<attributes private="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="name">
									<init>
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
															<primitiveExpression value="Name"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="value">
									<init>
										<methodInvokeExpression methodName="ReplaceFieldNamesWithValues">
											<parameters>
												<propertyReferenceExpression name="Value">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Groups">
																<argumentReferenceExpression name="m"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="Value"/>
														</indices>
													</arrayIndexerExpression>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="ContainsKey">
												<target>
													<fieldReferenceExpression name="actionParameters"/>
												</target>
												<parameters>
													<variableReferenceExpression name="name"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="Add">
											<target>
												<fieldReferenceExpression name="actionParameters"/>
											</target>
											<parameters>
												<variableReferenceExpression name="name"/>
												<variableReferenceExpression name="value"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<propertyReferenceExpression name="Empty">
										<typeReferenceExpression type="String"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AssignActionParameters(string) -->
						<memberMethod name="AssignActionParameters">
							<attributes family="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="data"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="EnableEmailMessages"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="actionParameters"/>
											<primitiveExpression value="null"/>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="actionParametersData"/>
											<argumentReferenceExpression name="data"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method GetActionParameterByName(string) -->
						<memberMethod returnType="System.String" name="GetActionParameterByName">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetActionParameterByName">
										<parameters>
											<argumentReferenceExpression name="name"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetActionParameterByName(string, object) -->
						<memberMethod returnType="System.String" name="GetActionParameterByName">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
								<parameter type="System.Object" name="defaultValue"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="v">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<propertyReferenceExpression name="ActionParameters"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="ToLower">
														<target>
															<argumentReferenceExpression name="name"/>
														</target>
													</methodInvokeExpression>
													<directionExpression direction="Out">
														<variableReferenceExpression name="v"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<convertExpression to="String">
												<argumentReferenceExpression name="defaultValue"/>
											</convertExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="v"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<xsl:if test="$IsPremium='true'">
							<!-- method Email(DataRow) -->
							<memberMethod name="Email">
								<attributes family="true"/>
								<parameters>
									<parameter type="DataRow" name="message"/>
								</parameters>
								<statements>
									<assignStatement>
										<fieldReferenceExpression name="actionParameters"/>
										<objectCreateExpression type="SortedDictionary">
											<typeArguments>
												<typeReference type="System.String"/>
												<typeReference type="System.String"/>
											</typeArguments>
										</objectCreateExpression>
									</assignStatement>
									<foreachStatement>
										<variable type="DataColumn" name="c" var="false"/>
										<target>
											<propertyReferenceExpression name="Columns">
												<propertyReferenceExpression name="Table">
													<argumentReferenceExpression name="message"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</target>
										<statements>
											<variableDeclarationStatement type="System.Object" name="v">
												<init>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="message"/>
														</target>
														<indices>
															<propertyReferenceExpression name="ColumnName">
																<variableReferenceExpression name="c"/>
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
													<variableDeclarationStatement type="System.String" name="loweredName">
														<init>
															<methodInvokeExpression methodName="ToLower">
																<target>
																	<propertyReferenceExpression name="ColumnName">
																		<variableReferenceExpression name="c"/>
																	</propertyReferenceExpression>
																</target>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueEquality">
																<variableReferenceExpression name="loweredName"/>
																<primitiveExpression value="body"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="loweredName"/>
																<stringEmptyExpression/>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<fieldReferenceExpression name="actionParameters"/>
															</target>
															<indices>
																<variableReferenceExpression name="loweredName"/>
															</indices>
														</arrayIndexerExpression>
														<convertExpression to="String">
															<variableReferenceExpression name="v"/>
														</convertExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
									<comment>require "To" and "Subject" to be present</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<methodInvokeExpression methodName="ContainsKey">
													<target>
														<fieldReferenceExpression name="actionParameters"/>
													</target>
													<parameters>
														<primitiveExpression value="to"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="ContainsKey">
													<target>
														<fieldReferenceExpression name="actionParameters"/>
													</target>
													<parameters>
														<primitiveExpression value="subject"/>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Email">
												<parameters>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method Email(string) -->
							<memberMethod name="Email">
								<attributes family="true"/>
								<parameters>
									<parameter type="System.String" name="data"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="Email">
										<parameters>
											<argumentReferenceExpression name="data"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method Email(string) -->
							<memberMethod name="Email">
								<attributes family="true"/>
								<parameters>
									<parameter type="MailMessage" name="message"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="Email">
										<parameters>
											<primitiveExpression value="null"/>
											<argumentReferenceExpression name="message"/>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method Email(string, MailMessage ) -->
							<memberMethod name="Email">
								<attributes family="true"/>
								<parameters>
									<parameter type="System.String" name="data"/>
									<parameter type="MailMessage" name="message"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="AssignActionParameters">
										<parameters>
											<argumentReferenceExpression name="data"/>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="SmtpClient" name="smtp">
										<init>
											<objectCreateExpression type="SmtpClient"/>
										</init>
									</variableDeclarationStatement>
									<comment>configure SMTP properties</comment>
									<variableDeclarationStatement type="System.String" name="host">
										<init>
											<methodInvokeExpression methodName="GetActionParameterByName">
												<parameters>
													<primitiveExpression value="Host"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="host"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="Host">
													<variableReferenceExpression name="smtp"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="host"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="port">
										<init>
											<methodInvokeExpression methodName="GetActionParameterByName">
												<parameters>
													<primitiveExpression value="Port"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="port"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="Port">
													<variableReferenceExpression name="smtp"/>
												</propertyReferenceExpression>
												<convertExpression to="Int32">
													<variableReferenceExpression name="port"/>
												</convertExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="enableSsl">
										<init>
											<methodInvokeExpression methodName="GetActionParameterByName">
												<parameters>
													<primitiveExpression value="EnableSSL"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="enableSsl"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="EnableSsl">
													<variableReferenceExpression name="smtp"/>
												</propertyReferenceExpression>
												<binaryOperatorExpression operator="ValueEquality">
													<methodInvokeExpression methodName="ToLower">
														<target>
															<variableReferenceExpression name="enableSsl"/>
														</target>
													</methodInvokeExpression>
													<primitiveExpression value="true" convertTo="String"/>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="userName">
										<init>
											<methodInvokeExpression methodName="GetActionParameterByName">
												<parameters>
													<primitiveExpression value="UserName"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="password">
										<init>
											<methodInvokeExpression methodName="GetActionParameterByName">
												<parameters>
													<primitiveExpression value="Password"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="userName"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="Credentials">
													<variableReferenceExpression name="smtp"/>
												</propertyReferenceExpression>
												<objectCreateExpression type="NetworkCredential">
													<parameters>
														<variableReferenceExpression name="userName"/>
														<variableReferenceExpression name="password"/>
														<methodInvokeExpression methodName="GetActionParameterByName">
															<parameters>
																<primitiveExpression value="Domain"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</objectCreateExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<comment>configure message properties</comment>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<argumentReferenceExpression name="message"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<argumentReferenceExpression name="message"/>
												<objectCreateExpression type="MailMessage"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="ConfigureMailMessage">
										<parameters>
											<variableReferenceExpression name="smtp"/>
											<variableReferenceExpression name="message"/>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="System.String" name="recepient">
										<init>
											<methodInvokeExpression methodName="GetActionParameterByName">
												<parameters>
													<primitiveExpression value="To"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="AddMailAddresses">
										<parameters>
											<propertyReferenceExpression name="To">
												<variableReferenceExpression name="message"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="recepient"/>
										</parameters>
									</methodInvokeExpression>
									<variableDeclarationStatement type="System.String" name="sender">
										<init>
											<methodInvokeExpression methodName="GetActionParameterByName">
												<parameters>
													<primitiveExpression value="From"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="sender"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="From">
													<variableReferenceExpression name="message"/>
												</propertyReferenceExpression>
												<objectCreateExpression type="MailAddress">
													<parameters>
														<variableReferenceExpression name="sender"/>
													</parameters>
												</objectCreateExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="cc">
										<init>
											<methodInvokeExpression methodName="GetActionParameterByName">
												<parameters>
													<primitiveExpression value="Cc"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="cc"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="AddMailAddresses">
												<parameters>
													<propertyReferenceExpression name="CC">
														<variableReferenceExpression name="message"/>
													</propertyReferenceExpression>
													<variableReferenceExpression name="cc"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="bcc">
										<init>
											<methodInvokeExpression methodName="GetActionParameterByName">
												<parameters>
													<primitiveExpression value="Bcc"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="bcc"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="AddMailAddresses">
												<parameters>
													<propertyReferenceExpression name="Bcc">
														<variableReferenceExpression name="message"/>
													</propertyReferenceExpression>
													<variableReferenceExpression name="bcc"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<propertyReferenceExpression name="Subject">
													<argumentReferenceExpression name="message"/>
												</propertyReferenceExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="Subject">
													<variableReferenceExpression name="message"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="GetActionParameterByName">
													<parameters>
														<primitiveExpression value="Subject"/>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<propertyReferenceExpression name="Body">
													<argumentReferenceExpression name="message"/>
												</propertyReferenceExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="Body">
													<variableReferenceExpression name="message"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="GetActionParameterByName">
													<parameters>
														<propertyReferenceExpression name="Empty">
															<typeReferenceExpression type="String"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="Clear">
										<target>
											<fieldReferenceExpression name="actionParameters"/>
										</target>
									</methodInvokeExpression>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<propertyReferenceExpression name="Body">
													<argumentReferenceExpression name="message"/>
												</propertyReferenceExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="Body">
													<argumentReferenceExpression name="message"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="Replace">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Body">
															<argumentReferenceExpression name="message"/>
														</propertyReferenceExpression>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[<attachment\s+type\s*=s*"(report|file)"\s*>([\s\S]+?)</attachment>]]></xsl:attribute>
														</primitiveExpression>
														<addressOfExpression>
															<methodReferenceExpression methodName="DoExtractAttachment"/>
														</addressOfExpression>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<propertyReferenceExpression name="IsBodyHtml">
											<variableReferenceExpression name="message"/>
										</propertyReferenceExpression>
										<methodInvokeExpression methodName="IsMatch">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Body">
													<variableReferenceExpression name="message"/>
												</propertyReferenceExpression>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[(</\w+>)|(<\w+>)]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<comment>produce attachments</comment>
									<foreachStatement>
										<variable type="System.String" name="key"/>
										<target>
											<propertyReferenceExpression name="Keys">
												<fieldReferenceExpression name="actionParameters"/>
											</propertyReferenceExpression>
										</target>
										<statements>
											<tryStatement>
												<statements>
													<variableDeclarationStatement type="XPathNavigator" name="nav">
														<init>
															<methodInvokeExpression methodName="CreateNavigator">
																<target>
																	<objectCreateExpression type="XPathDocument">
																		<parameters>
																			<objectCreateExpression type="StringReader">
																				<parameters>
																					<arrayIndexerExpression>
																						<target>
																							<fieldReferenceExpression name="actionParameters"/>
																						</target>
																						<indices>
																							<variableReferenceExpression name="key"/>
																						</indices>
																					</arrayIndexerExpression>
																				</parameters>
																			</objectCreateExpression>
																		</parameters>
																	</objectCreateExpression>
																</target>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<variableDeclarationStatement type="System.String" name="attachmentType">
														<init>
															<castExpression targetType="System.String">
																<methodInvokeExpression methodName="Evaluate">
																	<target>
																		<variableReferenceExpression name="nav"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="string(/attachment/@type)"/>
																	</parameters>
																</methodInvokeExpression>
															</castExpression>
														</init>
													</variableDeclarationStatement>
													<variableDeclarationStatement type="System.String" name="attachmentName">
														<init>
															<castExpression targetType="System.String">
																<methodInvokeExpression methodName="Evaluate">
																	<target>
																		<variableReferenceExpression name="nav"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="string(/attachment/name)"/>
																	</parameters>
																</methodInvokeExpression>
															</castExpression>
														</init>
													</variableDeclarationStatement>
													<variableDeclarationStatement type="System.String" name="mediaType">
														<init>
															<primitiveExpression value="null"/>
														</init>
													</variableDeclarationStatement>
													<variableDeclarationStatement type="System.Byte[]" name="attachmentData">
														<init>
															<primitiveExpression value="null"/>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueEquality">
																<variableReferenceExpression name="attachmentType"/>
																<primitiveExpression value="report"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<xsl:if test="a:project/a:reports/@enabled='true'">
																<variableDeclarationStatement type="System.String" name="argValue"/>
																<variableDeclarationStatement type="ReportArgs" name="args">
																	<init>
																		<objectCreateExpression type="ReportArgs"/>
																	</init>
																</variableDeclarationStatement>
																<comment>controller</comment>
																<assignStatement>
																	<variableReferenceExpression name="argValue"/>
																	<castExpression targetType="System.String">
																		<methodInvokeExpression methodName="Evaluate">
																			<target>
																				<variableReferenceExpression name="nav"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="string(/attachment/controller)"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="argValue"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="Controller">
																				<variableReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="argValue"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<comment>view</comment>
																<assignStatement>
																	<variableReferenceExpression name="argValue"/>
																	<castExpression targetType="System.String">
																		<methodInvokeExpression methodName="Evaluate">
																			<target>
																				<variableReferenceExpression name="nav"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="string(/attachment/view)"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="argValue"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="View">
																				<variableReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="argValue"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<comment>template name</comment>
																<assignStatement>
																	<variableReferenceExpression name="argValue"/>
																	<castExpression targetType="System.String">
																		<methodInvokeExpression methodName="Evaluate">
																			<target>
																				<variableReferenceExpression name="nav"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="string(/attachment/templateName)"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="argValue"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="TemplateName">
																				<variableReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="argValue"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<comment>format</comment>
																<assignStatement>
																	<variableReferenceExpression name="argValue"/>
																	<castExpression targetType="System.String">
																		<methodInvokeExpression methodName="Evaluate">
																			<target>
																				<variableReferenceExpression name="nav"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="string(/attachment/format)"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="argValue"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="Format">
																				<variableReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="argValue"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<comment>sort expression</comment>
																<assignStatement>
																	<variableReferenceExpression name="argValue"/>
																	<castExpression targetType="System.String">
																		<methodInvokeExpression methodName="Evaluate">
																			<target>
																				<variableReferenceExpression name="nav"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="string(/attachment/sortExpression)"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="argValue"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="SortExpression">
																				<variableReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="argValue"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<comment>filter details</comment>
																<assignStatement>
																	<variableReferenceExpression name="argValue"/>
																	<castExpression targetType="System.String">
																		<methodInvokeExpression methodName="Evaluate">
																			<target>
																				<variableReferenceExpression name="nav"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="string(/attachment/filterDetails)"/>
																			</parameters>
																		</methodInvokeExpression>
																	</castExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="argValue"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="FilterDetails">
																				<variableReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="argValue"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<comment>filter</comment>
																<variableDeclarationStatement type="List" name="filter">
																	<typeArguments>
																		<typeReference type="FieldFilter"/>
																	</typeArguments>
																	<init>
																		<objectCreateExpression type="List">
																			<typeArguments>
																				<typeReference type="FieldFilter"/>
																			</typeArguments>
																		</objectCreateExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="XPathNodeIterator" name="filterIterator">
																	<init>
																		<methodInvokeExpression methodName="Select">
																			<target>
																				<variableReferenceExpression name="nav"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="/attachment/filter/item"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<whileStatement>
																	<test>
																		<methodInvokeExpression methodName="MoveNext">
																			<target>
																				<variableReferenceExpression name="filterIterator"/>
																			</target>
																		</methodInvokeExpression>
																	</test>
																	<statements>
																		<variableDeclarationStatement type="FieldFilter" name="ff">
																			<init>
																				<objectCreateExpression type="FieldFilter"/>
																			</init>
																		</variableDeclarationStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="FieldName">
																				<variableReferenceExpression name="ff"/>
																			</propertyReferenceExpression>
																			<castExpression targetType="System.String">
																				<methodInvokeExpression methodName="Evaluate">
																					<target>
																						<propertyReferenceExpression name="Current">
																							<variableReferenceExpression name="filterIterator"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<primitiveExpression value="string(field)"/>
																					</parameters>
																				</methodInvokeExpression>
																			</castExpression>
																		</assignStatement>
																		<variableDeclarationStatement type="System.String" name="operatorName">
																			<init>
																				<castExpression targetType="System.String">
																					<methodInvokeExpression methodName="Evaluate">
																						<target>
																							<propertyReferenceExpression name="Current">
																								<variableReferenceExpression name="filterIterator"/>
																							</propertyReferenceExpression>
																						</target>
																						<parameters>
																							<primitiveExpression value="string(operator)"/>
																						</parameters>
																					</methodInvokeExpression>
																				</castExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<methodInvokeExpression methodName="IsMatch">
																					<target>
																						<typeReferenceExpression type="Regex"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="operatorName"/>
																						<primitiveExpression value="\w+"/>
																					</parameters>
																				</methodInvokeExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="operatorName"/>
																					<stringFormatExpression format="${{0}}$">
																						<variableReferenceExpression name="operatorName"/>
																					</stringFormatExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<variableDeclarationStatement type="System.Int32" name="operatorIndex">
																			<init>
																				<methodInvokeExpression methodName="IndexOf">
																					<target>
																						<typeReferenceExpression type="Array"/>
																					</target>
																					<parameters>
																						<propertyReferenceExpression name="ComparisonOperations">
																							<typeReferenceExpression type="RowFilterAttribute"/>
																						</propertyReferenceExpression>
																						<variableReferenceExpression name="operatorName"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueInequality">
																					<variableReferenceExpression name="operatorIndex"/>
																					<primitiveExpression value="-1"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<propertyReferenceExpression name="Operation">
																						<variableReferenceExpression name="ff"/>
																					</propertyReferenceExpression>
																					<castExpression targetType="RowFilterOperation">
																						<variableReferenceExpression name="operatorIndex"/>
																					</castExpression>
																				</assignStatement>
																				<variableDeclarationStatement type="List" name="values">
																					<typeArguments>
																						<typeReference type="System.Object"/>
																					</typeArguments>
																					<init>
																						<objectCreateExpression type="List">
																							<typeArguments>
																								<typeReference type="System.Object"/>
																							</typeArguments>
																						</objectCreateExpression>
																					</init>
																				</variableDeclarationStatement>
																				<variableDeclarationStatement type="XPathNodeIterator" name="valueIterator">
																					<init>
																						<methodInvokeExpression methodName="Select">
																							<target>
																								<propertyReferenceExpression name="Current">
																									<variableReferenceExpression name="filterIterator"/>
																								</propertyReferenceExpression>
																							</target>
																							<parameters>
																								<primitiveExpression value="value"/>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<whileStatement>
																					<test>
																						<methodInvokeExpression methodName="MoveNext">
																							<target>
																								<variableReferenceExpression name="valueIterator"/>
																							</target>
																						</methodInvokeExpression>
																					</test>
																					<statements>
																						<variableDeclarationStatement type="System.Object" name="v" var="false">
																							<init>
																								<propertyReferenceExpression name="Value">
																									<propertyReferenceExpression name="Current">
																										<variableReferenceExpression name="valueIterator"/>
																									</propertyReferenceExpression>
																								</propertyReferenceExpression>
																							</init>
																						</variableDeclarationStatement>
																						<variableDeclarationStatement type="System.String" name="t">
																							<init>
																								<methodInvokeExpression methodName="GetAttribute">
																									<target>
																										<propertyReferenceExpression name="Current">
																											<variableReferenceExpression name="valueIterator"/>
																										</propertyReferenceExpression>
																									</target>
																									<parameters>
																										<primitiveExpression value="type"/>
																										<stringEmptyExpression/>
																									</parameters>
																								</methodInvokeExpression>
																							</init>
																						</variableDeclarationStatement>
																						<conditionStatement>
																							<condition>
																								<unaryOperatorExpression operator="IsNotNullOrEmpty">
																									<variableReferenceExpression name="t"/>
																								</unaryOperatorExpression>
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
																											<methodInvokeExpression methodName="GetType">
																												<target>
																													<typeReferenceExpression type="Type"/>
																												</target>
																												<parameters>
																													<binaryOperatorExpression operator="Add">
																														<primitiveExpression value="System."/>
																														<variableReferenceExpression name="t"/>
																													</binaryOperatorExpression>
																												</parameters>
																											</methodInvokeExpression>
																										</parameters>
																									</methodInvokeExpression>
																								</assignStatement>
																							</trueStatements>
																						</conditionStatement>
																						<methodInvokeExpression methodName="Add">
																							<target>
																								<variableReferenceExpression name="values"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="v"/>
																							</parameters>
																						</methodInvokeExpression>
																					</statements>
																				</whileStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="ValueEquality">
																							<propertyReferenceExpression name="Count">
																								<variableReferenceExpression name="values"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="1"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<propertyReferenceExpression name="Value">
																								<variableReferenceExpression name="ff"/>
																							</propertyReferenceExpression>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="values"/>
																								</target>
																								<indices>
																									<primitiveExpression value="0"/>
																								</indices>
																							</arrayIndexerExpression>
																						</assignStatement>
																					</trueStatements>
																					<falseStatements>
																						<assignStatement>
																							<propertyReferenceExpression name="Value">
																								<variableReferenceExpression name="ff"/>
																							</propertyReferenceExpression>
																							<methodInvokeExpression methodName="ToArray">
																								<target>
																									<variableReferenceExpression name="values"/>
																								</target>
																							</methodInvokeExpression>
																						</assignStatement>
																					</falseStatements>
																				</conditionStatement>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="filter"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="ff"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</whileStatement>
																<assignStatement>
																	<propertyReferenceExpression name="Filter">
																		<variableReferenceExpression name="args"/>
																	</propertyReferenceExpression>
																	<methodInvokeExpression methodName="ToArray">
																		<target>
																			<variableReferenceExpression name="filter"/>
																		</target>
																	</methodInvokeExpression>
																</assignStatement>
																<assignStatement>
																	<variableReferenceExpression name="attachmentData"/>
																	<methodInvokeExpression methodName="Execute">
																		<target>
																			<typeReferenceExpression type="ReportBase"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="args"/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
																<assignStatement>
																	<variableReferenceExpression name="mediaType"/>
																	<propertyReferenceExpression name="MimeType">
																		<variableReferenceExpression name="args"/>
																	</propertyReferenceExpression>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNullOrEmpty">
																			<variableReferenceExpression name="attachmentName"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="attachmentName"/>
																			<binaryOperatorExpression operator="Add">
																				<propertyReferenceExpression name="Controller">
																					<variableReferenceExpression name="args"/>
																				</propertyReferenceExpression>
																				<variableReferenceExpression name="key"/>
																			</binaryOperatorExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<assignStatement>
																	<variableReferenceExpression name="attachmentName"/>
																	<stringFormatExpression format="{{0}}.{{1}}">
																		<variableReferenceExpression name="attachmentName"/>
																		<propertyReferenceExpression name="FileNameExtension">
																			<variableReferenceExpression name="args"/>
																		</propertyReferenceExpression>
																	</stringFormatExpression>
																</assignStatement>
															</xsl:if>
														</trueStatements>
													</conditionStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="IdentityInequality">
																<variableReferenceExpression name="attachmentData"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<methodInvokeExpression methodName="Add">
																<target>
																	<propertyReferenceExpression name="Attachments">
																		<variableReferenceExpression name="message"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<objectCreateExpression type="Attachment">
																		<parameters>
																			<objectCreateExpression type="MemoryStream">
																				<parameters>
																					<variableReferenceExpression name="attachmentData"/>
																				</parameters>
																			</objectCreateExpression>
																			<variableReferenceExpression name="attachmentName"/>
																			<variableReferenceExpression name="mediaType"/>
																		</parameters>
																	</objectCreateExpression>
																</parameters>
															</methodInvokeExpression>
														</trueStatements>
													</conditionStatement>
												</statements>
												<catch exceptionType="Exception" localName="error">
													<variableDeclarationStatement type="Stream" name="errorContent">
														<init>
															<objectCreateExpression type="MemoryStream"/>
														</init>
													</variableDeclarationStatement>
													<variableDeclarationStatement type="StreamWriter" name="esw">
														<init>
															<objectCreateExpression type="StreamWriter">
																<parameters>
																	<variableReferenceExpression name="errorContent"/>
																</parameters>
															</objectCreateExpression>
														</init>
													</variableDeclarationStatement>
													<methodInvokeExpression methodName="Write">
														<target>
															<variableReferenceExpression name="esw"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Message">
																<variableReferenceExpression name="error"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
													<methodInvokeExpression methodName="Flush">
														<target>
															<variableReferenceExpression name="esw"/>
														</target>
													</methodInvokeExpression>
													<assignStatement>
														<propertyReferenceExpression name="Position">
															<variableReferenceExpression name="errorContent"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</assignStatement>
													<methodInvokeExpression methodName="Add">
														<target>
															<propertyReferenceExpression name="Attachments">
																<variableReferenceExpression name="message"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<objectCreateExpression type="Attachment">
																<parameters>
																	<variableReferenceExpression name="errorContent"/>
																	<binaryOperatorExpression operator="Add">
																		<variableReferenceExpression name="key"/>
																		<primitiveExpression value=".txt"/>
																	</binaryOperatorExpression>
																	<primitiveExpression value="text/plain"/>
																</parameters>
															</objectCreateExpression>
														</parameters>
													</methodInvokeExpression>
												</catch>
											</tryStatement>
										</statements>
									</foreachStatement>
									<comment>send message</comment>
									<variableDeclarationStatement type="WaitCallback" name="workItem" var="false">
										<init>
											<addressOfExpression>
												<methodReferenceExpression methodName="DoSendEmail"/>
											</addressOfExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="QueueUserWorkItem">
										<target>
											<typeReferenceExpression type="ThreadPool"/>
										</target>
										<parameters>
											<variableReferenceExpression name="workItem"/>
											<arrayCreateExpression >
												<createType type="System.Object"/>
												<initializers>
													<variableReferenceExpression name="smtp"/>
													<variableReferenceExpression name="message"/>
													<methodInvokeExpression methodName="CreateBusinessRules">
														<target>
															<fieldReferenceExpression name="config"/>
														</target>
													</methodInvokeExpression>
												</initializers>
											</arrayCreateExpression>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method DoSendEmail(object) -->
							<memberMethod name="DoSendEmail">
								<attributes final="true" static="true"/>
								<parameters>
									<parameter type="System.Object" name="state"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="System.Object[]" name="args">
										<init>
											<castExpression targetType="System.Object[]">
												<argumentReferenceExpression name="state"/>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="SmtpClient" name="smtp">
										<init>
											<castExpression targetType="SmtpClient">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="args"/>
													</target>
													<indices>
														<primitiveExpression value="0"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="MailMessage" name="message">
										<init>
											<castExpression targetType="MailMessage">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="args"/>
													</target>
													<indices>
														<primitiveExpression value="1"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<tryStatement>
										<statements>
											<methodInvokeExpression methodName="Send">
												<target>
													<variableReferenceExpression name="smtp"/>
												</target>
												<parameters>
													<variableReferenceExpression name="message"/>
												</parameters>
											</methodInvokeExpression>
										</statements>
										<catch exceptionType="Exception" localName="error">
											<methodInvokeExpression methodName="HandleEmailException">
												<target>
													<castExpression targetType="BusinessRules">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="args"/>
															</target>
															<indices>
																<primitiveExpression value="2"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="smtp"/>
													<variableReferenceExpression name="message"/>
													<variableReferenceExpression name="error"/>
												</parameters>
											</methodInvokeExpression>
										</catch>
									</tryStatement>
								</statements>
							</memberMethod>
							<!-- method HandleEmailException(SmtpClient, MailMessage, Exception) -->
							<memberMethod name="HandleEmailException">
								<attributes family="true"/>
								<parameters>
									<parameter type="SmtpClient" name="smtp"/>
									<parameter type="MailMessage" name="message"/>
									<parameter type="Exception" name="error"/>
								</parameters>
							</memberMethod>
							<!-- method DoExtractAttachment(Match) -->
							<memberMethod returnType="System.String" name="DoExtractAttachment">
								<attributes private="true"/>
								<parameters>
									<parameter type="Match" name="m"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="Add">
										<target>
											<fieldReferenceExpression name="actionParameters"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="ToString">
												<target>
													<binaryOperatorExpression operator="Add">
														<propertyReferenceExpression name="Count">
															<fieldReferenceExpression name="actionParameters"/>
														</propertyReferenceExpression>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</target>
												<parameters>
													<primitiveExpression value="D3"/>
												</parameters>
											</methodInvokeExpression>
											<propertyReferenceExpression name="Value">
												<variableReferenceExpression name="m"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
									<methodReturnStatement>
										<stringEmptyExpression/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<memberMethod name="AddMailAddresses">
								<comment>
									<![CDATA[
        /// <summary>
        /// Adds email addresses with optional display names from the string list to the mail address collection.
        /// </summary>
        /// <param name="list">The collection of mail addresses.</param>
        /// <param name="addresses">The string of addresses separated with comma and semicolon with optional display names.</param>
                ]]>
								</comment>
								<attributes family="true"/>
								<parameters>
									<parameter type="MailAddressCollection" name="list"/>
									<parameter type="System.String" name="addresses"/>
								</parameters>
								<statements>
									<assignStatement>
										<variableReferenceExpression name="addresses"/>
										<methodInvokeExpression methodName="Replace">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="addresses"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[(\s*(,|;)\s*(,|;)\s*)+]]></xsl:attribute>
												</primitiveExpression>
												<primitiveExpression value=","/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<assignStatement>
										<variableReferenceExpression name="addresses"/>
										<methodInvokeExpression methodName="Replace">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="addresses"/>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[(('|")\s*('|"))]]></xsl:attribute>
												</primitiveExpression>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<variableDeclarationStatement type="Match" name="address">
										<init>
											<methodInvokeExpression methodName="Match">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="addresses"/>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[\s*(?'Email'((".+")|('.+'))?(.+?))\s*(,|;|$)]]></xsl:attribute>
													</primitiveExpression>
												</parameters>
											</methodInvokeExpression>
											<!--<methodInvokeExpression methodName="Match">
                        <target>
                          <propertyReferenceExpression name="EmailListRegex">
                            <argumentReferenceExpression name="addresses"/>
                          </propertyReferenceExpression>
                        </target>
                      </methodInvokeExpression>-->
										</init>
									</variableDeclarationStatement>
									<whileStatement>
										<test>
											<propertyReferenceExpression name="Success">
												<variableReferenceExpression name="address"/>
											</propertyReferenceExpression>
										</test>
										<statements>
											<variableDeclarationStatement type="Match" name="m">
												<init>
													<methodInvokeExpression methodName="Match">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="Trim">
																<target>
																	<propertyReferenceExpression name="Value">
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups">
																					<variableReferenceExpression name="address"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="Email"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="," convertTo="Char"/>
																	<primitiveExpression value=";" convertTo="Char"/>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[^\s*(((?'DisplayName'.+?)?\s*<\s*(?'Address'.+?@.+?)\s*>)|(?'Address'.+?@.+?))\s*$]]></xsl:attribute>
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
													<methodInvokeExpression methodName="Add">
														<target>
															<argumentReferenceExpression name="list"/>
														</target>
														<parameters>
															<objectCreateExpression type="MailAddress">
																<parameters>
																	<propertyReferenceExpression name="Value">
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups">
																					<variableReferenceExpression name="m"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="Address"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
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
																						<primitiveExpression value="DisplayName"/>
																					</indices>
																				</arrayIndexerExpression>
																			</propertyReferenceExpression>
																		</target>
																		<parameters>
																			<primitiveExpression value="'" convertTo="Char"/>
																			<primitiveExpression value="&quot;" convertTo="Char"/>
																		</parameters>
																	</methodInvokeExpression>
																	<propertyReferenceExpression name="UTF8">
																		<typeReferenceExpression type="Encoding"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<assignStatement>
												<variableReferenceExpression name="address"/>
												<methodInvokeExpression methodName="NextMatch">
													<target>
														<variableReferenceExpression name="address"/>
													</target>
												</methodInvokeExpression>
											</assignStatement>
										</statements>
									</whileStatement>
								</statements>
							</memberMethod>
							<!-- method ConfigureMailMessage(SmtpClient, MailMessage) -->
							<memberMethod name="ConfigureMailMessage">
								<comment>
									<![CDATA[
        /// <summary>
        /// Configures a new email message with default parameters.
        /// </summary>
        /// <param name="smtp">The SMTP client that will send the message.</param>
        /// <param name="message">The new message with the default configuration</param>
        ]]>
								</comment>
								<attributes family="true"/>
								<parameters>
									<parameter type="SmtpClient" name="smtp"/>
									<parameter type="MailMessage" name="message"/>
								</parameters>
							</memberMethod>
						</xsl:if>
						<!-- property ActionData -->
						<memberProperty type="System.String" name="ActionData">
							<comment>
								<![CDATA[
        /// <summary>
        /// The value of the 'Data' property of the currently processed action as defined in the data controller.
        /// </summary>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Arguments"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ReadActionData">
												<target>
													<propertyReferenceExpression name="Config"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Path">
														<propertyReferenceExpression name="Arguments"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method JavaScriptString(string, bool) -->
						<memberMethod returnType="System.String" name="JavaScriptString">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Object" name="value"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="JavaScriptString">
										<parameters>
											<argumentReferenceExpression name="value"/>
											<primitiveExpression value="false"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method JavaScriptString(string, bool) -->
						<memberMethod returnType="System.String" name="JavaScriptString">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Object" name="value"/>
								<parameter type="System.Boolean" name="addSingleQuotes"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="s">
									<init>
										<xsl:choose>
											<xsl:when test="a:project/@targetFramework!='3.5'">
												<methodInvokeExpression methodName="JavaScriptStringEncode">
													<target>
														<typeReferenceExpression type="System.Web.HttpUtility"/>
													</target>
													<parameters>
														<convertExpression to="String">
															<argumentReferenceExpression name="value"/>
														</convertExpression>
													</parameters>
												</methodInvokeExpression>
											</xsl:when>
											<xsl:otherwise>
												<methodInvokeExpression methodName="Replace">
													<target>
														<methodInvokeExpression methodName="Replace">
															<target>
																<methodInvokeExpression methodName="Replace">
																	<target>
																		<convertExpression to="String">
																			<argumentReferenceExpression name="value"/>
																		</convertExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="&#13;&#10;"/>
																		<primitiveExpression value="\r\n"/>
																	</parameters>
																</methodInvokeExpression>
															</target>
															<parameters>
																<primitiveExpression value="'"/>
																<primitiveExpression value="\'"/>
															</parameters>
														</methodInvokeExpression>
													</target>
													<parameters>
														<primitiveExpression value="&quot;"/>
														<primitiveExpression value="\&quot;"/>
													</parameters>
												</methodInvokeExpression>
											</xsl:otherwise>
										</xsl:choose>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<argumentReferenceExpression name="addSingleQuotes"/>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="s"/>
											<stringFormatExpression format="'{{0}}''">
												<argumentReferenceExpression name="s"/>
											</stringFormatExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="s"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- 
        protected virtual void ConfigureSqlQuery(SqlText query)
        {
        }
            -->
						<!-- method ConfigureSqlQuery(SqlText) -->
						<memberMethod name="ConfigureSqlQuery">
							<attributes family="true"/>
							<parameters>
								<parameter type="SqlText" name="query"/>
							</parameters>
						</memberMethod>
						<xsl:if test="$PageImplementation = 'html'">
							<!-- method AfterSqlAction(ActionArgs, ActionResult) -->
							<memberMethod name="AfterSqlAction">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="ActionArgs" name="args"/>
									<parameter type="ActionResult" name="result"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="AfterSqlAction">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<argumentReferenceExpression name="args"/>
											<argumentReferenceExpression name="result"/>
										</parameters>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="AfterAction">
										<target>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="ApplicationServices"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<argumentReferenceExpression name="args"/>
											<argumentReferenceExpression name="result"/>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
						</xsl:if>
						<!-- method BeforeSqlAction(ActionArgs, ActionResult) -->
						<memberMethod name="BeforeSqlAction">
							<attributes family="true" override="true"/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
							<statements>
								<comment>perform server-side check to make sure that commands Insert|Update|Delete are allowed</comment>
								<variableDeclarationStatement name="allow">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="IsSystemController">
												<parameters>
													<propertyReferenceExpression name="Controller">
														<argumentReferenceExpression name="args"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="acl">
											<init>
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="AccessControlList"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="Enabled">
													<variableReferenceExpression name="acl"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="ValueEquality">
																<propertyReferenceExpression name="CommandName">
																	<argumentReferenceExpression name="args"/>
																</propertyReferenceExpression>
																<primitiveExpression value="Insert"/>
															</binaryOperatorExpression>
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression methodName="PermissionGranted">
																	<target>
																		<variableReferenceExpression name="acl"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Controller">
																			<typeReferenceExpression type="PermissionKind"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Controller">
																			<argumentReferenceExpression name="args"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="create"/>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="allow"/>
															<primitiveExpression value="false"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="ValueEquality">
																<propertyReferenceExpression name="CommandName">
																	<argumentReferenceExpression name="args"/>
																</propertyReferenceExpression>
																<primitiveExpression value="Update"/>
															</binaryOperatorExpression>
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression methodName="PermissionGranted">
																	<target>
																		<variableReferenceExpression name="acl"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Controller">
																			<typeReferenceExpression type="PermissionKind"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Controller">
																			<argumentReferenceExpression name="args"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="update"/>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="allow"/>
															<primitiveExpression value="false"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="ValueEquality">
																<propertyReferenceExpression name="CommandName">
																	<argumentReferenceExpression name="args"/>
																</propertyReferenceExpression>
																<primitiveExpression value="Delete"/>
															</binaryOperatorExpression>
															<unaryOperatorExpression operator="Not">
																<methodInvokeExpression methodName="PermissionGranted">
																	<target>
																		<variableReferenceExpression name="acl"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Controller">
																			<typeReferenceExpression type="PermissionKind"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Controller">
																			<argumentReferenceExpression name="args"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="delete"/>
																	</parameters>
																</methodInvokeExpression>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="allow"/>
															<primitiveExpression value="false"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<variableReferenceExpression name="allow"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="Exception">
												<parameters>
													<stringFormatExpression format="Access Denied: {{0}} does not allow {{1}}.">
														<propertyReferenceExpression name="Controller">
															<argumentReferenceExpression name="args"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="CommandName">
															<argumentReferenceExpression name="args"/>
														</propertyReferenceExpression>
													</stringFormatExpression>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="CommandName">
													<variableReferenceExpression name="args"/>
												</propertyReferenceExpression>
												<primitiveExpression value="Insert"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="CommandName">
													<variableReferenceExpression name="args"/>
												</propertyReferenceExpression>
												<primitiveExpression value="Update"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="UpdateGeoFields"/>
									</trueStatements>
								</conditionStatement>
								<xsl:if test="$PageImplementation='html'">
									<methodInvokeExpression methodName="BeforeAction">
										<target>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="ApplicationServices"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<argumentReferenceExpression name="args"/>
											<argumentReferenceExpression name="result"/>
										</parameters>
									</methodInvokeExpression>
								</xsl:if>
								<methodInvokeExpression methodName="BeforeSqlAction">
									<target>
										<baseReferenceExpression/>
									</target>
									<parameters>
										<argumentReferenceExpression name="args"/>
										<argumentReferenceExpression name="result"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method IsSystemController(string)  -->
						<memberMethod returnType="System.Boolean" name="IsSystemController">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<statements>
								<methodReturnStatement>
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
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- enum PermissionKind -->
				<typeDeclaration isEnum="true" name="PermissionKind">
					<members>
						<memberField name="Controller">
							<attributes public="true"/>
						</memberField>
						<memberField name="Page">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- class AccessControlPermission -->
				<typeDeclaration name="AccessControlPermission">
					<members>
						<!-- property FullName -->
						<memberProperty type="System.String" name="FullName">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ObjectName -->
						<memberProperty type="System.String" name="ObjectName">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ParameterName -->
						<memberProperty type="System.String" name="ParameterName">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Type -->
						<memberProperty type="System.String" name="Type">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Text -->
						<memberProperty type="System.String" name="Text">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Descrption -->
						<memberProperty type="System.String" name="Description">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Allow -->
						<memberProperty type="System.String" name="Allow">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Deny -->
						<memberProperty type="System.String" name="Deny">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- method IsMatch -->
						<memberMethod returnType="System.Boolean" name="IsMatch">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanOr">
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="ObjectName"/>
											<primitiveExpression value="_any"/>
										</binaryOperatorExpression>
										<methodInvokeExpression methodName="Equals">
											<target>
												<propertyReferenceExpression name="ObjectName"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="controller"/>
												<propertyReferenceExpression name="CurrentCultureIgnoreCase">
													<typeReferenceExpression type="StringComparison"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class AccessConrolPermissionDictionary -->
				<typeDeclaration name="AccessControlPermissionDictionary">
					<baseTypes>
						<typeReference type="SortedDictionary">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="AccessControlPermission"/>
							</typeArguments>
						</typeReference>
					</baseTypes>
				</typeDeclaration>
				<!-- class AccessControlList -->
				<typeDeclaration name="AccessControlList">
					<members>
						<!-- field DefaultCacheDuration -->
						<memberField type="System.Int32" name="DefaultCacheDuration">
							<comment><![CDATA[ACL cache duration expressed in seconds.]]></comment>
							<attributes public="true" static="true"/>
							<init>
								<primitiveExpression value="10"/>
							</init>
						</memberField>
						<!-- property Grants -->
						<memberProperty type="SortedDictionary" name="Grants">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Permissions -->
						<memberProperty type="AccessControlPermissionDictionary" name="Permissions">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Groups -->
						<memberProperty type="AccessControlPermissionDictionary" name="Groups">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Alterations -->
						<memberProperty type="AccessControlPermissionDictionary" name="Alterations">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property AccessRules -->
						<memberProperty type="AccessControlPermissionDictionary" name="AccessRules">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- constructor() -->
						<constructor>
							<attributes public="true"/>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="Grants"/>
									<objectCreateExpression type="SortedDictionary">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="System.String"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Permissions"/>
									<objectCreateExpression type="AccessControlPermissionDictionary"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Groups"/>
									<objectCreateExpression type="AccessControlPermissionDictionary"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Alterations"/>
									<objectCreateExpression type="AccessControlPermissionDictionary"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="AccessRules"/>
									<objectCreateExpression type="AccessControlPermissionDictionary"/>
								</assignStatement>
							</statements>
						</constructor>
						<!-- property Enabled -->
						<memberProperty type="System.Boolean" name="Enabled">
							<attributes public="true"/>
						</memberProperty>
						<!-- property CacheDuration -->
						<memberField type="Nullable" name="cacheDuration">
							<typeArguments>
								<typeReference type="System.Int32"/>
							</typeArguments>
						</memberField>
						<memberProperty type="System.Int32" name="CacheDuration">
							<attributes public="true"/>
							<getStatements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="HasValue">
											<fieldReferenceExpression name="cacheDuration"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Value">
												<fieldReferenceExpression name="cacheDuration"/>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<propertyReferenceExpression name="DefaultCacheDuration"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Current -->
						<memberProperty type="AccessControlList" name="Current">
							<attributes public="true" static="true"/>
							<getStatements>
								<variableDeclarationStatement name="acl">
									<init>
										<castExpression targetType="AccessControlList">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Items">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="app_ACL"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="acl"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="acl"/>
											<castExpression targetType="AccessControlList">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Cache">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="app_ACL"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="acl"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="acl"/>
													<objectCreateExpression type="AccessControlList"/>
												</assignStatement>
												<methodInvokeExpression methodName="Initialize">
													<target>
														<variableReferenceExpression name="acl"/>
													</target>
												</methodInvokeExpression>
												<comment>cache the ACL</comment>
												<methodInvokeExpression methodName="Add">
													<target>
														<propertyReferenceExpression name="Cache">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="app_ACL"/>
														<variableReferenceExpression name="acl"/>
														<primitiveExpression value="null"/>
														<methodInvokeExpression methodName="AddSeconds">
															<target>
																<propertyReferenceExpression name="Now">
																	<typeReferenceExpression type="DateTime"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<propertyReferenceExpression name="CacheDuration">
																	<variableReferenceExpression name="acl"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
														<propertyReferenceExpression name="NoSlidingExpiration">
															<typeReferenceExpression type="Cache"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="Normal">
															<variableReferenceExpression name="CacheItemPriority"/>
														</propertyReferenceExpression>
														<primitiveExpression value="null"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
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
													<primitiveExpression value="app_ACL"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="acl"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="acl"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property FullName -->
						<memberProperty type="System.String" name="FullName">
							<attributes public="true"/>
							<getStatements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="MapPath">
										<target>
											<propertyReferenceExpression name="Server">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<primitiveExpression value="~/acl.json"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method Initialize() -->
						<memberMethod name="Initialize">
							<attributes family="true"/>
							<statements>
								<xsl:if test="$IsUnlimited='true'">
									<comment>read JSON definition from the file system</comment>
									<variableDeclarationStatement type="JObject" name="json">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="IsSiteContentEnabled">
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</propertyReferenceExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="access">
												<init>
													<methodInvokeExpression methodName="GrantFullAccess">
														<target>
															<typeReferenceExpression type="Controller"/>
														</target>
														<parameters>
															<primitiveExpression value="*"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<tryStatement>
												<statements>
													<variableDeclarationStatement name="userDefinedACL">
														<init>
															<methodInvokeExpression methodName="ReadSiteContent">
																<target>
																	<propertyReferenceExpression name="Current">
																		<typeReferenceExpression type="ApplicationServices"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="sys/acl.json"/>
																</parameters>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="IdentityInequality">
																<variableReferenceExpression name="userDefinedACL"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<tryStatement>
																<statements>
																	<assignStatement>
																		<variableReferenceExpression name="json"/>
																		<methodInvokeExpression methodName="Parse">
																			<target>
																				<typeReferenceExpression type="JObject"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Text">
																					<variableReferenceExpression name="userDefinedACL"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																</statements>
																<catch exceptionType="Exception">
																	<comment>do nothing</comment>
																</catch>
															</tryStatement>
														</trueStatements>
													</conditionStatement>
												</statements>
												<finally>
													<methodInvokeExpression methodName="RevokeFullAccess">
														<target>
															<typeReferenceExpression type="Controller"/>
														</target>
														<parameters>
															<variableReferenceExpression name="access"/>
														</parameters>
													</methodInvokeExpression>
												</finally>
											</tryStatement>
										</trueStatements>
									</conditionStatement>
									<comment>read application-level ACL if there is no user-defined ACL in CMS</comment>
									<variableDeclarationStatement name="preventAccidentalDisabling">
										<init>
											<primitiveExpression value="false"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="json"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="Exists">
														<target>
															<typeReferenceExpression type="File"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="FullName"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<tryStatement>
														<statements>
															<assignStatement>
																<variableReferenceExpression name="json"/>
																<methodInvokeExpression methodName="Parse">
																	<target>
																		<typeReferenceExpression type="JObject"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="ReadAllText">
																			<target>
																				<typeReferenceExpression type="File"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="FullName"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</assignStatement>
														</statements>
														<catch exceptionType="Exception">
															<assignStatement>
																<variableReferenceExpression name="json"/>
																<objectCreateExpression type="JObject"/>
															</assignStatement>
															<comment>JSON is broken - force the ACL mode anyway to call for Admin attention</comment>
															<assignStatement>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="json"/>
																	</target>
																	<indices>
																		<primitiveExpression value="enable"/>
																	</indices>
																</arrayIndexerExpression>
																<primitiveExpression value="true"/>
															</assignStatement>
														</catch>
													</tryStatement>
												</trueStatements>
												<falseStatements>
													<assignStatement>
														<variableReferenceExpression name="json"/>
														<objectCreateExpression type="JObject"/>
													</assignStatement>
												</falseStatements>
											</conditionStatement>
										</trueStatements>
										<falseStatements>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="Exists">
														<target>
															<typeReferenceExpression type="File"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="FullName"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="preventAccidentalDisabling"/>
														<primitiveExpression value="true"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</falseStatements>
									</conditionStatement>
									<comment>initialize Access Control List</comment>
									<variableDeclarationStatement name="enabledFlag">
										<init>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="json"/>
												</target>
												<indices>
													<primitiveExpression value="enabled"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="enabledFlag"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="Enabled"/>
												<binaryOperatorExpression operator="ValueEquality">
													<castExpression targetType="Nullable">
														<typeArguments>
															<typeReference type="System.Boolean"/>
														</typeArguments>
														<variableReferenceExpression name="enabledFlag"/>
													</castExpression>
													<primitiveExpression value="true"/>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<comment>prevent accidental disabling of application-level ACL by user-defined ACL from CMS</comment>
									<conditionStatement>
										<condition>
											<variableReferenceExpression name="preventAccidentalDisabling"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="Enabled"/>
												<primitiveExpression value="true"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<fieldReferenceExpression name="cacheDuration"/>
										<castExpression targetType="Nullable">
											<typeArguments>
												<typeReference type="System.Int32"/>
											</typeArguments>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="json"/>
												</target>
												<indices>
													<primitiveExpression value="cacheDuration"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</assignStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="Enabled"/>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="InitializePermissions"/>
											<methodInvokeExpression methodName="InitializeGrants">
												<parameters>
													<variableReferenceExpression name="json"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- method InitializeGrants(JObject) -->
						<memberMethod name="InitializeGrants">
							<attributes family="true"/>
							<parameters>
								<parameter type="JObject" name="json"/>
							</parameters>
							<statements>
								<xsl:if test="$IsUnlimited='true'">
									<variableDeclarationStatement name="deny">
										<init>
											<objectCreateExpression type="SortedDictionary">
												<typeArguments>
													<typeReference type="System.String"/>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="permissions">
										<init>
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="json"/>
												</target>
												<indices>
													<primitiveExpression value="permissions"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="permissions"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<foreachStatement>
												<variable type="JProperty" name="permission" var="false"/>
												<target>
													<variableReferenceExpression name="permissions"/>
												</target>
												<statements>
													<variableDeclarationStatement name="permissionDefinition">
														<init>
															<methodInvokeExpression methodName="GetValue">
																<target>
																	<castExpression targetType="JObject">
																		<variableReferenceExpression name="permissions"/>
																	</castExpression>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="permission"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="InvariantCultureIgnoreCase">
																		<typeReferenceExpression type="StringComparison"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="IdentityInequality">
																<variableReferenceExpression name="permissionDefinition"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<variableDeclarationStatement name="roles">
																<init>
																	<convertExpression to="String">
																		<variableReferenceExpression name="permissionDefinition"/>
																	</convertExpression>
																</init>
															</variableDeclarationStatement>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<variableReferenceExpression name="roles"/>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<variableReferenceExpression name="roles"/>
																		<methodInvokeExpression methodName="Replace">
																			<target>
																				<typeReferenceExpression type="Regex"/>
																			</target>
																			<parameters>
																				<methodInvokeExpression methodName="Trim">
																					<target>
																						<variableReferenceExpression name="roles"/>
																					</target>
																				</methodInvokeExpression>
																				<primitiveExpression value="\s+"/>
																				<primitiveExpression value=","/>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																	<methodInvokeExpression methodName="EnumeratePermissions">
																		<parameters>
																			<propertyReferenceExpression name="Name">
																				<variableReferenceExpression name="permission"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="roles"/>
																			<variableReferenceExpression name="deny"/>
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
									<foreachStatement>
										<variable name="name"/>
										<target>
											<propertyReferenceExpression name="Keys">
												<variableReferenceExpression name="deny"/>
											</propertyReferenceExpression>
										</target>
										<statements>
											<methodInvokeExpression methodName="Remove">
												<target>
													<propertyReferenceExpression name="Grants"/>
												</target>
												<parameters>
													<variableReferenceExpression name="name"/>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</foreachStatement>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- method EnumeratePermissions(string, string, SortedDictionary<string, string>) -->
						<memberMethod name="EnumeratePermissions">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="permission"/>
								<parameter type="System.String" name="roles"/>
								<parameter type="SortedDictionary" name="deny">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="System.String"/>
									</typeArguments>
								</parameter>
							</parameters>
							<statements>
								<xsl:if test="$IsUnlimited='true'">
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="StartsWith">
												<target>
													<argumentReferenceExpression name="permission"/>
												</target>
												<parameters>
													<primitiveExpression value="group."/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="AccessControlPermission" name="groupPermission">
												<init>
													<primitiveExpression value="null"/>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="TryGetValue">
														<target>
															<propertyReferenceExpression name="Groups"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="permission"/>
															<directionExpression direction="Out">
																<variableReferenceExpression name="groupPermission"/>
															</directionExpression>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<comment>prevent duplicate and recursive group references</comment>
													<methodInvokeExpression methodName="Remove">
														<target>
															<propertyReferenceExpression name="Groups"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="permission"/>
														</parameters>
													</methodInvokeExpression>
													<conditionStatement>
														<condition>
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<propertyReferenceExpression name="Allow">
																	<variableReferenceExpression name="groupPermission"/>
																</propertyReferenceExpression>
															</unaryOperatorExpression>
														</condition>
														<trueStatements>
															<foreachStatement>
																<variable name="name"/>
																<target>
																	<methodInvokeExpression methodName="Split">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Allow">
																				<variableReferenceExpression name="groupPermission"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="\s+"/>
																		</parameters>
																	</methodInvokeExpression>
																</target>
																<statements>
																	<methodInvokeExpression methodName="EnumeratePermissions">
																		<parameters>
																			<variableReferenceExpression name="name"/>
																			<argumentReferenceExpression name="roles"/>
																			<argumentReferenceExpression name="deny"/>
																		</parameters>
																	</methodInvokeExpression>
																</statements>
															</foreachStatement>
														</trueStatements>
													</conditionStatement>
													<comment>only non-group permission can be denied</comment>
													<conditionStatement>
														<condition>
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<propertyReferenceExpression name="Deny">
																	<variableReferenceExpression name="groupPermission"/>
																</propertyReferenceExpression>
															</unaryOperatorExpression>
														</condition>
														<trueStatements>
															<foreachStatement>
																<variable name="name"/>
																<target>
																	<methodInvokeExpression methodName="Split">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Deny">
																				<variableReferenceExpression name="groupPermission"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="\s+"/>
																		</parameters>
																	</methodInvokeExpression>
																</target>
																<statements>
																	<assignStatement>
																		<arrayIndexerExpression>
																			<target>
																				<argumentReferenceExpression name="deny"/>
																			</target>
																			<indices>
																				<methodInvokeExpression methodName="ToLower">
																					<target>
																						<variableReferenceExpression name="name"/>
																					</target>
																				</methodInvokeExpression>
																			</indices>
																		</arrayIndexerExpression>
																		<variableReferenceExpression name="name"/>
																	</assignStatement>
																</statements>
															</foreachStatement>
														</trueStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
										<falseStatements>
											<assignStatement>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Grants"/>
													</target>
													<indices>
														<methodInvokeExpression methodName="ToLower">
															<target>
																<argumentReferenceExpression name="permission"/>
															</target>
														</methodInvokeExpression>
													</indices>
												</arrayIndexerExpression>
												<argumentReferenceExpression name="roles"/>
											</assignStatement>
										</falseStatements>
									</conditionStatement>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- method InitializePermissions() -->
						<memberMethod name="InitializePermissions">
							<attributes family="true"/>
							<statements>
								<xsl:if test="$IsUnlimited='true'">
									<variableDeclarationStatement name="files">
										<init>
											<objectCreateExpression type="SortedDictionary">
												<typeArguments>
													<typeReference type="System.String"/>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement name="permissionsFolderPath">
										<init>
											<methodInvokeExpression methodName="MapPath">
												<target>
													<propertyReferenceExpression name="Server">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<primitiveExpression value="~/permissions"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="Exists">
												<target>
													<typeReferenceExpression type="Directory"/>
												</target>
												<parameters>
													<variableReferenceExpression name="permissionsFolderPath"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<foreachStatement>
												<variable name="fileName"/>
												<target>
													<methodInvokeExpression methodName="GetFiles">
														<target>
															<typeReferenceExpression type="Directory"/>
														</target>
														<parameters>
															<variableReferenceExpression name="permissionsFolderPath"/>
															<primitiveExpression value="*.json"/>
														</parameters>
													</methodInvokeExpression>
												</target>
												<statements>
													<assignStatement>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="files"/>
															</target>
															<indices>
																<methodInvokeExpression methodName="GetFileName">
																	<target>
																		<typeReferenceExpression type="Path"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="fileName"/>
																	</parameters>
																</methodInvokeExpression>
															</indices>
														</arrayIndexerExpression>
														<methodInvokeExpression methodName="ReadAllText">
															<target>
																<typeReferenceExpression type="File"/>
															</target>
															<parameters>
																<variableReferenceExpression name="fileName"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
												</statements>
											</foreachStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="IsSiteContentEnabled">
												<typeReferenceExpression type="ApplicationServices"/>
											</propertyReferenceExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement name="access">
												<init>
													<methodInvokeExpression methodName="GrantFullAccess">
														<target>
															<typeReferenceExpression type="Controller"/>
														</target>
														<parameters>
															<primitiveExpression value="*"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<tryStatement>
												<statements>
													<variableDeclarationStatement name="siteFiles">
														<init>
															<methodInvokeExpression methodName="ReadSiteContent">
																<target>
																	<propertyReferenceExpression name="Current">
																		<typeReferenceExpression type="ApplicationServices"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="sys/permissions"/>
																	<primitiveExpression value="*.json"/>
																</parameters>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<foreachStatement>
														<variable name="f"/>
														<target>
															<variableReferenceExpression name="siteFiles"/>
														</target>
														<statements>
															<assignStatement>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="files"/>
																	</target>
																	<indices>
																		<propertyReferenceExpression name="PhysicalName">
																			<variableReferenceExpression name="f"/>
																		</propertyReferenceExpression>
																	</indices>
																</arrayIndexerExpression>
																<propertyReferenceExpression name="Text">
																	<variableReferenceExpression name="f"/>
																</propertyReferenceExpression>
															</assignStatement>
														</statements>
													</foreachStatement>
												</statements>
												<finally>
													<methodInvokeExpression methodName="RevokeFullAccess">
														<target>
															<typeReferenceExpression type="Controller"/>
														</target>
														<parameters>
															<variableReferenceExpression name="access"/>
														</parameters>
													</methodInvokeExpression>
												</finally>
											</tryStatement>
										</trueStatements>
									</conditionStatement>
									<foreachStatement>
										<variable name="fileName"/>
										<target>
											<propertyReferenceExpression name="Keys">
												<variableReferenceExpression name="files"/>
											</propertyReferenceExpression>
										</target>
										<statements>
											<variableDeclarationStatement name="permissionInfo">
												<init>
													<methodInvokeExpression methodName="Match">
														<target>
															<typeReferenceExpression type="Regex"/>
														</target>
														<parameters>
															<methodInvokeExpression methodName="GetFileNameWithoutExtension">
																<target>
																	<typeReferenceExpression type="Path"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="fileName"/>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[^(?'Type'controller|access|group)\.(?'ObjectName'\w+)(\.(?'Param1'.+?))?(\.(?'Param2'.+?))?$]]></xsl:attribute>
															</primitiveExpression>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<propertyReferenceExpression name="Success">
														<variableReferenceExpression name="permissionInfo"/>
													</propertyReferenceExpression>
												</condition>
												<trueStatements>
													<tryStatement>
														<statements>
															<variableDeclarationStatement name="json">
																<init>
																	<methodInvokeExpression methodName="Parse">
																		<target>
																			<typeReferenceExpression type="JObject"/>
																		</target>
																		<parameters>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="files"/>
																				</target>
																				<indices>
																					<variableReferenceExpression name="fileName"/>
																				</indices>
																			</arrayIndexerExpression>
																		</parameters>
																	</methodInvokeExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement name="type">
																<init>
																	<propertyReferenceExpression name="Value">
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups">
																					<variableReferenceExpression name="permissionInfo"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="Type"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement name="objectName">
																<init>
																	<propertyReferenceExpression name="Value">
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups">
																					<variableReferenceExpression name="permissionInfo"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="ObjectName"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement name="parameterName">
																<init>
																	<propertyReferenceExpression name="Value">
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups">
																					<variableReferenceExpression name="permissionInfo"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="Param1"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement name="name">
																<init>
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="permissionInfo"/>
																	</propertyReferenceExpression>
																</init>
															</variableDeclarationStatement>
															<comment>parse "allow"</comment>
															<variableDeclarationStatement name="allowDef">
																<init>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="json"/>
																		</target>
																		<indices>
																			<primitiveExpression value="allow"/>
																		</indices>
																	</arrayIndexerExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement name="allow">
																<init>
																	<stringEmptyExpression/>
																</init>
															</variableDeclarationStatement>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="IsTypeOf">
																		<variableReferenceExpression name="allowDef"/>
																		<typeReferenceExpression type="JArray"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<variableReferenceExpression name="allow"/>
																		<methodInvokeExpression methodName="Join">
																			<target>
																				<typeReferenceExpression type="System.String"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="&#10;"/>
																				<castExpression targetType="JArray">
																					<variableReferenceExpression name="allowDef"/>
																				</castExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																</trueStatements>
																<falseStatements>
																	<assignStatement>
																		<variableReferenceExpression name="allow"/>
																		<convertExpression to="String">
																			<variableReferenceExpression name="allowDef"/>
																		</convertExpression>
																	</assignStatement>
																</falseStatements>
															</conditionStatement>
															<comment>parse "deny"</comment>
															<variableDeclarationStatement name="denyDef">
																<init>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="json"/>
																		</target>
																		<indices>
																			<primitiveExpression value="deny"/>
																		</indices>
																	</arrayIndexerExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement name="deny">
																<init>
																	<stringEmptyExpression/>
																</init>
															</variableDeclarationStatement>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="IsTypeOf">
																		<variableReferenceExpression name="denyDef"/>
																		<typeReferenceExpression type="JArray"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<variableReferenceExpression name="deny"/>
																		<methodInvokeExpression methodName="Join">
																			<target>
																				<typeReferenceExpression type="System.String"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="&#10;"/>
																				<castExpression targetType="JArray">
																					<variableReferenceExpression name="denyDef"/>
																				</castExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																</trueStatements>
																<falseStatements>
																	<assignStatement>
																		<variableReferenceExpression name="deny"/>
																		<convertExpression to="String">
																			<variableReferenceExpression name="denyDef"/>
																		</convertExpression>
																	</assignStatement>
																</falseStatements>
															</conditionStatement>
															<comment>add permission to the list</comment>
															<variableDeclarationStatement name="permission">
																<init>
																	<objectCreateExpression type="AccessControlPermission"/>
																</init>
															</variableDeclarationStatement>
															<assignStatement>
																<propertyReferenceExpression name="FullName">
																	<variableReferenceExpression name="permission"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="name"/>
															</assignStatement>
															<assignStatement>
																<propertyReferenceExpression name="ObjectName">
																	<variableReferenceExpression name="permission"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="objectName"/>
															</assignStatement>
															<assignStatement>
																<propertyReferenceExpression name="ParameterName">
																	<variableReferenceExpression name="permission"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="parameterName"/>
															</assignStatement>
															<assignStatement>
																<propertyReferenceExpression name="Type">
																	<variableReferenceExpression name="permission"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="type"/>
															</assignStatement>
															<assignStatement>
																<propertyReferenceExpression name="Text">
																	<variableReferenceExpression name="permission"/>
																</propertyReferenceExpression>
																<castExpression targetType="System.String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="json"/>
																		</target>
																		<indices>
																			<primitiveExpression value="text"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
															</assignStatement>
															<assignStatement>
																<propertyReferenceExpression name="Description">
																	<variableReferenceExpression name="permission"/>
																</propertyReferenceExpression>
																<castExpression targetType="System.String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="json"/>
																		</target>
																		<indices>
																			<primitiveExpression value="description"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
															</assignStatement>
															<assignStatement>
																<propertyReferenceExpression name="Allow">
																	<variableReferenceExpression name="permission"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="allow"/>
															</assignStatement>
															<assignStatement>
																<propertyReferenceExpression name="Deny">
																	<variableReferenceExpression name="permission"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="deny"/>
															</assignStatement>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="ValueEquality">
																		<variableReferenceExpression name="type"/>
																		<primitiveExpression value="group"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="name"/>
																			</indices>
																		</arrayIndexerExpression>
																		<variableReferenceExpression name="permission"/>
																	</assignStatement>
																</trueStatements>
																<falseStatements>
																	<assignStatement>
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Permissions"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="name"/>
																			</indices>
																		</arrayIndexerExpression>
																		<variableReferenceExpression name="permission"/>
																	</assignStatement>
																	<conditionStatement>
																		<condition>
																			<binaryOperatorExpression operator="ValueEquality">
																				<variableReferenceExpression name="type"/>
																				<primitiveExpression value="access"/>
																			</binaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<assignStatement>
																				<arrayIndexerExpression>
																					<target>
																						<propertyReferenceExpression name="AccessRules"/>
																					</target>
																					<indices>
																						<variableReferenceExpression name="name"/>
																					</indices>
																				</arrayIndexerExpression>
																				<variableReferenceExpression name="permission"/>
																			</assignStatement>
																		</trueStatements>
																		<falseStatements>
																			<conditionStatement>
																				<condition>
																					<binaryOperatorExpression operator="ValueEquality">
																						<variableReferenceExpression name="type"/>
																						<primitiveExpression value="controller"/>
																					</binaryOperatorExpression>
																				</condition>
																				<trueStatements>
																					<assignStatement>
																						<arrayIndexerExpression>
																							<target>
																								<propertyReferenceExpression name="Alterations"/>
																							</target>
																							<indices>
																								<variableReferenceExpression name="name"/>
																							</indices>
																						</arrayIndexerExpression>
																						<variableReferenceExpression name="permission"/>
																					</assignStatement>
																				</trueStatements>
																			</conditionStatement>
																		</falseStatements>
																	</conditionStatement>
																</falseStatements>
															</conditionStatement>
														</statements>
														<catch exceptionType="Exception"></catch>
													</tryStatement>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- method PermissionGrnated(PermissionKind, string) -->
						<memberMethod returnType="System.Boolean" name="PermissionGranted">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="PermissionKind" name="kind"/>
								<parameter type="System.String" name="objectName"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="PermissionGranted">
										<parameters>
											<argumentReferenceExpression name="kind"/>
											<argumentReferenceExpression name="objectName"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method PermissionGrnated(PermissionKind, string, string) -->
						<memberMethod returnType="System.Boolean" name="PermissionGranted">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="PermissionKind" name="kind"/>
								<parameter type="System.String" name="objectName"/>
								<parameter type="System.String" name="permission"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="granted">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Enabled"/>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="granted"/>
											<primitiveExpression value="false"/>
										</assignStatement>
										<variableDeclarationStatement name="test">
											<init>
												<methodInvokeExpression methodName="ToLower">
													<target>
														<methodInvokeExpression methodName="ToString">
															<target>
																<argumentReferenceExpression name="kind"/>
															</target>
														</methodInvokeExpression>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<argumentReferenceExpression name="objectName"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="test"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="test"/>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="."/>
															<argumentReferenceExpression name="objectName"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="permission"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="test"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="test"/>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="."/>
															<argumentReferenceExpression name="permission"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="PermissionGranted">
													<parameters>
														<variableReferenceExpression name="test"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="granted"/>
													<primitiveExpression value="true"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="granted"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method PermissionGranted(string fullPermissionName) -->
						<memberMethod returnType="System.Boolean" name="PermissionGranted">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="fullPermissionName"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="granted">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<xsl:if test="$IsUnlimited='true'">
									<variableDeclarationStatement name="roles">
										<init>
											<stringEmptyExpression/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<propertyReferenceExpression name="Grants"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="ToLower">
														<target>
															<argumentReferenceExpression name="fullPermissionName"/>
														</target>
													</methodInvokeExpression>
													<directionExpression direction="Out">
														<variableReferenceExpression name="roles"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="roles"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="BooleanOr">
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="ValueEquality">
																		<variableReferenceExpression name="roles"/>
																		<primitiveExpression value="*"/>
																	</binaryOperatorExpression>
																	<propertyReferenceExpression name="IsAuthenticated">
																		<propertyReferenceExpression name="Identity">
																			<propertyReferenceExpression name="User">
																				<propertyReferenceExpression name="Current">
																					<typeReferenceExpression type="HttpContext"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
																<binaryOperatorExpression operator="BooleanOr">
																	<binaryOperatorExpression operator="ValueEquality">
																		<variableReferenceExpression name="roles"/>
																		<primitiveExpression value="?"/>
																	</binaryOperatorExpression>
																	<methodInvokeExpression methodName="UserIsInRole">
																		<target>
																			<typeReferenceExpression type="DataControllerBase"/>
																		</target>
																		<parameters>
																			<argumentReferenceExpression name="roles"/>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="granted"/>
																<primitiveExpression value="true"/>
															</assignStatement>
														</trueStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<methodReturnStatement>
									<variableReferenceExpression name="granted"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>

</xsl:stylesheet>
