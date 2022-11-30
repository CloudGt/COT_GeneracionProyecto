<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:cs="urn:schemas-xslt-csharp"
    exclude-result-prefixes="msxsl dc cs"
>
  <xsl:output method="html" standalone="yes" indent="yes" />

  <msxsl:script language="C#" implements-prefix="cs">
    <![CDATA[
    public string ToDate(string date) {
      return DateTime.Parse(date).ToString("f");
    }
  ]]>
  </msxsl:script>

  <xsl:template match="/">
    <div>
      <div style="width:360px;padding-bottom:4px;margin-bottom:0px;padding-left:4px;">
        <form style="padding:0px;margin:0px;" method="get" name="gs2" action="http://codeontime.com/search" target="_blank">
          <table cellSpacing="0" cellPadding="0">
            <tbody>
              <tr>
                <td>
                  <input style="width:234px;font-family:tahoma;font-size:8.5pt;" maxLength="2048" name="q" id="DiscussionQuery"/>
                </td>
                <td style="padding-left:4px;">
                  <input style="font-family:tahoma;font-size:8.5pt;width:60px" value="Search" type="submit" name="qt_g" onclick="var q = document.getElementById('DiscussionQuery');if(q.value.match(/^\s*$/)) {{q.focus();return false;}}"/>
                </td>
                <td style="padding-left:4px;">
                  <input style="font-family:tahoma;font-size:8.5pt;width:60px" value="Discuss" type="submit" name="qt_g" onclick="return $openUrl('http://my.codeontime.com/codeontime/topics/new')"/>
                </td>
              </tr>
            </tbody>
          </table>
        </form>
      </div>
      <div class="News">
        <xsl:apply-templates select="//item"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="item">
    <div>
      <a href="{link}" target="_blank">
        <xsl:value-of select="title"/>
      </a>
    </div>
    <!--<div style="color:black">
      <xsl:value-of select="pubDate"/>
    </div>-->
    <div style="color:gray;">
      <xsl:value-of select="cs:ToDate(dc:date)"/>
      <xsl:text> | </xsl:text>
      <xsl:value-of select="dc:creator"/>
    </div>
    <div style="margin-bottom:12px;">
      <xsl:variable name="Description" select="substring-before(description, '&lt;br&gt; &lt;p&gt;-- &lt;br&gt; You received ')"/>
      <xsl:choose>
        <xsl:when test="string-length($Description)>0">
          <xsl:value-of select="$Description" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="description" disable-output-escaping="yes"/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
</xsl:stylesheet>
