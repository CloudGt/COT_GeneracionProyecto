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

  <!-- 
public partial class CustomersBusinessRules : MyCompany.Data.BusinessRules
{
    /// <summary>
    /// This method will execute in the view "grid1" before the action
    /// with the command name that matches "Insert|Update" 
    /// and also when argument matches "DoIt".
    /// </summary>
    /// <param name="customerID">CustomerID* String(5)</param>
    /// <param name="companyName">CompanyName* String(40)</param>
    /// <param name="contactName"></param>
    /// <param name="contactTitle"></param>
    /// <param name="address"></param>
    /// <param name="city"></param>
    /// <param name="region"></param>
    /// <param name="postalCode"></param>
    /// <param name="country"></param>
    /// <param name="phone"></param>
    /// <param name="fax"></param>
    [Rule("r100")]
    public void r100Implementation(string customerID, string companyName, string contactName, string contactTitle, string address, string city, string region, string postalCode, string country, string phone, string fax)
    {
        // This method will execute in the view "grid1" before the action
        // with the command name that matches "Insert|Update" 
        // when argument matches "DoIt".
    }
}

[AttributeUsage(AttributeTargets.Method, AllowMultiple = true, Inherited = true)]
public class RuleAttribute : Attribute
{
    public string Id { set; get; }
    public RuleAttribute(string id)
    {
        this.Id = id;
    }
}

-->

  <xsl:template match="c:rule">
    <xsl:apply-templates select="ancestor::c:dataController">
      <xsl:with-param name="Rule" select="."/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="c:dataController">
    <xsl:param name="Rule"/>

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
        <xsl:when test="$QualifiedClassName='MyProfileBusinessRules'">
          <xsl:text>Rules.MyProfileBusinessRulesBase</xsl:text>
        </xsl:when>
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
        <namespaceImport name="{$Namespace}.Models"/>
      </imports>
      <types>
        <!-- class BusinessObject -->
        <typeDeclaration name="{$QualifiedClassName}" isPartial="true">
          <baseTypes>
            <typeReference type="{$Namespace}.{$BusinessRulesBase}"/>
          </baseTypes>
          <members>
            <!-- code formulas -->

            <memberMethod name="{$Rule/@id}Implementation">
              <comment>
                <![CDATA[/// <summary>
]]>
                <xsl:if test="$Rule/@name!=''">
                  <xsl:text>Rule "</xsl:text>
                  <xsl:value-of select="$Rule/@name"/>
                  <xsl:text>" implementation:
</xsl:text>
                </xsl:if>
                <xsl:text>This method will execute</xsl:text>
                <xsl:choose>
                  <xsl:when test="$Rule/@view != ''">
                    <xsl:text> in the view with id matching "</xsl:text>
                    <xsl:value-of select="$Rule/@view"/>
                    <xsl:text>"</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text> in any view</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                  <xsl:when test="$Rule/@phase='Before'">
                    <xsl:text> before</xsl:text>
                  </xsl:when>
                  <xsl:when test="$Rule/@phase='After'">
                    <xsl:text> after</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text> for</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text> an action
