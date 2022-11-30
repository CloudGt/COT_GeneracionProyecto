<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler" xmlns:c="urn:schemas-codeontime-com:data-aquarium"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:asp="urn:asp.net" xmlns:act="urn:AjaxControlToolkit" xmlns:aquarium="urn:data-aquarium">
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="Namespace"/>
  <xsl:variable name="Controllers" select="/c:dataControllerCollection/c:dataController[not(@generate='false')]"/>

  <xsl:template match="/">
    <xsl:variable name="SelectedController">

      <xsl:for-each select="/c:dataControllerCollection/c:dataController[not(@generate='false')]">
        <xsl:sort select="count(c:fields/c:field)" data-type="number" order="descending"/>
        <xsl:if test="position()=1">
          <xsl:value-of select="@name"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="Header1Placeholder" runat="Server">
      <xsl:text>Master/Detail AJAX Data Controllers</xsl:text>
    </asp:Content>
    <asp:Content ID="Content3" ContentPlaceHolderID="Header2Placeholder" runat="Server">
      <xsl:value-of select="$Namespace"/>
    </asp:Content>
    <asp:Content ID="Content4" ContentPlaceHolderID="BodyPlaceholder" runat="Server">
      <act:TabContainer id="MainContainer" runat="server">
        <xsl:for-each select="$Controllers">
          <xsl:if test="position() mod 5 = 1">
            <xsl:variable name="StartIndex" select="position()"/>
            <xsl:variable name="LastInGroup">
              <xsl:choose>
                <xsl:when test="last() >= position() + 5">
                  <xsl:value-of select="$Controllers[$StartIndex+5]/@label"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$Controllers[last()]/@label"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <act:TabPanel ID="MainTab{position()}" runat="server" HeaderText="{substring(@label,1,2)}-{substring($LastInGroup,1,2)}">
              <ContentTemplate>
                <act:TabContainer id="TabContainer{position()}" runat="server">
                  <xsl:for-each select="$Controllers">
                    <xsl:if test="position()>=$StartIndex and $StartIndex + 5 > position()">
                      <xsl:variable name="Details" select="//c:dataController[c:fields/c:field[not(@readOnly='true') and c:items/@dataController=current()/@name] and not(@generate='false')]"/>
                      <act:TabPanel ID="{@name}Tab" runat="server" HeaderText="{@label}">
                        <ContentTemplate>
                          <div id="{@name}" runat="server"></div>
                          <aquarium:DataViewExtender id="{@name}Extender" runat="server" TargetControlID="{@name}" Controller="{@name}">
                            <xsl:if test="$Details">
                              <xsl:attribute name="PageSize">
                                <xsl:text>5</xsl:text>
                              </xsl:attribute>
                            </xsl:if>
                          </aquarium:DataViewExtender>
                          <xsl:if test="$Details">
                            <div style="padding-top:8px;"></div>
                            <act:TabContainer id="{@name}DetailsContainer" runat="server">
                              <xsl:variable name="Self" select="."/>
                              <xsl:for-each select="$Details">
                                <xsl:if test="3 >= position()">
                                  <act:TabPanel ID="{$Self/@name}{@name}DetailTab" runat="server" HeaderText="{@label}">
                                    <ContentTemplate>
                                      <div id="{$Self/@name}{@name}Detail" runat="server"></div>
                                      <aquarium:DataViewExtender id="{$Self/@name}{@name}Extender" runat="server" TargetControlID="{$Self/@name}{@name}Detail" Controller="{@name}" FilterSource="{$Self/@name}Extender" PageSize="5">
                                        <xsl:attribute name="FilterFields">
                                        <xsl:for-each select="c:fields/c:field[c:items/@dataController=$Self/@name and not(@generate='false')]">
                                          <xsl:if test="position()>1">
                                            <xsl:text>,</xsl:text>
                                          </xsl:if>
                                          <xsl:value-of select="@name"/>
                                        </xsl:for-each>
                                        </xsl:attribute>
                                      </aquarium:DataViewExtender>
                                    </ContentTemplate>
                                  </act:TabPanel>
                                </xsl:if>
                              </xsl:for-each>
                            </act:TabContainer>
                          </xsl:if>
                        </ContentTemplate>
                      </act:TabPanel>
                    </xsl:if>
                  </xsl:for-each>
                </act:TabContainer>
              </ContentTemplate>
            </act:TabPanel>
          </xsl:if>
        </xsl:for-each>
      </act:TabContainer>
    </asp:Content>
  </xsl:template>

</xsl:stylesheet>
