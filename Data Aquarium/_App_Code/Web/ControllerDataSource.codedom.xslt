<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <compileUnit namespace="{a:project/a:namespace}.Web">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Data"/>
        <namespaceImport name="System.Collections"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.ComponentModel"/>
        <namespaceImport name="System.Configuration"/>
        <namespaceImport name="System.IO"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Text"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.UI"/>
        <namespaceImport name="System.Web.UI.HtmlControls"/>
        <namespaceImport name="System.Web.UI.WebControls"/>
        <namespaceImport name="System.Xml"/>
        <namespaceImport name="System.Xml.XPath"/>
        <namespaceImport name="Newtonsoft.Json"/>
        <namespaceImport name="{a:project/a:namespace}.Data"/>
        <namespaceImport name="{a:project/a:namespace}.Web.Design"/>
      </imports>
      <types>
        <!-- class ControllerDataSource -->
        <typeDeclaration name="ControllerDataSource">
          <customAttributes>
            <customAttribute name="Designer">
              <arguments>
                <typeofExpression type="ControllerDataSourceDesigner"/>
              </arguments>
            </customAttribute>
            <customAttribute name="ToolboxData">
              <arguments>
                <primitiveExpression>
                  <xsl:attribute name="value"><![CDATA[<{0}:ControllerDataSource runat="server"></{0}:ControllerDataSource>]]></xsl:attribute>
                </primitiveExpression>
              </arguments>
            </customAttribute>
            <customAttribute name="PersistChildren">
              <arguments>
                <primitiveExpression value="false"/>
              </arguments>
            </customAttribute>
            <customAttribute name="DefaultProperty">
              <arguments>
                <primitiveExpression value="DataController"/>
              </arguments>
            </customAttribute>
            <customAttribute name="ParseChildren">
              <arguments>
                <primitiveExpression value="true"/>
              </arguments>
            </customAttribute>
          </customAttributes>
          <baseTypes>
            <typeReference type="DataSourceControl"/>
          </baseTypes>
          <members>
            <memberField type="ControllerDataSourceView" name="view"/>
            <!-- member DataController -->
            <memberProperty type="System.String" name="DataController">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <propertyReferenceExpression name="DataController">
                    <methodInvokeExpression methodName="GetView"/>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <propertyReferenceExpression name="DataController">
                    <methodInvokeExpression methodName="GetView"/>
                  </propertyReferenceExpression>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- member DataView -->
            <memberProperty type="System.String" name="DataView">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <propertyReferenceExpression name="DataView">
                    <methodInvokeExpression methodName="GetView"/>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <propertyReferenceExpression name="DataView">
                    <methodInvokeExpression methodName="GetView"/>
                  </propertyReferenceExpression>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- member PageRequestParameterName -->
            <memberField type="System.String" name="pageRequestParameterName"/>
            <memberProperty type="System.String" name="PageRequestParameterName">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="pageRequestParameterName"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="pageRequestParameterName"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- method GetView() -->
            <memberMethod returnType="ControllerDataSourceView" name="GetView">
              <attributes family="true" final="true"/>
              <statements>
                <methodReturnStatement>
                  <castExpression targetType="ControllerDataSourceView">
                    <methodInvokeExpression methodName="GetView">
                      <parameters>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="String"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- property FilterParameters -->
            <memberProperty type="ParameterCollection" name="FilterParameters">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="MergableProperty">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
                <customAttribute name="DefaultValue">
                  <arguments>
                    <primitiveExpression value=""/>
                  </arguments>
                </customAttribute>
                <customAttribute name="Editor">
                  <arguments>
                    <primitiveExpression value="System.Web.UI.Design.WebControls.ParameterCollectionEditor, System.Design, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"/>
                    <typeofExpression type="System.Drawing.Design.UITypeEditor"/>
                  </arguments>
                </customAttribute>
                <customAttribute name="PersistenceMode">
                  <arguments>
                    <propertyReferenceExpression name="InnerProperty">
                      <typeReferenceExpression type="PersistenceMode"/>
                    </propertyReferenceExpression>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <propertyReferenceExpression name="FilterParameters">
                    <methodInvokeExpression methodName="GetView"/>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- constructor ControllerDataSource() -->
            <constructor>
              <attributes public="true"/>
              <baseConstructorArgs></baseConstructorArgs>
            </constructor>
            <!-- method OnInit(EventArgs) -->
            <memberMethod name="OnInit">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="EventArgs" name="e"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="OnInit">
                  <target>
                    <baseReferenceExpression/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="e"/>
                  </parameters>
                </methodInvokeExpression>
                <attachEventStatement>
                  <event name="LoadComplete">
                    <propertyReferenceExpression name="Page">
                      <thisReferenceExpression/>
                    </propertyReferenceExpression>
                  </event>
                  <listener>
                    <delegateCreateExpression type="EventHandler" methodName="PageLoadComplete">
                      <target>
                        <thisReferenceExpression/>
                      </target>
                    </delegateCreateExpression>
                  </listener>
                </attachEventStatement>
              </statements>
            </memberMethod>
            <!-- method PageLoadComplete -->
            <memberMethod name="PageLoadComplete">
              <attributes private="true" final="true"/>
              <parameters>
                <parameter type="System.Object" name="sender"/>
                <parameter type="EventArgs" name="e"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="UpdateValues">
                  <target>
                    <propertyReferenceExpression name="FilterParameters"/>
                  </target>
                  <parameters>
                    <propertyReferenceExpression name="Context">
                      <thisReferenceExpression/>
                    </propertyReferenceExpression>
                    <thisReferenceExpression/>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- method GetViewNames() -->
            <memberMethod returnType="ICollection" name="GetViewNames">
              <attributes family="true" override="true"/>
              <statements>
                <methodReturnStatement>
                  <arrayCreateExpression>
                    <createType type="System.String"/>
                    <initializers>
                      <propertyReferenceExpression name="DefaultViewName">
                        <typeReferenceExpression type="ControllerDataSourceView"/>
                      </propertyReferenceExpression>
                    </initializers>
                  </arrayCreateExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method GetView(string) -->
            <memberMethod returnType="DataSourceView" name="GetView">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="viewName"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <fieldReferenceExpression name="view"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="view"/>
                      <objectCreateExpression type="ControllerDataSourceView">
                        <parameters>
                          <thisReferenceExpression/>
                          <propertyReferenceExpression name="Empty">
                            <typeReferenceExpression type="String"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </objectCreateExpression>
                    </assignStatement>
                    <conditionStatement>
                      <condition>
                        <propertyReferenceExpression name="IsTrackingViewState"/>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="TrackViewState">
                          <target>
                            <castExpression targetType="IStateManager">
                              <fieldReferenceExpression name="view"/>
                            </castExpression>
                          </target>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <fieldReferenceExpression name="view"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- LoadViewState(object) -->
            <memberMethod name="LoadViewState">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="System.Object" name="savedState"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="Pair" name="pair">
                  <init>
                    <castExpression targetType="Pair">
                      <argumentReferenceExpression name="savedState"/>
                    </castExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <argumentReferenceExpression name="savedState"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="LoadViewState">
                      <target>
                        <baseReferenceExpression/>
                      </target>
                      <parameters>
                        <primitiveExpression value="null"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                  <falseStatements>
                    <methodInvokeExpression methodName="LoadViewState">
                      <target>
                        <baseReferenceExpression/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="First">
                          <variableReferenceExpression name="pair"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <propertyReferenceExpression name="Second">
                            <variableReferenceExpression name="pair"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="LoadViewState">
                          <target>
                            <castExpression targetType="IStateManager">
                              <methodInvokeExpression methodName="GetView"/>
                            </castExpression>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Second">
                              <variableReferenceExpression name="pair"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- TrackViewState() -->
            <memberMethod name="TrackViewState">
              <attributes family="true" override="true"/>
              <statements>
                <methodInvokeExpression methodName="TrackViewState">
                  <target>
                    <baseReferenceExpression/>
                  </target>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <fieldReferenceExpression name="view"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="TrackViewState">
                      <target>
                        <castExpression targetType="IStateManager">
                          <fieldReferenceExpression name="view"/>
                        </castExpression>
                      </target>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- SaveViewState() -->
            <memberMethod returnType="System.Object" name="SaveViewState">
              <attributes family="true" override="true"/>
              <statements>
                <variableDeclarationStatement type="Pair" name="pair">
                  <init>
                    <objectCreateExpression type="Pair"/>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="First">
                    <variableReferenceExpression name="pair"/>
                  </propertyReferenceExpression>
                  <methodInvokeExpression methodName="SaveViewState">
                    <target>
                      <baseReferenceExpression/>
                    </target>
                  </methodInvokeExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <fieldReferenceExpression name="view"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="Second">
                        <variableReferenceExpression name="pair"/>
                      </propertyReferenceExpression>
                      <methodInvokeExpression methodName="SaveViewState">
                        <target>
                          <castExpression targetType="IStateManager">
                            <fieldReferenceExpression name="view"/>
                          </castExpression>
                        </target>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <binaryOperatorExpression operator="IdentityEquality">
                        <propertyReferenceExpression name="First">
                          <variableReferenceExpression name="pair"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <propertyReferenceExpression name="Second">
                          <variableReferenceExpression name="pair"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <primitiveExpression value="null"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="pair"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
         <!-- class ControllerDataSourceView -->
        <typeDeclaration name="ControllerDataSourceView">
          <baseTypes>
            <typeReference type="DataSourceView"/>
            <typeReference type="IStateManager"/>
          </baseTypes>
          <members>
            <!--field DefaultViewName -->
            <memberField type="System.String" name="DefaultViewName">
              <attributes static="true" public="true"/>
              <init>
                <primitiveExpression value="DataControllerView"/>
              </init>
            </memberField>
            <!-- property DataController -->
            <memberField type="System.String" name="dataController"/>
            <memberProperty type="System.String" name="DataController">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="dataController"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="dataController"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property DataView -->
            <memberField type="System.String" name="dataView"/>
            <memberProperty type="System.String" name="DataView">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="dataView"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="dataView"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <memberField type="System.Boolean" name="tracking"/>
            <memberField type="ControllerDataSource" name="owner"/>
            <!-- property FilterParameters -->
            <memberField type="ParameterCollection" name="filterParameters"/>
            <memberProperty type="ParameterCollection" name="FilterParameters">
              <attributes public="true" final="true"/>
              <getStatements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <fieldReferenceExpression name="filterParameters"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="filterParameters"/>
                      <objectCreateExpression type="ParameterCollection"/>
                    </assignStatement>
                    <attachEventStatement>
                      <event name="ParametersChanged">
                        <fieldReferenceExpression name="filterParameters"/>
                      </event>
                      <listener>
                        <delegateCreateExpression type="EventHandler" methodName="_filterParametersParametersChanged">
                          <target>
                            <thisReferenceExpression/>
                          </target>
                        </delegateCreateExpression>
                      </listener>
                    </attachEventStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <fieldReferenceExpression name="filterParameters"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- method _filterParametersParametersChanged(object, EventArgs) -->
            <memberMethod name="_filterParametersParametersChanged">
              <attributes private="true" final="true"/>
              <parameters>
                <parameter type="System.Object" name="sender"/>
                <parameter type="EventArgs" name="e"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="OnDataSourceViewChanged">
                  <parameters>
                    <propertyReferenceExpression name="Empty">
                      <typeReferenceExpression type="EventArgs"/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- constructor ControllerDataSourceView(IDataSource, string) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="IDataSource" name="owner"/>
                <parameter type="System.String" name="viewName"/>
              </parameters>
              <baseConstructorArgs>
                <argumentReferenceExpression name="owner"/>
                <argumentReferenceExpression name="viewName"/>
              </baseConstructorArgs>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="owner"/>
                  <castExpression targetType="ControllerDataSource">
                    <argumentReferenceExpression name="owner"/>
                  </castExpression>
                </assignStatement>
              </statements>
            </constructor>
            <!-- property CanRetrieveTotalRowCount -->
            <memberProperty type="System.Boolean" name="CanRetrieveTotalRowCount">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <primitiveExpression value="true"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property CanSort -->
            <memberProperty type="System.Boolean" name="CanSort">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <primitiveExpression value="true"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property CanPage -->
            <memberProperty type="System.Boolean" name="CanPage">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <primitiveExpression value="true"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property CanInsert-->
            <memberProperty type="System.Boolean" name="CanInsert">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <primitiveExpression value="true"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property CanUpdate-->
            <memberProperty type="System.Boolean" name="CanUpdate">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <primitiveExpression value="true"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property CanDelete-->
            <memberProperty type="System.Boolean" name="CanDelete">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <primitiveExpression value="true"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- method ExecuteSelect(DataSourceSelectArguments) -->
            <memberMethod returnType="IEnumerable" name="ExecuteSelect">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="DataSourceSelectArguments" name="arguments"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.Int32" name="pageSize">
                  <init>
                    <propertyReferenceExpression name="MaxValue">
                      <typeReferenceExpression type="Int32"/>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="GreaterThan">
                      <propertyReferenceExpression name="MaximumRows">
                        <argumentReferenceExpression name="arguments"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="pageSize"/>
                      <propertyReferenceExpression name="MaximumRows">
                        <argumentReferenceExpression name="arguments"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="System.Int32" name="pageIndex">
                  <init>
                    <binaryOperatorExpression operator="Divide">
                      <propertyReferenceExpression name="StartRowIndex">
                        <argumentReferenceExpression name="arguments"/>
                      </propertyReferenceExpression>
                      <variableReferenceExpression name="pageSize"/>
                    </binaryOperatorExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="PageRequest" name="request">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <propertyReferenceExpression name="PageRequestParameterName">
                        <fieldReferenceExpression name="owner"/>
                      </propertyReferenceExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.String" name="r">
                      <init>
                        <arrayIndexerExpression>
                          <target>
                            <propertyReferenceExpression name="Params">
                              <propertyReferenceExpression name="Request">
                                <propertyReferenceExpression name="Current">
                                  <typeReferenceExpression type="HttpContext"/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                            </propertyReferenceExpression>
                          </target>
                          <indices>
                            <propertyReferenceExpression name="PageRequestParameterName">
                              <fieldReferenceExpression name="owner"/>
                            </propertyReferenceExpression>
                          </indices>
                        </arrayIndexerExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="IsNotNullOrEmpty">
                          <variableReferenceExpression name="r"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="request"/>
                          <methodInvokeExpression methodName="DeserializeObject">
                            <typeArguments>
                              <typeReference type="PageRequest"/>
                            </typeArguments>
                            <target>
                              <typeReferenceExpression type="JsonConvert"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="r"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                        <assignStatement>
                          <propertyReferenceExpression name="PageIndex">
                            <variableReferenceExpression name="request"/>
                          </propertyReferenceExpression>
                          <variableReferenceExpression name="pageIndex"/>
                        </assignStatement>
                        <assignStatement>
                          <propertyReferenceExpression name="PageSize">
                            <variableReferenceExpression name="request"/>
                          </propertyReferenceExpression>
                          <variableReferenceExpression name="pageSize"/>
                        </assignStatement>
                        <assignStatement>
                          <propertyReferenceExpression name="View">
                            <variableReferenceExpression name="request"/>
                          </propertyReferenceExpression>
                          <propertyReferenceExpression name="DataView">
                            <fieldReferenceExpression name="owner"/>
                          </propertyReferenceExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <variableReferenceExpression name="request"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="request"/>
                      <objectCreateExpression type="PageRequest">
                        <parameters>
                          <variableReferenceExpression name="pageIndex"/>
                          <variableReferenceExpression name="pageSize"/>
                          <propertyReferenceExpression name="SortExpression">
                            <argumentReferenceExpression name="arguments"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="null"/>
                        </parameters>
                      </objectCreateExpression>
                    </assignStatement>
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
                    <variableDeclarationStatement type="System.Collections.Specialized.IOrderedDictionary" name="filterValues">
                      <init>
                        <methodInvokeExpression methodName="GetValues">
                          <target>
                            <propertyReferenceExpression name="FilterParameters"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Current">
                              <typeReferenceExpression type="HttpContext"/>
                            </propertyReferenceExpression>
                            <fieldReferenceExpression name="owner"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <foreachStatement>
                      <variable type="Parameter" name="p" var="false"/>
                      <target>
                        <propertyReferenceExpression name="FilterParameters"/>
                      </target>
                      <statements>
                        <variableDeclarationStatement type="System.Object" name="v">
                          <init>
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="filterValues"/>
                              </target>
                              <indices>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="p"/>
                                </propertyReferenceExpression>
                              </indices>
                            </arrayIndexerExpression>
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
                            <variableDeclarationStatement type="System.String" name="query">
                              <init>
                                <binaryOperatorExpression operator="Add">
                                  <propertyReferenceExpression name="Name">
                                    <variableReferenceExpression name="p"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value=":"/>
                                </binaryOperatorExpression>
                              </init>
                            </variableDeclarationStatement>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="BooleanOr">
                                  <binaryOperatorExpression operator="ValueEquality">
                                    <propertyReferenceExpression name="DbType">
                                      <variableReferenceExpression name="p"/>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="Object">
                                      <typeReferenceExpression type="DbType"/>
                                    </propertyReferenceExpression>
                                  </binaryOperatorExpression>
                                  <binaryOperatorExpression operator="ValueEquality">
                                    <propertyReferenceExpression name="DbType">
                                      <variableReferenceExpression name="p"/>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="String">
                                      <typeReferenceExpression type="DbType"/>
                                    </propertyReferenceExpression>
                                  </binaryOperatorExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <foreachStatement>
                                  <variable type="System.String" name="s"/>
                                  <target>
                                    <methodInvokeExpression methodName="Split">
                                      <target>
                                        <convertExpression to="String">
                                          <variableReferenceExpression name="v"/>
                                        </convertExpression>
                                      </target>
                                      <parameters>
                                        <primitiveExpression value="," convertTo="Char"/>
                                        <primitiveExpression value=";" convertTo="Char"/>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </target>
                                  <statements>
                                    <variableDeclarationStatement type="System.String" name="q">
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
																					<variableReferenceExpression name="q"/>
																				</unaryOperatorExpression>
                                      </condition>
                                      <trueStatements>
                                        <assignStatement>
                                          <variableReferenceExpression name="query"/>
                                          <binaryOperatorExpression operator="Add">
                                            <variableReferenceExpression name="query"/>
                                            <variableReferenceExpression name="q"/>
                                          </binaryOperatorExpression>
                                        </assignStatement>
                                      </trueStatements>
                                    </conditionStatement>
                                  </statements>
                                </foreachStatement>
                              </trueStatements>
                              <falseStatements>
                                <assignStatement>
                                  <variableReferenceExpression name="query"/>
                                  <stringFormatExpression format="{{0}}={{1}}">
                                    <variableReferenceExpression name="query"/>
                                    <variableReferenceExpression name="v"/>
                                  </stringFormatExpression>
                                </assignStatement>
                              </falseStatements>
                            </conditionStatement>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="filter"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="query"/>
                              </parameters>
                            </methodInvokeExpression>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </foreachStatement>
                    <assignStatement>
                      <propertyReferenceExpression name="Filter">
                        <variableReferenceExpression name="request"/>
                      </propertyReferenceExpression>
                      <methodInvokeExpression methodName="ToArray">
                        <target>
                          <variableReferenceExpression name="filter"/>
                        </target>
                      </methodInvokeExpression>
                    </assignStatement>

                  </trueStatements>
                </conditionStatement>
                <assignStatement>
                  <propertyReferenceExpression name="RequiresMetaData">
                    <variableReferenceExpression name="request"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="true"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="RequiresRowCount">
                    <variableReferenceExpression name="request"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="RetrieveTotalRowCount">
                    <variableReferenceExpression name="arguments"/>
                  </propertyReferenceExpression>
                </assignStatement>
                <variableDeclarationStatement type="ViewPage" name="page">
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
                        <fieldReferenceExpression name="dataController"/>
                        <fieldReferenceExpression name="dataView"/>
                        <variableReferenceExpression name="request"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="RetrieveTotalRowCount">
                      <argumentReferenceExpression name="arguments"/>
                    </propertyReferenceExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="TotalRowCount">
                        <argumentReferenceExpression name="arguments"/>
                      </propertyReferenceExpression>
                      <propertyReferenceExpression name="TotalRowCount">
                        <variableReferenceExpression name="page"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <propertyReferenceExpression name="DefaultView">
                    <methodInvokeExpression methodName="ToDataTable">
                      <target>
                        <variableReferenceExpression name="page"/>
                      </target>
                    </methodInvokeExpression>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- ExecuteUpdate(IDictionary, IDictionary, IDictionary)-->
            <memberMethod returnType="System.Int32" name="ExecuteUpdate">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="IDictionary" name="keys"/>
                <parameter type="IDictionary" name="values"/>
                <parameter type="IDictionary" name="oldValues"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="FieldValueDictionary" name="fieldValues">
                  <init>
                    <objectCreateExpression type="FieldValueDictionary"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Assign">
                  <target>
                    <variableReferenceExpression name="fieldValues"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="oldValues"/>
                    <primitiveExpression value="false"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Assign">
                  <target>
                    <variableReferenceExpression name="fieldValues"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="keys"/>
                    <primitiveExpression value="false"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Assign">
                  <target>
                    <variableReferenceExpression name="fieldValues"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="keys"/>
                    <primitiveExpression value="true"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Assign">
                  <target>
                    <variableReferenceExpression name="fieldValues"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="values"/>
                    <primitiveExpression value="true"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="ExecuteAction">
                    <parameters>
                      <primitiveExpression value="Edit"/>
                      <primitiveExpression value="Update"/>
                      <variableReferenceExpression name="fieldValues"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- ExecuteDelete(IDictionary, IDictionary) -->
            <memberMethod returnType="System.Int32" name="ExecuteDelete">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="IDictionary" name="keys"/>
                <parameter type="IDictionary" name="oldValues"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="FieldValueDictionary" name="fieldValues">
                  <init>
                    <objectCreateExpression type="FieldValueDictionary"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Assign">
                  <target>
                    <variableReferenceExpression name="fieldValues"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="keys"/>
                    <primitiveExpression value="false"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Assign">
                  <target>
                    <variableReferenceExpression name="fieldValues"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="keys"/>
                    <primitiveExpression value="true"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Assign">
                  <target>
                    <variableReferenceExpression name="fieldValues"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="oldValues"/>
                    <primitiveExpression value="true"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="ExecuteAction">
                    <parameters>
                      <primitiveExpression value="Select"/>
                      <primitiveExpression value="Delete"/>
                      <variableReferenceExpression name="fieldValues"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- ExecuteInsert(IDictionary) -->
            <memberMethod returnType="System.Int32" name="ExecuteInsert">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="IDictionary" name="values"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="FieldValueDictionary" name="fieldValues">
                  <init>
                    <objectCreateExpression type="FieldValueDictionary"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Assign">
                  <target>
                    <variableReferenceExpression name="fieldValues"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="values"/>
                    <primitiveExpression value="true"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="ExecuteAction">
                    <parameters>
                      <primitiveExpression value="New"/>
                      <primitiveExpression value="Insert"/>
                      <variableReferenceExpression name="fieldValues"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method ExecuteAction(string, string, FieldValues) -->
            <memberMethod returnType="System.Int32" name="ExecuteAction">
              <attributes family="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="lastCommandName"/>
                <parameter type="System.String" name="commandName"/>
                <parameter type="FieldValueDictionary" name="fieldValues"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="ActionArgs" name="args">
                  <init>
                    <objectCreateExpression type="ActionArgs"/>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Controller">
                    <variableReferenceExpression name="args"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="DataController"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="View">
                    <variableReferenceExpression name="args"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="DataView"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="LastCommandName">
                    <variableReferenceExpression name="args"/>
                  </propertyReferenceExpression>
                  <argumentReferenceExpression name="lastCommandName"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="CommandName">
                    <variableReferenceExpression name="args"/>
                  </propertyReferenceExpression>
                  <argumentReferenceExpression name="commandName"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Values">
                    <variableReferenceExpression name="args"/>
                  </propertyReferenceExpression>
                  <methodInvokeExpression methodName="ToArray">
                    <target>
                      <propertyReferenceExpression name="Values">
                        <argumentReferenceExpression name="fieldValues"/>
                      </propertyReferenceExpression>
                    </target>
                  </methodInvokeExpression>
                </assignStatement>
                <variableDeclarationStatement type="ActionResult" name="result">
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
                        <propertyReferenceExpression name="DataController"/>
                        <propertyReferenceExpression name="DataView"/>
                        <variableReferenceExpression name="args"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="RaiseExceptionIfErrors">
                  <target>
                    <variableReferenceExpression name="result"/>
                  </target>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <propertyReferenceExpression name="RowsAffected">
                    <variableReferenceExpression name="result"/>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method LoadViewState(object) -->
            <memberMethod name="LoadViewState">
              <attributes family="true"/>
              <parameters>
                <parameter type="System.Object" name="savedState"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <argumentReferenceExpression name="savedState"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="Pair" name="pair">
                      <init>
                        <castExpression targetType="Pair">
                          <argumentReferenceExpression name="savedState"/>
                        </castExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <propertyReferenceExpression name="Second">
                            <variableReferenceExpression name="pair"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="LoadViewState">
                          <target>
                            <castExpression targetType="IStateManager">
                              <propertyReferenceExpression name="FilterParameters"/>
                            </castExpression>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Second">
                              <variableReferenceExpression name="pair"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method SaveViewState() -->
            <memberMethod returnType="System.Object" name="SaveViewState">
              <attributes family="true"/>
              <statements>
                <variableDeclarationStatement type="Pair" name="pair">
                  <init>
                    <objectCreateExpression type="Pair"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <fieldReferenceExpression name="filterParameters"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="Second">
                        <variableReferenceExpression name="pair"/>
                      </propertyReferenceExpression>
                      <methodInvokeExpression methodName="SaveViewState">
                        <target>
                          <castExpression targetType="IStateManager">
                            <fieldReferenceExpression name="filterParameters"/>
                          </castExpression>
                        </target>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <binaryOperatorExpression operator="IdentityEquality">
                        <propertyReferenceExpression name="First">
                          <variableReferenceExpression name="pair"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <propertyReferenceExpression name="Second">
                          <variableReferenceExpression name="pair"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <primitiveExpression value="null"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="pair"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method TrackViewState() -->
            <memberMethod name="TrackViewState">
              <attributes family="true"/>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="tracking"/>
                  <primitiveExpression value="true"/>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <fieldReferenceExpression name="filterParameters"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="TrackViewState">
                      <target>
                        <castExpression targetType="IStateManager">
                          <fieldReferenceExpression name="filterParameters"/>
                        </castExpression>
                      </target>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- property IStateManager.IsTrackingViewState-->
            <memberProperty type="System.Boolean" name="IsTrackingViewState" privateImplementationType="IStateManager">
              <attributes/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="tracking"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- method IStateManager.LoadViewState(object) -->
            <memberMethod name="LoadViewState" privateImplementationType="IStateManager">
              <attributes/>
              <parameters>
                <parameter type="System.Object" name="state"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="LoadViewState">
                  <parameters>
                    <argumentReferenceExpression name="state"/>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- method IStateManager.SaveViewState() -->
            <memberMethod returnType="System.Object" name="SaveViewState" privateImplementationType="IStateManager">
              <attributes/>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SaveViewState"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method IStateManager.TrackViewState() -->
            <memberMethod name="TrackViewState" privateImplementationType="IStateManager">
              <attributes/>
              <statements>
                <methodInvokeExpression methodName="TrackViewState"/>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
