<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsPremium"/>
	<xsl:param name="IsUnlimited"/>
	<xsl:param name="Auditing" select="a:project/a:features/a:ease/a:auditing"/>
	<!-- $Mobile parameter must be set to "false" for DNN and SharePoint -->
	<xsl:param name="Mobile" select="'true'"/>
	<xsl:variable name="MembershipEnabled" select="a:project/a:membership/@enabled"/>
	<xsl:variable name="CustomSecurity" select="a:project/a:membership/@customSecurity"/>
	<xsl:variable name="ActiveDirectory" select="a:project/a:membership/@activeDirectory"/>
	<xsl:variable name="Namespace" select="a:project/a:namespace"/>
	<xsl:variable name="PageImplementation" select="a:project/@pageImplementation"/>

	<xsl:variable name="EnableJsonControllers" select="'false'"/>

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
				<xsl:if test="$IsUnlimited='true'">
					<namespaceImport name="System.Security.Cryptography"/>
				</xsl:if>
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
				<namespaceImport name="Newtonsoft.Json"/>
				<namespaceImport name="{$Namespace}.Handlers"/>
				<namespaceImport name="{$Namespace}.Services"/>
			</imports>
			<types>
				<!-- class Controller -->
				<typeDeclaration name="Controller" isPartial="true">
					<baseTypes>
						<typeReference type="DataControllerBase"/>
					</baseTypes>
					<members>
						<!-- method GrantFullAccess(params System.String[] controllers) -->
						<memberMethod returnType="System.String[]" name="GrantFullAccess">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="params System.String[]" name="controllers"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="FullAccess">
									<parameters>
										<primitiveExpression value="true"/>
										<argumentReferenceExpression name="controllers"/>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<argumentReferenceExpression name="controllers"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method RevokeFullAccess(params System.String[] controllers) -->
						<memberMethod name="RevokeFullAccess">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="params System.String[]" name="controllers"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="FullAccess">
									<parameters>
										<primitiveExpression value="false"/>
										<argumentReferenceExpression name="controllers"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class DataControllerBase -->
				<typeDeclaration name="DataControllerBase" isPartial="true">
					<baseTypes>
						<typeReference type="System.Object"/>
						<typeReference type="IDataController"/>
						<typeReference type="IAutoCompleteManager"/>
						<typeReference type="IDataEngine"/>
						<typeReference type="IBusinessObject"/>
					</baseTypes>
					<members>
						<memberField type="System.Int32" name="MaximumDistinctValues">
							<attributes public="true" const="true"/>
							<init>
								<primitiveExpression value="200"/>
							</init>
						</memberField>
						<!-- constructor DataControllerBase() -->
						<constructor>
							<attributes public="true"/>
							<statements>
								<methodInvokeExpression methodName="Initialize"/>
							</statements>
						</constructor>
						<!-- method Initialize() -->
						<memberMethod name="Initialize">
							<attributes family="true"/>
							<statements>
								<methodInvokeExpression methodName="Initialize">
									<target>
										<typeReferenceExpression type="CultureManager"/>
									</target>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- type constructor DataControllerBase () -->
						<typeConstructor>
							<statements>
								<comment>initialize type map</comment>
								<assignStatement>
									<fieldReferenceExpression name="typeMap"/>
									<objectCreateExpression type="SortedDictionary">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="Type"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="AnsiString"/>
										<typeofExpression type="System.String"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Binary"/>
										<typeofExpression type="System.Byte[]"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Byte[]"/>
										<typeofExpression type="System.Byte[]"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Byte"/>
										<typeofExpression type="System.Byte"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Boolean"/>
										<typeofExpression type="System.Boolean"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Currency"/>
										<typeofExpression type="System.Decimal"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Date"/>
										<typeofExpression type="DateTime"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="DateTime"/>
										<typeofExpression type="DateTime"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Decimal"/>
										<typeofExpression type="System.Decimal"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Double"/>
										<typeofExpression type="System.Double"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Guid"/>
										<typeofExpression type="Guid"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Int16"/>
										<typeofExpression type="System.Int16"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Int32"/>
										<typeofExpression type="System.Int32"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Int64"/>
										<typeofExpression type="System.Int64"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Object"/>
										<typeofExpression type="System.Object"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="SByte"/>
										<typeofExpression type="System.SByte"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Single"/>
										<typeofExpression type="System.Single"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="String"/>
										<typeofExpression type="System.String"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Time"/>
										<typeofExpression type="TimeSpan"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="TimeSpan"/>
										<typeofExpression type="DateTime"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="UInt16"/>
										<typeofExpression type="System.UInt16"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="UInt32"/>
										<typeofExpression type="System.UInt32"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="UInt64"/>
										<typeofExpression type="System.UInt64"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="VarNumeric"/>
										<typeofExpression type="System.Object"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="AnsiStringFixedLength"/>
										<typeofExpression type="System.String"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="StringFixedLength"/>
										<typeofExpression type="System.String"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Xml"/>
										<typeofExpression type="System.String"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="DateTime2"/>
										<typeofExpression type="DateTime"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="typeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="DateTimeOffset"/>
										<typeofExpression type="DateTimeOffset"/>
									</parameters>
								</methodInvokeExpression>
								<comment>initialize rowset type map</comment>
								<assignStatement>
									<fieldReferenceExpression name="rowsetTypeMap"/>
									<objectCreateExpression type="SortedDictionary">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="System.String"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="AnsiString"/>
										<primitiveExpression value="string"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Binary"/>
										<primitiveExpression value="bin.base64"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Byte"/>
										<primitiveExpression value="u1"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Boolean"/>
										<primitiveExpression value="boolean"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Currency"/>
										<primitiveExpression value="float"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Date"/>
										<primitiveExpression value="date"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="DateTime"/>
										<primitiveExpression value="dateTime"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Decimal"/>
										<primitiveExpression value="float"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Double"/>
										<primitiveExpression value="float"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Guid"/>
										<primitiveExpression value="uuid"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Int16"/>
										<primitiveExpression value="i2"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Int32"/>
										<primitiveExpression value="i4"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Int64"/>
										<primitiveExpression value="i8"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Object"/>
										<primitiveExpression value="string"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="SByte"/>
										<primitiveExpression value="i1"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Single"/>
										<primitiveExpression value="float"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="String"/>
										<primitiveExpression value="string"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Time"/>
										<primitiveExpression value="time"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="UInt16"/>
										<primitiveExpression value="u2"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="UInt32"/>
										<primitiveExpression value="u4"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="UIn64"/>
										<primitiveExpression value="u8"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="VarNumeric"/>
										<primitiveExpression value="float"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="AnsiStringFixedLength"/>
										<primitiveExpression value="string"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="StringFixedLength"/>
										<primitiveExpression value="string"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="Xml"/>
										<primitiveExpression value="string"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="DateTime2"/>
										<primitiveExpression value="dateTime"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="DateTimeOffset"/>
										<primitiveExpression value="dateTime.tz"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Add">
									<target>
										<fieldReferenceExpression name="rowsetTypeMap"/>
									</target>
									<parameters>
										<primitiveExpression value="TimeSpan"/>
										<primitiveExpression value="time"/>
									</parameters>
								</methodInvokeExpression>
								<comment>initialize the special converters</comment>
								<assignStatement>
									<propertyReferenceExpression name="SpecialConverters"/>
									<arrayCreateExpression>
										<createType type="SpecialConversionFunction"/>
										<sizeExpression>
											<propertyReferenceExpression name="Length">
												<propertyReferenceExpression name="SpecialConversionTypes"/>
											</propertyReferenceExpression>
										</sizeExpression>
									</arrayCreateExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="SpecialConverters"/>
										</target>
										<indices>
											<primitiveExpression value="0"/>
										</indices>
									</arrayIndexerExpression>
									<addressOfExpression>
										<methodReferenceExpression methodName="ConvertToGuid"/>
									</addressOfExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="SpecialConverters"/>
										</target>
										<indices>
											<primitiveExpression value="1"/>
										</indices>
									</arrayIndexerExpression>
									<addressOfExpression>
										<methodReferenceExpression methodName="ConvertToDateTimeOffset"/>
									</addressOfExpression>
								</assignStatement>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="SpecialConverters"/>
										</target>
										<indices>
											<primitiveExpression value="2"/>
										</indices>
									</arrayIndexerExpression>
									<addressOfExpression>
										<methodReferenceExpression methodName="ConvertToTimeSpan"/>
									</addressOfExpression>
								</assignStatement>
							</statements>
						</typeConstructor>
						<!-- method StringIsNull(string) -->
						<memberMethod returnType="System.Boolean" name="StringIsNull">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="s"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanOr">
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="s"/>
											<primitiveExpression value="null" convertTo="String"/>
										</binaryOperatorExpression>
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="s"/>
											<primitiveExpression value="%js%null"/>
										</binaryOperatorExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ConvertToType(Type, object) -->
						<typeDelegate type="System.Object" name="SpecialConversionFunction">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.Object" name="o"/>
							</parameters>
						</typeDelegate>
						<memberField type="Type[]" name="SpecialConversionTypes">
							<attributes public="true" static="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="Type"/>
									<initializers>
										<typeofExpression type="System.Guid"/>
										<typeofExpression type="System.DateTimeOffset"/>
										<typeofExpression type="System.TimeSpan"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<memberField type="SpecialConversionFunction[]" name="SpecialConverters">
							<attributes public="true" static="true"/>
						</memberField>
						<memberMethod returnType="System.Object" name="ConvertToGuid">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Object" name="o"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<objectCreateExpression type="Guid">
										<parameters>
											<methodInvokeExpression methodName="ToString">
												<target>
													<typeReferenceExpression type="Convert"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="o"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<memberMethod returnType="System.Object" name="ConvertToDateTimeOffset">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Object" name="o"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Parse">
										<target>
											<typeReferenceExpression type="System.DateTimeOffset"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="ToString">
												<target>
													<typeReferenceExpression type="Convert"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="o"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<memberMethod returnType="System.Object" name="ConvertToTimeSpan">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Object" name="o"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Parse">
										<target>
											<typeReferenceExpression type="System.TimeSpan"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="ToString">
												<target>
													<typeReferenceExpression type="Convert"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="o"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<memberMethod returnType="System.Object" name="ConvertToType">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="Type" name="targetType"/>
								<parameter type="System.Object" name="o"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsGenericType">
											<argumentReferenceExpression name="targetType"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="targetType"/>
											<propertyReferenceExpression name="PropertyType">
												<methodInvokeExpression methodName="GetProperty">
													<target>
														<argumentReferenceExpression name="targetType"/>
													</target>
													<parameters>
														<primitiveExpression value="Value"/>
													</parameters>
												</methodInvokeExpression>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="IdentityEquality">
												<argumentReferenceExpression name="o"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<methodInvokeExpression methodName="Equals">
												<target>
													<methodInvokeExpression methodName="GetType">
														<target>
															<argumentReferenceExpression name="o"/>
														</target>
													</methodInvokeExpression>
												</target>
												<parameters>
													<argumentReferenceExpression name="targetType"/>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<argumentReferenceExpression name="o"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
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
												<propertyReferenceExpression name="SpecialConversionTypes"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="i"/>
									</increment>
									<statements>
										<variableDeclarationStatement type="Type" name="t">
											<init>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="SpecialConversionTypes"/>
													</target>
													<indices>
														<variableReferenceExpression name="i"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="t"/>
													<argumentReferenceExpression name="targetType"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<delegateInvokeExpression>
														<target>
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="SpecialConverters"/>
																</target>
																<indices>
																	<variableReferenceExpression name="i"/>
																</indices>
															</arrayIndexerExpression>
														</target>
														<parameters>
															<argumentReferenceExpression name="o"/>
														</parameters>
													</delegateInvokeExpression>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</forStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IsTypeOf">
											<argumentReferenceExpression name="o"/>
											<typeReferenceExpression type="IConvertible"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="o"/>
											<methodInvokeExpression methodName="ChangeType">
												<target>
													<typeReferenceExpression type="Convert"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="o"/>
													<variableReferenceExpression name="targetType"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<methodInvokeExpression methodName="Equals">
														<target>
															<argumentReferenceExpression name="targetType"/>
														</target>
														<parameters>
															<typeofExpression type="System.String"/>
														</parameters>
													</methodInvokeExpression>
													<binaryOperatorExpression operator="IdentityInequality">
														<argumentReferenceExpression name="o"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<argumentReferenceExpression name="o"/>
													<methodInvokeExpression methodName="ToString">
														<target>
															<argumentReferenceExpression name="o"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="o"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ValueToString(object) -->
						<memberMethod returnType="System.String" name="ValueToString">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Object" name="o"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<argumentReferenceExpression name="o"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="IsTypeOf">
												<argumentReferenceExpression name="o"/>
												<typeReferenceExpression type="System.DateTime"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="o"/>
											<methodInvokeExpression methodName="ToString">
												<target>
													<castExpression targetType="DateTime">
														<argumentReferenceExpression name="o"/>
													</castExpression>
												</target>
												<parameters>
													<primitiveExpression value="yyyy-MM-ddTHH\:mm\:ss.fff"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="Add">
										<primitiveExpression value="%js%"/>
										<methodInvokeExpression methodName="SerializeObject">
											<target>
												<typeReferenceExpression type="JsonConvert"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="o"/>
											</parameters>
										</methodInvokeExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method StringToValue(string) -->
						<memberMethod returnType="System.Object" name="StringToValue">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="s"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="StringToValue">
										<parameters>
											<castExpression targetType="System.String">
												<primitiveExpression value="null"/>
											</castExpression>
											<argumentReferenceExpression name="s"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method StringToValue(DataField, string) -->
						<memberMethod returnType="System.Object" name="StringToValue">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="DataField" name="field"/>
								<parameter type="System.String" name="s"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="fieldType" var="false">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="field"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="fieldType"/>
											<propertyReferenceExpression name="Type">
												<argumentReferenceExpression name="field"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="StringToValue">
										<parameters>
											<variableReferenceExpression name="fieldType"/>
											<argumentReferenceExpression name="s"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property ISO8601DateStringMatcher-->
						<memberField type="Regex" name="ISO8601DateStringMatcher">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="Regex">
									<parameters>
										<primitiveExpression value="^\d{{4}}-\d{{2}}-\d{{2}}T\d{{2}}:\d{{2}}:\d{{2}}$"/>
									</parameters>
								</objectCreateExpression>
							</init>
						</memberField>
						<!-- method StringToValue(string, string) -->
						<memberMethod returnType="System.Object" name="StringToValue">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="fieldType"/>
								<parameter type="System.String" name="s"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<argumentReferenceExpression name="s"/>
											</unaryOperatorExpression>
											<methodInvokeExpression methodName="StartsWith">
												<target>
													<argumentReferenceExpression name="s"/>
												</target>
												<parameters>
													<primitiveExpression value="%js%"/>
												</parameters>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.Object" name="v">
											<init>
												<methodInvokeExpression methodName="DeserializeObject">
													<target>
														<typeReferenceExpression type="JsonConvert"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="Substring">
															<target>
																<argumentReferenceExpression name="s"/>
															</target>
															<parameters>
																<primitiveExpression value="4"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IsTypeOf">
														<variableReferenceExpression name="v"/>
														<typeReferenceExpression type="System.String"/>
													</binaryOperatorExpression>
													<methodInvokeExpression methodName="IsMatch">
														<target>
															<propertyReferenceExpression name="ISO8601DateStringMatcher"/>
														</target>
														<parameters>
															<castExpression targetType="System.String">
																<variableReferenceExpression name="v"/>
															</castExpression>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<methodInvokeExpression methodName="Parse">
														<target>
															<typeReferenceExpression type="System.DateTime"/>
														</target>
														<parameters>
															<castExpression targetType="System.String">
																<variableReferenceExpression name="v"/>
															</castExpression>
														</parameters>
													</methodInvokeExpression>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<unaryOperatorExpression operator="Not">
														<binaryOperatorExpression operator="IsTypeOf">
															<variableReferenceExpression name="v"/>
															<typeReferenceExpression type="System.String"/>
														</binaryOperatorExpression>
													</unaryOperatorExpression>
													<binaryOperatorExpression operator="BooleanOr">
														<binaryOperatorExpression operator="IdentityEquality">
															<argumentReferenceExpression name="fieldType"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="ValueEquality">
															<argumentReferenceExpression name="fieldType"/>
															<primitiveExpression value="String"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<variableReferenceExpression name="v"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<argumentReferenceExpression name="s"/>
											<castExpression targetType="System.String">
												<variableReferenceExpression name="v"/>
											</castExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="IsMatch">
													<target>
														<propertyReferenceExpression name="ISO8601DateStringMatcher"/>
													</target>
													<parameters>
														<variableReferenceExpression name="s"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<methodInvokeExpression methodName="Parse">
														<target>
															<typeReferenceExpression type="System.DateTime"/>
														</target>
														<parameters>
															<variableReferenceExpression name="s"/>
														</parameters>
													</methodInvokeExpression>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<argumentReferenceExpression name="fieldType"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ConvertFromString">
												<target>
													<methodInvokeExpression methodName="GetConverter">
														<target>
															<typeReferenceExpression type="TypeDescriptor"/>
														</target>
														<parameters>
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="TypeMap">
																		<typeReferenceExpression type="Controller"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<argumentReferenceExpression name="fieldType"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</methodInvokeExpression>
												</target>
												<parameters>
													<argumentReferenceExpression name="s"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="s"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ConvertObjectToValue(object) -->
						<memberField type="System.String[]" name="SpecialTypes">
							<attributes static="true" public="true"/>
							<init>
								<arrayCreateExpression>
									<createType type="System.String"/>
									<initializers>
										<primitiveExpression value="System.DateTimeOffset"/>
										<primitiveExpression value="System.TimeSpan"/>
										<primitiveExpression value="Microsoft.SqlServer.Types.SqlGeography"/>
										<primitiveExpression value="Microsoft.SqlServer.Types.SqlHierarchyId"/>
									</initializers>
								</arrayCreateExpression>
							</init>
						</memberField>
						<memberMethod returnType="System.Object" name="ConvertObjectToValue">
							<attributes static="true" public="true"/>
							<parameters>
								<parameter type="System.Object" name="o"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="Contains">
											<target>
												<propertyReferenceExpression name="SpecialTypes"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="FullName">
													<methodInvokeExpression methodName="GetType">
														<target>
															<argumentReferenceExpression name="o"/>
														</target>
													</methodInvokeExpression>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ToString">
												<target>
													<argumentReferenceExpression name="o"/>
												</target>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="o"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method EnsureJsonCompatibility(object) -->
						<memberMethod returnType="System.Object" name="EnsureJsonCompatibility">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Object" name="o"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<argumentReferenceExpression name="o"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IsTypeOf">
													<argumentReferenceExpression name="o"/>
													<typeReferenceExpression type="List">
														<typeArguments>
															<typeReference type="System.Object[]"/>
														</typeArguments>
													</typeReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable type="System.Object[]" name="values"/>
													<target>
														<castExpression targetType="List">
															<typeArguments>
																<typeReference type="System.Object[]"/>
															</typeArguments>
															<argumentReferenceExpression name="o"/>
														</castExpression>
													</target>
													<statements>
														<methodInvokeExpression methodName="EnsureJsonCompatibility">
															<parameters>
																<variableReferenceExpression name="values"/>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="IsTypeOf">
																<argumentReferenceExpression name="o"/>
																<typeReferenceExpression type="Array"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="IdentityEquality">
																<methodInvokeExpression methodName="GetElementType">
																	<target>
																		<methodInvokeExpression methodName="GetType">
																			<target>
																				<variableReferenceExpression name="o"/>
																			</target>
																		</methodInvokeExpression>
																	</target>
																</methodInvokeExpression>
																<typeofExpression type="System.Object"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.Object[]" name="row">
															<init>
																<castExpression targetType="System.Object[]">
																	<argumentReferenceExpression name="o"/>
																</castExpression>
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
																		<variableReferenceExpression name="row"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</test>
															<increment>
																<variableReferenceExpression name="i"/>
															</increment>
															<statements>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="row"/>
																		</target>
																		<indices>
																			<variableReferenceExpression name="i"/>
																		</indices>
																	</arrayIndexerExpression>
																	<methodInvokeExpression methodName="EnsureJsonCompatibility">
																		<parameters>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="row"/>
																				</target>
																				<indices>
																					<variableReferenceExpression name="i"/>
																				</indices>
																			</arrayIndexerExpression>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</statements>
														</forStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IsTypeOf">
																	<argumentReferenceExpression name="o"/>
																	<typeReferenceExpression type="DateTime"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="DateTime" name="d">
																	<init>
																		<castExpression targetType="DateTime">
																			<variableReferenceExpression name="o"/>
																		</castExpression>
																	</init>
																</variableDeclarationStatement>
																<methodReturnStatement>
																	<stringFormatExpression>
																		<xsl:attribute name="format"><![CDATA[{0:d4}-{1:d2}-{2:d2}T{3:d2}:{4:d2}:{5:d2}.{6:d3}]]></xsl:attribute>
																		<propertyReferenceExpression name="Year">
																			<variableReferenceExpression name="d"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Month">
																			<variableReferenceExpression name="d"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Day">
																			<variableReferenceExpression name="d"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Hour">
																			<variableReferenceExpression name="d"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Minute">
																			<variableReferenceExpression name="d"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Second">
																			<variableReferenceExpression name="d"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Millisecond">
																			<variableReferenceExpression name="d"/>
																		</propertyReferenceExpression>
																	</stringFormatExpression>
																</methodReturnStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="o"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateBusinessRules() -->
						<memberMethod returnType="BusinessRules" name="CreateBusinessRules">
							<attributes family="true" final="true"/>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Create">
										<target>
											<typeReferenceExpression type="BusinessRules"/>
										</target>
										<parameters>
											<fieldReferenceExpression name="config"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ApplyFieldFilter(ViewPage)-->
						<memberMethod name="ApplyFieldFilter">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<propertyReferenceExpression name="FieldFilter">
													<argumentReferenceExpression name="page"/>
												</propertyReferenceExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="GreaterThan">
												<propertyReferenceExpression name="Length">
													<propertyReferenceExpression name="FieldFilter">
														<argumentReferenceExpression name="page"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="List" name="newFields">
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
											<variable type="DataField" name="f"/>
											<target>
												<propertyReferenceExpression name="Fields">
													<argumentReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanOr">
															<propertyReferenceExpression name="IsPrimaryKey">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
															<methodInvokeExpression methodName="IncludeField">
																<target>
																	<variableReferenceExpression name="page"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="f"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="newFields"/>
															</target>
															<parameters>
																<variableReferenceExpression name="f"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<methodInvokeExpression methodName="Clear">
											<target>
												<propertyReferenceExpression name="Fields">
													<variableReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AddRange">
											<target>
												<propertyReferenceExpression name="Fields">
													<variableReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="newFields"/>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<propertyReferenceExpression name="FieldFilter">
												<variableReferenceExpression name="page"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- field serverRules-->
						<memberField type="BusinessRules" name="serverRules">
							<attributes private="true"/>
						</memberField>
						<!-- method InitBusinessRules(PageRequest, ViewPage) -->
						<memberMethod returnType="BusinessRules" name="InitBusinessRules">
							<attributes family="true"/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="BusinessRules" name="rules">
									<init>
										<methodInvokeExpression methodName="CreateBusinessRules">
											<target>
												<fieldReferenceExpression name="config"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<fieldReferenceExpression name="serverRules"/>
									<variableReferenceExpression name="rules"/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="serverRules"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="serverRules"/>
											<methodInvokeExpression methodName="CreateBusinessRules"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="Page">
										<fieldReferenceExpression name="serverRules"/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="page"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="RequiresRowCount">
										<fieldReferenceExpression name="serverRules"/>
									</propertyReferenceExpression>
									<binaryOperatorExpression operator="BooleanAnd">
										<propertyReferenceExpression name="RequiresRowCount">
											<argumentReferenceExpression name="page"/>
										</propertyReferenceExpression>
										<unaryOperatorExpression operator="Not">
											<binaryOperatorExpression operator="BooleanOr">
												<propertyReferenceExpression name="Inserting">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="DoesNotRequireData">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</unaryOperatorExpression>
									</binaryOperatorExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="rules"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<!--<assignStatement>
                      <propertyReferenceExpression name="Page">
                        <variableReferenceExpression name="rules"/>
                      </propertyReferenceExpression>
                      <variableReferenceExpression name="page"/>
                    </assignStatement>-->
										<methodInvokeExpression methodName="BeforeSelect">
											<target>
												<variableReferenceExpression name="rules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="request"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="ExecuteServerRules">
											<target>
												<fieldReferenceExpression name="serverRules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="request"/>
												<propertyReferenceExpression name="Before">
													<typeReferenceExpression type="ActionPhase"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="rules"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetPageList(PageRequeest[]) -->
						<memberMethod returnType="ViewPage[]" name="GetPageList">
							<attributes public="true"/>
							<parameters>
								<parameter type="PageRequest[]" name="requests"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="List" name="result">
									<typeArguments>
										<typeReference type="ViewPage"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="ViewPage"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="PageRequest" name="r"/>
									<target>
										<argumentReferenceExpression name="requests"/>
									</target>
									<statements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="result"/>
											</target>
											<parameters>
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
															<argumentReferenceExpression name="r"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="View">
															<argumentReferenceExpression name="r"/>
														</propertyReferenceExpression>
														<argumentReferenceExpression name="r"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="result"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ExecuteList(ActionArgs[]) -->
						<memberMethod returnType="ActionResult[]" name="ExecuteList">
							<attributes public="true" />
							<parameters>
								<parameter type="ActionArgs[]" name="requests"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="List" name="result">
									<typeArguments>
										<typeReference type="ActionResult"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="ActionResult"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="ActionArgs" name="r"/>
									<target>
										<argumentReferenceExpression name="requests"/>
									</target>
									<statements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="result"/>
											</target>
											<parameters>
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
															<variableReferenceExpression name="r"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="View">
															<variableReferenceExpression name="r"/>
														</propertyReferenceExpression>
														<variableReferenceExpression name="r"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="result"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IDataController.GetPage(string, string, PageRequest)-->
						<memberMethod returnType="ViewPage" name="GetPage" privateImplementationType="IDataController">
							<attributes/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="PageRequest" name="request"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ViewPage" name="page" var="false">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="cacheItem">
									<init>
										<objectCreateExpression type="DataCacheItem">
											<parameters>
												<argumentReferenceExpression name="controller"/>
												<argumentReferenceExpression name="request"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="HasValue">
											<variableReferenceExpression name="cacheItem"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<castExpression targetType="ViewPage">
												<propertyReferenceExpression name="Value">
													<variableReferenceExpression name="cacheItem"/>
												</propertyReferenceExpression>
											</castExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="SelectView">
									<parameters>
										<argumentReferenceExpression name="controller"/>
										<argumentReferenceExpression name="view"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="AssignContext">
									<target>
										<argumentReferenceExpression name="request"/>
									</target>
									<parameters>
										<argumentReferenceExpression name="controller"/>
										<fieldReferenceExpression name="viewId">
											<thisReferenceExpression/>
										</fieldReferenceExpression>
										<fieldReferenceExpression name="config"/>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<variableReferenceExpression name="page"/>
									<objectCreateExpression type="ViewPage">
										<parameters>
											<argumentReferenceExpression name="request"/>
										</parameters>
									</objectCreateExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="FieldFilter">
														<argumentReferenceExpression name="page"/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="Distinct">
														<variableReferenceExpression name="page"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Length">
														<propertyReferenceExpression name="FieldFilter">
															<argumentReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="IdentityInequality">
													<methodInvokeExpression methodName="SelectSingleNode">
														<target>
															<propertyReferenceExpression name="Config"/>
														</target>
														<parameters>
															<primitiveExpression value="/c:dataController/c:businessRules/c:rule[@commandName='Select']"/>
														</parameters>
													</methodInvokeExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="FieldFilter">
												<variableReferenceExpression name="page"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
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
								<methodInvokeExpression methodName="AssignDynamicExpressions">
									<target>
										<fieldReferenceExpression name="config"/>
									</target>
									<parameters>
										<variableReferenceExpression name="page"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="ApplyDataFilter">
									<target>
										<variableReferenceExpression name="page"/>
									</target>
									<parameters>
										<methodInvokeExpression methodName="CreateDataFilter">
											<target>
												<fieldReferenceExpression name="config"/>
											</target>
										</methodInvokeExpression>
										<propertyReferenceExpression name="Controller">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="View">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="LookupContextController">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="LookupContextView">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="LookupContextFieldName">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="BusinessRules" name="rules">
									<init>
										<methodInvokeExpression methodName="InitBusinessRules">
											<parameters>
												<argumentReferenceExpression name="request"/>
												<variableReferenceExpression name="page"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
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
												<methodInvokeExpression methodName="PopulatePageFields">
													<parameters>
														<variableReferenceExpression name="page"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="EnsurePageFields">
													<parameters>
														<variableReferenceExpression name="page"/>
														<primitiveExpression value="null"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<propertyReferenceExpression name="RequiresMetaData">
														<variableReferenceExpression name="page"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="IncludeMetadata">
														<target>
															<variableReferenceExpression name="page"/>
														</target>
														<parameters>
															<primitiveExpression value="categories"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="PopulatePageCategories">
													<parameters>
														<variableReferenceExpression name="page"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="SyncRequestedPage">
											<parameters>
												<argumentReferenceExpression name="request"/>
												<variableReferenceExpression name="page"/>
												<variableReferenceExpression name="connection"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="ConfigureCommand">
											<parameters>
												<variableReferenceExpression name="selectCommand"/>
												<variableReferenceExpression name="page"/>
												<propertyReferenceExpression name="Select">
													<typeReferenceExpression type="CommandConfigurationType"/>
												</propertyReferenceExpression>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="GreaterThan">
														<propertyReferenceExpression name="PageSize">
															<variableReferenceExpression name="page"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
													<unaryOperatorExpression operator="Not">
														<binaryOperatorExpression operator="BooleanOr">
															<propertyReferenceExpression name="Inserting">
																<argumentReferenceExpression name="request"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="DoesNotRequireData">
																<argumentReferenceExpression name="request"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="EnsureSystemPageFields">
													<parameters>
														<argumentReferenceExpression name="request"/>
														<variableReferenceExpression name="page"/>
														<variableReferenceExpression name="selectCommand"/>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement type="DbDataReader" name="reader">
													<init>
														<methodInvokeExpression methodName="ExecuteResultSetReader">
															<parameters>
																<variableReferenceExpression name="page"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="reader"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityEquality">
																	<variableReferenceExpression name="selectCommand"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="reader"/>
																	<methodInvokeExpression methodName="ExecuteVirtualReader">
																		<parameters>
																			<argumentReferenceExpression name="request"/>
																			<variableReferenceExpression name="page"/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<assignStatement>
																	<variableReferenceExpression name="reader"/>
																	<methodInvokeExpression methodName="ExecuteReader">
																		<target>
																			<variableReferenceExpression name="selectCommand"/>
																		</target>
																	</methodInvokeExpression>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
												<whileStatement>
													<test>
														<methodInvokeExpression methodName="SkipNext">
															<target>
																<variableReferenceExpression name="page"/>
															</target>
														</methodInvokeExpression>
													</test>
													<statements>
														<methodInvokeExpression methodName="Read">
															<target>
																<variableReferenceExpression name="reader"/>
															</target>
														</methodInvokeExpression>
													</statements>
												</whileStatement>
												<variableDeclarationStatement type="List" name="fieldMap">
													<typeArguments>
														<typeReference type="System.Int32"/>
													</typeArguments>
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="List" name="typedFieldMap">
													<typeArguments>
														<typeReference type="System.Int32"/>
													</typeArguments>
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<whileStatement>
													<test>
														<binaryOperatorExpression operator="BooleanAnd">
															<methodInvokeExpression methodName="ReadNext">
																<target>
																	<variableReferenceExpression name="page"/>
																</target>
															</methodInvokeExpression>
															<methodInvokeExpression methodName="Read">
																<target>
																	<variableReferenceExpression name="reader"/>
																</target>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</test>
													<statements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityEquality">
																	<variableReferenceExpression name="fieldMap"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="fieldMap"/>
																	<objectCreateExpression type="List">
																		<typeArguments>
																			<typeReference type="System.Int32"/>
																		</typeArguments>
																	</objectCreateExpression>
																</assignStatement>
																<assignStatement>
																	<variableReferenceExpression name="typedFieldMap"/>
																	<objectCreateExpression type="List">
																		<typeArguments>
																			<typeReference type="System.Int32"/>
																		</typeArguments>
																	</objectCreateExpression>
																</assignStatement>
																<variableDeclarationStatement type="SortedDictionary" name="availableColumns">
																	<typeArguments>
																		<typeReference type="System.String"/>
																		<typeReference type="System.Int32"/>
																	</typeArguments>
																	<init>
																		<objectCreateExpression type="SortedDictionary">
																			<typeArguments>
																				<typeReference type="System.String"/>
																				<typeReference type="System.Int32"/>
																			</typeArguments>
																		</objectCreateExpression>
																	</init>
																</variableDeclarationStatement>
																<forStatement>
																	<variable type="System.Int32" name="j">
																		<init>
																			<primitiveExpression value="0"/>
																		</init>
																	</variable>
																	<test>
																		<binaryOperatorExpression operator="LessThan">
																			<variableReferenceExpression  name="j"/>
																			<propertyReferenceExpression name="FieldCount">
																				<variableReferenceExpression name="reader"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</test>
																	<increment>
																		<variableReferenceExpression name="j"/>
																	</increment>
																	<statements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="availableColumns"/>
																				</target>
																				<indices>
																					<methodInvokeExpression methodName="ToLower">
																						<target>
																							<methodInvokeExpression methodName="GetName">
																								<target>
																									<variableReferenceExpression name="reader"/>
																								</target>
																								<parameters>
																									<variableReferenceExpression name="j"/>
																								</parameters>
																							</methodInvokeExpression>
																						</target>
																					</methodInvokeExpression>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="j"/>
																		</assignStatement>
																	</statements>
																</forStatement>
																<forStatement>
																	<variable type="System.Int32" name="k">
																		<init>
																			<primitiveExpression value="0"/>
																		</init>
																	</variable>
																	<test>
																		<binaryOperatorExpression operator="LessThan">
																			<variableReferenceExpression name="k"/>
																			<propertyReferenceExpression name="Count">
																				<propertyReferenceExpression name="Fields">
																					<variableReferenceExpression name="page"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</test>
																	<increment>
																		<variableReferenceExpression name="k"/>
																	</increment>
																	<statements>
																		<variableDeclarationStatement type="System.Int32" name="columnIndex">
																			<init>
																				<primitiveExpression value="0"/>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<methodInvokeExpression methodName="TryGetValue">
																						<target>
																							<variableReferenceExpression name="availableColumns"/>
																						</target>
																						<parameters>
																							<methodInvokeExpression methodName="ToLower">
																								<target>
																									<propertyReferenceExpression name="Name">
																										<arrayIndexerExpression>
																											<target>
																												<propertyReferenceExpression name="Fields">
																													<variableReferenceExpression name="page"/>
																												</propertyReferenceExpression>
																											</target>
																											<indices>
																												<variableReferenceExpression name="k"/>
																											</indices>
																										</arrayIndexerExpression>
																									</propertyReferenceExpression>
																								</target>
																							</methodInvokeExpression>
																							<directionExpression direction="Out">
																								<variableReferenceExpression name="columnIndex"/>
																							</directionExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="columnIndex"/>
																					<primitiveExpression value="-1"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<variableReferenceExpression name="fieldMap"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="columnIndex"/>
																			</parameters>
																		</methodInvokeExpression>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="GreaterThanOrEqual">
																					<variableReferenceExpression name="columnIndex"/>
																					<primitiveExpression value="0"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement name="columnType">
																					<init>
																						<methodInvokeExpression methodName="GetFieldType">
																							<target>
																								<variableReferenceExpression name="reader"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="columnIndex"/>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="IdentityEquality">
																							<variableReferenceExpression name="columnType"/>
																							<primitiveExpression value="null"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="Add">
																							<target>
																								<variableReferenceExpression name="typedFieldMap"/>
																							</target>
																							<parameters>
																								<primitiveExpression value="-1"/>
																							</parameters>
																						</methodInvokeExpression>
																					</trueStatements>
																					<falseStatements>
																						<methodInvokeExpression methodName="Add">
																							<target>
																								<variableReferenceExpression name="typedFieldMap"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="columnIndex"/>
																							</parameters>
																						</methodInvokeExpression>
																					</falseStatements>
																				</conditionStatement>
																			</trueStatements>
																			<falseStatements>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="typedFieldMap"/>
																					</target>
																					<parameters>
																						<primitiveExpression value="-1"/>
																					</parameters>
																				</methodInvokeExpression>
																			</falseStatements>
																		</conditionStatement>
																	</statements>
																</forStatement>
															</trueStatements>
														</conditionStatement>
														<variableDeclarationStatement type="System.Object[]" name="values">
															<init>
																<arrayCreateExpression>
																	<createType type="System.Object"/>
																	<sizeExpression>
																		<propertyReferenceExpression name="Count">
																			<propertyReferenceExpression name="Fields">
																				<variableReferenceExpression name="page"/>
																			</propertyReferenceExpression>
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
																		<variableReferenceExpression name="values"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</test>
															<increment>
																<variableReferenceExpression name="i"/>
															</increment>
															<statements>
																<variableDeclarationStatement type="System.Int32" name="columnIndex">
																	<init>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="fieldMap"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="i"/>
																			</indices>
																		</arrayIndexerExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueInequality">
																			<variableReferenceExpression name="columnIndex"/>
																			<primitiveExpression value="-1"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="DataField" name="field">
																			<init>
																				<arrayIndexerExpression>
																					<target>
																						<propertyReferenceExpression name="Fields">
																							<variableReferenceExpression name="page"/>
																						</propertyReferenceExpression>
																					</target>
																					<indices>
																						<variableReferenceExpression name="i"/>
																					</indices>
																				</arrayIndexerExpression>
																			</init>
																		</variableDeclarationStatement>
																		<variableDeclarationStatement type="System.Object" name="v"/>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueEquality">
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="typedFieldMap"/>
																						</target>
																						<indices>
																							<variableReferenceExpression name="i"/>
																						</indices>
																					</arrayIndexerExpression>
																					<primitiveExpression value="-1"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<usingStatement>
																					<variable name="stream">
																						<init>
																							<objectCreateExpression type="MemoryStream"/>
																						</init>
																					</variable>
																					<statements>
																						<comment>use GetBytes instead of GetStream for compatiblity with .NET 4 and below</comment>
																						<variableDeclarationStatement name="dataBuffer">
																							<init>
																								<arrayCreateExpression>
																									<createType type="System.Byte"/>
																									<sizeExpression>
																										<primitiveExpression value="4096"/>
																									</sizeExpression>
																								</arrayCreateExpression>
																							</init>
																						</variableDeclarationStatement>
																						<variableDeclarationStatement type="System.Int64" name="bytesRead"/>
																						<tryStatement>
																							<statements>
																								<assignStatement>
																									<variableReferenceExpression name="bytesRead"/>
																									<methodInvokeExpression methodName="GetBytes">
																										<target>
																											<variableReferenceExpression name="reader"/>
																										</target>
																										<parameters>
																											<variableReferenceExpression name="columnIndex"/>
																											<primitiveExpression value="0"/>
																											<variableReferenceExpression name="dataBuffer"/>
																											<primitiveExpression value="0"/>
																											<propertyReferenceExpression name="Length">
																												<variableReferenceExpression name="dataBuffer"/>
																											</propertyReferenceExpression>
																										</parameters>
																									</methodInvokeExpression>
																								</assignStatement>
																							</statements>
																							<catch exceptionType="Exception">
																								<assignStatement>
																									<variableReferenceExpression name="bytesRead"/>
																									<primitiveExpression value="0"/>
																								</assignStatement>
																							</catch>
																						</tryStatement>
																						<whileStatement>
																							<test>
																								<binaryOperatorExpression operator="GreaterThan">
																									<variableReferenceExpression name="bytesRead"/>
																									<primitiveExpression value="0"/>
																								</binaryOperatorExpression>
																							</test>
																							<statements>
																								<methodInvokeExpression methodName="Write">
																									<target>
																										<variableReferenceExpression name="stream"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="dataBuffer"/>
																										<primitiveExpression value="0"/>
																										<convertExpression to="Int32">
																											<variableReferenceExpression name="bytesRead"/>
																										</convertExpression>
																									</parameters>
																								</methodInvokeExpression>
																								<assignStatement>
																									<variableReferenceExpression name="bytesRead"/>
																									<methodInvokeExpression methodName="GetBytes">
																										<target>
																											<variableReferenceExpression name="reader"/>
																										</target>
																										<parameters>
																											<variableReferenceExpression name="columnIndex"/>
																											<propertyReferenceExpression name="Length">
																												<variableReferenceExpression name="stream"/>
																											</propertyReferenceExpression>
																											<variableReferenceExpression name="dataBuffer"/>
																											<primitiveExpression value="0"/>
																											<propertyReferenceExpression name="Length">
																												<variableReferenceExpression name="dataBuffer"/>
																											</propertyReferenceExpression>
																										</parameters>
																									</methodInvokeExpression>
																								</assignStatement>
																							</statements>
																						</whileStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="Length">
																										<variableReferenceExpression name="stream"/>
																									</propertyReferenceExpression>
																									<primitiveExpression value="0"/>
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
																							<falseStatements>
																								<assignStatement>
																									<propertyReferenceExpression name="Position">
																										<variableReferenceExpression name="stream"/>
																									</propertyReferenceExpression>
																									<primitiveExpression value="0"/>
																								</assignStatement>
																								<assignStatement>
																									<variableReferenceExpression name="dataBuffer"/>
																									<arrayCreateExpression >
																										<createType type="System.Byte"/>
																										<sizeExpression>
																											<propertyReferenceExpression name="Length">
																												<variableReferenceExpression name="stream"/>
																											</propertyReferenceExpression>
																										</sizeExpression>
																									</arrayCreateExpression>
																								</assignStatement>
																								<methodInvokeExpression methodName="Read">
																									<target>
																										<variableReferenceExpression name="stream"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="dataBuffer"/>
																										<primitiveExpression value="0"/>
																										<convertExpression to="Int32">
																											<propertyReferenceExpression name="Length">
																												<variableReferenceExpression name="stream"/>
																											</propertyReferenceExpression>
																										</convertExpression>
																									</parameters>
																								</methodInvokeExpression>
																								<assignStatement>
																									<variableReferenceExpression name="v"/>
																									<binaryOperatorExpression operator="Add">
																										<primitiveExpression value="0x"/>
																										<methodInvokeExpression methodName="Replace">
																											<target>
																												<methodInvokeExpression methodName="ToString">
																													<target>
																														<typeReferenceExpression type="BitConverter"/>
																													</target>
																													<parameters>
																														<variableReferenceExpression name="dataBuffer"/>
																													</parameters>
																												</methodInvokeExpression>
																											</target>
																											<parameters>
																												<primitiveExpression value="-"/>
																												<stringEmptyExpression/>
																											</parameters>
																										</methodInvokeExpression>
																									</binaryOperatorExpression>
																								</assignStatement>
																							</falseStatements>
																						</conditionStatement>
																					</statements>
																				</usingStatement>

																			</trueStatements>
																			<falseStatements>
																				<assignStatement>
																					<variableReferenceExpression name="v"/>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="reader"/>
																						</target>
																						<indices>
																							<variableReferenceExpression name="columnIndex"/>
																						</indices>
																					</arrayIndexerExpression>
																				</assignStatement>
																			</falseStatements>
																		</conditionStatement>
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
																						<propertyReferenceExpression name="IsMirror">
																							<variableReferenceExpression name="field"/>
																						</propertyReferenceExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="v"/>
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
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="BooleanAnd">
																									<binaryOperatorExpression operator="ValueEquality">
																										<propertyReferenceExpression name="Type">
																											<variableReferenceExpression name="field"/>
																										</propertyReferenceExpression>
																										<primitiveExpression value="Guid"/>
																									</binaryOperatorExpression>
																									<binaryOperatorExpression operator="IdentityEquality">
																										<methodInvokeExpression methodName="GetType">
																											<target>
																												<variableReferenceExpression name="v"/>
																											</target>
																										</methodInvokeExpression>
																										<typeofExpression type="System.Byte[]"/>
																									</binaryOperatorExpression>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<assignStatement>
																									<variableReferenceExpression name="v"/>
																									<objectCreateExpression type="Guid">
																										<parameters>
																											<castExpression targetType="System.Byte[]">
																												<variableReferenceExpression name="v"/>
																											</castExpression>
																										</parameters>
																									</objectCreateExpression>
																								</assignStatement>
																							</trueStatements>
																							<falseStatements>
																								<assignStatement>
																									<variableReferenceExpression name="v"/>
																									<methodInvokeExpression methodName="ConvertObjectToValue">
																										<parameters>
																											<variableReferenceExpression name="v"/>
																										</parameters>
																									</methodInvokeExpression>
																								</assignStatement>
																							</falseStatements>
																						</conditionStatement>
																					</falseStatements>
																				</conditionStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="values"/>
																						</target>
																						<indices>
																							<variableReferenceExpression name="i"/>
																						</indices>
																					</arrayIndexerExpression>
																					<variableReferenceExpression name="v"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="IsNotNullOrEmpty">
																					<propertyReferenceExpression name="SourceFields">
																						<variableReferenceExpression name="field"/>
																					</propertyReferenceExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="values"/>
																						</target>
																						<indices>
																							<variableReferenceExpression name="i"/>
																						</indices>
																					</arrayIndexerExpression>
																					<methodInvokeExpression methodName="CreateValueFromSourceFields">
																						<parameters>
																							<variableReferenceExpression name="field"/>
																							<variableReferenceExpression name="reader"/>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</forStatement>
														<conditionStatement>
															<condition>
																<propertyReferenceExpression name="RequiresPivot">
																	<variableReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="AddPivotValues">
																	<target>
																		<variableReferenceExpression name="page"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="values"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<propertyReferenceExpression name="Rows">
																			<variableReferenceExpression name="page"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="values"/>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
													</statements>
												</whileStatement>
												<methodInvokeExpression methodName="Close">
													<target>
														<variableReferenceExpression name="reader"/>
													</target>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="RequiresRowCount">
													<fieldReferenceExpression name="serverRules"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="EnableResultSet">
															<fieldReferenceExpression name="serverRules"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="TotalRowCount">
																<variableReferenceExpression name="page"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="ResultSetSize">
																<fieldReferenceExpression name="serverRules"/>
															</propertyReferenceExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<variableDeclarationStatement type="DbCommand" name="countCommand">
															<init>
																<methodInvokeExpression methodName="CreateCommand">
																	<parameters>
																		<variableReferenceExpression name="connection"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<propertyReferenceExpression name="FieldFilter">
																<variableReferenceExpression name="page"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="FieldFilter">
																<argumentReferenceExpression name="request"/>
															</propertyReferenceExpression>
														</assignStatement>
														<methodInvokeExpression methodName="ConfigureCommand">
															<parameters>
																<variableReferenceExpression name="countCommand"/>
																<variableReferenceExpression name="page"/>
																<propertyReferenceExpression name="SelectCount">
																	<typeReferenceExpression type="CommandConfigurationType"/>
																</propertyReferenceExpression>
																<primitiveExpression value="null"/>
															</parameters>
														</methodInvokeExpression>
														<assignStatement>
															<propertyReferenceExpression name="FieldFilter">
																<variableReferenceExpression name="page"/>
															</propertyReferenceExpression>
															<primitiveExpression value="null"/>
														</assignStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="YieldsSingleRow">
																	<parameters>
																		<variableReferenceExpression name="countCommand"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="TotalRowCount">
																		<variableReferenceExpression name="page"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="1"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<binaryOperatorExpression operator="LessThan">
																				<propertyReferenceExpression name="Count">
																					<propertyReferenceExpression name="Rows">
																						<variableReferenceExpression name="page"/>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																				<propertyReferenceExpression name="PageSize">
																					<variableReferenceExpression name="page"/>
																				</propertyReferenceExpression>
																			</binaryOperatorExpression>
																			<binaryOperatorExpression operator="LessThanOrEqual">
																				<propertyReferenceExpression name="PageIndex">
																					<variableReferenceExpression name="page"/>
																				</propertyReferenceExpression>
																				<primitiveExpression value="0"/>
																			</binaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="TotalRowCount">
																				<variableReferenceExpression name="page"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="Count">
																				<propertyReferenceExpression name="Rows">
																					<variableReferenceExpression name="page"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="TotalRowCount">
																				<variableReferenceExpression name="page"/>
																			</propertyReferenceExpression>
																			<methodInvokeExpression methodName="ToInt32">
																				<target>
																					<typeReferenceExpression type="Convert"/>
																				</target>
																				<parameters>
																					<methodInvokeExpression methodName="ExecuteScalar">
																						<target>
																							<variableReferenceExpression name="countCommand"/>
																						</target>
																					</methodInvokeExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</falseStatements>
																</conditionStatement>
															</falseStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="Not">
																<propertyReferenceExpression name="DoesNotRequireAggregates">
																	<variableReferenceExpression name="request"/>
																</propertyReferenceExpression>
															</unaryOperatorExpression>
															<propertyReferenceExpression name="RequiresAggregates">
																<variableReferenceExpression name="page"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.Object[]" name="aggregates">
															<init>
																<arrayCreateExpression>
																	<createType type="System.Object"/>
																	<sizeExpression>
																		<propertyReferenceExpression name="Count">
																			<propertyReferenceExpression name="Fields">
																				<variableReferenceExpression name="page"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																	</sizeExpression>
																</arrayCreateExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<propertyReferenceExpression name="EnableResultSet">
																	<fieldReferenceExpression name="serverRules"/>
																</propertyReferenceExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="DataTable" name="dt">
																	<init>
																		<methodInvokeExpression methodName="ExecuteResultSetTable">
																			<parameters>
																				<variableReferenceExpression name="page"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<forStatement>
																	<variable type="System.Int32" name="j">
																		<init>
																			<primitiveExpression value="0"/>
																		</init>
																	</variable>
																	<test>
																		<binaryOperatorExpression operator="LessThan">
																			<variableReferenceExpression name="j"/>
																			<propertyReferenceExpression name="Length">
																				<variableReferenceExpression name="aggregates"/>
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
																							<variableReferenceExpression name="page"/>
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
																				<binaryOperatorExpression operator="ValueInequality">
																					<propertyReferenceExpression name="Aggregate">
																						<variableReferenceExpression name="field"/>
																					</propertyReferenceExpression>
																					<propertyReferenceExpression name="None">
																						<typeReferenceExpression type="DataFieldAggregate"/>
																					</propertyReferenceExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<variableDeclarationStatement type="System.String" name="func">
																					<init>
																						<methodInvokeExpression methodName="ToString">
																							<target>
																								<propertyReferenceExpression name="Aggregate">
																									<variableReferenceExpression name="field"/>
																								</propertyReferenceExpression>
																							</target>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="ValueEquality">
																							<variableReferenceExpression name="func"/>
																							<primitiveExpression value="Count"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<variableDeclarationStatement type="SortedDictionary" name="uniqueValues">
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
																						<foreachStatement>
																							<variable type="DataRow" name="r" var="false"/>
																							<target>
																								<propertyReferenceExpression name="Rows">
																									<variableReferenceExpression name="dt"/>
																								</propertyReferenceExpression>
																							</target>
																							<statements>
																								<variableDeclarationStatement type="System.Object" name="v">
																									<init>
																										<arrayIndexerExpression>
																											<target>
																												<variableReferenceExpression name="r"/>
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
																										<assignStatement>
																											<arrayIndexerExpression>
																												<target>
																													<variableReferenceExpression name="uniqueValues"/>
																												</target>
																												<indices>
																													<methodInvokeExpression methodName="ToString">
																														<target>
																															<variableReferenceExpression name="v"/>
																														</target>
																													</methodInvokeExpression>
																												</indices>
																											</arrayIndexerExpression>
																											<primitiveExpression value="null"/>
																										</assignStatement>
																									</trueStatements>
																								</conditionStatement>
																							</statements>
																						</foreachStatement>
																						<assignStatement>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="aggregates"/>
																								</target>
																								<indices>
																									<variableReferenceExpression name="j"/>
																								</indices>
																							</arrayIndexerExpression>
																							<propertyReferenceExpression name="Count">
																								<propertyReferenceExpression name="Keys">
																									<variableReferenceExpression name="uniqueValues"/>
																								</propertyReferenceExpression>
																							</propertyReferenceExpression>
																						</assignStatement>
																					</trueStatements>
																					<falseStatements>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<variableReferenceExpression name="func"/>
																									<primitiveExpression value="Average"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<assignStatement>
																									<variableReferenceExpression name="func"/>
																									<primitiveExpression value="avg"/>
																								</assignStatement>
																							</trueStatements>
																						</conditionStatement>
																						<assignStatement>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="aggregates"/>
																								</target>
																								<indices>
																									<variableReferenceExpression name="j"/>
																								</indices>
																							</arrayIndexerExpression>
																							<methodInvokeExpression methodName="Compute">
																								<target>
																									<variableReferenceExpression name="dt"/>
																								</target>
																								<parameters>
																									<stringFormatExpression format="{{0}}([{{1}}])">
																										<variableReferenceExpression name="func"/>
																										<propertyReferenceExpression name="Name">
																											<variableReferenceExpression name="field"/>
																										</propertyReferenceExpression>
																									</stringFormatExpression>
																									<primitiveExpression value="null"/>
																								</parameters>
																							</methodInvokeExpression>
																						</assignStatement>
																					</falseStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</forStatement>
															</trueStatements>
															<falseStatements>
																<variableDeclarationStatement type="DbCommand" name="aggregateCommand">
																	<init>
																		<methodInvokeExpression methodName="CreateCommand">
																			<parameters>
																				<variableReferenceExpression name="connection"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<methodInvokeExpression methodName="ConfigureCommand">
																	<parameters>
																		<variableReferenceExpression name="aggregateCommand"/>
																		<variableReferenceExpression name="page"/>
																		<propertyReferenceExpression name="SelectAggregates">
																			<typeReferenceExpression type="CommandConfigurationType"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="null"/>
																	</parameters>
																</methodInvokeExpression>
																<variableDeclarationStatement type="DbDataReader" name="reader">
																	<init>
																		<methodInvokeExpression methodName="ExecuteReader">
																			<target>
																				<variableReferenceExpression name="aggregateCommand"/>
																			</target>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="Read">
																			<target>
																				<variableReferenceExpression name="reader"/>
																			</target>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<forStatement>
																			<variable type="System.Int32" name="j">
																				<init>
																					<primitiveExpression value="0"/>
																				</init>
																			</variable>
																			<test>
																				<binaryOperatorExpression operator="LessThan">
																					<variableReferenceExpression name="j"/>
																					<propertyReferenceExpression name="Length">
																						<variableReferenceExpression name="aggregates"/>
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
																									<variableReferenceExpression name="page"/>
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
																						<binaryOperatorExpression operator="ValueInequality">
																							<propertyReferenceExpression name="Aggregate">
																								<variableReferenceExpression name="field"/>
																							</propertyReferenceExpression>
																							<propertyReferenceExpression name="None">
																								<typeReferenceExpression type="DataFieldAggregate"/>
																							</propertyReferenceExpression>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="aggregates"/>
																								</target>
																								<indices>
																									<variableReferenceExpression name="j"/>
																								</indices>
																							</arrayIndexerExpression>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="reader"/>
																								</target>
																								<indices>
																									<propertyReferenceExpression name="Name">
																										<variableReferenceExpression name="field"/>
																									</propertyReferenceExpression>
																								</indices>
																							</arrayIndexerExpression>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																			</statements>
																		</forStatement>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="Close">
																	<target>
																		<variableReferenceExpression name="reader"/>
																	</target>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
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
																		<variableReferenceExpression name="aggregates"/>
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
																					<variableReferenceExpression name="page"/>
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
																		<binaryOperatorExpression operator="ValueInequality">
																			<propertyReferenceExpression name="Aggregate">
																				<variableReferenceExpression name="field"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="None">
																				<typeReferenceExpression type="DataFieldAggregate"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="System.Object" name="v">
																			<init>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="aggregates"/>
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
																					<binaryOperatorExpression operator="IdentityInequality">
																						<variableReferenceExpression name="v"/>
																						<primitiveExpression value="null"/>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="BooleanAnd">
																							<unaryOperatorExpression operator="Not">
																								<propertyReferenceExpression name="FormatOnClient">
																									<variableReferenceExpression name="field"/>
																								</propertyReferenceExpression>
																							</unaryOperatorExpression>
																							<unaryOperatorExpression operator="IsNotNullOrEmpty">
																								<propertyReferenceExpression name="DataFormatString">
																									<variableReferenceExpression name="field"/>
																								</propertyReferenceExpression>
																							</unaryOperatorExpression>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="v"/>
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
																				</conditionStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="aggregates"/>
																						</target>
																						<indices>
																							<variableReferenceExpression name="i"/>
																						</indices>
																					</arrayIndexerExpression>
																					<variableReferenceExpression name="v"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</forStatement>
														<assignStatement>
															<propertyReferenceExpression name="Aggregates">
																<variableReferenceExpression name="page"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="aggregates"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<xsl:if test="$IsPremium='true'">
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<propertyReferenceExpression name="RequiresFirstLetters">
															<argumentReferenceExpression name="request"/>
														</propertyReferenceExpression>
														<binaryOperatorExpression operator="ValueInequality">
															<fieldReferenceExpression name="viewType">
																<thisReferenceExpression/>
															</fieldReferenceExpression>
															<primitiveExpression value="Form"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<conditionStatement>
														<condition>
															<unaryOperatorExpression operator="Not">
																<propertyReferenceExpression name="RequiresRowCount">
																	<variableReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</unaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<propertyReferenceExpression name="FirstLetters">
																	<variableReferenceExpression name="page"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Empty">
																	<typeReferenceExpression type="String"/>
																</propertyReferenceExpression>
															</assignStatement>
														</trueStatements>
														<falseStatements>
															<variableDeclarationStatement type="DbCommand" name="firstLettersCommand">
																<init>
																	<methodInvokeExpression methodName="CreateCommand">
																		<parameters>
																			<variableReferenceExpression name="connection"/>
																		</parameters>
																	</methodInvokeExpression>
																</init>
															</variableDeclarationStatement>
															<variableDeclarationStatement type="System.String[]" name="oldFilter">
																<init>
																	<propertyReferenceExpression name="Filter">
																		<variableReferenceExpression name="page"/>
																	</propertyReferenceExpression>
																</init>
															</variableDeclarationStatement>
															<methodInvokeExpression methodName="ConfigureCommand">
																<parameters>
																	<variableReferenceExpression name="firstLettersCommand"/>
																	<variableReferenceExpression name="page"/>
																	<propertyReferenceExpression name="SelectFirstLetters">
																		<typeReferenceExpression type="CommandConfigurationType"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="null"/>
																</parameters>
															</methodInvokeExpression>
															<assignStatement>
																<propertyReferenceExpression name="Filter">
																	<variableReferenceExpression name="page"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="oldFilter"/>
															</assignStatement>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<propertyReferenceExpression name="FirstLetters">
																			<variableReferenceExpression name="page"/>
																		</propertyReferenceExpression>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<variableDeclarationStatement type="DbDataReader" name="reader">
																		<init>
																			<methodInvokeExpression methodName="ExecuteReader">
																				<target>
																					<variableReferenceExpression name="firstLettersCommand"/>
																				</target>
																			</methodInvokeExpression>
																		</init>
																	</variableDeclarationStatement>
																	<variableDeclarationStatement type="StringBuilder" name="firstLetters">
																		<init>
																			<objectCreateExpression type="StringBuilder">
																				<parameters>
																					<propertyReferenceExpression name="FirstLetters">
																						<variableReferenceExpression name="page"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</objectCreateExpression>
																		</init>
																	</variableDeclarationStatement>
																	<whileStatement>
																		<test>
																			<methodInvokeExpression methodName="Read">
																				<target>
																					<variableReferenceExpression name="reader"/>
																				</target>
																			</methodInvokeExpression>
																		</test>
																		<statements>
																			<methodInvokeExpression methodName="Append">
																				<target>
																					<variableReferenceExpression name="firstLetters"/>
																				</target>
																				<parameters>
																					<primitiveExpression value=","/>
																				</parameters>
																			</methodInvokeExpression>
																			<variableDeclarationStatement type="System.String" name="letter">
																				<init>
																					<methodInvokeExpression methodName="ToString">
																						<target>
																							<typeReferenceExpression type="Convert"/>
																						</target>
																						<parameters>
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="reader"/>
																								</target>
																								<indices>
																									<primitiveExpression value="0"/>
																								</indices>
																							</arrayIndexerExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</init>
																			</variableDeclarationStatement>
																			<conditionStatement>
																				<condition>
																					<unaryOperatorExpression operator="IsNotNullOrEmpty">
																						<variableReferenceExpression name="letter"/>
																					</unaryOperatorExpression>
																				</condition>
																				<trueStatements>
																					<methodInvokeExpression methodName="Append">
																						<target>
																							<variableReferenceExpression name="firstLetters"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="letter"/>
																						</parameters>
																					</methodInvokeExpression>
																				</trueStatements>
																			</conditionStatement>
																		</statements>
																	</whileStatement>
																	<methodInvokeExpression methodName="Close">
																		<target>
																			<variableReferenceExpression name="reader"/>
																		</target>
																	</methodInvokeExpression>
																	<assignStatement>
																		<propertyReferenceExpression name="FirstLetters">
																			<variableReferenceExpression name="page"/>
																		</propertyReferenceExpression>
																		<methodInvokeExpression methodName="ToString">
																			<target>
																				<variableReferenceExpression name="firstLetters"/>
																			</target>
																		</methodInvokeExpression>
																	</assignStatement>
																</trueStatements>
															</conditionStatement>
														</falseStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
										</xsl:if>
									</statements>
								</usingStatement>
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
										<methodInvokeExpression methodName="ProcessPageRequest">
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
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Inserting">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="NewRow">
												<variableReferenceExpression name="page"/>
											</propertyReferenceExpression>
											<arrayCreateExpression>
												<createType type="System.Object"/>
												<sizeExpression>
													<propertyReferenceExpression name="Count">
														<propertyReferenceExpression name="Fields">
															<variableReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</sizeExpression>
											</arrayCreateExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Inserting">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="SupportsCommand">
													<target>
														<fieldReferenceExpression name="serverRules"/>
													</target>
													<parameters>
														<primitiveExpression value="Sql|Code"/>
														<primitiveExpression value="New"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ExecuteServerRules">
													<target>
														<fieldReferenceExpression name="serverRules"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="request"/>
														<propertyReferenceExpression name="Execute">
															<typeReferenceExpression type="ActionPhase"/>
														</propertyReferenceExpression>
														<primitiveExpression value="New"/>
														<propertyReferenceExpression name="NewRow">
															<variableReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<methodInvokeExpression methodName="SupportsCommand">
														<target>
															<fieldReferenceExpression name="serverRules"/>
														</target>
														<parameters>
															<primitiveExpression value="Sql|Code"/>
															<primitiveExpression value="Select"/>
														</parameters>
													</methodInvokeExpression>
													<unaryOperatorExpression operator="Not">
														<propertyReferenceExpression name="Distinct">
															<variableReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable type="System.Object[]" name="row"/>
													<target>
														<propertyReferenceExpression name="Rows">
															<variableReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<methodInvokeExpression methodName="ExecuteServerRules">
															<target>
																<fieldReferenceExpression name="serverRules"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="request"/>
																<propertyReferenceExpression name="Execute">
																	<typeReferenceExpression type="ActionPhase"/>
																</propertyReferenceExpression>
																<primitiveExpression value="Select"/>
																<variableReferenceExpression name="row"/>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="Inserting">
												<variableReferenceExpression name="request"/>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="PopulateManyToManyFields">
											<parameters>
												<variableReferenceExpression name="page"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="rules"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="IRowHandler" name="rowHandler" var="false">
											<init>
												<variableReferenceExpression name="rules"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="Inserting">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="SupportsNewRow">
															<target>
																<variableReferenceExpression name="rowHandler"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="request"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="NewRow">
															<target>
																<variableReferenceExpression name="rowHandler"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="request"/>
																<variableReferenceExpression name="page"/>
																<propertyReferenceExpression name="NewRow">
																	<variableReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="SupportsPrepareRow">
															<target>
																<variableReferenceExpression name="rowHandler"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="request"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<foreachStatement>
															<variable type="System.Object[]" name="row"/>
															<target>
																<propertyReferenceExpression name="Rows">
																	<variableReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</target>
															<statements>
																<methodInvokeExpression methodName="PrepareRow">
																	<target>
																		<variableReferenceExpression name="rowHandler"/>
																	</target>
																	<parameters>
																		<argumentReferenceExpression name="request"/>
																		<variableReferenceExpression name="page"/>
																		<variableReferenceExpression name="row"/>
																	</parameters>
																</methodInvokeExpression>
															</statements>
														</foreachStatement>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="ProcessPageRequest">
											<target>
												<variableReferenceExpression name="rules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="request"/>
												<variableReferenceExpression name="page"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="CompleteConfiguration">
													<target>
														<variableReferenceExpression name="rules"/>
													</target>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="ResetViewPage">
													<parameters>
														<variableReferenceExpression name="page"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<xsl:if test="$IsUnlimited='true' and (contains($Auditing, 'Modified') or contains($Auditing, 'Created'))">
									<methodInvokeExpression methodName="Process">
										<target>
											<typeReferenceExpression type="{$Namespace}.Security.EventTracker"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="page"/>
											<variableReferenceExpression name="request"/>
										</parameters>
									</methodInvokeExpression>
								</xsl:if>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="rules"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AfterSelect">
											<target>
												<variableReferenceExpression name="rules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="request"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="ExecuteServerRules">
											<target>
												<fieldReferenceExpression name="serverRules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="request"/>
												<propertyReferenceExpression name="After">
													<typeReferenceExpression type="ActionPhase"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="Merge">
									<target>
										<propertyReferenceExpression name="Result">
											<fieldReferenceExpression name="serverRules"/>
										</propertyReferenceExpression>
									</target>
									<parameters>
										<variableReferenceExpression name="page"/>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<variableReferenceExpression name="page"/>
									<methodInvokeExpression methodName="ToResult">
										<target>
											<variableReferenceExpression name="page"/>
										</target>
										<parameters>
											<fieldReferenceExpression name="config"/>
											<fieldReferenceExpression name="view"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Value">
										<variableReferenceExpression name="cacheItem"/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="page"/>
								</assignStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="page"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ResetViewPage(ViewPage) -->
						<memberMethod name="ResetViewPage">
							<attributes public="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="RequiresMetaData">
										<argumentReferenceExpression name="page"/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<variableDeclarationStatement type="SortedDictionary" name="fieldIndexes">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="System.Int32"/>
									</typeArguments>
									<init>
										<objectCreateExpression type="SortedDictionary">
											<typeArguments>
												<typeReference type="System.String"/>
												<typeReference type="System.Int32"/>
											</typeArguments>
										</objectCreateExpression>
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
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="fieldIndexes"/>
												</target>
												<indices>
													<propertyReferenceExpression name="Name">
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
													</propertyReferenceExpression>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="i"/>
										</assignStatement>
									</statements>
								</forStatement>
								<methodInvokeExpression methodName="Clear">
									<target>
										<propertyReferenceExpression name="Fields">
											<argumentReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="Clear">
									<target>
										<propertyReferenceExpression name="Categories">
											<argumentReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</target>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="PopulatePageFields">
									<parameters>
										<variableReferenceExpression name="page"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="EnsurePageFields">
									<parameters>
										<argumentReferenceExpression name="page"/>
										<fieldReferenceExpression name="expressions"/>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<propertyReferenceExpression name="FieldFilter">
										<argumentReferenceExpression name="page"/>
									</propertyReferenceExpression>
									<methodInvokeExpression methodName="RequestedFieldFilter">
										<target>
											<argumentReferenceExpression name="page"/>
										</target>
									</methodInvokeExpression>
								</assignStatement>
								<methodInvokeExpression methodName="ApplyFieldFilter">
									<parameters>
										<argumentReferenceExpression name="page"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="PopulatePageCategories">
									<parameters>
										<variableReferenceExpression name="page"/>
									</parameters>
								</methodInvokeExpression>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="NewRow">
												<argumentReferenceExpression name="page"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="NewRow">
												<argumentReferenceExpression name="page"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ReorderRowValues">
												<parameters>
													<argumentReferenceExpression name="page"/>
													<variableReferenceExpression name="fieldIndexes"/>
													<propertyReferenceExpression name="NewRow">
														<argumentReferenceExpression name="page"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Rows">
												<argumentReferenceExpression name="page"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
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
														<propertyReferenceExpression name="Rows">
															<argumentReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</test>
											<increment>
												<variableReferenceExpression name="j"/>
											</increment>
											<statements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Rows">
																<argumentReferenceExpression name="page"/>
															</propertyReferenceExpression>
														</target>
														<indices>
															<variableReferenceExpression name="j"/>
														</indices>
													</arrayIndexerExpression>
													<methodInvokeExpression methodName="ReorderRowValues">
														<parameters>
															<argumentReferenceExpression name="page"/>
															<variableReferenceExpression name="fieldIndexes"/>
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Rows">
																		<argumentReferenceExpression name="page"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<variableReferenceExpression name="j"/>
																</indices>
															</arrayIndexerExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</statements>
										</forStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ReorderRowValues(ViewPage, SortedDictionary<string, int>, object[]) -->
						<memberMethod returnType="System.Object[]" name="ReorderRowValues">
							<attributes private ="true" final="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
								<parameter type="SortedDictionary" name="indexes">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="System.Int32"/>
									</typeArguments>
								</parameter>
								<parameter type="System.Object[]" name="row"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Object[]" name="newRow">
									<init>
										<arrayCreateExpression>
											<createType type="System.Object"/>
											<sizeExpression>
												<propertyReferenceExpression name="Length">
													<argumentReferenceExpression name="row"/>
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
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="newRow"/>
												</target>
												<indices>
													<variableReferenceExpression name="i"/>
												</indices>
											</arrayIndexerExpression>
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="row"/>
												</target>
												<indices>
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="indexes"/>
														</target>
														<indices>
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="field"/>
															</propertyReferenceExpression>
														</indices>
													</arrayIndexerExpression>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
									</statements>
								</forStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="newRow"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IDataController.GetListOfValues(string, string,DistinctValueRequest)-->
						<memberMethod returnType="System.Object[]" name="GetListOfValues" privateImplementationType="IDataController">
							<attributes/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="DistinctValueRequest" name="request"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="cacheItem">
									<init>
										<objectCreateExpression type="DataCacheItem">
											<parameters>
												<argumentReferenceExpression name="controller"/>
												<argumentReferenceExpression name="request"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="HasValue">
											<variableReferenceExpression name="cacheItem"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<castExpression targetType="System.Object[]">
												<propertyReferenceExpression name="Value">
													<variableReferenceExpression name="cacheItem"/>
												</propertyReferenceExpression>
											</castExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="SelectView">
									<parameters>
										<argumentReferenceExpression name="controller"/>
										<argumentReferenceExpression name="view"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="ViewPage" name="page">
									<init>
										<objectCreateExpression type="ViewPage">
											<parameters>
												<variableReferenceExpression name="request"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="ApplyDataFilter">
									<target>
										<variableReferenceExpression name="page"/>
									</target>
									<parameters>
										<methodInvokeExpression methodName="CreateDataFilter">
											<target>
												<fieldReferenceExpression name="config"/>
											</target>
										</methodInvokeExpression>
										<argumentReferenceExpression name="controller"/>
										<argumentReferenceExpression name="view"/>
										<propertyReferenceExpression name="LookupContextController">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="LookupContextView">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="LookupContextFieldName">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="List" name="distinctValues">
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
								<variableDeclarationStatement type="BusinessRules" name="rules">
									<init>
										<methodInvokeExpression methodName="CreateBusinessRules">
											<target>
												<fieldReferenceExpression name="config"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<fieldReferenceExpression name="serverRules"/>
									<variableReferenceExpression name="rules"/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="serverRules"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="serverRules"/>
											<methodInvokeExpression methodName="CreateBusinessRules"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="Page">
										<fieldReferenceExpression name="serverRules"/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="page"/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="rules"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="BeforeSelect">
											<target>
												<variableReferenceExpression name="rules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="request"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="ExecuteServerRules">
											<target>
												<fieldReferenceExpression name="serverRules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="request"/>
												<propertyReferenceExpression name="Before">
													<typeReferenceExpression type="ActionPhase"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="EnableResultSet">
											<fieldReferenceExpression name="serverRules"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="IDataReader" name="reader">
											<init>
												<methodInvokeExpression methodName="ExecuteResultSetReader">
													<parameters>
														<variableReferenceExpression name="page"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="SortedDictionary" name="uniqueValues">
											<typeArguments>
												<typeReference type="System.Object"/>
												<typeReference type="System.Object"/>
											</typeArguments>
											<init>
												<objectCreateExpression type="SortedDictionary">
													<typeArguments>
														<typeReference type="System.Object"/>
														<typeReference type="System.Object"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Boolean" name="hasNull">
											<init>
												<primitiveExpression value="false"/>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<methodInvokeExpression methodName="Read">
													<target>
														<variableReferenceExpression name="reader"/>
													</target>
												</methodInvokeExpression>
											</test>
											<statements>
												<variableDeclarationStatement type="System.Object" name="v">
													<init>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="reader"/>
															</target>
															<indices>
																<propertyReferenceExpression name="FieldName">
																	<variableReferenceExpression name="request"/>
																</propertyReferenceExpression>
															</indices>
														</arrayIndexerExpression>
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
															<variableReferenceExpression name="hasNull"/>
															<primitiveExpression value="true"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="uniqueValues"/>
																</target>
																<indices>
																	<variableReferenceExpression name="v"/>
																</indices>
															</arrayIndexerExpression>
															<variableReferenceExpression name="v"/>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
											</statements>
										</whileStatement>
										<conditionStatement>
											<condition>
												<variableReferenceExpression name="hasNull"/>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="distinctValues"/>
													</target>
													<parameters>
														<primitiveExpression value="null"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<foreachStatement>
											<variable type="System.Object" name="v"/>
											<target>
												<propertyReferenceExpression name="Keys">
													<variableReferenceExpression name="uniqueValues"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="LessThan">
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="distinctValues"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="PageSize">
																<variableReferenceExpression name="page"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="distinctValues"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ConvertObjectToValue">
																	<parameters>
																		<variableReferenceExpression name="v"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<breakStatement/>
													</falseStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
									<falseStatements>
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
												<variableDeclarationStatement type="DbCommand" name="command">
													<init>
														<methodInvokeExpression methodName="CreateCommand">
															<parameters>
																<variableReferenceExpression name="connection"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="ConfigureCommand">
													<parameters>
														<variableReferenceExpression name="command"/>
														<variableReferenceExpression name="page"/>
														<propertyReferenceExpression name="SelectDistinct">
															<typeReferenceExpression type="CommandConfigurationType"/>
														</propertyReferenceExpression>
														<primitiveExpression value="null"/>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement type="DbDataReader" name="reader">
													<init>
														<methodInvokeExpression methodName="ExecuteReader">
															<target>
																<variableReferenceExpression name="command"/>
															</target>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<whileStatement>
													<test>
														<binaryOperatorExpression operator="BooleanAnd">
															<methodInvokeExpression methodName="Read">
																<target>
																	<variableReferenceExpression name="reader"/>
																</target>
															</methodInvokeExpression>
															<binaryOperatorExpression operator="LessThan">
																<propertyReferenceExpression name="Count">
																	<variableReferenceExpression name="distinctValues"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="PageSize">
																	<argumentReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</test>
													<statements>
														<variableDeclarationStatement type="System.Object" name="v">
															<init>
																<methodInvokeExpression methodName="GetValue">
																	<target>
																		<variableReferenceExpression name="reader"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="0"/>
																	</parameters>
																</methodInvokeExpression>
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
																<assignStatement>
																	<variableReferenceExpression name="v"/>
																	<methodInvokeExpression methodName="ConvertObjectToValue">
																		<parameters>
																			<variableReferenceExpression name="v"/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
																<!--<conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="IsTypeOf">
                                  <variableReferenceExpression name="v"/>
                                  <typeReferenceExpression type="TimeSpan"/>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <variableReferenceExpression name="v"/>
                                  <methodInvokeExpression methodName="ToString">
                                    <target>
                                      <variableReferenceExpression name="v"/>
                                    </target>
                                  </methodInvokeExpression>
                                </assignStatement>
                              </trueStatements>
                            </conditionStatement>-->
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="distinctValues"/>
															</target>
															<parameters>
																<variableReferenceExpression name="v"/>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</whileStatement>
												<methodInvokeExpression methodName="Close">
													<target>
														<variableReferenceExpression name="reader"/>
													</target>
												</methodInvokeExpression>
											</statements>
										</usingStatement>
									</falseStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="rules"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AfterSelect">
											<target>
												<variableReferenceExpression name="rules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="request"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
									<falseStatements>
										<methodInvokeExpression methodName="ExecuteServerRules">
											<target>
												<fieldReferenceExpression name="serverRules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="request"/>
												<propertyReferenceExpression name="After">
													<typeReferenceExpression type="ActionPhase"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</falseStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.Object[]" name="result">
									<init>
										<methodInvokeExpression methodName="ToArray">
											<target>
												<variableReferenceExpression name="distinctValues"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="EnsureJsonCompatibility">
									<parameters>
										<variableReferenceExpression name="result"/>
									</parameters>
								</methodInvokeExpression>
								<assignStatement>
									<propertyReferenceExpression name="Value">
										<variableReferenceExpression name="cacheItem"/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="result"/>
								</assignStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IDataController.Execute(string, string, ActionArgs) -->
						<memberMethod returnType="ActionResult" name="Execute" privateImplementationType="IDataController">
							<attributes/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="ActionArgs" name="args"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ActionResult" name="result">
									<init>
										<objectCreateExpression type="ActionResult"/>
									</init>
								</variableDeclarationStatement>
								<!--
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="ExecuteWithPivot">
                      <parameters>
                        <argumentReferenceExpression name="controller"/>
                        <argumentReferenceExpression name="view"/>
                        <argumentReferenceExpression name="args"/>
                        <variableReferenceExpression name="result"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <variableReferenceExpression name="result"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>-->
								<methodInvokeExpression methodName="SelectView">
									<parameters>
										<argumentReferenceExpression name="controller"/>
										<argumentReferenceExpression name="view"/>
									</parameters>
								</methodInvokeExpression>
								<tryStatement>
									<statements>
										<!--<methodInvokeExpression methodName="ValidateArguments">
                      <parameters>
                        <argumentReferenceExpression name="args"/>
                      </parameters>
                    </methodInvokeExpression>-->
										<assignStatement>
											<fieldReferenceExpression name="serverRules"/>
											<methodInvokeExpression methodName="CreateBusinessRules">
												<target>
													<fieldReferenceExpression name="config"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<fieldReferenceExpression name="serverRules"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<fieldReferenceExpression name="serverRules"/>
													<methodInvokeExpression methodName="CreateBusinessRules"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="IActionHandler" name="handler">
											<init>
												<castExpression targetType="IActionHandler">
													<fieldReferenceExpression name="serverRules"/>
												</castExpression>
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
												<methodInvokeExpression methodName="PreProcessArguments">
													<target>
														<propertyReferenceExpression name="PlugIn">
															<fieldReferenceExpression name="config"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<argumentReferenceExpression name="args"/>
														<variableReferenceExpression name="result"/>
														<methodInvokeExpression methodName="CreateViewPage"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="EnsureFieldValues">
											<parameters>
												<variableReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueInequality">
													<propertyReferenceExpression name="SqlCommandType">
														<argumentReferenceExpression name="args"/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="None">
														<typeReferenceExpression type="CommandConfigurationType"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<xsl:if test="$IsUnlimited='true' and (contains($Auditing, 'Modified') or contains($Auditing, 'Created'))">
													<methodInvokeExpression methodName="Process">
														<target>
															<typeReferenceExpression type="{$Namespace}.Security.EventTracker"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="args"/>
															<fieldReferenceExpression name="_config"/>
														</parameters>
													</methodInvokeExpression>
												</xsl:if>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="IsBatchEditOrDelete">
															<argumentReferenceExpression name="args"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="ViewPage" name="page">
															<init>
																<methodInvokeExpression methodName="CreateViewPage"/>
															</init>
														</variableDeclarationStatement>
														<methodInvokeExpression methodName="PopulatePageFields">
															<parameters>
																<variableReferenceExpression name="page"/>
															</parameters>
														</methodInvokeExpression>
														<foreachStatement>
															<variable type="System.String" name="sv"/>
															<target>
																<propertyReferenceExpression name="SelectedValues">
																	<argumentReferenceExpression name="args"/>
																</propertyReferenceExpression>
															</target>
															<statements>
																<assignStatement>
																	<propertyReferenceExpression name="Canceled">
																		<variableReferenceExpression name="result"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="false"/>
																</assignStatement>
																<methodInvokeExpression methodName="ClearBlackAndWhiteLists">
																	<target>
																		<fieldReferenceExpression name="serverRules"/>
																	</target>
																</methodInvokeExpression>
																<variableDeclarationStatement type="System.String[]" name="key">
																	<init>
																		<methodInvokeExpression methodName="Split">
																			<target>
																				<variableReferenceExpression name="sv"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="," convertTo="Char"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="System.Int32" name="keyIndex">
																	<init>
																		<primitiveExpression value="0"/>
																	</init>
																</variableDeclarationStatement>
																<foreachStatement>
																	<variable type="FieldValue" name="v"/>
																	<target>
																		<propertyReferenceExpression name="OriginalFieldValues"/>
																	</target>
																	<statements>
																		<variableDeclarationStatement type="DataField" name="field">
																			<init>
																				<methodInvokeExpression methodName="FindField">
																					<target>
																						<variableReferenceExpression name="page"/>
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
																				<binaryOperatorExpression operator="IdentityInequality">
																					<variableReferenceExpression name="field"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<conditionStatement>
																					<condition>
																						<unaryOperatorExpression operator="Not">
																							<propertyReferenceExpression name="IsPrimaryKey">
																								<variableReferenceExpression name="field"/>
																							</propertyReferenceExpression>
																						</unaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<propertyReferenceExpression name="Modified">
																								<variableReferenceExpression name="v"/>
																							</propertyReferenceExpression>
																							<primitiveExpression value="true"/>
																						</assignStatement>
																					</trueStatements>
																					<falseStatements>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="Name">
																										<variableReferenceExpression name="v"/>
																									</propertyReferenceExpression>
																									<propertyReferenceExpression name="Name">
																										<variableReferenceExpression name="field"/>
																									</propertyReferenceExpression>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<assignStatement>
																									<propertyReferenceExpression name="OldValue">
																										<variableReferenceExpression name="v"/>
																									</propertyReferenceExpression>
																									<arrayIndexerExpression>
																										<target>
																											<variableReferenceExpression name="key"/>
																										</target>
																										<indices>
																											<variableReferenceExpression name="keyIndex"/>
																										</indices>
																									</arrayIndexerExpression>
																								</assignStatement>
																								<assignStatement>
																									<propertyReferenceExpression name="Modified">
																										<variableReferenceExpression name="v"/>
																									</propertyReferenceExpression>
																									<primitiveExpression value="false"/>
																								</assignStatement>
																								<assignStatement>
																									<variableReferenceExpression name="keyIndex"/>
																									<binaryOperatorExpression operator="Add">
																										<variableReferenceExpression name="keyIndex"/>
																										<primitiveExpression value="1"/>
																									</binaryOperatorExpression>
																								</assignStatement>
																							</trueStatements>
																						</conditionStatement>
																					</falseStatements>
																				</conditionStatement>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
																<usingStatement>
																	<variable type="DataConnection" name="connection">
																		<init>
																			<methodInvokeExpression methodName="CreateConnection">
																				<parameters>
																					<thisReferenceExpression/>
																					<primitiveExpression value="true"/>
																				</parameters>
																			</methodInvokeExpression>
																		</init>
																	</variable>
																	<statements>
																		<tryStatement>
																			<statements>
																				<variableDeclarationStatement type="DbCommand" name="command">
																					<init>
																						<methodInvokeExpression methodName="CreateCommand">
																							<parameters>
																								<variableReferenceExpression name="connection"/>
																								<argumentReferenceExpression name="args"/>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<methodInvokeExpression methodName="ExecutePreActionCommands">
																					<parameters>
																						<argumentReferenceExpression name="args"/>
																						<variableReferenceExpression name="result"/>
																						<variableReferenceExpression name="connection"/>
																					</parameters>
																				</methodInvokeExpression>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="IdentityInequality">
																							<variableReferenceExpression name="handler"/>
																							<primitiveExpression value="null"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="BeforeSqlAction">
																							<target>
																								<variableReferenceExpression name="handler"/>
																							</target>
																							<parameters>
																								<argumentReferenceExpression name="args"/>
																								<variableReferenceExpression name="result"/>
																							</parameters>
																						</methodInvokeExpression>
																					</trueStatements>
																					<falseStatements>
																						<methodInvokeExpression methodName="ExecuteServerRules">
																							<target>
																								<fieldReferenceExpression name="serverRules"/>
																							</target>
																							<parameters>
																								<argumentReferenceExpression name="args"/>
																								<argumentReferenceExpression name="result"/>
																								<propertyReferenceExpression name="Before">
																									<typeReferenceExpression type="ActionPhase"/>
																								</propertyReferenceExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</falseStatements>
																				</conditionStatement>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="BooleanAnd">
																							<binaryOperatorExpression operator="ValueEquality">
																								<propertyReferenceExpression name="Count">
																									<propertyReferenceExpression name="Errors">
																										<variableReferenceExpression name="result"/>
																									</propertyReferenceExpression>
																								</propertyReferenceExpression>
																								<primitiveExpression value="0"/>
																							</binaryOperatorExpression>
																							<unaryOperatorExpression operator="Not">
																								<propertyReferenceExpression name="Canceled">
																									<variableReferenceExpression name="result"/>
																								</propertyReferenceExpression>
																							</unaryOperatorExpression>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueInequality">
																									<propertyReferenceExpression name="CommandName">
																										<variableReferenceExpression name="args"/>
																									</propertyReferenceExpression>
																									<primitiveExpression value="Delete"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="ProcessOneToOneFields">
																									<parameters>
																										<variableReferenceExpression name="args"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="CommandName">
																										<variableReferenceExpression name="args"/>
																									</propertyReferenceExpression>
																									<primitiveExpression value="Delete"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="ProcessManyToManyFields">
																									<parameters>
																										<argumentReferenceExpression name="args"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																						<variableDeclarationStatement type="System.Int32" name="rowsAffected">
																							<init>
																								<primitiveExpression value="1"/>
																							</init>
																						</variableDeclarationStatement>
																						<conditionStatement>
																							<condition>
																								<methodInvokeExpression methodName="ConfigureCommand">
																									<parameters>
																										<variableReferenceExpression name="command"/>
																										<primitiveExpression value="null"/>
																										<propertyReferenceExpression name="SqlCommandType">
																											<variableReferenceExpression name="args"/>
																										</propertyReferenceExpression>
																										<propertyReferenceExpression name="Values">
																											<argumentReferenceExpression name="args"/>
																										</propertyReferenceExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</condition>
																							<trueStatements>
																								<assignStatement>
																									<variableReferenceExpression name="rowsAffected"/>
																									<methodInvokeExpression methodName="ExecuteNonQuery">
																										<target>
																											<variableReferenceExpression name="command"/>
																										</target>
																									</methodInvokeExpression>
																								</assignStatement>
																							</trueStatements>
																						</conditionStatement>
																						<assignStatement>
																							<propertyReferenceExpression name="RowsAffected">
																								<variableReferenceExpression name="result"/>
																							</propertyReferenceExpression>
																							<binaryOperatorExpression operator="Add">
																								<propertyReferenceExpression name="RowsAffected">
																									<variableReferenceExpression name="result"/>
																								</propertyReferenceExpression>
																								<variableReferenceExpression name="rowsAffected"/>
																							</binaryOperatorExpression>
																						</assignStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="CommandName">
																										<variableReferenceExpression name="args"/>
																									</propertyReferenceExpression>
																									<primitiveExpression value="Update"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="ProcessManyToManyFields">
																									<parameters>
																										<argumentReferenceExpression name="args"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="CommandName">
																										<variableReferenceExpression name="args"/>
																									</propertyReferenceExpression>
																									<primitiveExpression value="Delete"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="ProcessOneToOneFields">
																									<parameters>
																										<variableReferenceExpression name="args"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																						<conditionStatement>
																							<condition>
																								<binaryOperatorExpression operator="IdentityInequality">
																									<variableReferenceExpression name="handler"/>
																									<primitiveExpression value="null"/>
																								</binaryOperatorExpression>
																							</condition>
																							<trueStatements>
																								<methodInvokeExpression methodName="AfterSqlAction">
																									<target>
																										<variableReferenceExpression name="handler"/>
																									</target>
																									<parameters>
																										<argumentReferenceExpression name="args"/>
																										<variableReferenceExpression name="result"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																							<falseStatements>
																								<methodInvokeExpression methodName="ExecuteServerRules">
																									<target>
																										<fieldReferenceExpression name="serverRules"/>
																									</target>
																									<parameters>
																										<argumentReferenceExpression name="args"/>
																										<argumentReferenceExpression name="result"/>
																										<propertyReferenceExpression name="After">
																											<typeReferenceExpression type="ActionPhase"/>
																										</propertyReferenceExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</falseStatements>
																						</conditionStatement>
																						<methodInvokeExpression methodName="Clear">
																							<target>
																								<propertyReferenceExpression name="Parameters">
																									<variableReferenceExpression name="command"/>
																								</propertyReferenceExpression>
																							</target>
																						</methodInvokeExpression>
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
																								<methodInvokeExpression methodName="ProcessArguments">
																									<target>
																										<propertyReferenceExpression name="PlugIn">
																											<fieldReferenceExpression name="config"/>
																										</propertyReferenceExpression>
																									</target>
																									<parameters>
																										<argumentReferenceExpression name="args"/>
																										<variableReferenceExpression name="result"/>
																										<variableReferenceExpression name="page"/>
																									</parameters>
																								</methodInvokeExpression>
																							</trueStatements>
																						</conditionStatement>
																					</trueStatements>
																				</conditionStatement>
																			</statements>
																			<catch exceptionType="Exception" localName="ex">
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="BooleanAnd">
																							<propertyReferenceExpression name="CanClose">
																								<variableReferenceExpression name="connection"/>
																							</propertyReferenceExpression>
																							<binaryOperatorExpression operator="IsTypeOf">
																								<variableReferenceExpression name="connection"/>
																								<typeReferenceExpression type="DataTransaction"/>
																							</binaryOperatorExpression>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="Rollback">
																							<target>
																								<castExpression targetType="DataTransaction">
																									<variableReferenceExpression name="connection"/>
																								</castExpression>
																							</target>
																						</methodInvokeExpression>
																					</trueStatements>
																				</conditionStatement>
																				<throwExceptionStatement>
																					<variableReferenceExpression name="ex"/>
																				</throwExceptionStatement>
																			</catch>
																		</tryStatement>
																	</statements>
																</usingStatement>
																<conditionStatement>
																	<condition>
																		<propertyReferenceExpression name="CanceledSelectedValues">
																			<variableReferenceExpression name="result"/>
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
														<usingStatement>
															<variable type="DataConnection" name="connection">
																<init>
																	<methodInvokeExpression methodName="CreateConnection">
																		<parameters>
																			<thisReferenceExpression/>
																			<primitiveExpression value="true"/>
																		</parameters>
																	</methodInvokeExpression>
																</init>
															</variable>
															<statements>
																<tryStatement>
																	<statements>
																		<variableDeclarationStatement type="DbCommand" name="command">
																			<init>
																				<methodInvokeExpression methodName="CreateCommand">
																					<parameters>
																						<variableReferenceExpression name="connection"/>
																						<argumentReferenceExpression name="args"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<methodInvokeExpression methodName="ExecutePreActionCommands">
																			<parameters>
																				<argumentReferenceExpression name="args"/>
																				<variableReferenceExpression name="result"/>
																				<variableReferenceExpression name="connection"/>
																			</parameters>
																		</methodInvokeExpression>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityInequality">
																					<variableReferenceExpression name="handler"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="BeforeSqlAction">
																					<target>
																						<variableReferenceExpression name="handler"/>
																					</target>
																					<parameters>
																						<argumentReferenceExpression name="args"/>
																						<variableReferenceExpression name="result"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																			<falseStatements>
																				<methodInvokeExpression methodName="ExecuteServerRules">
																					<target>
																						<fieldReferenceExpression name="serverRules"/>
																					</target>
																					<parameters>
																						<argumentReferenceExpression name="args"/>
																						<argumentReferenceExpression name="result"/>
																						<propertyReferenceExpression name="Before">
																							<typeReferenceExpression type="ActionPhase"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</falseStatements>
																		</conditionStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanAnd">
																					<binaryOperatorExpression operator="ValueEquality">
																						<propertyReferenceExpression name="Count">
																							<propertyReferenceExpression name="Errors">
																								<variableReferenceExpression name="result"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																						<primitiveExpression value="0"/>
																					</binaryOperatorExpression>
																					<unaryOperatorExpression operator="Not">
																						<propertyReferenceExpression name="Canceled">
																							<variableReferenceExpression name="result"/>
																						</propertyReferenceExpression>
																					</unaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<!--<xsl:choose>
                                      <xsl:when test="$EnableTransactions='true'">
                                        <usingStatement>
                                          <variable type="SinglePhaseTransactionScope" name="scope">
                                            <init>
                                              <objectCreateExpression type="SinglePhaseTransactionScope"/>
                                            </init>
                                          </variable>
                                          <statements>
                                            <conditionStatement>
                                              <condition>
                                                <unaryOperatorExpression operator="Not">
                                                  <methodInvokeExpression methodName="InTransaction">
                                                    <target>
                                                      <typeReferenceExpression type="TransactionManager"/>
                                                    </target>
                                                    <parameters>
                                                      <argumentReferenceExpression name="args"/>
                                                    </parameters>
                                                  </methodInvokeExpression>
                                                </unaryOperatorExpression>
                                              </condition>
                                              <trueStatements>
                                                <methodInvokeExpression methodName="Enlist">
                                                  <target>
                                                    <variableReferenceExpression name="scope"/>
                                                  </target>
                                                  <parameters>
                                                    <variableReferenceExpression name="command"/>
                                                  </parameters>
                                                </methodInvokeExpression>
                                              </trueStatements>
                                            </conditionStatement>
                                            <xsl:call-template name="ExecuteCommand"/>
                                            <methodInvokeExpression methodName="Complete">
                                              <target>
                                                <typeReferenceExpression type="TransactionManager"/>
                                              </target>
                                              <parameters>
                                                <argumentReferenceExpression name="args"/>
                                                <variableReferenceExpression name="result"/>
                                                <methodInvokeExpression methodName="CreateViewPage"/>
                                              </parameters>
                                            </methodInvokeExpression>
                                            <methodInvokeExpression methodName="Complete">
                                              <target>
                                                <variableReferenceExpression name="scope"/>
                                              </target>
                                            </methodInvokeExpression>
                                          </statements>
                                        </usingStatement>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:call-template name="ExecuteCommand"/>
                                      </xsl:otherwise>
                                    </xsl:choose>-->
																				<xsl:call-template name="ExecuteCommand"/>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																	<catch exceptionType="Exception" localName="ex">
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="BooleanAnd">
																					<propertyReferenceExpression name="CanClose">
																						<variableReferenceExpression name="connection"/>
																					</propertyReferenceExpression>
																					<binaryOperatorExpression operator="IsTypeOf">
																						<variableReferenceExpression name="connection"/>
																						<typeReferenceExpression type="DataTransaction"/>
																					</binaryOperatorExpression>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Rollback">
																					<target>
																						<castExpression targetType="DataTransaction">
																							<variableReferenceExpression name="connection"/>
																						</castExpression>
																					</target>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																		<throwExceptionStatement>
																			<variableReferenceExpression name="ex"/>
																		</throwExceptionStatement>
																	</catch>
																</tryStatement>
															</statements>
														</usingStatement>
													</falseStatements>
												</conditionStatement>

											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Equals">
															<target>
																<propertyReferenceExpression name="CommandName">
																	<argumentReferenceExpression name="args"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<primitiveExpression value="PopulateDynamicLookups"/>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="PopulateDynamicLookups">
															<parameters>
																<argumentReferenceExpression name="args"/>
																<argumentReferenceExpression name="result"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="Equals">
																	<target>
																		<propertyReferenceExpression name="CommandName">
																			<argumentReferenceExpression name="args"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="ProcessImportFile"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Execute">
																	<target>
																		<typeReferenceExpression type="ImportProcessor"/>
																	</target>
																	<parameters>
																		<argumentReferenceExpression name="args"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="Equals">
																			<target>
																				<propertyReferenceExpression name="CommandName">
																					<argumentReferenceExpression name="args"/>
																				</propertyReferenceExpression>
																			</target>
																			<parameters>
																				<primitiveExpression value="Execute"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
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
																				<variableDeclarationStatement type="DbCommand" name="command">
																					<init>
																						<methodInvokeExpression methodName="CreateCommand">
																							<parameters>
																								<variableReferenceExpression name="connection"/>
																								<argumentReferenceExpression name="args"/>
																							</parameters>
																						</methodInvokeExpression>
																					</init>
																				</variableDeclarationStatement>
																				<methodInvokeExpression methodName="ExecuteNonQuery">
																					<target>
																						<variableReferenceExpression name="command"/>
																					</target>
																				</methodInvokeExpression>
																			</statements>
																		</usingStatement>
																	</trueStatements>
																	<falseStatements>
																		<methodInvokeExpression methodName="ProcessSpecialActions">
																			<target>
																				<fieldReferenceExpression name="serverRules"/>
																			</target>
																			<parameters>
																				<argumentReferenceExpression name="args"/>
																				<argumentReferenceExpression name="result"/>
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
									</statements>
									<catch exceptionType="Exception" localName="ex">
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IsTypeOf">
													<variableReferenceExpression name="ex"/>
													<typeReferenceExpression type="System.Reflection.TargetInvocationException"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="ex"/>
													<propertyReferenceExpression name="InnerException">
														<variableReferenceExpression name="ex"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="HandleException">
											<parameters>
												<variableReferenceExpression name="ex"/>
												<argumentReferenceExpression name="args"/>
												<argumentReferenceExpression name="result"/>
											</parameters>
										</methodInvokeExpression>
									</catch>
								</tryStatement>
								<methodInvokeExpression methodName="EnsureJsonCompatibility">
									<target>
										<variableReferenceExpression name="result"/>
									</target>
								</methodInvokeExpression>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- field originalFieldValues-->
						<memberField type="FieldValue[]" name="originalFieldValues"/>
						<!-- property OriginalFieldValues-->
						<memberProperty type="FieldValue[]" name="OriginalFieldValues">
							<attributes family="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="originalFieldValues"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method EnsureFieldValues(ActionArgs args)-->
						<memberMethod name="EnsureFieldValues">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="originalFieldValues"/>
									<propertyReferenceExpression name="Values">
										<variableReferenceExpression name="args"/>
									</propertyReferenceExpression>
								</assignStatement>
								<variableDeclarationStatement type="ViewPage" name="page">
									<init>
										<methodInvokeExpression methodName="CreateViewPage"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Controller">
										<variableReferenceExpression name="page"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="Controller">
										<argumentReferenceExpression name="args"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="View">
										<variableReferenceExpression name="page"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="View">
										<argumentReferenceExpression name="args"/>
									</propertyReferenceExpression>
								</assignStatement>

								<!--<variableDeclarationStatement type="SortedDictionary" name="fieldValues">
                  <typeArguments>
                    <typeReference type="System.String"/>
                    <typeReference type="FieldValue"/>
                  </typeArguments>
                  <init>
                    <objectCreateExpression type="SortedDictionary">
                      <typeArguments>
                        <typeReference type="System.String"/>
                        <typeReference type="FieldValue"/>
                      </typeArguments>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>-->
								<variableDeclarationStatement type="FieldValueDictionary" name="fieldValues">
									<init>
										<objectCreateExpression type="FieldValueDictionary"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<propertyReferenceExpression name="Values">
												<variableReferenceExpression name="args"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="Values">
												<variableReferenceExpression name="args"/>
											</propertyReferenceExpression>
											<arrayCreateExpression>
												<createType type="FieldValue"/>
												<initializers></initializers>
											</arrayCreateExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Length">
												<propertyReferenceExpression name="Values">
													<variableReferenceExpression name="args"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AddRange">
											<target>
												<variableReferenceExpression name="fieldValues"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Values">
													<argumentReferenceExpression name="args"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<!--<foreachStatement>
                      <variable type="FieldValue" name="fv"/>
                      <target>
                        <propertyReferenceExpression name="Values">
                          <variableReferenceExpression name="args"/>
                        </propertyReferenceExpression>
                      </target>
                      <statements>
                        <assignStatement>
                          <arrayIndexerExpression>
                            <target>
                              <variableReferenceExpression name="fieldValues"/>
                            </target>
                            <indices>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="fv"/>
                              </propertyReferenceExpression>
                            </indices>
                          </arrayIndexerExpression>
                          <variableReferenceExpression name="fv"/>
                        </assignStatement>
                      </statements>
                    </foreachStatement>-->
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="List" name="missingValues">
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
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="ContainsKey">
														<target>
															<variableReferenceExpression name="fieldValues"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="f"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="missingValues"/>
													</target>
													<parameters>
														<objectCreateExpression type="FieldValue">
															<parameters>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="f"/>
																</propertyReferenceExpression>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Count">
												<variableReferenceExpression name="missingValues"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="List" name="newValues">
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
															<variableReferenceExpression name="args"/>
														</propertyReferenceExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="AddRange">
											<target>
												<variableReferenceExpression name="newValues"/>
											</target>
											<parameters>
												<variableReferenceExpression name="missingValues"/>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<propertyReferenceExpression name="Values">
												<variableReferenceExpression name="args"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToArray">
												<target>
													<variableReferenceExpression name="newValues"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method SupportsLimitInSelect(DbCommand) -->
						<memberMethod returnType="System.Boolean" name="SupportsLimitInSelect">
							<attributes private="true"/>
							<parameters>
								<parameter type="System.Object" name="command"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Contains">
										<target>
											<methodInvokeExpression methodName="ToString">
												<target>
													<argumentReferenceExpression name="command"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<primitiveExpression value="MySql"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SupportsSkipInSelect(DbCommand) -->
						<memberMethod returnType="System.Boolean" name="SupportsSkipInSelect">
							<attributes private="true"/>
							<parameters>
								<parameter type="System.Object" name="command"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Contains">
										<target>
											<methodInvokeExpression methodName="ToString">
												<target>
													<argumentReferenceExpression name="command"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<primitiveExpression value="Firebird"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SyncRequestedPage(PageRequest, ViewPage, DataConnection -->
						<memberMethod name="SyncRequestedPage">
							<attributes family="true"/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
								<parameter type="DataConnection" name="connection"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="BooleanOr">
												<binaryOperatorExpression operator="IdentityEquality">
													<propertyReferenceExpression name="SyncKey">
														<argumentReferenceExpression name="request"/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="Length">
														<propertyReferenceExpression name="SyncKey">
															<argumentReferenceExpression name="request"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="LessThan">
												<propertyReferenceExpression name="PageSize">
													<argumentReferenceExpression name="page"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement/>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="DbCommand" name="syncCommand">
									<init>
										<methodInvokeExpression methodName="CreateCommand">
											<parameters>
												<argumentReferenceExpression name="connection"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="ConfigureCommand">
									<parameters>
										<variableReferenceExpression name="syncCommand"/>
										<argumentReferenceExpression name="page"/>
										<propertyReferenceExpression name="Sync">
											<typeReferenceExpression type="CommandConfigurationType"/>
										</propertyReferenceExpression>
										<primitiveExpression value="null"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="List" name="keyFields">
									<typeArguments>
										<typeReference type="DataField"/>
									</typeArguments>
									<init>
										<methodInvokeExpression methodName="EnumerateSyncFields">
											<target>
												<argumentReferenceExpression name="page"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<!--<variableDeclarationStatement type="Dictionary" name="keyFields">
                  <typeArguments>
                    <typeReference type="System.Int32"/>
                    <typeReference type="DataField"/>
                  </typeArguments>
                  <init>
                    <objectCreateExpression type="Dictionary">
                      <typeArguments>
                        <typeReference type="System.Int32"/>
                        <typeReference type="DataField"/>
                      </typeArguments>
                    </objectCreateExpression>
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
                    <conditionStatement>
                      <condition>
                        <propertyReferenceExpression name="IsPrimaryKey">
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
                        </propertyReferenceExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <variableReferenceExpression name="keyFields"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="i"/>
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
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </forStatement>-->
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="GreaterThan">
												<propertyReferenceExpression name="Count">
													<variableReferenceExpression name="keyFields"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<propertyReferenceExpression name="Count">
													<variableReferenceExpression name="keyFields"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="Length">
													<propertyReferenceExpression name="SyncKey">
														<argumentReferenceExpression name="request"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.Boolean" name="useSkip">
											<init>
												<binaryOperatorExpression operator="BooleanOr">
													<propertyReferenceExpression name="EnableResultSet">
														<fieldReferenceExpression name="serverRules"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="SupportsSkipInSelect">
														<parameters>
															<variableReferenceExpression name="syncCommand"/>
														</parameters>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<variableReferenceExpression name="useSkip"/>
												</unaryOperatorExpression>
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
																<variableReferenceExpression name="keyFields"/>
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
																		<variableReferenceExpression name="keyFields"/>
																	</target>
																	<indices>
																		<variableReferenceExpression name="i"/>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<!--<variableDeclarationStatement type="DataField" name="field">
                          <init>
                            <methodInvokeExpression methodName="ElementAt">
                              <typeArguments>
                                <typeReference type="DataField"/>
                              </typeArguments>
                              <target>
                                <propertyReferenceExpression name="Values">
                                  <variableReferenceExpression name="keyFields"/>
                                </propertyReferenceExpression>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="i"/>
                              </parameters>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>-->
														<variableDeclarationStatement type="DbParameter" name="p">
															<init>
																<methodInvokeExpression methodName="CreateParameter">
																	<target>
																		<variableReferenceExpression name="syncCommand"/>
																	</target>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<propertyReferenceExpression name="ParameterName">
																<variableReferenceExpression name="p"/>
															</propertyReferenceExpression>
															<stringFormatExpression format="{{0}}PrimaryKey_{{1}}">
																<fieldReferenceExpression name="parameterMarker"/>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
															</stringFormatExpression>
														</assignStatement>
														<tryStatement>
															<statements>
																<methodInvokeExpression methodName="AssignParameterValue">
																	<parameters>
																		<variableReferenceExpression name="p"/>
																		<variableReferenceExpression name="field"/>
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="SyncKey">
																					<argumentReferenceExpression name="request"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<variableReferenceExpression name="i"/>
																			</indices>
																		</arrayIndexerExpression>
																	</parameters>
																</methodInvokeExpression>
															</statements>
															<catch exceptionType="Exception">
																<methodReturnStatement/>
															</catch>
														</tryStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<propertyReferenceExpression name="Parameters">
																	<variableReferenceExpression name="syncCommand"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="p"/>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</forStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="DbDataReader" name="reader"/>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="EnableResultSet">
													<fieldReferenceExpression name="serverRules"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="reader"/>
													<methodInvokeExpression methodName="ExecuteResultSetReader">
														<parameters>
															<argumentReferenceExpression name="page"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="reader"/>
													<methodInvokeExpression methodName="ExecuteReader">
														<target>
															<variableReferenceExpression name="syncCommand"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<variableReferenceExpression name="useSkip"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="Read">
															<target>
																<variableReferenceExpression name="reader"/>
															</target>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="System.Int64" name="rowIndex">
															<init>
																<convertExpression to="Int64">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="reader"/>
																		</target>
																		<indices>
																			<primitiveExpression value="0"/>
																		</indices>
																	</arrayIndexerExpression>
																</convertExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<propertyReferenceExpression name="PageIndex">
																<argumentReferenceExpression name="page"/>
															</propertyReferenceExpression>
															<convertExpression to="Int32">
																<methodInvokeExpression methodName="Floor">
																	<target>
																		<typeReferenceExpression type="Math"/>
																	</target>
																	<parameters>
																		<binaryOperatorExpression operator="Divide">
																			<convertExpression to="Double">
																				<binaryOperatorExpression operator="Subtract">
																					<variableReferenceExpression name="rowIndex"/>
																					<primitiveExpression value="1"/>
																				</binaryOperatorExpression>
																			</convertExpression>
																			<convertExpression to="Double">
																				<propertyReferenceExpression name="PageSize">
																					<argumentReferenceExpression name="page"/>
																				</propertyReferenceExpression>
																			</convertExpression>
																		</binaryOperatorExpression>
																	</parameters>
																</methodInvokeExpression>
															</convertExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="PageOffset">
																<argumentReferenceExpression name="page"/>
															</propertyReferenceExpression>
															<primitiveExpression value="0"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<variableDeclarationStatement type="System.Int64" name="rowIndex">
													<init>
														<primitiveExpression value="1"/>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="List" name="keyFieldIndexes">
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
													<variable type="DataField" name="pkField"/>
													<target>
														<variableReferenceExpression name="keyFields"/>
													</target>
													<statements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="keyFieldIndexes"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="GetOrdinal">
																	<target>
																		<variableReferenceExpression name="reader"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="pkField"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
												<whileStatement>
													<test>
														<methodInvokeExpression methodName="Read">
															<target>
																<variableReferenceExpression name="reader"/>
															</target>
														</methodInvokeExpression>
													</test>
													<statements>
														<variableDeclarationStatement type="System.Int32" name="matchCount">
															<init>
																<primitiveExpression value="0"/>
															</init>
														</variableDeclarationStatement>
														<foreachStatement>
															<variable type="System.Int32" name="primaryKeyFieldIndex"/>
															<target>
																<variableReferenceExpression name="keyFieldIndexes"/>
															</target>
															<statements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<convertExpression to="String">
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="reader"/>
																					</target>
																					<indices>
																						<variableReferenceExpression name="primaryKeyFieldIndex"/>
																					</indices>
																				</arrayIndexerExpression>
																			</convertExpression>
																			<convertExpression to="String">
																				<arrayIndexerExpression>
																					<target>
																						<propertyReferenceExpression name="SyncKey">
																							<argumentReferenceExpression name="request"/>
																						</propertyReferenceExpression>
																					</target>
																					<indices>
																						<variableReferenceExpression name="matchCount"/>
																					</indices>
																				</arrayIndexerExpression>
																			</convertExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="matchCount"/>
																			<binaryOperatorExpression operator="Add">
																				<variableReferenceExpression name="matchCount"/>
																				<primitiveExpression value="1"/>
																			</binaryOperatorExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<breakStatement/>
																	</falseStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="matchCount"/>
																	<propertyReferenceExpression name="Count">
																		<variableReferenceExpression name="keyFieldIndexes"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="PageIndex">
																		<argumentReferenceExpression name="page"/>
																	</propertyReferenceExpression>
																	<convertExpression to="Int32">
																		<methodInvokeExpression methodName="Floor">
																			<target>
																				<typeReferenceExpression type="Math"/>
																			</target>
																			<parameters>
																				<binaryOperatorExpression operator="Divide">
																					<convertExpression to="Double">
																						<binaryOperatorExpression operator="Subtract">
																							<variableReferenceExpression name="rowIndex"/>
																							<primitiveExpression value="1"/>
																						</binaryOperatorExpression>
																					</convertExpression>
																					<convertExpression to="Double">
																						<propertyReferenceExpression name="PageSize">
																							<argumentReferenceExpression name="page"/>
																						</propertyReferenceExpression>
																					</convertExpression>
																				</binaryOperatorExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</convertExpression>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="PageOffset">
																		<argumentReferenceExpression name="page"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="0"/>
																</assignStatement>
																<methodInvokeExpression methodName="ResetSkipCount">
																	<target>
																		<argumentReferenceExpression name="page"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="false"/>
																	</parameters>
																</methodInvokeExpression>
																<breakStatement/>
															</trueStatements>
															<falseStatements>
																<incrementStatement>
																	<variableReferenceExpression name="rowIndex"/>
																</incrementStatement>
															</falseStatements>
														</conditionStatement>
													</statements>
												</whileStatement>
											</falseStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="Close">
											<target>
												<variableReferenceExpression name="reader"/>
											</target>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method HandleException(Exception, ActionArgs, ActionResult) -->
						<memberMethod name="HandleException">
							<attributes family="true"/>
							<parameters>
								<parameter type="Exception" name="ex"/>
								<parameter type="ActionArgs" name="args"/>
								<parameter type="ActionResult" name="result"/>
							</parameters>
							<statements>
								<whileStatement>
									<test>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="ex"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</test>
									<statements>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Errors">
													<variableReferenceExpression name="result"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="Message">
													<variableReferenceExpression name="ex"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<variableReferenceExpression name="ex"/>
											<propertyReferenceExpression name="InnerException">
												<variableReferenceExpression name="ex"/>
											</propertyReferenceExpression>
										</assignStatement>
									</statements>
								</whileStatement>
							</statements>
						</memberMethod>
						<!-- method IDataEngine.ExecuteReader(PageRequest) -->
						<memberMethod returnType="DbDataReader" name="ExecuteReader" privateImplementationType="IDataEngine">
							<attributes/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="viewPage"/>
									<objectCreateExpression type="ViewPage">
										<parameters>
											<argumentReferenceExpression name="request"/>
										</parameters>
									</objectCreateExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="config"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="config"/>
											<methodInvokeExpression methodName="CreateConfiguration">
												<parameters>
													<propertyReferenceExpression name="Controller">
														<argumentReferenceExpression name="request"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<methodInvokeExpression methodName="SelectView">
											<parameters>
												<propertyReferenceExpression name="Controller">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="View">
													<argumentReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="ApplyDataFilter">
									<target>
										<fieldReferenceExpression name="viewPage"/>
									</target>
									<parameters>
										<methodInvokeExpression methodName="CreateDataFilter">
											<target>
												<fieldReferenceExpression name="config"/>
											</target>
										</methodInvokeExpression>
										<propertyReferenceExpression name="Controller">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="View">
											<argumentReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="null"/>
										<primitiveExpression value="null"/>
										<primitiveExpression value="null"/>
									</parameters>
								</methodInvokeExpression>
								<methodInvokeExpression methodName="InitBusinessRules">
									<parameters>
										<argumentReferenceExpression name="request"/>
										<fieldReferenceExpression name="viewPage"/>
									</parameters>
								</methodInvokeExpression>
								<variableDeclarationStatement type="DbConnection" name="connection">
									<init>
										<methodInvokeExpression methodName="CreateConnection"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="DbCommand" name="selectCommand">
									<init>
										<methodInvokeExpression methodName="CreateCommand">
											<parameters>
												<variableReferenceExpression name="connection"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="ConfigureCommand">
									<parameters>
										<variableReferenceExpression name="selectCommand"/>
										<fieldReferenceExpression name="viewPage"/>
										<propertyReferenceExpression name="Select">
											<typeReferenceExpression type="CommandConfigurationType"/>
										</propertyReferenceExpression>
										<primitiveExpression value="null"/>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ExecuteReader">
										<target>
											<variableReferenceExpression name="selectCommand"/>
										</target>
										<parameters>
											<propertyReferenceExpression name="CloseConnection">
												<typeReferenceExpression type="CommandBehavior"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IAutoCompleteManager.GetCompletionList(string, int, string) -->
						<memberMethod returnType="System.String[]" name="GetCompletionList" privateImplementationType="IAutoCompleteManager">
							<attributes/>
							<parameters>
								<parameter type="System.String" name="prefixText"/>
								<parameter type="System.Int32" name="count"/>
								<parameter type="System.String" name="contextKey"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="contextKey"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.String[]" name="arguments">
									<init>
										<methodInvokeExpression methodName="Split">
											<target>
												<argumentReferenceExpression name="contextKey"/>
											</target>
											<parameters>
												<primitiveExpression value="," convertTo="Char"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<propertyReferenceExpression name="Length">
												<variableReferenceExpression name="arguments"/>
											</propertyReferenceExpression>
											<primitiveExpression value="3"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="DistinctValueRequest" name="request">
									<init>
										<objectCreateExpression type="DistinctValueRequest"/>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="FieldName">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<arrayIndexerExpression>
										<target>
											<variableReferenceExpression name="arguments"/>
										</target>
										<indices>
											<primitiveExpression value="2"/>
										</indices>
									</arrayIndexerExpression>
								</assignStatement>
								<variableDeclarationStatement type="System.String" name="filter">
									<init>
										<binaryOperatorExpression operator="Add">
											<propertyReferenceExpression name="FieldName">
												<variableReferenceExpression name="request"/>
											</propertyReferenceExpression>
											<primitiveExpression value=":"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="s"/>
									<target>
										<methodInvokeExpression methodName="Split">
											<target>
												<argumentReferenceExpression name="prefixText"/>
											</target>
											<parameters>
												<primitiveExpression value="," convertTo="Char"/>
												<primitiveExpression value=";" convertTo="Char"/>
											</parameters>
										</methodInvokeExpression>
									</target>
									<statements>
										<variableDeclarationStatement type="System.String" name="query">
											<init>
												<methodInvokeExpression methodName="ConvertSampleToQuery">
													<target>
														<typeReferenceExpression type="Controller"/>
													</target>
													<parameters>
														<variableReferenceExpression name="s"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="query"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="filter"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="filter"/>
														<variableReferenceExpression name="query"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<assignStatement>
									<propertyReferenceExpression name="Filter">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<arrayCreateExpression>
										<createType type="System.String"/>
										<initializers>
											<variableReferenceExpression name="filter"/>
										</initializers>
									</arrayCreateExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="AllowFieldInFilter">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="MaximumValueCount">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="count"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Controller">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<arrayIndexerExpression>
										<target>
											<variableReferenceExpression name="arguments"/>
										</target>
										<indices>
											<primitiveExpression value="0"/>
										</indices>
									</arrayIndexerExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="View">
										<variableReferenceExpression name="request"/>
									</propertyReferenceExpression>
									<arrayIndexerExpression>
										<target>
											<variableReferenceExpression name="arguments"/>
										</target>
										<indices>
											<primitiveExpression value="1"/>
										</indices>
									</arrayIndexerExpression>
								</assignStatement>
								<variableDeclarationStatement type="System.Object[]" name="list">
									<init>
										<methodInvokeExpression methodName="GetListOfValues">
											<target>
												<methodInvokeExpression methodName="CreateDataController">
													<target>
														<typeReferenceExpression type="ControllerFactory"/>
													</target>
												</methodInvokeExpression>
											</target>
											<parameters>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="arguments"/>
													</target>
													<indices>
														<primitiveExpression value="0"/>
													</indices>
												</arrayIndexerExpression>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="arguments"/>
													</target>
													<indices>
														<primitiveExpression value="1"/>
													</indices>
												</arrayIndexerExpression>
												<variableReferenceExpression name="request"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="List" name="result">
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
									<variable type="System.Object" name="o"/>
									<target>
										<variableReferenceExpression name="list"/>
									</target>
									<statements>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="result"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="ToString">
													<target>
														<typeReferenceExpression type="Convert"/>
													</target>
													<parameters>
														<variableReferenceExpression name="o"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="result"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IBusinessObject.AssignFilter(string, BusinessObjectParameters) -->
						<memberMethod name="AssignFilter" privateImplementationType="IBusinessObject">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="filter"/>
								<parameter type="BusinessObjectParameters" name="parameters"/>
							</parameters>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="viewFilter"/>
									<argumentReferenceExpression name="filter"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="parameters"/>
									<argumentReferenceExpression name="parameters"/>
								</assignStatement>
							</statements>
						</memberMethod>
						<!-- member GetSelectView(string controller) -->
						<memberMethod returnType="System.String" name="GetSelectView">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ControllerUtilities" name="c">
									<init>
										<objectCreateExpression type="ControllerUtilities"/>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetActionView">
										<target>
											<variableReferenceExpression name="c"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="controller"/>
											<primitiveExpression value="editForm1"/>
											<primitiveExpression value="Select"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- member GetUpdateView(string controller) -->
						<memberMethod returnType="System.String" name="GetUpdateView">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ControllerUtilities" name="c">
									<init>
										<objectCreateExpression type="ControllerUtilities"/>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetActionView">
										<target>
											<variableReferenceExpression name="c"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="controller"/>
											<primitiveExpression value="editForm1"/>
											<primitiveExpression value="Update"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- member GetInsertView(string controller) -->
						<memberMethod returnType="System.String" name="GetInsertView">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ControllerUtilities" name="c">
									<init>
										<objectCreateExpression type="ControllerUtilities"/>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetActionView">
										<target>
											<variableReferenceExpression name="c"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="controller"/>
											<primitiveExpression value="createForm1"/>
											<primitiveExpression value="Insert"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- member GetDeleteView(string controller) -->
						<memberMethod returnType="System.String" name="GetDeleteView">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="ControllerUtilities" name="c">
									<init>
										<objectCreateExpression type="ControllerUtilities"/>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetActionView">
										<target>
											<variableReferenceExpression name="c"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="controller"/>
											<primitiveExpression value="editForm1"/>
											<primitiveExpression value="Delete"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- field junctionTableMap -->
						<memberField type="SortedDictionary" name="junctionTableMap">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="List">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
								</typeReference>
							</typeArguments>
						</memberField>
						<!-- field junctionTableFieldName -->
						<memberField type="System.String" name="junctionTableFieldName"/>
						<!-- method PopulateManyToManyFields(PageRequest, ViewPage) -->
						<memberMethod name="PopulateManyToManyFields">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="primaryKeyField">
									<init>
										<stringEmptyExpression/>
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
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<propertyReferenceExpression name="ItemsTargetController">
														<variableReferenceExpression name="field"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="primaryKeyField"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
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
																		<assignStatement>
																			<variableReferenceExpression name="primaryKeyField"/>
																			<propertyReferenceExpression name="Name">
																				<variableReferenceExpression name="f"/>
																			</propertyReferenceExpression>
																		</assignStatement>
																		<breakStatement/>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="PopulateManyToManyField">
													<parameters>
														<argumentReferenceExpression name="page"/>
														<variableReferenceExpression name="field"/>
														<variableReferenceExpression name="primaryKeyField"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
						<!-- method PopulateManyToManyField(PageRequest, ViewPage, DataField, string) -->
						<memberMethod name="PopulateManyToManyField">
							<attributes public="true" final="false"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
								<parameter type="DataField" name="field"/>
								<parameter type="System.String" name="primaryKeyField"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueInequality">
											<fieldReferenceExpression name="junctionTableFieldName"/>
											<propertyReferenceExpression name="Name">
												<argumentReferenceExpression name="field"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="junctionTableFieldName"/>
											<propertyReferenceExpression name="Name">
												<argumentReferenceExpression name="field"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="junctionTableMap"/>
											<primitiveExpression value="null"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<fieldReferenceExpression name="junctionTableMap"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="junctionTableMap"/>
											<objectCreateExpression type="SortedDictionary">
												<typeArguments>
													<typeReference type="System.String"/>
													<typeReference type="List">
														<typeArguments>
															<typeReference type="System.String"/>
														</typeArguments>
													</typeReference>
												</typeArguments>
											</objectCreateExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Count">
														<propertyReferenceExpression name="Rows">
															<argumentReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<comment>read contents of junction table from the database for each row of the page</comment>
												<variableDeclarationStatement type="System.Int32" name="foreignKeyIndex">
													<init>
														<methodInvokeExpression methodName="IndexOfField">
															<target>
																<propertyReferenceExpression name="page"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="primaryKeyField"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="StringBuilder" name="listOfForeignKeys">
													<init>
														<objectCreateExpression type="StringBuilder"/>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable type="System.Object[]" name="row"/>
													<target>
														<propertyReferenceExpression name="Rows">
															<propertyReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="GreaterThan">
																	<propertyReferenceExpression name="Length">
																		<variableReferenceExpression name="listOfForeignKeys"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Append">
																	<target>
																		<variableReferenceExpression name="listOfForeignKeys"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="$or$"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="Append">
															<target>
																<variableReferenceExpression name="listOfForeignKeys"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ConvertObjectToValue">
																	<target>
																		<typeReferenceExpression type="DataControllerBase"/>
																	</target>
																	<parameters>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="row"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="foreignKeyIndex"/>
																			</indices>
																		</arrayIndexerExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
												<variableDeclarationStatement type="System.String" name="targetForeignKey1">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="targetForeignKey2">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="InitializeManyToManyProperties">
													<target>
														<typeReferenceExpression type="ViewPage"/>
													</target>
													<parameters>
														<variableReferenceExpression name="field"/>
														<propertyReferenceExpression name="Controller">
															<variableReferenceExpression name="page"/>
														</propertyReferenceExpression>
														<directionExpression direction="Out">
															<variableReferenceExpression name="targetForeignKey1"/>
														</directionExpression>
														<directionExpression direction="Out">
															<variableReferenceExpression name="targetForeignKey2"/>
														</directionExpression>
													</parameters>
												</methodInvokeExpression>
												<variableDeclarationStatement type="System.String" name="filter">
													<init>
														<stringFormatExpression format="{{0}}:$in${{1}}">
															<argumentReferenceExpression name="targetForeignKey1"/>
															<methodInvokeExpression methodName="ToString">
																<target>
																	<variableReferenceExpression name="listOfForeignKeys"/>
																</target>
															</methodInvokeExpression>
														</stringFormatExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="PageRequest" name="request">
													<init>
														<objectCreateExpression type="PageRequest">
															<parameters>
																<primitiveExpression value="0"/>
																<propertyReferenceExpression name="MaxValue">
																	<typeReferenceExpression type="Int32"/>
																</propertyReferenceExpression>
																<primitiveExpression value="null"/>
																<arrayCreateExpression>
																	<createType type="System.String"/>
																	<initializers>
																		<variableReferenceExpression name="filter"/>
																	</initializers>
																</arrayCreateExpression>
															</parameters>
														</objectCreateExpression>
													</init>
												</variableDeclarationStatement>
												<assignStatement>
													<propertyReferenceExpression name="RequiresMetaData">
														<variableReferenceExpression name="request"/>
													</propertyReferenceExpression>
													<primitiveExpression value="true"/>
												</assignStatement>
												<variableDeclarationStatement type="ViewPage" name="manyToManyPage">
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
																<propertyReferenceExpression name="ItemsTargetController">
																	<argumentReferenceExpression name="field"/>
																</propertyReferenceExpression>
																<primitiveExpression value="null"/>
																<variableReferenceExpression name="request"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<comment>enumerate values in junction table</comment>
												<variableDeclarationStatement type="System.Int32" name="targetForeignKey1Index">
													<init>
														<methodInvokeExpression methodName="IndexOfField">
															<target>
																<variableReferenceExpression name="manyToManyPage"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="targetForeignKey1"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.Int32" name="targetForeignKey2Index">
													<init>
														<methodInvokeExpression methodName="IndexOfField">
															<target>
																<variableReferenceExpression name="manyToManyPage"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="targetForeignKey2"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<comment>determine text field for items</comment>
												<variableDeclarationStatement type="SortedDictionary" name="items">
													<typeArguments>
														<typeReference type="System.Object"/>
														<typeReference type="System.Object"/>
													</typeArguments>
													<init>
														<objectCreateExpression type="SortedDictionary">
															<typeArguments>
																<typeReference type="System.Object"/>
																<typeReference type="System.Object"/>
															</typeArguments>
														</objectCreateExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="List" name="keyList">
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
												<variableDeclarationStatement type="System.Int32" name="targetTextIndex">
													<init>
														<primitiveExpression value="-1"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="SupportsStaticItems">
																<target>
																	<variableReferenceExpression name="field"/>
																</target>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<foreachStatement>
															<variable type="DataField" name="f"/>
															<target>
																<propertyReferenceExpression name="Fields">
																	<variableReferenceExpression name="manyToManyPage"/>
																</propertyReferenceExpression>
															</target>
															<statements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="Name">
																				<variableReferenceExpression name="f"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="targetForeignKey2"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="IsNotNullOrEmpty">
																					<propertyReferenceExpression name="AliasName">
																						<variableReferenceExpression name="f"/>
																					</propertyReferenceExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="targetTextIndex"/>
																					<methodInvokeExpression methodName="IndexOfField">
																						<target>
																							<variableReferenceExpression name="manyToManyPage"/>
																						</target>
																						<parameters>
																							<propertyReferenceExpression name="AliasName">
																								<variableReferenceExpression name="f"/>
																							</propertyReferenceExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																			</trueStatements>
																			<falseStatements>
																				<assignStatement>
																					<variableReferenceExpression name="targetTextIndex"/>
																					<methodInvokeExpression methodName="IndexOfField">
																						<target>
																							<variableReferenceExpression name="manyToManyPage"/>
																						</target>
																						<parameters>
																							<propertyReferenceExpression name="Name">
																								<variableReferenceExpression name="f"/>
																							</propertyReferenceExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																			</falseStatements>
																		</conditionStatement>
																		<breakStatement/>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
													</trueStatements>
												</conditionStatement>
												<foreachStatement>
													<variable type="System.Object[]" name="row"/>
													<target>
														<propertyReferenceExpression name="Rows">
															<variableReferenceExpression name="manyToManyPage"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<variableDeclarationStatement type="System.Object" name="v1">
															<init>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="row"/>
																	</target>
																	<indices>
																		<variableReferenceExpression name="targetForeignKey1Index"/>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Object" name="v2">
															<init>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="row"/>
																	</target>
																	<indices>
																		<variableReferenceExpression name="targetForeignKey2Index"/>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="v1"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="System.String" name="s1">
																	<init>
																		<convertExpression to="String">
																			<variableReferenceExpression name="v1"/>
																		</convertExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="List" name="values">
																	<typeArguments>
																		<typeReference type="System.String"/>
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
																					<fieldReferenceExpression name="junctionTableMap"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="s1"/>
																					<directionExpression direction="Out">
																						<variableReferenceExpression name="values"/>
																					</directionExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="values"/>
																			<objectCreateExpression type="List">
																				<typeArguments>
																					<typeReference type="System.String"/>
																				</typeArguments>
																			</objectCreateExpression>
																		</assignStatement>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<fieldReferenceExpression name="junctionTableMap"/>
																				</target>
																				<indices>
																					<variableReferenceExpression name="s1"/>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="values"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="values"/>
																	</target>
																	<parameters>
																		<convertExpression to="String">
																			<variableReferenceExpression name="v2"/>
																		</convertExpression>
																	</parameters>
																</methodInvokeExpression>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueInequality">
																			<variableReferenceExpression name="targetTextIndex"/>
																			<primitiveExpression value="-1"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement type="System.Object" name="text">
																			<init>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="row"/>
																					</target>
																					<indices>
																						<variableReferenceExpression name="targetTextIndex"/>
																					</indices>
																				</arrayIndexerExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<methodInvokeExpression methodName="ContainsKey">
																						<target>
																							<variableReferenceExpression name="items"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="v2"/>
																						</parameters>
																					</methodInvokeExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="items"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="v2"/>
																						<variableReferenceExpression name="text"/>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="keyList"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="v2"/>
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
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueInequality">
															<propertyReferenceExpression name="Count">
																<variableReferenceExpression name="items"/>
															</propertyReferenceExpression>
															<primitiveExpression value="0"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<foreachStatement>
															<variable type="System.Object" name="k"/>
															<target>
																<variableReferenceExpression name="keyList"/>
															</target>
															<statements>
																<variableDeclarationStatement type="System.Object" name="v">
																	<init>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="items"/>
																			</target>
																			<indices>
																				<variableReferenceExpression name="k"/>
																			</indices>
																		</arrayIndexerExpression>
																	</init>
																</variableDeclarationStatement>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<propertyReferenceExpression name="Items">
																			<argumentReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																	</target>
																	<parameters>
																		<arrayCreateExpression>
																			<createType type="System.Object"/>
																			<initializers>
																				<variableReferenceExpression name="k"/>
																				<variableReferenceExpression name="v"/>
																			</initializers>
																		</arrayCreateExpression>
																	</parameters>
																</methodInvokeExpression>
															</statements>
														</foreachStatement>
														<!--<foreachStatement>
                              <variable type="KeyValuePair" name="kvp">
                                <typeArguments>
                                  <typeReference type="System.Object"/>
                                  <typeReference type="System.Object"/>
                                </typeArguments>
                              </variable>
                              <target>
                                <variableReferenceExpression name="items"/>
                              </target>
                              <statements>
                                <methodInvokeExpression methodName="Add">
                                  <target>
                                    <propertyReferenceExpression name="Items">
                                      <variableReferenceExpression name="field"/>
                                    </propertyReferenceExpression>
                                  </target>
                                  <parameters>
                                    <arrayCreateExpression>
                                      <createType type="System.Object"/>
                                      <initializers>
                                        <propertyReferenceExpression name="Key">
                                          <variableReferenceExpression name="kvp"/>
                                        </propertyReferenceExpression>
                                        <propertyReferenceExpression name="Value">
                                          <variableReferenceExpression name="kvp"/>
                                        </propertyReferenceExpression>
                                      </initializers>
                                    </arrayCreateExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </statements>
                            </foreachStatement>-->
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<foreachStatement>
									<variable type="System.Object[]" name="values"/>
									<target>
										<propertyReferenceExpression name="Rows">
											<argumentReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<variableDeclarationStatement type="System.String" name="key">
											<init>
												<convertExpression to="String">
													<methodInvokeExpression methodName="SelectFieldValue">
														<target>
															<argumentReferenceExpression name="page"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="primaryKeyField"/>
															<variableReferenceExpression name="values"/>
														</parameters>
													</methodInvokeExpression>
												</convertExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="List" name="keyValues">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="TryGetValue">
													<target>
														<fieldReferenceExpression name="junctionTableMap"/>
													</target>
													<parameters>
														<variableReferenceExpression name="key"/>
														<directionExpression direction="Out">
															<variableReferenceExpression name="keyValues"/>
														</directionExpression>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="UpdateFieldValue">
													<target>
														<argumentReferenceExpression name="page"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Name">
															<argumentReferenceExpression name="field"/>
														</propertyReferenceExpression>
														<variableReferenceExpression name="values"/>
														<methodInvokeExpression methodName="Join">
															<target>
																<typeReferenceExpression type="String"/>
															</target>
															<parameters>
																<primitiveExpression value=","/>
																<methodInvokeExpression methodName="ToArray">
																	<target>
																		<variableReferenceExpression name="keyValues"/>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
						<!-- method ProcessOneToOneFields(ActionArgs) -->
						<memberMethod name="ProcessOneToOneFields">
							<attributes family="true"/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="XPathNavigator" name="oneToOneFieldNav">
									<init>
										<methodInvokeExpression methodName="SelectSingleNode">
											<target>
												<propertyReferenceExpression name="Config"/>
											</target>
											<parameters>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[/c:dataController/c:fields/c:field[c:items/@style='OneToOne']]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="oneToOneFieldNav"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="targetValues">
											<init>
												<objectCreateExpression type="List">
													<typeArguments>
														<typeReference type="FieldValue"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="itemsNav">
											<init>
												<methodInvokeExpression methodName="SelectSingleNode">
													<target>
														<variableReferenceExpression name="oneToOneFieldNav"/>
													</target>
													<parameters>
														<primitiveExpression value="c:items"/>
														<propertyReferenceExpression name="Resolver">
															<propertyReferenceExpression name="Config"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="fieldMap">
											<init>
												<objectCreateExpression type="SortedDictionary">
													<typeArguments>
														<typeReference type="System.String"/>
														<typeReference type="System.String"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<comment>configure the primary key field value</comment>
										<variableDeclarationStatement name="localKeyFieldName">
											<init>
												<methodInvokeExpression methodName="GetAttribute">
													<target>
														<variableReferenceExpression name="oneToOneFieldNav"/>
													</target>
													<parameters>
														<primitiveExpression value="name"/>
														<stringEmptyExpression/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="targetKeyFieldName">
											<init>
												<methodInvokeExpression methodName="GetAttribute">
													<target>
														<variableReferenceExpression name="itemsNav"/>
													</target>
													<parameters>
														<primitiveExpression value="dataValueField"/>
														<stringEmptyExpression/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="fvo">
											<init>
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="args"/>
													</target>
													<indices>
														<variableReferenceExpression name="localKeyFieldName"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="targetFvo">
											<init>
												<objectCreateExpression type="FieldValue">
													<parameters>
														<variableReferenceExpression name="targetKeyFieldName"/>
														<propertyReferenceExpression name="OldValue">
															<variableReferenceExpression name="fvo"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="NewValue">
															<variableReferenceExpression name="fvo"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="ReadOnly">
															<variableReferenceExpression name="fvo"/>
														</propertyReferenceExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="Modified">
												<variableReferenceExpression name="targetFvo"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="Modified">
												<variableReferenceExpression name="fvo"/>
											</propertyReferenceExpression>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="targetValues"/>
											</target>
											<parameters>
												<variableReferenceExpression name="targetFvo"/>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="fieldMap"/>
												</target>
												<indices>
													<variableReferenceExpression name="targetKeyFieldName"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="localKeyFieldName"/>
										</assignStatement>
										<comment> enumerate "copy" field values</comment>
										<variableDeclarationStatement name="copy">
											<init>
												<methodInvokeExpression methodName="GetAttribute">
													<target>
														<variableReferenceExpression name="itemsNav"/>
													</target>
													<parameters>
														<primitiveExpression value="copy"/>
														<stringEmptyExpression/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="m">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="copy"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[(\w+)\s*=\s*(\w+)]]></xsl:attribute>
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
												<variableDeclarationStatement name="localFieldName">
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
												<variableDeclarationStatement name="targetFieldName">
													<init>
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
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="ContainsKey">
																<target>
																	<variableReferenceExpression name="fieldMap"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="targetFieldName"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="fvo"/>
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="args"/>
																</target>
																<indices>
																	<variableReferenceExpression name="localFieldName"/>
																</indices>
															</arrayIndexerExpression>
														</assignStatement>
														<assignStatement>
															<variableReferenceExpression name="targetFvo"/>
															<objectCreateExpression type="FieldValue">
																<parameters>
																	<variableReferenceExpression name="targetFieldName"/>
																	<propertyReferenceExpression name="OldValue">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="NewValue">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="ReadOnly">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Modified">
																<variableReferenceExpression name="targetFvo"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Modified">
																<variableReferenceExpression name="fvo"/>
															</propertyReferenceExpression>
														</assignStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="targetValues"/>
															</target>
															<parameters>
																<variableReferenceExpression name="targetFvo"/>
															</parameters>
														</methodInvokeExpression>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="fieldMap"/>
																</target>
																<indices>
																	<variableReferenceExpression name="targetFieldName"/>
																</indices>
															</arrayIndexerExpression>
															<variableReferenceExpression name="localFieldName"/>
														</assignStatement>
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
										<comment>create a request</comment>
										<variableDeclarationStatement name="targetArgs">
											<init>
												<objectCreateExpression type="ActionArgs"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="Controller">
												<variableReferenceExpression name="targetArgs"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<variableReferenceExpression name="itemsNav"/>
												</target>
												<parameters>
													<primitiveExpression value="dataController"/>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="View">
												<variableReferenceExpression name="targetArgs"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="View">
												<argumentReferenceExpression name="args"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="CommandName">
												<variableReferenceExpression name="targetArgs"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="CommandName">
												<argumentReferenceExpression name="args"/>
											</propertyReferenceExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="LastCommandName">
												<variableReferenceExpression name="targetArgs"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="LastCommandName">
												<argumentReferenceExpression name="args"/>
											</propertyReferenceExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="LastCommandName">
														<variableReferenceExpression name="targetArgs"/>
													</propertyReferenceExpression>
													<primitiveExpression value="BatchEdit"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="LastCommandName">
														<variableReferenceExpression name="targetArgs"/>
													</propertyReferenceExpression>
													<primitiveExpression value="Edit"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<propertyReferenceExpression name="Values">
												<variableReferenceExpression name="targetArgs"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="ToArray">
												<target>
													<variableReferenceExpression name="targetValues"/>
												</target>
											</methodInvokeExpression>
										</assignStatement>
										<variableDeclarationStatement name="result">
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
															<variableReferenceExpression name="targetArgs"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="View">
															<variableReferenceExpression name="targetArgs"/>
														</propertyReferenceExpression>
														<variableReferenceExpression name="targetArgs"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="RaiseExceptionIfErrors">
											<target>
												<variableReferenceExpression name="result"/>
											</target>
										</methodInvokeExpression>
										<comment>copy the new values back to the original source</comment>
										<foreachStatement>
											<variable name="tfvo"/>
											<target>
												<propertyReferenceExpression name="Values">
													<variableReferenceExpression name="targetArgs"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<variableDeclarationStatement type="System.String" name="mappedFieldName">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="TryGetValue">
															<target>
																<variableReferenceExpression name="fieldMap"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="tfvo"/>
																</propertyReferenceExpression>
																<directionExpression direction="Out">
																	<variableReferenceExpression name="mappedFieldName"/>
																</directionExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="fvo"/>
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="args"/>
																</target>
																<indices>
																	<variableReferenceExpression name="mappedFieldName"/>
																</indices>
															</arrayIndexerExpression>
														</assignStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="IdentityInequality">
																		<variableReferenceExpression name="tfvo"/>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="ValueInequality">
																		<propertyReferenceExpression name="NewValue">
																			<variableReferenceExpression name="fvo"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="NewValue">
																			<variableReferenceExpression name="tfvo"/>
																		</propertyReferenceExpression>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="NewValue">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="NewValue">
																		<variableReferenceExpression name="tfvo"/>
																	</propertyReferenceExpression>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="Modified">
																		<variableReferenceExpression name="fvo"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="true"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ProcessManyToManyFields(ActionArgs)-->
						<memberMethod name="ProcessManyToManyFields">
							<attributes private="true" final="true"/>
							<parameters>
								<parameter type="ActionArgs" name="args"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="XPathNodeIterator" name="m2mFields">
									<init>
										<methodInvokeExpression methodName="Select">
											<target>
												<propertyReferenceExpression name="Config"/>
											</target>
											<parameters>
												<primitiveExpression value="/c:dataController/c:fields/c:field[c:items/@targetController!='']"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Count">
												<variableReferenceExpression name="m2mFields"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="XPathNavigator" name="primaryKeyNode">
											<init>
												<methodInvokeExpression methodName="SelectSingleNode">
													<target>
														<propertyReferenceExpression name="Config"/>
													</target>
													<parameters>
														<primitiveExpression value="/c:dataController/c:fields/c:field[@isPrimaryKey='true']"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="FieldValue" name="primaryKey">
											<init>
												<methodInvokeExpression methodName="SelectFieldValueObject">
													<target>
														<argumentReferenceExpression name="args"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="GetAttribute">
															<target>
																<variableReferenceExpression name="primaryKeyNode"/>
															</target>
															<parameters>
																<primitiveExpression value="name"/>
																<stringEmptyExpression/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<methodInvokeExpression methodName="MoveNext">
													<target>
														<variableReferenceExpression name="m2mFields"/>
													</target>
												</methodInvokeExpression>
											</test>
											<statements>
												<variableDeclarationStatement type="DataField" name="field">
													<init>
														<objectCreateExpression type="DataField">
															<parameters>
																<propertyReferenceExpression name="Current">
																	<variableReferenceExpression name="m2mFields"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Resolver">
																	<propertyReferenceExpression name="Config"/>
																</propertyReferenceExpression>
															</parameters>
														</objectCreateExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="FieldValue" name="fv">
													<init>
														<methodInvokeExpression methodName="SelectFieldValueObject">
															<target>
																<variableReferenceExpression name="args"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="field"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<variableReferenceExpression name="fv"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Scope">
																		<variableReferenceExpression name="fv"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="client"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="OldValue">
																		<variableReferenceExpression name="fv"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="NewValue">
																		<variableReferenceExpression name="fv"/>
																	</propertyReferenceExpression>
																</assignStatement>
																<assignStatement>
																	<propertyReferenceExpression name="Modified">
																		<variableReferenceExpression name="fv"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="false"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="CommandName">
																				<variableReferenceExpression name="args"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="Delete"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="Modified">
																				<variableReferenceExpression name="fv"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																		<assignStatement>
																			<propertyReferenceExpression name="NewValue">
																				<variableReferenceExpression name="fv"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="null"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="ProcessManyToManyField">
																	<parameters>
																		<propertyReferenceExpression name="Controller">
																			<variableReferenceExpression name="args"/>
																		</propertyReferenceExpression>
																		<variableReferenceExpression name="field"/>
																		<variableReferenceExpression name="fv"/>
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="primaryKey"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
																<assignStatement>
																	<propertyReferenceExpression name="Modified">
																		<variableReferenceExpression name="fv"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="false"/>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
										</whileStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ProcessManyToManyField(ActionArgs, DataField, FieldValue, object) -->
						<memberMethod name="ProcessManyToManyField">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="controllerName"/>
								<parameter type="DataField" name="field"/>
								<parameter type="FieldValue" name="fieldValue"/>
								<parameter type="System.Object" name="primaryKey"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Object" name="originalOldValue">
									<init>
										<propertyReferenceExpression name="OldValue">
											<argumentReferenceExpression name="fieldValue"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Boolea" name="restoreOldValue">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="keepBatch">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="args">
									<init>
										<propertyReferenceExpression name="Current">
											<typeReferenceExpression type="ActionArgs"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="args"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<propertyReferenceExpression name="IsBatchEditOrDelete">
												<variableReferenceExpression name="args"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="CommandName">
															<variableReferenceExpression name="args"/>
														</propertyReferenceExpression>
														<primitiveExpression value="Update"/>
													</binaryOperatorExpression>
													<unaryOperatorExpression operator="Not">
														<propertyReferenceExpression name="Modified">
															<argumentReferenceExpression name="fieldValue"/>
														</propertyReferenceExpression>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement/>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="List" name="pkFilter">
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
										<variableDeclarationStatement type="XPathNodeIterator" name="pkIterator">
											<init>
												<methodInvokeExpression methodName="Select">
													<target>
														<fieldReferenceExpression name="config"/>
													</target>
													<parameters>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[/c:dataController/c:fields/c:field[@isPrimaryKey='true']]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<methodInvokeExpression methodName="MoveNext">
													<target>
														<variableReferenceExpression name="pkIterator"/>
													</target>
												</methodInvokeExpression>
											</test>
											<statements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="pkFilter"/>
													</target>
													<parameters>
														<stringFormatExpression format="{{0}}:={{1}}">
															<methodInvokeExpression methodName="GetAttribute">
																<target>
																	<propertyReferenceExpression name="Current">
																		<variableReferenceExpression name="pkIterator"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="name"/>
																	<stringEmptyExpression/>
																</parameters>
															</methodInvokeExpression>
															<argumentReferenceExpression name="primaryKey"/>
														</stringFormatExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</whileStatement>
										<variableDeclarationStatement type="PageRequest" name="r">
											<init>
												<objectCreateExpression type="PageRequest">
													<parameters>
														<primitiveExpression value="0"/>
														<primitiveExpression value="1"/>
														<primitiveExpression value="null"/>
														<methodInvokeExpression methodName="ToArray">
															<target>
																<variableReferenceExpression name="pkFilter"/>
															</target>
														</methodInvokeExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="FieldFilter">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<arrayCreateExpression>
												<createType type="System.String"/>
												<initializers>
													<propertyReferenceExpression name="Name">
														<variableReferenceExpression name="field"/>
													</propertyReferenceExpression>
												</initializers>
											</arrayCreateExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="MetadataFilter">
												<variableReferenceExpression name="r"/>
											</propertyReferenceExpression>
											<arrayCreateExpression>
												<createType type="System.String"/>
												<initializers>
													<primitiveExpression value="fields"/>
												</initializers>
											</arrayCreateExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="RequiresMetaData">
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
														<argumentReferenceExpression name="controllerName"/>
														<fieldReferenceExpression name="viewId"/>
														<variableReferenceExpression name="r"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
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
												<assignStatement>
													<variableReferenceExpression name="originalOldValue"/>
													<propertyReferenceExpression name="OldValue">
														<argumentReferenceExpression name="fieldValue"/>
													</propertyReferenceExpression>
												</assignStatement>
												<assignStatement>
													<variableReferenceExpression name="restoreOldValue"/>
													<primitiveExpression value="true"/>
												</assignStatement>
												<assignStatement>
													<propertyReferenceExpression name="OldValue">
														<argumentReferenceExpression name="fieldValue"/>
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
															<methodInvokeExpression methodName="IndexOfField">
																<target>
																	<variableReferenceExpression name="p"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Name">
																		<variableReferenceExpression name="field"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</indices>
													</arrayIndexerExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="keepBatchFlag">
											<init>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="args"/>
													</target>
													<indices>
														<binaryOperatorExpression operator="Add">
															<propertyReferenceExpression name="Name">
																<variableReferenceExpression name="fieldValue"/>
															</propertyReferenceExpression>
															<primitiveExpression value="_BatchKeep"/>
														</binaryOperatorExpression>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="keepBatchFlag"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="keepBatch"/>
													<methodInvokeExpression methodName="Equals">
														<target>
															<primitiveExpression value="true"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="keepBatchFlag"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="List" name="oldValues">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
									<init>
										<methodInvokeExpression methodName="ValueToList">
											<target>
												<typeReferenceExpression type="BusinessRulesBase"/>
											</target>
											<parameters>
												<castExpression targetType="System.String">
													<propertyReferenceExpression name="OldValue">
														<variableReferenceExpression name="fieldValue"/>
													</propertyReferenceExpression>
												</castExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="List" name="newValues">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
									<init>
										<methodInvokeExpression methodName="ValueToList">
											<target>
												<typeReferenceExpression type="BusinessRulesBase"/>
											</target>
											<parameters>
												<castExpression targetType="System.String">
													<propertyReferenceExpression name="Value">
														<variableReferenceExpression name="fieldValue"/>
													</propertyReferenceExpression>
												</castExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<variableReferenceExpression name="keepBatch"/>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable name="v" type="System.String"/>
											<target>
												<variableReferenceExpression name="oldValues"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Contains">
																<target>
																	<variableReferenceExpression name="newValues"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="v"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="newValues"/>
															</target>
															<parameters>
																<variableReferenceExpression name="v"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="ListsAreEqual">
												<target>
													<typeReferenceExpression type="BusinessRulesBase"/>
												</target>
												<parameters>
													<variableReferenceExpression name="oldValues"/>
													<variableReferenceExpression name="newValues"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String" name="targetForeignKey1">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String" name="targetForeignKey2">
											<init>
												<primitiveExpression value="null"/>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="InitializeManyToManyProperties">
											<target>
												<typeReferenceExpression type="ViewPage"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="field"/>
												<argumentReferenceExpression name="controllerName"/>
												<directionExpression direction="Out">
													<variableReferenceExpression name="targetForeignKey1"/>
												</directionExpression>
												<directionExpression direction="Out">
													<variableReferenceExpression name="targetForeignKey2"/>
												</directionExpression>
											</parameters>
										</methodInvokeExpression>
										<variableDeclarationStatement type="IDataController" name="controller">
											<init>
												<methodInvokeExpression methodName="CreateDataController">
													<target>
														<typeReferenceExpression type="ControllerFactory"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="System.String" name="s"/>
											<target>
												<variableReferenceExpression name="oldValues"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Contains">
																<target>
																	<variableReferenceExpression name="newValues"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="s"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="ActionArgs" name="deleteArgs">
															<init>
																<objectCreateExpression type="ActionArgs"/>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<propertyReferenceExpression name="Controller">
																<variableReferenceExpression name="deleteArgs"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="ItemsTargetController">
																<argumentReferenceExpression name="field"/>
															</propertyReferenceExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="CommandName">
																<variableReferenceExpression name="deleteArgs"/>
															</propertyReferenceExpression>
															<primitiveExpression value="Delete"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="LastCommandName">
																<variableReferenceExpression name="deleteArgs"/>
															</propertyReferenceExpression>
															<primitiveExpression value="Select"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Values">
																<variableReferenceExpression name="deleteArgs"/>
															</propertyReferenceExpression>
															<arrayCreateExpression>
																<createType type="FieldValue"/>
																<initializers>
																	<objectCreateExpression type="FieldValue">
																		<parameters>
																			<argumentReferenceExpression name="targetForeignKey1"/>
																			<variableReferenceExpression name="primaryKey"/>
																			<variableReferenceExpression name="primaryKey"/>
																		</parameters>
																	</objectCreateExpression>
																	<objectCreateExpression type="FieldValue">
																		<parameters>
																			<argumentReferenceExpression name="targetForeignKey2"/>
																			<variableReferenceExpression name="s"/>
																			<variableReferenceExpression name="s"/>
																		</parameters>
																	</objectCreateExpression>
																	<objectCreateExpression type="FieldValue">
																		<parameters>
																			<primitiveExpression value="_SurrogatePK"/>
																			<arrayCreateExpression>
																				<createType type="System.String"/>
																				<initializers>
																					<variableReferenceExpression name="targetForeignKey1"/>
																					<variableReferenceExpression name="targetForeignKey2"/>
																				</initializers>
																			</arrayCreateExpression>
																		</parameters>
																	</objectCreateExpression>
																</initializers>
															</arrayCreateExpression>
														</assignStatement>
														<variableDeclarationStatement type="ActionResult" name="result">
															<init>
																<methodInvokeExpression methodName="Execute">
																	<target>
																		<variableReferenceExpression name="controller"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="ItemsTargetController">
																			<argumentReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="null"/>
																		<variableReferenceExpression name="deleteArgs"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<methodInvokeExpression methodName="RaiseExceptionIfErrors">
															<target>
																<variableReferenceExpression name="result"/>
															</target>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
										<foreachStatement>
											<variable type="System.String" name="s"/>
											<target>
												<variableReferenceExpression name="newValues"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="Contains">
																<target>
																	<variableReferenceExpression name="oldValues"/>
																</target>
																<parameters>
																	<variableReferenceExpression name="s"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="ActionArgs" name="updateArgs">
															<init>
																<objectCreateExpression type="ActionArgs"/>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<propertyReferenceExpression name="Controller">
																<variableReferenceExpression name="updateArgs"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="ItemsTargetController">
																<argumentReferenceExpression name="field"/>
															</propertyReferenceExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="CommandName">
																<variableReferenceExpression name="updateArgs"/>
															</propertyReferenceExpression>
															<primitiveExpression value="Insert"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="LastCommandName">
																<variableReferenceExpression name="updateArgs"/>
															</propertyReferenceExpression>
															<primitiveExpression value="New"/>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Values">
																<variableReferenceExpression name="updateArgs"/>
															</propertyReferenceExpression>
															<arrayCreateExpression>
																<createType type="FieldValue"/>
																<initializers>
																	<objectCreateExpression type="FieldValue">
																		<parameters>
																			<argumentReferenceExpression name="targetForeignKey1"/>
																			<variableReferenceExpression name="primaryKey"/>
																		</parameters>
																	</objectCreateExpression>
																	<objectCreateExpression type="FieldValue">
																		<parameters>
																			<argumentReferenceExpression name="targetForeignKey2"/>
																			<variableReferenceExpression name="s"/>
																		</parameters>
																	</objectCreateExpression>
																</initializers>
															</arrayCreateExpression>
														</assignStatement>
														<variableDeclarationStatement type="ActionResult" name="result">
															<init>
																<methodInvokeExpression methodName="Execute">
																	<target>
																		<variableReferenceExpression name="controller"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="ItemsTargetController">
																			<argumentReferenceExpression name="field"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="null"/>
																		<variableReferenceExpression name="updateArgs"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<methodInvokeExpression methodName="RaiseExceptionIfErrors">
															<target>
																<variableReferenceExpression name="result"/>
															</target>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<variableReferenceExpression name="restoreOldValue"/>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="OldValue">
												<argumentReferenceExpression name="fieldValue"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="originalOldValue"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- property DefaultDataControllerStream -->
						<memberField type="Stream" name="DefaultDataControllerStream">
							<attributes public="true" static="true"/>
							<init>
								<objectCreateExpression type="MemoryStream"/>
							</init>
						</memberField>
						<!-- method GetDataControllerStream(string) -->
						<memberMethod returnType="Stream" name="GetDataControllerStream">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<statements>
								<xsl:choose>
									<xsl:when test="$PageImplementation='html'">
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<unaryOperatorExpression operator="Not">
														<propertyReferenceExpression name="IsSiteContentEnabled">
															<typeReferenceExpression type="ApplicationServices"/>
														</propertyReferenceExpression>
													</unaryOperatorExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<argumentReferenceExpression name="controller"/>
														<propertyReferenceExpression name="SiteContentControllerName">
															<typeReferenceExpression type="ApplicationServices"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="null"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="HttpContext" name="context">
											<init>
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Boolean" name="requiresUser">
											<init>
												<primitiveExpression value="false"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<propertyReferenceExpression name="User">
														<variableReferenceExpression name="context"/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="requiresUser"/>
													<primitiveExpression value="true"/>
												</assignStatement>
												<comment>Establish user identity for REST requests</comment>
												<variableDeclarationStatement type="System.String" name="authorization">
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
																<primitiveExpression value="Authorization"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNullOrEmpty">
															<variableReferenceExpression name="authorization"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="User">
																<variableReferenceExpression name="context"/>
															</propertyReferenceExpression>
															<objectCreateExpression type="RolePrincipal">
																<parameters>
																	<objectCreateExpression type="AnonymousUserIdentity"/>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="StartsWith">
																	<target>
																		<variableReferenceExpression name="authorization"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="Basic"/>
																		<propertyReferenceExpression name="OrdinalIgnoreCase">
																			<typeReferenceExpression type="StringComparison"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="System.String[]" name="login">
																	<init>
																		<methodInvokeExpression methodName="Split">
																			<target>
																				<methodInvokeExpression methodName="GetString">
																					<target>
																						<propertyReferenceExpression name="Default">
																							<typeReferenceExpression type="Encoding"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<methodInvokeExpression methodName="FromBase64String">
																							<target>
																								<typeReferenceExpression type="Convert"/>
																							</target>
																							<parameters>
																								<methodInvokeExpression methodName="Substring">
																									<target>
																										<argumentReferenceExpression name="authorization"/>
																									</target>
																									<parameters>
																										<primitiveExpression value="6"/>
																									</parameters>
																								</methodInvokeExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</target>
																			<parameters>
																				<arrayCreateExpression>
																					<createType type="System.Char"/>
																					<initializers>
																						<primitiveExpression value=":" convertTo="Char"/>
																					</initializers>
																				</arrayCreateExpression>
																				<primitiveExpression value="2"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="ValidateUser">
																			<target>
																				<typeReferenceExpression type="Membership"/>
																			</target>
																			<parameters>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="login"/>
																					</target>
																					<indices>
																						<primitiveExpression value="0"/>
																					</indices>
																				</arrayIndexerExpression>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="login"/>
																					</target>
																					<indices>
																						<primitiveExpression value="1"/>
																					</indices>
																				</arrayIndexerExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<propertyReferenceExpression name="User">
																				<variableReferenceExpression name="context"/>
																			</propertyReferenceExpression>
																			<objectCreateExpression type="RolePrincipal">
																				<parameters>
																					<objectCreateExpression type="FormsIdentity">
																						<parameters>
																							<objectCreateExpression type="FormsAuthenticationTicket">
																								<parameters>
																									<arrayIndexerExpression>
																										<target>
																											<variableReferenceExpression name="login"/>
																										</target>
																										<indices>
																											<primitiveExpression value="0"/>
																										</indices>
																									</arrayIndexerExpression>
																									<primitiveExpression value="false"/>
																									<primitiveExpression value="10"/>
																								</parameters>
																							</objectCreateExpression>
																						</parameters>
																					</objectCreateExpression>
																				</parameters>
																			</objectCreateExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityEquality">
																	<propertyReferenceExpression name="User">
																		<variableReferenceExpression name="context"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="StatusCode">
																		<propertyReferenceExpression name="Response">
																			<variableReferenceExpression name="context"/>
																		</propertyReferenceExpression>
																	</propertyReferenceExpression>
																	<primitiveExpression value="401"/>
																</assignStatement>
																<methodInvokeExpression methodName="End">
																	<target>
																		<propertyReferenceExpression name="Response">
																			<variableReferenceExpression name="context"/>
																		</propertyReferenceExpression>
																	</target>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="System.String" name="sysControllersPath">
											<init>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="sys/controllers%/"/>
													<binaryOperatorExpression operator="Add">
														<argumentReferenceExpression name="controller"/>
														<xsl:choose>
															<xsl:when test="$EnableJsonControllers='true'">
																<primitiveExpression value=".json"/>
															</xsl:when>
															<xsl:otherwise>
																<primitiveExpression value=".xml"/>
															</xsl:otherwise>
														</xsl:choose>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Byte[]" name="data">
											<init>
												<castExpression targetType="System.Byte[]">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Cache">
																<propertyReferenceExpression name="Current">
																	<typeReferenceExpression type="HttpContext"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</target>
														<indices>
															<variableReferenceExpression name="sysControllersPath"/>
														</indices>
													</arrayIndexerExpression>
												</castExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="data"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
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
																<propertyReferenceExpression name="DynamicControllerCustomization">
																	<typeReferenceExpression type="ApplicationFeature"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="data"/>
															<methodInvokeExpression methodName="ReadSiteContentBytes">
																<target>
																	<propertyReferenceExpression name="Current">
																		<typeReferenceExpression type="ApplicationServices"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<variableReferenceExpression name="sysControllersPath"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="data"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="data"/>
															<arrayCreateExpression>
																<createType type="System.Byte[]"/>
															</arrayCreateExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<propertyReferenceExpression name="Cache">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="sysControllersPath"/>
														<variableReferenceExpression name="data"/>
														<primitiveExpression value="null"/>
														<methodInvokeExpression methodName="AddMinutes">
															<target>
																<propertyReferenceExpression name="Now">
																	<typeReferenceExpression type="DateTime"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<primitiveExpression value="10"/>
															</parameters>
														</methodInvokeExpression>
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
										<conditionStatement>
											<condition>
												<variableReferenceExpression name="requiresUser"/>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="User">
														<variableReferenceExpression name="context"/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="data"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="Length">
															<variableReferenceExpression name="data"/>
														</propertyReferenceExpression>
														<primitiveExpression value="0"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="null"/>
												</methodReturnStatement>
											</trueStatements>
											<falseStatements>
												<methodReturnStatement>
													<objectCreateExpression type="MemoryStream">
														<parameters>
															<variableReferenceExpression name="data"/>
														</parameters>
													</objectCreateExpression>
												</methodReturnStatement>
											</falseStatements>
										</conditionStatement>
									</xsl:when>
									<xsl:otherwise>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</xsl:otherwise>
								</xsl:choose>
							</statements>
						</memberMethod>
						<!-- method GetSurvey(string)-->
						<memberMethod returnType="System.String" name="GetSurvey">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="surveyName"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="root">
									<init>
										<methodInvokeExpression methodName="Combine">
											<target>
												<typeReferenceExpression type="Path"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="AppDomainAppPath">
													<typeReferenceExpression type="HttpRuntime"/>
												</propertyReferenceExpression>
												<primitiveExpression value="js"/>
												<primitiveExpression value="surveys"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="survey">
									<init>
										<methodInvokeExpression methodName="GetFileText">
											<target>
												<typeReferenceExpression type="ControllerConfigurationUtility"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Combine">
													<target>
														<typeReferenceExpression type="Path"/>
													</target>
													<parameters>
														<variableReferenceExpression name="root"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="surveyName"/>
															<primitiveExpression value=".min.js"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Combine">
													<target>
														<typeReferenceExpression type="Path"/>
													</target>
													<parameters>
														<variableReferenceExpression name="root"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="surveyName"/>
															<primitiveExpression value=".js"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="layout">
									<init>
										<methodInvokeExpression methodName="GetFileText">
											<target>
												<typeReferenceExpression type="ControllerConfigurationUtility"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Combine">
													<target>
														<typeReferenceExpression type="Path"/>
													</target>
													<parameters>
														<variableReferenceExpression name="root"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="surveyName"/>
															<primitiveExpression value=".html"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Combine">
													<target>
														<typeReferenceExpression type="Path"/>
													</target>
													<parameters>
														<variableReferenceExpression name="root"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="surveyName"/>
															<primitiveExpression value=".htm"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="rules">
									<init>
										<methodInvokeExpression methodName="GetFileText">
											<target>
												<typeReferenceExpression type="ControllerConfigurationUtility"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Combine">
													<target>
														<typeReferenceExpression type="Path"/>
													</target>
													<parameters>
														<variableReferenceExpression name="root"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="surveyName"/>
															<primitiveExpression value=".rules.min.js"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Combine">
													<target>
														<typeReferenceExpression type="Path"/>
													</target>
													<parameters>
														<variableReferenceExpression name="root"/>
														<binaryOperatorExpression operator="Add">
															<variableReferenceExpression name="surveyName"/>
															<primitiveExpression value=".rules.js"/>
														</binaryOperatorExpression>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="survey"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="survey"/>
											<methodInvokeExpression methodName="GetResourceText">
												<target>
													<typeReferenceExpression type="ControllerConfigurationUtility"/>
												</target>
												<parameters>
													<stringFormatExpression format="{$Namespace}.Surveys.{{0}}.min.js">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
													<stringFormatExpression format="{$Namespace}.{{0}}.min.js">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
													<stringFormatExpression format="{$Namespace}.Surveys.{{0}}.js">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
													<stringFormatExpression format="{$Namespace}.{{0}}.js">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="survey"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<throwExceptionStatement>
											<objectCreateExpression type="HttpException">
												<parameters>
													<primitiveExpression value="404"/>
													<primitiveExpression value="Not found."/>
												</parameters>
											</objectCreateExpression>
										</throwExceptionStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="layout"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="layout"/>
											<methodInvokeExpression methodName="GetResourceText">
												<target>
													<typeReferenceExpression type="ControllerConfigurationUtility"/>
												</target>
												<parameters>
													<stringFormatExpression format="{$Namespace}.Surveys.{{0}}.html">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
													<stringFormatExpression format="{$Namespace}.Surveys.{{0}}.htm">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
													<stringFormatExpression format="{$Namespace}.{{0}}.html">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
													<stringFormatExpression format="{$Namespace}.{{0}}.htm">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="rules"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="rules"/>
											<methodInvokeExpression methodName="GetResourceText">
												<target>
													<typeReferenceExpression type="ControllerConfigurationUtility"/>
												</target>
												<parameters>
													<stringFormatExpression format="{$Namespace}.Surveys.{{0}}.rules.min.js">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
													<stringFormatExpression format="{$Namespace}.{{0}}.rules.min.js">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
													<stringFormatExpression format="{$Namespace}.Surveys.{{0}}.rules.js">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
													<stringFormatExpression format="{$Namespace}.{{0}}.rules.js">
														<variableReferenceExpression name="surveyName"/>
													</stringFormatExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="StringBuilder" name="sb">
									<init>
										<objectCreateExpression type="StringBuilder"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="rules"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value="(function() {{"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendFormat">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value="$app.survey('register', '{{0}}', function () {{{{"/>
												<variableReferenceExpression name="surveyName"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<variableReferenceExpression name="rules"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value="}});"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<variableReferenceExpression name="sb"/>
											</target>
											<parameters>
												<primitiveExpression value="}})();"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="layout"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="survey"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="survey"/>
													<primitiveExpression value="}}\s*\)\s*;?\s*$"/>
													<stringFormatExpression format=", layout: '{{0}}' }}}});">
														<methodInvokeExpression methodName="JavaScriptStringEncode">
															<target>
																<typeReferenceExpression type="HttpUtility"/>
															</target>
															<parameters>
																<variableReferenceExpression name="layout"/>
															</parameters>
														</methodInvokeExpression>
													</stringFormatExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodInvokeExpression methodName="Append">
									<target>
										<variableReferenceExpression name="sb"/>
									</target>
									<parameters>
										<variableReferenceExpression name="survey"/>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToString">
										<target>
											<variableReferenceExpression name="sb"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ExecuteVirtualReader(PageRequest, ViewPage) -->
						<memberMethod returnType="DbDataReader" name="ExecuteVirtualReader">
							<attributes family="true"/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="DataTable" name="table">
									<init>
										<objectCreateExpression type="DataTable"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="DataField" name="field"/>
									<target>
										<propertyReferenceExpression name="Fields">
											<variableReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Columns">
													<variableReferenceExpression name="table"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<propertyReferenceExpression name="Name">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
												<typeofExpression type="System.Int32"/>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<variableDeclarationStatement type="DataRow" name="r">
									<init>
										<methodInvokeExpression methodName="NewRow">
											<target>
												<variableReferenceExpression name="table"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="ContainsField">
											<target>
												<argumentReferenceExpression name="page"/>
											</target>
											<parameters>
												<primitiveExpression value="PrimaryKey"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="r"/>
												</target>
												<indices>
													<primitiveExpression value="PrimaryKey"/>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="1"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
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
								<methodReturnStatement>
									<objectCreateExpression type="DataTableReader">
										<parameters>
											<variableReferenceExpression name="table"/>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property HierarchyOrganizationFieldName -->
						<memberProperty type="System.String" name="HierarchyOrganizationFieldName">
							<attributes family="true"/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="HierarchyOrganization__"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method GetRequestedViewType(ViewPage) -->
						<memberMethod returnType="System.String" name="GetRequestedViewType">
							<attributes family="true" />
							<parameters>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="viewType">
									<init>
										<propertyReferenceExpression name="ViewType">
											<argumentReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="viewType"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="viewType"/>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<fieldReferenceExpression name="view"/>
												</target>
												<parameters>
													<primitiveExpression value="type"/>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="viewType"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method EnsureSystemPageFields(PageReuqest, ViewPage, DbCommand) -->
						<memberMethod name="EnsureSystemPageFields">
							<attributes family="true"/>
							<parameters>
								<parameter type="PageRequest" name="request"/>
								<parameter type="ViewPage" name="page"/>
								<parameter type="DbCommand" name="command"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Distinct">
											<argumentReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
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
														<propertyReferenceExpression name="Fields">
															<argumentReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</test>
											<statements>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="IsPrimaryKey">
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
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="RemoveAt">
															<target>
																<propertyReferenceExpression name="Fields">
																	<argumentReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="i"/>
															</parameters>
														</methodInvokeExpression>
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
										<variableDeclarationStatement type="DataField" name="field">
											<init>
												<objectCreateExpression type="DataField"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="Name">
												<variableReferenceExpression name="field"/>
											</propertyReferenceExpression>
											<primitiveExpression value="group_count_"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Type">
												<variableReferenceExpression name="field"/>
											</propertyReferenceExpression>
											<primitiveExpression value="Double"/>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Fields">
													<argumentReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<variableReferenceExpression name="field"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<xsl:if test="$IsPremium='true'">
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="RequiresHierarchy">
													<parameters>
														<argumentReferenceExpression name="page"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement/>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.Boolean" name="requiresHierarchyOrganization">
										<init>
											<primitiveExpression value="false"/>
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
														<variableReferenceExpression name="requiresHierarchyOrganization"/>
														<primitiveExpression value="true"/>
													</assignStatement>
												</trueStatements>
												<falseStatements>
													<conditionStatement>
														<condition>
															<methodInvokeExpression methodName="IsTagged">
																<target>
																	<variableReferenceExpression name="field"/>
																</target>
																<parameters>
																	<primitiveExpression value="hierarchy-organization"/>
																</parameters>
															</methodInvokeExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<variableReferenceExpression name="requiresHierarchyOrganization"/>
																<primitiveExpression value="false"/>
															</assignStatement>
															<breakStatement/>
														</trueStatements>
													</conditionStatement>
												</falseStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
									<conditionStatement>
										<condition>
											<variableReferenceExpression name="requiresHierarchyOrganization"/>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="DataField" name="field">
												<init>
													<objectCreateExpression type="DataField"/>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<propertyReferenceExpression name="Name">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="HierarchyOrganizationFieldName"/>
											</assignStatement>
											<assignStatement>
												<propertyReferenceExpression name="Type">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
												<primitiveExpression value="String"/>
											</assignStatement>
											<assignStatement>
												<propertyReferenceExpression name="Tag">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
												<primitiveExpression value="hierarchy-organization"/>
											</assignStatement>
											<assignStatement>
												<propertyReferenceExpression name="Len">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
												<primitiveExpression value="255"/>
											</assignStatement>
											<assignStatement>
												<propertyReferenceExpression name="Columns">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
												<primitiveExpression value="20"/>
											</assignStatement>
											<assignStatement>
												<propertyReferenceExpression name="Hidden">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
												<primitiveExpression value="true"/>
											</assignStatement>
											<assignStatement>
												<propertyReferenceExpression name="ReadOnly">
													<variableReferenceExpression name="field"/>
												</propertyReferenceExpression>
												<primitiveExpression value="true"/>
											</assignStatement>
											<methodInvokeExpression methodName="Add">
												<target>
													<propertyReferenceExpression name="Fields">
														<argumentReferenceExpression name="page"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="field"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- method RequiresHierarchy(ViewPage) -->
						<memberMethod returnType="System.Boolean" name="RequiresHierarchy">
							<attributes family="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<xsl:if test="$IsPremium='true'">
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueInequality">
												<methodInvokeExpression methodName="GetRequestedViewType">
													<parameters>
														<argumentReferenceExpression name="page"/>
													</parameters>
												</methodInvokeExpression>
												<primitiveExpression value="DataSheet"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<primitiveExpression value="false"/>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
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
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="BooleanAnd">
																<binaryOperatorExpression operator="IdentityInequality">
																	<propertyReferenceExpression name="Filter">
																		<argumentReferenceExpression name="page"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
																<binaryOperatorExpression operator="GreaterThan">
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
													<methodReturnStatement>
														<primitiveExpression value="true"/>
													</methodReturnStatement>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
								</xsl:if>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method DatabaseEngineIs(DbCommand, params string[] -->
						<memberMethod returnType="System.Boolean" name="DatabaseEngineIs">
							<attributes family="true"/>
							<parameters>
								<parameter type="DbCommand" name="command"/>
								<parameter type="params System.String[]" name="flavors"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="DatabaseEngineIs">
										<parameters>
											<propertyReferenceExpression name="FullName">
												<methodInvokeExpression methodName="GetType">
													<target>
														<argumentReferenceExpression name="command"/>
													</target>
												</methodInvokeExpression>
											</propertyReferenceExpression>
											<argumentReferenceExpression name="flavors"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method DatabaseEngineIs(string, params string[] -->
						<memberMethod returnType="System.Boolean" name="DatabaseEngineIs">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="typeName"/>
								<parameter type="params System.String[]" name="flavors"/>
							</parameters>
							<statements>
								<foreachStatement>
									<variable type="System.String" name="s"/>
									<target>
										<argumentReferenceExpression name="flavors"/>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Contains">
													<target>
														<argumentReferenceExpression name="typeName"/>
													</target>
													<parameters>
														<variableReferenceExpression name="s"/>
													</parameters>
												</methodInvokeExpression>
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
						<!-- method FullAccess(bool, params string[]) -->
						<memberMethod name="FullAccess">
							<attributes family="true" static="true"/>
							<parameters>
								<parameter type="System.Boolean" name="grant"/>
								<parameter type="params System.String[]" name="controllers"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="SortedDictionary" name="access">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="System.Int32"/>
									</typeArguments>
									<init>
										<castExpression targetType="SortedDictionary">
											<typeArguments>
												<typeReference type="System.String"/>
												<typeReference type="System.Int32"/>
											</typeArguments>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Items">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="Controller_AccessGranted"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="access"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="access"/>
											<objectCreateExpression type="SortedDictionary">
												<typeArguments>
													<typeReference type="System.String"/>
													<typeReference type="System.Int32"/>
												</typeArguments>
											</objectCreateExpression>
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
													<primitiveExpression value="Controller_AccessGranted"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="access"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<foreachStatement>
									<variable type="System.String" name="c"/>
									<target>
										<argumentReferenceExpression name="controllers"/>
									</target>
									<statements>
										<variableDeclarationStatement type="System.Int32" name="count">
											<init>
												<primitiveExpression value="0"/>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="TryGetValue">
											<target>
												<variableReferenceExpression name="access"/>
											</target>
											<parameters>
												<variableReferenceExpression name="c"/>
												<directionExpression direction="Out">
													<variableReferenceExpression name="count"/>
												</directionExpression>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<variableReferenceExpression name="grant"/>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="count"/>
													<binaryOperatorExpression operator="Add">
														<variableReferenceExpression name="count"/>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</assignStatement>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<variableReferenceExpression name="count"/>
													<binaryOperatorExpression operator="Subtract">
														<variableReferenceExpression name="count"/>
														<primitiveExpression value="1"/>
													</binaryOperatorExpression>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="access"/>
												</target>
												<indices>
													<variableReferenceExpression name="c"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="count"/>
										</assignStatement>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
						<!-- method FullAccessGranted(string) -->
						<memberMethod returnType="System.Boolean" name="FullAccessGranted">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="SortedDictionary" name="access">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="System.Int32"/>
									</typeArguments>
									<init>
										<castExpression targetType="SortedDictionary">
											<typeArguments>
												<typeReference type="System.String"/>
												<typeReference type="System.Int32"/>
											</typeArguments>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Items">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="Controller_AccessGranted"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Int32" name="count">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="access"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="TryGetValue">
											<target>
												<variableReferenceExpression name="access"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="controller"/>
												<directionExpression direction="Out">
													<variableReferenceExpression name="count"/>
												</directionExpression>
											</parameters>
										</methodInvokeExpression>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="count"/>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="TryGetValue">
													<target>
														<variableReferenceExpression name="access"/>
													</target>
													<parameters>
														<primitiveExpression value="*"/>
														<directionExpression direction="Out">
															<variableReferenceExpression name="count"/>
														</directionExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="GreaterThan">
										<variableReferenceExpression name="count"/>
										<primitiveExpression value="0"/>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property AllowPublicAccess -->
						<memberProperty type="System.Boolean" name="AllowPublicAccess">
							<attributes public="true"/>
						</memberProperty>
						<!-- method ValidateViewAccess(string, string, string) -->
						<memberMethod returnType="System.Boolean" name="ValidateViewAccess">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="access"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<propertyReferenceExpression name="AuthorizationIsSupported">
												<typeReferenceExpression type="ApplicationServicesBase"/>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="HttpContext" name="context">
									<init>
										<propertyReferenceExpression name="Current">
											<typeReferenceExpression type="HttpContext"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="BooleanOr">
												<propertyReferenceExpression name="AllowPublicAccess"/>
												<methodInvokeExpression methodName="FullAccessGranted">
													<parameters>
														<argumentReferenceExpression name="controller"/>
													</parameters>
												</methodInvokeExpression>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Params">
															<propertyReferenceExpression name="Request">
																<variableReferenceExpression name="context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="_validationKey"/>
													</indices>
												</arrayIndexerExpression>
												<propertyReferenceExpression name="ValidationKey">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Enabled">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="AccessControlList"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<xsl:if test="$PageImplementation='html'">
									<xsl:if test="$MembershipEnabled='true' or $CustomSecurity='true' or $ActiveDirectory='true'">
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<methodInvokeExpression methodName="Equals">
														<target>
															<argumentReferenceExpression name="controller"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="SiteContentControllerName">
																<typeReferenceExpression type="ApplicationServicesBase"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="OrdinalIgnoreCase">
																<typeReferenceExpression type="StringComparison"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="UserIsInRole">
															<parameters>
																<propertyReferenceExpression name="SiteContentEditors">
																	<typeReferenceExpression type="ApplicationServices"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="false"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</xsl:if>
								</xsl:if>
								<variableDeclarationStatement type="System.Boolean" name="allow">
									<init>
										<primitiveExpression value="true"/>
									</init>
								</variableDeclarationStatement>
								<xsl:if test="$MembershipEnabled='true' or $CustomSecurity='true' or $ActiveDirectory='true'">
									<variableDeclarationStatement type="System.String" name="executionFilePath">
										<init>
											<propertyReferenceExpression name="AppRelativeCurrentExecutionFilePath">
												<propertyReferenceExpression name="Request">
													<variableReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="StartsWith">
														<target>
															<variableReferenceExpression name="executionFilePath"/>
														</target>
														<parameters>
															<primitiveExpression value="~/appservices/"/>
															<propertyReferenceExpression name="OrdinalIgnoreCase">
																<typeReferenceExpression type="StringComparison"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Equals">
														<target>
															<variableReferenceExpression name="executionFilePath"/>
														</target>
														<parameters>
															<primitiveExpression value="~/charthost.aspx"/>
															<propertyReferenceExpression name="OrdinalIgnoreCase">
																<typeReferenceExpression type="StringComparison"/>
															</propertyReferenceExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<unaryOperatorExpression operator="Not">
															<propertyReferenceExpression name="IsAuthenticated">
																<propertyReferenceExpression name="Identity">
																	<propertyReferenceExpression name="User">
																		<variableReferenceExpression name="context"/>
																	</propertyReferenceExpression>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</unaryOperatorExpression>
														<unaryOperatorExpression operator="Not">
															<methodInvokeExpression methodName="StartsWith">
																<target>
																	<argumentReferenceExpression name="controller"/>
																</target>
																<parameters>
																	<primitiveExpression value="aspnet_"/>
																</parameters>
															</methodInvokeExpression>
														</unaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="allow"/>
														<binaryOperatorExpression operator="ValueEquality">
															<argumentReferenceExpression name="access"/>
															<primitiveExpression value="Public"/>
														</binaryOperatorExpression>
													</assignStatement>
													<!--<xsl:if test="$PageImplementation='html'">
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="BooleanAnd">
                                  <unaryOperatorExpression operator="Not">
                                    <variableReferenceExpression name="allow"/>
                                  </unaryOperatorExpression>
                                  <binaryOperatorExpression operator="BooleanAnd">
                                    <propertyReferenceExpression name="IsSiteContentEnabled">
                                      <typeReferenceExpression type="ApplicationServices"/>
                                    </propertyReferenceExpression>
                                    <methodInvokeExpression methodName="Allows">
                                      <target>
                                        <typeReferenceExpression type="WorkflowRegister"/>
                                      </target>
                                      <parameters>
                                        <binaryOperatorExpression operator="Add">
                                          <primitiveExpression value="sys/controllers/"/>
                                          <argumentReferenceExpression name="controller"/>
                                        </binaryOperatorExpression>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </binaryOperatorExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <variableReferenceExpression name="allow"/>
                                  <primitiveExpression value="true"/>
                                </assignStatement>
                              </trueStatements>
                            </conditionStatement>
                          </xsl:if>-->
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<methodReturnStatement>
									<variableReferenceExpression name="allow"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- field resultSetParameters -->
						<memberField type="DbParameterCollection" name="resultSetParameters"/>
						<!-- method ExecuteResultSetTable(ViewPage) -->
						<memberMethod returnType="DataTable" name="ExecuteResultSetTable">
							<attributes final="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<propertyReferenceExpression name="ResultSet">
												<fieldReferenceExpression name="serverRules"/>
											</propertyReferenceExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="null"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="SelectClauseDictionary" name="expressions">
									<init>
										<objectCreateExpression type="SelectClauseDictionary"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="DataColumn" name="c" var="false"/>
									<target>
										<propertyReferenceExpression name="Columns">
											<propertyReferenceExpression name="ResultSet">
												<fieldReferenceExpression name="serverRules"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</target>
									<statements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="expressions"/>
												</target>
												<indices>
													<propertyReferenceExpression name="ColumnName">
														<variableReferenceExpression name="c"/>
													</propertyReferenceExpression>
												</indices>
											</arrayIndexerExpression>
											<propertyReferenceExpression name="ColumnName">
												<variableReferenceExpression name="c"/>
											</propertyReferenceExpression>
										</assignStatement>
									</statements>
								</foreachStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<propertyReferenceExpression name="Count">
												<propertyReferenceExpression name="Fields">
													<argumentReferenceExpression name="page"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="PopulatePageFields">
											<parameters>
												<argumentReferenceExpression name="page"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="EnsurePageFields">
											<parameters>
												<argumentReferenceExpression name="page"/>
												<primitiveExpression value="null"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="DataView" name="resultView">
									<init>
										<objectCreateExpression type="DataView">
											<parameters>
												<propertyReferenceExpression name="ResultSet">
													<fieldReferenceExpression name="serverRules"/>
												</propertyReferenceExpression>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<propertyReferenceExpression name="Sort">
										<variableReferenceExpression name="resultView"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="SortExpression">
										<argumentReferenceExpression name="page"/>
									</propertyReferenceExpression>
								</assignStatement>
								<usingStatement>
									<variable type="DbConnection" name="connection">
										<init>
											<methodInvokeExpression methodName="CreateConnection">
												<parameters>
													<primitiveExpression value="false"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variable>
									<statements>
										<variableDeclarationStatement type="DbCommand" name="command">
											<init>
												<methodInvokeExpression methodName="CreateCommand">
													<target>
														<variableReferenceExpression name="connection"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="StringBuilder" name="sb">
											<init>
												<objectCreateExpression type="StringBuilder"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<fieldReferenceExpression name="resultSetParameters"/>
											<propertyReferenceExpression name="Parameters">
												<variableReferenceExpression name="command"/>
											</propertyReferenceExpression>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="expressions"/>
											</target>
											<parameters>
												<primitiveExpression value="_DataView_RowFilter_"/>
												<primitiveExpression value="true" convertTo="String"/>
											</parameters>
										</methodInvokeExpression>
										<methodInvokeExpression methodName="AppendFilterExpressionsToWhere">
											<parameters>
												<variableReferenceExpression name="sb"/>
												<argumentReferenceExpression name="page"/>
												<variableReferenceExpression name="command"/>
												<variableReferenceExpression name="expressions"/>
												<stringEmptyExpression/>
											</parameters>
										</methodInvokeExpression>
										<variableDeclarationStatement type="System.String" name="filter">
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
												<methodInvokeExpression methodName="StartsWith">
													<target>
														<variableReferenceExpression name="filter"/>
													</target>
													<parameters>
														<primitiveExpression value="where"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="filter"/>
													<methodInvokeExpression methodName="Substring">
														<target>
															<variableReferenceExpression name="filter"/>
														</target>
														<parameters>
															<primitiveExpression value="5"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
										<assignStatement>
											<variableReferenceExpression name="filter"/>
											<methodInvokeExpression methodName="Replace">
												<target>
													<typeReferenceExpression type="Regex"/>
												</target>
												<parameters>
													<variableReferenceExpression name="filter"/>
													<binaryOperatorExpression operator="Add">
														<methodInvokeExpression methodName="Escape">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<fieldReferenceExpression name="parameterMarker"/>
															</parameters>
														</methodInvokeExpression>
														<primitiveExpression value="\w+"/>
													</binaryOperatorExpression>
													<addressOfExpression>
														<methodReferenceExpression methodName="DoReplaceResultSetParameter"/>
													</addressOfExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="RowFilter">
												<variableReferenceExpression name="resultView"/>
											</propertyReferenceExpression>
											<variableReferenceExpression name="filter"/>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="PageSize">
														<argumentReferenceExpression name="page"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="TotalRowCount">
														<variableReferenceExpression name="page"/>
													</propertyReferenceExpression>
													<propertyReferenceExpression name="Count">
														<variableReferenceExpression name="resultView"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</usingStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="RequiresPreFetching">
											<parameters>
												<argumentReferenceExpression name="page"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ResetSkipCount">
											<target>
												<argumentReferenceExpression name="page"/>
											</target>
											<parameters>
												<primitiveExpression value="true"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>

								<variableDeclarationStatement type="DataTable" name="result">
									<init>
										<methodInvokeExpression methodName="ToTable">
											<target>
												<variableReferenceExpression name="resultView"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String[]" name="fieldFilter">
									<init>
										<methodInvokeExpression methodName="RequestedFieldFilter">
											<target>
												<argumentReferenceExpression name="page"/>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="fieldFilter"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="GreaterThan">
												<propertyReferenceExpression name="Length">
													<variableReferenceExpression name="fieldFilter"/>
												</propertyReferenceExpression>
												<primitiveExpression value="0"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.Int32" name="fieldIndex">
											<init>
												<primitiveExpression value="0"/>
											</init>
										</variableDeclarationStatement>
										<whileStatement>
											<test>
												<binaryOperatorExpression operator="LessThan">
													<variableReferenceExpression name="fieldIndex"/>
													<propertyReferenceExpression name="Count">
														<propertyReferenceExpression name="Fields">
															<argumentReferenceExpression name="page"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</test>
											<statements>
												<variableDeclarationStatement name="outputField">
													<init>
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Fields">
																	<argumentReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</target>
															<indices>
																<variableReferenceExpression name="fieldIndex"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="System.String" name="fieldName">
													<init>
														<propertyReferenceExpression name="Name">
															<variableReferenceExpression name="outputField"/>
														</propertyReferenceExpression>
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
																		<variableReferenceExpression name="fieldFilter"/>
																		<variableReferenceExpression name="fieldName"/>
																	</parameters>
																</methodInvokeExpression>
																<primitiveExpression value="-1"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanAnd">
																<binaryOperatorExpression operator="ValueInequality">
																	<variableReferenceExpression name="fieldName"/>
																	<primitiveExpression value="group_count_"/>
																</binaryOperatorExpression>
																<unaryOperatorExpression operator="Not">
																	<propertyReferenceExpression name="IsPrimaryKey">
																		<variableReferenceExpression name="outputField"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="RemoveAt">
															<target>
																<propertyReferenceExpression name="Fields">
																	<argumentReferenceExpression name="page"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="fieldIndex"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<assignStatement>
															<variableReferenceExpression name="fieldIndex"/>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="fieldIndex"/>
																<primitiveExpression value="1"/>
															</binaryOperatorExpression>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
											</statements>
										</whileStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Distinct">
											<variableReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="DataTable" name="groupedTable">
											<init>
												<methodInvokeExpression methodName="ToTable">
													<target>
														<propertyReferenceExpression name="DefaultView">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="true"/>
														<variableReferenceExpression name="fieldFilter"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Columns">
													<variableReferenceExpression name="groupedTable"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<objectCreateExpression type="DataColumn">
													<parameters>
														<primitiveExpression value="group_count_"/>
														<typeofExpression type="System.Int32"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
										<foreachStatement>
											<variable type="DataRow" name="r" var="false"/>
											<target>
												<propertyReferenceExpression name="Rows">
													<variableReferenceExpression name="groupedTable"/>
												</propertyReferenceExpression>
											</target>
											<statements>
												<variableDeclarationStatement type="StringBuilder" name="filterExpression">
													<init>
														<objectCreateExpression type="StringBuilder"/>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable type="System.String" name="fieldName"/>
													<target>
														<variableReferenceExpression name="fieldFilter"/>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="GreaterThan">
																	<propertyReferenceExpression name="Length">
																		<variableReferenceExpression name="filterExpression"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Append">
																	<target>
																		<variableReferenceExpression name="filterExpression"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="and"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<methodInvokeExpression methodName="AppendFormat">
															<target>
																<variableReferenceExpression name="filterExpression"/>
															</target>
															<parameters>
																<primitiveExpression value="({{0}}='{{1}}')"/>
																<variableReferenceExpression name="fieldName"/>
																<methodInvokeExpression methodName="Replace">
																	<target>
																		<methodInvokeExpression methodName="ToString">
																			<target>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="r"/>
																					</target>
																					<indices>
																						<variableReferenceExpression name="fieldName"/>
																					</indices>
																				</arrayIndexerExpression>
																			</target>
																		</methodInvokeExpression>
																	</target>
																	<parameters>
																		<primitiveExpression value="'"/>
																		<primitiveExpression value="\'\'"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
												<assignStatement>
													<propertyReferenceExpression name="RowFilter">
														<propertyReferenceExpression name="DefaultView">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="ToString">
														<target>
															<variableReferenceExpression name="filterExpression"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="r"/>
														</target>
														<indices>
															<primitiveExpression value="group_count_"/>
														</indices>
													</arrayIndexerExpression>
													<propertyReferenceExpression name="Count">
														<propertyReferenceExpression name="DefaultView">
															<variableReferenceExpression name="result"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</assignStatement>
											</statements>
										</foreachStatement>
										<assignStatement>
											<variableReferenceExpression name="result"/>
											<variableReferenceExpression name="groupedTable"/>
										</assignStatement>
										<!--<assignStatement>
                      <propertyReferenceExpression name="TotalRowCount">
                        <argumentReferenceExpression name="page"/>
                      </propertyReferenceExpression>
                      <propertyReferenceExpression name="Count">
                        <propertyReferenceExpression name="Rows">
                          <variableReferenceExpression name="result"/>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                    </assignStatement>-->
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<propertyReferenceExpression name="ResultSetSize">
										<fieldReferenceExpression name="serverRules"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="Count">
										<propertyReferenceExpression name="Rows">
											<variableReferenceExpression name="result"/>
										</propertyReferenceExpression>
									</propertyReferenceExpression>
								</assignStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ExecuteResultSetReader(ViewPage) -->
						<memberMethod returnType="DbDataReader" name="ExecuteResultSetReader">
							<attributes final="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<propertyReferenceExpression name="ResultSet">
												<fieldReferenceExpression name="serverRules"/>
											</propertyReferenceExpression>
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
									<methodInvokeExpression methodName="CreateDataReader">
										<target>
											<methodInvokeExpression methodName="ExecuteResultSetTable">
												<parameters>
													<argumentReferenceExpression name="page"/>
												</parameters>
											</methodInvokeExpression>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method DoReplaceResultSetParameter(Match) -->
						<memberMethod returnType="System.String" name="DoReplaceResultSetParameter">
							<attributes family="true"/>
							<parameters>
								<parameter type="Match" name="m"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="DbParameter" name="p">
									<init>
										<arrayIndexerExpression>
											<target>
												<fieldReferenceExpression name="resultSetParameters"/>
											</target>
											<indices>
												<propertyReferenceExpression name="Value">
													<argumentReferenceExpression  name="m"/>
												</propertyReferenceExpression>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<stringFormatExpression format="'{{0}}'">
										<methodInvokeExpression methodName="Replace">
											<target>
												<methodInvokeExpression methodName="ToString">
													<target>
														<propertyReferenceExpression name="Value">
															<variableReferenceExpression name="p"/>
														</propertyReferenceExpression>
													</target>
												</methodInvokeExpression>
											</target>
											<parameters>
												<primitiveExpression value="'"/>
												<primitiveExpression value="''"/>
											</parameters>
										</methodInvokeExpression>
									</stringFormatExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method RequiresPreFetching(ViewPage) -->
						<memberMethod returnType="System.Boolean" name="RequiresPreFetching">
							<attributes final="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="viewType">
									<init>
										<propertyReferenceExpression name="ViewType">
											<argumentReferenceExpression name="page"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="viewType"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="viewType"/>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<fieldReferenceExpression name="view"/>
												</target>
												<parameters>
													<primitiveExpression value="type"/>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanAnd">
										<binaryOperatorExpression operator="ValueInequality">
											<propertyReferenceExpression name="PageSize">
												<argumentReferenceExpression name="page"/>
											</propertyReferenceExpression>
											<propertyReferenceExpression name="MaxValue">
												<typeReferenceExpression type="Int32"/>
											</propertyReferenceExpression>
										</binaryOperatorExpression>
										<methodInvokeExpression methodName="SupportsCaching">
											<target>
												<objectCreateExpression type="ControllerUtilities"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="page"/>
												<variableReferenceExpression name="viewType"/>
											</parameters>
										</methodInvokeExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>

				<!-- type ControllerUtilities -->
				<typeDeclaration name="ControllerUtilities" isPartial="true">
					<baseTypes>
						<typeReference type="ControllerUtilitiesBase"/>
					</baseTypes>
				</typeDeclaration>

				<!-- type ControllerUtilitiesBase -->
				<typeDeclaration name="ControllerUtilitiesBase">
					<members>
						<!-- property UtcOffsetInMinutes -->
						<!--<memberProperty type="System.Double" name="UtcOffsetInMinutes">
              <attributes public="true" static="true"/>
              <getStatements>
                <methodReturnStatement>
                  <propertyReferenceExpression name="TotalMinutes">
                    <methodInvokeExpression methodName="GetUtcOffset">
                      <target>
                        <propertyReferenceExpression name="CurrentTimeZone">
                          <typeReferenceExpression type="TimeZone"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Now">
                          <typeReferenceExpression type="DateTime"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>-->
						<!-- method GetActionView(string string, string) -->
						<memberMethod returnType="System.String" name="GetActionView">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="action"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<argumentReferenceExpression name="view"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method UserIsInRole(params string[])-->
						<memberMethod returnType="System.Boolean" name="UserIsInRole">
							<attributes public="true"/>
							<parameters>
								<parameter type="params System.String[]" name="roles"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="HttpContext" name="context">
									<init>
										<propertyReferenceExpression name="Current">
											<typeReferenceExpression type="HttpContext"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<variableReferenceExpression name="context"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="System.Int32" name="count">
									<init>
										<primitiveExpression value="0"/>
									</init>
								</variableDeclarationStatement>
								<foreachStatement>
									<variable type="System.String" name="r"/>
									<target>
										<argumentReferenceExpression name="roles"/>
									</target>
									<statements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<argumentReferenceExpression name="r"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable type="System.String" name="role"/>
													<target>
														<methodInvokeExpression methodName="Split">
															<target>
																<argumentReferenceExpression name="r"/>
															</target>
															<parameters>
																<primitiveExpression value="," convertTo="Char"/>
															</parameters>
														</methodInvokeExpression>
													</target>
													<statements>
														<variableDeclarationStatement type="System.String" name="testRole">
															<init>
																<methodInvokeExpression methodName="Trim">
																	<target>
																		<variableReferenceExpression name="role"/>
																	</target>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<variableReferenceExpression name="testRole"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<!-- 
                                if (!context.User.Identity.IsAuthenticated)
                                    return false;
                                -->
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<propertyReferenceExpression name="IsAuthenticated">
																				<propertyReferenceExpression name="Identity">
																					<propertyReferenceExpression name="User">
																						<variableReferenceExpression name="context"/>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodReturnStatement>
																			<primitiveExpression value="false"/>
																		</methodReturnStatement>
																	</trueStatements>
																</conditionStatement>
																<variableDeclarationStatement type="System.String" name="roleKey">
																	<init>
																		<binaryOperatorExpression operator="Add">
																			<primitiveExpression value="IsInRole_"/>
																			<variableReferenceExpression name="testRole"/>
																		</binaryOperatorExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="System.Object" name="isInRole">
																	<init>
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Items">
																					<variableReferenceExpression name="context"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<variableReferenceExpression name="roleKey"/>
																			</indices>
																		</arrayIndexerExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityEquality">
																			<variableReferenceExpression name="isInRole"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="isInRole"/>
																			<methodInvokeExpression methodName="IsInRole">
																				<target>
																					<propertyReferenceExpression name="User">
																						<variableReferenceExpression name="context"/>
																					</propertyReferenceExpression>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="testRole"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Items">
																						<variableReferenceExpression name="context"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<variableReferenceExpression name="roleKey"/>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="isInRole"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<castExpression targetType="System.Boolean">
																			<variableReferenceExpression name="isInRole"/>
																		</castExpression>
																	</condition>
																	<trueStatements>
																		<methodReturnStatement>
																			<primitiveExpression value="true"/>
																		</methodReturnStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<assignStatement>
															<variableReferenceExpression name="count"/>
															<binaryOperatorExpression operator="Add">
																<variableReferenceExpression name="count"/>
																<primitiveExpression value="1"/>
															</binaryOperatorExpression>
														</assignStatement>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<methodReturnStatement>
									<binaryOperatorExpression operator="ValueEquality">
										<variableReferenceExpression name="count"/>
										<primitiveExpression value="0"/>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property SupportsScrollingInDataSheet -->
						<memberProperty type="System.Boolean" name="SupportsScrollingInDataSheet">
							<attributes public="true"/>
							<getStatements>
								<xsl:choose>
									<xsl:when test="$IsPremium='true'">
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</xsl:when>
									<xsl:otherwise>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</xsl:otherwise>
								</xsl:choose>
							</getStatements>
						</memberProperty>
						<!-- property SupportsLastEnteredValues(string)  -->
						<memberMethod returnType="System.Boolean" name="SupportsLastEnteredValues">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SupportsCaching(ViewPage) -->
						<memberMethod returnType="System.Boolean" name="SupportsCaching">
							<attributes public="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
								<parameter type="System.String" name="viewType"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="viewType"/>
											<primitiveExpression value="DataSheet"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<xsl:choose>
											<xsl:when test="$Mobile='true'">
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="Not">
																<propertyReferenceExpression name="SupportsScrollingInDataSheet"/>
															</unaryOperatorExpression>
															<unaryOperatorExpression operator="Not">
																<propertyReferenceExpression name="IsTouchClient">
																	<typeReferenceExpression type="ApplicationServices"/>
																</propertyReferenceExpression>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="SupportsCaching">
																<argumentReferenceExpression name="page"/>
															</propertyReferenceExpression>
															<primitiveExpression value="false"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</xsl:when>
											<xsl:otherwise>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<propertyReferenceExpression name="SupportsScrollingInDataSheet"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="SupportsCaching">
																<argumentReferenceExpression name="page"/>
															</propertyReferenceExpression>
															<primitiveExpression value="false"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</xsl:otherwise>
										</xsl:choose>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<argumentReferenceExpression name="viewType"/>
													<primitiveExpression value="Grid"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<xsl:choose>
													<xsl:when test="$Mobile='true'">
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<propertyReferenceExpression name="IsTouchClient">
																		<typeReferenceExpression type="ApplicationServices"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<propertyReferenceExpression name="SupportsCaching">
																		<argumentReferenceExpression name="page"/>
																	</propertyReferenceExpression>
																	<primitiveExpression value="false"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</xsl:when>
													<xsl:otherwise>
														<assignStatement>
															<propertyReferenceExpression name="SupportsCaching">
																<argumentReferenceExpression name="page"/>
															</propertyReferenceExpression>
															<primitiveExpression value="false"/>
														</assignStatement>
													</xsl:otherwise>
												</xsl:choose>
											</trueStatements>
											<falseStatements>
												<assignStatement>
													<propertyReferenceExpression name="SupportsCaching">
														<argumentReferenceExpression name="page"/>
													</propertyReferenceExpression>
													<primitiveExpression value="false"/>
												</assignStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<propertyReferenceExpression name="SupportsCaching">
										<argumentReferenceExpression name="page"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
								<!--<xsl:choose>
                  <xsl:when test="$IsPremium='true'">
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <unaryOperatorExpression operator="Not">
                            <propertyReferenceExpression name="SupportsScrollingInDataSheet"/>
                          </unaryOperatorExpression>
                          <unaryOperatorExpression operator="Not">
                            <propertyReferenceExpression name="IsTouchClient">
                              <typeReferenceExpression type="ApplicationServices"/>
                            </propertyReferenceExpression>
                          </unaryOperatorExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <propertyReferenceExpression name="SupportsCaching">
                            <argumentReferenceExpression name="page"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="false"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodReturnStatement>
                      <propertyReferenceExpression name="SupportsCaching">
                        <argumentReferenceExpression name="page"/>
                      </propertyReferenceExpression>
                    </methodReturnStatement>
                  </xsl:when>
                  <xsl:otherwise>
                    <methodReturnStatement>
                      <primitiveExpression value="false"/>
                    </methodReturnStatement>
                  </xsl:otherwise>
                </xsl:choose>-->
							</statements>
						</memberMethod>
						<!-- method ValidateName(string)-->
						<memberMethod returnType="System.String" name="ValidateName">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="name"/>
							</parameters>
							<statements>
								<comment>Prevent injection of single quote in the name used in XPath queries.</comment>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="name"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="Replace">
												<target>
													<variableReferenceExpression name="name"/>
												</target>
												<parameters>
													<primitiveExpression value="'"/>
													<primitiveExpression value="_"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="name"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- type ControllerFactory -->
				<typeDeclaration name="ControllerFactory">
					<members>
						<!-- method CreateDataController -->
						<memberMethod returnType="IDataController" name="CreateDataController">
							<attributes public="true" static="true"/>
							<statements>
								<methodReturnStatement>
									<objectCreateExpression type="Controller"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AutoCompleteManager -->
						<memberMethod returnType="IAutoCompleteManager" name="CreateAutoCompleteManager">
							<attributes public="true" static="true"/>
							<statements>
								<methodReturnStatement>
									<objectCreateExpression type="Controller"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateDataEngine -->
						<memberMethod returnType="IDataEngine" name="CreateDataEngine">
							<attributes public="true" static="true"/>
							<statements>
								<methodReturnStatement>
									<objectCreateExpression type="Controller"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetDataControllerStream(string) -->
						<memberMethod returnType="Stream" name="GetDataControllerStream">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetDataControllerStream">
										<target>
											<objectCreateExpression type="Controller"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="controller"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetSurvey(string) -->
						<memberMethod returnType="System.String" name="GetSurvey">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="survey"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetSurvey">
										<target>
											<objectCreateExpression type="Controller"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="survey"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class StringEncryptor -->
				<typeDeclaration name="StringEncryptor" isPartial="true">
					<baseTypes>
						<typeReference type="StringEncryptorBase"/>
					</baseTypes>
					<members>
						<!-- 
       public static string ToString(object o)
        {
            var enc = new StringEncryptor();
            return enc.Encrypt(o.ToString());
        }

        public static string ToBase64String(object o)
        {
            var s = ToString(o);
            return Convert.ToBase64String(Encoding.Default.GetBytes(s));
        }

        public static string FromString(string s)
        {
            var enc = new StringEncryptor();
            return enc.Decrypt(s);
        }

        public static string FromBase64String(string s)
        {
            return FromString(Encoding.Default.GetString(Convert.FromBase64String(s)));
        }
            -->
						<!-- method ToString(object) -->
						<memberMethod returnType="System.String" name="ToString" >
							<attributes public="true" static="true" overloaded="true"/>
							<parameters>
								<parameter type="System.Object" name="o"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="StringEncryptor" name="enc">
									<init>
										<objectCreateExpression type="StringEncryptor"/>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Encrypt">
										<target>
											<variableReferenceExpression name="enc"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="ToString">
												<target>
													<argumentReferenceExpression name="o"/>
												</target>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToBase64String(object) -->
						<memberMethod returnType="System.String" name="ToBase64String">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.Object" name="o"/>
							</parameters>
							<statements>
								<methodReturnStatement>
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
														<parameters>
															<argumentReferenceExpression name="o"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method FromString(string) -->
						<memberMethod returnType="System.String" name="FromString">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="s"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="StringEcryptor" name="enc">
									<init>
										<objectCreateExpression type="StringEncryptor"/>
									</init>
								</variableDeclarationStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Decrypt">
										<target>
											<variableReferenceExpression name="enc"/>
										</target>
										<parameters>
											<argumentReferenceExpression name="s"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method FromBase64String(string) -->
						<memberMethod returnType="System.String" name="FromBase64String">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="System.String" name="s"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="FromString">
										<parameters>
											<methodInvokeExpression methodName="GetString">
												<target>
													<propertyReferenceExpression name="Default">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<methodInvokeExpression methodName="FromBase64String">
														<target>
															<typeReferenceExpression type="Convert"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="s"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
				<!-- class StringEncryptorBase -->
				<typeDeclaration name="StringEncryptorBase">
					<members>
						<xsl:if test="$IsUnlimited='true'">
							<!-- property Key -->
							<memberProperty type="System.Byte[]" name="Key">
								<attributes public="true"/>
								<getStatements>
									<methodReturnStatement>
										<arrayCreateExpression>
											<createType type="System.Byte"/>
											<initializers>
												<primitiveExpression value="253"/>
												<primitiveExpression value="124"/>
												<primitiveExpression value="8"/>
												<primitiveExpression value="201"/>
												<primitiveExpression value="31"/>
												<primitiveExpression value="27"/>
												<primitiveExpression value="89"/>
												<primitiveExpression value="189"/>
												<primitiveExpression value="251"/>
												<primitiveExpression value="47"/>
												<primitiveExpression value="198"/>
												<primitiveExpression value="241"/>
												<primitiveExpression value="38"/>
												<primitiveExpression value="78"/>
												<primitiveExpression value="198"/>
												<primitiveExpression value="193"/>
												<primitiveExpression value="18"/>
												<primitiveExpression value="179"/>
												<primitiveExpression value="209"/>
												<primitiveExpression value="220"/>
												<primitiveExpression value="34"/>
												<primitiveExpression value="84"/>
												<primitiveExpression value="178"/>
												<primitiveExpression value="99"/>
												<primitiveExpression value="193"/>
												<primitiveExpression value="84"/>
												<primitiveExpression value="64"/>
												<primitiveExpression value="15"/>
												<primitiveExpression value="188"/>
												<primitiveExpression value="98"/>
												<primitiveExpression value="101"/>
												<primitiveExpression value="153"/>
											</initializers>
										</arrayCreateExpression>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- property IV -->
							<memberProperty type="System.Byte[]" name="IV">
								<attributes public="true"/>
								<getStatements>
									<methodReturnStatement>
										<arrayCreateExpression>
											<createType type="System.Byte"/>
											<initializers>
												<primitiveExpression value="87"/>
												<primitiveExpression value="84"/>
												<primitiveExpression value="163"/>
												<primitiveExpression value="98"/>
												<primitiveExpression value="205"/>
												<primitiveExpression value="255"/>
												<primitiveExpression value="139"/>
												<primitiveExpression value="173"/>
												<primitiveExpression value="16"/>
												<primitiveExpression value="88"/>
												<primitiveExpression value="88"/>
												<primitiveExpression value="254"/>
												<primitiveExpression value="133"/>
												<primitiveExpression value="176"/>
												<primitiveExpression value="55"/>
												<primitiveExpression value="112"/>
											</initializers>
										</arrayCreateExpression>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
						</xsl:if>
						<!-- method Encrypt(string) -->
						<memberMethod returnType="System.String" name="Encrypt">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="s"/>
							</parameters>
							<statements>
								<xsl:choose>
									<xsl:when test="$IsUnlimited='true'">
										<variableDeclarationStatement type="System.Byte[]" name="plainText">
											<init>
												<methodInvokeExpression methodName="GetBytes">
													<target>
														<propertyReferenceExpression name="Default">
															<typeReferenceExpression type="Encoding"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<stringFormatExpression format="{{0}}$${{1}}">
															<argumentReferenceExpression name="s"/>
															<methodInvokeExpression methodName="GetHashCode">
																<target>
																	<argumentReferenceExpression name="s"/>
																</target>
															</methodInvokeExpression>
														</stringFormatExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Byte[]" name="cipherText"/>
										<usingStatement>
											<variable type="MemoryStream" name="output">
												<init>
													<objectCreateExpression type="MemoryStream"/>
												</init>
											</variable>
											<statements>
												<usingStatement>
													<variable type="Stream" name="cOutput">
														<init>
															<objectCreateExpression type="CryptoStream">
																<parameters>
																	<variableReferenceExpression name="output"/>
																	<methodInvokeExpression methodName="CreateEncryptor">
																		<target>
																			<methodInvokeExpression methodName="Create">
																				<target>
																					<typeReferenceExpression type="Aes"/>
																				</target>
																			</methodInvokeExpression>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Key"/>
																			<propertyReferenceExpression name="IV"/>
																		</parameters>
																	</methodInvokeExpression>
																	<propertyReferenceExpression name="Write">
																		<typeReferenceExpression type="CryptoStreamMode"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</init>
													</variable>
													<statements>
														<methodInvokeExpression methodName="Write">
															<target>
																<typeReferenceExpression type="cOutput"/>
															</target>
															<parameters>
																<variableReferenceExpression name="plainText"/>
																<primitiveExpression value="0"/>
																<propertyReferenceExpression name="Length">
																	<variableReferenceExpression name="plainText"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</usingStatement>
												<assignStatement>
													<variableReferenceExpression name="cipherText"/>
													<methodInvokeExpression methodName="ToArray">
														<target>
															<variableReferenceExpression name="output"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</statements>
										</usingStatement>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ToBase64String">
												<target>
													<typeReferenceExpression type="Convert"/>
												</target>
												<parameters>
													<variableReferenceExpression name="cipherText"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</xsl:when>
									<xsl:otherwise>
										<methodReturnStatement>
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
															<argumentReferenceExpression name="s"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</xsl:otherwise>
								</xsl:choose>
							</statements>
						</memberMethod>
						<!-- method Decrypt(string) -->
						<memberMethod returnType="System.String" name="Decrypt">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="s"/>
							</parameters>
							<statements>
								<xsl:choose>
									<xsl:when test="$IsUnlimited='true'">
										<variableDeclarationStatement type="System.Byte[]" name="cipherText">
											<init>
												<methodInvokeExpression methodName="FromBase64String">
													<target>
														<typeReferenceExpression type="Convert"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="s"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.Byte[]" name="plainText"/>
										<usingStatement>
											<variable type="MemoryStream" name="output">
												<init>
													<objectCreateExpression type="MemoryStream"/>
												</init>
											</variable>
											<statements>
												<usingStatement>
													<variable type="Stream" name="cOutput">
														<init>
															<objectCreateExpression type="CryptoStream">
																<parameters>
																	<variableReferenceExpression name="output"/>
																	<methodInvokeExpression methodName="CreateDecryptor">
																		<target>
																			<methodInvokeExpression methodName="Create">
																				<target>
																					<typeReferenceExpression type="Aes"/>
																				</target>
																			</methodInvokeExpression>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Key"/>
																			<propertyReferenceExpression name="IV"/>
																		</parameters>
																	</methodInvokeExpression>
																	<propertyReferenceExpression name="Write">
																		<typeReferenceExpression type="CryptoStreamMode"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</init>
													</variable>
													<statements>
														<methodInvokeExpression methodName="Write">
															<target>
																<variableReferenceExpression name="cOutput"/>
															</target>
															<parameters>
																<variableReferenceExpression name="cipherText"/>
																<primitiveExpression value="0"/>
																<propertyReferenceExpression name="Length">
																	<variableReferenceExpression name="cipherText"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</usingStatement>
												<assignStatement>
													<variableReferenceExpression name="plainText"/>
													<methodInvokeExpression methodName="ToArray">
														<target>
															<variableReferenceExpression name="output"/>
														</target>
													</methodInvokeExpression>
												</assignStatement>
											</statements>
										</usingStatement>
										<variableDeclarationStatement type="System.String" name="plain">
											<init>
												<methodInvokeExpression methodName="GetString">
													<target>
														<propertyReferenceExpression name="Default">
															<typeReferenceExpression type="Encoding"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="plainText"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement type="System.String[]" name="parts">
											<init>
												<methodInvokeExpression methodName="Split">
													<target>
														<variableReferenceExpression name="plain"/>
													</target>
													<parameters>
														<arrayCreateExpression>
															<createType type="System.String"/>
															<initializers>
																<primitiveExpression value="$$"/>
															</initializers>
														</arrayCreateExpression>
														<propertyReferenceExpression name="None">
															<typeReferenceExpression type="StringSplitOptions"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="ValueInequality">
														<propertyReferenceExpression name="Length">
															<variableReferenceExpression name="parts"/>
														</propertyReferenceExpression>
														<primitiveExpression value="2"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="ValueInequality">
														<methodInvokeExpression methodName="GetHashCode">
															<target>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="parts"/>
																	</target>
																	<indices>
																		<primitiveExpression value="0"/>
																	</indices>
																</arrayIndexerExpression>
															</target>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="ToInt32">
															<target>
																<typeReferenceExpression type="Convert"/>
															</target>
															<parameters>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="parts"/>
																	</target>
																	<indices>
																		<primitiveExpression value="1"/>
																	</indices>
																</arrayIndexerExpression>
															</parameters>
														</methodInvokeExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<throwExceptionStatement>
													<objectCreateExpression type="Exception">
														<parameters>
															<primitiveExpression value="Attempt to alter the hashed URL."/>
														</parameters>
													</objectCreateExpression>
												</throwExceptionStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="parts"/>
												</target>
												<indices>
													<primitiveExpression value="0"/>
												</indices>
											</arrayIndexerExpression>
										</methodReturnStatement>
									</xsl:when>
									<xsl:otherwise>
										<methodReturnStatement>
											<methodInvokeExpression methodName="GetString">
												<target>
													<propertyReferenceExpression name="Default">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<methodInvokeExpression methodName="FromBase64String">
														<target>
															<typeReferenceExpression type="Convert"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="s"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</xsl:otherwise>
								</xsl:choose>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>

	<xsl:template name="ExecuteCommand">
		<conditionStatement>
			<condition>
				<binaryOperatorExpression operator="ValueInequality">
					<propertyReferenceExpression name="CommandName">
						<variableReferenceExpression name="args"/>
					</propertyReferenceExpression>
					<primitiveExpression value="Delete"/>
				</binaryOperatorExpression>
			</condition>
			<trueStatements>
				<methodInvokeExpression methodName="ProcessOneToOneFields">
					<parameters>
						<variableReferenceExpression name="args"/>
					</parameters>
				</methodInvokeExpression>
			</trueStatements>
		</conditionStatement>
		<conditionStatement>
			<condition>
				<binaryOperatorExpression operator="ValueEquality">
					<propertyReferenceExpression name="CommandName">
						<variableReferenceExpression name="args"/>
					</propertyReferenceExpression>
					<primitiveExpression value="Delete"/>
				</binaryOperatorExpression>
			</condition>
			<trueStatements>
				<methodInvokeExpression methodName="ProcessManyToManyFields">
					<parameters>
						<variableReferenceExpression name="args"/>
					</parameters>
				</methodInvokeExpression>
			</trueStatements>
		</conditionStatement>
		<conditionStatement>
			<condition>
				<methodInvokeExpression methodName="ConfigureCommand">
					<parameters>
						<variableReferenceExpression name="command"/>
						<primitiveExpression value="null"/>
						<propertyReferenceExpression name="SqlCommandType">
							<variableReferenceExpression name="args"/>
						</propertyReferenceExpression>
						<propertyReferenceExpression name="Values">
							<variableReferenceExpression name="args"/>
						</propertyReferenceExpression>
					</parameters>
				</methodInvokeExpression>
			</condition>
			<trueStatements>
				<assignStatement>
					<propertyReferenceExpression name="RowsAffected">
						<variableReferenceExpression name="result"/>
					</propertyReferenceExpression>
					<methodInvokeExpression methodName="ExecuteNonQuery">
						<target>
							<variableReferenceExpression name="command"/>
						</target>
					</methodInvokeExpression>
				</assignStatement>
				<conditionStatement>
					<condition>
						<binaryOperatorExpression operator="ValueEquality">
							<propertyReferenceExpression name="RowsAffected">
								<variableReferenceExpression name="result"/>
							</propertyReferenceExpression>
							<primitiveExpression value="0"/>
						</binaryOperatorExpression>
					</condition>
					<trueStatements>
						<assignStatement>
							<propertyReferenceExpression name="RowNotFound">
								<variableReferenceExpression name="result"/>
							</propertyReferenceExpression>
							<primitiveExpression value="true"/>
						</assignStatement>
						<methodInvokeExpression methodName="Add">
							<target>
								<propertyReferenceExpression name="Errors">
									<variableReferenceExpression name="result"/>
								</propertyReferenceExpression>
							</target>
							<parameters>
								<methodInvokeExpression methodName="Replace">
									<target>
										<typeReferenceExpression type="Localizer"/>
									</target>
									<parameters>
										<primitiveExpression value="RecordChangedByAnotherUser"/>
										<primitiveExpression value="The record has been changed by another user."/>
									</parameters>
								</methodInvokeExpression>
							</parameters>
						</methodInvokeExpression>
					</trueStatements>
					<falseStatements>
						<methodInvokeExpression methodName="ExecutePostActionCommands">
							<parameters>
								<argumentReferenceExpression name="args"/>
								<variableReferenceExpression name="result"/>
								<variableReferenceExpression name="connection"/>
							</parameters>
						</methodInvokeExpression>
					</falseStatements>
				</conditionStatement>
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
				<methodInvokeExpression methodName="ProcessManyToManyFields">
					<parameters>
						<variableReferenceExpression name="args"/>
					</parameters>
				</methodInvokeExpression>
			</trueStatements>
		</conditionStatement>
		<conditionStatement>
			<condition>
				<binaryOperatorExpression operator="ValueEquality">
					<propertyReferenceExpression name="CommandName">
						<variableReferenceExpression name="args"/>
					</propertyReferenceExpression>
					<primitiveExpression value="Delete"/>
				</binaryOperatorExpression>
			</condition>
			<trueStatements>
				<methodInvokeExpression methodName="ProcessOneToOneFields">
					<parameters>
						<variableReferenceExpression name="args"/>
					</parameters>
				</methodInvokeExpression>
			</trueStatements>
		</conditionStatement>
		<conditionStatement>
			<condition>
				<binaryOperatorExpression operator="IdentityInequality">
					<variableReferenceExpression name="handler"/>
					<primitiveExpression value="null"/>
				</binaryOperatorExpression>
			</condition>
			<trueStatements>
				<methodInvokeExpression methodName="AfterSqlAction">
					<target>
						<variableReferenceExpression name="handler"/>
					</target>
					<parameters>
						<argumentReferenceExpression name="args"/>
						<variableReferenceExpression name="result"/>
					</parameters>
				</methodInvokeExpression>
			</trueStatements>
			<falseStatements>
				<methodInvokeExpression methodName="ExecuteServerRules">
					<target>
						<fieldReferenceExpression name="serverRules"/>
					</target>
					<parameters>
						<argumentReferenceExpression name="args"/>
						<argumentReferenceExpression name="result"/>
						<propertyReferenceExpression name="After">
							<typeReferenceExpression type="ActionPhase"/>
						</propertyReferenceExpression>
					</parameters>
				</methodInvokeExpression>
			</falseStatements>
		</conditionStatement>
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
				<methodInvokeExpression methodName="ProcessArguments">
					<target>
						<propertyReferenceExpression name="PlugIn">
							<fieldReferenceExpression name="config"/>
						</propertyReferenceExpression>
					</target>
					<parameters>
						<argumentReferenceExpression name="args"/>
						<variableReferenceExpression name="result"/>
						<methodInvokeExpression methodName="CreateViewPage"/>
					</parameters>
				</methodInvokeExpression>
			</trueStatements>
		</conditionStatement>
	</xsl:template>
</xsl:stylesheet>
