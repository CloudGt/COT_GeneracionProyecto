<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
	<xsl:output method="xml" indent="yes"/>

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
				<!-- class ActionResult -->
				<typeDeclaration name="ActionResult">
					<members>
						<!-- property Tag -->
						<memberProperty type="System.String" name="Tag">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Errors -->
						<memberField type="List" name="errors">
							<typeArguments>
								<typeReference type="System.String"/>
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
						<memberProperty type="List" name="Errors">
							<typeArguments>
								<typeReference type="System.String"/>
							</typeArguments>
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="errors"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- property Values -->
						<memberField type="List" name="values">
							<typeArguments>
								<typeReference type="FieldValue"/>
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
						<memberProperty type="List" name="Values">
							<typeArguments>
								<typeReference type="FieldValue"/>
							</typeArguments>
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="values"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
						<!-- public CanceledSelectedValues -->
						<memberProperty type="System.Boolean" name="CanceledSelectedValues">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Canceled -->
						<memberField type="System.Boolean" name="canceled">
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
						<memberProperty type="System.Boolean" name="Canceled">
							<attributes public="true" final="true"/>
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
						<!-- property NavigateUrl -->
						<memberField type="System.String" name="navigateUrl">
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
						<memberProperty type="System.String" name="NavigateUrl">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="navigateUrl"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="navigateUrl"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property ClientScript -->
						<memberField type="System.String" name="clientScript">
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
						<memberProperty type="System.String" name="ClientScript">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="clientScript"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="clientScript"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property RowsAffected -->
						<memberField type="System.Int32" name="rowsAffected">
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
						<memberProperty type="System.Int32" name="RowsAffected">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="rowsAffected"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="rowsAffected"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- property KeepSelection -->
						<memberProperty type="System.Boolean" name="KeepSelection">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property ClearSelection -->
						<memberProperty type="System.Boolean" name="ClearSelection">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property Filter -->
						<memberProperty type="System.String[]" name="Filter">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- property SortExpression -->
						<memberProperty type="System.String" name="SortExpression">
							<attributes public="true" final="true"/>
						</memberProperty>
						<!-- constructor ActionResult() -->
						<constructor>
							<attributes public="true"/>
							<statements>
								<assignStatement>
									<fieldReferenceExpression name="errors">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
								<assignStatement>
									<fieldReferenceExpression name="values">
										<thisReferenceExpression/>
									</fieldReferenceExpression>
									<objectCreateExpression type="List">
										<typeArguments>
											<typeReference type="FieldValue"/>
										</typeArguments>
									</objectCreateExpression>
								</assignStatement>
							</statements>
						</constructor>
						<!-- method RaiseExceptionIfErrors -->
						<memberMethod name="RaiseExceptionIfErrors">
							<attributes final="true" public="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="GreaterThan">
											<propertyReferenceExpression name="Count">
												<propertyReferenceExpression name="Errors"/>
											</propertyReferenceExpression>
											<primitiveExpression value="0"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="StringBuilder" name="sb">
											<init>
												<objectCreateExpression type="StringBuilder"/>
											</init>
										</variableDeclarationStatement>
										<foreachStatement>
											<variable type="System.String" name="er"/>
											<target>
												<propertyReferenceExpression name="Errors"/>
											</target>
											<statements>
												<methodInvokeExpression methodName="AppendLine">
													<target>
														<variableReferenceExpression name="sb"/>
													</target>
													<parameters>
														<variableReferenceExpression name="er"/>
													</parameters>
												</methodInvokeExpression>
												<throwExceptionStatement>
													<objectCreateExpression type="Exception">
														<parameters>
															<methodInvokeExpression methodName="ToString">
																<target>
																	<variableReferenceExpression name="sb"/>
																</target>
															</methodInvokeExpression>
														</parameters>
													</objectCreateExpression>
												</throwExceptionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ToObject<T>() -->
						<memberMethod returnType="T" name="ToObject">
							<typeParameters>
								<typeParameter name="T"/>
							</typeParameters>
							<attributes public="true" final="true"/>
							<statements>
								<variableDeclarationStatement type="Type" name="objectType">
									<init>
										<typeofExpression type="T"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="T" name="theObject">
									<init>
										<castExpression targetType="T">
											<methodInvokeExpression methodName="CreateInstance">
												<target>
													<propertyReferenceExpression name="Assembly">
														<variableReferenceExpression name="objectType"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<propertyReferenceExpression name="FullName">
														<variableReferenceExpression name="objectType"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="AssignTo">
									<parameters>
										<variableReferenceExpression name="theObject"/>
									</parameters>
								</methodInvokeExpression>
								<methodReturnStatement>
									<variableReferenceExpression name="theObject"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AssignTo(object) -->
						<memberMethod name="AssignTo">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.Object" name="instance"/>
							</parameters>
							<statements>
								<foreachStatement>
									<variable type="FieldValue" name="v"/>
									<target>
										<propertyReferenceExpression name="Values"/>
									</target>
									<statements>
										<methodInvokeExpression methodName="AssignTo">
											<target>
												<variableReferenceExpression name="v"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="instance"/>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
						<!-- method ShowMessage(string) -->
						<memberMethod name="ShowMessage">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="format"/>
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ShowMessage">
									<parameters>
										<methodInvokeExpression methodName="Format">
											<target>
												<typeReferenceExpression type="String"/>
											</target>
											<parameters>
												<variableReferenceExpression name="format"/>
												<argumentReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ShowMessage(string) -->
						<memberMethod name="ShowMessage">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="message"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression value="Web.DataView.showMessage('{{0}}');"/>
										<methodInvokeExpression methodName="JavaScriptString">
											<target>
												<typeReferenceExpression type="BusinessRules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="message"/>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ShowViewMessage(string) -->
						<memberMethod name="ShowViewMessage">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="format"/>
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ShowViewMessage">
									<parameters>
										<methodInvokeExpression methodName="Format">
											<target>
												<typeReferenceExpression type="String"/>
											</target>
											<parameters>
												<variableReferenceExpression name="format"/>
												<argumentReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ShowViewMessage(string) -->
						<memberMethod name="ShowViewMessage">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="message"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression value="this.showViewMessage('{{0}}');"/>
										<methodInvokeExpression methodName="JavaScriptString">
											<target>
												<typeReferenceExpression type="BusinessRules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="message"/>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method Focus(string, string, params object[]) -->
						<memberMethod name="Focus">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
								<parameter type="System.String" name="fmt"/>
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression>
											<xsl:attribute name="value"><![CDATA[this._serverFocus('{0}','{1}');]]></xsl:attribute>
										</primitiveExpression>
										<argumentReferenceExpression name="fieldName"/>
										<methodInvokeExpression methodName="JavaScriptString">
											<target>
												<typeReferenceExpression type="BusinessRules"/>
											</target>
											<parameters>
												<methodInvokeExpression methodName="Format">
													<target>
														<typeReferenceExpression type="String"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="fmt"/>
														<argumentReferenceExpression name="args"/>
													</parameters>
												</methodInvokeExpression>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method Focus(string) -->
						<memberMethod name="Focus">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="fieldName"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="Focus">
									<parameters>
										<argumentReferenceExpression name="fieldName"/>
										<propertyReferenceExpression name="Empty">
											<typeReferenceExpression type="String"/>
										</propertyReferenceExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ExecuteOnClient(string) -->
						<memberMethod name="ExecuteOnClient">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="javaScriptFormatString"/>
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<methodInvokeExpression methodName="Format">
											<target>
												<typeReferenceExpression type="String"/>
											</target>
											<parameters>
												<variableReferenceExpression name="javaScriptFormatString"/>
												<argumentReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ExecuteOnClient(string) -->
						<memberMethod name="ExecuteOnClient">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="javaScript"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<propertyReferenceExpression name="ClientScript"/>
											</unaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="EndsWith">
													<target>
														<propertyReferenceExpression name="ClientScript"/>
													</target>
													<parameters>
														<primitiveExpression value=";"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="ClientScript"/>
											<binaryOperatorExpression operator="Add">
												<propertyReferenceExpression name="ClientScript"/>
												<primitiveExpression value=";"/>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<argumentReferenceExpression name="javaScript"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<propertyReferenceExpression name="ClientScript"/>
											<binaryOperatorExpression operator="Add">
												<propertyReferenceExpression name="ClientScript"/>
												<argumentReferenceExpression name="javaScript"/>
											</binaryOperatorExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ShowLastView() -->
						<memberMethod name="ShowLastView">
							<attributes public="true" final="true"/>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression value="this.goToView(this._lastViewId);"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ShowView(string) -->
						<memberMethod name="ShowView">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="viewId"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression value="this.goToView('{{0}}');"/>
										<argumentReferenceExpression name="viewId"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ShowAlert(string) -->
						<memberMethod name="ShowAlert">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="message"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression value="$app.alert('{{0}}');"/>
										<methodInvokeExpression methodName="JavaScriptString">
											<target>
												<typeReferenceExpression type="BusinessRules"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="message"/>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ShowAlert(string, string, params object[]) -->
						<memberMethod name="ShowAlert">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="fmt"/>
								<parameter type="params System.Object[]" name="args"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ShowAlert">
									<parameters>
										<methodInvokeExpression methodName="Format">
											<target>
												<typeReferenceExpression type="String"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="fmt"/>
												<argumentReferenceExpression name="args"/>
											</parameters>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method HideModal() -->
						<memberMethod name="HideModal">
							<attributes public="true" final="true"/>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression value="this.endModalState('Cancel');"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method ShowModal(string, string, string, string) -->
						<memberMethod name="ShowModal">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.String" name="controller"/>
								<parameter type="System.String" name="view"/>
								<parameter type="System.String" name="startCommandName"/>
								<parameter type="System.String" name="startCommandArgument"/>
							</parameters>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression value="if(this._container&amp;&amp;this.get_controller()=='{{0}}'){{{{this._savePosition();this._showModal({{{{commandName:'{{2}}',commandArgument:'{{3}}'}}}});}}}}else Web.DataView.showModal(null, '{{0}}', '{{1}}', '{{2}}', '{{3}}');"/>
										<argumentReferenceExpression name="controller"/>
										<argumentReferenceExpression name="view"/>
										<argumentReferenceExpression name="startCommandName"/>
										<argumentReferenceExpression name="startCommandArgument"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method SelectFirstRow() -->
						<memberMethod name="SelectFirstRow">
							<attributes public="true" final="true"/>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression value="this.set_autoSelectFirstRow(true);this._autoSelect();"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method HighlightFirstRow() -->
						<memberMethod name="HighlightFirstRow">
							<attributes public="true" final="true"/>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression value="this.set_autoHighlightFirstRow(true);this._autoSelect();"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method Refresh() -->
						<memberMethod name="Refresh">
							<comment>
								<![CDATA[
        /// <summary>
        /// Refreshes the data view that has caused execution of business rules. Fresh data will be fetched from the server.
        /// </summary>]]>
							</comment>
							<attributes public="true" final="true"/>
							<statements>
								<methodInvokeExpression methodName="Refresh">
									<parameters>
										<primitiveExpression value="true"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method Refresh(bool) -->
						<memberMethod name="Refresh">
							<comment>
								<![CDATA[
        /// <summary>
        /// Refreshes the data view that has caused execution of business rules.
        /// </summary>
        /// <param name="fetch">Indicates that the fresh data must be fetched from the server.</param>
              ]]>
							</comment>
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="System.Boolean" name="fetch"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.Boolean" name="noFetch">
									<init>
										<unaryOperatorExpression operator="Not">
											<argumentReferenceExpression name="fetch"/>
										</unaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression value="this.refresh({{0}});"/>
										<methodInvokeExpression methodName="ToLower">
											<target>
												<methodInvokeExpression methodName="ToString">
													<target>
														<argumentReferenceExpression name="noFetch"/>
													</target>
												</methodInvokeExpression>
											</target>
										</methodInvokeExpression>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method RefreshChildren() -->
						<memberMethod name="RefreshChildren">
							<comment>
								<![CDATA[
        /// <summary>
        /// Refreshes the children of the data view that has caused execution of business rules.
        /// </summary>]]>
							</comment>
							<attributes public="true" final="true"/>
							<statements>
								<methodInvokeExpression methodName="ExecuteOnClient">
									<parameters>
										<primitiveExpression value="this.refreshChildren();"/>
									</parameters>
								</methodInvokeExpression>
								<!--<methodInvokeExpression methodName="ExecuteOnClient">
                  <parameters>
                    <primitiveExpression value="this._forceChanged=true;this._raiseSelectedDelayed=true;"/>
                  </parameters>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="Contains">
                        <target>
                          <propertyReferenceExpression name="ClientScript"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="this.refresh("/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="ExecuteOnClient">
                      <parameters>
                        <primitiveExpression value="this.refresh(true);"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>-->
							</statements>
						</memberMethod>
						<!-- method Continue() -->
						<memberMethod name="Continue">
							<comment>
								<![CDATA[
        /// <summary>
        /// Ensures that the action state machine will execute an iteration when the server response is returned to the client library. 
        /// </summary>]]>
							</comment>
							<attributes public="true" final="true"/>
							<statements>
								<variableDeclarationStatement type="System.String" name="script">
									<init>
										<primitiveExpression value="this._continueAfterScript=true;"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanOr">
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<propertyReferenceExpression name="ClientScript"/>
											</unaryOperatorExpression>
											<unaryOperatorExpression operator="Not">
												<methodInvokeExpression methodName="Contains">
													<target>
														<propertyReferenceExpression name="ClientScript"/>
													</target>
													<parameters>
														<variableReferenceExpression name="script"/>
													</parameters>
												</methodInvokeExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="ExecuteOnClient">
											<parameters>
												<variableReferenceExpression name="script"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- property RowNotFound -->
						<memberField type="System.Boolean" name="rowNotFound"/>
						<memberProperty type="System.Boolean" name="RowNotFound">
							<attributes public="true" final="true"/>
							<getStatements>
								<methodReturnStatement>
									<fieldReferenceExpression name="rowNotFound"/>
								</methodReturnStatement>
							</getStatements>
							<setStatements>
								<assignStatement>
									<fieldReferenceExpression name="rowNotFound"/>
									<propertySetValueReferenceExpression/>
								</assignStatement>
							</setStatements>
						</memberProperty>
						<!-- method Merge(ViewPage) -->
						<memberMethod name="Merge">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="ViewPage" name="page"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="ClientScript">
										<argumentReferenceExpression name="page"/>
									</propertyReferenceExpression>
									<propertyReferenceExpression name="ClientScript"/>
								</assignStatement>
							</statements>
						</memberMethod>
						<!-- method Merge(ActionResult) -->
						<memberMethod name="Merge">
							<attributes public="true" final="true"/>
							<parameters>
								<parameter type="ActionResult" name="result"/>
							</parameters>
							<statements>
								<foreachStatement>
									<variable type="System.String" name="er"/>
									<target>
										<propertyReferenceExpression name="Errors">
											<argumentReferenceExpression name="result"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Errors"/>
											</target>
											<parameters>
												<variableReferenceExpression name="er"/>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
								<assignStatement>
									<propertyReferenceExpression name="ClientScript"/>
									<binaryOperatorExpression operator="Add">
										<propertyReferenceExpression name="ClientScript"/>
										<propertyReferenceExpression name="ClientScript">
											<argumentReferenceExpression name="result"/>
										</propertyReferenceExpression>
									</binaryOperatorExpression>
								</assignStatement>
								<foreachStatement>
									<variable type="FieldValue" name="v"/>
									<target>
										<propertyReferenceExpression name="Values">
											<argumentReferenceExpression name="result"/>
										</propertyReferenceExpression>
									</target>
									<statements>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="Values"/>
											</target>
											<parameters>
												<variableReferenceExpression name="v"/>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</foreachStatement>
							</statements>
						</memberMethod>
						<!-- method EnsureJsonCompatibility() -->
						<memberMethod name="EnsureJsonCompatibility">
							<attributes public="true" final="true"/>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<propertyReferenceExpression name="Values"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable type="FieldValue" name="v"/>
											<target>
												<propertyReferenceExpression name="Values"/>
											</target>
											<statements>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="Modified">
															<variableReferenceExpression name="v"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="DisableConversion">
															<target>
																<variableReferenceExpression name="v"/>
															</target>
														</methodInvokeExpression>
														<assignStatement>
															<propertyReferenceExpression name="NewValue">
																<variableReferenceExpression name="v"/>
															</propertyReferenceExpression>
															<methodInvokeExpression methodName="EnsureJsonCompatibility">
																<target>
																	<typeReferenceExpression type="DataControllerBase"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="NewValue">
																		<variableReferenceExpression name="v"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<methodInvokeExpression methodName="EnableConversion">
															<target>
																<variableReferenceExpression name="v"/>
															</target>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
