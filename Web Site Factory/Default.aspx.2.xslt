<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium" xmlns:asp="urn:asp.net" xmlns:aquarium="urn:data-aquarium">
	<xsl:output method="html" indent="yes"/>
	<xsl:param name="Namespace"/>

	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head runat="server">
				<title></title>
			</head>
			<body>
				<form id="form1" runat="server">
					<div>
            <asp:ScriptManager ID="sm" runat="server" AjaxFrameworkMode="Disabled" ScriptMode="Release" />
					</div>
				</form>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
