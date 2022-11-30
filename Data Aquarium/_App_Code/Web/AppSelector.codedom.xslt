<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl app"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="Namespace" />

  <xsl:template match="/">
    <compileUnit namespace="{$Namespace}.Web">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Configuration"/>
        <namespaceImport name="System.ComponentModel"/>
        <namespaceImport name="System.IO"/>
        <namespaceImport name="System.Text"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.UI"/>
        <namespaceImport name="System.Web.UI.HtmlControls"/>
        <namespaceImport name="System.Web.UI.WebControls"/>
        <namespaceImport name="System.Web.UI.WebControls.WebParts"/>
      </imports>
      <types>
        <!-- class AppPage -->
        <typeDeclaration name="AppPage">
          <members>
            <memberProperty type="System.String" name="Name">
              <attributes public="true" final="true"/>
            </memberProperty>
            <memberProperty type="System.String" name="Path">
              <attributes public="true" final="true"/>
            </memberProperty>
            <memberProperty type="System.String" name="Description">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- constructor AppPage(string, string string)-->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
                <parameter type="System.String" name="path"/>
                <parameter type="System.String" name="description"/>
              </parameters>
              <statements>
                <assignStatement>
                  <propertyReferenceExpression name="Name">
                    <thisReferenceExpression/>
                  </propertyReferenceExpression>
                  <variableReferenceExpression name="name"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Path">
                    <thisReferenceExpression/>
                  </propertyReferenceExpression>
                  <methodInvokeExpression methodName="Replace">
                    <target>
                      <typeReferenceExpression type="Regex"/>
                    </target>
                    <parameters>
                      <variableReferenceExpression name="path"/>
                      <primitiveExpression value="\^\w+\^"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Description">
                    <thisReferenceExpression/>
                  </propertyReferenceExpression>
                  <variableReferenceExpression name="description"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- property Pages -->
            <memberField type="AppPage[]" name="Pages">
              <attributes public="true" static="true"/>
              <init>
                <arrayCreateExpression>
                  <createType type="AppPage"/>
                  <initializers>
                    <xsl:for-each select="/app:application/app:pages/app:page">
                      <objectCreateExpression type="AppPage">
                        <parameters>
                          <primitiveExpression value="{@name}"/>
                          <primitiveExpression value="{@path}"/>
                          <primitiveExpression value="{@description}"/>
                        </parameters>
                      </objectCreateExpression>
                    </xsl:for-each>
                  </initializers>
                </arrayCreateExpression>
              </init>
            </memberField>
            <!-- method Find(string) -->
            <memberMethod returnType="AppPage" name="Find">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="AppPage" name="p"/>
                  <target>
                    <propertyReferenceExpression name="Pages"/>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Name">
                            <variableReferenceExpression name="p"/>
                          </propertyReferenceExpression>
                          <argumentReferenceExpression name="name"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <variableReferenceExpression name="p"/>
                        </methodReturnStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <primitiveExpression value="null"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class AppSelector-->
        <typeDeclaration name="AppSelector">
          <customAttributes>
            <customAttribute name="ToolboxItemAttribute">
              <arguments>
                <primitiveExpression value="false"/>
              </arguments>
            </customAttribute>
          </customAttributes>
          <baseTypes>
            <typeReference type="System.Web.UI.Control"/>
          </baseTypes>
          <members>
            <memberField type="HiddenField" name="hidden"/>
            <!-- property ApplicationPage -->
            <memberProperty type="System.String" name="ApplicationPage">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <propertyReferenceExpression name="Value">
                    <fieldReferenceExpression name="hidden"/>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <fieldReferenceExpression name="hidden"/>
                  </propertyReferenceExpression>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
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
                <assignStatement>
                  <fieldReferenceExpression name="hidden"/>
                  <objectCreateExpression type="HiddenField"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Value">
                    <fieldReferenceExpression name="hidden"/>
                  </propertyReferenceExpression>
                  <propertyReferenceExpression name="ApplicationPage"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="ID">
                    <fieldReferenceExpression name="hidden"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="ApplicationPage"/>
                </assignStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <fieldReferenceExpression name="hidden"/>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- method CreateChildControls() -->
            <memberMethod name="CreateChildControls">
              <attributes family="true" override="true"/>
              <statements>
                <methodInvokeExpression methodName="CreateChildControls">
                  <target>
                    <baseReferenceExpression/>
                  </target>
                </methodInvokeExpression>
                <comment>render a list of available logical pages</comment>
                <variableDeclarationStatement type="StringBuilder" name="sb">
                  <init>
                    <objectCreateExpression type="StringBuilder"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="HtmlTextWriter" name="writer">
                  <init>
                    <objectCreateExpression type="HtmlTextWriter">
                      <parameters>
                        <objectCreateExpression type="StringWriter">
                          <parameters>
                            <variableReferenceExpression name="sb"/>
                          </parameters>
                        </objectCreateExpression>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="AddAttribute">
                  <target>
                    <variableReferenceExpression name="writer"/>
                  </target>
                  <parameters>
                    <propertyReferenceExpression name="Type">
                      <typeReferenceExpression type="HtmlTextWriterAttribute"/>
                    </propertyReferenceExpression>
                    <primitiveExpression value="text/css"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="RenderBeginTag">
                  <target>
                    <variableReferenceExpression name="writer"/>
                  </target>
                  <parameters>
                    <propertyReferenceExpression name="Style">
                      <typeReferenceExpression type="HtmlTextWriterTag"/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Write">
                  <target>
                    <variableReferenceExpression name="writer"/>
                  </target>
                  <parameters>
                    <primitiveExpression>
                      <xsl:attribute name="value">
                        <![CDATA[
.SPF_WebParts_AppEditorPart {margin-bottom:8px;}
.SPF_WebParts_AppEditorPart .Text {color:#000;}
.SPF_WebParts_AppEditorPart .PageList {height:250px;overflow:auto;border:solid 1px silver;background-color:#fff;padding:4px;margin-top:4px;}
.SPF_WebParts_AppEditorPart .PageList ul  {padding:0px;margin:0px;}
.SPF_WebParts_AppEditorPart .PageList ul li {list-style-type: none;padding:4px;border:solid 1px #fff;cursor:pointer;color:#000}
.SPF_WebParts_AppEditorPart .PageList ul li.Selected {background-color:#D1E6FF;border:solid 1px #84ACDD;}
.SPF_WebParts_AppEditorPart .PageList ul li:hover {background-color:#FFECB5;border:solid 1px #E5C365;}
.SPF_WebParts_AppEditorPart .Info {color:#000;margin-top:4px;border:solid 1px #000;background-color:#FFFFE1;padding:8px;min-height:30px;}
");
]]>
                      </xsl:attribute>
                    </primitiveExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="RenderEndTag">
                  <target>
                    <variableReferenceExpression name="writer"/>
                  </target>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="RegisterClientScriptBlock">
                  <target>
                    <propertyReferenceExpression name="ClientScript">
                      <propertyReferenceExpression name="Page"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <methodInvokeExpression methodName="GetType"/>
                    <primitiveExpression value="SPF_WebParts_AppEditorPart"/>
                    <primitiveExpression >
                      <xsl:attribute name="value">
                        <![CDATA[
function SPF_WebParts_AppEditorPart_Toggle(itemElem,propElem) {
    var list = itemElem.parentNode.childNodes;
    var v = document.getElementById(propElem).value = itemElem.getAttribute('value');
    var infoBox = itemElem.parentNode.parentNode.nextSibling;
    infoBox.innerHTML = itemElem.getAttribute('description');
    infoBox.style.display = '';
    for (var i = 0; i < list.length; i++)  {
        var peer = list[i];
        if (peer.className != null)
            peer.className = peer.getAttribute('value') == v ? 'Selected' : '';
    }
};
]]>
                      </xsl:attribute>
                    </primitiveExpression>
                    <primitiveExpression value="true"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddAttribute">
                  <target>
                    <variableReferenceExpression name="writer"/>
                  </target>
                  <parameters>
                    <propertyReferenceExpression name="Type">
                      <typeReferenceExpression type="HtmlTextWriterAttribute"/>
                    </propertyReferenceExpression>
                    <primitiveExpression value="text/javascript"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="RenderBeginTag">
                  <target>
                    <variableReferenceExpression name="writer"/>
                  </target>
                  <parameters>
                    <propertyReferenceExpression name="Script">
                      <typeReferenceExpression type="HtmlTextWriterTag"/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="RenderEndTag">
                  <target>
                    <variableReferenceExpression name="writer"/>
                  </target>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddAttribute">
                  <target>
                    <variableReferenceExpression name="writer"/>
                  </target>
                  <parameters>
                    <propertyReferenceExpression name="Class">
                      <typeReferenceExpression type="HtmlTextWriterAttribute"/>
                    </propertyReferenceExpression>
                    <primitiveExpression value="SPF_WebParts_AppEditorPart"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="RenderBeginTag">
                  <target>
                    <variableReferenceExpression name="writer"/>
                  </target>
                  <parameters>
                    <propertyReferenceExpression name="Div">
                      <typeReferenceExpression type="HtmlTextWriterTag"/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="Length">
                        <propertyReferenceExpression name="Pages">
                          <typeReferenceExpression type="AppPage"/>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Write">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Application pages were not found."/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                  <falseStatements>
                    <variableDeclarationStatement type="AppPage" name="selectedPage">
                      <init>
                        <methodInvokeExpression methodName="Find">
                          <target>
                            <typeReferenceExpression type="AppPage"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="ApplicationPage"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="selectedPage"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AddAttribute">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Class">
                              <typeReferenceExpression type="HtmlTextWriterAttribute"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="Text"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="RenderBeginTag">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Div">
                              <typeReferenceExpression type="HtmlTextWriterTag"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="Write">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="Logical page &lt;b&gt;"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="WriteEncodedText">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Path">
                              <variableReferenceExpression name="selectedPage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="Write">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="&lt;/b&gt; is selected. "/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="WriteEncodedText">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Description">
                              <variableReferenceExpression name="selectedPage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="Write">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <primitiveExpression>
                              <xsl:attribute name="value"><![CDATA[ <a href="javascript:" onclick="this.parentNode.nextSibling.style.display='';this.parentNode.style.display='none';return false;">Click here to change the page.</a>]]></xsl:attribute>
                            </primitiveExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="RenderEndTag">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>

                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="selectedPage"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AddStyleAttribute">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="display"/>
                            <primitiveExpression value="none"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="RenderBeginTag">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Div">
                          <typeReferenceExpression type="HtmlTextWriterTag"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Write">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Please select a logical page."/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AddAttribute">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Class">
                          <typeReferenceExpression type="HtmlTextWriterAttribute"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="PageList"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="RenderBeginTag">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Div">
                          <typeReferenceExpression type="HtmlTextWriterTag"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="RenderBeginTag">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Ul">
                          <typeReferenceExpression type="HtmlTextWriterTag"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <foreachStatement>
                      <variable type="AppPage" name="page"/>
                      <target>
                        <propertyReferenceExpression name="Pages">
                          <typeReferenceExpression type="AppPage"/>
                        </propertyReferenceExpression>
                      </target>
                      <statements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="IdentityEquality">
                              <variableReferenceExpression name="page"/>
                              <variableReferenceExpression name="selectedPage"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodInvokeExpression methodName="AddAttribute">
                              <target>
                                <variableReferenceExpression name="writer"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="Class">
                                  <typeReferenceExpression type="HtmlTextWriterAttribute"/>
                                </propertyReferenceExpression>
                                <primitiveExpression value="Selected"/>
                              </parameters>
                            </methodInvokeExpression>
                          </trueStatements>
                        </conditionStatement>
                        <methodInvokeExpression methodName="AddAttribute">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Onclick">
                              <typeReferenceExpression type="HtmlTextWriterAttribute"/>
                            </propertyReferenceExpression>
                            <stringFormatExpression format="SPF_WebParts_AppEditorPart_Toggle(this, '{{0}}')">
                              <propertyReferenceExpression name="ClientID">
                                <fieldReferenceExpression name="hidden"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="page"/>
                              </propertyReferenceExpression>
                            </stringFormatExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AddAttribute">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="value"/>
                            <propertyReferenceExpression name="Name">
                              <variableReferenceExpression name="page"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AddAttribute">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="description"/>
                            <propertyReferenceExpression name="Description">
                              <variableReferenceExpression name="page"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression  methodName="RenderBeginTag">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Li">
                              <typeReferenceExpression type="HtmlTextWriterTag"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="WriteEncodedText">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Path">
                              <variableReferenceExpression name="page"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="RenderEndTag">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                        </methodInvokeExpression>
                      </statements>
                    </foreachStatement>
                    <methodInvokeExpression methodName="RenderEndTag">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AddStyleAttribute">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Height">
                          <typeReferenceExpression type="HtmlTextWriterStyle"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="4px"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="RenderBeginTag">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Div">
                          <typeReferenceExpression type="HtmlTextWriterTag"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="RenderEndTag">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="RenderEndTag">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                    </methodInvokeExpression>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityEquality">
                          <variableReferenceExpression name="selectedPage"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AddStyleAttribute">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Display">
                              <typeReferenceExpression type="HtmlTextWriterStyle"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="none"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="AddAttribute">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Class">
                          <typeReferenceExpression type="HtmlTextWriterAttribute"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="Info"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="RenderBeginTag">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Div">
                          <typeReferenceExpression type="HtmlTextWriterTag"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="selectedPage"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="WriteEncodedText">
                          <target>
                            <variableReferenceExpression name="writer"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Description">
                              <variableReferenceExpression name="selectedPage"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="RenderEndTag">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="RenderEndTag">
                      <target>
                        <variableReferenceExpression name="writer"/>
                      </target>
                    </methodInvokeExpression>
                  </falseStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="Close">
                  <target>
                    <variableReferenceExpression name="writer"/>
                  </target>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <objectCreateExpression type="LiteralControl">
                      <parameters>
                        <methodInvokeExpression methodName="ToString">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                        </methodInvokeExpression>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
