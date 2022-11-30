<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium" xmlns:asp="urn:asp.net" xmlns:aquarium="urn:data-aquarium">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
	<xsl:param name="Namespace"/>
	<xsl:param name="IsApplication" select="'false'"/>

	<xsl:template match="/">
		<!--<xsl:variable name="SelectedController">
			<xsl:for-each select="/c:dataControllerCollection/c:dataController">
				<xsl:sort select="count(c:fields/c:field)" data-type="number" order="descending"/>
				<xsl:if test="position()=1">
					<xsl:value-of select="@name"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>-->
		<xsl:choose>
			<xsl:when test="$IsApplication = 'true'">
				<asp:Content ID="Content1" ContentPlaceHolderID="PageHeaderContentPlaceHolder" runat="Server">
					Details
				</asp:Content>
				<asp:Content ID="Content2" ContentPlaceHolderID="PageContentPlaceHolder" runat="Server">
					<div id="Div1" runat="server" visible="false" />
					<aquarium:DataViewExtender ID="Extender1" runat="server" TargetControlID="Div1" FilterSource="ExtenderFilter"
							View="editForm1" ShowActionBar="false" />
					<input type="hidden" name="ExtenderFilter" id="ExtenderFilter" runat="server" />
				</asp:Content>
			</xsl:when>
			<xsl:otherwise>
				<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
				</asp:Content>
				<asp:Content ID="Content2" ContentPlaceHolderID="Header1Placeholder" runat="Server">
					<xsl:text>Details</xsl:text>
				</asp:Content>
				<asp:Content ID="Content3" ContentPlaceHolderID="Header2Placeholder" runat="Server">
					<xsl:value-of select="$Namespace"/>
				</asp:Content>
				<asp:Content ID="Content4" ContentPlaceHolderID="BodyPlaceholder" runat="Server">
					<div id="Div1" runat="server" visible="false">
					</div>
					<aquarium:DataViewExtender ID="Extender1" runat="server" TargetControlID="Div1" FilterSource="ExtenderFilter"
						View="editForm1" ShowActionBar="false" />
					<input type="hidden" name="ExtenderFilter" id="ExtenderFilter" runat="server" />
				</asp:Content>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
