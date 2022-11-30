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
        <!-- class ActionArgs -->
        <typeDeclaration name="ActionArgs">
          <members>
            <!-- property Sequence -->
            <memberProperty type="Nullable" name="Sequence">
              <typeArguments>
                <typeReference type="System.Int32"/>
              </typeArguments>
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Sequence -->
            <memberProperty type="Nullable" name="Date">
              <typeArguments>
                <typeReference type="DateTime"/>
              </typeArguments>
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property IgnoreBusinessRules -->
            <memberProperty type="System.Boolean" name="IgnoreBusinessRules">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Tag -->
            <memberProperty type="System.String" name="Tag">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property CommandName -->
            <memberField type="System.String" name="commandName">
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
            <memberProperty type="System.String" name="CommandName">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="commandName"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="commandName"/>
                  <methodInvokeExpression methodName="ValidateName">
                    <target>
                      <typeReferenceExpression type="ControllerUtilities"/>
                    </target>
                    <parameters>
                      <propertySetValueReferenceExpression/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property CommandArgument -->
            <memberField type="System.String" name="commandArgument">
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
            <memberProperty type="System.String" name="CommandArgument">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="commandArgument"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="commandArgument"/>
                  <methodInvokeExpression methodName="ValidateName">
                    <target>
                      <typeReferenceExpression type="ControllerUtilities"/>
                    </target>
                    <parameters>
                      <propertySetValueReferenceExpression/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property LastCommandName -->
            <memberField type="System.String" name="lastCommandName">
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
            <memberProperty type="System.String" name="LastCommandName">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="lastCommandName"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="lastCommandName"/>
                  <methodInvokeExpression methodName="ValidateName">
                    <target>
                      <typeReferenceExpression type="ControllerUtilities"/>
                    </target>
                    <parameters>
                      <propertySetValueReferenceExpression/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property ContextKey -->
            <memberField type="System.String" name="contextKey">
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
            <memberProperty type="System.String" name="ContextKey">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="contextKey"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="contextKey"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Path -->
            <memberProperty type="System.String" name="Path">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Cookie -->
            <!--<memberField type="System.String" name="cookie">
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
            <memberProperty type="System.String" name="Cookie">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="cookie"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="cookie"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>-->
            <!-- property Controller -->
            <memberField type="System.String" name="controller">
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
                  <methodInvokeExpression methodName="ValidateName">
                    <target>
                      <typeReferenceExpression type="ControllerUtilities"/>
                    </target>
                    <parameters>
                      <propertySetValueReferenceExpression/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property View -->
            <memberField type="System.String" name="view">
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
                  <methodInvokeExpression methodName="ValidateName">
                    <target>
                      <typeReferenceExpression type="ControllerUtilities"/>
                    </target>
                    <parameters>
                      <propertySetValueReferenceExpression/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property LastView -->
            <memberField type="System.String" name="lastView">
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
            <memberProperty type="System.String" name="LastView">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="lastView"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="lastView"/>
                  <methodInvokeExpression methodName="ValidateName">
                    <target>
                      <typeReferenceExpression type="ControllerUtilities"/>
                    </target>
                    <parameters>
                      <propertySetValueReferenceExpression/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Values -->
            <memberField type="FieldValue[]" name="values">
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
            <memberProperty type="FieldValue[]" name="Values">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="values"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="values"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Filter -->
            <memberField type="System.String[]" name="filter">
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
            <memberProperty type="System.String[]" name="Filter">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="filter"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="filter"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property SortExpression -->
            <memberProperty type="System.String" name="SortExpression">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property GroupExpression -->
            <memberProperty type="System.String" name="GroupExpression">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property SqlCommandType -->
            <memberProperty type="CommandConfigurationType" name="SqlCommandType">
              <attributes public="true" final="true"/>
              <getStatements>
                <variableDeclarationStatement type="CommandConfigurationType" name="commandType">
                  <init>
                    <propertyReferenceExpression name="None">
                      <typeReferenceExpression type="CommandConfigurationType"/>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="Equals">
                      <target>
                        <propertyReferenceExpression name="CommandName"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="update"/>
                        <propertyReferenceExpression name="OrdinalIgnoreCase">
                          <typeReferenceExpression type="StringComparison"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="commandType"/>
                      <propertyReferenceExpression name="Update">
                        <typeReferenceExpression type="CommandConfigurationType"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="Equals">
                          <target>
                            <propertyReferenceExpression name="CommandName"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="insert"/>
                            <propertyReferenceExpression name="OrdinalIgnoreCase">
                              <typeReferenceExpression type="StringComparison"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="commandType"/>
                          <propertyReferenceExpression name="Insert">
                            <typeReferenceExpression type="CommandConfigurationType"/>
                          </propertyReferenceExpression>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="Equals">
                              <target>
                                <propertyReferenceExpression name="CommandName"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="delete"/>
                                <propertyReferenceExpression name="OrdinalIgnoreCase">
                                  <typeReferenceExpression type="StringComparison"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="commandType"/>
                              <propertyReferenceExpression name="Delete">
                                <typeReferenceExpression type="CommandConfigurationType"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="commandType"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property IsBatchEditOrDelete -->
            <memberProperty type="System.Boolean" name="IsBatchEditOrDelete">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <binaryOperatorExpression operator="BooleanOr">
                    <binaryOperatorExpression operator="BooleanAnd">
                      <binaryOperatorExpression operator="ValueEquality">
                        <propertyReferenceExpression name="LastCommandName"/>
                        <primitiveExpression value="BatchEdit"/>
                      </binaryOperatorExpression>
                      <binaryOperatorExpression operator="ValueEquality">
                        <propertyReferenceExpression name="CommandName"/>
                        <primitiveExpression value="Update"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <binaryOperatorExpression operator="ValueEquality">
                        <propertyReferenceExpression name="CommandName"/>
                        <primitiveExpression value="Delete"/>
                      </binaryOperatorExpression>
                      <binaryOperatorExpression operator="GreaterThan">
                        <propertyReferenceExpression name="Length">
                          <propertyReferenceExpression name="SelectedValues"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="1"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </binaryOperatorExpression>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property SelectedValues -->
            <memberField type="System.String[]" name="selectedValues">
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
            <memberProperty type="System.String[]" name="SelectedValues">
              <attributes public="true" final="true"/>
              <getStatements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <fieldReferenceExpression name="selectedValues"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="selectedValues"/>
                      <arrayCreateExpression>
                        <createType type="System.String"/>
                        <sizeExpression>
                          <primitiveExpression value="0"/>
                        </sizeExpression>
                      </arrayCreateExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <fieldReferenceExpression name="selectedValues"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="selectedValues"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property ExternalFilter -->
            <memberField type="FieldValue[]" name="externalFilter">
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
            <memberProperty type="FieldValue[]" name="ExternalFilter">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="externalFilter"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="externalFilter"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property SaveLEVs -->
            <memberField type="System.Boolean" name="saveLEVs">
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
            <memberProperty type="System.Boolean" name="SaveLEVs">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="saveLEVs"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="saveLEVs"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Current -->
            <memberProperty type="ActionArgs" name="Current">
              <attributes public="true" static="true"/>
              <getStatements>
                <methodReturnStatement>
                  <castExpression targetType="ActionArgs">
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Items">
                          <propertyReferenceExpression name="Current">
                            <typeReferenceExpression type="HttpContext"/>
                          </propertyReferenceExpression>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <primitiveExpression value="ActionArgs_Current"/>
                      </indices>
                    </arrayIndexerExpression>
                  </castExpression>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- method Forget() -->
            <memberMethod name="Forget">
              <attributes public="true" static="true"/>
              <statements>
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
                      <primitiveExpression value="ActionArgs_Current"/>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="null"/>
                </assignStatement>
              </statements>
            </memberMethod>
            <!-- property Trigger -->
            <memberProperty type="System.String" name="Trigger">
              <comment>
                <![CDATA[
        /// <summary>
        /// The name of the field that has triggered the 'Calculate' action.
        /// </summary>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- constructor ActionArgs() -->
            <constructor>
              <attributes  public="true"/>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <binaryOperatorExpression operator="IdentityInequality">
                        <propertyReferenceExpression name="Current">
                          <typeReferenceExpression type="HttpContext"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <propertyReferenceExpression name="Current"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
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
                          <primitiveExpression value="ActionArgs_Current"/>
                        </indices>
                      </arrayIndexerExpression>
                      <thisReferenceExpression/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </constructor>
            <!-- property this[string]-->
            <memberProperty type="FieldValue" name="Item">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
              </parameters>
              <getStatements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SelectFieldValueObject">
                    <parameters>
                      <argumentReferenceExpression name="name"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
                <!--<foreachStatement>
                  <variable type="FieldValue" name="v"/>
                  <target>
                    <propertyReferenceExpression name="Values"/>
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
                            <propertyReferenceExpression name="CurrentCultureIgnoreCase">
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
                <methodReturnStatement>
                  <primitiveExpression value="null"/>
                </methodReturnStatement>-->
              </getStatements>
            </memberProperty>
            <!-- method SelectFieldValeObject(string) -->
            <memberMethod returnType="FieldValue" name="SelectFieldValueObject">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
              </parameters>
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
                            <methodInvokeExpression methodName="Equals">
                              <target>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="v"/>
                                </propertyReferenceExpression>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="name"/>
                                <propertyReferenceExpression name="OrdinalIgnoreCase">
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
                </conditionStatement>
                <methodReturnStatement>
                  <primitiveExpression value="null"/>
                </methodReturnStatement>
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
                        <variableReferenceExpression name="theObject"/>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="theObject"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- property AddValue(params FIeldValue[]) -->
            <memberMethod name="AddValue">
              <attributes final="true" public="true"/>
              <parameters>
                <parameter type="params FieldValue[]" name="values"/>
              </parameters>
              <statements>
                <variableDeclarationStatement name="newValues">
                  <init>
                    <objectCreateExpression type="List">
                      <typeArguments>
                        <typeReference type="FieldValue"/>
                      </typeArguments>
                      <parameters>
                        <propertyReferenceExpression name="Values"/>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement><variable type="FieldValue" name="fvo"/>
                  <target>
                    <variableReferenceExpression name="values"/>
                  </target>
                  <statements>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="newValues"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="fvo"/>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                </foreachStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Values"/>
                  <methodInvokeExpression methodName="ToArray">
                    <target>
                      <variableReferenceExpression name="newValues"/>
                    </target>
                  </methodInvokeExpression>
                </assignStatement>
              </statements>
            </memberMethod>
            <!-- property RquiresPivot -->
            <!--<memberProperty type="System.Boolean" name="RequiresPivot">
              <attributes public="true" final="true"/>
              <getStatements>
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
                            <methodInvokeExpression methodName="StartsWith">
                              <target>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="v"/>
                                </propertyReferenceExpression>
                              </target>
                              <parameters>
                                <primitiveExpression value="PivotCol"/>
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
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <primitiveExpression value="false"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>-->
            <!-- property PivotValues -->
            <!--<memberProperty type="FieldValue[][]" name="PivotValues">
              <attributes public="true" final="true"/>
              <getStatements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <propertyReferenceExpression name="Values"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <primitiveExpression value="null"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="List" name="valueSets">
                  <typeArguments>
                    <typeReference type="FieldValue[]"/>
                  </typeArguments>
                  <init>
                    <objectCreateExpression type="List">
                      <typeArguments>
                        <typeReference type="FieldValue[]"/>
                      </typeArguments>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Int32" name="valueSetIndex">
                  <init>
                    <primitiveExpression value="0"/>
                  </init>
                </variableDeclarationStatement>
                <whileStatement>
                  <test>
                    <primitiveExpression value="true"/>
                  </test>
                  <statements>
                    <variableDeclarationStatement type="List" name="valueNames">
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
                    <variableDeclarationStatement type="List" name="currentSet">
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
                      <variable type="FieldValue" name="v"/>
                      <target>
                        <propertyReferenceExpression name="Values"/>
                      </target>
                      <statements>
                        <variableDeclarationStatement type="Match" name="m">
                          <init>
                            <methodInvokeExpression methodName="Match">
                              <target>
                                <typeReferenceExpression type="Regex"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="v"/>
                                </propertyReferenceExpression>
                                <primitiveExpression value="^PivotCol(\d+)_(.+)$"/>
                              </parameters>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="BooleanAnd">
                              <propertyReferenceExpression name="Success">
                                <variableReferenceExpression name="m"/>
                              </propertyReferenceExpression>
                              <binaryOperatorExpression operator="ValueEquality">
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
                                <methodInvokeExpression methodName="ToString">
                                  <target>
                                    <variableReferenceExpression name="valueSetIndex"/>
                                  </target>
                                </methodInvokeExpression>
                              </binaryOperatorExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="v"/>
                              </propertyReferenceExpression>
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
                            </assignStatement>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="valueNames"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="v"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="currentSet"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="v"/>
                              </parameters>
                            </methodInvokeExpression>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </foreachStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Count">
                            <variableReferenceExpression name="currentSet"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <breakStatement/>
                      </trueStatements>
                    </conditionStatement>
                    <foreachStatement>
                      <variable type="FieldValue" name="v"/>
                      <target>
                        <propertyReferenceExpression name="Values"/>
                      </target>
                      <statements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="BooleanAnd">
                              <unaryOperatorExpression operator="Not">
                                <methodInvokeExpression methodName="StartsWith">
                                  <target>
                                    <propertyReferenceExpression name="Name">
                                      <variableReferenceExpression name="v"/>
                                    </propertyReferenceExpression>
                                  </target>
                                  <parameters>
                                    <primitiveExpression value="PivotCol"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </unaryOperatorExpression>
                              <unaryOperatorExpression operator="Not">
                                <methodInvokeExpression methodName="Contains">
                                  <target>
                                    <variableReferenceExpression name="valueNames"/>
                                  </target>
                                  <parameters>
                                    <propertyReferenceExpression name="Name">
                                      <variableReferenceExpression name="v"/>
                                    </propertyReferenceExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </unaryOperatorExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="currentSet"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="v"/>
                              </parameters>
                            </methodInvokeExpression>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </foreachStatement>
                    <assignStatement>
                      <variableReferenceExpression name="valueSetIndex"/>
                      <binaryOperatorExpression operator="Add">
                        <variableReferenceExpression name="valueSetIndex"/>
                        <primitiveExpression value="1"/>
                      </binaryOperatorExpression>
                    </assignStatement>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="valueSets"/>
                      </target>
                      <parameters>
                        <methodInvokeExpression methodName="ToArray">
                          <target>
                            <variableReferenceExpression name="currentSet"/>
                          </target>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                </whileStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="ToArray">
                    <target>
                      <variableReferenceExpression name="valueSets"/>
                    </target>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>-->
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
