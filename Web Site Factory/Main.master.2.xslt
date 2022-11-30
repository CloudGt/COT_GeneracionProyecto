<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium" xmlns:asp="urn:asp.net" xmlns:aquarium="urn:data-aquarium"
                xmlns:act="urn:ajax-control-toolkit"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project" >
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="Namespace"/>
  <xsl:param name="MembershipEnabled" select="'false'"/>
  <xsl:param name="PageHeader"/>
  <xsl:param name="Copyright"/>
  <xsl:param name="ScriptOnly" select="'false'"/>

  <xsl:template match="/">
    <!--  xmlns="http://www.w3.org/1999/xhtml" -->
    <html>
      <attributeExpression property="xml:lang">
        <propertyReferenceExpression name="IetfLanguageTag">
          <propertyReferenceExpression name="CurrentUICulture">
            <typeReferenceExpression type="System.Globalization.CultureInfo"/>
          </propertyReferenceExpression>
        </propertyReferenceExpression>
      </attributeExpression>
      <attributeExpression property="lang">
        <propertyReferenceExpression name="IetfLanguageTag">
          <propertyReferenceExpression name="CurrentUICulture">
            <typeReferenceExpression type="System.Globalization.CultureInfo"/>
          </propertyReferenceExpression>
        </propertyReferenceExpression>
      </attributeExpression>
      <head runat="server">
        <title>Main</title>
        <meta http-equiv="X-UA-COMPATIBLE" content="IE=Edge" />
        <asp:ContentPlaceHolder ID="head" runat="server">
        </asp:ContentPlaceHolder>
      </head>
      <body runat="server">
        <form id="form1" runat="server">
          <div>
            <xsl:variable name="ScriptManagerElement">
              <xsl:choose>
                <xsl:when test="$ScriptOnly='true'">
                  <xsl:text>asp:ScriptManager</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>act:ToolkitScriptManager</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:element name="{$ScriptManagerElement}">
              <xsl:attribute name="ID">
                <xsl:text>sm</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="runat">
                <xsl:text>server</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="ScriptMode">
                <xsl:text>Release</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="AjaxFrameworkMode">
                <xsl:text>Disabled</xsl:text>
              </xsl:attribute>
            </xsl:element>
            <xsl:if test="$MembershipEnabled='true' or /a:project/a:membership[@windowsAuthentication='true' or @customSecurity='true' or @activeDirectory='true']">
              <aquarium:MembershipBar ID="mb" runat="server">
                <xsl:if test="/a:project/a:membership[@displayRememberMe='false']">
                  <xsl:attribute name="DisplayRememberMe">
                    <xsl:text>False</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:membership/@rememberMeSet='true'">
                  <xsl:attribute name="RememberMeSet">
                    <xsl:text>True</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:membership/@displayPasswordRecovery='false'">
                  <xsl:attribute name="DisplayPasswordRecovery">
                    <xsl:text>False</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:membership/@displaySignUp='false'">
                  <xsl:attribute name="DisplaySignUp">
                    <xsl:text>False</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:membership[@displayMyAccount='false']">
                  <xsl:attribute name="DisplayMyAccount">
                    <xsl:text>False</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:membership/@displayHelp='false'">
                  <xsl:attribute name="DisplayHelp">
                    <xsl:text>False</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:membership[@dedicatedLogin='true' or @windowsAuthentication='true']">
                  <xsl:attribute name="DisplayLogin">
                    <xsl:text>False</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:membership/@idleUserDetectionTimeout>0">
                  <xsl:attribute name="IdleUserTimeout">
                    <xsl:value-of select="/a:project/a:membership/@idleUserDetectionTimeout"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:features/@enableHistory='true'">
                  <xsl:attribute name="EnableHistory">
                    <xsl:text>True</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:features/@enablePermalinks='true'">
                  <xsl:attribute name="EnablePermalinks">
                    <xsl:text>True</xsl:text>
                  </xsl:attribute>
                </xsl:if>
              </aquarium:MembershipBar>
            </xsl:if>
            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" ShowStartingNode="False" />
            <div id="PageHeader">
              <div id="PageHeaderBar">
                <asp:ContentPlaceHolder ID="PageHeaderContentPlaceHolder" runat="server">
                  <xsl:choose>
                    <xsl:when test="string-length($PageHeader)=0">
                      <xsl:value-of select="/a:project/@prettyName"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$PageHeader" disable-output-escaping="yes"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </asp:ContentPlaceHolder>
              </div>
              <div id="PageMenuBar" runat="server" class="PageMenuBar">
              </div>
            </div>
            <aquarium:MenuExtender ID="Menu1" runat="server" DataSourceID="SiteMapDataSource1"
								TargetControlID="PageMenuBar" HoverStyle="Auto" PopupPosition="Left" ShowSiteActions="true">
              <xsl:if test="/a:project/a:layout/@menuStyle!='MultiLevel'">
                <xsl:attribute name="PresentationStyle">
                  <xsl:value-of select="/a:project/a:layout/@menuStyle"/>
                </xsl:attribute>
              </xsl:if>
            </aquarium:MenuExtender>
            <table id="PageBody">
              <!-- page header -->
              <tr>
                <td id="PageHeaderSideBar">
                  <asp:Image ID="Image5" runat="server" SkinID="PageLogo" CssClass="PageLogo" />
                </td>
                <td id="PageHeaderLeftSide">
                  <span class="placeholder" >
                    <xsl:text> </xsl:text>
                  </span>
                </td>
                <td id="PageHeaderContent">
                  <div class="Header">
                    <asp:SiteMapPath ID="SiteMapPath1" runat="server" SkinID="SiteMapPath" />
                    <div class="Title">
                      <asp:ContentPlaceHolder ID="PageTitleContentPlaceHolder" runat="server">
                        <xsl:text>Page Title</xsl:text>
                      </asp:ContentPlaceHolder>
                    </div>
                  </div>
                </td>
                <td id="PageHeaderRightSide">
                  <span class="placeholder" >
                    <xsl:text> </xsl:text>
                  </span>
                </td>
              </tr>
              <!-- page body -->
              <tr>
                <td id="PageContentSideBar">
                  <div class="SideBarBody">
                    <asp:ContentPlaceHolder ID="SideBarPlaceHolder" runat="server" />
                    <span class="placeholder" >
                      <xsl:text> </xsl:text>
                    </span>
                  </div>
                </td>
                <td id="PageContentLeftSide">
                  <span class="placeholder" >
                    <xsl:text> </xsl:text>
                  </span>
                </td>
                <td id="PageContent">
                  <asp:ContentPlaceHolder ID="PageContentPlaceHolder" runat="server">
                  </asp:ContentPlaceHolder>
                </td>
                <td id="PageContentRightSide">
                  <span class="placeholder" >
                    <xsl:text> </xsl:text>
                  </span>
                </td>
              </tr>
              <!-- page footer -->
              <tr>
                <td id="PageFooterSideBar">
                  <span class="placeholder" >
                    <xsl:text> </xsl:text>
                  </span>
                </td>
                <td id="PageFooterLeftSide">
                  <span class="placeholder" >
                    <xsl:text> </xsl:text>
                  </span>
                </td>
                <td id="PageFooterContent">
                  <span class="placeholder" >
                    <xsl:text> </xsl:text>
                  </span>
                </td>
                <td id="PageFooterRightSide">
                  <span class="placeholder" >
                    <xsl:text> </xsl:text>
                  </span>
                </td>
              </tr>
            </table>
            <div id="PageFooterBar">
              <asp:ContentPlaceHolder ID="PageFooterContentPlaceHolder" runat="server">
                <xsl:choose>
                  <xsl:when test="string-length($Copyright)=0">
                    <xsl:text disable-output-escaping="yes">&amp;copy; </xsl:text>
                    <xsl:text disable-output-escaping="yes"> 2022 </xsl:text>
                    <xsl:value-of select="a:project/a:namespace"/>
                    <xsl:text>. ^Copyright^All rights reserved.^Copyright^</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$Copyright" disable-output-escaping="yes"/>
                  </xsl:otherwise>
                </xsl:choose>
              </asp:ContentPlaceHolder>
            </div>
          </div>
        </form>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
