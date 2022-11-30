<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="IsClassLibrary" select="'false'"/>
  <xsl:param name="IsPremium"/>

  <xsl:template match="/">
    <compileUnit namespace="{a:project/a:namespace}.Web">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Data"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Configuration"/>
        <namespaceImport name="System.Text"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Security"/>
        <namespaceImport name="System.Web.UI"/>
        <namespaceImport name="System.Web.UI.HtmlControls"/>
        <namespaceImport name="System.Web.UI.WebControls"/>
        <namespaceImport name="System.Web.UI.WebControls.WebParts"/>
        <namespaceImport name="{a:project/a:namespace}.Data"/>
        <!--<namespaceImport name="AjaxControlToolkit"/>-->
      </imports>
      <types>
        <!-- enum DataViewSelectionMode -->
        <typeDeclaration name="DataViewSelectionMode" isEnum="true">
          <members>
            <memberField name="Single">
              <attributes public="true"/>
            </memberField>
            <memberField name="Multiple">
              <attributes public="true"/>
            </memberField>
          </members>
        </typeDeclaration>
        <!-- enum ActionButtonLocation -->
        <typeDeclaration name="ActionButtonLocation" isEnum="true">
          <members>
            <memberField name="Auto">
              <attributes public="true"/>
            </memberField>
            <memberField name="None">
              <attributes public="true"/>
            </memberField>
            <memberField name="Top">
              <attributes public="true"/>
            </memberField>
            <memberField name="Bottom">
              <attributes public="true"/>
            </memberField>
            <memberField name="TopAndBottom">
              <attributes public="true"/>
            </memberField>
          </members>
        </typeDeclaration>
        <!-- enum PagerLocation -->
        <typeDeclaration name="PagerLocation" isEnum="true">
          <members>
            <memberField name="None">
              <attributes public="true"/>
            </memberField>
            <memberField name="Top">
              <attributes public="true"/>
            </memberField>
            <memberField name="Bottom">
              <attributes public="true"/>
            </memberField>
            <memberField name="TopAndBottom">
              <attributes public="true"/>
            </memberField>
          </members>
        </typeDeclaration>
        <!-- enum AutoHideMode -->
        <typeDeclaration name="AutoHideMode" isEnum="true">
          <members>
            <memberField name="Nothing">
              <attributes public="true"/>
            </memberField>
            <memberField name="Self">
              <attributes public="true"/>
            </memberField>
            <memberField name="Container">
              <attributes public="true"/>
            </memberField>
          </members>
        </typeDeclaration>
        <!-- class FieldFilter -->
        <typeDeclaration name="FieldFilter">
          <members>
            <!-- property FieldName -->
            <memberField type="System.String" name="fieldName"/>
            <memberProperty type="System.String" name="FieldName">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="fieldName"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="fieldName"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
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
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="operation"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Value -->
            <memberField type="System.Object" name="value"/>
            <memberProperty type="System.Object" name="Value">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="value"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <binaryOperatorExpression operator="BooleanAnd">
                        <binaryOperatorExpression operator="BooleanAnd">
                          <binaryOperatorExpression operator="IdentityInequality">
                            <propertySetValueReferenceExpression/>
                            <primitiveExpression value="null"/>
                          </binaryOperatorExpression>
                          <binaryOperatorExpression operator="IsTypeOf">
                            <variableReferenceExpression name="value"/>
                            <typeReferenceExpression type="String"/>
                          </binaryOperatorExpression>
                        </binaryOperatorExpression>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Operation"/>
                          <propertyReferenceExpression name="Like">
                            <typeReferenceExpression type="RowFilterOperation"/>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                      <unaryOperatorExpression operator="Not">
                        <methodInvokeExpression methodName="Contains">
                          <target>
                            <castExpression targetType="System.String">
                              <propertySetValueReferenceExpression/>
                            </castExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="%"/>
                          </parameters>
                        </methodInvokeExpression>
                      </unaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="value"/>
                      <methodInvokeExpression methodName="Format">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="%{{0}}%"/>
                          <propertySetValueReferenceExpression/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="value"/>
                      <propertySetValueReferenceExpression/>
                    </assignStatement>
                  </falseStatements>
                </conditionStatement>
              </setStatements>
            </memberProperty>
            <!-- constructor() -->
            <constructor>
              <attributes public="true"/>
            </constructor>
            <!-- constructor(string, RowFilterOperation) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
                <parameter type="RowFilterOperation" name="operation"/>
              </parameters>
              <chainedConstructorArgs>
                <argumentReferenceExpression name="fieldName"/>
                <argumentReferenceExpression name="operation"/>
                <primitiveExpression value="null"/>
              </chainedConstructorArgs>
            </constructor>
            <!-- constructor(string, RowFilterOperation, object) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
                <parameter type="RowFilterOperation" name="operation"/>
                <parameter type="System.Object" name="value"/>
              </parameters>
              <statements>
                <assignStatement>
                  <propertyReferenceExpression name="FieldName">
                    <thisReferenceExpression/>
                  </propertyReferenceExpression>
                  <argumentReferenceExpression name="fieldName"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Operation">
                    <thisReferenceExpression/>
                  </propertyReferenceExpression>
                  <argumentReferenceExpression name="operation"/>
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
        <!-- class DataViewExtender -->
        <typeDeclaration name="DataViewExtender" isPartial="true">
          <baseTypes>
            <typeReference type="DataViewExtenderBase"/>
          </baseTypes>
        </typeDeclaration>
        <!-- class DataViewExtender -->
        <typeDeclaration name="DataViewExtenderBase" >
          <customAttributes>
            <customAttribute name="TargetControlType">
              <arguments>
                <typeofExpression type="Panel"/>
              </arguments>
            </customAttribute>
            <customAttribute name="TargetControlType">
              <arguments>
                <typeofExpression type="HtmlContainerControl"/>
              </arguments>
            </customAttribute>
            <!--<xsl:if test="$IsClassLibrary='true'">
							<customAttribute name="ClientCssResource">
								<arguments>
									<primitiveExpression value="{a:project/a:namespace}.Theme.Aquarium.css"/>
								</arguments>
							</customAttribute>
						</xsl:if>-->
          </customAttributes>
          <baseTypes>
            <typeReference type="AquariumExtenderBase"/>
          </baseTypes>
          <members>
            <!-- property AutoHide -->
            <memberField type="AutoHideMode" name="autoHide"/>
            <memberProperty type="AutoHideMode" name="AutoHide">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="Specifies user interface element that will be hidden if data view can be automatically hidden."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <propertyReferenceExpression name="Nothing">
                      <typeReferenceExpression type="AutoHideMode"/>
                    </propertyReferenceExpression>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="autoHide"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="autoHide"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Controller -->
            <memberField type="System.String" name="controller"/>
            <memberProperty type="System.String" name="Controller">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The name of the data controller. Controllers are stored in the &quot;~/Controllers&quot; folder of your project. Do not include the file extension."/>
                  </arguments>
                </customAttribute>
              </customAttributes>
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
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The name of the startup view in the data controller. The first view is displayed if the property is left blank."/>
                  </arguments>
                </customAttribute>
              </customAttributes>
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
            <!-- property PageSize -->
            <memberField type="System.Int32" name="pageSize"/>
            <memberProperty type="System.Int32" name="PageSize">
              <attributes final="true" public="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The number of rows displayed by grid views of the data controller."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="10"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="pageSize"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="pageSize"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property ShowActionBar -->
            <memberProperty type="System.Boolean" name="ShowActionBar">
              <attributes final="true" public="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="Specifies if the action bar is displayed above the views of the data controller."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="true"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
            </memberProperty>
            <!-- property ShowActionButtons -->
            <memberProperty type="ActionButtonLocation" name="ShowActionButtons">
              <attributes final="true" public="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="Specifies if the action buttons are displayed in the form views of the data controller."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <propertyReferenceExpression name="TopAndBottom">
                      <typeReferenceExpression type="ActionButtonLocation"/>
                    </propertyReferenceExpression>
                  </arguments>
                </customAttribute>
              </customAttributes>
            </memberProperty>
            <xsl:if test="$IsPremium='true'">
              <!-- property ShowSearchBar -->
              <memberField type="System.Boolean" name="showSearchBar"/>
              <memberProperty type="System.Boolean" name="ShowSearchBar">
                <attributes final="true" public="true"/>
                <customAttributes>
                  <customAttribute name="System.ComponentModel.Description">
                    <arguments>
                      <primitiveExpression value="Specifies if the search bar is enabled in the views of the data controller."/>
                    </arguments>
                  </customAttribute>
                  <customAttribute name="System.ComponentModel.DefaultValue">
                    <arguments>
                      <primitiveExpression value="true"/>
                    </arguments>
                  </customAttribute>
                </customAttributes>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="showSearchBar"/>
                  </methodReturnStatement>
                </getStatements>
                <setStatements>
                  <assignStatement>
                    <fieldReferenceExpression name="showSearchBar"/>
                    <propertySetValueReferenceExpression/>
                  </assignStatement>
                </setStatements>
              </memberProperty>
              <memberField type="System.Boolean" name="showModalForms"/>
              <memberProperty type="System.Boolean" name="ShowModalForms">
                <attributes final="true" public="true"/>
                <customAttributes>
                  <customAttribute name="System.ComponentModel.Description">
                    <arguments>
                      <primitiveExpression value="Specifies that form views are displayed as modal popups. The default form rendering mode is in-place."/>
                    </arguments>
                  </customAttribute>
                  <customAttribute name="System.ComponentModel.DefaultValue">
                    <arguments>
                      <primitiveExpression value="true"/>
                    </arguments>
                  </customAttribute>
                </customAttributes>
                <getStatements>
                  <methodReturnStatement>
                    <fieldReferenceExpression name="showModalForms"/>
                  </methodReturnStatement>
                </getStatements>
                <setStatements>
                  <assignStatement>
                    <fieldReferenceExpression name="showModalForms"/>
                    <propertySetValueReferenceExpression/>
                  </assignStatement>
                </setStatements>
              </memberProperty>
            </xsl:if>
            <!-- property FilterSource -->
            <memberField type="System.String" name="filterSource"/>
            <memberProperty type="System.String" name="FilterSource">
              <attributes final="true" public="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="Defines the external source of filtering values. This may be the name of URL parameter or DHTML element in the page. Data view extender will automatically recognize if the DHTML element is also extended and will interface with the client-side extender object."/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="filterSource"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="filterSource"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property FilterFields -->
            <memberField type="System.String" name="filterFields"/>
            <memberProperty type="System.String" name="FilterFields">
              <attributes final="true" public="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="Specify the field(s) of the data controller that shall be filtered with the values from the source defined by the FilterSource property."/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="filterFields"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="filterFields"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property VisibleWhen -->
            <memberProperty type="System.String" name="VisibleWhen">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The JavaScript expression that must evaluate as true if the data view is visible."/>
                  </arguments>
                </customAttribute>
              </customAttributes>
            </memberProperty>
            <!-- property Roles -->
            <memberProperty type="System.String" name="Roles">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The comma-separated list of roles allowed to see the data view on the page."/>
                  </arguments>
                </customAttribute>
              </customAttributes>
            </memberProperty>
            <!-- property StartCommandName -->
            <memberField type="System.String" name="startCommandName"/>
            <memberProperty type="System.String" name="StartCommandName">
              <attributes final="true" public="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="Specify a command that must be executed when the data view is instantiated."/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="startCommandName"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="startCommandName"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property StartCommandArgument -->
            <memberField type="System.String" name="startCommandArgument"/>
            <memberProperty type="System.String" name="StartCommandArgument">
              <attributes final="true" public="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="Specify an argument of a command that must be executed when the data view is instantiated."/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="startCommandArgument"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="startCommandArgument"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property SelectedValue -->
            <memberField type="System.String" name="selectedValue"/>
            <memberProperty type="System.String" name="SelectedValue">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Browsable">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <fieldReferenceExpression name="selectedValue"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="selectedValue"/>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Params">
                            <propertyReferenceExpression name="Request">
                              <propertyReferenceExpression name="Page"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                        </target>
                        <indices>
                          <methodInvokeExpression methodName="Format">
                            <target>
                              <typeReferenceExpression type="String"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="{{0}}_{{1}}_SelectedValue"/>
                              <propertyReferenceExpression name="ClientID"/>
                              <propertyReferenceExpression name="Controller"/>
                            </parameters>
                          </methodInvokeExpression>
                        </indices>
                      </arrayIndexerExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <fieldReferenceExpression name="selectedValue"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="selectedValue"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property SelectionMode -->
            <memberField type="DataViewSelectionMode" name="selectionMode"/>
            <memberProperty type="DataViewSelectionMode" name="SelectionMode">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The selection mode for the data view."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <propertyReferenceExpression name="Single">
                      <typeReferenceExpression type="DataViewSelectionMode"/>
                    </propertyReferenceExpression>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="selectionMode"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="selectionMode"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property ShowInSummary -->
            <memberField type="System.Boolean" name="showInSummary"/>
            <memberProperty type="System.Boolean" name="ShowInSummary">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The data view is presented in the page summary."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="showInSummary"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="showInSummary"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property ShowDescription -->
            <memberField type="System.Boolean" name="showDescription"/>
            <memberProperty type="System.Boolean" name="ShowDescription">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The view descripition is displayed at the top the data extender target."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="true"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="showDescription"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="showDescription"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property ShowViewSelector -->
            <memberField type="System.Boolean" name="showViewSelector"/>
            <memberProperty type="System.Boolean" name="ShowViewSelector">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The view selector is displayed in the action bar."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="true"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="showViewSelector"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="showViewSelector"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property SearchOnStart -->
            <memberField type="System.Boolean" name="searchOnStart"/>
            <memberProperty type="System.Boolean" name="SearchOnStart">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="Display grid view in search mode and do not retreive the data when view is displayed for the first time."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="searchOnStart"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="searchOnStart"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property SummaryFieldCount -->
            <memberField type="System.Int32" name="summaryFieldCount"/>
            <memberProperty type="System.Int32" name="SummaryFieldCount">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The maximum number of fields that can be contributed to the summary."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="5"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="summaryFieldCount"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="summaryFieldCount"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Tag -->
            <memberField type="System.String" name="tag"/>
            <memberProperty type="System.String" name="Tag">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The identifying string passed from the client to server. Use it to filter actions and to program business rules."/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="tag"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="tag"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Tags -->
            <memberProperty type="System.String" name="Tags">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The identifying string passed from the client to server. Use it to filter actions and to program business rules. Separate multiple tags with comma or space."/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="tag"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="tag"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property ShowDetailsInListMode -->
            <memberField type="System.Boolean" name="showDetailsInListMode"/>
            <memberProperty type="System.Boolean" name="ShowDetailsInListMode">
              <attributes final="true" public="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The child data views are hidden if the active view is displaying a list of records."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="true"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="showDetailsInListMode"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="showDetailsInListMode"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property ShowPager -->
            <memberField type="PagerLocation" name="showPager"/>
            <memberProperty type="PagerLocation" name="ShowPager">
              <attributes final="true" public="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="Specifies if the pager is displayed at the top or/and bottom of the views."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="true"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="showPager"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="showPager"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property ShowPager -->
            <memberProperty type="System.Boolean" name="ShowPageSize">
              <attributes final="true" public="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Description">
                  <arguments>
                    <primitiveExpression value="The page size information is displayed in the pager area of data views."/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="true"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
            </memberProperty>
            <!-- contructor DataViewExtender() -->
            <constructor>
              <attributes public="true"/>
              <baseConstructorArgs>
                <primitiveExpression value="Web.DataView"/>
              </baseConstructorArgs>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="pageSize">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <primitiveExpression value="10"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="showActionBar">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <primitiveExpression value="true"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="showActionButtons">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <propertyReferenceExpression name="TopAndBottom">
                    <typeReferenceExpression type="ActionButtonLocation"/>
                  </propertyReferenceExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="showDetailsInListMode">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <primitiveExpression value="true"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="showPager">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <propertyReferenceExpression name="Bottom">
                    <typeReferenceExpression type="PagerLocation"/>
                  </propertyReferenceExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="showPageSize">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <primitiveExpression value="true"/>
                </assignStatement>
                <xsl:if test="$IsPremium='true'">
                  <assignStatement>
                    <fieldReferenceExpression name="showSearchBar">
                      <thisReferenceExpression/>
                    </fieldReferenceExpression>
                    <primitiveExpression value="true"/>
                  </assignStatement>
                </xsl:if>
                <assignStatement>
                  <fieldReferenceExpression name="showDescription"/>
                  <primitiveExpression value="true"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="showViewSelector"/>
                  <primitiveExpression value="true"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="summaryFieldCount"/>
                  <primitiveExpression value="5"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="showQuickFind"/>
                  <primitiveExpression value="true"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- property Enabled -->
            <memberField type="System.Boolean" name="enabled">
              <init>
                <primitiveExpression value="true"/>
              </init>
            </memberField>
            <memberProperty type="System.Boolean" name="Enabled">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Browsable">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="enabled"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="enabled"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- propertiy TabIndex -->
            <memberField type="System.Int32" name="tabIndex"/>
            <memberProperty type="System.Int32" name="TabIndex">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Browsable">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="tabIndex"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="tabIndex"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property LookupValue -->
            <memberField type="System.Boolean" name="lookupMode"/>
            <memberField type="System.String" name="lookupValue"/>
            <memberProperty type="System.String" name="LookupValue">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Browsable">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="lookupValue"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="lookupValue"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="lookupMode"/>
                  <primitiveExpression value="true"/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property LookupText -->
            <memberField type="System.String" name="lookupText"/>
            <memberProperty type="System.String" name="LookupText">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Browsable">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="lookupText"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="lookupText"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property LookupPostBackExpression -->
            <memberField type="System.String" name="lookupPostBackExpression"/>
            <memberProperty type="System.String" name="LookupPostBackExpression">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.Browsable">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="lookupPostBackExpression"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="lookupPostBackExpression"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property AllowCreateLookupItems -->
            <memberField type="System.Boolean" name="allowCreateLookupItems"/>
            <memberProperty type="System.Boolean" name="AllowCreateLookupItems">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="true"/>
                  </arguments>
                </customAttribute>
                <customAttribute name="System.ComponentModel.Browsable">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="allowCreateLookupItems"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="allowCreateLookupItems"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property ShowRowNumber -->
            <memberProperty type="System.Boolean" name="ShowRowNumber">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
            </memberProperty>
            <!-- property ShowQuickFind -->
            <memberField type="System.Boolean" name="showQuickFind"/>
            <memberProperty type="System.Boolean" name="ShowQuickFind">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="true"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="showQuickFind"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="showQuickFind"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property SearchByFirstLetter -->
            <memberProperty type="System.Boolean" name="SearchByFirstLetter">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
            </memberProperty>
            <!-- property AutoSelectFirstRow -->
            <memberProperty type="System.Boolean" name="AutoSelectFirstRow">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
            </memberProperty>
            <!-- property AutoHighlightFirstRow -->
            <memberProperty type="System.Boolean" name="AutoHighlightFirstRow">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="false"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
            </memberProperty>
            <!-- property RefreshInterval -->
            <memberProperty type="System.Int32" name="RefreshInterval">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="System.ComponentModel.DefaultValue">
                  <arguments>
                    <primitiveExpression value="0"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
            </memberProperty>
            <!-- method ConfigureDescriptor(Control) -->
            <memberMethod name="ConfigureDescriptor">
              <typeArguments>
                <typeReference type="ScriptDescriptor"/>
              </typeArguments>
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="ScriptBehaviorDescriptor" name="descriptor"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="RegisterHiddenField">
                  <target>
                    <propertyReferenceExpression name="ClientScript">
                      <propertyReferenceExpression name="Page"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <typeReferenceExpression type="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="{{0}}_{{1}}_SelectedValue"/>
                        <propertyReferenceExpression name="ClientID"/>
                        <propertyReferenceExpression name="Controller"/>
                      </parameters>
                    </methodInvokeExpression>
                    <propertyReferenceExpression name="SelectedValue"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="appId"/>
                    <propertyReferenceExpression name="TargetControlID">
                      <thisReferenceExpression/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="controller"/>
                    <propertyReferenceExpression name="Controller">
                      <thisReferenceExpression/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="viewId"/>
                    <propertyReferenceExpression name="View">
                      <thisReferenceExpression/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="pageSize"/>
                    <propertyReferenceExpression name="PageSize">
                      <thisReferenceExpression/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="ShowActionBar"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <variableReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="showActionBar"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueInequality">
                      <propertyReferenceExpression name="ShowActionButtons"/>
                      <propertyReferenceExpression name="TopAndBottom">
                        <typeReferenceExpression type="ActionButtonLocation"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <variableReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="showActionButtons"/>
                        <methodInvokeExpression methodName="ToString">
                          <target>
                            <propertyReferenceExpression name="ShowActionButtons"/>
                          </target>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueInequality">
                      <propertyReferenceExpression name="ShowPager"/>
                      <propertyReferenceExpression name="Bottom">
                        <typeReferenceExpression type="PagerLocation"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <variableReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="showPager"/>
                        <methodInvokeExpression methodName="ToString">
                          <target>
                            <propertyReferenceExpression name="ShowPager"/>
                          </target>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="ShowPageSize"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <variableReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="showPageSize"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="ShowDetailsInListMode"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <variableReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="showDetailsInListMode"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <xsl:if test="$IsPremium='true'">
                  <conditionStatement>
                    <condition>
                      <propertyReferenceExpression name="ShowSearchBar"/>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="AddProperty">
                        <target>
                          <variableReferenceExpression name="descriptor"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="showSearchBar"/>
                          <primitiveExpression value="true"/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <propertyReferenceExpression name="ShowModalForms"/>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="AddProperty">
                        <target>
                          <variableReferenceExpression name="descriptor"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="showModalForms"/>
                          <primitiveExpression value="true"/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                </xsl:if>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="SearchOnStart"/>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <variableReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="searchOnStart"/>
                        <primitiveExpression value="true"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <fieldReferenceExpression name="lookupMode"/>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <variableReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="mode"/>
                        <primitiveExpression value="Lookup"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <variableReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="lookupValue"/>
                        <propertyReferenceExpression name="LookupValue"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <variableReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="lookupText"/>
                        <propertyReferenceExpression name="LookupText"/>
                      </parameters>
                    </methodInvokeExpression>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="IsNullOrEmpty">
                            <target>
                              <typeReferenceExpression type="String"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="LookupPostBackExpression"/>
                            </parameters>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AddProperty">
                          <target>
                            <variableReferenceExpression name="descriptor"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="lookupPostBackExpression"/>
                            <propertyReferenceExpression name="LookupPostBackExpression"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <propertyReferenceExpression name="AllowCreateLookupItems"/>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AddProperty">
                          <target>
                            <variableReferenceExpression name="descriptor"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="newViewId"/>
                            <methodInvokeExpression methodName="LookupActionArgument">
                              <target>
                                <typeReferenceExpression type="{a:project/a:namespace}.Data.Controller"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="Controller"/>
                                <primitiveExpression value="New"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsNullOrEmpty">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="FilterSource"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="Control" name="source">
                      <init>
                        <methodInvokeExpression methodName="FindControl">
                          <target>
                            <propertyReferenceExpression name="NamingContainer"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="FilterSource"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="source"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AddProperty">
                          <target>
                            <variableReferenceExpression name="descriptor"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="filterSource"/>
                            <propertyReferenceExpression name="ClientID">
                              <variableReferenceExpression name="source"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="IsTypeOf">
                              <variableReferenceExpression name="source"/>
                              <typeReferenceExpression type="DataViewExtender"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodInvokeExpression methodName="AddProperty">
                              <target>
                                <variableReferenceExpression name="descriptor"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="appFilterSource"/>
                                <propertyReferenceExpression name="TargetControlID">
                                  <castExpression targetType="DataViewExtender">
                                    <variableReferenceExpression name="source"/>
                                  </castExpression>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                      <falseStatements>
                        <methodInvokeExpression methodName="AddProperty">
                          <target>
                            <variableReferenceExpression name="descriptor"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="filterSource"/>
                            <propertyReferenceExpression name="FilterSource">
                              <thisReferenceExpression/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </falseStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsNullOrEmpty">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="FilterFields"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <variableReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="filterFields"/>
                        <propertyReferenceExpression name="FilterFields">
                          <thisReferenceExpression/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="cookie"/>
                    <methodInvokeExpression methodName="ToString">
                      <target>
                        <methodInvokeExpression methodName="NewGuid">
                          <target>
                            <typeReferenceExpression type="Guid"/>
                          </target>
                        </methodInvokeExpression>
                      </target>
                    </methodInvokeExpression>
                  </parameters>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsNullOrEmpty">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="StartCommandName"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="startCommandName"/>
                        <propertyReferenceExpression name="StartCommandName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsNullOrEmpty">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="StartCommandArgument"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="startCommandArgument"/>
                        <propertyReferenceExpression name="StartCommandArgument"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="SelectionMode"/>
                      <propertyReferenceExpression name="Multiple">
                        <typeReferenceExpression type="DataViewSelectionMode"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="selectionMode"/>
                        <primitiveExpression value="Multiple"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="Enabled"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="enabled"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="GreaterThan">
                      <propertyReferenceExpression name="TabIndex"/>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="tabIndex"/>
                        <propertyReferenceExpression name="TabIndex"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="ShowInSummary"/>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="showInSummary"/>
                        <primitiveExpression value="true" convertTo="String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="ShowDescription"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="showDescription"/>
                        <primitiveExpression value="false" />
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="ShowViewSelector"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="showViewSelector"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsNullOrEmpty">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="Tag"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="tag"/>
                        <propertyReferenceExpression name="Tag"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueInequality">
                      <propertyReferenceExpression name="SummaryFieldCount"/>
                      <primitiveExpression value="5"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="summaryFieldCount"/>
                        <propertyReferenceExpression name="SummaryFieldCount"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="SearchByFirstLetter"/>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="showFirstLetters"/>
                        <primitiveExpression value="true"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <xsl:if test="$IsPremium='true'">
                  <conditionStatement>
                    <condition>
                      <propertyReferenceExpression name="AutoSelectFirstRow"/>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="AddProperty">
                        <target>
                          <argumentReferenceExpression name="descriptor"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="autoSelectFirstRow"/>
                          <primitiveExpression value="true"/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <propertyReferenceExpression name="AutoHighlightFirstRow"/>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="AddProperty">
                        <target>
                          <argumentReferenceExpression name="descriptor"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="autoHighlightFirstRow"/>
                          <primitiveExpression value="true"/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="GreaterThan">
                        <propertyReferenceExpression name="RefreshInterval"/>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="AddProperty">
                        <target>
                          <argumentReferenceExpression name="descriptor"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="refreshInterval"/>
                          <propertyReferenceExpression name="RefreshInterval"/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                </xsl:if>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="ShowQuickFind"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="showQuickFind"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="ShowRowNumber"/>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="showRowNumber"/>
                        <primitiveExpression value="true"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueInequality">
                      <propertyReferenceExpression name="AutoHide"/>
                      <propertyReferenceExpression name="Nothing">
                        <typeReferenceExpression type="AutoHideMode"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="autoHide"/>
                        <methodInvokeExpression methodName="ToInt16">
                          <target>
                            <typeReferenceExpression type="Convert"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="AutoHide"/>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="ContainsKey">
                      <target>
                        <propertyReferenceExpression name="Properties"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="StartupFilter"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <variableReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="startupFilter"/>
                        <arrayIndexerExpression>
                          <target>
                            <propertyReferenceExpression name="Properties"/>
                          </target>
                          <indices>
                            <primitiveExpression value="StartupFilter"/>
                          </indices>
                        </arrayIndexerExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <!--<conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueInequality">
                      <propertyReferenceExpression name="Transaction"/>
                      <propertyReferenceExpression name="NotSupported">
                        <typeReferenceExpression type="DataTransactionMode"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.String" name="t">
                      <init>
                        <methodInvokeExpression methodName="ToString">
                          <target>
                            <propertyReferenceExpression name="Transaction"/>
                          </target>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanOr">
                          <binaryOperatorExpression operator="ValueInequality">
                            <propertyReferenceExpression name="Transaction"/>
                            <propertyReferenceExpression name="Supported">
                              <typeReferenceExpression type="DataTransactionMode"/>
                            </propertyReferenceExpression>
                          </binaryOperatorExpression>
                          <binaryOperatorExpression operator="BooleanAnd">
                            <binaryOperatorExpression operator="ValueEquality">
                              <arrayIndexerExpression>
                                <target>
                                  <propertyReferenceExpression name="Params">
                                    <propertyReferenceExpression name="Request">
                                      <propertyReferenceExpression name="Page"/>
                                    </propertyReferenceExpression>
                                  </propertyReferenceExpression>
                                </target>
                                <indices>
                                  <primitiveExpression value="_transaction"/>
                                </indices>
                              </arrayIndexerExpression>
                              <primitiveExpression value="true" convertTo="String"/>
                            </binaryOperatorExpression>
                            <binaryOperatorExpression operator="BooleanAnd">
                              <binaryOperatorExpression operator="ValueEquality">
                                <arrayIndexerExpression>
                                  <target>
                                    <propertyReferenceExpression name="Params">
                                      <propertyReferenceExpression name="Request">
                                        <propertyReferenceExpression name="Page"/>
                                      </propertyReferenceExpression>
                                    </propertyReferenceExpression>
                                  </target>
                                  <indices>
                                    <primitiveExpression value="_controller"/>
                                  </indices>
                                </arrayIndexerExpression>
                                <propertyReferenceExpression name="Controller">
                                  <thisReferenceExpression/>
                                </propertyReferenceExpression>
                              </binaryOperatorExpression>
                              <methodInvokeExpression methodName="IsNullOrEmpty">
                                <target>
                                  <typeReferenceExpression type="String"/>
                                </target>
                                <parameters>
                                  <propertyReferenceExpression name="FilterSource">
                                    <thisReferenceExpression/>
                                  </propertyReferenceExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </binaryOperatorExpression>
                          </binaryOperatorExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="t"/>
                          <methodInvokeExpression methodName="ToString">
                            <target>
                              <methodInvokeExpression methodName="NewGuid">
                                <target>
                                  <typeReferenceExpression type="Guid"/>
                                </target>
                              </methodInvokeExpression>
                            </target>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="transaction"/>
                        <variableReferenceExpression name="t"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>-->
                <!-- 
  if (!String.IsNullOrEmpty(Roles) && !DataControllerBase.UserIsInRole(Roles))
            {
                if (String.IsNullOrEmpty(VisibleWhen))
                    VisibleWhen = "false";
                else
                    VisibleWhen = String.Format("({0}) && false", VisibleWhen);
            }                -->
                <variableDeclarationStatement type="System.String" name="visibleWhenExpression">
                  <init>
                    <propertyReferenceExpression name="VisibleWhen"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <unaryOperatorExpression operator="IsNotNullOrEmpty">
                        <propertyReferenceExpression name="Roles"/>
                      </unaryOperatorExpression>
                      <unaryOperatorExpression operator="Not">
                        <methodInvokeExpression methodName="UserIsInRole">
                          <target>
                            <typeReferenceExpression type="DataControllerBase"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Roles"/>
                          </parameters>
                        </methodInvokeExpression>
                      </unaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="IsNullOrEmpty">
                          <propertyReferenceExpression name="visibleWhenExpression"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="visibleWhenExpression"/>
                          <primitiveExpression value="false" convertTo="String"/>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <assignStatement>
                          <variableReferenceExpression name="visibleWhenExpression"/>
                          <stringFormatExpression format="({{0}}) &amp;&amp; false">
                            <variableReferenceExpression name="visibleWhenExpression"/>
                          </stringFormatExpression>
                        </assignStatement>
                      </falseStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <propertyReferenceExpression name="visibleWhenExpression"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="visibleWhen"/>
                        <propertyReferenceExpression name="visibleWhenExpression"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method ConfigureScripts -->
            <memberMethod name="ConfigureScripts">
              <attributes override="true" family="true"/>
              <parameters>
                <parameter type="List" name="scripts">
                  <typeArguments>
                    <typeReference type="ScriptReference"/>
                  </typeArguments>
                </parameter>
              </parameters>
            </memberMethod>
            <!-- method AssignFilter(List<FieldFilter>) -->
            <memberMethod name="AssignFilter">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="List" name="filter">
                  <typeArguments>
                    <typeReference type="FieldFilter"/>
                  </typeArguments>
                </parameter>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="AssignFilter">
                  <target>
                    <thisReferenceExpression/>
                  </target>
                  <parameters>
                    <methodInvokeExpression methodName="ToArray">
                      <target>
                        <argumentReferenceExpression name="filter"/>
                      </target>
                    </methodInvokeExpression>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- method AssignStartupFilter(List<FieldFilter>) -->
            <memberMethod name="AssignStartupFilter">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="List" name="filter">
                  <typeArguments>
                    <typeReference type="FieldFilter"/>
                  </typeArguments>
                </parameter>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="AssignStartupFilter">
                  <target>
                    <thisReferenceExpression/>
                  </target>
                  <parameters>
                    <methodInvokeExpression methodName="ToArray">
                      <target>
                        <argumentReferenceExpression name="filter"/>
                      </target>
                    </methodInvokeExpression>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- method CreateFilterExpressions(FieldFilter[]) -->
            <memberMethod returnType="SortedDictionary" name="CreateFilterExpressions">
              <typeArguments>
                <typeReference type="System.String"/>
                <typeReference type="System.String"/>
              </typeArguments>
              <attributes private="true"/>
              <parameters>
                <parameter type="FieldFilter[]" name="filter"/>
              </parameters>
              <statements>
                <comment>prepare a list of filter expressions</comment>
                <variableDeclarationStatement type="SortedDictionary" name="list">
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
                  <variable type="FieldFilter" name="ff"/>
                  <target>
                    <argumentReferenceExpression name="filter"/>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="System.String" name="filterExpression">
                      <init>
                        <primitiveExpression value="null"/>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="TryGetValue">
                            <target>
                              <argumentReferenceExpression name="list"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="FieldName">
                                <variableReferenceExpression name="ff"/>
                              </propertyReferenceExpression>
                              <directionExpression direction="Out">
                                <variableReferenceExpression name="filterExpression"/>
                              </directionExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="filterExpression"/>
                          <propertyReferenceExpression name="Empty">
                            <typeReferenceExpression type="String"/>
                          </propertyReferenceExpression>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <assignStatement>
                          <variableReferenceExpression name="filterExpression"/>
                          <binaryOperatorExpression operator="Add">
                            <variableReferenceExpression name="filterExpression"/>
                            <primitiveExpression value="\0"/>
                          </binaryOperatorExpression>
                        </assignStatement>
                      </falseStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IsTypeOf">
                          <propertyReferenceExpression name="Value">
                            <variableReferenceExpression name="ff"/>
                          </propertyReferenceExpression>
                          <typeReferenceExpression type="Array"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <variableDeclarationStatement type="System.Object[]" name="values">
                          <init>
                            <castExpression targetType="System.Object[]">
                              <propertyReferenceExpression name="Value">
                                <variableReferenceExpression name="ff"/>
                              </propertyReferenceExpression>
                            </castExpression>
                          </init>
                        </variableDeclarationStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <propertyReferenceExpression name="Operation">
                                <variableReferenceExpression name="ff"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="Between">
                                <typeReferenceExpression type="RowFilterOperation"/>
                              </propertyReferenceExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <propertyReferenceExpression name="Value">
                                <variableReferenceExpression name="ff"/>
                              </propertyReferenceExpression>
                              <methodInvokeExpression methodName="Format">
                                <target>
                                  <typeReferenceExpression type="String"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="{{0}}$and${{1}}"/>
                                  <methodInvokeExpression methodName="ValueToString">
                                    <target>
                                      <typeReferenceExpression type="DataControllerBase"/>
                                    </target>
                                    <parameters>
                                      <arrayIndexerExpression>
                                        <target>
                                          <variableReferenceExpression name="values"/>
                                        </target>
                                        <indices>
                                          <primitiveExpression value="0"/>
                                        </indices>
                                      </arrayIndexerExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                  <methodInvokeExpression methodName="ValueToString">
                                    <target>
                                      <typeReferenceExpression type="DataControllerBase"/>
                                    </target>
                                    <parameters>
                                      <arrayIndexerExpression>
                                        <target>
                                          <variableReferenceExpression name="values"/>
                                        </target>
                                        <indices>
                                          <primitiveExpression value="1"/>
                                        </indices>
                                      </arrayIndexerExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </assignStatement>
                          </trueStatements>
                          <falseStatements>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="BooleanOr">
                                  <binaryOperatorExpression operator="ValueEquality">
                                    <propertyReferenceExpression name="Operation">
                                      <variableReferenceExpression name="ff"/>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="Includes">
                                      <typeReferenceExpression type="RowFilterOperation"/>
                                    </propertyReferenceExpression>
                                  </binaryOperatorExpression>
                                  <binaryOperatorExpression operator="ValueEquality">
                                    <propertyReferenceExpression name="Operation">
                                      <variableReferenceExpression name="ff"/>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="DoesNotInclude">
                                      <typeReferenceExpression type="RowFilterOperation"/>
                                    </propertyReferenceExpression>
                                  </binaryOperatorExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <variableDeclarationStatement type="StringBuilder" name="svb">
                                  <init>
                                    <objectCreateExpression type="StringBuilder"/>
                                  </init>
                                </variableDeclarationStatement>
                                <foreachStatement>
                                  <variable type="System.Object" name="o"/>
                                  <target>
                                    <variableReferenceExpression name="values"/>
                                  </target>
                                  <statements>
                                    <conditionStatement>
                                      <condition>
                                        <binaryOperatorExpression operator="GreaterThan">
                                          <propertyReferenceExpression name="Length">
                                            <variableReferenceExpression name="svb"/>
                                          </propertyReferenceExpression>
                                          <primitiveExpression value="0"/>
                                        </binaryOperatorExpression>
                                      </condition>
                                      <trueStatements>
                                        <methodInvokeExpression methodName="Append">
                                          <target>
                                            <variableReferenceExpression name="svb"/>
                                          </target>
                                          <parameters>
                                            <primitiveExpression value="$or$"/>
                                          </parameters>
                                        </methodInvokeExpression>
                                      </trueStatements>
                                    </conditionStatement>
                                    <methodInvokeExpression methodName="Append">
                                      <target>
                                        <variableReferenceExpression name="svb"/>
                                      </target>
                                      <parameters>
                                        <methodInvokeExpression methodName="ValueToString">
                                          <target>
                                            <typeReferenceExpression type="DataControllerBase"/>
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
                                  <propertyReferenceExpression name="Value">
                                    <variableReferenceExpression name="ff"/>
                                  </propertyReferenceExpression>
                                  <methodInvokeExpression methodName="ToString">
                                    <target>
                                      <variableReferenceExpression name="svb"/>
                                    </target>
                                  </methodInvokeExpression>
                                </assignStatement>
                              </trueStatements>
                            </conditionStatement>
                          </falseStatements>
                        </conditionStatement>
                      </trueStatements>
                      <falseStatements>
                        <assignStatement>
                          <propertyReferenceExpression name="Value">
                            <variableReferenceExpression name="ff"/>
                          </propertyReferenceExpression>
                          <methodInvokeExpression methodName="ValueToString">
                            <target>
                              <typeReferenceExpression type="DataControllerBase"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="Value">
                                <variableReferenceExpression name="ff"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </falseStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Operation">
                            <variableReferenceExpression name="ff"/>
                          </propertyReferenceExpression>
                          <propertyReferenceExpression name="None">
                            <typeReferenceExpression type="RowFilterOperation"/>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="filterExpression"/>
                          <primitiveExpression value="null"/>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <assignStatement>
                          <variableReferenceExpression name="filterExpression"/>
                          <binaryOperatorExpression operator="Add">
                            <variableReferenceExpression name="filterExpression"/>
                            <binaryOperatorExpression operator="Add">
                              <arrayIndexerExpression>
                                <target>
                                  <propertyReferenceExpression name="ComparisonOperations">
                                    <typeReferenceExpression type="RowFilterAttribute"/>
                                  </propertyReferenceExpression>
                                </target>
                                <indices>
                                  <methodInvokeExpression methodName="ToInt32">
                                    <target>
                                      <typeReferenceExpression type="Convert"/>
                                    </target>
                                    <parameters>
                                      <propertyReferenceExpression name="Operation">
                                        <variableReferenceExpression name="ff"/>
                                      </propertyReferenceExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </indices>
                              </arrayIndexerExpression>
                              <methodInvokeExpression methodName="Replace">
                                <target>
                                  <methodInvokeExpression methodName="ToString">
                                    <target>
                                      <typeReferenceExpression type="Convert"/>
                                    </target>
                                    <parameters>
                                      <propertyReferenceExpression name="Value">
                                        <variableReferenceExpression name="ff"/>
                                      </propertyReferenceExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </target>
                                <parameters>
                                  <primitiveExpression value="'"/>
                                  <primitiveExpression value="\'"/>
                                </parameters>
                              </methodInvokeExpression>
                            </binaryOperatorExpression>
                          </binaryOperatorExpression>
                        </assignStatement>
                      </falseStatements>
                    </conditionStatement>
                    <assignStatement>
                      <arrayIndexerExpression>
                        <target>
                          <variableReferenceExpression name="list"/>
                        </target>
                        <indices>
                          <propertyReferenceExpression name="FieldName">
                            <variableReferenceExpression name="ff"/>
                          </propertyReferenceExpression>
                        </indices>
                      </arrayIndexerExpression>
                      <variableReferenceExpression name="filterExpression"/>
                    </assignStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="list"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method AssignFilter(FieldFilter[]) -->
            <memberMethod name="AssignFilter">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="FieldFilter[]" name="filter"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="SortedDictionary" name="list">
                  <typeArguments>
                    <typeReference type="System.String"/>
                    <typeReference type="System.String"/>
                  </typeArguments>
                  <init>
                    <methodInvokeExpression methodName="CreateFilterExpressions">
                      <parameters>
                        <argumentReferenceExpression name="filter"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <comment>create a filter</comment>
                <variableDeclarationStatement type="StringBuilder" name="sb">
                  <init>
                    <objectCreateExpression type="StringBuilder"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="AppendFormat">
                  <target>
                    <variableReferenceExpression name="sb"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="var dv = Web.DataView.find('{{0}}');dv.beginFilter();var f;"/>
                    <propertyReferenceExpression name="ID">
                      <thisReferenceExpression/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
                <foreachStatement>
                  <variable type="System.String" name="fieldName"/>
                  <target>
                    <propertyReferenceExpression name="Keys">
                      <variableReferenceExpression name="list"/>
                    </propertyReferenceExpression>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="IsNullOrEmpty">
                          <arrayIndexerExpression>
                            <target>
                              <variableReferenceExpression name="list"/>
                            </target>
                            <indices>
                              <variableReferenceExpression name="fieldName"/>
                            </indices>
                          </arrayIndexerExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AppendFormat">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="f=dv.findField('{{0}}');if(f)dv.removeFromFilter(f);"/>
                            <variableReferenceExpression name="fieldName"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                      <falseStatements>
                        <methodInvokeExpression methodName="AppendFormat">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="f=dv.findField('{{0}}');if(f)dv.applyFilter(f,':', '{{1}}');"/>
                            <variableReferenceExpression name="fieldName"/>
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="list"/>
                              </target>
                              <indices>
                                <variableReferenceExpression name="fieldName"/>
                              </indices>
                            </arrayIndexerExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodInvokeExpression methodName="Append">
                  <target>
                    <variableReferenceExpression name="sb"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="dv.endFilter();"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="RegisterClientScriptBlock">
                  <target>
                    <typeReferenceExpression type="ScriptManager"/>
                  </target>
                  <parameters>
                    <propertyReferenceExpression name="Page"/>
                    <typeofExpression type="DataViewExtender"/>
                    <binaryOperatorExpression operator="Add">
                      <primitiveExpression value="AsyncPostBackScript"/>
                      <propertyReferenceExpression name="ID">
                        <thisReferenceExpression/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                    <methodInvokeExpression methodName="ToString">
                      <target>
                        <variableReferenceExpression name="sb"/>
                      </target>
                    </methodInvokeExpression>
                    <primitiveExpression value="true"/>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- method AssignStartupFilter(FieldFiter[]) -->
            <memberMethod name="AssignStartupFilter">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="FieldFilter[]" name="filter"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="SortedDictionary" name="list">
                  <typeArguments>
                    <typeReference type="System.String"/>
                    <typeReference type="System.String"/>
                  </typeArguments>
                  <init>
                    <methodInvokeExpression methodName="CreateFilterExpressions">
                      <parameters>
                        <argumentReferenceExpression name="filter"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="List" name="dataViewFilter">
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
                  <variable type="System.String" name="fieldName"/>
                  <target>
                    <propertyReferenceExpression name="Keys">
                      <variableReferenceExpression name="list"/>
                    </propertyReferenceExpression>
                  </target>
                  <statements>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="dataViewFilter"/>
                      </target>
                      <parameters>
                        <methodInvokeExpression methodName="Format">
                          <target>
                            <typeReferenceExpression type="String"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="{{0}}:{{1}}"/>
                            <variableReferenceExpression name="fieldName"/>
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="list"/>
                              </target>
                              <indices>
                                <variableReferenceExpression name="fieldName"/>
                              </indices>
                            </arrayIndexerExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                </foreachStatement>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Properties"/>
                    </target>
                    <indices>
                      <primitiveExpression value="StartupFilter"/>
                    </indices>
                  </arrayIndexerExpression>
                  <variableReferenceExpression name="dataViewFilter"/>
                </assignStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
