<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="IsPremium"/>

	<xsl:template match="/">
		<compileUnit namespace="{a:project/a:namespace}.Data">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Data.Common"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Xml"/>
				<namespaceImport name="System.Xml.XPath"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Caching"/>
				<namespaceImport name="System.Web.Configuration"/>
				<namespaceImport name="System.Web.Security"/>
			</imports>
			<types>
				<!-- enum DataFieldMaskType -->
				<typeDeclaration name="DataFieldMaskType" isEnum="true">
					<members>
						<memberField name="None">
							<attributes public="true"/>
						</memberField>
						<memberField name="Date">
							<attributes public="true"/>
						</memberField>
						<memberField name="Number">
							<attributes public="true"/>
						</memberField>
						<memberField name="Time">
							<attributes public="true"/>
						</memberField>
						<memberField name="DateTime">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- enum DataFieldAggregate -->
				<typeDeclaration name="DataFieldAggregate" isEnum="true">
					<members>
						<memberField name="None">
							<attributes public="true"/>
						</memberField>
						<memberField name="Sum">
							<attributes public="true"/>
						</memberField>
						<memberField name="Count">
							<attributes public="true"/>
						</memberField>
						<memberField name="Average">
							<attributes public="true"/>
						</memberField>
						<memberField name="Max">
							<attributes public="true"/>
						</memberField>
						<memberField name="Min">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- enum OnDemandDisplayStyle -->
				<typeDeclaration name="OnDemandDisplayStyle" isEnum="true">
					<members>
						<memberField name="Thumbnail">
							<attributes public="true"/>
						</memberField>
						<memberField name="Link">
							<attributes public="true"/>
						</memberField>
						<memberField name="Signature">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- enum TextInputMode -->
				<typeDeclaration name="TextInputMode" isEnum="true">
					<members>
						<memberField name="Text">
							<attributes public="true"/>
						</memberField>
						<memberField name="Password">
							<attributes public="true"/>
						</memberField>
						<memberField name="RichText">
							<attributes public="true"/>
						</memberField>
						<memberField name="Note">
							<attributes public="true"/>
						</memberField>
						<memberField name="Static">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- FielSearchMode -->
				<typeDeclaration name="FieldSearchMode" isEnum="true">
					<members>
						<memberField name="Default">
							<attributes public="true"/>
						</memberField>
						<memberField name="Required">
							<attributes public="true"/>
						</memberField>
						<memberField name="Suggested">
							<attributes public="true"/>
						</memberField>
						<memberField name="Allowed">
							<attributes public="true"/>
						</memberField>
						<memberField name="Forbidden">
							<attributes public="true"/>
						</memberField>
					</members>
				</typeDeclaration>
				<!-- class DataField -->
				<typeDeclaration name="DataField">
					<members>
						<!-- property Name -->
						<memberProperty type="System.String" name="Name">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property AliasName -->
						<memberProperty type="System.String" name="AliasName">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Tag -->
						<memberProperty type="System.String" name="Tag">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Type -->
						<memberProperty type="System.String" name="Type">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Len -->
						<memberProperty type="System.Int32" name="Len">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Label -->
						<memberProperty type="System.String" name="Label">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property IsPrimaryKey -->
						<memberProperty type="System.Boolean" name="IsPrimaryKey">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ReadOnly -->
						<memberProperty type="System.Boolean" name="ReadOnly">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DefaultValue -->
						<memberField type="System.String" name="defaultValue"/>
						<memberProperty type="System.String" name="DefaultValue">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="defaultValue"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property HasDefaultValue -->
						<memberProperty type="System.Boolean" name="HasDefaultValue">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<unaryOperatorExpression operator="IsNotNullOrEmpty">
										<fieldReferenceExpression name="defaultValue"/>
									</unaryOperatorExpression>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property HeaderText -->
						<memberField type="System.String" name="headerText"/>
						<memberProperty type="System.String" name="HeaderText">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="headerText"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="headerText"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<propertySetValueReferenceExpression/>
											</unaryOperatorExpression>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="label"/>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="label"/>
											<propertySetValueReferenceExpression/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</setStatements>
						</memberProperty>
						<!-- property FooterText -->
						<memberProperty type="System.String" name="FooterText">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ToolTip -->
						<memberProperty type="System.String" name="ToolTip">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Watermark -->
						<memberProperty type="System.String" name="Watermark">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Hidden -->
						<memberProperty type="System.Boolean" name="Hidden">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property AllowQBE -->
						<memberProperty type="System.Boolean" name="AllowQBE">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property AllowSorting -->
						<memberProperty type="System.Boolean" name="AllowSorting">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property AllowLEV -->
						<xsl:if test="$IsPremium='true'">
							<memberProperty type="System.Boolean" name="AllowLEV">
								<attributes public="true" final="true"/>
							</memberProperty>
						</xsl:if>
						<!-- property DataFormatString -->
						<memberProperty type="System.String" name="DataFormatString">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Copy -->
						<memberProperty type="System.String" name="Copy">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property HyperlinkFormatString -->
						<memberProperty type="System.String" name="HyperlinkFormatString">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property FormatOnClient -->
						<memberProperty type="System.Boolean" name="FormatOnClient">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property SourceFields -->
						<memberProperty type="System.String" name="SourceFields">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property CategoryIndex -->
						<memberProperty type="System.Int32" name="CategoryIndex">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property AllowNulls -->
						<memberProperty type="System.Boolean" name="AllowNulls">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Columns -->
						<memberProperty type="System.Int32" name="Columns">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Rows -->
						<memberProperty type="System.Int32" name="Rows">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property OnDemand -->
						<memberProperty type="System.Boolean" name="OnDemand">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Search -->
						<memberProperty type="FieldSearchMode" name="Search">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property SearchOptions -->
						<memberProperty type="System.String" name="SearchOptions">
							<attributes public="true"/>
						</memberProperty>
						<!-- property ItemsDataController -->
						<memberProperty type="System.String" name="ItemsDataController">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ItemsDataView -->
						<memberProperty type="System.String" name="ItemsDataView">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ItemsDataValueField -->
						<memberProperty type="System.String" name="ItemsDataValueField">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ItemsDataTextField -->
						<memberProperty type="System.String" name="ItemsDataTextField">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ItemsStyle -->
						<memberProperty type="System.String" name="ItemsStyle">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ItemsPageSize -->
						<memberProperty type="System.Int32" name="ItemsPageSize">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ItemsNewDataView -->
						<memberProperty type="System.String" name="ItemsNewDataView">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ItemsNewDataView -->
						<memberProperty type="System.String" name="ItemsTargetController">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ItemsLetters -->
						<memberProperty type="System.Boolean" name="ItemsLetters">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Items -->
						<memberField type="List" name="items">
							<typeArguments>
								<typeReference type="System.Object[]"/>
							</typeArguments>
						</memberField>
						<memberProperty type="List" name="Items">
							<typeArguments >
								<typeReference type="System.Object[]"/>
							</typeArguments>
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="items"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Aggregate -->
						<memberProperty type="DataFieldAggregate" name="Aggregate">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property OnDemandHandler -->
						<memberProperty type="System.String" name="OnDemandHandler">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property OnDemandDisplayStyle -->
						<memberProperty type="OnDemandDisplayStyle" name="OnDemandStyle">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property TextMode -->
						<memberProperty type="TextInputMode" name="TextMode">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property MaskType-->
						<memberProperty type="DataFieldMaskType" name="MaskType">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Mask -->
						<memberProperty type="System.String" name="Mask">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ContextFields -->
						<memberField type="System.String" name="contextFields"/>
						<memberProperty type="System.String" name="ContextFields">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="contextFields"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- method SelectExpression() -->
						<memberField type="System.String" name="selectExpression"/>
						<memberMethod returnType="System.String" name="SelectExpression">
							<attributes public="true" final="true"/>
							<statements>
								<methodReturnStatement>
									<fieldReferenceExpression name="selectExpression"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- property Formula -->
						<memberProperty type="System.String" name="Formula">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ShowInSummary -->
						<memberProperty type="System.Boolean" name="ShowInSummary">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property IsMirror -->
						<memberField type="System.Boolean" name="isMirror"/>
						<memberProperty type="System.Boolean" name="IsMirror">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="isMirror"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property HtmlEncode -->
						<memberProperty type="System.Boolean" name="HtmlEncode">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property AutoCompletePrefixLength -->
						<memberProperty type="System.Int32" name="AutoCompletePrefixLength">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Calculated -->
						<memberProperty type="System.Boolean" name="Calculated">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property CausesCalculate -->
						<memberProperty type="System.Boolean" name="CausesCalculate">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property IsVirtual -->
						<memberProperty type="System.Boolean" name="IsVirtual">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Configuration -->
						<memberProperty type="System.String" name="Configuration">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Editor -->
						<memberProperty type="System.String" name="Editor">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property AutoSelect -->
						<memberProperty type="System.Boolean" name="AutoSelect">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property SearchOnStart -->
						<memberProperty type="System.Boolean" name="SearchOnStart">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ItemsDescription -->
						<memberProperty type="System.String" name="ItemsDescription">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewController-->
						<memberProperty type="System.String" name="DataViewController">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewId -->
						<memberProperty type="System.String" name="DataViewId">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewFilterSource-->
						<memberProperty type="System.String" name="DataViewFilterSource">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewFilterFields-->
						<memberProperty type="System.String" name="DataViewFilterFields">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewShowInSummary-->
						<memberProperty type="System.Boolean" name="DataViewShowInSummary">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewShowActionBar-->
						<memberField type="System.Boolean" name="dataViewShowActionBar">
							<init>
								<primitiveExpression value="true"/>
							</init>
						</memberField>
						<memberProperty type="System.Boolean" name="DataViewShowActionBar">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="dataViewShowActionBar"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="dataViewShowActionBar"/>
									<argumentReferenceExpression name="value"/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataViewShowActionButtons-->
						<memberProperty type="System.String" name="DataViewShowActionButtons">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewShowDescription-->
						<memberField type="System.Boolean" name="dataViewShowDescription">
							<init>
								<primitiveExpression value="true"/>
							</init>
						</memberField>
						<memberProperty type="System.Boolean" name="DataViewShowDescription">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="dataViewShowDescription"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="dataViewShowDescription"/>
									<argumentReferenceExpression name="value"/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataViewShowViewSelector-->
						<memberField type="System.Boolean" name="dataViewShowViewSelector">
							<init>
								<primitiveExpression value="true"/>
							</init>
						</memberField>
						<memberProperty type="System.Boolean" name="DataViewShowViewSelector">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="dataViewShowViewSelector"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="dataViewShowViewSelector"/>
									<argumentReferenceExpression name="value"/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataViewShowModalForms-->
						<memberProperty type="System.Boolean" name="DataViewShowModalForms">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewSearchByFirstLetter-->
						<memberProperty type="System.Boolean" name="DataViewSearchByFirstLetter">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewSearchOnStart-->
						<memberProperty type="System.Boolean" name="DataViewSearchOnStart">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewPageSize-->
						<memberProperty type="System.Int32" name="DataViewPageSize">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewMultiSelect-->
						<memberProperty type="System.Boolean" name="DataViewMultiSelect">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewShowPager-->
						<memberProperty type="System.String" name="DataViewShowPager">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewShowPageSize-->
						<memberField type="System.Boolean" name="dataViewShowPageSize">
							<init>
								<primitiveExpression value="true"/>
							</init>
						</memberField>
						<memberProperty type="System.Boolean" name="DataViewShowPageSize">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="dataViewShowPageSize"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="dataViewShowPageSize"/>
									<argumentReferenceExpression name="value"/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataViewShowSearchBar-->
						<memberField type="System.Boolean" name="dataViewShowSearchBar">
							<init>
								<primitiveExpression value="true"/>
							</init>
						</memberField>
						<memberProperty type="System.Boolean" name="DataViewShowSearchBar">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="dataViewShowSearchBar"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="dataViewShowSearchBar"/>
									<argumentReferenceExpression name="value"/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataViewShowQuickFind-->
						<memberField type="System.Boolean" name="dataViewShowQuickFind">
							<init>
								<primitiveExpression value="true"/>
							</init>
						</memberField>
						<memberProperty type="System.Boolean" name="DataViewShowQuickFind">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="dataViewShowQuickFind"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="dataViewShowQuickFind"/>
									<argumentReferenceExpression name="value"/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property DataViewShowRowNumber -->
						<memberProperty type="System.Boolean" name="DataViewShowRowNumber">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewAutoSelectFirstRow -->
						<memberProperty type="System.Boolean" name="DataViewAutoSelectFirstRow">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewAutoHighlightFirstRow -->
						<memberProperty type="System.Boolean" name="DataViewAutoHighlightFirstRow">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property DataViewRefreshInterval -->
						<memberProperty type="System.Int32" name="DataViewRefreshInterval">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- constructor DataField() -->
						<constructor>
							<attributes public="true"/>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="items"/>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="System.Object[]"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="formatOnClient"/>
									<primitiveExpression value="true"/>
								</assignStatement>
							</statements>
						</constructor>
						<!-- constructor DataField(XPathNavigator, IXmlNamespaceResolver) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="XPathNavigator" name="field"/>
								<parameter type="IXmlNamespaceResolver" name="nm"/>
							</parameters>
							<chainedConstructorArgs/>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="name">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<argumentReferenceExpression name="field"/>
										</target>
										<parameters>
											<primitiveExpression value="name"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="type">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<argumentReferenceExpression name="field"/>
										</target>
										<parameters>
											<primitiveExpression value="type"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement type="System.String" name="l">
									<init>
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="length"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="l"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="len"/>
											<methodInvokeExpression methodName="ToInt32">
												<target>
													<typeReferenceExpression type="Convert"/>
												</target>
												<parameters>
													<variableReferenceExpression name="l"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<fieldReferenceExpression name="label">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<argumentReferenceExpression name="field"/>
										</target>
										<parameters>
											<primitiveExpression value="label"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
									<!--<castExpression targetType="System.String">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="field"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="string(@label)"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="isPrimaryKey">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueEquality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="isPrimaryKey"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="true" convertTo="String"/>
									</binaryOperatorExpression>
									<!--<castExpression targetType="System.Boolean">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="field"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="@isPrimaryKey='true'"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="readOnly">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueEquality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="readOnly"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="true" convertTo="String"/>
									</binaryOperatorExpression>
									<!--<castExpression targetType="System.Boolean">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="field"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="@readOnly='true'"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="onDemand">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueEquality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="onDemand"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="true" convertTo="String"/>
									</binaryOperatorExpression>
									<!--<castExpression targetType="System.Boolean">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="field"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="@onDemand='true'"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="defaultValue">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<argumentReferenceExpression name="field"/>
										</target>
										<parameters>
											<primitiveExpression value="default"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
									<!--<castExpression targetType="System.String">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="field"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="string(@default)"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="allowNulls">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueInequality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="allowNulls"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="false" convertTo="String"/>
									</binaryOperatorExpression>
									<!--<castExpression targetType="System.Boolean">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="field"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="not(@allowNulls='false')"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="hidden">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueEquality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="hidden"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="true" convertTo="String"/>
									</binaryOperatorExpression>
									<!--<castExpression targetType="System.Boolean">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="field"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="@hidden='true'"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="allowQBE">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueInequality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="allowQBE"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="false" convertTo="String"/>
									</binaryOperatorExpression>
									<!--<castExpression targetType="System.Boolean">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="field"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="not(@allowQBE='false')"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
								</assignStatement>
								<xsl:if test="$IsPremium='true'">
									<assignStatement>
										<fieldReferenceExpression name="allowLEV">
											<thisReferenceExpression/>
										</fieldReferenceExpression>
										<binaryOperatorExpression operator="ValueEquality">
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<variableReferenceExpression name="field"/>
												</target>
												<parameters>
													<primitiveExpression value="allowLEV"/>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
											<primitiveExpression value="true" convertTo="String"/>
										</binaryOperatorExpression>
									</assignStatement>
								</xsl:if>
								<assignStatement>
									<fieldReferenceExpression name="allowSorting">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueInequality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="allowSorting"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="false" convertTo="String"/>
									</binaryOperatorExpression>
									<!--<castExpression targetType="System.Boolean">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="field"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="not(@allowSorting='false')"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="sourceFields">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<argumentReferenceExpression name="field"/>
										</target>
										<parameters>
											<primitiveExpression value="sourceFields"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement type="System.String" name="onDemandStyle">
									<init>
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="onDemandStyle"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="onDemandStyle"/>
											<primitiveExpression value="Link"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="onDemandStyle">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<propertyReferenceExpression name="Link">
												<typeReferenceExpression type="OnDemandDisplayStyle"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="onDemandStyle"/>
													<primitiveExpression value="Signature"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<fieldReferenceExpression name="onDemandStyle">
														<thisReferenceExpression/>
													</fieldReferenceExpression>
													<propertyReferenceExpression name="Signature">
														<typeReferenceExpression type="OnDemandDisplayStyle"/>
													</propertyReferenceExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<assignStatement>
									<fieldReferenceExpression name="onDemandHandler">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<argumentReferenceExpression name="field"/>
										</target>
										<parameters>
											<primitiveExpression value="onDemandHandler"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="contextFields">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<argumentReferenceExpression name="field"/>
										</target>
										<parameters>
											<primitiveExpression value="contextFields"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="selectExpression">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<argumentReferenceExpression name="field"/>
										</target>
										<parameters>
											<primitiveExpression value="select"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<variableDeclarationStatement type="System.Boolean" name="computed">
									<init>
										<binaryOperatorExpression operator="ValueEquality">
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<argumentReferenceExpression name="field"/>
												</target>
												<parameters>
													<primitiveExpression value="computed"/>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
											<primitiveExpression value="true" convertTo="String"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<variableReferenceExpression name="computed"/>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="formula"/>
											<castExpression targetType="System.String">
												<methodInvokeExpression methodName="Evaluate">
													<target>
														<argumentReferenceExpression name="field"/>
													</target>
													<parameters>
														<primitiveExpression value="string(self::c:field/c:formula)"/>
														<argumentReferenceExpression name="nm"/>
													</parameters>
												</methodInvokeExpression>
											</castExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<fieldReferenceExpression name="formula"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<fieldReferenceExpression name="formula"/>
													<primitiveExpression value="null" convertTo="String"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<fieldReferenceExpression name="showInSummary">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueEquality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="showInSummary"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="true" convertTo="String"/>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="htmlEncode">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueInequality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="htmlEncode"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="false" convertTo="String"/>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="calculated">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueEquality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="calculated"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="true" convertTo="String"/>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="causesCalculate">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueEquality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="causesCalculate"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="true" convertTo="String"/>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="isVirtual">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="ValueEquality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="isVirtual"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="true" convertTo="String"/>
									</binaryOperatorExpression>
								</assignStatement>
								<!-- this.Configuration = ((string)(field.Evaluate("string(self::c:field/c:configuration)", nm))); -->
								<assignStatement>
									<fieldReferenceExpression name="configuration">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<castExpression targetType="System.String">
										<methodInvokeExpression methodName="Evaluate">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="string(self::c:field/c:configuration)"/>
												<argumentReferenceExpression name="nm"/>
											</parameters>
										</methodInvokeExpression>
									</castExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="dataFormatString">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<methodInvokeExpression methodName="GetAttribute">
										<target>
											<argumentReferenceExpression name="field"/>
										</target>
										<parameters>
											<primitiveExpression value="dataFormatString"/>
											<propertyReferenceExpression name="Empty">
												<typeReferenceExpression type="String"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="formatOnClient"/>
									<binaryOperatorExpression operator="ValueInequality">
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="formatOnClient"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<primitiveExpression value="false" convertTo="String"/>
									</binaryOperatorExpression>
								</assignStatement>
								<variableDeclarationStatement type="System.String" name="editor">
									<init>
										<methodInvokeExpression methodName="GetAttribute">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="editor"/>
												<propertyReferenceExpression name="Empty">
													<typeReferenceExpression type="String"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="editor"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="editor"/>
											<variableReferenceExpression name="editor"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="XPathNavigator" name="itemsNav">
									<init>
										<methodInvokeExpression methodName="SelectSingleNode">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="c:items"/>
												<argumentReferenceExpression name="nm"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="itemsNav"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="ItemsDataController">
												<thisReferenceExpression/>
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
											<propertyReferenceExpression name="ItemsTargetController">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<variableReferenceExpression name="itemsNav"/>
												</target>
												<parameters>
													<primitiveExpression value="targetController"/>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement type="XPathNavigator" name="dataViewNav">
									<init>
										<methodInvokeExpression methodName="SelectSingleNode">
											<target>
												<argumentReferenceExpression name="field"/>
											</target>
											<parameters>
												<primitiveExpression value="c:dataView"/>
												<argumentReferenceExpression name="nm"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="dataViewNav"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="DataViewController">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<argumentReferenceExpression name="dataViewNav"/>
												</target>
												<parameters>
													<primitiveExpression value="controller"/>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="DataViewId">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<argumentReferenceExpression name="dataViewNav"/>
												</target>
												<parameters>
													<primitiveExpression value="view"/>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="DataViewFilterSource">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<argumentReferenceExpression name="dataViewNav"/>
												</target>
												<parameters>
													<primitiveExpression value="filterSource"/>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="DataViewFilterFields">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="GetAttribute">
												<target>
													<argumentReferenceExpression name="dataViewNav"/>
												</target>
												<parameters>
													<primitiveExpression value="filterFields"/>
													<propertyReferenceExpression name="Empty">
														<typeReferenceExpression type="String"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="allowQBE"/>
											<primitiveExpression value="true"/>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="allowSorting"/>
											<primitiveExpression value="true"/>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="len"/>
											<primitiveExpression value="0"/>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="columns"/>
											<primitiveExpression value="0"/>
										</assignStatement>
										<assignStatement>
											<fieldReferenceExpression name="htmlEncode"/>
											<primitiveExpression value="true"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</constructor>
						<!-- constructor DataField(XPathNavigator, IXmlNamespaceResolver, bool) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="XPathNavigator" name="field"/>
								<parameter type="IXmlNamespaceResolver" name="nm"/>
								<parameter type="System.Boolean" name="hidden"/>
							</parameters>
							<chainedConstructorArgs>
								<argumentReferenceExpression name="field"/>
								<argumentReferenceExpression name="nm"/>
							</chainedConstructorArgs>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="hidden">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<argumentReferenceExpression name="hidden"/>
								</assignStatement>
								<!--<conditionStatement>
                  <condition>
                    <fieldReferenceExpression name="_allowQBE">
                      <thisReferenceExpression/>
                    </fieldReferenceExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="allowQBE">
                        <thisReferenceExpression/>
                      </fieldReferenceExpression>
                      <unaryOperatorExpression operator="Not">
                        <argumentReferenceExpression name="hidden"/>
                      </unaryOperatorExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>-->
							</statements>
						</constructor>
						<!-- constructor (DataField) -->
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="DataField" name="field"/>
							</parameters>
							<chainedConstructorArgs></chainedConstructorArgs>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="isMirror">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="name">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<binaryOperatorExpression operator="Add">
										<propertyReferenceExpression name="Name">
											<argumentReferenceExpression name="field"/>
										</propertyReferenceExpression>
										<primitiveExpression value="_Mirror"/>
									</binaryOperatorExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="type">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<propertyReferenceExpression name="Type">
										<argumentReferenceExpression name="field"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="len">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<propertyReferenceExpression name="Len">
										<variableReferenceExpression name="field"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="label">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<propertyReferenceExpression name="Label">
										<argumentReferenceExpression name="field"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="readOnly">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<primitiveExpression value="true"/>
									<!--<propertyReferenceExpression name="ReadOnly">
                    <argumentReferenceExpression name="field"/>
                  </propertyReferenceExpression>-->
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="allowNulls">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<propertyReferenceExpression name="AllowNulls">
										<argumentReferenceExpression name="field"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="allowQBE">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<propertyReferenceExpression name="AllowQBE">
										<argumentReferenceExpression name="field"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="allowSorting">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<propertyReferenceExpression name="AllowSorting">
										<argumentReferenceExpression name="field"/>
									</propertyReferenceExpression>
								</assignStatement>
								<xsl:if test="$IsPremium='true'">
									<assignStatement>
										<fieldReferenceExpression name="allowLEV">
											<thisReferenceExpression/>
										</fieldReferenceExpression>
										<propertyReferenceExpression name="AllowLEV">
											<argumentReferenceExpression name="field"/>
										</propertyReferenceExpression>
									</assignStatement>
								</xsl:if>
								<assignStatement>
									<fieldReferenceExpression name="dataFormatString">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<propertyReferenceExpression name="DataFormatString">
										<argumentReferenceExpression name="field"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="aggregate">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<propertyReferenceExpression name="Aggregate">
										<argumentReferenceExpression name="field"/>
									</propertyReferenceExpression>
								</assignStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<methodInvokeExpression methodName="Contains">
												<target>
													<fieldReferenceExpression name="dataFormatString">
														<thisReferenceExpression/>
													</fieldReferenceExpression>
												</target>
												<parameters>
													<primitiveExpression value="{{"/>
												</parameters>
											</methodInvokeExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<fieldReferenceExpression name="dataFormatString">
												<thisReferenceExpression/>
											</fieldReferenceExpression>
											<methodInvokeExpression methodName="Format">
												<target>
													<typeReferenceExpression type="String"/>
												</target>
												<parameters>
													<primitiveExpression>
														<xsl:attribute name="value"><![CDATA[{{0:{0}}}]]></xsl:attribute>
													</primitiveExpression>
													<fieldReferenceExpression name="dataFormatString">
														<thisReferenceExpression/>
													</fieldReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<fieldReferenceExpression name="aliasName">
										<argumentReferenceExpression name="field"/>
									</fieldReferenceExpression>
									<fieldReferenceExpression name="name">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="FormatOnClient">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<primitiveExpression value="false"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="FormatOnClient">
										<argumentReferenceExpression name="field"/>
									</propertyReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="DataFormatString">
										<argumentReferenceExpression name="field"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="Empty">
										<typeReferenceExpression type="String"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="hidden">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
							</statements>
						</constructor>
						<!-- method NormalizeDataFormatString() -->
						<memberMethod name="NormalizeDataFormatString">
							<attributes public="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<fieldReferenceExpression name="dataFormatString"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="System.String" name="fmt">
											<init>
												<fieldReferenceExpression name="dataFormatString"/>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="Contains">
														<target>
															<variableReferenceExpression name="fmt"/>
														</target>
														<parameters>
															<primitiveExpression value="{{"/>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<fieldReferenceExpression name="dataFormatString"/>
													<methodInvokeExpression methodName="Format">
														<target>
															<typeReferenceExpression type="String"/>
														</target>
														<parameters>
															<primitiveExpression>
																<xsl:attribute name="value"><![CDATA[{{0:{0}}}]]></xsl:attribute>
															</primitiveExpression>
															<variableReferenceExpression name="fmt"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<fieldReferenceExpression name="type"/>
													<primitiveExpression value="DateTime"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<fieldReferenceExpression name="dataFormatString"/>
													<primitiveExpression value="{{0:d}}"/>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ExpressionName() -->
						<memberMethod returnType="System.String" name="ExpressionName">
							<attributes public="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsMirror"/>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="Substring">
												<target>
													<propertyReferenceExpression name="Name"/>
												</target>
												<parameters>
													<primitiveExpression value="0"/>
													<binaryOperatorExpression operator="Subtract">
														<propertyReferenceExpression name="Length">
															<propertyReferenceExpression name="Name"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="Length">
															<primitiveExpression value="_Mirror"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<propertyReferenceExpression name="Name"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SupportsStaticItems -->
						<!-- 
        public bool SupportsStaticItems()
        {
            return !String.IsNullOrEmpty(ItemsStyle) && !(ItemsStyle == "AutoComplete" || ItemsStyle == "Lookup" || ItemsStyle == "Basket");
        }
            -->
						<memberMethod returnType="System.Boolean" name="SupportsStaticItems">
							<attributes public="true" final="true"/>
							<statements>
								<methodReturnStatement>
									<binaryOperatorExpression operator="BooleanAnd">
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<propertyReferenceExpression name="ItemsDataController"/>
										</unaryOperatorExpression>
										<unaryOperatorExpression operator="Not">
											<binaryOperatorExpression operator="BooleanOr">
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="ItemsStyle"/>
													<primitiveExpression value="AutoComplete"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="ItemsStyle"/>
													<primitiveExpression value="Lookup"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</unaryOperatorExpression>
									</binaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method IsMatchedByName(string) -->
						<memberMethod returnType="System.Boolean" name="IsMatchedByName">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="sample"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="headerText">
									<init>
										<propertyReferenceExpression name="HeaderText">
											<thisReferenceExpression/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="headerText"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="headerText"/>
											<propertyReferenceExpression name="Label">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="headerText"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="headerText"/>
											<propertyReferenceExpression name="Name">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<assignStatement>
									<variableReferenceExpression name="headerText"/>
									<methodInvokeExpression methodName="Replace">
										<target>
											<variableReferenceExpression name="headerText"/>
										</target>
										<parameters>
											<primitiveExpression value=" "/>
											<stringEmptyExpression/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="StartsWith">
										<target>
											<variableReferenceExpression name="headerText"/>
										</target>
										<parameters>
											<methodInvokeExpression methodName="Replace">
												<target>
													<argumentReferenceExpression name="sample"/>
												</target>
												<parameters>
													<primitiveExpression value=" "/>
													<stringEmptyExpression/>
												</parameters>
											</methodInvokeExpression>
											<propertyReferenceExpression name="CurrentCultureIgnoreCase">
												<typeReferenceExpression type="StringComparison"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ToString() -->
						<memberMethod returnType="System.String" name="ToString">
							<attributes public="true" override="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<propertyReferenceExpression name="Formula"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="Format">
												<target>
													<typeReferenceExpression type="String"/>
												</target>
												<parameters>
													<primitiveExpression value="{{0}} as {{1}}; SQL: {{2}}"/>
													<propertyReferenceExpression name="Name"/>
													<propertyReferenceExpression name="Type"/>
													<propertyReferenceExpression name="Formula"/>
												</parameters>
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
													<primitiveExpression value="{{0}} as {{1}}"/>
													<propertyReferenceExpression name="Name"/>
													<propertyReferenceExpression name="Type"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method IsTagged(string) -->
						<memberMethod returnType="System.Boolean" name="IsTagged">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="tag"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<propertyReferenceExpression name="Tag">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="Contains">
										<target>
											<propertyReferenceExpression name="Tag">
												<thisReferenceExpression/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<argumentReferenceExpression name="tag"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
