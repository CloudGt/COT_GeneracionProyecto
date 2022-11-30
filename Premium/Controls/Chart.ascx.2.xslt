<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium"
    xmlns:asp="urn:asp.net" xmlns:aquarium="urn:data-aquarium"
    xmlns:factory="urn:codeontime:app-factory" exclude-result-prefixes="app factory c">
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="Namespace"/>
  <xsl:param name="Name"/>

  <xsl:template match="c:view">
    <xsl:variable name="XValue" select="c:dataFields/c:dataField[starts-with(@chart,'XValue')]"/>
    <xsl:variable name="YValueMembers" select="c:dataFields/c:dataField[@chart!='' and @fieldName!=$XValue/@fieldName]"/>
    <xsl:choose>
      <xsl:when test="$YValueMembers[1][@chart='Bar' or @chart='Custom' or @chart='Bar-Cylinder']">
        <xsl:call-template name="GenerateBarChart">
          <xsl:with-param name="XValue" select="$XValue"/>
          <xsl:with-param name="YValueMembers" select="$YValueMembers"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$YValueMembers[1][@chart='Column' or @chart='Column-Cylinder']">
        <xsl:call-template name="GenerateBarChart">
          <xsl:with-param name="XValue" select="$XValue"/>
          <xsl:with-param name="YValueMembers" select="$YValueMembers"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$YValueMembers[1][@chart='Line']">
        <xsl:call-template name="GenerateBarChart">
          <xsl:with-param name="XValue" select="$XValue"/>
          <xsl:with-param name="YValueMembers" select="$YValueMembers"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$YValueMembers[1][@chart='Spline']">
        <xsl:call-template name="GenerateBarChart">
          <xsl:with-param name="XValue" select="$XValue"/>
          <xsl:with-param name="YValueMembers" select="$YValueMembers"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
    <aquarium:ControllerDataSource ID="ControllerDataSource1" runat="server" DataController="{ancestor::c:dataController/@name}"
        DataView="{@id}" PageRequestParameterName="r" />
  </xsl:template>

  <xsl:template name="CreateChartType">
    <xsl:param name="DataField" select="."/>
    <xsl:attribute name="ChartType">
      <xsl:choose>
        <xsl:when test="contains($DataField/@chart, '-')">
          <xsl:value-of select="substring-before($DataField/@chart,'-')"/>
        </xsl:when>
        <xsl:when test="$DataField/@chart='Custom'">
          <xsl:text>Bar</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$DataField/@chart"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <xsl:template name="CreateLabelFormat">
    <xsl:param name="DataField" select="."/>
    <xsl:variable name="DataFormatString">
      <xsl:choose>
        <xsl:when test="$DataField/@dataFormatString!=''">
          <xsl:value-of select="$DataField/@dataFormatString"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="Field" select="ancestor::c:dataController/c:fields/c:field[@name=$DataField/@fieldName]"/>
          <xsl:if test="$Field/@dataFormatString!=''">
            <xsl:value-of select="$Field/@dataFormatString"/>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:attribute name="LabelFormat">
      <xsl:choose>
        <xsl:when test="$DataFormatString!='' and contains($DataFormatString, '{')">
          <xsl:value-of select="$DataFormatString"/>
        </xsl:when>
        <xsl:when test="$DataFormatString!=''">
          <xsl:text>{0:</xsl:text>
          <xsl:value-of select="$DataFormatString"/>
          <xsl:text>}</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <xsl:template name="CreateLegendText">
    <xsl:param name="DataField" select="."/>
    <xsl:attribute name="LegendText">
      <xsl:choose>
        <xsl:when test="$DataField/c:headerText!=''">
          <xsl:value-of select="$DataField/c:headerText"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="Field" select="ancestor::c:dataController/c:fields/c:field[@name=$DataField/@fieldName]"/>
          <xsl:choose>
            <xsl:when test="$Field/c:headerText!=''">
              <xsl:value-of select="$Field/c:headerText"/>
            </xsl:when>
            <xsl:when test="$Field/@label">
              <xsl:value-of select="$Field/@label"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$Field/@name"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <xsl:template name="GenerateBarChart">
    <xsl:param name="XValue" />
    <xsl:param name="YValueMembers" />
    <xsl:param name="LabelFormat"/>
    <asp:Chart ID="Chart1" runat="server" BackColor="211, 223, 240" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)"
    Width="412px" Height="296px" BorderlineDashStyle="Solid" BackGradientStyle="TopBottom"
    BorderWidth="2px" BorderColor="#1A3B69" DataSourceID="ControllerDataSource1">
      <Legends>
        <asp:Legend IsTextAutoFit="True" Name="Default" BackColor="Transparent"
            Font="Trebuchet MS, 8.25pt, style=Bold">
          <xsl:attribute name="Enabled">
            <xsl:choose>
              <xsl:when test="$XValue/ancestor::c:view/@legend='true'">
                <xsl:text>True</xsl:text>
              </xsl:when>
              <xsl:otherwise>False</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </asp:Legend>
      </Legends>
      <Series>
        <xsl:for-each select="$YValueMembers">
          <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
              Name="{@fieldName}" XValueMember="{$XValue/@fieldName}"
              YValuesPerPoint="4" YValueMembers="{@fieldName}">
            <xsl:call-template name="CreateChartType"/>
            <xsl:call-template name="CreateLabelFormat"/>
            <xsl:call-template name="CreateLegendText"/>
          </asp:Series>
        </xsl:for-each>
      </Series>
      <ChartAreas>
        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="Transparent"
            BackColor="64, 165, 191, 228" ShadowColor="Transparent" BackGradientStyle="TopBottom">
          <Area3DStyle Rotation="10" Perspective="10" Enable3D="True" Inclination="15" IsRightAngleAxes="False"
              WallWidth="0" IsClustered="False" />
          <AxisY LineColor="64, 64, 64, 64">
            <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold">
              <xsl:variable name="YValueField" select="ancestor::c:dataController/c:fields/c:field[@name=$YValueMembers[1]/@fieldName]"/>
              <xsl:variable name="DataFormatString">
                <xsl:choose>
                  <xsl:when test="$YValueMembers[1]/@dataFormatString!=''">
                    <xsl:value-of select="$YValueMembers[1]/@dataFormatString"/>
                  </xsl:when>
                  <xsl:when test="$YValueField/@dataFormatString!=''">
                    <xsl:value-of select="YXValueField/@dataFormatString"/>
                  </xsl:when>
                </xsl:choose>
              </xsl:variable>
              <xsl:if test="$DataFormatString!=''">
                <xsl:attribute name="Format">
                  <xsl:value-of select="$DataFormatString"/>
                </xsl:attribute>
              </xsl:if>
            </LabelStyle>
            <MajorGrid LineColor="64, 64, 64, 64" />
          </AxisY>
          <AxisX LineColor="64, 64, 64, 64">
            <LabelStyle Font="Arial, 8.25pt, style=Bold">
              <xsl:variable name="XValueField" select="ancestor::c:dataController/c:fields/c:field[@name=$XValue/@fieldName]"/>
              <xsl:variable name="DataFormatString">
                <xsl:choose>
                  <xsl:when test="$XValue/@dataFormatString!=''">
                    <xsl:value-of select="$XValue/@dataFormatString"/>
                  </xsl:when>
                  <xsl:when test="$XValueField/@dataFormatString!=''">
                    <xsl:value-of select="$XValueField/@dataFormatString"/>
                  </xsl:when>
                </xsl:choose>
              </xsl:variable>
              <xsl:if test="$DataFormatString!=''">
                <xsl:attribute name="Format">
                  <xsl:value-of select="$DataFormatString"/>
                </xsl:attribute>
              </xsl:if>
            </LabelStyle>
            <MajorGrid LineColor="64, 64, 64, 64" />
          </AxisX>
        </asp:ChartArea>
      </ChartAreas>
    </asp:Chart>
  </xsl:template>

</xsl:stylesheet>
