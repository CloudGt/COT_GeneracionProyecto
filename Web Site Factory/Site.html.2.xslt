<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium" xmlns:asp="urn:asp.net" xmlns:aquarium="urn:data-aquarium"
                xmlns:act="urn:ajax-control-toolkit"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project" exclude-result-prefixes="codedom msxsl c asp aquarium act a">
  <xsl:output method="html"/>
  <xsl:param name="Namespace"/>
  <xsl:param name="MembershipEnabled" select="'false'"/>
  <xsl:param name="PageHeader"/>
  <xsl:param name="Copyright"/>
  <xsl:param name="ScriptOnly" select="'false'"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Site</title>
      </head>
      <body>
        <xsl:if test="$MembershipEnabled='true' or /a:project/a:membership[@windowsAuthentication='true' or @customSecurity='true' or @activeDirectory='true']">
          <div data-role="placeholder" data-placeholder="membership-bar">
            <xsl:if test="/a:project/a:membership[@displayRememberMe='false']">
              <xsl:attribute name="data-display-remember-me">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="/a:project/a:membership/@rememberMeSet='true'">
              <xsl:attribute name="data-remember-me-set">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="/a:project/a:membership/@displayPasswordRecovery='false'">
              <xsl:attribute name="data-display-password-recovery">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="/a:project/a:membership/@displaySignUp='false'">
              <xsl:attribute name="data-display-sign-up">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="/a:project/a:membership[@displayMyAccount='false']">
              <xsl:attribute name="data-display-my-account">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="/a:project/a:membership/@displayHelp='false'">
              <xsl:attribute name="data-display-help">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="/a:project/a:membership[@dedicatedLogin='true' or @windowsAuthentication='true']">
              <xsl:attribute name="data-display-login">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="/a:project/a:membership/@idleUserDetectionTimeout>0">
              <xsl:attribute name="data-idle-user-timeout">
                <xsl:value-of select="/a:project/a:membership/@idleUserDetectionTimeout"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="/a:project/a:features/@enableHistory='true'">
              <xsl:attribute name="data-enable-history">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="/a:project/a:features/@enablePermalinks='true'">
              <xsl:attribute name="data-enable-permalinks">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:text> </xsl:text>
          </div>
        </xsl:if>
        <div id="PageHeader">
          <div id="PageHeaderBar">
            <div data-role="placeholder" data-placeholder="page-header">
              <xsl:choose>
                <xsl:when test="string-length($PageHeader)=0">
                  <xsl:value-of select="/a:project/@prettyName"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$PageHeader" disable-output-escaping="yes"/>
                </xsl:otherwise>
              </xsl:choose>
            </div>
          </div>
          <div data-role="placeholder" data-placeholder="menu-bar" class="PageMenuBar" data-hover-style="Auto" data-popup-position="Left" data-show-site-actions="true">
            <xsl:if test="/a:project/a:layout/@menuStyle!='MultiLevel'">
              <xsl:attribute name="data-presentation-style">
                <xsl:value-of select="/a:project/a:layout/@menuStyle"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:text> </xsl:text>
          </div>
        </div>
        <table id="PageBody">
          <tr>
            <td id="PageHeaderSideBar">
              <img class="PageLogo" alt="logo" />
            </td>
            <td id="PageHeaderLeftSide">
              <span class="placeholder">
                <xsl:text> </xsl:text>
              </span>
            </td>
            <td id="PageHeaderContent">
              <div class="Header">
                <div data-role="placeholder" data-placeholder="site-map-path">
                  <xsl:text> </xsl:text>
                </div>
                <div class="Title">
                  <div data-role="placeholder" data-placeholder="page-title">Page Title</div>
                </div>
              </div>
            </td>
            <td id="PageHeaderRightSide">
              <span class="placeholder">
                <xsl:text> </xsl:text>
              </span>
            </td>
          </tr>
          <tr>
            <td id="PageContentSideBar">
              <div class="SideBarBody">
                <div data-role="placeholder" data-placeholder="page-side-bar">
                  <xsl:text> </xsl:text>
                </div>
                <span class="placeholder">
                  <xsl:text> </xsl:text>
                </span>
              </div>
            </td>
            <td id="PageContentLeftSide">
              <span class="placeholder">
                <xsl:text> </xsl:text>
              </span>
            </td>
            <td id="PageContent">
              <div data-role="placeholder" data-placeholder="page-content">
                <xsl:text> </xsl:text>
              </div>
            </td>
            <td id="PageContentRightSide">
              <span class="placeholder">
                <xsl:text> </xsl:text>
              </span>
            </td>
          </tr>
          <tr>
            <td id="PageFooterSideBar">
              <span class="placeholder">
                <xsl:text> </xsl:text>
              </span>
            </td>
            <td id="PageFooterLeftSide">
              <span class="placeholder">
                <xsl:text> </xsl:text>
              </span>
            </td>
            <td id="PageFooterContent">
              <span class="placeholder">
                <xsl:text> </xsl:text>
              </span>
            </td>
            <td id="PageFooterRightSide">
              <span class="placeholder">
                <xsl:text> </xsl:text>
              </span>
            </td>
          </tr>
        </table>
        <div id="PageFooterBar">
          <div data-role="placeholder" data-placeholder="page-footer">
            <xsl:choose>
              <xsl:when test="string-length($Copyright)=0">
                <xsl:text disable-output-escaping="yes">&amp;copy; </xsl:text>
                <xsl:text disable-output-escaping="yes"> 2021 </xsl:text>
                <xsl:value-of select="$Namespace"/>
                <xsl:text>. ^Copyright^All rights reserved.^Copyright^</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$Copyright" disable-output-escaping="yes"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text> </xsl:text>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
