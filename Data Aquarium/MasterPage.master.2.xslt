<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:codedom="http://www.codeontime.com/2008/codedom-compiler"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:c="urn:schemas-codeontime-com:data-aquarium" xmlns:asp="urn:asp.net" xmlns:aquarium="urn:data-aquarium" xmlns:act="urn:ajax-control-toolkit" >
	<xsl:output method="html" indent="yes"/>
	<xsl:param name="Namespace"/>
	<xsl:param name="MembershipEnabled" select="'false'"/>

	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head runat="server">
				<title>Home</title>
				<style type="text/css">
					<![CDATA[input, select, textarea, button
        {
            font-family: tahoma;
            font-size: 8.5pt;
        }]]>
				</style>
				<asp:ContentPlaceHolder ID="head" runat="server">
				</asp:ContentPlaceHolder>
			</head>
			<body style="margin: 0px; background-color: DimGray; font-family: Tahoma; font-size: 8.5pt;">
				<form id="form1" runat="server">
					<div>
						<act:ToolkitScriptManager ID="sm" runat="server" ScriptMode="Release" />
						<xsl:if test="$MembershipEnabled='true'">
							<aquarium:MembershipBar ID="mb" runat="server"/>
						</xsl:if>
						<table cellpadding="0" cellspacing="0" style="width: 100%">
							<tr>
								<td style="background-color: gainsboro; border-bottom: solid 1px silver; padding: 2px;">
									<asp:Menu ID="Menu1" runat="server" DataSourceID="SiteMapDataSource1" Orientation="Horizontal">
										<StaticSelectedStyle BackColor="#FFE08A" BorderColor="#D2B47A" BorderStyle="Solid"
                        BorderWidth="1px" ForeColor="Black" />
										<StaticMenuItemStyle BorderColor="Gainsboro" BorderStyle="Solid" BorderWidth="1px"
                        Font-Names="Tahoma" Font-Size="8.5pt" ForeColor="#333333" HorizontalPadding="4px"
                        ItemSpacing="3px" VerticalPadding="2px" />
										<StaticHoverStyle BackColor="White" BorderColor="#D2B47A" BorderStyle="Solid" BorderWidth="1px"
                        ForeColor="#333333" />
									</asp:Menu>
									<asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" ShowStartingNode="False" />
								</td>
							</tr>
							<tr>
								<td style="padding: 8px;">
									<table style="border-collapse: collapse; width: 100%;">
										<tr>
											<td style="color: White; font-size: 14pt;">
												<asp:ContentPlaceHolder ID="Header1Placeholder" runat="server">
													Header1
												</asp:ContentPlaceHolder>
											</td>
											<td align="right" style="color: White; font-size: 14pt; text-transform: uppercase; padding-right: 4px;">
												<asp:ContentPlaceHolder ID="Header2Placeholder" runat="server">
													Header2
												</asp:ContentPlaceHolder>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="padding: 8px; background-color: White; height: 400px;" valign="top">
									<xsl:choose>
										<xsl:when test="$MembershipEnabled='true'">
											<asp:LoginView ID="LoginView1" runat="server">
												<AnonymousTemplate>
													<table>
														<tr>
															<td style="width: 280px">
																The content of this page is hidden from anonymous users.
																<br />
																Move mouse over the login link in the top right corner of the screen to bring up a login
																dialog.
																<br />
																<br />
																Login as <b title="User Name: user">user</b> / <b title="Password: user123%">user123%</b> or <b title="User Name: admin">
																	admin
																</b>/ <b title="Password: admin123%">admin123%</b>.
																<br />
																<br />
																Both user accounts belong to <b title="Role: Users">Users</b> role.
																<br />
																<br />
																<div style="color: red">
																	User <b title="User Name: admin">admin</b> belongs to <b title="Role: Administrators">Administrators</b> role and is able to manage users
																	and roles. Additional menu bar option <i>Membership</i> is available to administators
																	only.
																</div>
															</td>
														</tr>
													</table>
												</AnonymousTemplate>
												<LoggedInTemplate>
												</LoggedInTemplate>
											</asp:LoginView>
											<div id="BodyPlaceholderDiv" runat="server">
												<asp:ContentPlaceHolder ID="BodyPlaceholder" runat="server">
													Content
												</asp:ContentPlaceHolder>
											</div>
										</xsl:when>
										<xsl:otherwise>
											<asp:ContentPlaceHolder ID="BodyPlaceholder" runat="server">
												Content
											</asp:ContentPlaceHolder>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr>
								<td style="padding: 8px; color: White;">
									<xsl:text disable-output-escaping="yes">&amp;copy; 2015 </xsl:text>
									<xsl:value-of select="$Namespace"/>
									<xsl:text>. All rights reserved.</xsl:text>
								</td>
							</tr>
						</table>
					</div>
				</form>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
