<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://schemas.microsoft.com/AspNet/SiteMap-File-1.0"
		xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl app"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="PageImplementation"/>

  <msxsl:script language="C#" implements-prefix="app">
    <![CDATA[
		private System.Collections.Generic.List<string> _pages = new System.Collections.Generic.List<string>();
		
		public string NormalizePath(string path)
		{
				path = Regex.Replace(path, @"\s+\|\s+", "|", RegexOptions.Compiled).Trim();
				return path;
		}
		public string GetPathNodeText(string path)
		{
				Match m = Regex.Match(path, @"([^\|]+)\|$", RegexOptions.Compiled);
				return m.Groups[1].Value;
		}
		public bool Reset() 
		{
				this._pages.Clear();
				return true;
		}
		public bool RegisterPage(string name) 
		{
				this._pages.Add(name);
				return true;
		}
		public bool PageIsRegistered(string name)
		{
				return this._pages.Contains(name);
		}
    
    public static string PrettyUrl(string url)
    {
        url = Regex.Replace(url, @"(\p{Ll})([\p{Lu}\d])", "$1-$2");
        return url.ToLower();
    }
    
	]]>
  </msxsl:script>

  <xsl:template match="/">
    <siteMap>
      <siteMapNode title="^SiteHome^Home^SiteHome^" description="">
        <xsl:attribute name="url">
          <xsl:choose>
            <xsl:when test="$PageImplementation='html'">
              <xsl:text>~/index.html</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>~/Default.aspx</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:for-each select="/app:application/app:pages/app:page[string-length(@path)>0]">
          <xsl:sort select="@index" data-type="number" order="ascending"/>
          <xsl:call-template name="RenderNode"/>
        </xsl:for-each>
      </siteMapNode>
    </siteMap>
  </xsl:template>

  <xsl:template name="RenderNode">
    <xsl:variable name="Path" select="concat(app:NormalizePath(@path),'|')" />
    <xsl:if test="not(app:PageIsRegistered(@name))">
      <siteMapNode title="{app:GetPathNodeText($Path)}" description="{@description}">
        <xsl:choose>
          <xsl:when test="string-length(@url)!=0">
            <xsl:if test="@url!='about:blank'">
              <xsl:attribute name="url">
                <xsl:value-of select="@url"/>
              </xsl:attribute>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="url">
              <xsl:choose>
                <xsl:when test="$PageImplementation='html'">
                  <xsl:text>~/pages/</xsl:text>
                  <xsl:value-of select="app:PrettyUrl(@name)"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>~/Pages/</xsl:text>
                  <xsl:value-of select="@name"/>
                  <xsl:text>.aspx</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="string-length(@roles)>0 and @roles!='?'">
          <xsl:attribute name="roles">
            <xsl:value-of select="@roles"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@roles='?'">
          <xsl:attribute name="public"><![CDATA[true]]></xsl:attribute>
        </xsl:if>
        <xsl:if test="string-length(@customStyle)>0">
          <xsl:attribute name="cssClass">
            <xsl:value-of select="@customStyle"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="string-length(@device)>0">
          <xsl:attribute name="device">
            <xsl:choose>
              <xsl:when test="@device='Desktop'">
                <xsl:text>desktop</xsl:text>
              </xsl:when>
              <xsl:otherwise>touch</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:if>
        <xsl:variable name="RegisterPage" select="app:RegisterPage(@name)"/>
        <xsl:variable name="Pages" select="/app:application/app:pages/app:page[starts-with(app:NormalizePath(@path), $Path)]"/>
        <!--<xsl:if test="$Pages[not(app:PageIsRegistered(@name))]">
					<siteMapNode url="~/Pages/{@name}.aspx?__" title="{app:GetPathNodeText($Path)}" description="{@path}"/>
				</xsl:if>-->
        <xsl:for-each select="$Pages">
          <xsl:sort select="@index" data-type="number" order="ascending"/>
          <xsl:call-template name="RenderNode"/>
        </xsl:for-each>

      </siteMapNode>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
