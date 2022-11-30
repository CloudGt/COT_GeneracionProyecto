<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:l="http://www.codeontime.com/2008/code-generator"
    extension-element-prefixes="l"
>
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <div>
      <xsl:call-template name="ListProjects">
        <xsl:with-param name="ProjectType" select="'Free'"/>
      </xsl:call-template>
      <div style="margin-top:16px;  ">
        <div class="Task">
          We recommend creating <b>Web Site Factory</b> project if this is your first time
          using <b>Code On Time</b>. No additional software is required.
        </div>
        <div class="Task">
          <a href="javascript:" onclick="return $openUrl('http://codeontime.com/learn/video/getting-started/overview');" title="Learning Resources"
              target="_blank">Learn</a> to develop applications with <b>Code On Time</b>.
        </div>
        <div class="Task">
          Use free <xsl:call-template name="RenderVWDRef"/> to further customize generated projects when needed.
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="ListProjects">
    <xsl:param name="ProjectType"/>
    <div class="Heading">
      <xsl:choose>
        <xsl:when test="$ProjectType = 'Free'">New Project</xsl:when>
        <xsl:otherwise>
          <xsl:text>Subscription</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </div>
    <table class="Projects">
      <xsl:for-each select="l:library/l:project[contains(@title, 'Factory') and @display='true']">
        <xsl:sort data-type="text" order="ascending" select="@order"/>
        <tr onclick="NewProject('{@name}'); return false;" >
          <xsl:if test="position()>1 and last() != 1">
            <xsl:attribute name="class">
              <xsl:text>Divider</xsl:text>
            </xsl:attribute>
          </xsl:if>
          <td class="Title">
            <a href="#" title="Create a &quot;{@title}&quot; project" class="{@cssClass}">
              <div>
                <span class="outer">
                  <span class="inner">
                    <xsl:value-of select="@title"/>
                  </span>
                </span>
              </div>
            </a>
          </td>
          <td class="Description">
            <xsl:value-of select="@description" disable-output-escaping="yes"/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
  <xsl:template name="RenderVWDRef">
    <a href="javascript:" onclick="window.external.OpenUrl('https://www.visualstudio.com/vs/modern-web-tooling/');return false;" title="Download free Visual Studio Community">Microsoft Visual Studio Community</a>
  </xsl:template>
</xsl:stylesheet>
