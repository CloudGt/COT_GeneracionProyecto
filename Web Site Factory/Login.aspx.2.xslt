<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium" xmlns:asp="urn:asp.net" xmlns:uc1="ur:custom-controls" xmlns:aquarium="urn:data-aquarium">
	<xsl:output method="html" indent="yes"/>
	<xsl:param name="Namespace"/>

	<xsl:template match="/">
		<xsl:text disable-output-escaping="yes"><![CDATA[
<%@ Register Src="Controls/Login.ascx" TagName="Login" TagPrefix="uc1" %>]]>
</xsl:text>
		<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

			<script type="text/javascript">
					<![CDATA[
        function pageLoad() {
            var inputs = document.getElementsByTagName('input');
            for (var i = 0; i < inputs.length; i++)
                if (inputs[i].id.match(/_UserName/)) {
                inputs[i].focus();
                break;
            }
        }
    ]]>
			</script>

		</asp:Content>
		<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContentPlaceHolder" runat="Server">
			Login
		</asp:Content>
		<asp:Content ID="Content3" ContentPlaceHolderID="SideBarPlaceHolder" runat="Server">
		</asp:Content>
		<asp:Content ID="Content4" ContentPlaceHolderID="PageContentPlaceHolder" runat="Server">
			<uc1:Login ID="Login1" runat="server" />
		</asp:Content>
	</xsl:template>

</xsl:stylesheet>
