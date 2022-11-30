<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="IsClassLibrary" select="'false'"/>
  <xsl:param name="Theme" select="'Aquarium'"/>
  <xsl:param name="ScriptOnly" select="'false'"/>

  <xsl:template match="/">
    <compileUnit namespace="{a:project/a:namespace}.Web">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Security"/>
        <namespaceImport name="System.Web.UI"/>
        <namespaceImport name="System.Web.UI.HtmlControls"/>
        <namespaceImport name="System.Web.UI.WebControls"/>
        <xsl:if test="$ScriptOnly='false'">
          <namespaceImport name="AjaxControlToolkit"/>
        </xsl:if>
      </imports>
      <types>

        <!-- class ControlHost -->
        <typeDeclaration name="ControlHost">
          <attributes  public="true"/>
          <baseTypes>
            <typeReference type="System.Web.UI.Page"/>
          </baseTypes>
          <members>
            <!-- property Theme -->
            <memberProperty type="System.String" name="Theme">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <propertyReferenceExpression name="Theme">
                    <baseReferenceExpression/>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <comment>Themes are not supported in editors.</comment>
              </setStatements>
            </memberProperty>
            <!-- method OnInit(EventArgs) -->
            <memberMethod name="OnInit">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="EventArgs" name="e"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <objectCreateExpression type="LiteralControl">
                      <parameters>
                        <primitiveExpression>
                          <xsl:attribute name="value">
                            <xsl:text disable-output-escaping="yes"><![CDATA[
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="overflow: hidden">
]]></xsl:text>
                          </xsl:attribute>
                        </primitiveExpression>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="HtmlHead" name="head">
                  <init>
                    <objectCreateExpression type="HtmlHead"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="head"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls">
                      <variableReferenceExpression name="head"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <objectCreateExpression type="LiteralControl">
                      <parameters>
                        <primitiveExpression>
                          <xsl:attribute name="value">
                            <xsl:text disable-output-escaping="yes"><![CDATA[
    <script type="text/javascript">
        function pageLoad() {
            var m = location.href.match(/(\?|&)id=(.+?)(&|$)/);
            if (!(parent && parent.window.Web) || !m) return;
            var elem = parent.window.$get(m[2]);
            if (!elem) return;
            if (typeof (FieldEditor_SetValue) !== "undefined")
                FieldEditor_SetValue(elem.value);
            else
                alert('The field editor does not implement "FieldEditor_SetValue" function.');
            if (typeof (FieldEditor_GetValue) !== "undefined")
                parent.window.Web.DataView.Editors[elem.id] = { 'GetValue': FieldEditor_GetValue, 'SetValue': FieldEditor_SetValue };
            else
                alert('The field editor does not implement "FieldEditor_GetValue" function.');
        }
    </script>
]]></xsl:text>
                          </xsl:attribute>
                        </primitiveExpression>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls">
                      <variableReferenceExpression name="head"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <objectCreateExpression type="LiteralControl">
                      <parameters>
                        <primitiveExpression>
                          <xsl:attribute name="value">
                            <xsl:text disable-output-escaping="yes"><![CDATA[
    <style type="text/css">
        .ajax__htmleditor_editor_container
        {
            border-width:0px!important;
        }

        .ajax__htmleditor_editor_bottomtoolbar
        {
            padding-top:2px!important;
        }
    </style>]]></xsl:text>
                          </xsl:attribute>
                        </primitiveExpression>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <objectCreateExpression type="LiteralControl">
                      <parameters>
                        <primitiveExpression>
                          <xsl:attribute name="value">
                            <xsl:text disable-output-escaping="yes"><![CDATA[
<body style="margin: 0px; padding: 0px; background-color: #fff;">
]]></xsl:text>
                          </xsl:attribute>
                        </primitiveExpression>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="HtmlForm" name="form">
                  <init>
                    <objectCreateExpression type="HtmlForm"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="form"/>
                  </parameters>
                </methodInvokeExpression>
                <xsl:choose>
                  <xsl:when test="$ScriptOnly='true'">
                    <variableDeclarationStatement type="ScriptManager" name="sm">
                      <init>
                        <objectCreateExpression type="ScriptManager"/>
                      </init>
                    </variableDeclarationStatement>
                  </xsl:when>
                  <xsl:otherwise>
                    <variableDeclarationStatement type="ToolkitScriptManager" name="sm">
                      <init>
                        <objectCreateExpression type="ToolkitScriptManager"/>
                      </init>
                    </variableDeclarationStatement>
                  </xsl:otherwise>
                </xsl:choose>
                <assignStatement>
                  <propertyReferenceExpression name="ScriptMode">
                    <variableReferenceExpression name="sm"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="Release">
                    <typeReferenceExpression type="ScriptMode"/>
                  </propertyReferenceExpression>
                </assignStatement>
                <xsl:if test="a:project/@targetFramework='4.0'">
                  <assignStatement>
                    <propertyReferenceExpression name="EnableCdn">
                      <variableReferenceExpression name="sm"/>
                    </propertyReferenceExpression>
                    <primitiveExpression value="false"/>
                  </assignStatement>
                </xsl:if>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls">
                      <propertyReferenceExpression name="form"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="sm"/>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="System.String" name="controlName">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Params">
                          <propertyReferenceExpression name="Request"/>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <primitiveExpression value="control"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="Control" name="c">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<variableReferenceExpression name="controlName"/>
										</unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <tryStatement>
                      <statements>
                        <assignStatement>
                          <variableReferenceExpression name="c"/>
                          <methodInvokeExpression methodName="LoadControl">
                            <parameters>
                              <methodInvokeExpression methodName="Format">
                                <target>
                                  <typeReferenceExpression type="String"/>
                                </target>
                                <parameters>
                                  <primitiveExpression>
                                    <xsl:attribute name="value"><![CDATA[~/Controls/{0}.ascx]]></xsl:attribute>
                                  </primitiveExpression>
                                  <variableReferenceExpression name="controlName"/>
                                </parameters>
                              </methodInvokeExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </statements>
                      <catch exceptionType="Exception">
                      </catch>
                    </tryStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="c"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <variableDeclarationStatement type="System.Object[]" name="editorAttributes">
                          <init>
                            <methodInvokeExpression methodName="GetCustomAttributes">
                              <target>
                                <methodInvokeExpression methodName="GetType">
                                  <target>
                                    <variableReferenceExpression name="c"/>
                                  </target>
                                </methodInvokeExpression>
                              </target>
                              <parameters>
                                <typeofExpression type="AquariumFieldEditorAttribute"/>
                                <primitiveExpression value="true"/>
                              </parameters>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <propertyReferenceExpression name="Length">
                                <variableReferenceExpression name="editorAttributes"/>
                              </propertyReferenceExpression>
                              <primitiveExpression value="0"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="c"/>
                              <primitiveExpression value="null"/>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                      <falseStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <variableReferenceExpression name="controlName"/>
                              <primitiveExpression value="RichEditor"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <xsl:choose>
                              <xsl:when test="$ScriptOnly='true'"></xsl:when>
                              <xsl:otherwise>
                                <variableDeclarationStatement type="AjaxControlToolkit.HTMLEditor.Editor" name="editor">
                                  <init>
                                    <objectCreateExpression type="AjaxControlToolkit.HTMLEditor.Editor"/>
                                  </init>
                                </variableDeclarationStatement>
                                <assignStatement>
                                  <propertyReferenceExpression name="AutoFocus">
                                    <variableReferenceExpression name="editor"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="false"/>
                                </assignStatement>
                                <assignStatement>
                                  <propertyReferenceExpression name="InitialCleanUp">
                                    <variableReferenceExpression name="editor"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="true"/>
                                </assignStatement>
                                <assignStatement>
                                  <propertyReferenceExpression name="NoScript">
                                    <variableReferenceExpression name="editor"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="true"/>
                                </assignStatement>
                                <assignStatement>
                                  <propertyReferenceExpression name="Width">
                                    <variableReferenceExpression name="editor"/>
                                  </propertyReferenceExpression>
                                  <objectCreateExpression type="Unit">
                                    <parameters>
                                      <primitiveExpression value="100%"/>
                                    </parameters>
                                  </objectCreateExpression>
                                </assignStatement>
                                <assignStatement>
                                  <propertyReferenceExpression name="Height">
                                    <variableReferenceExpression name="editor"/>
                                  </propertyReferenceExpression>
                                  <objectCreateExpression type="Unit">
                                    <parameters>
                                      <primitiveExpression value="250"/>
                                    </parameters>
                                  </objectCreateExpression>
                                </assignStatement>
                                <assignStatement>
                                  <variableReferenceExpression name="c"/>
                                  <variableReferenceExpression name="editor"/>
                                </assignStatement>
                              </xsl:otherwise>
                            </xsl:choose>
                          </trueStatements>
                        </conditionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <variableReferenceExpression name="c"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
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
                  </trueStatements>
                  <falseStatements>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <propertyReferenceExpression name="Controls">
                          <variableReferenceExpression name="form"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="c"/>
                      </parameters>
                    </methodInvokeExpression>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <binaryOperatorExpression operator="IsTypeOf">
                            <variableReferenceExpression name="c"/>
                            <typeReferenceExpression type="System.Web.UI.UserControl"/>
                          </binaryOperatorExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="RegisterClientScriptBlock">
                          <target>
                            <propertyReferenceExpression name="ClientScript">
                              <thisReferenceExpression/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <methodInvokeExpression methodName="GetType"/>
                            <primitiveExpression value="ClientScripts"/>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="String"/>
                              </target>
                              <parameters>
                                <primitiveExpression>
                                  <xsl:attribute name="value">
                                    <xsl:text disable-output-escaping="yes"><![CDATA[function FieldEditor_GetValue(){{return $find('{0}').get_content();}}
function FieldEditor_SetValue(value) {{$find('{0}').set_content(value);}}]]></xsl:text>
                                  </xsl:attribute>
                                </primitiveExpression>
                                <propertyReferenceExpression name="ClientID">
                                  <variableReferenceExpression name="c"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                            <primitiveExpression value="true"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <objectCreateExpression type="LiteralControl">
                      <parameters>
                        <primitiveExpression>
                          <xsl:attribute name="value">
                            <xsl:text disable-output-escaping="yes"><![CDATA[

</body>
</html>]]></xsl:text>
                          </xsl:attribute>
                        </primitiveExpression>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="OnInit">
                  <target>
                    <baseReferenceExpression/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="e"/>
                  </parameters>
                </methodInvokeExpression>
                <assignStatement>
                  <propertyReferenceExpression name="EnableViewState"/>
                  <primitiveExpression value="false"/>
                </assignStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
