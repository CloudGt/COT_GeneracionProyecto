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
        <!-- class ActionGroup -->
        <typeDeclaration name="ActionGroup">
          <members>
            <!-- property Scope -->
            <memberProperty type="System.String" name="Scope">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property HeaderText -->
            <memberProperty type="System.String" name="HeaderText">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Flat -->
            <memberProperty type="System.Boolean" name="Flat">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Id -->
            <memberProperty type="System.String" name="Id">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Actions -->
            <memberField type="List" name="actions">
              <typeArguments>
                <typeReference type="Action"/>
              </typeArguments>
            </memberField>
            <memberProperty type="List" name="Actions">
              <typeArguments>
                <typeReference type="Action"/>
              </typeArguments>
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="actions"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- constructor ActionGroup() -->
            <constructor>
              <attributes public="true"/>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="actions">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <objectCreateExpression type="List">
                    <typeArguments>
                      <typeReference type="Action"/>
                    </typeArguments>
                  </objectCreateExpression>
                </assignStatement>
              </statements>
            </constructor>
            <!-- constructor ActionGroup(XPathNavigator, IXmlNamespaceResolver) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="XPathNavigator" name="actionGroup"/>
                <parameter type="IXmlNamespaceResolver" name="resolver"/>
              </parameters>
              <chainedConstructorArgs></chainedConstructorArgs>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="scope">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="actionGroup"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="scope"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <!--<castExpression targetType="System.String">
										<methodInvokeExpression methodName="Evaluate">
											<target>
												<argumentReferenceExpression name="actionGroup"/>
											</target>
											<parameters>
												<primitiveExpression value="string(@scope)"/>
											</parameters>
										</methodInvokeExpression>
									</castExpression>-->
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="headerText">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <!--<castExpression targetType="System.String">
										<methodInvokeExpression methodName="Evaluate">
											<target>
												<argumentReferenceExpression name="actionGroup"/>
											</target>
											<parameters>
												<primitiveExpression value="string(@headerText)"/>
											</parameters>
										</methodInvokeExpression>
									</castExpression>-->
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="actionGroup"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="headerText"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="Id">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="actionGroup"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="id"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="flat"/>
                  <binaryOperatorExpression operator="ValueEquality">
                    <methodInvokeExpression methodName="GetAttribute">
                      <target>
                        <argumentReferenceExpression name="actionGroup"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="flat"/>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="String"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <primitiveExpression value="true" convertTo="String"/>
                  </binaryOperatorExpression>
                </assignStatement>
                <variableDeclarationStatement type="XPathNodeIterator" name="actionIterator">
                  <init>
                    <methodInvokeExpression methodName="Select">
                      <target>
                        <argumentReferenceExpression name="actionGroup"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="c:action"/>
                        <argumentReferenceExpression name="resolver"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <whileStatement>
                  <test>
                    <methodInvokeExpression methodName="MoveNext">
                      <target>
                        <variableReferenceExpression name="actionIterator"/>
                      </target>
                    </methodInvokeExpression>
                  </test>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="UserIsInRole">
                          <target>
                            <typeReferenceExpression type="Controller"/>
                          </target>
                          <parameters>
                            <methodInvokeExpression methodName="GetAttribute">
                              <target>
                                <propertyReferenceExpression name="Current">
                                  <variableReferenceExpression name="actionIterator"/>
                                </propertyReferenceExpression>
                              </target>
                              <parameters>
                                <primitiveExpression value="roles"/>
                                <propertyReferenceExpression name="Empty">
                                  <typeReferenceExpression type="String"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                            <!--<castExpression targetType="System.String">
															<methodInvokeExpression methodName="Evaluate">
																<target>
																	<propertyReferenceExpression name="Current">
																		<variableReferenceExpression name="actionIterator"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="string(@roles)"/>
																</parameters>
															</methodInvokeExpression>
														</castExpression>-->
                          </parameters>
                        </methodInvokeExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <propertyReferenceExpression name="Actions">
                              <thisReferenceExpression/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <objectCreateExpression type="Action">
                              <parameters>
                                <propertyReferenceExpression name="Current">
                                  <variableReferenceExpression name="actionIterator"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="resolver"/>
                              </parameters>
                            </objectCreateExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </whileStatement>
              </statements>
            </constructor>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
