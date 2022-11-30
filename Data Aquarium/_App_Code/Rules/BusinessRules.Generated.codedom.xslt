<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:c="urn:schemas-codeontime-com:data-aquarium"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:csharp="urn:codeontime-customcode"
    exclude-result-prefixes="msxsl a c csharp"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:param name="Namespace"/>
  <xsl:param name="SharedBusinessRules" select="'false'"/>

  <xsl:include href="..\Data\Objects\Shared.codedom.xslt"/>

  <xsl:template match="c:dataController">

    <xsl:variable name="QualifiedNamespace">
      <xsl:choose>
        <xsl:when test="contains(@handler,'.')">
          <xsl:value-of select="csharp:ExtractNamespace(@handler)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$Namespace"/>
          <xsl:text>.Rules</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="QualifiedClassName">
      <xsl:choose>
        <xsl:when test="contains(@handler, '.')">
          <xsl:value-of select="csharp:ExtractClassName(@handler)"/>
        </xsl:when>
        <xsl:when test="@handler!=''">
          <xsl:value-of select="@handler"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@name"/>
          <xsl:text>BusinessRules</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="BusinessRulesBase">
      <xsl:choose>
        <xsl:when test="$SharedBusinessRules='true'">
          <xsl:text>Rules.SharedBusinessRules</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>Data.BusinessRules</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="Self" select="."/>

    <compileUnit namespace="{$QualifiedNamespace}">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Data"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Security"/>
        <namespaceImport name="{$Namespace}.Data"/>
      </imports>
      <types>
        <!-- class BusinessObject -->
        <typeDeclaration name="{$QualifiedClassName}" isPartial="true">
          <baseTypes>
            <typeReference type="{$Namespace}.{$BusinessRulesBase}"/>
          </baseTypes>
          <members>
            <!-- code formulas -->
            <xsl:variable name="FieldsWithCodeFormulas" select="c:fields/c:field[string-length(c:codeFormula)>0]"/>
            <xsl:if test="$FieldsWithCodeFormulas">
              <memberMethod name="Calculate{$Self/@name}">
                <attributes public="true" final="false"/>
                <customAttributes>
                  <xsl:for-each select="$FieldsWithCodeFormulas">
                    <customAttribute name="ControllerAction">
                      <arguments>
                        <primitiveExpression value="{$Self/@name}"/>
                        <primitiveExpression value="Calculate"/>
                        <primitiveExpression value="{@name}"/>
                      </arguments>
                    </customAttribute>
                  </xsl:for-each>
                </customAttributes>
                <parameters>
                  <xsl:for-each select="$Self">
                    <xsl:call-template name="RenderFilterParameters"/>
                  </xsl:for-each>
                </parameters>
                <statements>
                  <xsl:for-each select="$FieldsWithCodeFormulas">
                    <methodInvokeExpression methodName="UpdateFieldValue">
                      <parameters>
                        <primitiveExpression value="{@name}"/>
                        <snippet>
                          <xsl:value-of select="c:codeFormula"/>
                        </snippet>
                      </parameters>
                    </methodInvokeExpression>
                  </xsl:for-each>
                </statements>
              </memberMethod>
            </xsl:if>
            <!-- default values created with a row builder -->
            <xsl:variable name="CodeDefaults" select="c:fields/c:field[string-length(c:codeDefault)>0]"/>
            <xsl:if test="$CodeDefaults">
              <memberMethod name="BuildNew{$Self/@name}">
                <attributes public="true" final="false"/>
                <customAttributes>
                  <customAttribute name="RowBuilder">
                    <arguments>
                      <primitiveExpression value="{$Self/@name}"/>
                      <propertyReferenceExpression name="New">
                        <typeReferenceExpression type="RowKind"/>
                      </propertyReferenceExpression>
                    </arguments>
                  </customAttribute>
                </customAttributes>
                <statements>
                  <xsl:for-each select="$CodeDefaults">
                    <methodInvokeExpression methodName="UpdateFieldValue">
                      <target>
                      </target>
                      <parameters>
                        <primitiveExpression value="{@name}"/>
                        <snippet>
                          <xsl:value-of select="c:codeDefault"/>
                        </snippet>
                      </parameters>
                    </methodInvokeExpression>
                  </xsl:for-each>
                </statements>
              </memberMethod>
            </xsl:if>
            <!-- code values calculations-->
            <xsl:variable name="CodeValues" select="c:fields/c:field[string-length(c:codeValue)>0]"/>
            <xsl:if test="$CodeValues">
              <memberMethod name="AssignFieldValuesTo{$Self/@name}">
                <attributes public="true" final="false"/>
                <customAttributes>
                  <customAttribute name="ControllerAction">
                    <arguments>
                      <primitiveExpression value="{$Self/@name}"/>
                      <primitiveExpression value="Insert"/>
                      <propertyReferenceExpression name="Before">
                        <typeReferenceExpression type="ActionPhase"/>
                      </propertyReferenceExpression>
                    </arguments>
                  </customAttribute>
                  <customAttribute name="ControllerAction">
                    <arguments>
                      <primitiveExpression value="{$Self/@name}"/>
                      <primitiveExpression value="Update"/>
                      <propertyReferenceExpression name="Before">
                        <typeReferenceExpression type="ActionPhase"/>
                      </propertyReferenceExpression>
                    </arguments>
                  </customAttribute>
                </customAttributes>
                <parameters>
                  <xsl:for-each select="$Self">
                    <xsl:call-template name="RenderFilterParameters"/>
                  </xsl:for-each>
                </parameters>
                <statements>
                  <xsl:for-each select="$CodeValues">
                    <variableDeclarationStatement type="FieldValue" name="{@name}FieldValue">
                      <init>
                        <methodInvokeExpression methodName="SelectFieldValueObject">
                          <parameters>
                            <primitiveExpression value="{@name}"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.Object" name="{@name}CodeValue">
                      <init>
                        <snippet>
                          <xsl:value-of select="c:codeValue"/>
                        </snippet>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityEquality">
                          <variableReferenceExpression name="{@name}FieldValue"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AddFieldValue">
                          <parameters>
                            <primitiveExpression value="{@name}"/>
                            <variableReferenceExpression name="{@name}CodeValue"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                      <falseStatements>
                        <assignStatement>
                          <propertyReferenceExpression name="NewValue">
                            <variableReferenceExpression name="{@name}FieldValue"/>
                          </propertyReferenceExpression>
                          <variableReferenceExpression name="{@name}CodeValue"/>
                        </assignStatement>
                        <assignStatement>
                          <propertyReferenceExpression name="Modified">
                            <variableReferenceExpression name="{@name}FieldValue"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                        <assignStatement>
                          <propertyReferenceExpression name="ReadOnly">
                            <variableReferenceExpression name="{@name}FieldValue"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="false"/>
                        </assignStatement>
                      </falseStatements>
                    </conditionStatement>
                  </xsl:for-each>
                </statements>
              </memberMethod>
            </xsl:if>
            <!-- Row filters -->
            <xsl:for-each select=".//c:dataField[c:codeFilter!='' and c:codeFilter/@operator!='']">
              <xsl:variable name="Field" select="$Self/c:fields/c:field[@name=current()/@fieldName]"/>
              <memberProperty name="{@fieldName}RowFilter">
                <xsl:for-each select="$Field">
                  <xsl:call-template name="RenderFieldType"/>
                </xsl:for-each>
                <attributes public="true" final="false"/>
                <customAttributes>
                  <customAttribute type="RowFilter">
                    <arguments>
                      <primitiveExpression value="{$Self/@name}"/>
                      <primitiveExpression value="{ancestor::c:view/@id}"/>
                      <primitiveExpression value="{@fieldName}"/>
                      <propertyReferenceExpression name="{c:codeFilter/@operator}">
                        <typeReferenceExpression type="RowFilterOperation"/>
                      </propertyReferenceExpression>
                    </arguments>
                  </customAttribute>
                </customAttributes>
                <getStatements>
                  <methodReturnStatement>
                    <snippet>
                      <xsl:value-of select="c:codeFilter"/>
                    </snippet>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
            </xsl:for-each>
            <xsl:for-each select="c:views/c:view[@virtualViewId!='' and c:overrideWhen!='']">
              <!-- 
    [OverrideWhen("Products", "grid2", "grid1")]
    public bool View_grid2_Overrides_grid1
    {
        get
        {
            return !Context.User.IsInRole("Administrators");
        }
    }
						-->
              <memberProperty type="System.Boolean">
                <xsl:attribute name="name">
                  <xsl:text>View_</xsl:text>
                  <xsl:value-of select="@id"/>
                  <xsl:text>_Overrides_</xsl:text>
                  <xsl:value-of select="@virtualViewId"/>
                </xsl:attribute>
                <attributes public="true" final="true"/>
                <customAttributes>
                  <customAttribute name="OverrideWhen">
                    <arguments>
                      <primitiveExpression value="{$Self/@name}"/>
                      <primitiveExpression value="{@id}"/>
                      <primitiveExpression value="{@virtualViewId}"/>
                    </arguments>
                  </customAttribute>
                </customAttributes>
                <getStatements>
                  <methodReturnStatement>
                    <snippet>
                      <xsl:value-of select="c:overrideWhen"/>
                    </snippet>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
            </xsl:for-each>
            <!-- pivot views -->
            <!--<xsl:variable name="PivotViews" select="c:views/c:view[c:dataFields/c:dataField/@pivot!='']"/>
            <xsl:for-each select="$PivotViews">
              -->
            <!-- property Xxx_PivotOverride -->
            <!--
              <memberProperty type="System.Boolean" name="{@id}_PivotOverride">
                <attributes public="true" final="true"/>
                <customAttributes>
                  <customAttribute name="OverrideWhen">
                    <arguments>
                      <primitiveExpression value="{$Self/@name}"/>
                      <primitiveExpression value="{@id}_Pivot"/>
                      <primitiveExpression value="{@id}"/>
                    </arguments>
                  </customAttribute>
                </customAttributes>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression value="true"/>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              -->
            <!-- method XxxxNewRow() -->
            <!--
              <memberMethod name="{@id}_NewRow">
                <attributes public="true" final="true"/>
                <customAttributes>
                  <customAttribute name="RowBuilder">
                    <arguments>
                      <primitiveExpression value="{$Self/@name}"/>
                      <primitiveExpression value="{@id}"/>
                      <propertyReferenceExpression name="New">
                        <typeReferenceExpression type="RowKind"/>
                      </propertyReferenceExpression>
                    </arguments>
                  </customAttribute>
                </customAttributes>
                <statements>
                  <methodInvokeExpression methodName="AssignDefaultPivotColumnValues"/>
                </statements>
              </memberMethod>
            </xsl:for-each>-->
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>

</xsl:stylesheet>
