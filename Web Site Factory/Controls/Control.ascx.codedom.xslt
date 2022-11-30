<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a app"
>
  <xsl:output method="xml" indent="yes" />

  <xsl:param name="Host" select="''"/>
  <xsl:param name="Namespace"/>
  <xsl:param name="Name"/>
  <xsl:param name="PageImplementation"/>

  <xsl:template match="app:userControl">
    <compileUnit>
      <xsl:if test="$Host='DotNetNuke'">
        <xsl:attribute name="namespace">
          <xsl:value-of select="$Namespace"/>
          <xsl:text>.WebApp</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.UI"/>
        <namespaceImport name="System.Web.UI.WebControls"/>
      </imports>
      <types>
        <!-- class Controls_XXXXX -->
        <typeDeclaration name="Controls_{$Name}" isPartial="true">
          <customAttributes>
            <xsl:if test="$Name='RichEditor'">
              <customAttribute name="{$Namespace}.Web.AquariumFieldEditor"/>
            </xsl:if>
          </customAttributes>
          <baseTypes>
            <typeReference type="System.Web.UI.UserControl"/>
          </baseTypes>
          <members>
            <!-- method Page_Load(object, EventArgs) -->
            <memberMethod name="Page_Load">
              <attributes family="true" final="true"/>
              <parameters>
                <parameter type="System.Object" name="sender"/>
                <parameter type="EventArgs" name="e"/>
              </parameters>
              <statements>
                <xsl:choose>
                  <xsl:when test="$Name='Login'">
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <propertyReferenceExpression name="IsAuthenticated">
                            <propertyReferenceExpression name="Identity">
                              <propertyReferenceExpression name="User">
                                <propertyReferenceExpression name="Page"/>
                              </propertyReferenceExpression>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                          <unaryOperatorExpression operator="IsNotNullOrEmpty">
                            <arrayIndexerExpression>
                              <target>
                                <propertyReferenceExpression name="Params">
                                  <propertyReferenceExpression name="Request"/>
                                </propertyReferenceExpression>
                              </target>
                              <indices>
                                <primitiveExpression value="ReturnUrl"/>
                              </indices>
                            </arrayIndexerExpression>
                          </unaryOperatorExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Redirect">
                          <target>
                            <propertyReferenceExpression name="Response"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="~/Pages/Home.aspx"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </xsl:when>
                  <xsl:when test="$Name='RichEditor'">
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <propertyReferenceExpression name="IsPostBack"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="RegisterClientScriptBlock">
                          <target>
                            <propertyReferenceExpression name="ClientScript">
                              <propertyReferenceExpression name="Page"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <methodInvokeExpression methodName="GetType"/>
                            <primitiveExpression value="ClientScripts"/>
                            <primitiveExpression>
                              <xsl:attribute name="value">
                                <![CDATA[
function FieldEditor_Element() {
  var list = document.getElementsByTagName('div');
  for (var i = 0; i < list.length; i++) {
      var elem = list[i];
      if (elem.className && elem.className.match(/ajax__html_editor_extender_texteditor/))
         return elem;
  }
  return null;
}                                 
function FieldEditor_GetValue(){return FieldEditor_Element().innerHTML;}
function FieldEditor_SetValue(value) {FieldEditor_Element().innerHTML=value;}]]>
                              </xsl:attribute>
                            </primitiveExpression>
                            <primitiveExpression value="true"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </xsl:when>
                  <xsl:when test="$Name='TableOfContents' and $PageImplementation!='html'">
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <propertyReferenceExpression name="IsPostBack"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="DataBind">
                          <target>
                            <propertyReferenceExpression name="TreeView1"/>
                          </target>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="ConfigureNodeTargets">
                          <parameters>
                            <propertyReferenceExpression name="Nodes">
                              <propertyReferenceExpression name="TreeView1"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </xsl:when>
                </xsl:choose>
              </statements>
            </memberMethod>
            <xsl:if test="$Name='TableOfContents' and $PageImplementation!='html'">
              <memberMethod name="ConfigureNodeTargets">
                <attributes private ="true"/>
                <parameters>
                  <parameter type="TreeNodeCollection" name="nodes"/>
                </parameters>
                <statements>
                  <foreachStatement>
                    <variable type="TreeNode" name="n" var="false"/>
                    <target>
                      <argumentReferenceExpression name="nodes"/>
                    </target>
                    <statements>
                      <variableDeclarationStatement type="Match" name="m">
                        <init>
                          <methodInvokeExpression methodName="Match">
                            <target>
                              <typeReferenceExpression type="Regex"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="NavigateUrl">
                                <variableReferenceExpression name="n"/>
                              </propertyReferenceExpression>
                              <primitiveExpression value="^(_\w+):(.+)$"/>
                            </parameters>
                          </methodInvokeExpression>
                        </init>
                      </variableDeclarationStatement>
                      <conditionStatement>
                        <condition>
                          <propertyReferenceExpression name="Success">
                            <variableReferenceExpression name="m"/>
                          </propertyReferenceExpression>
                        </condition>
                        <trueStatements>
                          <assignStatement>
                            <propertyReferenceExpression name="Target">
                              <variableReferenceExpression name="n"/>
                            </propertyReferenceExpression>
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
                          </assignStatement>
                          <assignStatement>
                            <propertyReferenceExpression name="NavigateUrl">
                              <variableReferenceExpression name="n"/>
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
                        </trueStatements>
                      </conditionStatement>
                      <methodInvokeExpression methodName="ConfigureNodeTargets">
                        <parameters>
                          <propertyReferenceExpression name="ChildNodes">
                            <variableReferenceExpression name="n"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </statements>
                  </foreachStatement>
                </statements>
              </memberMethod>
            </xsl:if>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
