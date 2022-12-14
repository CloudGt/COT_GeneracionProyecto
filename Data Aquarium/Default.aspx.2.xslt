<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium" xmlns:asp="urn:asp.net" xmlns:aquarium="urn:data-aquarium">
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="Namespace"/>

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
      <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" ToolTip="Select a data controller" Font-Names="Tahoma" Font-Size="8.5pt">
        <xsl:for-each select="/c:dataControllerCollection/c:dataController[not(@generate='false')]">
          <asp:ListItem Text="{@name}" Value="{@name}">
            <xsl:if test="@name=$SelectedController">
              <xsl:attribute name="Selected">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
          </asp:ListItem>
        </xsl:for-each>
      </asp:DropDownList>
    </asp:Content>
    <asp:Content ID="Content3" ContentPlaceHolderID="Header2Placeholder" runat="Server">
      <xsl:value-of select="$Namespace"/>
    </asp:Content>
    <asp:Content ID="Content4" ContentPlaceHolderID="BodyPlaceholder" runat="Server">
      <div id="DataViewPlaceholder1" runat="server" visible="true">
        <xsl:text>[Data View Placeholder]</xsl:text>
      </div>
      <aquarium:DataViewExtender ID="DataViewExtender1" runat="server" TargetControlID="DataViewPlaceholder1" Controller="{$SelectedController}"/>
    </asp:Content>
  </xsl:template>

</xsl:stylesheet>
