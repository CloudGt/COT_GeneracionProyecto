<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium" xmlns:asp="urn:asp.net" xmlns:aquarium="urn:data-aquarium">
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="Namespace"/>
  <xsl:variable name="LookupControllers" select="/c:dataControllerCollection/c:dataController[count(c:fields/c:field[@isPrimaryKey='true'])=1]"/>

  <xsl:template match="/">
    <xsl:variable name="SelectedController">
      <xsl:for-each select="/c:dataControllerCollection/c:dataController">
        <xsl:sort select="count(c:fields/c:field)" data-type="number" order="descending"/>
        <xsl:if test="position()=1">
          <xsl:value-of select="@name"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="Header1Placeholder" runat="Server">
      <xsl:text>Database Lookups (Replacement for asp:DropDownList)</xsl:text>
    </asp:Content>
    <asp:Content ID="Content3" ContentPlaceHolderID="Header2Placeholder" runat="Server">
      <xsl:value-of select="$Namespace"/>
    </asp:Content>
    <asp:Content ID="Content4" ContentPlaceHolderID="BodyPlaceholder" runat="Server">
      <xsl:text disable-output-escaping="yes">
                    <![CDATA[<div style="font-family: Tahoma; font-size: 9; border-bottom: solid 1px silver; padding: 4px;
                        margin-bottom: 8px;">
                        <div style="width: 700px">
                            Replace all <i>asp:DropDownList</i> and <i>asp:ListBox</i> controls that are being
                            used in your ASP.NET applications to lookup the database information with infinitely
                            scalable and efficient <b>Database Lookups for ASP.NET and AJAX</b>.</div>
                        <br />
                        <br />
                        Compare the syntax of a standard ASP.NET control
 <pre ><span style="color: blue">&lt;</span><span style="color: #a31515">asp</span><span style="color: blue">:</span><span style="color: #a31515">DropDownList </span><span style="color: red">ID</span><span style="color: blue">=&quot;ProductsLookup&quot; </span><span style="color: red">runat</span><span style="color: blue">=&quot;server&quot; </span><span style="color: red">DataSourceID</span><span style="color: blue">=&quot;ProductsDataSet1&quot;
    </span><span style="color: red">DataValueField</span><span style="color: blue">=&quot;ProductID&quot; </span><span style="color: red">DataTextField</span><span style="color: blue">=&quot;ProductName&quot; /&gt;
</span></pre>
and that of a Database Lookups for ASP.NET and AJAX
 <pre ><span style="color:blue">&lt;</span><span style="color:#a31515">aquarium</span><span style="color:blue">:</span><span style="color:#a31515">DataViewLookup </span><span style="color:red">ID</span><span style="color:blue">="ProductsLookup" </span><span style="color:red">runat</span><span style="color:blue">="server" </span><span style="color:red">DataController</span><span style="color:blue">="Products"
    </span><span style="color:red">DataValueField</span><span style="color:blue">="ProductID" </span><span style="color:red">DataTextField</span><span style="color:blue">="ProductName" /&gt;
</span></pre>
                   </div>
                    <div style="padding: 4px; font-family: Tahoma; font-size: 9;">
                        See the run-time difference below:
                    </div>
]]>
                  </xsl:text>
      <table style="width:100%;">
        <tr>
          <td valign="top" style="width:50%;">
            <xsl:call-template name="RenderLookups">
              <xsl:with-param name="StartIndex" select="0"/>
              <xsl:with-param name="EndIndex" select="count($LookupControllers) div 2"/>
            </xsl:call-template>
          </td>
          <td valign="top" style="width:50%;">
            <xsl:call-template name="RenderLookups">
              <xsl:with-param name="StartIndex" select="(count($LookupControllers) div 2) + 1"/>
            </xsl:call-template>
          </td>
        </tr>
      </table>
    </asp:Content>
  </xsl:template>

  <xsl:template name="RenderLookups">
    <xsl:param name="StartIndex" select="0"/>
    <xsl:param name="EndIndex" select="1000"/>
    <table xmlns="http://www.w3.org/1999/xhtml">
      <xsl:for-each select="$LookupControllers">
        <xsl:if test="position()>=$StartIndex and position() &lt;=$EndIndex">
          <tr>
            <td>
              <xsl:value-of select="@name"/>
              <xsl:text>:</xsl:text>
            </td>
            <td>
              <aquarium:DataViewLookup ID="{@name}Lookup" runat="server" DataController="{@name}"
                  DataValueField="{c:fields/c:field[@isPrimaryKey='true']/@name}"
                  DataTextField="{c:views/c:view[@type='Grid']//c:dataFields/c:dataField[1]/@fieldName}"
                              />
            </td>
          </tr>
        </xsl:if>
      </xsl:for-each>
    </table>
  </xsl:template>

</xsl:stylesheet>
