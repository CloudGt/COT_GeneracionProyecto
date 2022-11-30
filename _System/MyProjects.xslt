<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:p="http://www.codeontime.com/2008/code-generator"
    extension-element-prefixes="p"
>
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="Library"/>

  <xsl:template match="/">
    <xsl:variable name="Projects" select="p:projects/p:project"/>
    <xsl:variable name="Groups" select="$Projects/@group[not(.=preceding::*/@group)]"/>
    <div>
      <div>
        <xsl:text disable-output-escaping="yes"><![CDATA[
        This is the list of the projects that you have created. Click on the project name to run, design, develop, publish, and more.
        Project <a href="#" id="ShowBackups" title="Open the folder with backups.">backup</a> is performed prior to each code generation session automatically.]]></xsl:text>
      </div>
      <table class="MyProjects" cellpadding="0" cellspacing="0">
        <xsl:if test="count($Projects) >= 10">
          <!-- show top 5 last used -->
          <tr>
            <td colspan="3" style="padding-top:8px;padding-bottom:4px;font-weight:bold;border-top-width:0">Recent Projects</td>
          </tr>
          <tr>
            <th align="right" class="PojectNumber">#</th>
            <th align="left" class="ProjectTitle">Project Name</th>
            <th align="left">Last Modified</th>
          </tr>
          <xsl:for-each select="$Projects">
            <xsl:sort data-type="text" order="descending" select="@modified"/>
            <xsl:if test="position() &lt;= 5">
              <xsl:call-template name="RenderProjectInfo">
                <xsl:with-param name="ShowCurrent" select="'false'"/>
              </xsl:call-template>
            </xsl:if>
          </xsl:for-each>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="count($Groups)>1">
            <xsl:for-each select="$Groups[.!='']">
              <xsl:sort select="."/>
              <xsl:variable name="CurrentGroup" select="."/>
              <tr>
                <td colspan="3" >
                  <xsl:attribute name="style">
                    <xsl:text>padding-top:8px;padding-bottom:4px;</xsl:text>
                    <xsl:if test="position()=1 and count($Projects)&lt;10">
                      <xsl:text>border-top-width:0</xsl:text>
                    </xsl:if>
                  </xsl:attribute>
                  <b>
                    <xsl:value-of select="$CurrentGroup"/>
                  </b>
                </td>
              </tr>
              <tr>
                <th align="right" class="PojectNumber">#</th>
                <th align="left" class="ProjectTitle">Project Name</th>
                <th align="left">Last Modified</th>
              </tr>
              <xsl:for-each select="$Projects[@group=$CurrentGroup]">
                <xsl:sort data-type="text" order="ascending" select="@displayName"/>
                <xsl:call-template name="RenderProjectInfo"/>
              </xsl:for-each>
            </xsl:for-each>
            <tr>
              <td colspan="3" style="padding-top:8px;padding-bottom:4px;font-weight:bold">Other</td>
            </tr>
            <tr>
              <th align="right" class="PojectNumber">#</th>
              <th align="left" class="ProjectTitle">Project Name</th>
              <th align="left">Last Modified</th>
            </tr>
            <xsl:for-each select="$Projects[@group='']">
              <xsl:sort data-type="text" order="ascending" select="@displayName"/>
              <xsl:call-template name="RenderProjectInfo"/>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="count($Projects) >= 10">
              <tr>
                <td colspan="3" style="padding-top:8px;padding-bottom:4px;font-weight:bold;border-top-width:0">All Projects</td>
              </tr>
            </xsl:if>
            <tr>
              <th align="right" class="PojectNumber">#</th>
              <th align="left" class="ProjectTitle">Project Name</th>
              <th align="left">Last Modified</th>
            </tr>
            <xsl:for-each select="$Projects">
              <xsl:sort data-type="text" order="ascending" select="@displayName"/>
              <xsl:call-template name="RenderProjectInfo"/>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </table>
    </div>
  </xsl:template>

  <xsl:template name="RenderProjectInfo">
    <xsl:param name="ShowCurrent" select="'true'"/>
    <tr>
      <td align="right">
        <xsl:value-of select="position()"/>
        <xsl:text>.</xsl:text>
      </td>
      <td class="Title ProjectTitle" >
        <a href="#" onclick="ProjectAction('{@type}', '{@name}', '{@projectLocationJS}');return false;" class="{@cssClass}">
          <xsl:attribute name="title">
            <xsl:text>Select</xsl:text>
          </xsl:attribute>
          <div>
            <xsl:attribute name="class">
              <xsl:value-of select="@cssClass"/>
              <xsl:if test="@current='true' and $ShowCurrent='true'">
                <xsl:text> Current</xsl:text>
              </xsl:if>
            </xsl:attribute>
            <span class="outer">
              <span class="inner">
                <xsl:value-of select="@displayName"/>
              </span>
            </span>
          </div>
        </a>
      </td>
      <td>
        <xsl:value-of select="@modifiedInfo"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template name="AddRowHoverUnhover">
    <xsl:attribute name="onmouseover">
      <xsl:text>this.parentNode.parentNode.className = 'Highlight'</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="onmouseout">
      <xsl:text>this.parentNode.parentNode.className = ''</xsl:text>
    </xsl:attribute>
  </xsl:template>
</xsl:stylesheet>
