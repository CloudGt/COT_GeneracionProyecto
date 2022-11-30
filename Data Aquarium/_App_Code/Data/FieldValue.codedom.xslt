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
        <namespaceImport name="System.Collections"/>
        <namespaceImport name="System.Collections.Generic"/>
      </imports>
      <types>
        <!-- class FieldValue -->
        <typeDeclaration name="FieldValue">
          <customAttributes>
            <customAttribute name="Serializable"/>
          </customAttributes>
          <members>
            <!-- field newValueIsSet -->
            <memberField type="System.Boolean" name="newValueIsSet">
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
            <!-- field modifiedIsSet-->
            <memberField type="System.Boolean" name="modifiedIsSet">
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
                <methodReturnStatement>
                  <fieldReferenceExpression name="name"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="name"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property OldValue -->
            <memberField type="System.Object" name="oldValue">
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
            <memberProperty type="System.Object" name="OldValue">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="oldValue"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <fieldReferenceExpression name="enableConversion"/>
                      <binaryOperatorExpression operator="IsTypeOf">
                        <propertySetValueReferenceExpression/>
                        <typeReferenceExpression type="System.String"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="oldValue"/>
                      <methodInvokeExpression methodName="StringToValue">
                        <target>
                          <typeReferenceExpression type="DataControllerBase"/>
                        </target>
                        <parameters>
                          <castExpression targetType="System.String">
                            <propertySetValueReferenceExpression/>
                          </castExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="oldValue"/>
                      <propertySetValueReferenceExpression/>
                    </assignStatement>
                  </falseStatements>
                </conditionStatement>
              </setStatements>
            </memberProperty>
            <!-- property NewValue -->
            <memberField type="System.Object" name="newValue">
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
            <memberProperty type="System.Object" name="NewValue">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="newValue"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <!--<assignStatement>
                  <fieldReferenceExpression name="newValue"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>-->
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <fieldReferenceExpression name="enableConversion"/>
                      <binaryOperatorExpression operator="IsTypeOf">
                        <propertySetValueReferenceExpression/>
                        <typeReferenceExpression type="System.String"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="newValue"/>
                      <methodInvokeExpression methodName="StringToValue">
                        <target>
                          <typeReferenceExpression type="DataControllerBase"/>
                        </target>
                        <parameters>
                          <castExpression targetType="System.String">
                            <propertySetValueReferenceExpression/>
                          </castExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="newValue"/>
                      <propertySetValueReferenceExpression/>
                    </assignStatement>
                  </falseStatements>
                </conditionStatement>
              </setStatements>
            </memberProperty>
            <!-- property Modified -->
            <memberField type="System.Boolean" name="modified">
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
            <memberProperty type="System.Boolean" name="Modified">
              <attributes public="true" final="true"/>
              <getStatements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <fieldReferenceExpression name="modifiedIsSet"/>
                      <unaryOperatorExpression operator="Not">
                        <propertyReferenceExpression name="ReadOnly"/>
                      </unaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <fieldReferenceExpression name="modified"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <binaryOperatorExpression operator="BooleanAnd">
                    <fieldReferenceExpression name="newValueIsSet"/>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="ReadOnly"/>
                    </unaryOperatorExpression>
                  </binaryOperatorExpression>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="modified"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="modifiedIsSet"/>
                  <primitiveExpression value="true"/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- ReadOnly -->
            <memberProperty type="System.Boolean" name="ReadOnly">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Value -->
            <memberProperty type="System.Object" name="Value">
              <attributes public="true" final="true"/>
              <getStatements>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="ReadOnly"/>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <fieldReferenceExpression name="newValueIsSet"/>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <propertyReferenceExpression name="NewValue"/>
                        </methodReturnStatement>
                      </trueStatements>
                      <falseStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="BooleanAnd">
                              <fieldReferenceExpression name="modifiedIsSet"/>
                              <fieldReferenceExpression name="modified"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodReturnStatement>
                              <propertyReferenceExpression name="NewValue"/>
                            </methodReturnStatement>
                          </trueStatements>
                          <falseStatements>
                            <methodReturnStatement>
                              <propertyReferenceExpression name="OldValue"/>
                            </methodReturnStatement>
                          </falseStatements>
                        </conditionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="Modified"/>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <propertyReferenceExpression name="NewValue"/>
                    </methodReturnStatement>
                  </trueStatements>
                  <falseStatements>
                    <methodReturnStatement>
                      <propertyReferenceExpression name="OldValue"/>
                    </methodReturnStatement>
                  </falseStatements>
                </conditionStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <propertyReferenceExpression name="OldValue"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Modified"/>
                  <primitiveExpression value="false"/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Error -->
            <memberProperty type="System.String" name="Error">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Scope -->
            <memberProperty type="System.String" name="Scope">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- constructor FieldValue() -->
            <constructor>
              <attributes public="true"/>
            </constructor>
            <!-- constructor FieldValue(string) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="name"/>
                  <argumentReferenceExpression name="fieldName"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- constructor FieldValue(string, object) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
                <parameter type="System.Object" name="newValue"/>
              </parameters>
              <chainedConstructorArgs>
                <variableReferenceExpression name="fieldName"/>
                <primitiveExpression value="null"/>
                <variableReferenceExpression name="newValue"/>
              </chainedConstructorArgs>
            </constructor>
            <!-- constructor FieldValue(string, object, object) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
                <parameter type="System.Object" name="oldValue"/>
                <parameter type="System.Object" name="newValue"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="name"/>
                  <argumentReferenceExpression name="fieldName"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="oldValue"/>
                  <argumentReferenceExpression name="oldValue"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="newValue"/>
                  <argumentReferenceExpression name="newValue"/>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <binaryOperatorExpression operator="IdentityInequality">
                        <argumentReferenceExpression name="newValue"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                      <binaryOperatorExpression operator="IdentityInequality">
                        <argumentReferenceExpression name="oldValue"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="newValueIsSet"/>
                      <unaryOperatorExpression operator="Not">
                        <methodInvokeExpression methodName="Equals">
                          <target>
                            <argumentReferenceExpression name="newValue"/>
                          </target>
                          <parameters>
                            <argumentReferenceExpression name="oldValue"/>
                          </parameters>
                        </methodInvokeExpression>
                      </unaryOperatorExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="newValueIsSet"/>
                      <binaryOperatorExpression operator="BooleanOr">
                        <binaryOperatorExpression operator="BooleanOr">
                          <binaryOperatorExpression operator="BooleanAnd">
                            <binaryOperatorExpression operator="IdentityInequality">
                              <argumentReferenceExpression name="newValue"/>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                            <binaryOperatorExpression operator="IdentityEquality">
                              <argumentReferenceExpression name="oldValue"/>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                          </binaryOperatorExpression>
                          <binaryOperatorExpression operator="BooleanAnd">
                            <binaryOperatorExpression operator="IdentityInequality">
                              <argumentReferenceExpression name="oldValue"/>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                            <binaryOperatorExpression operator="IdentityEquality">
                              <argumentReferenceExpression name="newValue"/>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                          </binaryOperatorExpression>
                        </binaryOperatorExpression>
                        <binaryOperatorExpression operator="ValueInequality">
                          <argumentReferenceExpression name="newValue"/>
                          <argumentReferenceExpression name="oldValue"/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </assignStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </constructor>
            <!-- constructor(string, object, object, bool) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
                <parameter type="System.Object" name="oldValue"/>
                <parameter type="System.Object" name="newValue"/>
                <parameter type="System.Boolean" name="readOnly"/>
              </parameters>
              <chainedConstructorArgs>
                <argumentReferenceExpression name="fieldName"/>
                <argumentReferenceExpression name="oldValue"/>
                <argumentReferenceExpression name="newValue"/>
              </chainedConstructorArgs>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="readOnly"/>
                  <argumentReferenceExpression name="readOnly"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- method ToString() -->
            <memberMethod returnType="System.String" name="ToString">
              <attributes public ="true" override="true"/>
              <statements>
                <variableDeclarationStatement type="System.String" name="oldValueInfo">
                  <init>
                    <propertyReferenceExpression name="Empty">
                      <typeReferenceExpression type="String"/>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Object" name="v">
                  <init>
                    <propertyReferenceExpression name="Value"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="Modified"/>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.Object" name="ov">
                      <init>
                        <propertyReferenceExpression name="OldValue"/>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityEquality">
                          <variableReferenceExpression name="ov"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="ov"/>
                          <primitiveExpression value="null" convertTo="String"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <assignStatement>
                      <variableReferenceExpression name="oldValueInfo"/>
                      <methodInvokeExpression methodName="Format">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <primitiveExpression value=" (old value = {{0}})"/>
                          <variableReferenceExpression name="ov"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="System.String" name="isReadOnly">
                  <init>
                    <propertyReferenceExpression name="Empty">
                      <typeReferenceExpression type="String"/>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="ReadOnly"/>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="isReadOnly"/>
                      <primitiveExpression value=" (read-only)"/>
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
                <variableDeclarationStatement type="System.String" name="err">
                  <init>
                    <propertyReferenceExpression name="Empty">
                      <typeReferenceExpression type="String"/>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <propertyReferenceExpression name="Error"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="err"/>
                      <stringFormatExpression format="; Input Error: {{0}}">
                        <propertyReferenceExpression name="Error"/>
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
                      <stringFormatExpression format="{{0}} = {{1}}{{2}}{{3}}{{4}}">
                        <propertyReferenceExpression name="Name"/>
                        <propertyReferenceExpression name="v"/>
                        <variableReferenceExpression name="oldValueInfo"/>
                        <variableReferenceExpression name="isReadOnly"/>
                        <variableReferenceExpression name="err"/>
                      </stringFormatExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CheckModified() -->
            <!--<memberMethod name="CheckModified">
              <attributes public="true" final="true"/>
              <statements>
                <conditionStatement>
                  <condition>
                    <fieldReferenceExpression name="noCheck"/>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement/>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="Equals">
                      <target>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="String"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="NewValue"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="NewValue"/>
                      <primitiveExpression value="null"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <propertyReferenceExpression name="NewValue"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <propertyReferenceExpression name="OldValue"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <fieldReferenceExpression name="modified"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <assignStatement>
                          <fieldReferenceExpression name="modified"/>
                          <primitiveExpression value="false"/>
                        </assignStatement>
                      </falseStatements>
                    </conditionStatement>
                  </trueStatements>
                  <falseStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <propertyReferenceExpression name="OldValue"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <fieldReferenceExpression name="modified"/>
                          <unaryOperatorExpression operator="Not">
                            <methodInvokeExpression methodName="Equals">
                              <target>
                                <propertyReferenceExpression name="NewValue"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="OldValue"/>
                              </parameters>
                            </methodInvokeExpression>
                          </unaryOperatorExpression>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <assignStatement>
                          <fieldReferenceExpression name="modified"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                      </falseStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>-->
            <!-- method AssignTo(object) -->
            <memberMethod name="AssignTo">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.Object" name="instance"/>
              </parameters>
              <statements>
                <!--<methodInvokeExpression methodName="CheckModified"/>-->
                <variableDeclarationStatement type="Type" name="t">
                  <init>
                    <methodInvokeExpression methodName="GetType">
                      <target>
                        <argumentReferenceExpression name="instance"/>
                      </target>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Reflection.PropertyInfo" name="propInfo">
                  <init>
                    <methodInvokeExpression methodName="GetProperty">
                      <target>
                        <variableReferenceExpression name="t"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Name"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Object" name="v">
                  <init>
                    <propertyReferenceExpression name="Value"/>
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
                    <conditionStatement>
                      <condition>
                        <propertyReferenceExpression name="IsGenericType">
                          <propertyReferenceExpression name="PropertyType">
                            <variableReferenceExpression name="propInfo"/>
                          </propertyReferenceExpression>
                        </propertyReferenceExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="Equals">
                              <target>
                                <propertyReferenceExpression name="PropertyType">
                                  <methodInvokeExpression methodName="GetProperty">
                                    <target>
                                      <propertyReferenceExpression name="PropertyType">
                                        <variableReferenceExpression name="propInfo"/>
                                      </propertyReferenceExpression>
                                    </target>
                                    <parameters>
                                      <primitiveExpression value="Value"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                </propertyReferenceExpression>
                              </target>
                              <parameters>
                                <typeofExpression type="Guid"/>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="v"/>
                              <objectCreateExpression type="Guid">
                                <parameters>
                                  <methodInvokeExpression methodName="ToString">
                                    <target>
                                      <typeReferenceExpression type="Convert"/>
                                    </target>
                                    <parameters>
                                      <variableReferenceExpression name="v"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                </parameters>
                              </objectCreateExpression>
                            </assignStatement>
                          </trueStatements>
                          <falseStatements>
                            <assignStatement>
                              <variableReferenceExpression name="v"/>
                              <methodInvokeExpression methodName="ChangeType">
                                <target>
                                  <typeReferenceExpression type="Convert"/>
                                </target>
                                <parameters>
                                  <variableReferenceExpression name="v"/>
                                  <propertyReferenceExpression name="PropertyType">
                                    <methodInvokeExpression methodName="GetProperty">
                                      <target>
                                        <propertyReferenceExpression name="PropertyType">
                                          <variableReferenceExpression name="propInfo"/>
                                        </propertyReferenceExpression>
                                      </target>
                                      <parameters>
                                        <primitiveExpression value="Value"/>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </propertyReferenceExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </assignStatement>
                          </falseStatements>
                        </conditionStatement>
                      </trueStatements>
                      <falseStatements>
                        <assignStatement>
                          <variableReferenceExpression name="v"/>
                          <methodInvokeExpression methodName="ChangeType">
                            <target>
                              <typeReferenceExpression type="Convert"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="v"/>
                              <propertyReferenceExpression name="PropertyType">
                                <variableReferenceExpression name="propInfo"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </falseStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="InvokeMember">
                  <target>
                    <variableReferenceExpression name="t"/>
                  </target>
                  <parameters>
                    <propertyReferenceExpression name="Name"/>
                    <propertyReferenceExpression name="SetProperty">
                      <typeReferenceExpression type="System.Reflection.BindingFlags"/>
                    </propertyReferenceExpression>
                    <primitiveExpression value="null"/>
                    <argumentReferenceExpression name="instance"/>
                    <arrayCreateExpression>
                      <createType type="System.Object"/>
                      <initializers>
                        <variableReferenceExpression name="v"/>
                      </initializers>
                    </arrayCreateExpression>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- field _enableConversion-->
            <memberField type="System.Boolean" name="enableConversion">
              <attributes private="true"/>
              <customAttributes>
                <customAttribute name="System.Diagnostics.DebuggerBrowsable">
                  <arguments>
                    <propertyReferenceExpression name="Never">
                      <typeReferenceExpression type="System.Diagnostics.DebuggerBrowsableState"/>
                    </propertyReferenceExpression>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <init>
                <primitiveExpression value="true"/>
              </init>
            </memberField>
            <!-- method EnableConversion()-->
            <memberMethod name="EnableConversion">
              <attributes public="true" final="true"/>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="enableConversion"/>
                  <primitiveExpression value="true"/>
                </assignStatement>
              </statements>
            </memberMethod>
            <!-- method DisableConversion()-->
            <memberMethod name="DisableConversion">
              <attributes public="true" final="true"/>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="enableConversion"/>
                  <primitiveExpression value="false"/>
                </assignStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class FieldValueDictionary -->
        <typeDeclaration name="FieldValueDictionary">
          <baseTypes>
            <typeReference type="SortedDictionary">
              <typeArguments>
                <typeReference type="System.String"/>
                <typeReference type="FieldValue"/>
              </typeArguments>
            </typeReference>
          </baseTypes>
          <members>
            <!-- constructor() -->
            <constructor>
              <attributes public="true"/>
            </constructor>
            <!-- constructor(ActionArgs) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="ActionArgs" name="args"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <propertyReferenceExpression name="Values">
                        <variableReferenceExpression name="args"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddRange">
                      <parameters>
                        <propertyReferenceExpression name="Values">
                          <argumentReferenceExpression name="args"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </constructor>
            <!-- constructor(List<FieldValue>) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="List" name="values">
                  <typeArguments>
                    <typeReference type="FieldValue"/>
                  </typeArguments>
                </parameter>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <argumentReferenceExpression name="values"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddRange">
                      <parameters>
                        <methodInvokeExpression methodName="ToArray">
                          <target>
                            <argumentReferenceExpression name="values"/>
                          </target>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </constructor>
            <!-- constructor(FieldValue[]) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="FieldValue[]" name="values"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <argumentReferenceExpression name="values"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddRange">
                      <parameters>
                        <argumentReferenceExpression name="values"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </constructor>
            <!-- method AddRange(FieldValue[]) -->
            <memberMethod name="AddRange">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="FieldValue[]" name="values"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="FieldValue" name="fvo"/>
                  <target>
                    <argumentReferenceExpression name="values"/>
                  </target>
                  <statements>
                    <assignStatement>
                      <arrayIndexerExpression>
                        <target>
                          <thisReferenceExpression/>
                        </target>
                        <indices>
                          <propertyReferenceExpression name="Name">
                            <variableReferenceExpression name="fvo"/>
                          </propertyReferenceExpression>
                        </indices>
                      </arrayIndexerExpression>
                      <variableReferenceExpression name="fvo"/>
                    </assignStatement>
                  </statements>
                </foreachStatement>
              </statements>
            </memberMethod>
            <!-- method Assign(System.Collection.IDictionary, bool) -->
            <memberMethod name="Assign">
              <attributes public ="true" final="true"/>
              <parameters>
                <parameter type="IDictionary" name="values"/>
                <parameter type="System.Boolean" name="assignToNewValues"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="System.String" name="fieldName" var="false"/>
                  <target>
                    <propertyReferenceExpression name="Keys">
                      <argumentReferenceExpression name="values"/>
                    </propertyReferenceExpression>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="ContainsKey">
                            <parameters>
                              <variableReferenceExpression name="fieldName"/>
                            </parameters>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Add">
                          <parameters>
                            <variableReferenceExpression name="fieldName"/>
                            <objectCreateExpression type="FieldValue">
                              <parameters>
                                <variableReferenceExpression name="fieldName"/>
                              </parameters>
                            </objectCreateExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <variableDeclarationStatement type="FieldValue" name="v">
                      <init>
                        <arrayIndexerExpression>
                          <target>
                            <thisReferenceExpression/>
                          </target>
                          <indices>
                            <variableReferenceExpression name="fieldName"/>
                          </indices>
                        </arrayIndexerExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <argumentReferenceExpression name="assignToNewValues"/>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <propertyReferenceExpression name="NewValue">
                            <variableReferenceExpression name="v"/>
                          </propertyReferenceExpression>
                          <arrayIndexerExpression>
                            <target>
                              <argumentReferenceExpression name="values"/>
                            </target>
                            <indices>
                              <variableReferenceExpression name="fieldName"/>
                            </indices>
                          </arrayIndexerExpression>
                        </assignStatement>
                        <!--<methodInvokeExpression methodName="CheckModified">
                          <target>
                            <variableReferenceExpression name="v"/>
                          </target>
                        </methodInvokeExpression>-->
                      </trueStatements>
                      <falseStatements>
                        <assignStatement>
                          <propertyReferenceExpression name="OldValue">
                            <variableReferenceExpression name="v"/>
                          </propertyReferenceExpression>
                          <arrayIndexerExpression>
                            <target>
                              <argumentReferenceExpression name="values"/>
                            </target>
                            <indices>
                              <variableReferenceExpression name="fieldName"/>
                            </indices>
                          </arrayIndexerExpression>
                        </assignStatement>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
