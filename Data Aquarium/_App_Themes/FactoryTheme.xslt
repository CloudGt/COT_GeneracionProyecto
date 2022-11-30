<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
    xmlns:csharp="urn:csharp-utilities"
>
	<xsl:output method="text" indent="yes"/>
	<xsl:param name="Theme"/>
	<xsl:param name="Namespace"/>

	<msxsl:script language="C#" implements-prefix="csharp">
		public string GenerateGuid() {
		return Guid.NewGuid().ToString();
		}
	</msxsl:script>

	<xsl:template match="*">
		<xsl:text>/*

Do not modify this file (~/App_Themes/</xsl:text>
		<xsl:value-of select="$Namespace"/>
		<xsl:text>/_Theme.css) since all changes will be lost.
Place new CSS rules in a separate stylesheet and save it to ~/App_Themes/</xsl:text>
		<xsl:value-of select="$Namespace"/>
		<xsl:text> folder.

*/
		
@import url(../</xsl:text>
		<xsl:value-of select="$Theme"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$Theme"/>
		<xsl:text>.css);

@import url(../../css/sys/bootstrap.min.css);
</xsl:text>
	</xsl:template>

</xsl:stylesheet>