with a command name that matches "</xsl:text>
                <xsl:value-of select="$Rule/@commandName"/><xsl:text>"</xsl:text>
                <xsl:if test="$Rule/@commandArgument!=''">
                  <xsl:text> and argument that matches "</xsl:text>
                  <xsl:value-of select="$Rule/@commandArgument"/>
                  <xsl:text>"</xsl:text>
                </xsl:if><xsl:text>.</xsl:text>
                <![CDATA[
/// </summary>
]]><!--<xsl:for-each select="c:fields/c:field">
                  <![CDATA[/// <param name="]]><xsl:value-of select="@name"/><xsl:text>"></xsl:text>CustomerID* String(5)<![CDATA[</param>
]]>
                </xsl:for-each>-->
              </comment>
              <attributes public="true" final="false"/>
              <customAttributes>
                <customAttribute name="Rule">
                  <arguments>
                    <primitiveExpression value="{$Rule/@id}"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <parameters>
                <xsl:for-each select="$Self">
                  <!--<xsl:call-template name="RenderRuleParameters"/>-->
                </xsl:for-each>
                <parameter name="instance" type="{$Self/@name}Model"/>
              </parameters>
              <statements>
                <xsl:variable name="FieldLevelRule_FieldName" select="substring-before($Rule/@name, '_')"/>
                <xsl:variable name="FieldLevelRule_RuleClass" select="substring-after($Rule/@name, '_')"/>
                <xsl:variable name="Field" select="c:fields/c:field[@name=$FieldLevelRule_FieldName]"/>
                <xsl:choose>
                  <xsl:when test="$Field and $FieldLevelRule_RuleClass='Validator'">
                    <conditionStatement>
                      <condition>
                        <xsl:choose>
                          <xsl:when test="$Field/@type='String'">
                            <unaryOperatorExpression operator="IsNullOrEmpty">
                              <propertyReferenceExpression name="{$Field/@name}">
                                <argumentReferenceExpression name="instance"/>
                              </propertyReferenceExpression>
                            </unaryOperatorExpression>
                          </xsl:when>
                          <xsl:when test="$Field/@type='Byte[]' or $Field/@type='Object'">
                            <binaryOperatorExpression operator="IdentityEquality">
                              <methodInvokeExpression methodName="SelectFieldValue">
                                <target>
                                  <thisReferenceExpression/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="{$Field/@name}"/>
                                </parameters>
                              </methodInvokeExpression>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                          </xsl:when>
                          <xsl:otherwise>
                            <unaryOperatorExpression operator="Not">
                              <propertyReferenceExpression name="HasValue">
                                <propertyReferenceExpression name="{$Field/@name}">
                                  <argumentReferenceExpression name="instance"/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                            </unaryOperatorExpression>
                          </xsl:otherwise>
                        </xsl:choose>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="PreventDefault">
                          <target>
                            <thisReferenceExpression/>
                          </target>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="Focus">
                          <target>
                            <propertyReferenceExpression name="Result">
                              <thisReferenceExpression/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="{$Field/@name}"/>
                            <primitiveExpression value="Required field."/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </xsl:when>
                  <xsl:when test="$Field and $FieldLevelRule_RuleClass='Converter'">
                    <!-- 
            if (!String.IsNullOrEmpty(city) && (Arguments.CommandName != "Calculate" || Arguments.Trigger == "City"))
            {
                UpdateFieldValue("City", city.ToUpper());
            }
                    -->
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <xsl:choose>
                            <xsl:when test="$Field/@type='String'">
                              <unaryOperatorExpression operator="IsNotNullOrEmpty">
                                <propertyReferenceExpression name="{$Field/@name}">
                                  <argumentReferenceExpression name="instance"/>
                                </propertyReferenceExpression>
                              </unaryOperatorExpression>
                            </xsl:when>
                            <xsl:when test="$Field/@type='Byte[]' or $Field/@type='Object'">
                              <binaryOperatorExpression operator="IdentityInequality">
                                <methodInvokeExpression methodName="SelectFieldValue">
                                  <target>
                                    <thisReferenceExpression/>
                                  </target>
                                  <parameters>
                                    <primitiveExpression value="{$Field/@name}"/>
                                  </parameters>
                                </methodInvokeExpression>
                                <primitiveExpression value="null"/>
                              </binaryOperatorExpression>
                            </xsl:when>
                            <xsl:otherwise>
                              <propertyReferenceExpression name="HasValue">
                                <propertyReferenceExpression name="{$Field/@name}">
                                  <argumentReferenceExpression name="instance"/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                            </xsl:otherwise>
                          </xsl:choose>
                          <binaryOperatorExpression operator="BooleanOr">
                            <binaryOperatorExpression operator="ValueInequality">
                              <propertyReferenceExpression name="CommandName">
                                <propertyReferenceExpression name="Arguments">
                                  <thisReferenceExpression/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                              <primitiveExpression value="Calculate"/>
                            </binaryOperatorExpression>
                            <binaryOperatorExpression operator="ValueEquality">
                              <propertyReferenceExpression name="Trigger">
                                <propertyReferenceExpression name="Arguments">
                                  <thisReferenceExpression/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                              <primitiveExpression value="{$Field/@name}"/>
                            </binaryOperatorExpression>
                          </binaryOperatorExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <xsl:if test="$Field/@type != 'String'">
                          <comment>implement a conversion of the field value here</comment>
                        </xsl:if>
                        <methodInvokeExpression methodName="UpdateFieldValue">
                          <parameters>
                            <primitiveExpression value="{$Field/@name}"/>
                            <xsl:choose>
                              <xsl:when test="$Field/@type='String'">
                                <methodInvokeExpression methodName="ToUpper">
                                  <target>
                                    <propertyReferenceExpression name="{$Field/@name}">
                                      <argumentReferenceExpression name="instance"/>
                                    </propertyReferenceExpression>
                                  </target>
                                </methodInvokeExpression>
                              </xsl:when>
                              <xsl:otherwise>
                                <propertyReferenceExpression name="{$Field/@name}">
                                  <argumentReferenceExpression name="instance"/>
                                </propertyReferenceExpression>
                              </xsl:otherwise>
                            </xsl:choose>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </xsl:when>
                  <xsl:when test="$Rule/@id = 'GetData' and $Rule/@phase = 'Before' and $Rule/@commandName = 'Select'">
                    <assignStatement>
                      <propertyReferenceExpression name="ResultSet"/>
                      <methodInvokeExpression methodName="Create{@name}DataTable"/>
                    </assignStatement>
                  </xsl:when>
                  <xsl:when test="$Rule/@phase='Before' and ($Rule/@id = 'Update' or $Rule/@id = 'Insert' or $Rule/@id = 'Delete')">
                    <methodInvokeExpression methodName="PreventDefault" />
                  </xsl:when>
                  <xsl:otherwise>
                    <comment>
                      <xsl:text>This is the placeholder for method implementation.</xsl:text>
                    </comment>
                  </xsl:otherwise>
                </xsl:choose>
              </statements>
            </memberMethod>
            <xsl:if test="$Rule/@id = 'GetData' and $Rule/@phase = 'Before' and $Rule/@commandName = 'Select'">
              <memberMethod returnType="DataTable" name="Create{@name}DataTable">
                <attributes private="true" />
                <statements>
                  <variableDeclarationStatement type="DataTable" name="dt">
                    <init>
                      <objectCreateExpression type="DataTable"/>
                    </init>
                  </variableDeclarationStatement>

                  <xsl:for-each select="c:fields/c:field">
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <propertyReferenceExpression name="Columns">
                          <variableReferenceExpression name="dt"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="{@name}"/>
                        <typeofExpression type="{@type}"/>
                      </parameters>
                    </methodInvokeExpression>
                  </xsl:for-each>

                  <comment>
                    <xsl:text>
 Populate rows of table "dt" with data from any source (web service, file system, database, etc.)
</xsl:text>
                  </comment>

                  <methodReturnStatement>
                    <variableReferenceExpression name="dt"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
            </xsl:if>

          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>

</xsl:stylesheet>
