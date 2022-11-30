<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium"
    xmlns:asp="urn:asp.net" xmlns:aquarium="urn:data-aquarium"
    xmlns:factory="urn:codeontime:app-factory" exclude-result-prefixes="app factory">
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="Namespace"/>
  <xsl:param name="Name"/>

  <xsl:template match="app:userControl">
    <xsl:choose>
      <xsl:when test="@generate='FirstTimeOnly' and not(app:body) or (string-length(app:body)=0)">
        <xsl:text disable-output-escaping="yes"><![CDATA[
<!-- 
    This section provides a sample markup for Desktop user inteface.
-->
]]></xsl:text>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
          <ContentTemplate>
            <div style="margin:2px;border: solid 1px silver;padding:8px;">
              <xsl:value-of select="concat(@prefix, ':', @name)"/>
            </div>
          </ContentTemplate>
        </asp:UpdatePanel>
        <xsl:text disable-output-escaping="yes"><![CDATA[
<!-- 
    This section provides a sample markup for Touch UI user interface. 
-->
]]></xsl:text>
        <div id="{@name}" data-app-role="page" data-activator="Button|{@name}">
          <p>
            Markup of <i>
              <xsl:value-of select="@name"/>
            </i> custom user control for Touch UI.
          </p>
        </div>
        <xsl:text disable-output-escaping="yes">
        <![CDATA[
<script type="text/javascript">
    (function() {
        if ($app.touch)
            $(document).one('start.app', function () {
                // The page of Touch UI application is ready to be configured
        });
    })();
</script>
]]></xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="app:body" disable-output-escaping="yes"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
