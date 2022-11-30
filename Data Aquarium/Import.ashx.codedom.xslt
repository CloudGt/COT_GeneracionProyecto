<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:bo="urn:schemas-codeontime-com:business-objects" xmlns:ontime="urn:schemas-codeontime-com:extensions"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a bo ontime"
>
	<xsl:param name="Namespace"/>
	<xsl:param name="IsPremium"/>
	<xsl:param name="Host"/>
	<xsl:output method="xml" indent="yes"/>

	<msxsl:script language="C#" implements-prefix="ontime">
		<![CDATA[
  public string NormalizeLineEndings(string s) {
    return s.Replace("\n", "\r\n");
  }
  ]]>
	</msxsl:script>


	<xsl:template match="/">

		<compileUnit>
			<xsl:attribute name="namespace">
				<xsl:value-of select="$Namespace"/>
				<xsl:if test="$Host='SharePoint'">
					<xsl:text>.WebParts</xsl:text>
				</xsl:if>
				<xsl:text>.Handlers</xsl:text>
			</xsl:attribute>
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Drawing"/>
				<namespaceImport name="System.Drawing.Imaging"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Net"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="{$Namespace}.Data"/>
			</imports>
			<types>
				<!-- class Import -->
				<typeDeclaration name="Import">
					<baseTypes>
						<typeReference type="GenericHandlerBase"/>
						<typeReference type="IHttpHandler"/>
						<typeReference type="System.Web.SessionState.IRequiresSessionState"/>
					</baseTypes>
					<members>
						<!-- method IHttpContext.ProcessRequest(HttpContext) -->
						<memberMethod name="ProcessRequest" privateImplementationType="IHttpHandler">
							<attributes/>
							<parameters>
								<parameter type="HttpContext" name="context"/>
							</parameters>
							<statements>
								<xsl:if test="$IsPremium='true'">
									<xsl:call-template name="GenerateProcessRequest"/>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- property IHttpContext.IsReusable -->
						<memberProperty type="System.Boolean" name="IsReusable" privateImplementationType="IHttpHandler">
							<attributes/>
							<getStatements>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</getStatements>
						</memberProperty>
					</members>
				</typeDeclaration>
			</types>
		</compileUnit>
	</xsl:template>
	<xsl:template name="GenerateProcessRequest">
		<variableDeclarationStatement type="System.String" name="parentId">
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
						<primitiveExpression value="parentId"/>
					</indices>
				</arrayIndexerExpression>
			</init>
		</variableDeclarationStatement>
		<variableDeclarationStatement type="System.String" name="controller">
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
						<primitiveExpression value="controller"/>
					</indices>
				</arrayIndexerExpression>
			</init>
		</variableDeclarationStatement>
		<variableDeclarationStatement type="System.String" name="view">
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
						<primitiveExpression value="view"/>
					</indices>
				</arrayIndexerExpression>
			</init>
		</variableDeclarationStatement>
		<conditionStatement>
			<condition>
				<binaryOperatorExpression operator="BooleanOr">
					<unaryOperatorExpression operator="IsNullOrEmpty">
						<variableReferenceExpression name="parentId"/>
					</unaryOperatorExpression>
					<binaryOperatorExpression operator="BooleanOr">
						<unaryOperatorExpression operator="IsNullOrEmpty">
							<variableReferenceExpression name="controller"/>
						</unaryOperatorExpression>
						<unaryOperatorExpression operator="IsNullOrEmpty">
							<variableReferenceExpression name="view"/>
						</unaryOperatorExpression>
					</binaryOperatorExpression>
				</binaryOperatorExpression>
			</condition>
			<trueStatements>
				<throwExceptionStatement>
					<objectCreateExpression type="HttpException">
						<parameters>
							<primitiveExpression value="404"/>
							<stringEmptyExpression/>
						</parameters>
					</objectCreateExpression>
				</throwExceptionStatement>
			</trueStatements>
		</conditionStatement>
		<variableDeclarationStatement type="System.String" name="methodName">
			<init>
				<primitiveExpression value="null"/>
			</init>
		</variableDeclarationStatement>
		<variableDeclarationStatement type="System.String" name="data">
			<init>
				<primitiveExpression value="null"/>
			</init>
		</variableDeclarationStatement>
		<variableDeclarationStatement type="StringBuilder" name="errors">
			<init>
				<objectCreateExpression type="StringBuilder"/>
			</init>
		</variableDeclarationStatement>
		<conditionStatement>
			<condition>
				<binaryOperatorExpression operator="ValueEquality">
					<propertyReferenceExpression name="HttpMethod">
						<propertyReferenceExpression name="Request">
							<argumentReferenceExpression name="context"/>
						</propertyReferenceExpression>
					</propertyReferenceExpression>
					<primitiveExpression value="GET"/>
				</binaryOperatorExpression>
			</condition>
			<trueStatements>
				<assignStatement>
					<variableReferenceExpression name="methodName"/>
					<primitiveExpression value="_initImportUpload"/>
				</assignStatement>
			</trueStatements>
			<falseStatements>
				<conditionStatement>
					<condition>
						<binaryOperatorExpression operator="BooleanAnd">
							<binaryOperatorExpression operator="ValueEquality">
								<propertyReferenceExpression name="HttpMethod">
									<propertyReferenceExpression name="Request">
										<argumentReferenceExpression name="context"/>
									</propertyReferenceExpression>
								</propertyReferenceExpression>
								<primitiveExpression value="POST"/>
							</binaryOperatorExpression>
							<binaryOperatorExpression operator="GreaterThan">
								<propertyReferenceExpression name="Count">
									<propertyReferenceExpression name="Files">
										<propertyReferenceExpression name="Request">
											<argumentReferenceExpression name="context"/>
										</propertyReferenceExpression>
									</propertyReferenceExpression>
								</propertyReferenceExpression>
								<primitiveExpression value="0"/>
							</binaryOperatorExpression>
						</binaryOperatorExpression>
					</condition>
					<trueStatements>
						<assignStatement>
							<variableReferenceExpression name="methodName"/>
							<primitiveExpression value="_finishImportUpload"/>
						</assignStatement>
						<variableDeclarationStatement type="System.String" name="tempFileName">
							<init>
								<primitiveExpression value="null"/>
							</init>
						</variableDeclarationStatement>
						<tryStatement>
							<statements>
								<comment>save file to the temporary folder</comment>
								<variableDeclarationStatement type="System.String" name="fileName">
									<init>
										<propertyReferenceExpression name="FileName">
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Files">
														<propertyReferenceExpression name="Request">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="0"/>
												</indices>
											</arrayIndexerExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="extension">
									<init>
										<methodInvokeExpression methodName="ToLower">
											<target>
												<methodInvokeExpression methodName="GetExtension">
													<target>
														<typeReferenceExpression type="Path"/>
													</target>
													<parameters>
														<variableReferenceExpression name="fileName"/>
													</parameters>
												</methodInvokeExpression>
											</target>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<variableReferenceExpression name="tempFileName"/>
									<methodInvokeExpression methodName="Combine">
										<target>
											<typeReferenceExpression type="Path"/>
										</target>
										<parameters>
											<propertyReferenceExpression name="SharedTempPath">
												<typeReferenceExpression type="ImportProcessor"/>
											</propertyReferenceExpression>
											<binaryOperatorExpression operator="Add">
												<methodInvokeExpression methodName="ToString">
													<target>
														<methodInvokeExpression methodName="NewGuid">
															<target>
																<typeReferenceExpression type="Guid"/>
															</target>
														</methodInvokeExpression>
													</target>
												</methodInvokeExpression>
												<variableReferenceExpression name="extension"/>
											</binaryOperatorExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<methodInvokeExpression methodName="SaveAs">
									<target>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Files">
													<propertyReferenceExpression name="Request">
														<argumentReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="0"/>
											</indices>
										</arrayIndexerExpression>
									</target>
									<parameters>
										<variableReferenceExpression name="tempFileName"/>
									</parameters>
								</methodInvokeExpression>
								<comment>return response to the client</comment>
								<variableDeclarationStatement type="ImportProcessorBase" name="ip">
									<init>
										<methodInvokeExpression methodName="Create">
											<target>
												<propertyReferenceExpression name="ImportProcessorFactory"/>
											</target>
											<parameters>
												<variableReferenceExpression name="tempFileName"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.Int32" name="numberOfRecords">
									<init>
										<methodInvokeExpression methodName="CountRecords">
											<target>
												<variableReferenceExpression name="ip"/>
											</target>
											<parameters>
												<variableReferenceExpression name="tempFileName"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="availableImportFields">
									<init>
										<methodInvokeExpression methodName="CreateListOfAvailableFields">
											<target>
												<variableReferenceExpression name="ip"/>
											</target>
											<parameters>
												<variableReferenceExpression name="controller"/>
												<variableReferenceExpression name="view"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="System.String" name="fieldMap">
									<init>
										<methodInvokeExpression methodName="CreateInitialFieldMap">
											<target>
												<variableReferenceExpression name="ip"/>
											</target>
											<parameters>
												<variableReferenceExpression name="tempFileName"/>
												<variableReferenceExpression name="controller"/>
												<variableReferenceExpression name="view"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<variableReferenceExpression name="data"/>
									<methodInvokeExpression methodName="Format">
										<target>
											<typeReferenceExpression type="String"/>
										</target>
										<parameters>
											<xsl:variable name="Html" xml:space="preserve">
                        <![CDATA[
<form>
<input id="NumberOfRecords" type="hidden" value="{0}"/>
<input id="AvailableImportFields" type="hidden" value="{1}"/>
<input id="FieldMap" type="hidden" value="{2}"/><input id="FileName" type="hidden" value="{3}"/>
</form>]]></xsl:variable>
											<primitiveExpression value="{ontime:NormalizeLineEndings($Html)}"/>
											<variableReferenceExpression name="numberOfRecords"/>
											<methodInvokeExpression methodName="HtmlAttributeEncode">
												<target>
													<typeReferenceExpression type="HttpUtility"/>
												</target>
												<parameters>
													<variableReferenceExpression name="availableImportFields"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="HtmlAttributeEncode">
												<target>
													<typeReferenceExpression type="HttpUtility"/>
												</target>
												<parameters>
													<variableReferenceExpression name="fieldMap"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="GetFileName">
												<target>
													<typeReferenceExpression type="Path"/>
												</target>
												<parameters>
													<variableReferenceExpression name="tempFileName"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
							</statements>
							<catch exceptionType="Exception" localName="error">
								<whileStatement>
									<test>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="error"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</test>
									<statements>
										<methodInvokeExpression methodName="AppendLine">
											<target>
												<variableReferenceExpression name="errors"/>
											</target>
											<parameters>
												<propertyReferenceExpression name="Message">
													<variableReferenceExpression name="error"/>
												</propertyReferenceExpression>
											</parameters>
										</methodInvokeExpression>
										<assignStatement>
											<variableReferenceExpression name="error"/>
											<propertyReferenceExpression name="InnerException">
												<variableReferenceExpression name="error"/>
											</propertyReferenceExpression>
										</assignStatement>
									</statements>
								</whileStatement>
								<assignStatement>
									<variableReferenceExpression name="data"/>
									<methodInvokeExpression methodName="Format">
										<target>
											<typeReferenceExpression type="String"/>
										</target>
										<parameters>
											<primitiveExpression>
												<xsl:attribute name="value"><![CDATA[<form><input type="hidden" id="Errors" value="{0}"/>]]></xsl:attribute>
											</primitiveExpression>
											<methodInvokeExpression methodName="HtmlAttributeEncode">
												<target>
													<typeReferenceExpression type="HttpUtility"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="ToString">
														<target>
															<variableReferenceExpression name="errors"/>
														</target>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
								<tryStatement>
									<statements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Exists">
													<target>
														<typeReferenceExpression type="File"/>
													</target>
													<parameters>
														<variableReferenceExpression name="tempFileName"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Delete">
													<target>
														<typeReferenceExpression type="File"/>
													</target>
													<parameters>
														<variableReferenceExpression name="tempFileName"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</tryStatement>
							</catch>
						</tryStatement>
					</trueStatements>
					<falseStatements>
						<throwExceptionStatement>
							<objectCreateExpression type="HttpException">
								<parameters>
									<primitiveExpression value="404"/>
									<propertyReferenceExpression name="Empty">
										<typeReferenceExpression type="String"/>
									</propertyReferenceExpression>
								</parameters>
							</objectCreateExpression>
						</throwExceptionStatement>
					</falseStatements>
				</conditionStatement>
			</falseStatements>
		</conditionStatement>
		<comment>format response and send it to the client</comment>
		<variableDeclarationStatement type="System.String" name="responseTemplate">
			<init>
				<xsl:variable name="Html2" xml:space="preserve">
          <![CDATA[
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head></head><body onload="if (parent && parent.window.$find)parent.window.$find('{0}').{1}(document)">{2}</body></html>]]></xsl:variable>
				<primitiveExpression value="{ontime:NormalizeLineEndings($Html2)}"/>
			</init>
		</variableDeclarationStatement>
		<assignStatement>
			<propertyReferenceExpression name="ContentType">
				<propertyReferenceExpression name="Response">
					<argumentReferenceExpression name="context"/>
				</propertyReferenceExpression>
			</propertyReferenceExpression>
			<primitiveExpression value="text/html"/>
		</assignStatement>
		<methodInvokeExpression methodName="Write">
			<target>
				<propertyReferenceExpression name="Response">
					<argumentReferenceExpression name="context"/>
				</propertyReferenceExpression>
			</target>
			<parameters>
				<methodInvokeExpression methodName="Format">
					<target>
						<typeReferenceExpression type="String"/>
					</target>
					<parameters>
						<variableReferenceExpression name="responseTemplate"/>
						<variableReferenceExpression name="parentId"/>
						<variableReferenceExpression name="methodName"/>
						<variableReferenceExpression name="data"/>
					</parameters>
				</methodInvokeExpression>
			</parameters>
		</methodInvokeExpression>
	</xsl:template>
</xsl:stylesheet>
