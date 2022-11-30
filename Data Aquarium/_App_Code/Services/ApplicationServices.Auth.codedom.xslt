<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:codeontime="urn:schemas-codeontime-com:ease"  exclude-result-prefixes="msxsl a codeontime"
>

	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="TargetFramework" select="a:project/@targetFramework"/>
	<xsl:param name="TargetFramework45Plus"/>
	<xsl:param name="ScriptOnly" select="a:project/a:features/a:framework/@scriptOnly"/>
	<xsl:param name="PageImplementation" select="a:project/@pageImplementation"/>
	<xsl:param name="IsUnlimited"/>
	<xsl:param name="IsPremium"/>
	<xsl:param name="Mobile"/>
	<xsl:param name="ProjectId"/>
	<xsl:param name="SiteContentTableName" select="''"/>
	<xsl:param name="SiteContentSiteContentID"/>
	<xsl:param name="SiteContentFileName"/>
	<xsl:param name="SiteContentContentType"/>
	<xsl:param name="SiteContentLength"/>
	<xsl:param name="SiteContentRoles"/>
	<xsl:param name="SiteContentUsers"/>
	<xsl:param name="SiteContentCacheProfile"/>
	<xsl:param name="SiteContentRoleExceptions"/>
	<xsl:param name="SiteContentUserExceptions"/>
	<xsl:param name="SiteContentSchedule"/>
	<xsl:param name="SiteContentScheduleExceptions"/>
	<xsl:param name="SiteContentCreatedDate"/>
	<xsl:param name="SiteContentModifiedDate"/>

	<xsl:variable name="Theme" select="a:project/a:theme/@name"/>
	<xsl:variable name="MembershipEnabled" select="a:project/a:membership/@enabled"/>
	<xsl:variable name="CustomSecurity" select="a:project/a:membership/@customSecurity"/>

	<xsl:param name="ProviderName" select="a:project/a:providerName"/>

	<msxsl:script language="C#" implements-prefix="codeontime">
		<![CDATA[
    private System.Collections.Generic.SortedDictionary<string, string> _tables = new System.Collections.Generic.SortedDictionary<string, string>();
    private System.Collections.Generic.SortedDictionary<string, System.Collections.Generic.SortedDictionary<string,string>> _columns = 
      new System.Collections.Generic.SortedDictionary<string, System.Collections.Generic.SortedDictionary<string,string>>();
    private System.Collections.Generic.SortedDictionary<string, System.Collections.Generic.List<string>> _roles = 
      new System.Collections.Generic.SortedDictionary<string, System.Collections.Generic.List<string>>();
    private System.Collections.Generic.List<string> _users = new System.Collections.Generic.List<string>();
    
    public string Initialize(string map) { 
      // initialize tables and columns
      string currentTableName = String.Empty; 
      map = "\r\n" + map;
      // |\s*column\s+(\[.+\])(?'ColumnName'\w+)\s*=\s*(?'PhysicalColumnName'.+?)
      Match m = Regex.Match(map, @"$\s*(table\s*(?'TableName'\w+)\s*=\s*(?'PhysicalTableName'.+?)\s*$)|(column\s*(\[.+?\])\s*(?'ColumnName'\w+)\s*=(?'PhysicalColumnName'.*?)\s*$)", RegexOptions.IgnoreCase | RegexOptions.Multiline);
      while (m.Success) {
        string tableName = m.Groups["TableName"].Value;
        if (!String.IsNullOrEmpty(tableName)) { 
          currentTableName = tableName.ToLower();
          _tables[currentTableName] = m.Groups["PhysicalTableName"].Value;
        }
        string columnName = m.Groups["ColumnName"].Value;
        if (!String.IsNullOrEmpty(columnName)) {
          System.Collections.Generic.SortedDictionary<string, string> columns = null;
          if (!_columns.TryGetValue(currentTableName, out columns)) {
            columns = new System.Collections.Generic.SortedDictionary<string, string>();
            _columns[currentTableName] = columns;
          } 
          columns[columnName.ToLower()] = m.Groups["PhysicalColumnName"].Value.Trim();
        }
        m = m.NextMatch();
      }
      
      // initialize role mapping
      m = Regex.Match(map, @"$\s*role\s+(?'Role'.+)\s+=\s*(?'Users'.+?)\s*(?:$)", RegexOptions.IgnoreCase | RegexOptions.Multiline);
      while (m.Success) {
        string role = m.Groups["Role"].Value;
        string userList = m.Groups["Users"].Value;
          System.Collections.Generic.List<string> users = null;
          if (!_roles.TryGetValue(role, out users)) {
            users = new System.Collections.Generic.List<string>();
            _roles[role] = users;
          }
          Match m2 = Regex.Match(userList, @"\s*(?'UserName'.+?)\s*(,|$)");
          while (m2.Success) {
             string userName = m2.Groups["UserName"].Value;
             users.Add(userName);
             if (!String.IsNullOrEmpty(userName) && !_users.Contains(userName))
                _users.Add(userName);
             
             m2 = m2.NextMatch();
          }
        
        m = m.NextMatch();
      }
      
      // return an empty string
      return String.Empty;
    }
    
    public XPathNavigator Roles() {
        StringBuilder sb = new StringBuilder();
        sb.Append("<roles>");
        foreach (string role in _roles.Keys) {
           sb.AppendFormat("<role name=\"{0}\" loweredName=\"{1}\">", role, role.ToLower());
           foreach (string user in _roles[role])
             sb.AppendFormat("<user name=\"{0}\" loweredName=\"{1}\"/>", user, user.ToLower());
           sb.Append("</role>");
        }
        sb.Append("</roles>");
        return new XPathDocument(new System.IO.StringReader(sb.ToString())).CreateNavigator().SelectSingleNode("/roles");
    }
    
    public XPathNavigator Users() {
        StringBuilder sb = new StringBuilder();
        sb.Append("<users>");
        foreach (string userName in _users) {
           sb.AppendFormat("<user name=\"{0}\" loweredName=\"{1}\"/>", userName, userName.ToLower());
        }
        sb.Append("</users>");
        return new XPathDocument(new System.IO.StringReader(sb.ToString())).CreateNavigator().SelectSingleNode("/users");
    }
    
    public XPathNavigator UserRoles(string user) {
        StringBuilder sb = new StringBuilder();
        sb.Append("<roles>");
        foreach (string role in _roles.Keys) {
          if (_roles[role].Contains(user) || _roles[role].Contains("*"))
           sb.AppendFormat("<role name=\"{0}\" loweredName=\"{1}\"/>", role, role.ToLower());
        }
        sb.Append("</roles>");
        return new XPathDocument(new System.IO.StringReader(sb.ToString())).CreateNavigator().SelectSingleNode("/roles");
    }

    public string GetTable(string table) 
    {
        table = table.ToLower();
        string result;
        if (!_tables.TryGetValue(table, out result) || String.IsNullOrEmpty(result))
          return String.Format("Table_{0}_IsNotMapped", table);
        return result;
    } 
    public string GetTableColumn(string table, string column) 
    {
        table = table.ToLower();
        column = column.ToLower();
        System.Collections.Generic.SortedDictionary<string, string> columns = null;
        if (!_columns.TryGetValue(table, out columns))
            return String.Format("Table_{0}_IsNotMapped", table);
        string result;
        if (!columns.TryGetValue(column, out result) || String.IsNullOrEmpty(result)) 
            return String.Format("Column_{0}_{1}_IsNotMapped", table, column);
        return result;
    }
    public string TranslateSql(string sql) {
      sql = Regex.Replace(sql, @"\?\?(?'Expression'[\s\S]+?)\^(?'Table'\w+)(.(?'Column'\w+))?\?\?", DoReplaceConditionals);
      sql = Regex.Replace(sql, @"\[(?'Table'\w+)(.(?'Column'\w+))?\]", DoReplaceKnownName);
      return sql;
    }
    
    public bool TableColumnIsDefined(string table, string column) {
      string columnName = GetTableColumn(table, column);
      return !columnName.Contains("_IsNotMapped");
    }
    
    private string DoReplaceConditionals(Match m) {
      string table = m.Groups["Table"].Value;
      string column = m.Groups["Column"].Value;
      string expression = m.Groups["Expression"].Value;
      if (!String.IsNullOrEmpty(column) && !GetTableColumn(table, column).EndsWith("_IsNotMapped"))
         return expression;
      return String.Empty;
    }
    
    private string DoReplaceKnownName(Match m) {
      string table = m.Groups["Table"].Value;
      string column = m.Groups["Column"].Value;    
      if (String.IsNullOrEmpty(column))
        return GetTable(table);
      return GetTableColumn(table, column);
    }
    
  public string NormalizeLineEndings(string s) {
    s = s.Trim();
    s = (s.Contains("\n") ? "\r\n" : String.Empty) + TranslateSql(s).Replace("\n", "\r\n");
    s = Regex.Replace(s, @"(\s)set\s*,s*", "$1set ");
    return Regex.Replace(s, "(\r\n){2,100}", "\r\n");
  }
  
  public string SubstringAfterLast(string s, string indexOf) {
    return s.Substring(s.LastIndexOf(indexOf) + 1);
  }
  public string SubstringBeforeLast(string s, string indexOf) {
    return s.Substring(0, s.LastIndexOf(indexOf));
  }
  
    ]]>
	</msxsl:script>


	<xsl:variable name="Namespace" select="a:project/a:namespace"/>

	<xsl:template match="/">
		<compileUnit namespace="{$Namespace}.Services">
			<imports>
				<namespaceImport name="System"/>
				<namespaceImport name="System.Collections.Generic"/>
				<namespaceImport name="System.Collections.Specialized"/>
				<namespaceImport name="System.ComponentModel"/>
				<namespaceImport name="System.Data"/>
				<namespaceImport name="System.Data.Common"/>
				<namespaceImport name="System.Configuration"/>
				<namespaceImport name="System.IO"/>
				<namespaceImport name="System.Globalization"/>
				<namespaceImport name="System.Linq"/>
				<namespaceImport name="System.Net"/>
				<namespaceImport name="System.Net.Mail"/>
				<namespaceImport name="System.Reflection"/>
				<namespaceImport name="System.Threading"/>
				<namespaceImport name="System.Security.Principal"/>
				<namespaceImport name="System.Text"/>
				<namespaceImport name="System.Text.RegularExpressions"/>
				<namespaceImport name="System.Web"/>
				<namespaceImport name="System.Web.Caching"/>
				<namespaceImport name="System.Web.UI"/>
				<namespaceImport name="System.Web.UI.HtmlControls"/>
				<namespaceImport name="System.Web.Security"/>
				<namespaceImport name="System.Web.SessionState"/>
				<namespaceImport name="System.Web.Configuration"/>
				<namespaceImport name="System.IO.Compression"/>
				<namespaceImport name="System.Xml.XPath"/>
				<xsl:if test="$TargetFramework != '3.5'">
					<namespaceImport name="System.Web.Routing"/>
					<namespaceImport name="System.Drawing"/>
					<namespaceImport name="System.Drawing.Imaging"/>
				</xsl:if>
				<namespaceImport name="System.Security.Cryptography"/>
				<namespaceImport name="Newtonsoft.Json"/>
				<namespaceImport name="Newtonsoft.Json.Linq"/>
				<namespaceImport name="{$Namespace}.Data"/>
				<namespaceImport name="{$Namespace}.Handlers"/>
				<namespaceImport name="{$Namespace}.Services.Rest"/>
				<namespaceImport name="{$Namespace}.Web"/>
			</imports>
			<types>
				<!-- class UserTicket-->
				<typeDeclaration name="UserTicket">
					<members>
						<memberField type="System.String" name="UserName">
							<attributes public="true"/>
							<customAttributes>
								<customAttribute name="JsonProperty">
									<arguments>
										<primitiveExpression value="name"/>
									</arguments>
								</customAttribute>
							</customAttributes>
						</memberField>
						<memberField type="System.String" name="Email">
							<attributes public="true"/>
							<customAttributes>
								<customAttribute name="JsonProperty">
									<arguments>
										<primitiveExpression value="email"/>
									</arguments>
								</customAttribute>
							</customAttributes>
						</memberField>
						<memberField type="System.String" name="AccessToken">
							<attributes public="true"/>
							<customAttributes>
								<customAttribute name="JsonProperty">
									<arguments>
										<primitiveExpression value="access_token"/>
									</arguments>
								</customAttribute>
							</customAttributes>
						</memberField>
						<memberField type="System.String" name="RefreshToken">
							<attributes public="true"/>
							<customAttributes>
								<customAttribute name="JsonProperty">
									<arguments>
										<primitiveExpression value="refresh_token"/>
									</arguments>
								</customAttribute>
							</customAttributes>
						</memberField>
						<memberField type="System.String" name="Picture">
							<attributes public="true"/>
							<customAttributes>
								<customAttribute name="JsonProperty">
									<arguments>
										<primitiveExpression value="picture"/>
									</arguments>
								</customAttribute>
							</customAttributes>
						</memberField>
						<memberField type="Dictionary" name="Claims">
							<typeArguments>
								<typeReference type="System.String"/>
								<typeReference type="System.String"/>
							</typeArguments>
							<customAttributes>
								<customAttribute name="JsonProperty">
									<arguments>
										<primitiveExpression value="claims"/>
									</arguments>
								</customAttribute>
							</customAttributes>
							<init>
								<objectCreateExpression type="Dictionary">
									<typeArguments>
										<typeReference type="System.String"/>
										<typeReference type="System.String"/>
									</typeArguments>
								</objectCreateExpression>
							</init>
							<attributes public="true"/>
						</memberField>
						<constructor>
							<attributes public="true"/>
						</constructor>
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="MembershipUser" name="user"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="UserName"/>
									<propertyReferenceExpression name="UserName">
										<variableReferenceExpression name="user"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Email"/>
									<propertyReferenceExpression name="Email">
										<variableReferenceExpression name="user"/>
									</propertyReferenceExpression>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="Picture"/>
									<methodInvokeExpression methodName="UserPictureString">
										<target>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="ApplicationServices"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<variableReferenceExpression name="user"/>
										</parameters>
									</methodInvokeExpression>
								</assignStatement>
							</statements>
						</constructor>
						<constructor>
							<attributes public="true"/>
							<parameters>
								<parameter type="MembershipUser" name="user"/>
								<parameter type="System.String" name="accessToken"/>
								<parameter type="System.String" name="refreshToken"/>
							</parameters>
							<chainedConstructorArgs>
								<variableReferenceExpression name="user"/>
							</chainedConstructorArgs>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="AccessToken">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="accessToken"/>
								</assignStatement>
								<assignStatement>
									<propertyReferenceExpression name="RefreshToken">
										<thisReferenceExpression/>
									</propertyReferenceExpression>
									<variableReferenceExpression name="refreshToken"/>
								</assignStatement>
							</statements>
						</constructor>
					</members>
				</typeDeclaration>
				<!-- class ApplicationServicesBase-->
				<typeDeclaration name="ApplicationServicesBase" isPartial="true">
					<members>
						<!-- method GetAccessTokenDuration(MembershipUser) -->
						<memberMethod returnType="System.Int32" name="GetAccessTokenDuration">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="fromSettings"/>
							</parameters>
							<statements>
								<comment>15 minutes </comment>
								<variableDeclarationStatement type="System.Int32" name="accessDuration">
									<init>
										<primitiveExpression value="15"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="JToken" name="jTimeout">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<argumentReferenceExpression name="fromSettings"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="jTimeout"/>
											<methodInvokeExpression methodName="TryGetJsonProperty">
												<parameters>
													<propertyReferenceExpression name="DefaultSettings"/>
													<argumentReferenceExpression  name="fromSettings"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="jTimeout"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="accessDuration"/>
													<castExpression targetType="System.Int32">
														<variableReferenceExpression name="jTimeout"/>
													</castExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="accessDuration"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method GetRefreshTokenDuration(MembershipUser) -->
						<memberMethod returnType="System.Int32" name="GetRefreshTokenDuration">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="fromSettings"/>
							</parameters>
							<statements>
								<comment>60 minutes x 24 hours x 7 days = 10080 minutes</comment>
								<variableDeclarationStatement name="refreshDuration">
									<init>
										<binaryOperatorExpression operator="Multiply">
											<binaryOperatorExpression operator="Multiply">
												<primitiveExpression value="60"/>
												<primitiveExpression value="24"/>
											</binaryOperatorExpression>
											<primitiveExpression value="7"/>
										</binaryOperatorExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement type="JToken" name="jTimeout">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<argumentReferenceExpression name="fromSettings"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="jTimeout"/>
											<methodInvokeExpression methodName="TryGetJsonProperty">
												<parameters>
													<propertyReferenceExpression name="DefaultSettings"/>
													<argumentReferenceExpression  name="fromSettings"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="jTimeout"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<variableReferenceExpression name="refreshDuration"/>
													<castExpression targetType="System.Int32">
														<variableReferenceExpression name="jTimeout"/>
													</castExpression>
												</assignStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="refreshDuration"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateTicket(MembershipUser, string) -->
						<memberMethod returnType="UserTicket" name="CreateTicket">
							<attributes public="true"/>
							<parameters>
								<parameter type="MembershipUser" name="user"/>
								<parameter type="System.String" name="refreshToken"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="CreateTicket">
										<parameters>
											<argumentReferenceExpression name="user"/>
											<argumentReferenceExpression name="refreshToken"/>
											<primitiveExpression value="membership.accountManager.accessTokenDuration"/>
											<primitiveExpression value="membership.accountManager.refreshTokenDuration"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateTicket(MembershipUser, string, string, string) -->
						<memberMethod returnType="UserTicket" name="CreateTicket">
							<attributes public="true"/>
							<parameters>
								<parameter type="MembershipUser" name="user"/>
								<parameter type="System.String" name="refreshToken"/>
								<parameter type="System.String" name="accessTokenDuration"/>
								<parameter type="System.String" name="refreshTokenDuration"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="CreateTicket">
										<parameters>
											<argumentReferenceExpression name="user"/>
											<argumentReferenceExpression name="refreshToken"/>
											<methodInvokeExpression methodName="GetAccessTokenDuration">
												<parameters>
													<variableReferenceExpression name="accessTokenDuration"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="GetRefreshTokenDuration">
												<parameters>
													<variableReferenceExpression name="refreshTokenDuration"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateTicket(MembershipUser, string, int, int) -->
						<memberMethod returnType="UserTicket" name="CreateTicket">
							<attributes public="true"/>
							<parameters>
								<parameter type="MembershipUser" name="user"/>
								<parameter type="System.String" name="refreshToken"/>
								<parameter type="System.Int32" name="accessTokenDuration"/>
								<parameter type="System.Int32" name="refreshTokenDuration"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="System.String" name="userData">
									<init>
										<stringEmptyExpression/>
									</init>
								</variableDeclarationStatement>
								<xsl:if test="$TargetFramework!='3.5' and ($MembershipEnabled='true' or $CustomSecurity='true')">
									<variableDeclarationStatement type="OAuthHandler" name="handler">
										<init>
											<methodInvokeExpression methodName="GetActiveHandler">
												<target>
													<typeReferenceExpression type="OAuthHandlerFactory"/>
												</target>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="handler"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="userData"/>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="OAUTH:"/>
													<methodInvokeExpression methodName="GetHandlerName">
														<target>
															<variableReferenceExpression name="handler"/>
														</target>
													</methodInvokeExpression>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
								<variableDeclarationStatement type="FormsAuthenticationTicket" name="accessTicket">
									<init>
										<objectCreateExpression type="FormsAuthenticationTicket">
											<parameters>
												<primitiveExpression value="1"/>
												<propertyReferenceExpression name="UserName">
													<variableReferenceExpression name="user"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="Now">
													<typeReferenceExpression type="DateTime"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="AddMinutes">
													<target>
														<propertyReferenceExpression name="Now">
															<typeReferenceExpression type="DateTime"/>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<variableReferenceExpression name="accessTokenDuration"/>
													</parameters>
												</methodInvokeExpression>
												<primitiveExpression value="false"/>
												<variableReferenceExpression name="userData"/>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="refreshToken"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement type="FormsAuthenticationTicket" name="refreshTicket">
											<init>
												<objectCreateExpression type="FormsAuthenticationTicket">
													<parameters>
														<primitiveExpression value="1"/>
														<propertyReferenceExpression name="UserName">
															<variableReferenceExpression name="user"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="Now">
															<typeReferenceExpression type="DateTime"/>
														</propertyReferenceExpression>
														<methodInvokeExpression methodName="AddMinutes">
															<target>
																<propertyReferenceExpression name="Now">
																	<typeReferenceExpression type="DateTime"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<variableReferenceExpression name="refreshTokenDuration"/>
															</parameters>
														</methodInvokeExpression>
														<primitiveExpression value="false"/>
														<primitiveExpression value="REFRESHONLY"/>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<variableReferenceExpression name="refreshToken"/>
											<methodInvokeExpression methodName="Encrypt">
												<target>
													<typeReferenceExpression type="FormsAuthentication"/>
												</target>
												<parameters>
													<variableReferenceExpression name="refreshTicket"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<objectCreateExpression type="UserTicket">
										<parameters>
											<variableReferenceExpression name="user"/>
											<methodInvokeExpression methodName="Encrypt">
												<target>
													<typeReferenceExpression type="FormsAuthentication"/>
												</target>
												<parameters>
													<variableReferenceExpression name="accessTicket"/>
												</parameters>
											</methodInvokeExpression>
											<variableReferenceExpression name="refreshToken"/>
										</parameters>
									</objectCreateExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ValidateTicket(ticket)-->
						<memberMethod returnType="System.Boolean" name="ValidateTicket">
							<attributes public="true"/>
							<parameters>
								<parameter type="FormsAuthenticationTicket" name="ticket"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<unaryOperatorExpression operator="Not">
										<binaryOperatorExpression operator="BooleanOr">
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="ticket"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<binaryOperatorExpression operator="BooleanOr">
												<propertyReferenceExpression name="Expired">
													<variableReferenceExpression name="ticket"/>
												</propertyReferenceExpression>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<propertyReferenceExpression name="Name">
														<variableReferenceExpression name="ticket"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</unaryOperatorExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method InvalidateTicket(ticket)-->
						<memberMethod name="InvalidateTicket">
							<attributes public="true"/>
							<parameters>
								<parameter type="FormsAuthenticationTicket" name="ticket"/>
							</parameters>
							<statements>
							</statements>
						</memberMethod>
						<!-- method ValidateToken(string accessToken)-->
						<memberMethod returnType="System.Boolean" name="ValidateToken">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="accessToken"/>
							</parameters>
							<statements>
								<tryStatement>
									<statements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<methodInvokeExpression methodName="AccessTokenToSelfEncryptedToken">
														<target>
															<typeReferenceExpression type="RESTfulResource"/>
														</target>
														<parameters>
															<argumentReferenceExpression name="accessToken"/>
															<directionExpression direction="Out">
																<argumentReferenceExpression name="accessToken"/>
															</directionExpression>
														</parameters>
													</methodInvokeExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="false"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement type="FormsAuthenticationTicket" name="ticket">
											<init>
												<methodInvokeExpression methodName="Decrypt">
													<target>
														<typeReferenceExpression type="FormsAuthentication"/>
													</target>
													<parameters>
														<variableReferenceExpression name="accessToken"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="ValueEquality">
													<propertyReferenceExpression name="UserData">
														<variableReferenceExpression name="ticket"/>
													</propertyReferenceExpression>
													<primitiveExpression value="REFRESHONLY"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="false"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="ValidateTicket">
													<parameters>
														<variableReferenceExpression name="ticket"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<propertyReferenceExpression name="User">
														<propertyReferenceExpression name="Current">
															<propertyReferenceExpression name="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
													<objectCreateExpression type="RolePrincipal">
														<parameters>
															<objectCreateExpression type="FormsIdentity">
																<parameters>
																	<objectCreateExpression type="FormsAuthenticationTicket">
																		<parameters>
																			<propertyReferenceExpression name="Name">
																				<variableReferenceExpression name="ticket"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="false"/>
																			<primitiveExpression value="0"/>
																		</parameters>
																	</objectCreateExpression>
																</parameters>
															</objectCreateExpression>
														</parameters>
													</objectCreateExpression>
												</assignStatement>
												<methodReturnStatement>
													<primitiveExpression value="true"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</statements>
									<catch exceptionType="Exception"></catch>
								</tryStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method UserLogin(username password, createPersistentCookie)-->
						<memberMethod returnType="System.Boolean" name="UserLogin">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="System.String" name="password"/>
								<parameter type="System.Boolean" name="createPersistentCookie"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<convertExpression to="Boolean">
												<methodInvokeExpression methodName="SettingsProperty">
													<parameters>
														<primitiveExpression value="server.2FA.enabled"/>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
											<convertExpression to="Boolean">
												<methodInvokeExpression methodName="SettingsProperty">
													<parameters>
														<primitiveExpression value="server.2FA.disableLoginPassword"/>
														<primitiveExpression value="false"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="user">
											<init>
												<methodInvokeExpression methodName="GetUser">
													<target>
														<typeReferenceExpression type="Membership"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="username"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="IdentityEquality">
														<variableReferenceExpression name="user"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<propertyReferenceExpression name="IsLockedOut">
														<variableReferenceExpression name="user"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="false"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<variableDeclarationStatement name="userAuthData">
											<init>
												<methodInvokeExpression methodName="UserAuthenticationData">
													<parameters>
														<argumentReferenceExpression name="username"/>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="BooleanOr">
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="userAuthData"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<binaryOperatorExpression operator="IdentityEquality">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="userAuthData"/>
																</target>
																<indices>
																	<primitiveExpression value="2FA"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="ValueInequality">
														<convertExpression to="String">
															<methodInvokeExpression methodName="SettingsProperty">
																<parameters>
																	<primitiveExpression value="server.2FA.setup.mode"/>
																</parameters>
															</methodInvokeExpression>
														</convertExpression>
														<primitiveExpression value="auto"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="false"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<primitiveExpression value="true"/>
										</methodReturnStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="ValidateUser">
													<target>
														<typeReferenceExpression type="Membership"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="username"/>
														<argumentReferenceExpression name="password"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="true"/>
												</methodReturnStatement>
											</trueStatements>
											<falseStatements>
												<methodReturnStatement>
													<primitiveExpression value="false"/>
												</methodReturnStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method OtpAuthenticationDurationOfTrust() -->
						<memberMethod returnType="System.Int32" name="OtpAuthenticationDurationOfTrust">
							<attributes family="true"/>
							<statements>
								<methodReturnStatement>
									<convertExpression to="Int32">
										<methodInvokeExpression methodName="SettingsProperty">
											<parameters>
												<primitiveExpression value="server.2FA.trustThisDevice"/>
												<primitiveExpression value="180"/>
											</parameters>
										</methodInvokeExpression>
									</convertExpression>

								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method UserLogout()-->
						<memberMethod name="UserLogout">
							<attributes public="true"/>
							<statements>
								<methodInvokeExpression methodName="SignOut">
									<target>
										<typeReferenceExpression type="FormsAuthentication"/>
									</target>
								</methodInvokeExpression>
								<xsl:if test="$TargetFramework!='3.5' and ($MembershipEnabled='true' or $CustomSecurity='true')">
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="IsSiteContentEnabled">
												<typeReferenceExpression type="ApplicationServices"/>
											</propertyReferenceExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="OAuthHandler" name="handler">
												<init>
													<methodInvokeExpression methodName="GetActiveHandler">
														<target>
															<typeReferenceExpression type="OAuthHandlerFactory"/>
														</target>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="handler"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="SignOut">
														<target>
															<variableReferenceExpression name="handler"/>
														</target>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
								</xsl:if>
							</statements>
						</memberMethod>
						<!-- method UserRoles()-->
						<memberMethod returnType="System.String[]" name="UserRoles">
							<attributes public="true"/>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="GetRolesForUser">
										<target>
											<typeReferenceExpression type="Roles"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AuthenticateUser(username, password, createPersistentCookie)-->
						<memberMethod returnType="System.Object" name="AuthenticateUser">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="System.String" name="password"/>
								<parameter type="System.Nullable" name="createPersistentCookie">
									<typeArguments>
										<typeReference type="Boolean"/>
									</typeArguments>
								</parameter>
							</parameters>
							<statements>
								<variableDeclarationStatement type="HttpResponse" name="response">
									<init>
										<propertyReferenceExpression name="Response">
											<propertyReferenceExpression name="Current">
												<typeReferenceExpression type="HttpContext"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<methodInvokeExpression methodName="StartsWith">
											<target>
												<variableReferenceExpression name="password"/>
											</target>
											<parameters>
												<primitiveExpression value="token:"/>
											</parameters>
										</methodInvokeExpression>
									</condition>
									<trueStatements>
										<comment>validate token login</comment>
										<tryStatement>
											<statements>
												<variableDeclarationStatement type="System.String" name="key">
													<init>
														<methodInvokeExpression methodName="Substring">
															<target>
																<variableReferenceExpression name="password"/>
															</target>
															<parameters>
																<primitiveExpression value="6"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement type="FormsAuthenticationTicket" name="ticket">
													<init>
														<methodInvokeExpression methodName="Decrypt">
															<target>
																<typeReferenceExpression type="FormsAuthentication"/>
															</target>
															<parameters>
																<variableReferenceExpression name="key"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<methodInvokeExpression methodName="ValidateTicket">
																<parameters>
																	<variableReferenceExpression name="ticket"/>
																</parameters>
															</methodInvokeExpression>
															<binaryOperatorExpression operator="BooleanAnd">
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<propertyReferenceExpression name="UserData">
																		<variableReferenceExpression name="ticket"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
																<methodInvokeExpression methodName="IsMatch">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="UserData">
																			<variableReferenceExpression name="ticket"/>
																		</propertyReferenceExpression>
																		<primitiveExpression value="^(REFRESHONLY$|OAUTH:)"/>
																	</parameters>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement type="MembershipUser" name="user">
															<init>
																<methodInvokeExpression methodName="GetUser">
																	<target>
																		<typeReferenceExpression type="Membership"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Name">
																			<variableReferenceExpression name="ticket"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="IdentityInequality">
																		<variableReferenceExpression name="user"/>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="BooleanAnd">
																		<propertyReferenceExpression name="IsApproved">
																			<variableReferenceExpression name="user"/>
																		</propertyReferenceExpression>
																		<unaryOperatorExpression operator="Not">
																			<propertyReferenceExpression name="IsLockedOut">
																				<variableReferenceExpression name="user"/>
																			</propertyReferenceExpression>
																		</unaryOperatorExpression>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="AllowUI">
																				<target>
																					<typeReferenceExpression type="ApplicationServices"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="UserName">
																						<variableReferenceExpression name="user"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodReturnStatement>
																			<primitiveExpression value="false"/>
																		</methodReturnStatement>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="InvalidateTicket">
																	<parameters>
																		<variableReferenceExpression name="ticket"/>
																	</parameters>
																</methodInvokeExpression>
																<xsl:if test="$TargetFramework!='3.5' and ($MembershipEnabled='true' or $CustomSecurity='true')">
																	<variableDeclarationStatement type="HttpCookie" name="cookie">
																		<init>
																			<objectCreateExpression type="HttpCookie">
																				<parameters>
																					<primitiveExpression value=".PROVIDER"/>
																					<stringEmptyExpression/>
																				</parameters>
																			</objectCreateExpression>
																		</init>
																	</variableDeclarationStatement>
																	<conditionStatement>
																		<condition>
																			<binaryOperatorExpression operator="BooleanAnd">
																				<unaryOperatorExpression operator="IsNotNullOrEmpty">
																					<propertyReferenceExpression name="UserData">
																						<variableReferenceExpression name="ticket"/>
																					</propertyReferenceExpression>
																				</unaryOperatorExpression>
																				<methodInvokeExpression methodName="StartsWith">
																					<target>
																						<propertyReferenceExpression name="UserData">
																							<variableReferenceExpression name="ticket"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<primitiveExpression value="OAUTH:"/>
																					</parameters>
																				</methodInvokeExpression>
																			</binaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<variableDeclarationStatement type="OAuthHandler" name="handler">
																				<init>
																					<methodInvokeExpression methodName="Create">
																						<target>
																							<typeReferenceExpression type="OAuthHandlerFactoryBase"/>
																						</target>
																						<parameters>
																							<methodInvokeExpression methodName="Substring">
																								<target>
																									<propertyReferenceExpression name="UserData">
																										<variableReferenceExpression name="ticket"/>
																									</propertyReferenceExpression>
																								</target>
																								<parameters>
																									<primitiveExpression value="6"/>
																								</parameters>
																							</methodInvokeExpression>
																						</parameters>
																					</methodInvokeExpression>
																				</init>
																			</variableDeclarationStatement>
																			<conditionStatement>
																				<condition>
																					<binaryOperatorExpression operator="IdentityInequality">
																						<variableReferenceExpression name="handler"/>
																						<primitiveExpression value="null"/>
																					</binaryOperatorExpression>
																				</condition>
																				<trueStatements>
																					<assignStatement>
																						<propertyReferenceExpression name="Value">
																							<variableReferenceExpression name="cookie"/>
																						</propertyReferenceExpression>
																						<methodInvokeExpression methodName="GetHandlerName">
																							<target>
																								<variableReferenceExpression name="handler"/>
																							</target>
																						</methodInvokeExpression>
																					</assignStatement>
																					<conditionStatement>
																						<condition>
																							<unaryOperatorExpression operator="Not">
																								<methodInvokeExpression methodName="ValidateRefreshToken">
																									<target>
																										<variableReferenceExpression name="handler"/>
																									</target>
																									<parameters>
																										<variableReferenceExpression name="user"/>
																										<variableReferenceExpression name="key"/>
																									</parameters>
																								</methodInvokeExpression>
																							</unaryOperatorExpression>
																						</condition>
																						<trueStatements>
																							<methodReturnStatement>
																								<primitiveExpression value="false"/>
																							</methodReturnStatement>
																						</trueStatements>
																					</conditionStatement>
																				</trueStatements>
																			</conditionStatement>
																		</trueStatements>
																	</conditionStatement>
																	<conditionStatement>
																		<condition>
																			<propertyReferenceExpression name="HasValue">
																				<argumentReferenceExpression name="createPersistentCookie"/>
																			</propertyReferenceExpression>
																		</condition>
																		<trueStatements>
																			<methodInvokeExpression methodName="SetCookie">
																				<target>
																					<typeReferenceExpression type="ApplicationServices"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="cookie"/>
																				</parameters>
																			</methodInvokeExpression>
																			<methodInvokeExpression methodName="SetAuthCookie">
																				<target>
																					<typeReferenceExpression type="FormsAuthentication"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="UserName">
																						<variableReferenceExpression name="user"/>
																					</propertyReferenceExpression>
																					<propertyReferenceExpression name="Value">
																						<variableReferenceExpression name="createPersistentCookie"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</trueStatements>
																	</conditionStatement>
																</xsl:if>
																<conditionStatement>
																	<condition>
																		<propertyReferenceExpression name="HasValue">
																			<argumentReferenceExpression name="createPersistentCookie"/>
																		</propertyReferenceExpression>
																	</condition>
																	<trueStatements>
																		<methodReturnStatement>
																			<methodInvokeExpression methodName="CreateTicket">
																				<parameters>
																					<variableReferenceExpression name="user"/>
																					<variableReferenceExpression name="key"/>
																				</parameters>
																			</methodInvokeExpression>
																		</methodReturnStatement>
																	</trueStatements>
																	<falseStatements>
																		<methodReturnStatement>
																			<methodInvokeExpression methodName="CreateTicket">
																				<parameters>
																					<variableReferenceExpression name="user"/>
																					<variableReferenceExpression name="key"/>
																					<primitiveExpression value="server.rest.authorization.accessTokenDuration"/>
																					<primitiveExpression value="server.rest.authorization.refreshTokenDuration"/>
																				</parameters>
																			</methodInvokeExpression>
																		</methodReturnStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
											<catch exceptionType="Exception"/>
										</tryStatement>
									</trueStatements>
									<falseStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="IsMatch">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="password"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[;otpauth\:\w+;exec\:\w+\;]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<methodInvokeExpression methodName="OtpAuth">
														<parameters>
															<argumentReferenceExpression name="username"/>
															<argumentReferenceExpression name="password"/>
														</parameters>
													</methodInvokeExpression>
												</methodReturnStatement>
											</trueStatements>
											<falseStatements>
												<comment>login user</comment>
												<conditionStatement>
													<condition>
														<methodInvokeExpression methodName="UserLogin">
															<parameters>
																<argumentReferenceExpression name="username"/>
																<argumentReferenceExpression name="password"/>
																<methodInvokeExpression methodName="Equals">
																	<target>
																		<argumentReferenceExpression name="createPersistentCookie"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="true"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="successResponse">
															<init>
																<methodInvokeExpression methodName="CreateUserLoginResponse">
																	<parameters>
																		<argumentReferenceExpression name="username"/>
																		<primitiveExpression value="true"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="IdentityInequality">
																		<variableReferenceExpression name="successResponse"/>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																	<methodInvokeExpression methodName="AllowUserLoginResponse">
																		<parameters>
																			<argumentReferenceExpression name="username"/>
																			<variableReferenceExpression name="successResponse"/>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodReturnStatement>
																	<variableReferenceExpression name="successResponse"/>
																</methodReturnStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<propertyReferenceExpression name="HasValue">
																	<argumentReferenceExpression name="createPersistentCookie"/>
																</propertyReferenceExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="SetAuthCookie">
																	<target>
																		<typeReferenceExpression type="FormsAuthentication"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="username"/>
																		<propertyReferenceExpression name="Value">
																			<variableReferenceExpression name="createPersistentCookie"/>
																		</propertyReferenceExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<variableDeclarationStatement type="MembershipUser" name="user">
															<init>
																<methodInvokeExpression methodName="GetUser">
																	<target>
																		<typeReferenceExpression type="Membership"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="username"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="user"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<propertyReferenceExpression name="HasValue">
																			<argumentReferenceExpression name="createPersistentCookie"/>
																		</propertyReferenceExpression>
																	</condition>
																	<trueStatements>
																		<methodReturnStatement>
																			<methodInvokeExpression methodName="CreateTicket">
																				<parameters>
																					<variableReferenceExpression name="user"/>
																					<primitiveExpression value="null"/>
																				</parameters>
																			</methodInvokeExpression>
																		</methodReturnStatement>
																	</trueStatements>
																	<falseStatements>
																		<methodReturnStatement>
																			<methodInvokeExpression methodName="CreateTicket">
																				<parameters>
																					<variableReferenceExpression name="user"/>
																					<primitiveExpression value="null"/>
																					<primitiveExpression value="server.rest.authorization.accessTokenDuration"/>
																					<primitiveExpression value="server.rest.authorization.refreshTokenDuration"/>
																				</parameters>
																			</methodInvokeExpression>
																		</methodReturnStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
													<falseStatements>
														<variableDeclarationStatement name="failureResponse">
															<init>
																<methodInvokeExpression methodName="CreateUserLoginResponse">
																	<parameters>
																		<argumentReferenceExpression name="username"/>
																		<primitiveExpression value="false"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="failureResponse"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodReturnStatement>
																	<variableReferenceExpression name="failureResponse"/>
																</methodReturnStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</falseStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method SkupUserLoginResponse -->
						<memberMethod name="SkipUserLoginResponse">
							<attributes family="true"/>
							<statements>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<propertyReferenceExpression name="Items">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</target>
										<indices>
											<primitiveExpression value="ApplicationServices_SkipUserLoginResponse"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
							</statements>
						</memberMethod>
						<!-- method OtpAuth(string, string) -->
						<memberMethod returnType="System.Object" name="OtpAuth">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="System.String" name="password"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="totpSize">
									<init>
										<convertExpression to="Int32">
											<methodInvokeExpression methodName="SettingsProperty">
												<parameters>
													<primitiveExpression value="server.2FA.code.length"/>
													<primitiveExpression value="6"/>
												</parameters>
											</methodInvokeExpression>
										</convertExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="totpPeriod">
									<init>
										<convertExpression to="Int32">
											<methodInvokeExpression methodName="SettingsProperty">
												<parameters>
													<primitiveExpression value="server.2FA.code.period"/>
													<primitiveExpression value="30"/>
												</parameters>
											</methodInvokeExpression>
										</convertExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="backupCodeLength">
									<init>
										<convertExpression to="Int32">
											<methodInvokeExpression methodName="SettingsProperty">
												<parameters>
													<primitiveExpression value="server.2FA.backupCodes.length"/>
													<primitiveExpression value="8"/>
												</parameters>
											</methodInvokeExpression>
										</convertExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="backupCodeCount">
									<init>
										<convertExpression to="Int32">
											<methodInvokeExpression methodName="SettingsProperty">
												<parameters>
													<primitiveExpression value="server.2FA.backupCodes.count"/>
													<primitiveExpression value="10"/>
												</parameters>
											</methodInvokeExpression>
										</convertExpression>
									</init>
								</variableDeclarationStatement>
								<comment>prepare the otpauth arguments</comment>
								<variableDeclarationStatement name="args">
									<init>
										<objectCreateExpression type="JObject">
											<parameters>
												<objectCreateExpression type="JProperty">
													<parameters>
														<primitiveExpression value="username"/>
														<argumentReferenceExpression name="username"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<assignStatement>
									<variableReferenceExpression name="password"/>
									<binaryOperatorExpression operator="Add">
										<primitiveExpression value="password:"/>
										<argumentReferenceExpression name="password"/>
									</binaryOperatorExpression>
								</assignStatement>
								<foreachStatement>
									<variable name="vp"/>
									<target>
										<methodInvokeExpression methodName="Split">
											<target>
												<argumentReferenceExpression name="password"/>
											</target>
											<parameters>
												<primitiveExpression value=";" convertTo="Char"/>
											</parameters>
										</methodInvokeExpression>
									</target>
									<statements>
										<variableDeclarationStatement name="p">
											<init>
												<methodInvokeExpression methodName="Match">
													<target>
														<typeReferenceExpression type="Regex"/>
													</target>
													<parameters>
														<variableReferenceExpression name="vp"/>
														<primitiveExpression>
															<xsl:attribute name="value"><![CDATA[^(\w+)\:(.+)$]]></xsl:attribute>
														</primitiveExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="Success">
													<variableReferenceExpression name="p"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="v">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="2"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="o" type="System.Object" var="false">
													<init>
														<variableReferenceExpression name="v"/>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<variableReferenceExpression name="v"/>
															<primitiveExpression value="null" convertTo="String"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="o"/>
															<primitiveExpression value="null"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanOr">
																	<binaryOperatorExpression operator="ValueEquality">
																		<variableReferenceExpression name="v"/>
																		<primitiveExpression value="true" convertTo="String"/>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="ValueEquality">
																		<variableReferenceExpression name="v"/>
																		<primitiveExpression value="false" convertTo="String"/>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="o"/>
																	<convertExpression to="Boolean">
																		<variableReferenceExpression name="v"/>
																	</convertExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</falseStatements>
												</conditionStatement>
												<variableDeclarationStatement name="propName">
													<init>
														<propertyReferenceExpression name="Value">
															<arrayIndexerExpression>
																<target>
																	<propertyReferenceExpression name="Groups">
																		<variableReferenceExpression name="p"/>
																	</propertyReferenceExpression>
																</target>
																<indices>
																	<primitiveExpression value="1"/>
																</indices>
															</arrayIndexerExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="Remove">
													<target>
														<variableReferenceExpression name="args"/>
													</target>
													<parameters>
														<variableReferenceExpression name="propName"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="args"/>
													</target>
													<parameters>
														<objectCreateExpression type="JProperty">
															<parameters>
																<variableReferenceExpression name="propName"/>
																<variableReferenceExpression name="o"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</statements>
								</foreachStatement>
								<assignStatement>
									<argumentReferenceExpression name="password"/>
									<convertExpression to="String">
										<arrayIndexerExpression>
											<target>
												<variableReferenceExpression name="args"/>
											</target>
											<indices>
												<primitiveExpression value="password"/>
											</indices>
										</arrayIndexerExpression>
									</convertExpression>
								</assignStatement>
								<variableDeclarationStatement name="validationKey">
									<init>
										<propertyReferenceExpression name="ValidationKey">
											<typeReferenceExpression type="ApplicationServices"/>
										</propertyReferenceExpression>
									</init>
								</variableDeclarationStatement>
								<comment>execute the otpauth method</comment>
								<variableDeclarationStatement name="exec">
									<init>
										<convertExpression to="String">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="args"/>
												</target>
												<indices>
													<primitiveExpression value="exec"/>
												</indices>
											</arrayIndexerExpression>
										</convertExpression>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="result">
									<init>
										<objectCreateExpression type="JObject"/>
									</init>
								</variableDeclarationStatement>

								<comment>***** send verification code to the user *****</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="exec"/>
											<primitiveExpression value="send"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="result"/>
												</target>
												<indices>
													<primitiveExpression value="event"/>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="otpauthtotpsetup_verificationcodesent.app"/>
										</assignStatement>
										<variableDeclarationStatement name="method">
											<init>
												<convertExpression to="String">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="args"/>
														</target>
														<indices>
															<primitiveExpression value="method"/>
														</indices>
													</arrayIndexerExpression>
												</convertExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="type">
											<init>
												<convertExpression to="String">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="args"/>
														</target>
														<indices>
															<primitiveExpression value="type"/>
														</indices>
													</arrayIndexerExpression>
												</convertExpression>
											</init>
										</variableDeclarationStatement>
										<tryStatement>
											<statements>
												<variableDeclarationStatement name="authData">
													<init>
														<methodInvokeExpression methodName="OtpAuthenticationData">
															<parameters>
																<argumentReferenceExpression name="username"/>
																<convertExpression to="String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="args"/>
																		</target>
																		<indices>
																			<primitiveExpression value="url"/>
																		</indices>
																	</arrayIndexerExpression>
																</convertExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="contacts">
													<init>
														<arrayIndexerExpression>
															<target>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="authData"/>
																	</target>
																	<indices>
																		<primitiveExpression value="verify"/>
																	</indices>
																</arrayIndexerExpression>
															</target>
															<indices>
																<variableReferenceExpression name="type"/>
															</indices>
														</arrayIndexerExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="Not">
															<binaryOperatorExpression operator="IsTypeOf">
																<variableReferenceExpression name="contacts"/>
																<typeReferenceExpression type="JArray"/>
															</binaryOperatorExpression>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="contacts"/>
															<objectCreateExpression type="JArray">
																<parameters>
																	<variableReferenceExpression name="contacts"/>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<foreachStatement>
													<variable name="c"/>
													<target>
														<variableReferenceExpression name="contacts"/>
													</target>
													<statements>
														<variableDeclarationStatement name="contact">
															<init>
																<convertExpression to="String">
																	<variableReferenceExpression name="c"/>
																</convertExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<methodInvokeExpression methodName="Hash">
																		<target>
																			<typeReferenceExpression type="TextUtility"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="contact"/>
																		</parameters>
																	</methodInvokeExpression>
																	<variableReferenceExpression name="method"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="secret">
																	<init>
																		<methodInvokeExpression methodName="OtpAuthenticationSecretFrom">
																			<parameters>
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="authData"/>
																					</target>
																					<indices>
																						<primitiveExpression value="otpauth"/>
																					</indices>
																				</arrayIndexerExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="code">
																	<init>
																		<methodInvokeExpression methodName="Compute">
																			<target>
																				<objectCreateExpression type="Totp">
																					<parameters>
																						<methodInvokeExpression methodName="FromBase32String">
																							<target>
																								<typeReferenceExpression type="TextUtility"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="secret"/>
																							</parameters>
																						</methodInvokeExpression>
																						<variableReferenceExpression name="totpPeriod"/>
																					</parameters>
																				</objectCreateExpression>
																			</target>
																			<parameters>
																				<methodInvokeExpression methodName="AddSeconds">
																					<target>
																						<propertyReferenceExpression name="UtcNow">
																							<typeReferenceExpression type="DateTime"/>
																						</propertyReferenceExpression>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="totpPeriod"/>
																					</parameters>
																				</methodInvokeExpression>
																				<variableReferenceExpression name="totpSize"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="message">
																	<init>
																		<methodInvokeExpression methodName="Format">
																			<target>
																				<typeReferenceExpression type="System.String"/>
																			</target>
																			<parameters>
																				<methodInvokeExpression methodName="Replace">
																					<target>
																						<typeReferenceExpression type="Regex"/>
																					</target>
																					<parameters>
																						<convertExpression to="String">
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="args"/>
																								</target>
																								<indices>
																									<primitiveExpression value="template"/>
																								</indices>
																							</arrayIndexerExpression>
																						</convertExpression>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[\d{5,}]]></xsl:attribute>
																						</primitiveExpression>
																						<primitiveExpression value="{{0}}"/>
																					</parameters>
																				</methodInvokeExpression>
																				<variableReferenceExpression name="code"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="confirmation">
																	<init>
																		<convertExpression to="String">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="args"/>
																				</target>
																				<indices>
																					<primitiveExpression value="confirmation"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</init>
																</variableDeclarationStatement>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="result"/>
																		</target>
																		<indices>
																			<primitiveExpression value="notify"/>
																		</indices>
																	</arrayIndexerExpression>
																	<methodInvokeExpression methodName="OtpAuthenticationSendVerificationCode">
																		<parameters>
																			<variableReferenceExpression name="code"/>
																			<variableReferenceExpression name="type"/>
																			<variableReferenceExpression name="contact"/>
																			<variableReferenceExpression name="message"/>
																			<variableReferenceExpression name="confirmation"/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
																<breakStatement/>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
											</statements>
											<catch exceptionType="Exception" localName="ex">
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="result"/>
														</target>
														<indices>
															<primitiveExpression value="notify"/>
														</indices>
													</arrayIndexerExpression>
													<propertyReferenceExpression name="Message">
														<variableReferenceExpression name="ex"/>
													</propertyReferenceExpression>
												</assignStatement>
											</catch>
										</tryStatement>
									</trueStatements>
								</conditionStatement>
								<comment>***** validate the verification code *****</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="exec"/>
											<primitiveExpression value="login"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="authData">
											<init>
												<methodInvokeExpression methodName="OtpAuthenticationData">
													<parameters>
														<argumentReferenceExpression name="username"/>
														<convertExpression to="String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="args"/>
																</target>
																<indices>
																	<primitiveExpression value="url"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="otpauthUrl">
											<init>
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="authData"/>
													</target>
													<indices>
														<primitiveExpression value="otpauth"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="passcode">
											<init>
												<convertExpression to="String">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="args"/>
														</target>
														<indices>
															<primitiveExpression value="passcode"/>
														</indices>
													</arrayIndexerExpression>
												</convertExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="otpauthUrl"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="passcode"/>
													</unaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="secret">
													<init>
														<methodInvokeExpression methodName="OtpAuthenticationSecretFrom">
															<parameters>
																<variableReferenceExpression name="otpauthUrl"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="user">
													<init>
														<methodInvokeExpression methodName="GetUser">
															<target>
																<typeReferenceExpression type="Membership"/>
															</target>
															<parameters>
																<argumentReferenceExpression name="username"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="secret"/>
															</unaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanAnd">
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="user"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
																<unaryOperatorExpression operator="Not">
																	<propertyReferenceExpression name="IsLockedOut">
																		<variableReferenceExpression name="user"/>
																	</propertyReferenceExpression>
																</unaryOperatorExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="d">
															<init>
																<propertyReferenceExpression name="UtcNow">
																	<typeReferenceExpression type="DateTime"/>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="maxDate">
															<init>
																<methodInvokeExpression methodName="AddSeconds">
																	<target>
																		<variableReferenceExpression name="d"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="120"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<variableReferenceExpression name="d"/>
															<methodInvokeExpression methodName="AddSeconds">
																<target>
																	<variableReferenceExpression name="d"/>
																</target>
																<parameters>
																	<binaryOperatorExpression operator="Subtract">
																		<binaryOperatorExpression operator="Multiply">
																			<primitiveExpression value="-1"/>
																			<methodInvokeExpression methodName="Max">
																				<target>
																					<typeReferenceExpression type="Math"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="totpPeriod"/>
																					<convertExpression to="Int32">
																						<methodInvokeExpression methodName="SettingsProperty">
																							<parameters>
																								<primitiveExpression value="server.2FA.code.window"/>
																								<primitiveExpression value="180"/>
																							</parameters>
																						</methodInvokeExpression>
																					</convertExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</binaryOperatorExpression>
																		<variableReferenceExpression name="totpPeriod"/>
																	</binaryOperatorExpression>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<variableDeclarationStatement name="authenticated">
															<init>
																<primitiveExpression value="false"/>
															</init>
														</variableDeclarationStatement>
														<whileStatement>
															<test>
																<binaryOperatorExpression operator="LessThan">
																	<variableReferenceExpression name="d"/>
																	<variableReferenceExpression name="maxDate"/>
																</binaryOperatorExpression>
															</test>
															<statements>
																<variableDeclarationStatement name="code">
																	<init>
																		<methodInvokeExpression methodName="Compute">
																			<target>
																				<objectCreateExpression type="Totp">
																					<parameters>
																						<methodInvokeExpression methodName="FromBase32String">
																							<target>
																								<typeReferenceExpression type="TextUtility"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="secret"/>
																							</parameters>
																						</methodInvokeExpression>
																						<variableReferenceExpression name="totpPeriod"/>
																					</parameters>
																				</objectCreateExpression>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="d"/>
																				<variableReferenceExpression name="totpSize"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<variableReferenceExpression name="code"/>
																			<variableReferenceExpression name="passcode"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="authenticated"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																		<breakStatement/>
																	</trueStatements>
																</conditionStatement>
																<assignStatement>
																	<variableReferenceExpression name="d"/>
																	<methodInvokeExpression methodName="AddSeconds">
																		<target>
																			<variableReferenceExpression name="d"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="totpPeriod"/>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</statements>
														</whileStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<variableReferenceExpression name="authenticated"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="backupCodes">
																	<init>
																		<objectCreateExpression type="List">
																			<typeArguments>
																				<typeReference type="System.String"/>
																			</typeArguments>
																			<parameters>
																				<methodInvokeExpression methodName="Split">
																					<target>
																						<typeReferenceExpression type="Regex"/>
																					</target>
																					<parameters>
																						<convertExpression to="String">
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="authData"/>
																								</target>
																								<indices>
																									<primitiveExpression value="backupCodes"/>
																								</indices>
																							</arrayIndexerExpression>
																						</convertExpression>
																						<primitiveExpression>
																							<xsl:attribute name="value"><![CDATA[\s*,\s*]]></xsl:attribute>
																						</primitiveExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</parameters>
																		</objectCreateExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<methodInvokeExpression methodName="Contains">
																			<target>
																				<variableReferenceExpression name="backupCodes"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="passcode"/>
																			</parameters>
																		</methodInvokeExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="authenticated"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																		<methodInvokeExpression methodName="Remove">
																			<target>
																				<variableReferenceExpression name="backupCodes"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="passcode"/>
																			</parameters>
																		</methodInvokeExpression>
																		<variableDeclarationStatement name="newBackupCodes">
																			<init>
																				<methodInvokeExpression methodName="Join">
																					<target>
																						<typeReferenceExpression type="System.String"/>
																					</target>
																					<parameters>
																						<primitiveExpression value=", "/>
																						<methodInvokeExpression methodName="ToArray">
																							<target>
																								<variableReferenceExpression name="backupCodes"/>
																							</target>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="IsNullOrEmpty">
																					<variableReferenceExpression name="newBackupCodes"/>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="newBackupCodes"/>
																					<primitiveExpression value="null"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<methodInvokeExpression methodName="UserAuthenticationData">
																			<parameters>
																				<argumentReferenceExpression name="username"/>
																				<objectCreateExpression type="JObject">
																					<parameters>
																						<objectCreateExpression type="JProperty">
																							<parameters>
																								<primitiveExpression value="Backup Codes"/>
																								<variableReferenceExpression name="newBackupCodes"/>
																							</parameters>
																						</objectCreateExpression>
																					</parameters>
																				</objectCreateExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<variableReferenceExpression name="authenticated"/>
															</condition>
															<trueStatements>
																<comment>internal verification has been completed successfully</comment>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<unaryOperatorExpression operator="IsNullOrEmpty">
																				<variableReferenceExpression name="password"/>
																			</unaryOperatorExpression>
																			<binaryOperatorExpression operator="ValueEquality">
																				<propertyReferenceExpression name="Name">
																					<propertyReferenceExpression name="Identity">
																						<propertyReferenceExpression name="User">
																							<propertyReferenceExpression name="Current">
																								<typeReferenceExpression type="HttpContext"/>
																							</propertyReferenceExpression>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																				</propertyReferenceExpression>
																				<argumentReferenceExpression name="username"/>
																			</binaryOperatorExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodReturnStatement>
																			<primitiveExpression value="true"/>
																		</methodReturnStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<convertExpression to="Boolean">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="args"/>
																				</target>
																				<indices>
																					<primitiveExpression value="trustThisDevice"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="OtpAuthenticationTrustThisDevice">
																			<parameters>
																				<argumentReferenceExpression name="username"/>
																				<variableReferenceExpression name="authData"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<comment>return the user ticket to the client</comment>
																<methodInvokeExpression methodName="SkipUserLoginResponse"/>
																<methodReturnStatement>
																	<methodInvokeExpression methodName="AuthenticateUser">
																		<parameters>
																			<argumentReferenceExpression name="username"/>
																			<convertExpression to="String">
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="args"/>
																					</target>
																					<indices>
																						<primitiveExpression value="password"/>
																					</indices>
																				</arrayIndexerExpression>
																			</convertExpression>
																			<convertExpression to="Boolean">
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="args"/>
																					</target>
																					<indices>
																						<primitiveExpression value="createPersistentCookie"/>
																					</indices>
																				</arrayIndexerExpression>
																			</convertExpression>
																		</parameters>
																	</methodInvokeExpression>
																</methodReturnStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="ValidateUser">
																	<target>
																		<typeReferenceExpression type="Membership"/>
																	</target>
																	<parameters>
																		<argumentReferenceExpression name="username"/>
																		<methodInvokeExpression methodName="ToString">
																			<target>
																				<objectCreateExpression type="Guid"/>
																			</target>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<comment>***** generate the new backup codes *****</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="exec"/>
											<primitiveExpression value="generate"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="secret">
											<init>
												<methodInvokeExpression methodName="OtpAuthenticationSecretFrom">
													<parameters>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="args"/>
															</target>
															<indices>
																<primitiveExpression value="url"/>
															</indices>
														</arrayIndexerExpression>
													</parameters>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="secret"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="result"/>
														</target>
														<indices>
															<primitiveExpression value="event"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="otpauthtotpsetup_backupcodesgeneratedone.app"/>
												</assignStatement>
												<variableDeclarationStatement name="backupCodes">
													<init>
														<objectCreateExpression type="List">
															<typeArguments>
																<typeReference type="System.String"/>
															</typeArguments>
														</objectCreateExpression>
													</init>
												</variableDeclarationStatement>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="result"/>
													</target>
													<parameters>
														<objectCreateExpression type="JProperty">
															<parameters>
																<primitiveExpression value="newBackupCodes"/>
																<methodInvokeExpression methodName="Compute">
																	<target>
																		<objectCreateExpression type="Totp">
																			<parameters>
																				<variableReferenceExpression name="secret"/>
																				<variableReferenceExpression name="totpPeriod"/>
																			</parameters>
																		</objectCreateExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="backupCodeLength"/>
																		<variableReferenceExpression name="backupCodeCount"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<methodReturnStatement>
													<primitiveExpression value="false"/>
												</methodReturnStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<comment>***** setup the 2-Factor Authentication *****</comment>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<variableReferenceExpression name="exec"/>
											<primitiveExpression value="setup"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="passcode">
											<init>
												<convertExpression to="String">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="args"/>
														</target>
														<indices>
															<primitiveExpression value="passcode"/>
														</indices>
													</arrayIndexerExpression>
												</convertExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="password"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<comment>new 2FA setup</comment>
												<variableDeclarationStatement name="userAuthData">
													<init>
														<methodInvokeExpression methodName="UserAuthenticationData">
															<parameters>
																<argumentReferenceExpression name="username"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="IdentityInequality">
																<variableReferenceExpression name="userAuthData"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="IdentityInequality">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="userAuthData"/>
																	</target>
																	<indices>
																		<primitiveExpression value="2FA"/>
																	</indices>
																</arrayIndexerExpression>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="false"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="SkipUserLoginResponse"/>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanOr">
															<binaryOperatorExpression operator="ValueEquality">
																<variableReferenceExpression name="password"/>
																<variableReferenceExpression name="validationKey"/>
															</binaryOperatorExpression>
															<methodInvokeExpression methodName="UserLogin">
																<parameters>
																	<argumentReferenceExpression name="username"/>
																	<argumentReferenceExpression name="password"/>
																	<primitiveExpression value="false"/>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="result"/>
																</target>
																<indices>
																	<primitiveExpression value="event"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="otpauthtotpsetup.app"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="result"/>
																</target>
																<indices>
																	<primitiveExpression value="otpauth"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="totp"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="result"/>
																</target>
																<indices>
																	<primitiveExpression value="username"/>
																</indices>
															</arrayIndexerExpression>
															<argumentReferenceExpression name="username"/>
														</assignStatement>
														<variableDeclarationStatement name="secret">
															<init>
																<methodInvokeExpression methodName ="ToBase32String">
																	<target>
																		<typeReferenceExpression type="TextUtility"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="GetUniqueKey">
																			<target>
																				<typeReferenceExpression type="TextUtility"/>
																			</target>
																			<parameters>
																				<convertExpression to="Int32">
																					<methodInvokeExpression methodName="SettingsProperty">
																						<parameters>
																							<primitiveExpression value="server.2FA.secret.length"/>
																							<primitiveExpression value="10"/>
																						</parameters>
																					</methodInvokeExpression>
																				</convertExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="result"/>
																</target>
																<indices>
																	<primitiveExpression value="secret"/>
																</indices>
															</arrayIndexerExpression>
															<variableReferenceExpression name="secret"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="result"/>
																</target>
																<indices>
																	<primitiveExpression value="url"/>
																</indices>
															</arrayIndexerExpression>
															<stringFormatExpression>
																<xsl:attribute name="format"><![CDATA[otpauth://totp/{0}?secret={1}&issuer={2}&algorithm=SHA1&digits={3}&period={4}]]></xsl:attribute>
																<methodInvokeExpression methodName="UrlEncode">
																	<target>
																		<typeReferenceExpression type="HttpUtility"/>
																	</target>
																	<parameters>
																		<argumentReferenceExpression name="username"/>
																	</parameters>
																</methodInvokeExpression>
																<variableReferenceExpression name="secret"/>
																<methodInvokeExpression methodName="UrlEncode">
																	<target>
																		<typeReferenceExpression type="HttpUtility"/>
																	</target>
																	<parameters>
																		<convertExpression to="String">
																			<methodInvokeExpression methodName="SettingsProperty">
																				<parameters>
																					<primitiveExpression value="appName"/>
																					<propertyReferenceExpression name="Name"/>
																				</parameters>
																			</methodInvokeExpression>
																		</convertExpression>
																	</parameters>
																</methodInvokeExpression>
																<variableReferenceExpression name="totpSize"/>
																<variableReferenceExpression name="totpPeriod"/>
															</stringFormatExpression>
														</assignStatement>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="result"/>
															</target>
															<parameters>
																<objectCreateExpression type="JProperty">
																	<parameters>
																		<primitiveExpression value="backupCodes"/>
																		<methodInvokeExpression methodName="Compute">
																			<target>
																				<objectCreateExpression type="Totp">
																					<parameters>
																						<methodInvokeExpression methodName="ToBase32String">
																							<target>
																								<typeReferenceExpression type="TextUtility"/>
																							</target>
																							<parameters>
																								<variableReferenceExpression name="secret"/>
																							</parameters>
																						</methodInvokeExpression>
																						<variableReferenceExpression name="totpPeriod"/>
																					</parameters>
																				</objectCreateExpression>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="backupCodeLength"/>
																				<variableReferenceExpression name="backupCodeCount"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
													<falseStatements>
														<methodReturnStatement>
															<primitiveExpression value="false"/>
														</methodReturnStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="passcode"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<comment>existing or new 2FA setup</comment>
														<variableDeclarationStatement name="newUrl">
															<init>
																<convertExpression to="String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="args"/>
																		</target>
																		<indices>
																			<primitiveExpression value="url"/>
																		</indices>
																	</arrayIndexerExpression>
																</convertExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="newBackupCodes">
															<init>
																<convertExpression to="String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="args"/>
																		</target>
																		<indices>
																			<primitiveExpression value="backupCodes"/>
																		</indices>
																	</arrayIndexerExpression>
																</convertExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement type="System.Object" name="authenticated" var="false">
															<init>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="passcode"/>
																	<variableReferenceExpression name="validationKey"/>
																</binaryOperatorExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="Not">
																	<methodInvokeExpression methodName="Equals">
																		<target>
																			<primitiveExpression value="true"/>
																		</target>
																		<parameters>
																			<variableReferenceExpression name="authenticated"/>
																		</parameters>
																	</methodInvokeExpression>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="authenticated"/>
																	<methodInvokeExpression methodName="OtpAuth">
																		<parameters>
																			<argumentReferenceExpression name="username"/>
																			<stringFormatExpression>
																				<xsl:attribute name="format"><![CDATA[null;exec:login;passcode:{0};url:{1};backupCodes:{2}]]></xsl:attribute>
																				<variableReferenceExpression name="passcode"/>
																				<variableReferenceExpression name="newUrl"/>
																				<variableReferenceExpression name="newBackupCodes"/>
																			</stringFormatExpression>
																		</parameters>
																	</methodInvokeExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="Equals">
																	<target>
																		<primitiveExpression value="true"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="authenticated"/>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="newUrl"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<comment>save the new or change the existing 2FA setup</comment>
																		<variableDeclarationStatement type="System.String" name="existingUrl" var="false">
																			<init>
																				<primitiveExpression value="null"/>
																			</init>
																		</variableDeclarationStatement>
																		<variableDeclarationStatement name="userAuthData">
																			<init>
																				<methodInvokeExpression methodName="UserAuthenticationData">
																					<parameters>
																						<argumentReferenceExpression name="username"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityInequality">
																					<variableReferenceExpression name="userAuthData"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<variableReferenceExpression name="existingUrl"/>
																					<convertExpression to="String">
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="userAuthData"/>
																							</target>
																							<indices>
																								<primitiveExpression value="2FA"/>
																							</indices>
																						</arrayIndexerExpression>
																					</convertExpression>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<variableDeclarationStatement name="setupType">
																			<init>
																				<primitiveExpression value="new"/>
																			</init>
																		</variableDeclarationStatement>
																		<comment>if there is an existing 2FA setup then it must match the new setup</comment>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="IsNotNullOrEmpty">
																					<variableReferenceExpression name="existingUrl"/>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="ValueInequality">
																							<variableReferenceExpression name="newUrl"/>
																							<variableReferenceExpression name="existingUrl"/>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<methodReturnStatement>
																							<primitiveExpression value="false"/>
																						</methodReturnStatement>
																					</trueStatements>
																				</conditionStatement>
																				<assignStatement>
																					<variableReferenceExpression name="setupType"/>
																					<primitiveExpression value="existing"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<comment>save the setup to the database</comment>
																		<variableDeclarationStatement name="newUserAuthData">
																			<init>
																				<objectCreateExpression type="JObject"/>
																			</init>
																		</variableDeclarationStatement>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="newUserAuthData"/>
																				</target>
																				<indices>
																					<primitiveExpression value="2FA"/>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="newUrl"/>
																		</assignStatement>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="IsNotNullOrEmpty">
																					<variableReferenceExpression name="newBackupCodes"/>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="newUserAuthData"/>
																						</target>
																						<indices>
																							<primitiveExpression value="Backup Codes"/>
																						</indices>
																					</arrayIndexerExpression>
																					<variableReferenceExpression name="newBackupCodes"/>
																				</assignStatement>
																			</trueStatements>
																		</conditionStatement>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="newUserAuthData"/>
																				</target>
																				<indices>
																					<primitiveExpression value="Methods"/>
																				</indices>
																			</arrayIndexerExpression>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="args"/>
																				</target>
																				<indices>
																					<primitiveExpression value="methods"/>
																				</indices>
																			</arrayIndexerExpression>
																		</assignStatement>
																		<methodInvokeExpression methodName="UserAuthenticationData">
																			<parameters>
																				<argumentReferenceExpression name="username"/>
																				<variableReferenceExpression name="newUserAuthData"/>
																			</parameters>
																		</methodInvokeExpression>
																		<comment>inform the user about successful setup</comment>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="result"/>
																				</target>
																				<indices>
																					<primitiveExpression value="event"/>
																				</indices>
																			</arrayIndexerExpression>
																			<primitiveExpression value="otpauthtotpsetup_complete.app"/>
																		</assignStatement>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="result"/>
																				</target>
																				<indices>
																					<primitiveExpression value="setupType"/>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="setupType"/>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<comment>existing 2FA setup</comment>
																		<variableDeclarationStatement name="userAuthData">
																			<init>
																				<methodInvokeExpression methodName="UserAuthenticationData">
																					<parameters>
																						<argumentReferenceExpression name="username"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<variableDeclarationStatement name="secret">
																			<init>
																				<methodInvokeExpression methodName="OtpAuthenticationSecretFrom">
																					<parameters>
																						<arrayIndexerExpression>
																							<target>
																								<variableReferenceExpression name="userAuthData"/>
																							</target>
																							<indices>
																								<primitiveExpression value="2FA"/>
																							</indices>
																						</arrayIndexerExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="ValueInequality">
																					<variableReferenceExpression name="secret"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="result"/>
																						</target>
																						<indices>
																							<primitiveExpression value="event"/>
																						</indices>
																					</arrayIndexerExpression>
																					<primitiveExpression value="otpauthtotpsetup.app"/>
																				</assignStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="result"/>
																						</target>
																						<indices>
																							<primitiveExpression value="otpauth"/>
																						</indices>
																					</arrayIndexerExpression>
																					<primitiveExpression value="totp"/>
																				</assignStatement>
																				<assignStatement>
																					<arrayIndexerExpression>
																						<target>
																							<variableReferenceExpression name="result"/>
																						</target>
																						<indices>
																							<primitiveExpression value="username"/>
																						</indices>
																					</arrayIndexerExpression>
																					<argumentReferenceExpression name="username"/>
																				</assignStatement>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="result"/>
																					</target>
																					<parameters>
																						<objectCreateExpression type="JProperty">
																							<parameters>
																								<primitiveExpression value="url"/>
																								<arrayIndexerExpression>
																									<target>
																										<variableReferenceExpression name="userAuthData"/>
																									</target>
																									<indices>
																										<primitiveExpression value="2FA"/>
																									</indices>
																								</arrayIndexerExpression>
																							</parameters>
																						</objectCreateExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="result"/>
																					</target>
																					<parameters>
																						<objectCreateExpression type="JProperty">
																							<parameters>
																								<primitiveExpression value="secret"/>
																								<variableReferenceExpression name="secret"/>
																							</parameters>
																						</objectCreateExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="result"/>
																					</target>
																					<parameters>
																						<objectCreateExpression type="JProperty">
																							<parameters>
																								<primitiveExpression value="backupCodes"/>
																								<methodInvokeExpression methodName="Split">
																									<target>
																										<typeReferenceExpression type="Regex"/>
																									</target>
																									<parameters>
																										<convertExpression to="String">
																											<arrayIndexerExpression>
																												<target>
																													<variableReferenceExpression name="userAuthData"/>
																												</target>
																												<indices>
																													<primitiveExpression value="Backup Codes"/>
																												</indices>
																											</arrayIndexerExpression>
																										</convertExpression>
																										<primitiveExpression>
																											<xsl:attribute name="value"><![CDATA[\s*,\s*]]></xsl:attribute>
																										</primitiveExpression>
																									</parameters>
																								</methodInvokeExpression>
																							</parameters>
																						</objectCreateExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<variableDeclarationStatement name="methods">
																					<init>
																						<convertExpression to="String">
																							<arrayIndexerExpression>
																								<target>
																									<variableReferenceExpression name="userAuthData"/>
																								</target>
																								<indices>
																									<primitiveExpression value="Methods"/>
																								</indices>
																							</arrayIndexerExpression>
																						</convertExpression>
																					</init>
																				</variableDeclarationStatement>
																				<conditionStatement>
																					<condition>
																						<unaryOperatorExpression operator="IsNullOrEmpty">
																							<variableReferenceExpression name="methods"/>
																						</unaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<variableReferenceExpression name="methods"/>
																							<primitiveExpression value="app,email"/>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																				<assignStatement>
																					<variableReferenceExpression name="methods"/>
																					<methodInvokeExpression methodName="Replace">
																						<target>
																							<typeReferenceExpression type="Regex"/>
																						</target>
																						<parameters>
																							<methodInvokeExpression methodName="ToLower">
																								<target>
																									<variableReferenceExpression name="methods"/>
																								</target>
																							</methodInvokeExpression>
																							<primitiveExpression value="\s+"/>
																							<stringEmptyExpression/>
																						</parameters>
																					</methodInvokeExpression>
																				</assignStatement>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="result"/>
																					</target>
																					<parameters>
																						<objectCreateExpression type="JProperty">
																							<parameters>
																								<primitiveExpression value="methods"/>
																								<variableReferenceExpression name="methods"/>
																							</parameters>
																						</objectCreateExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="result"/>
																					</target>
																					<parameters>
																						<objectCreateExpression type="JProperty">
																							<parameters>
																								<primitiveExpression value="status"/>
																								<primitiveExpression value="ready"/>
																							</parameters>
																						</objectCreateExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																			<falseStatements>
																				<methodReturnStatement>
																					<primitiveExpression value="false"/>
																				</methodReturnStatement>
																			</falseStatements>
																		</conditionStatement>
																	</falseStatements>
																</conditionStatement>
															</trueStatements>
															<falseStatements>
																<methodReturnStatement>
																	<primitiveExpression value="false"/>
																</methodReturnStatement>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="result"/>
														</target>
														<indices>
															<primitiveExpression value="event"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<arrayIndexerExpression>
														<target>
															<variableReferenceExpression name="result"/>
														</target>
														<indices>
															<primitiveExpression value="event"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="otpauthtotpsetup_confirm.app"/>
												</assignStatement>
												<variableDeclarationStatement type="JObject" name="userAuthData" var="false">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="newUrl">
													<init>
														<convertExpression to="String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="args"/>
																</target>
																<indices>
																	<primitiveExpression value="url"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="newBackupCodes">
													<init>
														<convertExpression to="String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="args"/>
																</target>
																<indices>
																	<primitiveExpression value="backupCodes"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="newMethods">
													<init>
														<convertExpression to="String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="args"/>
																</target>
																<indices>
																	<primitiveExpression value="methods"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="newUrl"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="userAuthData"/>
															<objectCreateExpression type="JObject"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="userAuthData"/>
																</target>
																<indices>
																	<primitiveExpression value="2FA"/>
																</indices>
															</arrayIndexerExpression>
															<variableReferenceExpression name="newUrl"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="userAuthData"/>
																</target>
																<indices>
																	<primitiveExpression value="Backup Codes"/>
																</indices>
															</arrayIndexerExpression>
															<variableReferenceExpression name="newBackupCodes"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="userAuthData"/>
																</target>
																<indices>
																	<primitiveExpression value="Methods"/>
																</indices>
															</arrayIndexerExpression>
															<variableReferenceExpression name="newMethods"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement name="authData">
													<init>
														<methodInvokeExpression methodName="CreateUserLoginResponse">
															<parameters>
																<argumentReferenceExpression name="username"/>
																<primitiveExpression value="true"/>
																<variableReferenceExpression name="userAuthData"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<comment>options "url" and "backupCodes" are provided by the setup when Enable/Save is pressed</comment>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="authData"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="authData"/>
															<objectCreateExpression type="JObject">
																<parameters>
																	<objectCreateExpression type="JProperty">
																		<parameters>
																			<primitiveExpression value="otpauth"/>
																			<variableReferenceExpression name="newUrl"/>
																		</parameters>
																	</objectCreateExpression>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement name="otpauthUrl">
													<init>
														<convertExpression to="String">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authData"/>
																</target>
																<indices>
																	<primitiveExpression value="otpauth"/>
																</indices>
															</arrayIndexerExpression>
														</convertExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="ValueInequality">
																<convertExpression to="String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="args"/>
																		</target>
																		<indices>
																			<primitiveExpression value="consent"/>
																		</indices>
																	</arrayIndexerExpression>
																</convertExpression>
																<primitiveExpression value="Enable"/>
															</binaryOperatorExpression>"<unaryOperatorExpression operator="IsNotNullOrEmpty">
																<variableReferenceExpression name="newUrl"/>
															</unaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<comment>do not remove 2FA if the client URL does not match the 2FA option in the User Authorization Data</comment>
														<assignStatement>
															<variableReferenceExpression name="userAuthData"/>
															<methodInvokeExpression methodName="UserAuthenticationData">
																<parameters>
																	<argumentReferenceExpression name="username"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="IdentityInequality">
																		<variableReferenceExpression name="userAuthData"/>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="ValueInequality">
																		<variableReferenceExpression name="newUrl"/>
																		<convertExpression to="String">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="userAuthData"/>
																				</target>
																				<indices>
																					<primitiveExpression value="2FA"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodReturnStatement>
																	<primitiveExpression value="false"/>
																</methodReturnStatement>
															</trueStatements>
														</conditionStatement>
														<comment>remove 2FA setup</comment>
														<methodInvokeExpression methodName="UserAuthenticationData">
															<parameters>
																<argumentReferenceExpression name="username"/>
																<objectCreateExpression type="JObject">
																	<parameters>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="2FA"/>
																				<primitiveExpression value="null"/>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="Backup Codes"/>
																				<primitiveExpression value="null"/>
																			</parameters>
																		</objectCreateExpression>
																		<objectCreateExpression type="JProperty">
																			<parameters>
																				<primitiveExpression value="Methods"/>
																				<primitiveExpression value="null"/>
																			</parameters>
																		</objectCreateExpression>
																	</parameters>
																</objectCreateExpression>
															</parameters>
														</methodInvokeExpression>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="result"/>
																</target>
																<indices>
																	<primitiveExpression value="event"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="otpauthtotpsetup_complete.app"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="result"/>
																</target>
																<indices>
																	<primitiveExpression value="setupType"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="none"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<variableReferenceExpression name="otpauthUrl"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<comment>ask the user to provide the verification code </comment>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="result"/>
																		</target>
																		<indices>
																			<primitiveExpression value="confirm"/>
																		</indices>
																	</arrayIndexerExpression>
																	<primitiveExpression value="verification_code"/>
																</assignStatement>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="authData"/>
																		</target>
																		<indices>
																			<primitiveExpression value="canTrustThisDevice"/>
																		</indices>
																	</arrayIndexerExpression>
																	<primitiveExpression value="false"/>
																</assignStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="newUrl"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="authData"/>
																				</target>
																				<indices>
																					<primitiveExpression value="url"/>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="newUrl"/>
																		</assignStatement>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="authData"/>
																				</target>
																				<indices>
																					<primitiveExpression value="canEnterBackupCode"/>
																				</indices>
																			</arrayIndexerExpression>
																			<primitiveExpression value="false"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="newBackupCodes"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="authData"/>
																				</target>
																				<indices>
																					<primitiveExpression value="backupCodes"/>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="newBackupCodes"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="newMethods"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="authData"/>
																				</target>
																				<indices>
																					<primitiveExpression value="methods"/>
																				</indices>
																			</arrayIndexerExpression>
																			<variableReferenceExpression name="newMethods"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
															<falseStatements>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="result"/>
																		</target>
																		<indices>
																			<primitiveExpression value="confirm"/>
																		</indices>
																	</arrayIndexerExpression>
																	<primitiveExpression value="password"/>
																</assignStatement>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="authData"/>
																		</target>
																		<indices>
																			<primitiveExpression value="otpauth"/>
																		</indices>
																	</arrayIndexerExpression>
																	<primitiveExpression value="totp"/>
																</assignStatement>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="authData"/>
																		</target>
																		<indices>
																			<primitiveExpression value="username"/>
																		</indices>
																	</arrayIndexerExpression>
																	<argumentReferenceExpression name="username"/>
																</assignStatement>
															</falseStatements>
														</conditionStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authData"/>
																</target>
																<indices>
																	<primitiveExpression value="exec"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="setup"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authData"/>
																</target>
																<indices>
																	<primitiveExpression value="verifyVia"/>
																</indices>
															</arrayIndexerExpression>
															<methodInvokeExpression methodName="SettingsProperty">
																<parameters>
																	<primitiveExpression value="server.2FA.verify"/>
																	<objectCreateExpression type="JObject">
																		<parameters>
																			<objectCreateExpression type="JProperty">
																				<parameters>
																					<primitiveExpression value="app"/>
																					<primitiveExpression value="true"/>
																				</parameters>
																			</objectCreateExpression>
																			<objectCreateExpression type="JProperty">
																				<parameters>
																					<primitiveExpression value="email"/>
																					<primitiveExpression value="true"/>
																				</parameters>
																			</objectCreateExpression>
																		</parameters>
																	</objectCreateExpression>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<variableDeclarationStatement name="setup">
															<init>
																<methodInvokeExpression methodName="SettingsProperty">
																	<parameters>
																		<primitiveExpression value="server.2FA.setup"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="setup"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="authData"/>
																		</target>
																		<indices>
																			<primitiveExpression value="setup"/>
																		</indices>
																	</arrayIndexerExpression>
																	<variableReferenceExpression name="setup"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="result"/>
																</target>
																<indices>
																	<primitiveExpression value="options"/>
																</indices>
															</arrayIndexerExpression>
															<variableReferenceExpression name="authData"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authData"/>
																</target>
																<indices>
																	<primitiveExpression value="confirm"/>
																</indices>
															</arrayIndexerExpression>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="result"/>
																</target>
																<indices>
																	<primitiveExpression value="confirm"/>
																</indices>
															</arrayIndexerExpression>
														</assignStatement>
													</falseStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OtpAuthenticationSendVerificationCode(string, string, string, string, string) -->
						<memberMethod returnType="System.String" name="OtpAuthenticationSendVerificationCode">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="code"/>
								<parameter type="System.String" name="type"/>
								<parameter type="System.String" name="contact"/>
								<parameter type="System.String" name="message"/>
								<parameter type="System.String" name="confirmation"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<argumentReferenceExpression name="type"/>
											<primitiveExpression value="email"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="mail">
											<init>
												<objectCreateExpression type="MailMessage"/>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<propertyReferenceExpression name="Subject">
												<variableReferenceExpression name="mail"/>
											</propertyReferenceExpression>
											<argumentReferenceExpression name="message"/>
										</assignStatement>
										<assignStatement>
											<propertyReferenceExpression name="Body">
												<variableReferenceExpression name="mail"/>
											</propertyReferenceExpression>
											<argumentReferenceExpression name="code"/>
										</assignStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<propertyReferenceExpression name="To">
													<variableReferenceExpression name="mail"/>
												</propertyReferenceExpression>
											</target>
											<parameters>
												<objectCreateExpression type="MailAddress">
													<parameters>
														<variableReferenceExpression name="contact"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
										<variableDeclarationStatement name="client">
											<init>
												<objectCreateExpression type="SmtpClient"/>
											</init>
										</variableDeclarationStatement>
										<methodInvokeExpression methodName="Send">
											<target>
												<variableReferenceExpression name="client"/>
											</target>
											<parameters>
												<variableReferenceExpression name="mail"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="confirmation"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OtpAuthenticationTrustThisDevice(string, JObject) -->
						<memberMethod returnType="System.Boolean" name="OtpAuthenticationTrustThisDevice">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="JObject" name="authData"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="result">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<tryStatement>
									<statements>
										<variableDeclarationStatement name="userTrust">
											<init>
												<objectCreateExpression type="SortedDictionary">
													<typeArguments>
														<typeReference type="System.String"/>
														<typeReference type="System.String"/>
													</typeArguments>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="cookie">
											<init>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Cookies">
															<propertyReferenceExpression name="Request">
																<propertyReferenceExpression name="Current">
																	<typeReferenceExpression type="HttpContext"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value=".trustThis"/>
													</indices>
												</arrayIndexerExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="cookie"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<comment>Sample: 05343490152021-09-16T08:22:44.0435998Zadmin</comment>
												<comment>enumerate existing trusts</comment>
												<variableDeclarationStatement name="s">
													<init>
														<methodInvokeExpression methodName="FromBase64String">
															<target>
																<typeReferenceExpression type="StringEncryptor"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="cookie"/>
																</propertyReferenceExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<variableDeclarationStatement name="iterator">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="s"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[(?'Passcode'\d{10})(?'Date'\d{4}-\d{2}-\d{2}T\d{2}\:\d{2}\:\d{2}\.\d{7}Z)(?'UserName'.+?)(\s|$)]]></xsl:attribute>
																</primitiveExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<whileStatement>
													<test>
														<propertyReferenceExpression name="Success">
															<variableReferenceExpression name="iterator"/>
														</propertyReferenceExpression>
													</test>
													<statements>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="userTrust"/>
																</target>
																<indices>
																	<propertyReferenceExpression name="Value">
																		<arrayIndexerExpression>
																			<target>
																				<propertyReferenceExpression name="Groups">
																					<variableReferenceExpression name="iterator"/>
																				</propertyReferenceExpression>
																			</target>
																			<indices>
																				<primitiveExpression value="UserName"/>
																			</indices>
																		</arrayIndexerExpression>
																	</propertyReferenceExpression>
																</indices>
															</arrayIndexerExpression>
															<binaryOperatorExpression operator="Add">
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="iterator"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Passcode"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="iterator"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="Date"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</assignStatement>
														<assignStatement>
															<variableReferenceExpression name="iterator"/>
															<methodInvokeExpression methodName="NextMatch">
																<target>
																	<variableReferenceExpression name="iterator"/>
																</target>
															</methodInvokeExpression>
														</assignStatement>
													</statements>
												</whileStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="authData"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="System.String" name="trustInfo" var="false">
													<init>
														<primitiveExpression value="null"/>
													</init>
												</variableDeclarationStatement>
												<assignStatement>
													<variableReferenceExpression name="authData"/>
													<methodInvokeExpression methodName="OtpAuthenticationData">
														<parameters>
															<argumentReferenceExpression name="username"/>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="IdentityInequality">
																<variableReferenceExpression name="authData"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
															<methodInvokeExpression methodName="TryGetValue">
																<target>
																	<variableReferenceExpression name="userTrust"/>
																</target>
																<parameters>
																	<argumentReferenceExpression name="username"/>
																	<directionExpression direction="Out">
																		<variableReferenceExpression name="trustInfo"/>
																	</directionExpression>
																</parameters>
															</methodInvokeExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="passcode">
															<init>
																<methodInvokeExpression methodName="Substring">
																	<target>
																		<variableReferenceExpression name="trustInfo"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="0"/>
																		<primitiveExpression value="10"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="d">
															<init>
																<methodInvokeExpression methodName="Parse">
																	<target>
																		<typeReferenceExpression type="DateTime"/>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="Substring">
																			<target>
																				<variableReferenceExpression name="trustInfo"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="10"/>
																			</parameters>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="secret">
															<init>
																<methodInvokeExpression methodName="OtpAuthenticationSecretFrom">
																	<parameters>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="authData"/>
																			</target>
																			<indices>
																				<primitiveExpression value="otpauth"/>
																			</indices>
																		</arrayIndexerExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="expectedPasscode">
															<init>
																<methodInvokeExpression methodName="Compute">
																	<target>
																		<objectCreateExpression type="Totp">
																			<parameters>
																				<methodInvokeExpression methodName="FromBase32String">
																					<target>
																						<typeReferenceExpression type="TextUtility"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="secret"/>
																					</parameters>
																				</methodInvokeExpression>
																				<primitiveExpression value="30"/>
																			</parameters>
																		</objectCreateExpression>
																	</target>
																	<parameters>
																		<methodInvokeExpression methodName="ToUniversalTime">
																			<target>
																				<variableReferenceExpression name="d"/>
																			</target>
																		</methodInvokeExpression>
																		<primitiveExpression value="10"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<variableReferenceExpression name="passcode"/>
																	<variableReferenceExpression name="expectedPasscode"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="result"/>
																	<primitiveExpression value="true"/>
																</assignStatement>
															</trueStatements>
															<falseStatements>
																<methodInvokeExpression methodName="Remove">
																	<target>
																		<variableReferenceExpression name="userTrust"/>
																	</target>
																	<parameters>
																		<argumentReferenceExpression name="username"/>
																	</parameters>
																</methodInvokeExpression>
															</falseStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<comment>create a trust entry</comment>
												<variableDeclarationStatement name="secret">
													<init>
														<methodInvokeExpression methodName="OtpAuthenticationSecretFrom">
															<parameters>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="authData"/>
																	</target>
																	<indices>
																		<primitiveExpression value="otpauth"/>
																	</indices>
																</arrayIndexerExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="secret"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="d">
															<init>
																<propertyReferenceExpression name="UtcNow">
																	<typeReferenceExpression type="DateTime"/>
																</propertyReferenceExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="passcode">
															<init>
																<methodInvokeExpression methodName="Compute">
																	<target>
																		<objectCreateExpression type="Totp">
																			<parameters>
																				<methodInvokeExpression methodName="FromBase32String">
																					<target>
																						<typeReferenceExpression type="TextUtility"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="secret"/>
																					</parameters>
																				</methodInvokeExpression>
																				<primitiveExpression value="30"/>
																			</parameters>
																		</objectCreateExpression>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="d"/>
																		<primitiveExpression value="10"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="userTrust"/>
																</target>
																<indices>
																	<argumentReferenceExpression name="username"/>
																</indices>
															</arrayIndexerExpression>
															<stringFormatExpression>
																<xsl:attribute name="format"><![CDATA[{0}{1:o}]]></xsl:attribute>
																<variableReferenceExpression name="passcode"/>
																<variableReferenceExpression name="d"/>
															</stringFormatExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
										<comment>set the .trustThis cookie</comment>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="GreaterThan">
													<propertyReferenceExpression name="Count">
														<variableReferenceExpression name="userTrust"/>
													</propertyReferenceExpression>
													<primitiveExpression value="0"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="list">
													<init>
														<objectCreateExpression type="List">
															<typeArguments>
																<typeReference type="System.String"/>
															</typeArguments>
														</objectCreateExpression>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable name="name" type="System.String" var="false"/>
													<target>
														<propertyReferenceExpression name="Keys">
															<variableReferenceExpression name="userTrust"/>
														</propertyReferenceExpression>
													</target>
													<statements>
														<methodInvokeExpression methodName="Add">
															<target>
																<variableReferenceExpression name="list"/>
															</target>
															<parameters>
																<binaryOperatorExpression operator="Add">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="userTrust"/>
																		</target>
																		<indices>
																			<variableReferenceExpression name="name"/>
																		</indices>
																	</arrayIndexerExpression>
																	<variableReferenceExpression name="name"/>
																</binaryOperatorExpression>
															</parameters>
														</methodInvokeExpression>
													</statements>
												</foreachStatement>
												<variableDeclarationStatement name="newTrust">
													<init>
														<methodInvokeExpression methodName="ToBase64String">
															<target>
																<typeReferenceExpression type="StringEncryptor"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="Join">
																	<target>
																		<typeReferenceExpression type="System.String"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="\n"/>
																		<methodInvokeExpression methodName="ToArray">
																			<target>
																				<variableReferenceExpression name="list"/>
																			</target>
																		</methodInvokeExpression>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanOr">
															<binaryOperatorExpression operator="IdentityEquality">
																<variableReferenceExpression name="cookie"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="ValueInequality">
																<propertyReferenceExpression name="Value">
																	<variableReferenceExpression name="cookie"/>
																</propertyReferenceExpression>
																<variableReferenceExpression name="newTrust"/>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="cookie"/>
															<objectCreateExpression type="HttpCookie">
																<parameters>
																	<primitiveExpression value=".trustThis"/>
																	<variableReferenceExpression name="newTrust"/>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Expires">
																<variableReferenceExpression name="cookie"/>
															</propertyReferenceExpression>
															<methodInvokeExpression methodName="AddDays">
																<target>
																	<propertyReferenceExpression name="Now">
																		<typeReferenceExpression type="DateTime"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<methodInvokeExpression methodName="OtpAuthenticationDurationOfTrust"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<methodInvokeExpression methodName="SetCookie">
															<target>
																<typeReferenceExpression type="ApplicationServices"/>
															</target>
															<parameters>
																<variableReferenceExpression name="cookie"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<variableReferenceExpression name="cookie"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="Expires">
																<variableReferenceExpression name="cookie"/>
															</propertyReferenceExpression>
															<methodInvokeExpression methodName="AddDays">
																<target>
																	<propertyReferenceExpression name="Now">
																		<typeReferenceExpression type="DateTime"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="-10"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<assignStatement>
															<propertyReferenceExpression name="Value">
																<variableReferenceExpression name="cookie"/>
															</propertyReferenceExpression>
															<primitiveExpression value="null"/>
														</assignStatement>
														<methodInvokeExpression methodName="SetCookie">
															<target>
																<typeReferenceExpression type="ApplicationServices"/>
															</target>
															<parameters>
																<variableReferenceExpression name="cookie"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</statements>
									<catch exceptionType="Exception">
										<comment>ignore all exceptions</comment>
									</catch>
								</tryStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="result"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OtpAuthenticationSecretFrom(JToken) -->
						<memberMethod returnType="System.String" name="OtpAuthenticationSecretFrom">
							<attributes family="true"/>
							<parameters>
								<parameter type="JToken" name="url"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="OtpAuthenticationSecretFrom">
										<parameters>
											<convertExpression to="String">
												<argumentReferenceExpression name="url"/>
											</convertExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OtpAuthenticationSecretFrom(string) -->
						<memberMethod returnType="System.String" name="OtpAuthenticationSecretFrom">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="url"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="secretParam">
									<init>
										<methodInvokeExpression methodName="Match">
											<target>
												<typeReferenceExpression type="Regex"/>
											</target>
											<parameters>
												<convertExpression to="String">
													<argumentReferenceExpression name="url"/>
												</convertExpression>
												<primitiveExpression>
													<xsl:attribute name="value"><![CDATA[(\?|&)secret=(?'Secret'.+?)(&|$)]]></xsl:attribute>
												</primitiveExpression>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="Success">
											<variableReferenceExpression name="secretParam"/>
										</propertyReferenceExpression>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<propertyReferenceExpression name="Value">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Groups">
															<variableReferenceExpression name="secretParam"/>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="Secret"/>
													</indices>
												</arrayIndexerExpression>
											</propertyReferenceExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateUserLoginResponse(string, bool) -->
						<memberMethod returnType="JObject" name="CreateUserLoginResponse">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="System.Boolean" name="success"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="CreateUserLoginResponse">
										<parameters>
											<argumentReferenceExpression name="username"/>
											<argumentReferenceExpression name="success"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method CreateUserLoginResponse(string, bool, JObject userAuthDatA) -->
						<memberMethod returnType="JObject" name="CreateUserLoginResponse">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="System.Boolean" name="success"/>
								<parameter type="JObject" name="userAuthData"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<argumentReferenceExpression name="success"/>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="Contains">
													<target>
														<propertyReferenceExpression name="Items">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="ApplicationServices_SkipUserLoginResponse"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="Remove">
													<target>
														<propertyReferenceExpression name="Items">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<parameters>
														<primitiveExpression value="ApplicationServices_SkipUserLoginResponse"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<argumentReferenceExpression name="userAuthData"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodInvokeExpression methodName="OtpAuthenticationActivate">
															<parameters>
																<argumentReferenceExpression name="username"/>
															</parameters>
														</methodInvokeExpression>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement name="authData">
													<init>
														<methodInvokeExpression methodName="OtpAuthenticationData">
															<parameters>
																<argumentReferenceExpression name="username"/>
																<argumentReferenceExpression name="userAuthData"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authData"/>
																</target>
																<indices>
																	<primitiveExpression value="otpauth"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authData"/>
																</target>
																<indices>
																	<primitiveExpression value="event"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="otpauth.app"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authData"/>
																</target>
																<indices>
																	<primitiveExpression value="username"/>
																</indices>
															</arrayIndexerExpression>
															<argumentReferenceExpression name="username"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authData"/>
																</target>
																<indices>
																	<primitiveExpression value="success"/>
																</indices>
															</arrayIndexerExpression>
															<argumentReferenceExpression name="success"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authData"/>
																</target>
																<indices>
																	<primitiveExpression value="otpauth"/>
																</indices>
															</arrayIndexerExpression>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authData"/>
																</target>
																<indices>
																	<primitiveExpression value="type"/>
																</indices>
															</arrayIndexerExpression>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="authData"/>
																</target>
																<indices>
																	<primitiveExpression value="confirm"/>
																</indices>
															</arrayIndexerExpression>
															<primitiveExpression value="verification_code"/>
														</assignStatement>
														<variableDeclarationStatement name="verify">
															<init>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="authData"/>
																	</target>
																	<indices>
																		<primitiveExpression value="verify"/>
																	</indices>
																</arrayIndexerExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="verify"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<!-- call -->
																<variableDeclarationStatement name="callMe">
																	<init>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="verify"/>
																			</target>
																			<indices>
																				<primitiveExpression value="call"/>
																			</indices>
																		</arrayIndexerExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="callMe"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="verify"/>
																				</target>
																				<indices>
																					<primitiveExpression value="call"/>
																				</indices>
																			</arrayIndexerExpression>
																			<methodInvokeExpression methodName="EncodeContactInformation">
																				<parameters>
																					<variableReferenceExpression name="callMe"/>
																					<primitiveExpression value="call"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<!-- sms -->
																<variableDeclarationStatement name="smsMe">
																	<init>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="verify"/>
																			</target>
																			<indices>
																				<primitiveExpression value="sms"/>
																			</indices>
																		</arrayIndexerExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="smsMe"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="verify"/>
																				</target>
																				<indices>
																					<primitiveExpression value="sms"/>
																				</indices>
																			</arrayIndexerExpression>
																			<methodInvokeExpression methodName="EncodeContactInformation">
																				<parameters>
																					<variableReferenceExpression name="smsMe"/>
																					<primitiveExpression value="sms"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<!-- email -->
																<variableDeclarationStatement name="emailMe">
																	<init>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="verify"/>
																			</target>
																			<indices>
																				<primitiveExpression value="email"/>
																			</indices>
																		</arrayIndexerExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="emailMe"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="verify"/>
																				</target>
																				<indices>
																					<primitiveExpression value="email"/>
																				</indices>
																			</arrayIndexerExpression>
																			<methodInvokeExpression methodName="EncodeContactInformation">
																				<parameters>
																					<variableReferenceExpression name="emailMe"/>
																					<primitiveExpression value="email"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<!-- dial -->
																<variableDeclarationStatement name="dialTo">
																	<init>
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="verify"/>
																			</target>
																			<indices>
																				<primitiveExpression value="dial"/>
																			</indices>
																		</arrayIndexerExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="dialTo"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="verify"/>
																				</target>
																				<indices>
																					<primitiveExpression value="dial"/>
																				</indices>
																			</arrayIndexerExpression>
																			<methodInvokeExpression methodName="EncodeContactInformation">
																				<parameters>
																					<variableReferenceExpression name="dialTo"/>
																					<primitiveExpression value="dial"/>
																				</parameters>
																			</methodInvokeExpression>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<methodInvokeExpression methodName="OtpAuthenticationDurationOfTrust"/>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="authData"/>
																		</target>
																		<indices>
																			<primitiveExpression value="canTrustThisDevice"/>
																		</indices>
																	</arrayIndexerExpression>
																	<primitiveExpression value="false"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<comment>remove sensitive data</comment>
														<methodInvokeExpression methodName="Remove">
															<target>
																<variableReferenceExpression name="authData"/>
															</target>
															<parameters>
																<primitiveExpression value="type"/>
															</parameters>
														</methodInvokeExpression>
														<methodInvokeExpression methodName="Remove">
															<target>
																<variableReferenceExpression name="authData"/>
															</target>
															<parameters>
																<primitiveExpression value="backupCodes"/>
															</parameters>
														</methodInvokeExpression>
														<methodReturnStatement>
															<variableReferenceExpression name="authData"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OtpAuthenticationActivate(string) -->
						<memberMethod name="OtpAuthenticationActivate">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<convertExpression to="Boolean">
												<methodInvokeExpression methodName="SettingsProperty">
													<parameters>
														<primitiveExpression value="server.2FA.enabled"/>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
											<binaryOperatorExpression operator="ValueEquality">
												<convertExpression to="String">
													<methodInvokeExpression methodName="SettingsProperty">
														<parameters>
															<primitiveExpression value="server.2FA.setup.mode"/>
															<primitiveExpression value="user"/>
														</parameters>
													</methodInvokeExpression>
												</convertExpression>
												<primitiveExpression value="auto"/>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<tryStatement>
											<statements>
												<variableDeclarationStatement name="userAuthData">
													<init>
														<methodInvokeExpression methodName="UserAuthenticationData">
															<parameters>
																<argumentReferenceExpression name="username"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanOr">
															<binaryOperatorExpression operator="IdentityEquality">
																<variableReferenceExpression name="userAuthData"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="BooleanAnd">
																<binaryOperatorExpression operator="IdentityEquality">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="userAuthData"/>
																		</target>
																		<indices>
																			<primitiveExpression value="Source"/>
																		</indices>
																	</arrayIndexerExpression>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
																<binaryOperatorExpression operator="IdentityEquality">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="userAuthData"/>
																		</target>
																		<indices>
																			<primitiveExpression value="2FA"/>
																		</indices>
																	</arrayIndexerExpression>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<comment>get the 2FA setup data</comment>
														<variableDeclarationStatement name="setupObject">
															<init>
																<methodInvokeExpression methodName="OtpAuth">
																	<parameters>
																		<argumentReferenceExpression name="username"/>
																		<stringFormatExpression>
																			<xsl:attribute name="format"><![CDATA[null;otpauth:totp;exec:setup;password:{0};]]></xsl:attribute>
																			<propertyReferenceExpression name="ValidationKey">
																				<typeReferenceExpression type="ApplicationServices"/>
																			</propertyReferenceExpression>
																		</stringFormatExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<binaryOperatorExpression operator="IdentityInequality">
																		<variableReferenceExpression name="setupObject"/>
																		<primitiveExpression value="null"/>
																	</binaryOperatorExpression>
																	<binaryOperatorExpression operator="IsTypeOf">
																		<variableReferenceExpression name="setupObject"/>
																		<typeReferenceExpression type="JObject"/>
																	</binaryOperatorExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<comment>enumerate the verification methods</comment>
																<variableDeclarationStatement name="setupMethods">
																	<init>
																		<methodInvokeExpression methodName="SettingsProperty">
																			<parameters>
																				<primitiveExpression value="server.2FA.setup.methods"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="methods">
																	<init>
																		<objectCreateExpression type="List">
																			<typeArguments>
																				<typeReference  type="System.String"/>
																			</typeArguments>
																		</objectCreateExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityInequality">
																			<variableReferenceExpression name="setupMethods"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<foreachStatement>
																			<variable type="JProperty" name="p" var="false"/>
																			<target>
																				<variableReferenceExpression name="setupMethods"/>
																			</target>
																			<statements>
																				<conditionStatement>
																					<condition>
																						<binaryOperatorExpression operator="BooleanAnd">
																							<binaryOperatorExpression operator="BooleanAnd">
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="Type">
																										<variableReferenceExpression name="p"/>
																									</propertyReferenceExpression>
																									<propertyReferenceExpression name="Property">
																										<typeReferenceExpression type="JTokenType"/>
																									</propertyReferenceExpression>
																								</binaryOperatorExpression>
																								<binaryOperatorExpression operator="ValueEquality">
																									<propertyReferenceExpression name="Type">
																										<propertyReferenceExpression name="Value">
																											<variableReferenceExpression name="p"/>
																										</propertyReferenceExpression>
																									</propertyReferenceExpression>
																									<propertyReferenceExpression name="Boolean">
																										<typeReferenceExpression type="JTokenType"/>
																									</propertyReferenceExpression>
																								</binaryOperatorExpression>
																							</binaryOperatorExpression>
																							<convertExpression to="Boolean">
																								<propertyReferenceExpression name="Value">
																									<variableReferenceExpression name="p"/>
																								</propertyReferenceExpression>
																							</convertExpression>
																						</binaryOperatorExpression>
																					</condition>
																					<trueStatements>
																						<methodInvokeExpression methodName="Add">
																							<target>
																								<variableReferenceExpression name="methods"/>
																							</target>
																							<parameters>
																								<propertyReferenceExpression name="Name">
																									<variableReferenceExpression name="p"/>
																								</propertyReferenceExpression>
																							</parameters>
																						</methodInvokeExpression>
																					</trueStatements>
																				</conditionStatement>
																			</statements>
																		</foreachStatement>
																	</trueStatements>
																</conditionStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueEquality">
																			<propertyReferenceExpression name="Count">
																				<variableReferenceExpression name="methods"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="0"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<variableReferenceExpression name="methods"/>
																			</target>
																			<parameters>
																				<primitiveExpression value="email"/>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
																<comment>save the 2FA setup data</comment>
																<variableDeclarationStatement name="setupData">
																	<init>
																		<castExpression targetType="JObject">
																			<variableReferenceExpression name="setupObject"/>
																		</castExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement name="backupCodes">
																	<init>
																		<castExpression targetType="JArray">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="setupData"/>
																				</target>
																				<indices>
																					<primitiveExpression value="backupCodes"/>
																				</indices>
																			</arrayIndexerExpression>
																		</castExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="IdentityEquality">
																			<variableReferenceExpression name="backupCodes"/>
																			<primitiveExpression value="null"/>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="backupCodes"/>
																			<objectCreateExpression type="JArray"/>
																		</assignStatement>
																	</trueStatements>
																</conditionStatement>
																<methodInvokeExpression methodName="OtpAuth">
																	<parameters>
																		<argumentReferenceExpression name="username"/>
																		<stringFormatExpression>
																			<xsl:attribute name="format"><![CDATA[null;otpauth:totp;exec:setup;passcode:{0};trustThisDevice:false;url:{1};backupCodes:{2};methods:{3};]]></xsl:attribute>
																			<propertyReferenceExpression name="ValidationKey">
																				<typeReferenceExpression type="ApplicationServices"/>
																			</propertyReferenceExpression>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="setupData"/>
																				</target>
																				<indices>
																					<primitiveExpression value="url"/>
																				</indices>
																			</arrayIndexerExpression>
																			<methodInvokeExpression methodName="Join">
																				<target>
																					<typeReferenceExpression type="System.String"/>
																				</target>
																				<parameters>
																					<primitiveExpression value=", "/>
																					<variableReferenceExpression name="backupCodes"/>
																				</parameters>
																			</methodInvokeExpression>
																			<methodInvokeExpression methodName="Join">
																				<target>
																					<typeReferenceExpression type="System.String"/>
																				</target>
																				<parameters>
																					<primitiveExpression value=","/>
																					<methodInvokeExpression methodName="ToArray">
																						<target>
																							<variableReferenceExpression name="methods"/>
																						</target>
																					</methodInvokeExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</stringFormatExpression>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</statements>
											<catch exceptionType="Exception">
												<comment>ignore all errors</comment>
											</catch>
										</tryStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method AllowUserLoginResponse(string, JObject) -->
						<memberMethod returnType="System.Boolean" name="AllowUserLoginResponse">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="JObject" name="response"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="ValueEquality">
											<convertExpression to="String">
												<arrayIndexerExpression>
													<target>
														<argumentReferenceExpression name="response"/>
													</target>
													<indices>
														<primitiveExpression value="event"/>
													</indices>
												</arrayIndexerExpression>
											</convertExpression>
											<primitiveExpression value="otpauth.app"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="OtpAuthenticationTrustThisDevice">
													<parameters>
														<argumentReferenceExpression name="username"/>
														<primitiveExpression value="null"/>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="false"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="true"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method EncodeContactInformation(JToken, string) -->
						<memberMethod returnType="JToken" name="EncodeContactInformation">
							<attributes public="true" static="true"/>
							<parameters>
								<parameter type="JToken" name="contacts"/>
								<parameter type="System.String" name="type"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="Not">
											<binaryOperatorExpression operator="IsTypeOf">
												<argumentReferenceExpression name="contacts"/>
												<typeReferenceExpression type="JArray"/>
											</binaryOperatorExpression>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="contacts"/>
											<objectCreateExpression type="JArray">
												<parameters>
													<argumentReferenceExpression name="contacts"/>
												</parameters>
											</objectCreateExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<forStatement>
									<variable name="i">
										<init>
											<primitiveExpression value="0"/>
										</init>
									</variable>
									<test>
										<binaryOperatorExpression operator="LessThan">
											<variableReferenceExpression name="i"/>
											<methodInvokeExpression methodName="Count">
												<target>
													<variableReferenceExpression name="contacts"/>
												</target>
											</methodInvokeExpression>
										</binaryOperatorExpression>
									</test>
									<increment>
										<variableReferenceExpression name="i"/>
									</increment>
									<statements>
										<variableDeclarationStatement name="text">
											<init>
												<convertExpression to="String">
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="contacts"/>
														</target>
														<indices>
															<variableReferenceExpression name="i"/>
														</indices>
													</arrayIndexerExpression>
												</convertExpression>
											</init>
										</variableDeclarationStatement>
										<variableDeclarationStatement name="encodedContact">
											<init>
												<objectCreateExpression type="JObject">
													<parameters>
														<objectCreateExpression type="JProperty">
															<parameters>
																<primitiveExpression value="value"/>
																<methodInvokeExpression methodName="Hash">
																	<target>
																		<typeReferenceExpression type="TextUtility"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="text"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</objectCreateExpression>
														<objectCreateExpression type="JProperty">
															<parameters>
																<primitiveExpression value="type"/>
																<variableReferenceExpression name="type"/>
															</parameters>
														</objectCreateExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variableDeclarationStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="contacts"/>
												</target>
												<indices>
													<variableReferenceExpression name="i"/>
												</indices>
											</arrayIndexerExpression>
											<variableReferenceExpression name="encodedContact"/>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanOr">
													<binaryOperatorExpression operator="ValueEquality">
														<argumentReferenceExpression name="type"/>
														<primitiveExpression value="call"/>
													</binaryOperatorExpression>
													<binaryOperatorExpression operator="ValueEquality">
														<variableReferenceExpression name="type"/>
														<primitiveExpression value="sms"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="phone">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="text"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[^(.+?)(.{4})$]]></xsl:attribute>
																</primitiveExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="Success">
															<variableReferenceExpression name="phone"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="text"/>
															<binaryOperatorExpression operator="Add">
																<methodInvokeExpression methodName="Replace">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="phone"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="1"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																		<primitiveExpression value="\d"/>
																		<primitiveExpression value="x"/>
																	</parameters>
																</methodInvokeExpression>
																<propertyReferenceExpression name="Value">
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="Groups">
																				<variableReferenceExpression name="phone"/>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="2"/>
																		</indices>
																	</arrayIndexerExpression>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
											<falseStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="ValueEquality">
															<argumentReferenceExpression name="type"/>
															<primitiveExpression value="email"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<variableDeclarationStatement name="email">
															<init>
																<methodInvokeExpression methodName="Match">
																	<target>
																		<typeReferenceExpression type="Regex"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="text"/>
																		<primitiveExpression>
																			<xsl:attribute name="value"><![CDATA[^(.)(.+?)(.@.+)$]]></xsl:attribute>
																		</primitiveExpression>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<propertyReferenceExpression name="Success">
																	<variableReferenceExpression name="email"/>
																</propertyReferenceExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<variableReferenceExpression name="text"/>
																	<binaryOperatorExpression operator="Add">
																		<binaryOperatorExpression operator="Add">
																			<propertyReferenceExpression name="Value">
																				<arrayIndexerExpression>
																					<target>
																						<propertyReferenceExpression name="Groups">
																							<variableReferenceExpression name="email"/>
																						</propertyReferenceExpression>
																					</target>
																					<indices>
																						<primitiveExpression value="1"/>
																					</indices>
																				</arrayIndexerExpression>
																			</propertyReferenceExpression>
																			<primitiveExpression value="..."/>
																		</binaryOperatorExpression>
																		<propertyReferenceExpression name="Value">
																			<arrayIndexerExpression>
																				<target>
																					<propertyReferenceExpression name="Groups">
																						<variableReferenceExpression name="email"/>
																					</propertyReferenceExpression>
																				</target>
																				<indices>
																					<primitiveExpression value="3"/>
																				</indices>
																			</arrayIndexerExpression>
																		</propertyReferenceExpression>
																	</binaryOperatorExpression>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</falseStatements>
										</conditionStatement>
										<methodInvokeExpression methodName="Add">
											<target>
												<variableReferenceExpression name="encodedContact"/>
											</target>
											<parameters>
												<objectCreateExpression type="JProperty">
													<parameters>
														<primitiveExpression value="text"/>
														<variableReferenceExpression name="text"/>
													</parameters>
												</objectCreateExpression>
											</parameters>
										</methodInvokeExpression>
									</statements>
								</forStatement>
								<methodReturnStatement>
									<argumentReferenceExpression name="contacts"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method UserAuthenticationData(string) -->
						<memberMethod returnType="JObject" name="UserAuthenticationData">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="UserAuthenticationData">
										<parameters>
											<argumentReferenceExpression name="username"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method UserAuthentiationData(string, JObject) -->
						<memberMethod returnType="JObject" name="UserAuthenticationData">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="JObject" name="newData"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="JObject" name="data" var="false">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="user">
									<init>
										<methodInvokeExpression methodName="GetUser">
											<target>
												<typeReferenceExpression type="Membership"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="username"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="user"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="data"/>
											<methodInvokeExpression methodName="ParseYamlOrJson">
												<target>
													<typeReferenceExpression type="TextUtility"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="ReadUserAuthenticationData">
														<parameters>
															<argumentReferenceExpression name="user"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="IdentityInequality">
													<argumentReferenceExpression name="newData"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="data"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<variableReferenceExpression name="data"/>
															<argumentReferenceExpression name="newData"/>
														</assignStatement>
													</trueStatements>
													<falseStatements>
														<foreachStatement>
															<variable type="JProperty" name="p" var="false"/>
															<target>
																<methodInvokeExpression methodName="Properties">
																	<target>
																		<argumentReferenceExpression name="newData"/>
																	</target>
																</methodInvokeExpression>
															</target>
															<statements>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="ValueInequality">
																			<propertyReferenceExpression name="Type">
																				<propertyReferenceExpression name="Value">
																					<variableReferenceExpression name="p"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="Null">
																				<typeReferenceExpression type="JTokenType"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="data"/>
																				</target>
																				<indices>
																					<propertyReferenceExpression name="Name">
																						<variableReferenceExpression name="p"/>
																					</propertyReferenceExpression>
																				</indices>
																			</arrayIndexerExpression>
																			<convertExpression to="String">
																				<propertyReferenceExpression name="Value">
																					<variableReferenceExpression name="p"/>
																				</propertyReferenceExpression>
																			</convertExpression>
																		</assignStatement>
																	</trueStatements>
																	<falseStatements>
																		<methodInvokeExpression methodName="Remove">
																			<target>
																				<variableReferenceExpression name="data"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="p"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</falseStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
													</falseStatements>
												</conditionStatement>
												<methodInvokeExpression methodName="Remove">
													<target>
														<variableReferenceExpression name="data"/>
													</target>
													<parameters>
														<primitiveExpression value="error"/>
													</parameters>
												</methodInvokeExpression>
												<methodInvokeExpression methodName="WriteUserAuthenticationData">
													<parameters>
														<variableReferenceExpression name="user"/>
														<methodInvokeExpression methodName="ToYamlString">
															<target>
																<typeReferenceExpression type="TextUtility"/>
															</target>
															<parameters>
																<variableReferenceExpression name="data"/>
															</parameters>
														</methodInvokeExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="data"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method ReadUserAuthenticationData(MembershipUser) -->
						<memberMethod returnType="System.String" name="ReadUserAuthenticationData">
							<attributes family="true"/>
							<parameters>
								<parameter type="MembershipUser" name="user"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<propertyReferenceExpression name="Comment">
										<argumentReferenceExpression name="user"/>
									</propertyReferenceExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method WriteUserAuthenticationData(MembershipUser, string) -->
						<memberMethod name="WriteUserAuthenticationData">
							<attributes family="true"/>
							<parameters>
								<parameter type="MembershipUser" name="user"/>
								<parameter type="System.String" name="data"/>
							</parameters>
							<statements>
								<assignStatement>
									<propertyReferenceExpression name="Comment">
										<argumentReferenceExpression name="user"/>
									</propertyReferenceExpression>
									<argumentReferenceExpression name="data"/>
								</assignStatement>
								<methodInvokeExpression methodName="UpdateUser">
									<target>
										<typeReferenceExpression type="Membership"/>
									</target>
									<parameters>
										<argumentReferenceExpression name="user"/>
									</parameters>
								</methodInvokeExpression>
							</statements>
						</memberMethod>
						<!-- method AppDataWriteAllBytes(string, byte[]) -->
						<memberMethod name="AppDataWriteAllBytes">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="path"/>
								<parameter type="System.Byte[]" name="data"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsSiteContentEnabled"/>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="WriteAllBytes">
											<target>
												<typeReferenceExpression type="SiteContentFile"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="path"/>
												<methodInvokeExpression methodName="GetMimeMapping">
													<target>
														<typeReferenceExpression type="MimeMapping"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="path"/>
													</parameters>
												</methodInvokeExpression>
												<argumentReferenceExpression name="data"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method AppDataWriteAllText(string, string) -->
						<memberMethod name="AppDataWriteAllText">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="path"/>
								<parameter type="System.String" name="data"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsSiteContentEnabled"/>
									</condition>
									<trueStatements>
										<methodInvokeExpression methodName="WriteAllText">
											<target>
												<typeReferenceExpression type="SiteContentFile"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="path"/>
												<methodInvokeExpression methodName="GetMimeMapping">
													<target>
														<typeReferenceExpression type="MimeMapping"/>
													</target>
													<parameters>
														<argumentReferenceExpression name="path"/>
													</parameters>
												</methodInvokeExpression>
												<argumentReferenceExpression name="data"/>
											</parameters>
										</methodInvokeExpression>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method AppDataSearch(string, string) -->
						<memberMethod returnType="System.String[]" name="AppDataSearch">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="path"/>
								<parameter type="System.String" name="filename"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="AppDataSearch">
										<parameters>
											<argumentReferenceExpression name="path"/>
											<argumentReferenceExpression name="filename"/>
											<propertyReferenceExpression name="MaxValue">
												<typeReferenceExpression type="Int32"/>
											</propertyReferenceExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AppDataSearch(string, string, int) -->
						<memberMethod returnType="System.String[]" name="AppDataSearch">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="path"/>
								<parameter type="System.String" name="filename"/>
								<parameter type="System.Int32" name="maxCount"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="AppDataSearch">
										<parameters>
											<argumentReferenceExpression name="path"/>
											<argumentReferenceExpression name="filename"/>
											<argumentReferenceExpression name="maxCount"/>
											<primitiveExpression value="null"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AppDataSearch(string, string, int) -->
						<memberMethod returnType="System.String[]" name="AppDataSearch">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="path"/>
								<parameter type="System.String" name="filename"/>
								<parameter type="System.Int32" name="maxCount"/>
								<parameter type="Nullable" name="modified">
									<typeArguments>
										<typeReference type="DateTime"/>
									</typeArguments>
								</parameter>
							</parameters>
							<statements>
								<variableDeclarationStatement name="files">
									<init>
										<objectCreateExpression type="List">
											<typeArguments>
												<typeReference type="System.String"/>
											</typeArguments>
										</objectCreateExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsSiteContentEnabled"/>
									</condition>
									<trueStatements>
										<foreachStatement>
											<variable name="f"/>
											<target>
												<methodInvokeExpression methodName="ReadSiteContent">
													<parameters>
														<argumentReferenceExpression name="path"/>
														<argumentReferenceExpression name="filename"/>
														<argumentReferenceExpression name="maxCount"/>
														<argumentReferenceExpression name="modified"/>
													</parameters>
												</methodInvokeExpression>
											</target>
											<statements>
												<methodInvokeExpression methodName="Add">
													<target>
														<variableReferenceExpression name="files"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="FullName">
															<variableReferenceExpression name="f"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</statements>
										</foreachStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="ToArray">
										<target>
											<variableReferenceExpression name="files"/>
										</target>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AppDataReadAllBytes(string) -->
						<memberMethod returnType="System.Byte[]" name="AppDataReadAllBytes">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="path"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsSiteContentEnabled"/>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ReadAllBytes">
												<target>
													<typeReferenceExpression type="SiteContentFile"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="path"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AppDataReadAllText(string) -->
						<memberMethod returnType="System.String" name="AppDataReadAllText">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="path"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsSiteContentEnabled"/>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="ReadAllText">
												<target>
													<typeReferenceExpression type="SiteContentFile"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="path"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="null"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AppDataDelete(string) -->
						<memberMethod returnType="System.Int32" name="AppDataDelete">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="path"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsSiteContentEnabled"/>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="Delete">
												<target>
													<typeReferenceExpression type="SiteContentFile"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="path"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="0"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method AppDataExists(string) -->
						<memberMethod returnType="System.Boolean" name="AppDataExists">
							<attributes public="true"/>
							<parameters>
								<parameter type="System.String" name="path"/>
							</parameters>
							<statements>
								<conditionStatement>
									<condition>
										<propertyReferenceExpression name="IsSiteContentEnabled"/>
									</condition>
									<trueStatements>
										<methodReturnStatement>
											<methodInvokeExpression methodName="Exists">
												<target>
													<typeReferenceExpression type="SiteContentFile"/>
												</target>
												<parameters>
													<argumentReferenceExpression name="path"/>
												</parameters>
											</methodInvokeExpression>
										</methodReturnStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OtpAuthenticationData(string) -->
						<memberMethod returnType="JObject" name="OtpAuthenticationData">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
							</parameters>
							<statements>
								<methodReturnStatement>
									<methodInvokeExpression methodName="OtpAuthenticationData">
										<parameters>
											<argumentReferenceExpression name="username"/>
											<castExpression targetType="JObject">
												<primitiveExpression value="null"/>
											</castExpression>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OtpAuthenticationData(string, string) -->
						<memberMethod returnType="JObject" name="OtpAuthenticationData">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="System.String" name="otpauthUrl"/>
							</parameters>
							<statements>
								<variableDeclarationStatement type="JObject" name="userAuthData" var="false">
									<init>
										<primitiveExpression value="null"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNotNullOrEmpty">
											<argumentReferenceExpression name="otpauthUrl"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="userAuthData"/>
											<objectCreateExpression type="JObject"/>
										</assignStatement>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="userAuthData"/>
												</target>
												<indices>
													<primitiveExpression value="2FA"/>
												</indices>
											</arrayIndexerExpression>
											<argumentReferenceExpression name="otpauthUrl"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<methodInvokeExpression methodName="OtpAuthenticationData">
										<parameters>
											<argumentReferenceExpression name="username"/>
											<variableReferenceExpression name="userAuthData"/>
										</parameters>
									</methodInvokeExpression>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OtpAuthenticationData(string, JObject) -->
						<memberMethod returnType="JObject" name="OtpAuthenticationData">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="JObject" name="userAuthData"/>
							</parameters>
							<statements>
								<variableDeclarationStatement name="otpData">
									<init>
										<objectCreateExpression type="JObject"/>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityEquality">
											<argumentReferenceExpression name="userAuthData"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<argumentReferenceExpression name="userAuthData"/>
											<methodInvokeExpression methodName="UserAuthenticationData">
												<parameters>
													<argumentReferenceExpression name="username"/>
												</parameters>
											</methodInvokeExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<argumentReferenceExpression name="userAuthData"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<convertExpression to="Boolean">
												<methodInvokeExpression methodName="SettingsProperty">
													<parameters>
														<primitiveExpression value="server.2FA.enabled"/>
														<primitiveExpression value="true"/>
													</parameters>
												</methodInvokeExpression>
											</convertExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<variableDeclarationStatement name="otpauth">
											<init>
												<convertExpression to="String">
													<arrayIndexerExpression>
														<target>
															<argumentReferenceExpression name="userAuthData"/>
														</target>
														<indices>
															<primitiveExpression value="2FA"/>
														</indices>
													</arrayIndexerExpression>
												</convertExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="otpauth"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="otpAuthType">
													<init>
														<methodInvokeExpression methodName="Match">
															<target>
																<typeReferenceExpression type="Regex"/>
															</target>
															<parameters>
																<variableReferenceExpression name="otpauth"/>
																<primitiveExpression>
																	<xsl:attribute name="value"><![CDATA[(^|\n)otpauth://(\w+)/]]></xsl:attribute>
																</primitiveExpression>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="Success">
															<variableReferenceExpression name="otpAuthType"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="otpData"/>
																</target>
																<indices>
																	<primitiveExpression value="otpauth"/>
																</indices>
															</arrayIndexerExpression>
															<variableReferenceExpression name="otpauth"/>
														</assignStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="otpData"/>
																</target>
																<indices>
																	<primitiveExpression value="codeLength"/>
																</indices>
															</arrayIndexerExpression>
															<methodInvokeExpression methodName="SettingsProperty">
																<parameters>
																	<primitiveExpression value="server.2FA.code.length"/>
																	<primitiveExpression value="6"/>
																</parameters>
															</methodInvokeExpression>
														</assignStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="GreaterThan">
																	<convertExpression to="Int32">
																		<methodInvokeExpression methodName="SettingsProperty">
																			<parameters>
																				<primitiveExpression value="server.2FA.backupCodes.count"/>
																				<primitiveExpression value="10"/>
																			</parameters>
																		</methodInvokeExpression>
																	</convertExpression>
																	<primitiveExpression value="0"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="backupCodes">
																	<init>
																		<convertExpression to="String">
																			<arrayIndexerExpression>
																				<target>
																					<argumentReferenceExpression name="userAuthData"/>
																				</target>
																				<indices>
																					<primitiveExpression value="Backup Codes"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</init>
																</variableDeclarationStatement>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="otpData"/>
																		</target>
																		<indices>
																			<primitiveExpression value="backupCodes"/>
																		</indices>
																	</arrayIndexerExpression>
																	<variableReferenceExpression name="backupCodes"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="otpData"/>
																</target>
																<indices>
																	<primitiveExpression value="type"/>
																</indices>
															</arrayIndexerExpression>
															<propertyReferenceExpression name="Value">
																<arrayIndexerExpression>
																	<target>
																		<propertyReferenceExpression name="Groups">
																			<variableReferenceExpression name="otpAuthType"/>
																		</propertyReferenceExpression>
																	</target>
																	<indices>
																		<primitiveExpression value="2"/>
																	</indices>
																</arrayIndexerExpression>
															</propertyReferenceExpression>
														</assignStatement>
														<comment>Verification methods must be enabled in the app and selected by the user during the setup.</comment>
														<variableDeclarationStatement name="verify">
															<init>
																<objectCreateExpression type="JObject"/>
															</init>
														</variableDeclarationStatement>
														<assignStatement>
															<arrayIndexerExpression>
																<target>
																	<variableReferenceExpression name="otpData"/>
																</target>
																<indices>
																	<primitiveExpression value="verify"/>
																</indices>
															</arrayIndexerExpression>
															<variableReferenceExpression name="verify"/>
														</assignStatement>
														<methodInvokeExpression methodName="OtpVerificationData">
															<parameters>
																<argumentReferenceExpression name="username"/>
																<variableReferenceExpression name="verify"/>
															</parameters>
														</methodInvokeExpression>
														<variableDeclarationStatement name="allowedMethods">
															<init>
																<objectCreateExpression type="List">
																	<typeArguments>
																		<typeReference type="System.String"/>
																	</typeArguments>
																</objectCreateExpression>
															</init>
														</variableDeclarationStatement>
														<variableDeclarationStatement name="methodsToRemove">
															<init>
																<objectCreateExpression type="List">
																	<typeArguments>
																		<typeReference type="System.String"/>
																	</typeArguments>
																</objectCreateExpression>
															</init>
														</variableDeclarationStatement>
														<comment>application-approved methods</comment>
														<conditionStatement>
															<condition>
																<convertExpression to="Boolean">
																	<methodInvokeExpression methodName="SettingsProperty">
																		<parameters>
																			<primitiveExpression value="server.2FA.verify.app"/>
																			<primitiveExpression value="true"/>
																		</parameters>
																	</methodInvokeExpression>
																</convertExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="allowedMethods"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="app"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<convertExpression to="Boolean">
																	<methodInvokeExpression methodName="SettingsProperty">
																		<parameters>
																			<primitiveExpression value="server.2FA.verify.email"/>
																			<primitiveExpression value="true"/>
																		</parameters>
																	</methodInvokeExpression>
																</convertExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="allowedMethods"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="email"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<convertExpression to="Boolean">
																	<methodInvokeExpression methodName="SettingsProperty">
																		<parameters>
																			<primitiveExpression value="server.2FA.verify.call"/>
																			<primitiveExpression value="false"/>
																		</parameters>
																	</methodInvokeExpression>
																</convertExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="allowedMethods"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="call"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<conditionStatement>
															<condition>
																<convertExpression to="Boolean">
																	<methodInvokeExpression methodName="SettingsProperty">
																		<parameters>
																			<primitiveExpression value="server.2FA.verify.sms"/>
																			<primitiveExpression value="false"/>
																		</parameters>
																	</methodInvokeExpression>
																</convertExpression>
															</condition>
															<trueStatements>
																<methodInvokeExpression methodName="Add">
																	<target>
																		<variableReferenceExpression name="allowedMethods"/>
																	</target>
																	<parameters>
																		<primitiveExpression value="sms"/>
																	</parameters>
																</methodInvokeExpression>
															</trueStatements>
														</conditionStatement>
														<comment>user-approved methods</comment>
														<variableDeclarationStatement name="methods">
															<init>
																<convertExpression to="String">
																	<arrayIndexerExpression>
																		<target>
																			<argumentReferenceExpression name="userAuthData"/>
																		</target>
																		<indices>
																			<primitiveExpression value="Methods"/>
																		</indices>
																	</arrayIndexerExpression>
																</convertExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<variableReferenceExpression name="methods"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="userApprovedMethods">
																	<init>
																		<methodInvokeExpression methodName="Split">
																			<target>
																				<typeReferenceExpression type="Regex"/>
																			</target>
																			<parameters>
																				<argumentReferenceExpression name="methods"/>
																				<primitiveExpression>
																					<xsl:attribute name="value"><![CDATA[\s*,\s*]]></xsl:attribute>
																				</primitiveExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<foreachStatement>
																	<variable name="m"/>
																	<target>
																		<variableReferenceExpression name="allowedMethods"/>
																	</target>
																	<statements>
																		<conditionStatement>
																			<condition>
																				<unaryOperatorExpression operator="Not">
																					<methodInvokeExpression methodName="Contains">
																						<target>
																							<variableReferenceExpression name="userApprovedMethods"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="m"/>
																						</parameters>
																					</methodInvokeExpression>
																				</unaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<methodInvokeExpression methodName="Add">
																					<target>
																						<variableReferenceExpression name="methodsToRemove"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="m"/>
																					</parameters>
																				</methodInvokeExpression>
																			</trueStatements>
																		</conditionStatement>
																	</statements>
																</foreachStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="GreaterThan">
																			<propertyReferenceExpression name="Count">
																				<variableReferenceExpression name="allowedMethods"/>
																			</propertyReferenceExpression>
																			<propertyReferenceExpression name="Count">
																				<variableReferenceExpression name="methodsToRemove"/>
																			</propertyReferenceExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<foreachStatement>
																			<variable name="m"/>
																			<target>
																				<variableReferenceExpression name="methodsToRemove"/>
																			</target>
																			<statements>
																				<methodInvokeExpression methodName="Remove">
																					<target>
																						<variableReferenceExpression name="allowedMethods"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="m"/>
																					</parameters>
																				</methodInvokeExpression>
																			</statements>
																		</foreachStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
														<comment>keep the allowed verification methods</comment>
														<methodInvokeExpression methodName="Clear">
															<target>
																<variableReferenceExpression name="methodsToRemove"/>
															</target>
														</methodInvokeExpression>
														<foreachStatement>
															<variable name="p"/>
															<target>
																<methodInvokeExpression methodName="Properties">
																	<target>
																		<variableReferenceExpression name="verify"/>
																	</target>
																</methodInvokeExpression>
															</target>
															<statements>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="Not">
																			<methodInvokeExpression methodName="Contains">
																				<target>
																					<variableReferenceExpression name="allowedMethods"/>
																				</target>
																				<parameters>
																					<propertyReferenceExpression name="Name">
																						<variableReferenceExpression name="p"/>
																					</propertyReferenceExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<methodInvokeExpression methodName="Add">
																			<target>
																				<variableReferenceExpression name="methodsToRemove"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="Name">
																					<variableReferenceExpression name="p"/>
																				</propertyReferenceExpression>
																			</parameters>
																		</methodInvokeExpression>
																	</trueStatements>
																</conditionStatement>
															</statements>
														</foreachStatement>
														<foreachStatement>
															<variable name="m"/>
															<target>
																<variableReferenceExpression name="methodsToRemove"/>
															</target>
															<statements>
																<methodInvokeExpression methodName="Remove">
																	<target>
																		<variableReferenceExpression name="verify"/>
																	</target>
																	<parameters>
																		<variableReferenceExpression name="m"/>
																	</parameters>
																</methodInvokeExpression>
															</statements>
														</foreachStatement>
														<comment>add "dial" method of verification unconditionally</comment>
														<variableDeclarationStatement name="dial">
															<init>
																<methodInvokeExpression methodName="SettingsProperty">
																	<parameters>
																		<primitiveExpression value="server.2FA.verify.dial"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="IdentityInequality">
																	<variableReferenceExpression name="dial"/>
																	<primitiveExpression value="null"/>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<assignStatement>
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="verify"/>
																		</target>
																		<indices>
																			<primitiveExpression value="dial"/>
																		</indices>
																	</arrayIndexerExpression>
																	<variableReferenceExpression name="dial"/>
																</assignStatement>
															</trueStatements>
														</conditionStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<variableReferenceExpression name="otpData"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method OtpVerificationData(string, JObject) -->
						<memberMethod name="OtpVerificationData">
							<attributes family="true"/>
							<parameters>
								<parameter type="System.String" name="username"/>
								<parameter type="JObject" name="verify"/>
							</parameters>
							<statements>
								<assignStatement>
									<arrayIndexerExpression>
										<target>
											<argumentReferenceExpression name="verify"/>
										</target>
										<indices>
											<primitiveExpression value="app"/>
										</indices>
									</arrayIndexerExpression>
									<primitiveExpression value="true"/>
								</assignStatement>
								<variableDeclarationStatement name="user">
									<init>
										<methodInvokeExpression methodName="GetUser">
											<target>
												<typeReferenceExpression type="Membership"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="username"/>
											</parameters>
										</methodInvokeExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="BooleanAnd">
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="user"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<propertyReferenceExpression name="Email">
													<variableReferenceExpression name="user"/>
												</propertyReferenceExpression>
											</unaryOperatorExpression>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<arrayIndexerExpression>
												<target>
													<argumentReferenceExpression name="verify"/>
												</target>
												<indices>
													<primitiveExpression value="email"/>
												</indices>
											</arrayIndexerExpression>
											<propertyReferenceExpression name="Email">
												<variableReferenceExpression name="user"/>
											</propertyReferenceExpression>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
							</statements>
						</memberMethod>
						<!-- method ValidateApiKey (HttpApplication) -->
						<memberMethod returnType="System.Boolean" name="ValidateRESTfulApiKey">
							<attributes public="true"/>
							<parameters>
								<parameter type="HttpApplication" name="app"/>
							</parameters>
							<statements>
								<comment>authenticate the user with the API key specified in the header or query</comment>
								<variableDeclarationStatement name="isPublicKey">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="isPathKey">
									<init>
										<primitiveExpression value="false"/>
									</init>
								</variableDeclarationStatement>
								<variableDeclarationStatement name="apiKey">
									<init>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<propertyReferenceExpression name="Request">
														<argumentReferenceExpression name="app"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="x-api-key"/>
											</indices>
										</arrayIndexerExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="apiKey"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="apiKey"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="QueryString">
														<propertyReferenceExpression name="Request">
															<argumentReferenceExpression name="app"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="x-api-key"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="isPublicKey"/>
											<primitiveExpression value="true"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<conditionStatement>
									<condition>
										<unaryOperatorExpression operator="IsNullOrEmpty">
											<variableReferenceExpression name="apiKey"/>
										</unaryOperatorExpression>
									</condition>
									<trueStatements>
										<assignStatement>
											<variableReferenceExpression name="apiKey"/>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="QueryString">
														<propertyReferenceExpression name="Request">
															<argumentReferenceExpression name="app"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="api_key"/>
												</indices>
											</arrayIndexerExpression>
										</assignStatement>
										<assignStatement>
											<variableReferenceExpression name="isPublicKey"/>
											<primitiveExpression value="true"/>
										</assignStatement>
									</trueStatements>
								</conditionStatement>
								<variableDeclarationStatement name="authorizationKeys">
									<init>
										<castExpression targetType="JArray">
											<methodInvokeExpression methodName="SettingsProperty">
												<parameters>
													<primitiveExpression value="server.rest.authorization.keys"/>
												</parameters>
											</methodInvokeExpression>
										</castExpression>
									</init>
								</variableDeclarationStatement>
								<conditionStatement>
									<condition>
										<binaryOperatorExpression operator="IdentityInequality">
											<variableReferenceExpression name="authorizationKeys"/>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</condition>
									<trueStatements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<variableReferenceExpression name="apiKey"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="executionPath">
													<init>
														<propertyReferenceExpression name="CurrentExecutionFilePath">
															<propertyReferenceExpression name="Request">
																<argumentReferenceExpression name="app"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</init>
												</variableDeclarationStatement>
												<foreachStatement>
													<variable name="key"/>
													<target>
														<variableReferenceExpression name="authorizationKeys"/>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="Type">
																		<variableReferenceExpression name="key"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="Object">
																		<typeReferenceExpression type="JTokenType"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="k">
																	<init>
																		<convertExpression to="String">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="key"/>
																				</target>
																				<indices>
																					<primitiveExpression value="key"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<binaryOperatorExpression operator="BooleanOr">
																			<binaryOperatorExpression operator="ValueEquality">
																				<variableReferenceExpression name="executionPath"/>
																				<binaryOperatorExpression operator="Add">
																					<primitiveExpression value="/v2/"/>
																					<variableReferenceExpression name="k"/>
																				</binaryOperatorExpression>
																			</binaryOperatorExpression>
																			<methodInvokeExpression methodName="StartsWith">
																				<target>
																					<variableReferenceExpression name="executionPath"/>
																				</target>
																				<parameters>
																					<stringFormatExpression format="/v2/{{0}}/">
																						<variableReferenceExpression name="k"/>
																					</stringFormatExpression>
																				</parameters>
																			</methodInvokeExpression>
																		</binaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<assignStatement>
																			<variableReferenceExpression name="apiKey"/>
																			<variableReferenceExpression name="k"/>
																		</assignStatement>
																		<assignStatement>
																			<variableReferenceExpression name="isPublicKey"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																		<assignStatement>
																			<variableReferenceExpression name="isPathKey"/>
																			<primitiveExpression value="true"/>
																		</assignStatement>
																		<breakStatement/>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="apiKey"/>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable name="keyUser"/>
													<target>
														<variableReferenceExpression name="authorizationKeys"/>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<methodInvokeExpression methodName="Equals">
																	<target>
																		<variableReferenceExpression name="apiKey"/>
																	</target>
																	<parameters>
																		<convertExpression to="String">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="keyUser"/>
																				</target>
																				<indices>
																					<primitiveExpression value="key"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</parameters>
																</methodInvokeExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement name="username">
																	<init>
																		<convertExpression to="String">
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="keyUser"/>
																				</target>
																				<indices>
																					<primitiveExpression value="user"/>
																				</indices>
																			</arrayIndexerExpression>
																		</convertExpression>
																	</init>
																</variableDeclarationStatement>
																<conditionStatement>
																	<condition>
																		<unaryOperatorExpression operator="IsNotNullOrEmpty">
																			<variableReferenceExpression name="username"/>
																		</unaryOperatorExpression>
																	</condition>
																	<trueStatements>
																		<variableDeclarationStatement name="user">
																			<init>
																				<methodInvokeExpression methodName="GetUser">
																					<target>
																						<typeReferenceExpression type="Membership"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="username"/>
																					</parameters>
																				</methodInvokeExpression>
																			</init>
																		</variableDeclarationStatement>
																		<conditionStatement>
																			<condition>
																				<binaryOperatorExpression operator="IdentityInequality">
																					<variableReferenceExpression name="user"/>
																					<primitiveExpression value="null"/>
																				</binaryOperatorExpression>
																			</condition>
																			<trueStatements>
																				<conditionStatement>
																					<condition>
																						<variableReferenceExpression name="isPublicKey"/>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<propertyReferenceExpression name="PublicApiKey">
																								<typeReferenceExpression type="RESTfulResource"/>
																							</propertyReferenceExpression>
																							<variableReferenceExpression name="apiKey"/>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																				<conditionStatement>
																					<condition>
																						<variableReferenceExpression name="isPathKey"/>
																					</condition>
																					<trueStatements>
																						<assignStatement>
																							<propertyReferenceExpression name="PublicApiKeyInPath">
																								<typeReferenceExpression type="RESTfulResource"/>
																							</propertyReferenceExpression>
																							<variableReferenceExpression name="apiKey"/>
																						</assignStatement>
																					</trueStatements>
																				</conditionStatement>
																				<assignStatement>
																					<propertyReferenceExpression name="User">
																						<propertyReferenceExpression name="Context">
																							<argumentReferenceExpression name="app"/>
																						</propertyReferenceExpression>
																					</propertyReferenceExpression>
																					<objectCreateExpression type="RolePrincipal">
																						<parameters>
																							<objectCreateExpression type="FormsIdentity">
																								<parameters>
																									<objectCreateExpression type="FormsAuthenticationTicket">
																										<parameters>
																											<propertyReferenceExpression name="UserName">
																												<variableReferenceExpression name="user"/>
																											</propertyReferenceExpression>
																											<primitiveExpression value="false"/>
																											<primitiveExpression value="10"/>
																										</parameters>
																									</objectCreateExpression>
																								</parameters>
																							</objectCreateExpression>
																						</parameters>
																					</objectCreateExpression>
																				</assignStatement>
																				<methodReturnStatement>
																					<primitiveExpression value="true"/>
																				</methodReturnStatement>
																			</trueStatements>
																		</conditionStatement>
																	</trueStatements>
																</conditionStatement>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
									</trueStatements>
								</conditionStatement>
								<methodReturnStatement>
									<primitiveExpression value="false"/>
								</methodReturnStatement>
							</statements>
						</memberMethod>
						<!-- method EnumerateIdClaims(MembershipUser, JObject, List<string>) -->
						<memberMethod name="EnumerateIdClaims">
							<attributes public="true"/>
							<parameters>
								<parameter type="MembershipUser" name="user"/>
								<parameter type="JObject" name="claims"/>
								<parameter type="List" name="scopes">
									<typeArguments>
										<typeReference type="System.String"/>
									</typeArguments>
								</parameter>
							</parameters>
						</memberMethod>
					</members>
				</typeDeclaration>
				<xsl:if test="$MembershipEnabled='true' or $CustomSecurity='true'">
					<!-- class OAuthHandler-->
					<typeDeclaration name="OAuthHandler">
						<attributes abstract="true" public="true"/>
						<members>
							<!-- field StartPage-->
							<memberField type="System.String" name="StartPage">
								<attributes public="true"/>
							</memberField>
							<!-- field _refreshedToken-->
							<memberField type="System.Boolean" name="refreshedToken">
								<attributes private="true"/>
								<init>
									<primitiveExpression value="false"/>
								</init>
							</memberField>
							<xsl:if test="$SiteContentTableName!=''">
								<!-- field saasFile-->
								<memberField type="SiteContentFile" name="saasFile">
									<attributes private="true"/>
								</memberField>
							</xsl:if>
							<!-- field clientUri-->
							<memberField type="System.String" name="clientUri"/>
							<!-- property ClientUri-->
							<memberProperty type="System.String" name="ClientUri">
								<attributes public="true"/>
								<getStatements>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<unaryOperatorExpression operator="IsNullOrEmpty">
													<fieldReferenceExpression name="clientUri"/>
												</unaryOperatorExpression>
												<propertyReferenceExpression name="IsSiteContentEnabled">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="clientUri"/>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Config"/>
													</target>
													<indices>
														<primitiveExpression value="Client Uri"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="Not">
														<methodInvokeExpression methodName="StartsWith">
															<target>
																<fieldReferenceExpression name="clientUri"/>
															</target>
															<parameters>
																<primitiveExpression value="http"/>
															</parameters>
														</methodInvokeExpression>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<fieldReferenceExpression name="clientUri"/>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="https://"/>
															<fieldReferenceExpression name="clientUri"/>
														</binaryOperatorExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<fieldReferenceExpression name="clientUri"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- field config-->
							<memberField type="SaasConfiguration" name="config">
								<attributes private="true"/>
								<init>
									<primitiveExpression value="null"/>
								</init>
							</memberField>
							<!-- property Config-->
							<memberProperty type="SaasConfiguration" name="Config">
								<attributes public="true"/>
								<getStatements>
									<xsl:if test="$SiteContentTableName!=''">
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<binaryOperatorExpression operator="IdentityEquality">
														<fieldReferenceExpression name="config"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
													<propertyReferenceExpression name="IsSiteContentEnabled">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<fieldReferenceExpression name="saasFile"/>
													<methodInvokeExpression methodName="ReadSiteContent">
														<target>
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="ApplicationServices"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<binaryOperatorExpression operator="Add">
																<binaryOperatorExpression operator="Add">
																	<methodInvokeExpression methodName="GetSiteContentBasePath"/>
																	<primitiveExpression value="/"/>
																</binaryOperatorExpression>
																<methodInvokeExpression methodName="ToLower">
																	<target>
																		<methodInvokeExpression methodName="GetHandlerName"/>
																	</target>
																</methodInvokeExpression>
															</binaryOperatorExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="IdentityInequality">
															<fieldReferenceExpression name="saasFile"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<fieldReferenceExpression name="_config"/>
															<objectCreateExpression type="SaasConfiguration">
																<parameters>
																	<propertyReferenceExpression name="Text">
																		<fieldReferenceExpression name="saasFile"/>
																	</propertyReferenceExpression>
																</parameters>
															</objectCreateExpression>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
									</xsl:if>
									<methodReturnStatement>
										<fieldReferenceExpression name="config"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- property Tokens -->
							<memberProperty name="Tokens" type="JObject">
								<attributes family="true"/>
							</memberProperty>
							<!-- property StoreToken-->
							<memberProperty name="StoreToken" type="System.Boolean">
								<attributes family="true"/>
							</memberProperty>
							<!-- property Scope-->
							<memberProperty name="Scope" type="System.String">
								<attributes family="true"/>
								<getStatements>
									<methodReturnStatement>
										<stringEmptyExpression/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<memberProperty type="System.String" name="AppState">
								<attributes public="true" final="true"/>
							</memberProperty>
							<!-- method ProcessRequest(HttpContext)-->
							<memberMethod name="ProcessRequest">
								<attributes public="true"/>
								<parameters>
									<parameter type="HttpContext" name="context"/>
								</parameters>
								<statements>
									<tryStatement>
										<statements>
											<variableDeclarationStatement type="ApplicationServices" name="services">
												<init>
													<methodInvokeExpression methodName="Create">
														<target>
															<typeReferenceExpression type="ApplicationServices"/>
														</target>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<assignStatement>
												<propertyReferenceExpression name="StartPage"/>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<propertyReferenceExpression name="Request">
																<argumentReferenceExpression name="context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="start"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNullOrEmpty">
														<propertyReferenceExpression name="StartPage"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="StartPage"/>
														<methodInvokeExpression methodName="UserHomePageUrl">
															<target>
																<variableReferenceExpression name="services"/>
															</target>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<variableDeclarationStatement type="System.String" name="state">
												<init>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="QueryString">
																<propertyReferenceExpression name="Request">
																	<argumentReferenceExpression name="context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</target>
														<indices>
															<primitiveExpression value="state"/>
														</indices>
													</arrayIndexerExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="state"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="SetState">
														<parameters>
															<variableReferenceExpression name="state"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<methodInvokeExpression methodName="RestoreSession">
												<parameters>
													<variableReferenceExpression name="context"/>
												</parameters>
											</methodInvokeExpression>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityEquality">
														<propertyReferenceExpression name="Config"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<throwExceptionStatement>
														<objectCreateExpression type="Exception">
															<parameters>
																<primitiveExpression value="Provider not found."/>
															</parameters>
														</objectCreateExpression>
													</throwExceptionStatement>
												</trueStatements>
												<falseStatements>
													<variableDeclarationStatement type="System.String" name="code">
														<init>
															<methodInvokeExpression methodName="GetAuthCode">
																<parameters>
																	<propertyReferenceExpression name="Request">
																		<variableReferenceExpression name="context"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<unaryOperatorExpression operator="IsNullOrEmpty">
																<variableReferenceExpression name="code"/>
															</unaryOperatorExpression>
														</condition>
														<trueStatements>
															<variableDeclarationStatement type="System.String" name="er">
																<init>
																	<arrayIndexerExpression>
																		<target>
																			<propertyReferenceExpression name="QueryString">
																				<propertyReferenceExpression name="Request">
																					<argumentReferenceExpression name="context"/>
																				</propertyReferenceExpression>
																			</propertyReferenceExpression>
																		</target>
																		<indices>
																			<primitiveExpression value="error"/>
																		</indices>
																	</arrayIndexerExpression>
																</init>
															</variableDeclarationStatement>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<variableReferenceExpression name="er"/>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<methodInvokeExpression methodName="HandleError">
																		<parameters>
																			<variableReferenceExpression name="context"/>
																		</parameters>
																	</methodInvokeExpression>
																</trueStatements>
																<falseStatements>
																	<methodInvokeExpression methodName="Redirect">
																		<target>
																			<propertyReferenceExpression name="Response">
																				<variableReferenceExpression name="context"/>
																			</propertyReferenceExpression>
																		</target>
																		<parameters>
																			<methodInvokeExpression methodName="GetAuthorizationUrl"/>
																		</parameters>
																	</methodInvokeExpression>
																</falseStatements>
															</conditionStatement>
														</trueStatements>
														<falseStatements>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="Not">
																		<methodInvokeExpression methodName="GetAccessTokens">
																			<parameters>
																				<variableReferenceExpression name="code"/>
																				<primitiveExpression value="false"/>
																			</parameters>
																		</methodInvokeExpression>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<propertyReferenceExpression name="StatusCode">
																			<propertyReferenceExpression name="Response">
																				<variableReferenceExpression name="context"/>
																			</propertyReferenceExpression>
																		</propertyReferenceExpression>
																		<primitiveExpression value="401"/>
																	</assignStatement>
																</trueStatements>
																<falseStatements>
																	<methodInvokeExpression methodName="StoreTokens">
																		<parameters>
																			<propertyReferenceExpression name="Tokens"/>
																			<propertyReferenceExpression name="StoreToken"/>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="SetSession">
																		<parameters>
																			<variableReferenceExpression name="context"/>
																		</parameters>
																	</methodInvokeExpression>
																	<methodInvokeExpression methodName="RedirectToStartPage">
																		<parameters>
																			<variableReferenceExpression name="context"/>
																		</parameters>
																	</methodInvokeExpression>
																</falseStatements>
															</conditionStatement>
														</falseStatements>
													</conditionStatement>
												</falseStatements>
											</conditionStatement>
										</statements>
										<catch exceptionType="Exception" localName="ex">
											<methodInvokeExpression methodName="HandleException">
												<parameters>
													<variableReferenceExpression name="context"/>
													<variableReferenceExpression name="ex"/>
												</parameters>
											</methodInvokeExpression>
										</catch>
									</tryStatement>
								</statements>
							</memberMethod>
							<!-- method GetSiteContentBasePath() -->
							<memberMethod returnType="System.String" name="GetSiteContentBasePath">
								<attributes family="true" />
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="sys/saas"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method SetSession(HttpContext, MembershipUser)-->
							<memberMethod name="SetSession">
								<attributes public="true"/>
								<parameters>
									<parameter type="HttpContext" name="context"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<propertyReferenceExpression name="StoreToken"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="MembershipUser" name="user">
												<init>
													<methodInvokeExpression methodName="SyncUser"/>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityEquality">
														<propertyReferenceExpression name="user"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<throwExceptionStatement>
														<objectCreateExpression type="Exception">
															<parameters>
																<primitiveExpression value="No user found."/>
															</parameters>
														</objectCreateExpression>
													</throwExceptionStatement>
												</trueStatements>
											</conditionStatement>
											<variableDeclarationStatement type="ApplicationServices" name="services">
												<init>
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</init>
											</variableDeclarationStatement>
											<comment>logout current user</comment>
											<variableDeclarationStatement type="HttpCookie" name="auth">
												<init>
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Cookies">
																<propertyReferenceExpression name="Request">
																	<variableReferenceExpression name="context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</target>
														<indices>
															<propertyReferenceExpression name="FormsCookieName">
																<typeReferenceExpression type="FormsAuthentication"/>
															</propertyReferenceExpression>
														</indices>
													</arrayIndexerExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="auth"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement type="FormsAuthenticationTicket" name="oldTicket">
														<init>
															<methodInvokeExpression methodName="Decrypt">
																<target>
																	<typeReferenceExpression type="FormsAuthentication"/>
																</target>
																<parameters>
																	<propertyReferenceExpression name="Value">
																		<variableReferenceExpression name="auth"/>
																	</propertyReferenceExpression>
																</parameters>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueInequality">
																<propertyReferenceExpression name="Name">
																	<variableReferenceExpression name="oldTicket"/>
																</propertyReferenceExpression>
																<propertyReferenceExpression name="UserName">
																	<variableReferenceExpression name="user"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<methodInvokeExpression methodName="UserLogout">
																<target>
																	<variableReferenceExpression name="services"/>
																</target>
															</methodInvokeExpression>
														</trueStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
											<variableDeclarationStatement type="FormsAuthenticationTicket" name="ticket">
												<init>
													<objectCreateExpression type="FormsAuthenticationTicket">
														<parameters>
															<primitiveExpression value="0"/>
															<propertyReferenceExpression name="UserName">
																<variableReferenceExpression name="user"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Now">
																<typeReferenceExpression type="DateTime"/>
															</propertyReferenceExpression>
															<methodInvokeExpression methodName="AddHours">
																<target>
																	<propertyReferenceExpression name="Now">
																		<typeReferenceExpression type="DateTime"/>
																	</propertyReferenceExpression>
																</target>
																<parameters>
																	<primitiveExpression value="12"/>
																</parameters>
															</methodInvokeExpression>
															<primitiveExpression value="false"/>
															<binaryOperatorExpression operator="Add">
																<primitiveExpression value="OAUTH:"/>
																<methodInvokeExpression methodName="GetHandlerName"/>
															</binaryOperatorExpression>
														</parameters>
													</objectCreateExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="System.String" name="encrypted">
												<init>
													<methodInvokeExpression methodName="Encrypt">
														<target>
															<typeReferenceExpression type="FormsAuthentication"/>
														</target>
														<parameters>
															<variableReferenceExpression name="ticket"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="JToken" name="accountManagerEnabled">
												<init>
													<methodInvokeExpression methodName="TryGetJsonProperty">
														<target>
															<typeReferenceExpression type="ApplicationServicesBase"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="DefaultSettings">
																<variableReferenceExpression name="services"/>
															</propertyReferenceExpression>
															<primitiveExpression value="membership.accountManager.enabled"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanOr">
														<binaryOperatorExpression operator="IdentityEquality">
															<variableReferenceExpression name="accountManagerEnabled"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
														<methodInvokeExpression methodName="Value">
															<typeArguments>
																<typeReference type="System.Boolean"/>
															</typeArguments>
															<target>
																<variableReferenceExpression name="accountManagerEnabled"/>
															</target>
														</methodInvokeExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<comment>client token login</comment>
													<variableDeclarationStatement type="HttpCookie" name="cookie">
														<init>
															<objectCreateExpression type="HttpCookie">
																<parameters>
																	<primitiveExpression value=".TOKEN"/>
																	<variableReferenceExpression name="encrypted"/>
																</parameters>
															</objectCreateExpression>
														</init>
													</variableDeclarationStatement>
													<assignStatement>
														<propertyReferenceExpression name="Expires">
															<variableReferenceExpression name="cookie"/>
														</propertyReferenceExpression>
														<methodInvokeExpression methodName="AddMinutes">
															<target>
																<propertyReferenceExpression name="Now">
																	<typeReferenceExpression type="System.DateTime"/>
																</propertyReferenceExpression>
															</target>
															<parameters>
																<primitiveExpression value="5"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
													<methodInvokeExpression methodName="SetCookie">
														<target>
															<propertyReferenceExpression name="Response">
																<variableReferenceExpression name="context"/>
															</propertyReferenceExpression>
														</target>
														<parameters>
															<variableReferenceExpression name="cookie"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
												<falseStatements>
													<comment>server login</comment>
													<methodInvokeExpression methodName="AuthenticateUser">
														<target>
															<variableReferenceExpression name="services"/>
														</target>
														<parameters>
															<propertyReferenceExpression name="UserName">
																<variableReferenceExpression name="user"/>
															</propertyReferenceExpression>
															<binaryOperatorExpression operator="Add">
																<primitiveExpression value="token:"/>
																<variableReferenceExpression name="encrypted"/>
															</binaryOperatorExpression>
															<primitiveExpression value="false"/>
														</parameters>
													</methodInvokeExpression>
												</falseStatements>
											</conditionStatement>
											<methodInvokeExpression methodName="Set">
												<target>
													<propertyReferenceExpression name="Cookies">
														<propertyReferenceExpression name="Response">
															<argumentReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<objectCreateExpression type="HttpCookie">
														<parameters>
															<primitiveExpression value=".PROVIDER"/>
															<methodInvokeExpression methodName="GetHandlerName"/>
														</parameters>
													</objectCreateExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method RestoreSession(HttpContext)-->
							<memberMethod name="RestoreSession">
								<attributes public="true"/>
								<parameters>
									<parameter type="HttpContext" name="context"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="ValueEquality">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<propertyReferenceExpression name="Request">
																<variableReferenceExpression name="context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="storeToken"/>
													</indices>
												</arrayIndexerExpression>
												<primitiveExpression value="true" convertTo="String"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="StoreToken"/>
												<primitiveExpression value="true"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method GetAccessTokens()-->
							<memberMethod returnType="System.Boolean" name="GetAccessTokens">
								<attributes family="true"/>
								<parameters>
									<parameter type="System.String" name="code"/>
									<parameter type="System.Boolean" name="refresh"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="GetAccessTokenRequest">
												<parameters>
													<variableReferenceExpression name="code"/>
													<variableReferenceExpression name="refresh"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="WebResponse" name="response">
										<init>
											<methodInvokeExpression methodName="GetResponse">
												<target>
													<variableReferenceExpression name="request"/>
												</target>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="json">
										<init>
											<stringEmptyExpression/>
										</init>
									</variableDeclarationStatement>
									<usingStatement>
										<variable type="StreamReader" name="sr">
											<init>
												<objectCreateExpression type="StreamReader">
													<parameters>
														<methodInvokeExpression methodName="GetResponseStream">
															<target>
																<variableReferenceExpression name="response"/>
															</target>
														</methodInvokeExpression>
													</parameters>
												</objectCreateExpression>
											</init>
										</variable>
										<statements>
											<assignStatement>
												<variableReferenceExpression name="json"/>
												<methodInvokeExpression methodName="ReadToEnd">
													<target>
														<variableReferenceExpression name="sr"/>
													</target>
												</methodInvokeExpression>
											</assignStatement>
										</statements>
									</usingStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="IsCustomErrorEnabled">
														<propertyReferenceExpression name="Current">
															<typeReferenceExpression type="HttpContext"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
												<binaryOperatorExpression operator="BooleanOr">
													<unaryOperatorExpression operator="IsNullOrEmpty">
														<variableReferenceExpression name="json"/>
													</unaryOperatorExpression>
													<binaryOperatorExpression operator="ValueInequality">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="json"/>
															</target>
															<indices>
																<primitiveExpression value="0"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="{{" convertTo="Char"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<throwExceptionStatement>
												<objectCreateExpression type="Exception">
													<parameters>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="Error fetching access tokens. Response: "/>
															<variableReferenceExpression name="json"/>
														</binaryOperatorExpression>
													</parameters>
												</objectCreateExpression>
											</throwExceptionStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="JObject" name="responseObj">
										<init>
											<methodInvokeExpression methodName="Parse">
												<target>
													<typeReferenceExpression type="JObject"/>
												</target>
												<parameters>
													<variableReferenceExpression name="json"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="er">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<variableReferenceExpression name="responseObj"/>
													</target>
													<indices>
														<primitiveExpression value="error"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="er"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<throwExceptionStatement>
												<objectCreateExpression type="Exception">
													<parameters>
														<variableReferenceExpression name="er"/>
													</parameters>
												</objectCreateExpression>
											</throwExceptionStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<propertyReferenceExpression name="Tokens"/>
										<variableReferenceExpression name="responseObj"/>
									</assignStatement>
									<methodReturnStatement>
										<binaryOperatorExpression operator="IdentityInequality">
											<arrayIndexerExpression>
												<target>
													<variableReferenceExpression name="responseObj"/>
												</target>
												<indices>
													<primitiveExpression value="access_token"/>
												</indices>
											</arrayIndexerExpression>
											<primitiveExpression value="null"/>
										</binaryOperatorExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method StoreTokens(JObject, bool)-->
							<memberMethod name="StoreTokens">
								<attributes public="true"/>
								<parameters>
									<parameter type="JObject" name="tokens"/>
									<parameter type="System.Boolean" name="storeSystem"/>
								</parameters>
								<statements>
									<xsl:if test="$SiteContentTableName!=''">
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<variableReferenceExpression name="storeSystem"/>
													<binaryOperatorExpression operator="BooleanAnd">
														<propertyReferenceExpression name="IsSiteContentEnabled">
															<typeReferenceExpression type="ApplicationServices"/>
														</propertyReferenceExpression>
														<binaryOperatorExpression operator="IdentityInequality">
															<fieldReferenceExpression name="config"/>
															<primitiveExpression value="null"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement name="accessToken">
													<init>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="tokens"/>
																</target>
																<indices>
																	<primitiveExpression value="access_token"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="accessToken"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="AccessToken">
																<fieldReferenceExpression name="config"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="accessToken"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<variableDeclarationStatement name="refreshToken">
													<init>
														<castExpression targetType="System.String">
															<arrayIndexerExpression>
																<target>
																	<argumentReferenceExpression name="tokens"/>
																</target>
																<indices>
																	<primitiveExpression value="refresh_token"/>
																</indices>
															</arrayIndexerExpression>
														</castExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="refreshToken"/>
														</unaryOperatorExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="RefreshToken">
																<fieldReferenceExpression name="config"/>
															</propertyReferenceExpression>
															<variableReferenceExpression name="refreshToken"/>
														</assignStatement>
													</trueStatements>
												</conditionStatement>
												<assignStatement>
													<propertyReferenceExpression name="Text">
														<fieldReferenceExpression name="saasFile"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="Trim">
														<target>
															<methodInvokeExpression methodName="ToString">
																<target>
																	<fieldReferenceExpression name="config"/>
																</target>
															</methodInvokeExpression>
														</target>
													</methodInvokeExpression>
												</assignStatement>
												<methodInvokeExpression methodName="WriteAllText">
													<target>
														<typeReferenceExpression type="SiteContentFile"/>
													</target>
													<parameters>
														<stringFormatExpression format="{{0}}/{{1}}">
															<propertyReferenceExpression name="Path">
																<fieldReferenceExpression name="saasFile"/>
															</propertyReferenceExpression>
															<propertyReferenceExpression name="Name">
																<fieldReferenceExpression name="saasFile"/>
															</propertyReferenceExpression>
														</stringFormatExpression>
														<propertyReferenceExpression name="Text">
															<fieldReferenceExpression name="saasFile"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
									</xsl:if>
								</statements>
							</memberMethod>
							<!-- method LoadTokens(string)-->
							<memberMethod returnType="System.Boolean" name="LoadTokens">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="userName"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="false"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAuthCode(HttpRequest)-->
							<memberMethod returnType="System.String" name="GetAuthCode">
								<attributes family="true"/>
								<parameters>
									<parameter type="HttpRequest" name="request"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="QueryString">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<primitiveExpression value="code"/>
											</indices>
										</arrayIndexerExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method Query(string)-->
							<memberMethod returnType="JObject" name="Query">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.Boolean" name="useSystemToken"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="JObject" name="result">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<tryStatement>
										<statements>
											<variableDeclarationStatement type="System.String" name="token">
												<init>
													<castExpression targetType="System.String">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Tokens"/>
															</target>
															<indices>
																<primitiveExpression value="access_token"/>
															</indices>
														</arrayIndexerExpression>
													</castExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<argumentReferenceExpression name="useSystemToken"/>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="token"/>
														<propertyReferenceExpression name="AccessToken">
															<propertyReferenceExpression name="Config"/>
														</propertyReferenceExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNullOrEmpty">
														<variableReferenceExpression name="token"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<throwExceptionStatement>
														<objectCreateExpression type="Exception">
															<parameters>
																<primitiveExpression value="No token for request."/>
															</parameters>
														</objectCreateExpression>
													</throwExceptionStatement>
												</trueStatements>
											</conditionStatement>
											<variableDeclarationStatement type="WebRequest" name="request">
												<init>
													<methodInvokeExpression methodName="GetQueryRequest">
														<parameters>
															<variableReferenceExpression name="method"/>
															<variableReferenceExpression name="token"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="WebResponse" name="response">
												<init>
													<methodInvokeExpression methodName="GetResponse">
														<target>
															<variableReferenceExpression name="request"/>
														</target>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<usingStatement>
												<variable type="StreamReader" name="sr">
													<init>
														<objectCreateExpression type="StreamReader">
															<parameters>
																<methodInvokeExpression methodName="GetResponseStream">
																	<target>
																		<variableReferenceExpression name="response"/>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</objectCreateExpression>
													</init>
												</variable>
												<statements>
													<assignStatement>
														<variableReferenceExpression name="result"/>
														<methodInvokeExpression methodName="Parse">
															<target>
																<typeReferenceExpression type="JObject"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ReadToEnd">
																	<target>
																		<variableReferenceExpression name="sr"/>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
													<methodInvokeExpression methodName="OAuthSetUserObject">
														<target>
															<methodInvokeExpression methodName="Create">
																<target>
																	<typeReferenceExpression type="ApplicationServicesBase"/>
																</target>
															</methodInvokeExpression>
														</target>
														<parameters>
															<variableReferenceExpression name="result"/>
														</parameters>
													</methodInvokeExpression>
												</statements>
											</usingStatement>
										</statements>
										<catch exceptionType="WebException" localName="ex">
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<propertyReferenceExpression name="Status">
															<variableReferenceExpression name="ex"/>
														</propertyReferenceExpression>
														<propertyReferenceExpression name="ProtocolError">
															<typeReferenceExpression type="WebExceptionStatus"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement type="HttpWebResponse" name="response">
														<init>
															<castExpression targetType="HttpWebResponse">
																<propertyReferenceExpression name="Response">
																	<variableReferenceExpression name="ex"/>
																</propertyReferenceExpression>
															</castExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="BooleanAnd">
																<binaryOperatorExpression operator="ValueEquality">
																	<propertyReferenceExpression name="StatusCode">
																		<variableReferenceExpression name="response"/>
																	</propertyReferenceExpression>
																	<propertyReferenceExpression name="Unauthorized">
																		<typeReferenceExpression type="HttpStatusCode"/>
																	</propertyReferenceExpression>
																</binaryOperatorExpression>
																<unaryOperatorExpression operator="Not">
																	<fieldReferenceExpression name="refreshedToken"/>
																</unaryOperatorExpression>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<fieldReferenceExpression name="refreshedToken"/>
																<primitiveExpression value="true"/>
															</assignStatement>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="Not">
																		<methodInvokeExpression methodName="RefreshTokens">
																			<parameters>
																				<variableReferenceExpression name="useSystemToken"/>
																			</parameters>
																		</methodInvokeExpression>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<throwExceptionStatement>
																		<objectCreateExpression type="Exception">
																			<parameters>
																				<primitiveExpression value="Token expired."/>
																			</parameters>
																		</objectCreateExpression>
																	</throwExceptionStatement>
																</trueStatements>
																<falseStatements>
																	<assignStatement>
																		<variableReferenceExpression name="result"/>
																		<methodInvokeExpression methodName="Query">
																			<parameters>
																				<variableReferenceExpression name="method"/>
																				<variableReferenceExpression name="useSystemToken"/>
																			</parameters>
																		</methodInvokeExpression>
																	</assignStatement>
																</falseStatements>
															</conditionStatement>
														</trueStatements>
														<falseStatements>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="ValueEquality">
																		<propertyReferenceExpression name="StatusCode">
																			<variableReferenceExpression name="response"/>
																		</propertyReferenceExpression>
																		<propertyReferenceExpression name="Forbidden">
																			<typeReferenceExpression type="HttpStatusCode"/>
																		</propertyReferenceExpression>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<throwExceptionStatement>
																		<objectCreateExpression type="Exception">
																			<parameters>
																				<primitiveExpression value="Insufficient permissions."/>
																			</parameters>
																		</objectCreateExpression>
																	</throwExceptionStatement>
																</trueStatements>
															</conditionStatement>
														</falseStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
										</catch>
									</tryStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="result"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method RefreshTokens(bool)-->
							<memberMethod returnType="System.Boolean" name="RefreshTokens">
								<attributes family="true"/>
								<parameters>
									<parameter type="System.Boolean" name="useSystemToken"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="System.String" name="refresh">
										<init>
											<castExpression targetType="System.String">
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="Tokens"/>
													</target>
													<indices>
														<primitiveExpression value="refresh_token"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<argumentReferenceExpression name="useSystemToken"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="refresh"/>
												<propertyReferenceExpression name="RefreshToken">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="refresh"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<methodInvokeExpression methodName="GetAccessTokens">
														<parameters>
															<variableReferenceExpression name="refresh"/>
															<primitiveExpression value="true"/>
														</parameters>
													</methodInvokeExpression>
												</condition>
												<trueStatements>
													<conditionStatement>
														<condition>
															<argumentReferenceExpression name="useSystemToken"/>
														</condition>
														<trueStatements>
															<methodInvokeExpression methodName="StoreTokens">
																<parameters>
																	<propertyReferenceExpression name="Tokens"/>
																	<primitiveExpression value="true"/>
																</parameters>
															</methodInvokeExpression>
														</trueStatements>
													</conditionStatement>
													<methodReturnStatement>
														<primitiveExpression value="true"/>
													</methodReturnStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<primitiveExpression value="false"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method SyncUser()-->
							<memberMethod returnType="MembershipUser" name="SyncUser">
								<attributes public="true"/>
								<statements>
									<variableDeclarationStatement type="System.String" name="username">
										<init>
											<methodInvokeExpression methodName="GetUserName"/>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="email">
										<init>
											<methodInvokeExpression methodName="GetUserEmail"/>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="MembershipUser" name="user">
										<init>
											<methodInvokeExpression methodName="GetUser">
												<target>
													<typeReferenceExpression type="Membership"/>
												</target>
												<parameters>
													<variableReferenceExpression name="username"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<variableReferenceExpression name="user"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<variableDeclarationStatement type="System.String" name="userNameOfEmailOwner">
												<init>
													<methodInvokeExpression methodName="GetUserNameByEmail">
														<target>
															<typeReferenceExpression type="Membership"/>
														</target>
														<parameters>
															<variableReferenceExpression name="username"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="userNameOfEmailOwner"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="user"/>
														<methodInvokeExpression methodName="GetUser">
															<target>
																<typeReferenceExpression type="Membership"/>
															</target>
															<parameters>
																<variableReferenceExpression name="userNameOfEmailOwner"/>
															</parameters>
														</methodInvokeExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityEquality">
													<variableReferenceExpression name="user"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="ValueEquality">
													<arrayIndexerExpression>
														<target>
															<propertyReferenceExpression name="Config"/>
														</target>
														<indices>
															<primitiveExpression value="Sync User"/>
														</indices>
													</arrayIndexerExpression>
													<primitiveExpression value="true" convertTo="String"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<comment>create user</comment>
											<variableDeclarationStatement type="System.String" name="comment">
												<init>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="Source: "/>
														<methodInvokeExpression methodName="GetHandlerName"/>
													</binaryOperatorExpression>
												</init>
											</variableDeclarationStatement>
											<variableDeclarationStatement type="MembershipCreateStatus" name="status"/>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNullOrEmpty">
														<variableReferenceExpression name="email"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<variableReferenceExpression name="email"/>
														<variableReferenceExpression name="username"/>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
											<assignStatement>
												<variableReferenceExpression name="user"/>
												<methodInvokeExpression methodName="CreateUser">
													<target>
														<typeReferenceExpression type="Membership"/>
													</target>
													<parameters>
														<variableReferenceExpression name="username"/>
														<methodInvokeExpression methodName="ToString">
															<target>
																<methodInvokeExpression methodName="NewGuid">
																	<target>
																		<typeReferenceExpression type="Guid"/>
																	</target>
																</methodInvokeExpression>
															</target>
														</methodInvokeExpression>
														<variableReferenceExpression name="email"/>
														<variableReferenceExpression name="comment"/>
														<methodInvokeExpression methodName="ToString">
															<target>
																<methodInvokeExpression methodName="NewGuid">
																	<target>
																		<typeReferenceExpression type="Guid"/>
																	</target>
																</methodInvokeExpression>
															</target>
														</methodInvokeExpression>
														<primitiveExpression value="true"/>
														<directionExpression direction="Out">
															<variableReferenceExpression name="status"/>
														</directionExpression>
													</parameters>
												</methodInvokeExpression>
											</assignStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="status"/>
														<propertyReferenceExpression name="Success">
															<typeReferenceExpression type="MembershipCreateStatus"/>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<throwExceptionStatement>
														<objectCreateExpression type="Exception">
															<parameters>
																<methodInvokeExpression methodName="ToString">
																	<target>
																		<variableReferenceExpression name="status"/>
																	</target>
																</methodInvokeExpression>
															</parameters>
														</objectCreateExpression>
													</throwExceptionStatement>
												</trueStatements>
											</conditionStatement>
											<assignStatement>
												<propertyReferenceExpression name="Comment">
													<variableReferenceExpression name="user"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="comment"/>
											</assignStatement>
											<methodInvokeExpression methodName="UpdateUser">
												<target>
													<typeReferenceExpression type="Membership"/>
												</target>
												<parameters>
													<variableReferenceExpression name="user"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="AddUserToRoles">
												<target>
													<typeReferenceExpression type="Roles"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="UserName">
														<variableReferenceExpression name="user"/>
													</propertyReferenceExpression>
													<methodInvokeExpression methodName="GetDefaultUserRoles">
														<parameters>
															<variableReferenceExpression name="user"/>
														</parameters>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityInequality">
												<variableReferenceExpression name="user"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<unaryOperatorExpression operator="IsNotNullOrEmpty">
															<variableReferenceExpression name="email"/>
														</unaryOperatorExpression>
														<binaryOperatorExpression operator="ValueInequality">
															<variableReferenceExpression name="email"/>
															<propertyReferenceExpression name="Email">
																<variableReferenceExpression name="user"/>
															</propertyReferenceExpression>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<propertyReferenceExpression name="Email">
															<variableReferenceExpression name="user"/>
														</propertyReferenceExpression>
														<variableReferenceExpression name="email"/>
													</assignStatement>
													<methodInvokeExpression methodName="UpdateUser">
														<target>
															<typeReferenceExpression type="Membership"/>
														</target>
														<parameters>
															<variableReferenceExpression name="user"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
											<methodInvokeExpression methodName="SetUserAvatar">
												<parameters>
													<variableReferenceExpression name="user"/>
												</parameters>
											</methodInvokeExpression>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<propertyReferenceExpression name="Config"/>
															</target>
															<indices>
																<primitiveExpression value="Sync Roles"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="true" convertTo="String"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<comment>verify roles</comment>
													<variableDeclarationStatement type="List" name="roleList">
														<typeArguments>
															<typeReference type="System.String"/>
														</typeArguments>
														<init>
															<methodInvokeExpression methodName="GetUserRoles">
																<parameters>
																	<variableReferenceExpression name="user"/>
																</parameters>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<foreachStatement>
														<variable type="System.String" name="role"/>
														<target>
															<variableReferenceExpression name="roleList"/>
														</target>
														<statements>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="Not">
																		<methodInvokeExpression methodName="IsUserInRole">
																			<target>
																				<typeReferenceExpression type="Roles"/>
																			</target>
																			<parameters>
																				<propertyReferenceExpression name="UserName">
																					<variableReferenceExpression name="user"/>
																				</propertyReferenceExpression>
																				<variableReferenceExpression name="role"/>
																			</parameters>
																		</methodInvokeExpression>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<conditionStatement>
																		<condition>
																			<unaryOperatorExpression operator="Not">
																				<methodInvokeExpression methodName="RoleExists">
																					<target>
																						<typeReferenceExpression type="Roles"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="role"/>
																					</parameters>
																				</methodInvokeExpression>
																			</unaryOperatorExpression>
																		</condition>
																		<trueStatements>
																			<methodInvokeExpression methodName="CreateRole">
																				<target>
																					<typeReferenceExpression type="Roles"/>
																				</target>
																				<parameters>
																					<variableReferenceExpression name="role"/>
																				</parameters>
																			</methodInvokeExpression>
																		</trueStatements>
																	</conditionStatement>
																	<methodInvokeExpression methodName="AddUserToRole">
																		<target>
																			<typeReferenceExpression type="Roles"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="UserName">
																				<variableReferenceExpression name="user"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="role"/>
																		</parameters>
																	</methodInvokeExpression>
																</trueStatements>
															</conditionStatement>
														</statements>
													</foreachStatement>
													<variableDeclarationStatement type="List" name="existingRoles">
														<typeArguments>
															<typeReference type="System.String"/>
														</typeArguments>
														<init>
															<objectCreateExpression type="List">
																<typeArguments>
																	<typeReference type="System.String"/>
																</typeArguments>
																<parameters>
																	<methodInvokeExpression methodName="GetRolesForUser">
																		<target>
																			<typeReferenceExpression type="Roles"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="UserName">
																				<variableReferenceExpression name="user"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</parameters>
															</objectCreateExpression>
														</init>
													</variableDeclarationStatement>
													<foreachStatement>
														<variable type="System.String" name="oldRole"/>
														<target>
															<variableReferenceExpression name="existingRoles"/>
														</target>
														<statements>
															<conditionStatement>
																<condition>
																	<unaryOperatorExpression operator="Not">
																		<methodInvokeExpression methodName="Contains">
																			<target>
																				<variableReferenceExpression name="roleList"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="oldRole"/>
																			</parameters>
																		</methodInvokeExpression>
																	</unaryOperatorExpression>
																</condition>
																<trueStatements>
																	<methodInvokeExpression methodName="RemoveUserFromRole">
																		<target>
																			<typeReferenceExpression type="Roles"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="UserName">
																				<variableReferenceExpression name="user"/>
																			</propertyReferenceExpression>
																			<variableReferenceExpression name="oldRole"/>
																		</parameters>
																	</methodInvokeExpression>
																</trueStatements>
															</conditionStatement>
														</statements>
													</foreachStatement>
												</trueStatements>
											</conditionStatement>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="OAuthSyncUser">
										<target>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="ApplicationServicesBase"/>
												</target>
											</methodInvokeExpression>
										</target>
										<parameters>
											<variableReferenceExpression name="user"/>
										</parameters>
									</methodInvokeExpression>
									<methodReturnStatement>
										<variableReferenceExpression name="user"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserName()-->
							<memberMethod returnType="System.String" name="GetUserName">
								<attributes public="true" abstract="true"/>
							</memberMethod>
							<!-- method GetUserEmail()-->
							<memberMethod returnType="System.String" name="GetUserEmail">
								<attributes public="true"/>
								<statements>
									<methodReturnStatement>
										<stringEmptyExpression/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method SetUserAvatar(MembershipUser)-->
							<memberMethod name="SetUserAvatar">
								<attributes public="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<xsl:if test="$SiteContentTableName!=''">
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsSiteContentEnabled">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<tryStatement>
													<statements>
														<variableDeclarationStatement type="System.String" name="url">
															<init>
																<methodInvokeExpression methodName="GetUserImageUrl">
																	<parameters>
																		<variableReferenceExpression name="user"/>
																	</parameters>
																</methodInvokeExpression>
															</init>
														</variableDeclarationStatement>
														<conditionStatement>
															<condition>
																<unaryOperatorExpression operator="IsNotNullOrEmpty">
																	<variableReferenceExpression name="url"/>
																</unaryOperatorExpression>
															</condition>
															<trueStatements>
																<variableDeclarationStatement type="WebRequest" name="request">
																	<init>
																		<methodInvokeExpression methodName="Create">
																			<target>
																				<typeReferenceExpression type="WebRequest"/>
																			</target>
																			<parameters>
																				<variableReferenceExpression name="url"/>
																			</parameters>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<variableDeclarationStatement type="WebResponse" name="response">
																	<init>
																		<methodInvokeExpression methodName="GetResponse">
																			<target>
																				<variableReferenceExpression name="request"/>
																			</target>
																		</methodInvokeExpression>
																	</init>
																</variableDeclarationStatement>
																<usingStatement>
																	<variable type="Stream" name="s">
																		<init>
																			<methodInvokeExpression methodName="GetResponseStream">
																				<target>
																					<variableReferenceExpression name="response"/>
																				</target>
																			</methodInvokeExpression>
																		</init>
																	</variable>
																	<statements>
																		<variableDeclarationStatement type="Bitmap" name="b">
																			<init>
																				<castExpression targetType="Bitmap">
																					<methodInvokeExpression methodName="FromStream">
																						<target>
																							<typeReferenceExpression type="Bitmap"/>
																						</target>
																						<parameters>
																							<variableReferenceExpression name="s"/>
																						</parameters>
																					</methodInvokeExpression>
																				</castExpression>
																			</init>
																		</variableDeclarationStatement>
																		<usingStatement>
																			<variable type="MemoryStream" name="ms">
																				<init>
																					<objectCreateExpression type="MemoryStream"/>
																				</init>
																			</variable>
																			<statements>
																				<methodInvokeExpression methodName="Save">
																					<target>
																						<variableReferenceExpression name="b"/>
																					</target>
																					<parameters>
																						<variableReferenceExpression name="ms"/>
																						<propertyReferenceExpression name="Png">
																							<typeReferenceExpression type="ImageFormat"/>
																						</propertyReferenceExpression>
																					</parameters>
																				</methodInvokeExpression>
																				<methodInvokeExpression methodName="WriteAllBytes">
																					<target>
																						<typeReferenceExpression type="SiteContentFile"/>
																					</target>
																					<parameters>
																						<stringFormatExpression format="sys/users/{{0}}.png">
																							<propertyReferenceExpression name="UserName">
																								<variableReferenceExpression name="user"/>
																							</propertyReferenceExpression>
																						</stringFormatExpression>
																						<primitiveExpression value="image/png"/>
																						<methodInvokeExpression methodName="ToArray">
																							<target>
																								<variableReferenceExpression name="ms"/>
																							</target>
																						</methodInvokeExpression>
																					</parameters>
																				</methodInvokeExpression>
																			</statements>
																		</usingStatement>
																	</statements>
																</usingStatement>
															</trueStatements>
														</conditionStatement>
													</statements>
													<catch exceptionType="Exception"></catch>
												</tryStatement>
											</trueStatements>
										</conditionStatement>
									</xsl:if>
								</statements>
							</memberMethod>
							<!-- method GetUserImageUrl(MembershipUser)-->
							<memberMethod returnType="System.String" name="GetUserImageUrl">
								<attributes public="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="null"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetDefaultUserRoles(MembershipUser)-->
							<memberMethod returnType="System.String[]" name="GetDefaultUserRoles">
								<attributes public="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<arrayCreateExpression>
											<createType type="System.String"/>
											<initializers>
												<primitiveExpression value="Users"/>
											</initializers>
										</arrayCreateExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserRoles()-->
							<memberMethod returnType="List" name="GetUserRoles">
								<typeArguments>
									<typeReference type="System.String"/>
								</typeArguments>
								<attributes public="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="List" name="roleList">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
										<init>
											<objectCreateExpression type="List">
												<typeArguments>
													<typeReference type="System.String"/>
												</typeArguments>
											</objectCreateExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="Add">
										<target>
											<variableReferenceExpression name="roleList"/>
										</target>
										<parameters>
											<primitiveExpression value="Users"/>
										</parameters>
									</methodInvokeExpression>
									<methodReturnStatement>
										<variableReferenceExpression name="roleList"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserProfile()-->
							<memberMethod returnType="System.String" name="GetUserProfile">
								<attributes public="true"/>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="logout"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetState()-->
							<memberMethod returnType="System.String" name="GetState">
								<attributes public="true"/>
								<statements>
									<variableDeclarationStatement type="System.String" name="state">
										<init>
											<binaryOperatorExpression operator="Add">
												<primitiveExpression value="start="/>
												<propertyReferenceExpression name="StartPage"/>
											</binaryOperatorExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="StoreToken"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="state"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="state"/>
													<primitiveExpression value="|storeToken=true"/>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<propertyReferenceExpression name="AppState"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="state"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="state"/>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="|"/>
														<propertyReferenceExpression name="AppState"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="state"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method SetState()-->
							<memberMethod name="SetState">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="state"/>
								</parameters>
								<statements>
									<foreachStatement>
										<variable type="System.String" name="part"/>
										<target>
											<methodInvokeExpression methodName="Split">
												<target>
													<argumentReferenceExpression name="state"/>
												</target>
												<parameters>
													<primitiveExpression value="|" convertTo="Char"/>
												</parameters>
											</methodInvokeExpression>
										</target>
										<statements>
											<conditionStatement>
												<condition>
													<unaryOperatorExpression operator="IsNotNullOrEmpty">
														<variableReferenceExpression name="part"/>
													</unaryOperatorExpression>
												</condition>
												<trueStatements>
													<variableDeclarationStatement type="System.String[]" name="ps">
														<init>
															<methodInvokeExpression methodName="Split">
																<target>
																	<variableReferenceExpression name="part"/>
																</target>
																<parameters>
																	<primitiveExpression value="=" convertTo="Char"/>
																</parameters>
															</methodInvokeExpression>
														</init>
													</variableDeclarationStatement>
													<conditionStatement>
														<condition>
															<binaryOperatorExpression operator="ValueEquality">
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="ps"/>
																	</target>
																	<indices>
																		<primitiveExpression value="0"/>
																	</indices>
																</arrayIndexerExpression>
																<primitiveExpression value="start"/>
															</binaryOperatorExpression>
														</condition>
														<trueStatements>
															<assignStatement>
																<propertyReferenceExpression name="StartPage"/>
																<arrayIndexerExpression>
																	<target>
																		<variableReferenceExpression name="ps"/>
																	</target>
																	<indices>
																		<primitiveExpression value="1"/>
																	</indices>
																</arrayIndexerExpression>
															</assignStatement>
														</trueStatements>
														<falseStatements>
															<conditionStatement>
																<condition>
																	<binaryOperatorExpression operator="ValueEquality">
																		<arrayIndexerExpression>
																			<target>
																				<variableReferenceExpression name="ps"/>
																			</target>
																			<indices>
																				<primitiveExpression value="0"/>
																			</indices>
																		</arrayIndexerExpression>
																		<primitiveExpression value="storeToken"/>
																	</binaryOperatorExpression>
																</condition>
																<trueStatements>
																	<assignStatement>
																		<propertyReferenceExpression name="StoreToken"/>
																		<binaryOperatorExpression operator="BooleanAnd">
																			<binaryOperatorExpression operator="ValueEquality">
																				<arrayIndexerExpression>
																					<target>
																						<variableReferenceExpression name="ps"/>
																					</target>
																					<indices>
																						<primitiveExpression value="1"/>
																					</indices>
																				</arrayIndexerExpression>
																				<primitiveExpression value="true" convertTo="String"/>
																			</binaryOperatorExpression>
																			<propertyReferenceExpression name="IsSuperUser">
																				<typeReferenceExpression type="ApplicationServicesBase"/>
																			</propertyReferenceExpression>
																			<!--<methodInvokeExpression methodName="IsUserInRole">
                                        <target>
                                          <typeReferenceExpression type="Roles"/>
                                        </target>
                                        <parameters>
                                          <primitiveExpression value="Administrators"/>
                                        </parameters>
                                      </methodInvokeExpression>-->
																		</binaryOperatorExpression>
																	</assignStatement>
																</trueStatements>
																<falseStatements>
																	<methodInvokeExpression methodName="OAuthSetState">
																		<target>
																			<methodInvokeExpression methodName="Create">
																				<target>
																					<typeReferenceExpression type="ApplicationServicesBase"/>
																				</target>
																			</methodInvokeExpression>
																		</target>
																		<parameters>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="ps"/>
																				</target>
																				<indices>
																					<primitiveExpression value="0"/>
																				</indices>
																			</arrayIndexerExpression>
																			<arrayIndexerExpression>
																				<target>
																					<variableReferenceExpression name="ps"/>
																				</target>
																				<indices>
																					<primitiveExpression value="1"/>
																				</indices>
																			</arrayIndexerExpression>
																		</parameters>
																	</methodInvokeExpression>
																</falseStatements>
															</conditionStatement>
														</falseStatements>
													</conditionStatement>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
								</statements>
							</memberMethod>
							<!-- method RedirectToLoginPage()-->
							<memberMethod name="RedirectToLoginPage">
								<attributes public="true"/>
								<statements>
									<!-- 
            string redirectUrl = null;
            if (Config != null)
                redirectUrl = GetAuthorizationUrl();
            else
                redirectUrl = ApplicationServices.Create().UserHomePageUrl();
            HttpContext.Current.Response.Redirect(redirectUrl);
                  -->
									<variableDeclarationStatement type="System.String" name="redirectUrl">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="IdentityEquality">
												<propertyReferenceExpression name="Config"/>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="redirectUrl"/>
												<methodInvokeExpression methodName="UserHomePageUrl">
													<target>
														<methodInvokeExpression methodName="Create">
															<target>
																<typeReferenceExpression type="ApplicationServices"/>
															</target>
														</methodInvokeExpression>
													</target>
												</methodInvokeExpression>
											</assignStatement>
										</trueStatements>
										<falseStatements>
											<assignStatement>
												<variableReferenceExpression name="redirectUrl"/>
												<methodInvokeExpression methodName="GetAuthorizationUrl"/>
											</assignStatement>
										</falseStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="Redirect">
										<target>
											<propertyReferenceExpression name="Response">
												<propertyReferenceExpression name="Current">
													<typeReferenceExpression type="HttpContext"/>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<variableReferenceExpression name="redirectUrl"/>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method RedirectToStartPage(context)-->
							<memberMethod name="RedirectToStartPage">
								<attributes public="true"/>
								<parameters>
									<parameter type="HttpContext" name="context"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<propertyReferenceExpression name="IsAuthenticated">
												<propertyReferenceExpression name="Identity">
													<propertyReferenceExpression name="User">
														<variableReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</propertyReferenceExpression>
											</propertyReferenceExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="Redirect">
												<target>
													<propertyReferenceExpression name="Response">
														<variableReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<propertyReferenceExpression name="StartPage"/>
												</parameters>
											</methodInvokeExpression>
										</trueStatements>
										<falseStatements>
											<methodInvokeExpression methodName="Redirect">
												<target>
													<propertyReferenceExpression name="Response">
														<variableReferenceExpression name="context"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Add">
														<binaryOperatorExpression operator="Add">
															<methodInvokeExpression methodName="UserHomePageUrl">
																<target>
																	<propertyReferenceExpression name="Current">
																		<typeReferenceExpression type="ApplicationServices"/>
																	</propertyReferenceExpression>
																</target>
															</methodInvokeExpression>
															<primitiveExpression value="?ReturnUrl="/>
														</binaryOperatorExpression>
														<methodInvokeExpression methodName="UrlEncode">
															<target>
																<typeReferenceExpression type="HttpUtility"/>
															</target>
															<parameters>
																<methodInvokeExpression methodName="ResolveClientUrl">
																	<target>
																		<typeReferenceExpression type="ApplicationServices"/>
																	</target>
																	<parameters>
																		<propertyReferenceExpression name="StartPage"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</falseStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method ValidateRefreshToken(MembershipUser)-->
							<memberMethod returnType="System.Boolean" name="ValidateRefreshToken">
								<attributes public="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
									<parameter type="System.String" name="token"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="true"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method SignOut()-->
							<memberMethod name="SignOut">
								<attributes public="true"/>
							</memberMethod>
							<!-- method HandleError(HttpContext)-->
							<memberMethod name="HandleError">
								<attributes family="true"/>
								<parameters>
									<parameter type="HttpContext" name="context"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="System.String" name="desc">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="QueryString">
														<propertyReferenceExpression name="Request">
															<variableReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="error_description"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<variableReferenceExpression name="desc"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="desc"/>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<propertyReferenceExpression name="Request">
																<variableReferenceExpression name="context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="error"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<throwExceptionStatement>
										<objectCreateExpression type="Exception">
											<parameters>
												<variableReferenceExpression name="desc"/>
											</parameters>
										</objectCreateExpression>
									</throwExceptionStatement>
								</statements>
							</memberMethod>
							<!-- method HandleException(HttpContext, Exception)-->
							<memberMethod name="HandleException">
								<attributes family="true"/>
								<parameters>
									<parameter type="HttpContext" name="context"/>
									<parameter type="Exception" name="ex"/>
								</parameters>
								<statements>
									<whileStatement>
										<test>
											<binaryOperatorExpression operator="IdentityInequality">
												<propertyReferenceExpression name="InnerException">
													<variableReferenceExpression name="ex"/>
												</propertyReferenceExpression>
												<primitiveExpression value="null"/>
											</binaryOperatorExpression>
										</test>
										<statements>
											<assignStatement>
												<variableReferenceExpression name="ex"/>
												<propertyReferenceExpression name="InnerException">
													<variableReferenceExpression name="ex"/>
												</propertyReferenceExpression>
											</assignStatement>
										</statements>
									</whileStatement>
									<variableDeclarationStatement type="ServiceRequestError" name="er">
										<init>
											<objectCreateExpression type="ServiceRequestError"/>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Message">
											<variableReferenceExpression name="er"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Message">
											<variableReferenceExpression name="ex"/>
										</propertyReferenceExpression>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ExceptionType">
											<variableReferenceExpression name="er"/>
										</propertyReferenceExpression>
										<methodInvokeExpression methodName="ToString">
											<target>
												<methodInvokeExpression methodName="GetType">
													<target>
														<variableReferenceExpression name="ex"/>
													</target>
												</methodInvokeExpression>
											</target>
										</methodInvokeExpression>
									</assignStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="Not">
												<propertyReferenceExpression name="IsCustomErrorEnabled">
													<variableReferenceExpression name="context"/>
												</propertyReferenceExpression>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<propertyReferenceExpression name="StackTrace">
													<variableReferenceExpression name="er"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="StackTrace">
													<variableReferenceExpression name="ex"/>
												</propertyReferenceExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodInvokeExpression methodName="ClearError">
										<target>
											<propertyReferenceExpression name="Server">
												<variableReferenceExpression name="context"/>
											</propertyReferenceExpression>
										</target>
									</methodInvokeExpression>
									<assignStatement>
										<propertyReferenceExpression name="TrySkipIisCustomErrors">
											<propertyReferenceExpression name="Response">
												<variableReferenceExpression name="context"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
										<primitiveExpression value="true"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentType">
											<propertyReferenceExpression name="Response">
												<variableReferenceExpression name="context"/>
											</propertyReferenceExpression>
										</propertyReferenceExpression>
										<primitiveExpression value="application/json"/>
									</assignStatement>
									<methodInvokeExpression methodName="Clear">
										<target>
											<propertyReferenceExpression name="Response">
												<variableReferenceExpression name="context"/>
											</propertyReferenceExpression>
										</target>
									</methodInvokeExpression>
									<methodInvokeExpression methodName="Write">
										<target>
											<propertyReferenceExpression name="Response">
												<variableReferenceExpression name="context"/>
											</propertyReferenceExpression>
										</target>
										<parameters>
											<methodInvokeExpression methodName="SerializeObject">
												<target>
													<typeReferenceExpression type="JsonConvert"/>
												</target>
												<parameters>
													<variableReferenceExpression name="er"/>
												</parameters>
											</methodInvokeExpression>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- method GetHandlerName()-->
							<memberMethod returnType="System.String" name="GetHandlerName">
								<attributes public="true" abstract="true"/>
							</memberMethod>
							<!-- method GetAuthorizationUrl()-->
							<memberMethod name="GetAuthorizationUrl" returnType="System.String">
								<attributes public="true" abstract="true"/>
							</memberMethod>
							<!-- method GetAccessTokenRequest(string, bool)-->
							<memberMethod name="GetAccessTokenRequest" returnType="WebRequest">
								<attributes family="true" abstract="true"/>
								<parameters>
									<parameter type="System.String" name="code"/>
									<parameter type="System.Boolean" name="refresh"/>
								</parameters>
							</memberMethod>
							<!-- method GetQueryRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetQueryRequest">
								<attributes family="true" abstract="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.String" name="token"/>
								</parameters>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- class OAuthHandlerFactory-->
					<typeDeclaration name="OAuthHandlerFactory" isPartial="true">
						<attributes public="true"/>
						<baseTypes>
							<typeReference type="OAuthHandlerFactoryBase"/>
						</baseTypes>
					</typeDeclaration>
					<!-- class OAuthHandlerFactoryBase-->
					<typeDeclaration name="OAuthHandlerFactoryBase">
						<attributes public="true"/>
						<members>
							<!-- property SortedDictionary<string, Type> Handlers-->
							<memberField type="SortedDictionary" name="Handlers">
								<typeArguments>
									<typeReference type="System.String"/>
									<typeReference type="Type"/>
								</typeArguments>
								<attributes public="true" static="true"/>
								<init>
									<objectCreateExpression type="SortedDictionary">
										<typeArguments>
											<typeReference type="System.String"/>
											<typeReference type="Type"/>
										</typeArguments>
									</objectCreateExpression>
								</init>
							</memberField>
							<!-- method Create(service)-->
							<memberMethod returnType="OAuthHandler" name="Create">
								<attributes public="true" static="true"/>
								<parameters>
									<parameter type="System.String" name="service"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="GetHandler">
											<target>
												<objectCreateExpression type="OAuthHandlerFactory"/>
											</target>
											<parameters>
												<argumentReferenceExpression name="service"/>
											</parameters>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetActiveHandler()-->
							<memberMethod returnType="OAuthHandler" name="GetActiveHandler">
								<attributes public="true" static="true"/>
								<statements>
									<variableDeclarationStatement type="HttpCookie" name="saas">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Cookies">
														<propertyReferenceExpression name="Request">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value=".PROVIDER"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<binaryOperatorExpression operator="IdentityInequality">
													<variableReferenceExpression name="saas"/>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
												<binaryOperatorExpression operator="IdentityInequality">
													<propertyReferenceExpression name="Value">
														<variableReferenceExpression name="saas"/>
													</propertyReferenceExpression>
													<primitiveExpression value="null"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<methodInvokeExpression methodName="Create">
													<target>
														<typeReferenceExpression type="OAuthHandlerFactory"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="Value">
															<variableReferenceExpression name="saas"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<primitiveExpression value="null"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetHandler(service)-->
							<memberMethod returnType="OAuthHandler" name="GetHandler">
								<attributes public="true"/>
								<parameters>
									<parameter type="System.String" name="service"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="Type" name="t">
										<init>
											<primitiveExpression value="null"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="TryGetValue">
												<target>
													<propertyReferenceExpression name="Handlers"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="ToLower">
														<target>
															<argumentReferenceExpression name="service"/>
														</target>
													</methodInvokeExpression>
													<directionExpression direction="Out">
														<variableReferenceExpression name="t"/>
													</directionExpression>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<methodReturnStatement>
												<castExpression targetType="OAuthHandler">
													<methodInvokeExpression methodName="CreateInstance">
														<target>
															<typeReferenceExpression type="Activator"/>
														</target>
														<parameters>
															<variableReferenceExpression name="t"/>
														</parameters>
													</methodInvokeExpression>
												</castExpression>
											</methodReturnStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<primitiveExpression value="null"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method CreateAutoLogin()-->
							<memberMethod returnType="OAuthHandler" name="CreateAutoLogin">
								<attributes public="true" static="true"/>
								<statements>
									<methodReturnStatement>
										<methodInvokeExpression methodName="GetAutoLoginHandler">
											<target>
												<objectCreateExpression type="OAuthHandlerFactory"/>
											</target>
										</methodInvokeExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAutoLoginHandler()-->
							<memberMethod returnType="OAuthHandler" name="GetAutoLoginHandler">
								<attributes public="true"/>
								<statements>
									<xsl:if test="$SiteContentTableName!=''">
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsSiteContentEnabled">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<foreachStatement>
													<variable type="SiteContentFile" name="file"/>
													<target>
														<methodInvokeExpression methodName="ReadSiteContent">
															<target>
																<methodInvokeExpression methodName="Create">
																	<target>
																		<typeReferenceExpression type="ApplicationServices"/>
																	</target>
																</methodInvokeExpression>
															</target>
															<parameters>
																<primitiveExpression value="sys/saas"/>
																<primitiveExpression value="%"/>
															</parameters>
														</methodInvokeExpression>
													</target>
													<statements>
														<conditionStatement>
															<condition>
																<binaryOperatorExpression operator="BooleanAnd">
																	<unaryOperatorExpression operator="IsNotNullOrEmpty">
																		<propertyReferenceExpression name="Text">
																			<variableReferenceExpression name="file"/>
																		</propertyReferenceExpression>
																	</unaryOperatorExpression>
																	<methodInvokeExpression methodName="IsMatch">
																		<target>
																			<typeReferenceExpression type="Regex"/>
																		</target>
																		<parameters>
																			<propertyReferenceExpression name="Text">
																				<variableReferenceExpression name="file"/>
																			</propertyReferenceExpression>
																			<primitiveExpression value="Auto Login:\s*true"/>
																		</parameters>
																	</methodInvokeExpression>
																</binaryOperatorExpression>
															</condition>
															<trueStatements>
																<methodReturnStatement>
																	<methodInvokeExpression methodName="GetHandler">
																		<parameters>
																			<propertyReferenceExpression name="Name">
																				<variableReferenceExpression name="file"/>
																			</propertyReferenceExpression>
																		</parameters>
																	</methodInvokeExpression>
																</methodReturnStatement>
															</trueStatements>
														</conditionStatement>
													</statements>
												</foreachStatement>
											</trueStatements>
										</conditionStatement>
									</xsl:if>
									<methodReturnStatement>
										<primitiveExpression value="null"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
					<!-- CloudIdentityOAuthHandler-->
					<typeDeclaration isPartial="true" name="CloudIdentityOAuthHandler">
						<baseTypes>
							<typeReference type="CloudIdentityOAuthHandlerBase"/>
						</baseTypes>
					</typeDeclaration>
					<!-- CloudIdentityOAuthHandlerBase-->
					<typeDeclaration isPartial="true" name="CloudIdentityOAuthHandlerBase">
						<baseTypes>
							<typeReference type="OAuthHandler"/>
						</baseTypes>
						<members>
							<memberField type="JObject" name="userObj"/>
							<!-- method GetHandlerName()-->
							<memberMethod returnType="System.String" name="GetHandlerName">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="CloudIdentity"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- property Scope-->
							<memberProperty type="System.String" name="Scope">
								<attributes override="true" family="true"/>
								<getStatements>
									<variableDeclarationStatement type="System.String" name="scopes">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Config"/>
												</target>
												<indices>
													<primitiveExpression value="Scope"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<variableReferenceExpression name="scopes"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="scopes"/>
												<primitiveExpression value="profile email"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="scopes"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method GetAuthorizationUrl()-->
							<memberMethod name="GetAuthorizationUrl" returnType="System.String">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<stringFormatExpression format="{{0}}/oauth/auth?response_type=code&amp;client_id={{1}}&amp;redirect_uri={{2}}&amp;scope={{3}}&amp;state={{4}}">
											<propertyReferenceExpression name="ClientUri"/>
											<propertyReferenceExpression name="ClientId">
												<propertyReferenceExpression name="Config"/>
											</propertyReferenceExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="RedirectUri">
														<propertyReferenceExpression name="Config"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="Scope"/>
												</parameters>
											</methodInvokeExpression>
											<methodInvokeExpression methodName="EscapeDataString">
												<target>
													<typeReferenceExpression type="Uri"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="GetState"/>
												</parameters>
											</methodInvokeExpression>
										</stringFormatExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAccessTokenRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetAccessTokenRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="code"/>
									<parameter type="System.Boolean" name="refresh"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Add">
														<propertyReferenceExpression name="ClientUri"/>
														<primitiveExpression value="/oauth/token"/>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Method">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="POST"/>
									</assignStatement>
									<variableDeclarationStatement type="System.String" name="codeType">
										<init>
											<primitiveExpression value="code"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<argumentReferenceExpression name="refresh"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="codeType"/>
												<primitiveExpression value="access_token"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="body">
										<init>
											<stringFormatExpression format="{{0}}={{1}}&amp;client_id={{2}}&amp;client_secret={{3}}&amp;redirect_uri={{4}}&amp;grant_type=authorization_code">
												<variableReferenceExpression name="codeType"/>
												<argumentReferenceExpression name="code"/>
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="ClientSecret">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="RedirectUri">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.Byte[]" name="bodyBytes">
										<init>
											<methodInvokeExpression methodName="GetBytes">
												<target>
													<propertyReferenceExpression name="UTF8">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="body"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentType">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="application/x-www-form-urlencoded"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentLength">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Length">
											<variableReferenceExpression name="bodyBytes"/>
										</propertyReferenceExpression>
									</assignStatement>
									<usingStatement>
										<variable type="Stream" name="stream">
											<init>
												<methodInvokeExpression methodName="GetRequestStream">
													<target>
														<variableReferenceExpression name="request"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variable>
										<statements>
											<methodInvokeExpression methodName="Write">
												<target>
													<variableReferenceExpression name="stream"/>
												</target>
												<parameters>
													<variableReferenceExpression name="bodyBytes"/>
													<primitiveExpression value="0"/>
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="bodyBytes"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</usingStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetQueryRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetQueryRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.String" name="token"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Add">
														<propertyReferenceExpression name="ClientUri"/>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="/oauth/"/>
															<argumentReferenceExpression name="method"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<propertyReferenceExpression name="Authorization">
													<typeReferenceExpression type="HttpRequestHeader"/>
												</propertyReferenceExpression>
											</indices>
										</arrayIndexerExpression>
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="Bearer "/>
											<argumentReferenceExpression name="token"/>
										</binaryOperatorExpression>
									</assignStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserName()-->
							<memberMethod returnType="System.String" name="GetUserName">
								<attributes public="true" override="true"/>
								<statements>
									<assignStatement>
										<fieldReferenceExpression name="userObj"/>
										<methodInvokeExpression methodName="Query">
											<parameters>
												<primitiveExpression value="user"/>
												<primitiveExpression value="false"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<fieldReferenceExpression name="userObj"/>
												</target>
												<indices>
													<primitiveExpression value="name"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<xsl:if test="$PageImplementation='html' and $SiteContentTableName!=''">
								<!-- method SyncUser()-->
								<memberMethod returnType="MembershipUser" name="SyncUser">
									<attributes override="true" public="true"/>
									<statements>
										<variableDeclarationStatement type="MembershipUser" name="user">
											<init>
												<methodInvokeExpression methodName="SyncUser">
													<target>
														<baseReferenceExpression/>
													</target>
												</methodInvokeExpression>
											</init>
										</variableDeclarationStatement>
										<conditionStatement>
											<condition>
												<binaryOperatorExpression operator="BooleanAnd">
													<propertyReferenceExpression name="IsSiteContentEnabled">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
													<binaryOperatorExpression operator="IdentityInequality">
														<variableReferenceExpression name="user"/>
														<primitiveExpression value="null"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodInvokeExpression methodName="WriteJson">
													<target>
														<typeReferenceExpression type="SiteContentFile"/>
													</target>
													<parameters>
														<stringFormatExpression format="sys/users/{{0}}.json">
															<propertyReferenceExpression name="UserName">
																<variableReferenceExpression name="user"/>
															</propertyReferenceExpression>
														</stringFormatExpression>
														<fieldReferenceExpression name="userObj"/>
													</parameters>
												</methodInvokeExpression>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<variableReferenceExpression name="user"/>
										</methodReturnStatement>
									</statements>
								</memberMethod>
								<!-- method LoadTokens(string userName)-->
								<memberMethod returnType="System.Boolean" name="LoadTokens">
									<attributes public="true" override="true"/>
									<parameters>
										<parameter type="System.String" name="userName"/>
									</parameters>
									<statements>
										<conditionStatement>
											<condition>
												<propertyReferenceExpression name="IsSiteContentEnabled">
													<typeReferenceExpression type="ApplicationServices"/>
												</propertyReferenceExpression>
											</condition>
											<trueStatements>
												<assignStatement>
													<fieldReferenceExpression name="userObj"/>
													<methodInvokeExpression methodName="ReadJson">
														<target>
															<typeReferenceExpression type="SiteContentFile"/>
														</target>
														<parameters>
															<stringFormatExpression format="sys/users/{{0}}.json">
																<variableReferenceExpression name="userName"/>
															</stringFormatExpression>
														</parameters>
													</methodInvokeExpression>
												</assignStatement>
												<conditionStatement>
													<condition>
														<propertyReferenceExpression name="HasValues">
															<fieldReferenceExpression name="userObj"/>
														</propertyReferenceExpression>
													</condition>
													<trueStatements>
														<assignStatement>
															<propertyReferenceExpression name="Tokens"/>
															<fieldReferenceExpression name="userObj"/>
														</assignStatement>
														<methodReturnStatement>
															<primitiveExpression value="true"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</statements>
								</memberMethod>
								<!-- method ValidateRefreshToken(MembershipUser, string)-->
								<memberMethod returnType="System.Boolean" name="ValidateRefreshToken">
									<attributes public="true" override="true"/>
									<parameters>
										<parameter type="MembershipUser" name="user"/>
										<parameter type="System.String" name="token"/>
									</parameters>
									<statements>
										<conditionStatement>
											<condition>
												<unaryOperatorExpression operator="Not">
													<propertyReferenceExpression name="IsSiteContentEnabled">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</unaryOperatorExpression>
											</condition>
											<trueStatements>
												<methodReturnStatement>
													<primitiveExpression value="true"/>
												</methodReturnStatement>
											</trueStatements>
										</conditionStatement>
										<conditionStatement>
											<condition>
												<methodInvokeExpression methodName="LoadTokens">
													<parameters>
														<propertyReferenceExpression name="UserName">
															<variableReferenceExpression name="user"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</condition>
											<trueStatements>
												<variableDeclarationStatement type="JObject" name="response">
													<init>
														<methodInvokeExpression methodName="Query">
															<parameters>
																<primitiveExpression value="user"/>
																<primitiveExpression value="false"/>
															</parameters>
														</methodInvokeExpression>
													</init>
												</variableDeclarationStatement>
												<conditionStatement>
													<condition>
														<binaryOperatorExpression operator="BooleanAnd">
															<binaryOperatorExpression operator="IdentityInequality">
																<variableReferenceExpression name="response"/>
																<primitiveExpression value="null"/>
															</binaryOperatorExpression>
															<binaryOperatorExpression operator="ValueEquality">
																<castExpression targetType="System.String">
																	<arrayIndexerExpression>
																		<target>
																			<variableReferenceExpression name="response"/>
																		</target>
																		<indices>
																			<primitiveExpression value="name"/>
																		</indices>
																	</arrayIndexerExpression>
																</castExpression>
																<propertyReferenceExpression name="UserName">
																	<variableReferenceExpression name="user"/>
																</propertyReferenceExpression>
															</binaryOperatorExpression>
														</binaryOperatorExpression>
													</condition>
													<trueStatements>
														<methodReturnStatement>
															<primitiveExpression value="true"/>
														</methodReturnStatement>
													</trueStatements>
												</conditionStatement>
											</trueStatements>
										</conditionStatement>
										<methodReturnStatement>
											<primitiveExpression value="false"/>
										</methodReturnStatement>
									</statements>
								</memberMethod>
							</xsl:if>
						</members>
					</typeDeclaration>
					<!-- DnnOAuthHandler-->
					<typeDeclaration isPartial="true" name="DnnOAuthHandler">
						<baseTypes>
							<typeReference type="DnnOAuthHandlerBase"/>
						</baseTypes>
					</typeDeclaration>
					<!-- DnnOAuthHandlerBase-->
					<typeDeclaration isPartial="true" name="DnnOAuthHandlerBase">
						<baseTypes>
							<typeReference type="OAuthHandler"/>
						</baseTypes>
						<members>
							<!-- property Scope-->
							<memberProperty type="System.String" name="Scope">
								<attributes family="true" override="true"/>
								<getStatements>
									<variableDeclarationStatement type="System.String" name="sc">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Config"/>
												</target>
												<indices>
													<primitiveExpression value="Scope"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.String" name="tokens">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="Config"/>
												</target>
												<indices>
													<primitiveExpression value="Tokens"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="tokens"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="sc"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="sc"/>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value=" token:"/>
														<methodInvokeExpression methodName="Join">
															<target>
																<typeReferenceExpression type="System.String"/>
															</target>
															<parameters>
																<primitiveExpression value=" token:"/>
																<methodInvokeExpression methodName="Split">
																	<target>
																		<variableReferenceExpression name="tokens"/>
																	</target>
																	<parameters>
																		<primitiveExpression value=" " convertTo="Char"/>
																	</parameters>
																</methodInvokeExpression>
															</parameters>
														</methodInvokeExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="sc"/>
									</methodReturnStatement>
								</getStatements>
							</memberProperty>
							<!-- method GetHandlerName-->
							<memberMethod returnType="System.String" name="GetHandlerName">
								<attributes override="true" public="true"/>
								<statements>
									<methodReturnStatement>
										<primitiveExpression value="DNN"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAuthorizationUrl()-->
							<memberMethod name="GetAuthorizationUrl" returnType="System.String">
								<attributes public="true" override="true"/>
								<statements>
									<variableDeclarationStatement type="System.String" name="authUrl">
										<init>
											<stringFormatExpression format="{{0}}?response_type=code&amp;client_id={{1}}&amp;redirect_uri={{2}}&amp;state={{3}}">
												<propertyReferenceExpression name="ClientUri"/>
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="RedirectUri">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="EscapeDataString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<methodInvokeExpression methodName="GetState"/>
													</parameters>
												</methodInvokeExpression>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<propertyReferenceExpression name="Scope"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="authUrl"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="authUrl"/>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="&amp;scope="/>
														<methodInvokeExpression methodName="EscapeDataString">
															<target>
																<typeReferenceExpression type="Uri"/>
															</target>
															<parameters>
																<propertyReferenceExpression name="Scope"/>
															</parameters>
														</methodInvokeExpression>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="username">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="QueryString">
														<propertyReferenceExpression name="Request">
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="HttpContext"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="username"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNotNullOrEmpty">
												<variableReferenceExpression name="username"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="authUrl"/>
												<binaryOperatorExpression operator="Add">
													<variableReferenceExpression name="authUrl"/>
													<binaryOperatorExpression operator="Add">
														<primitiveExpression value="&amp;username="/>
														<variableReferenceExpression name="username"/>
													</binaryOperatorExpression>
												</binaryOperatorExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="authUrl"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetAccessTokenRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetAccessTokenRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="code"/>
									<parameter type="System.Boolean" name="refresh"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<propertyReferenceExpression name="ClientUri"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="Method">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="POST"/>
									</assignStatement>
									<variableDeclarationStatement type="System.String" name="codeType">
										<init>
											<primitiveExpression value="code"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<variableReferenceExpression name="refresh"/>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="codeType"/>
												<primitiveExpression value="access_token"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="body">
										<init>
											<stringFormatExpression format="{{0}}={{1}}&amp;client_id={{2}}&amp;client_secret={{3}}&amp;redirect_uri={{4}}&amp;grant_type=authorization_code">
												<variableReferenceExpression name="codeType"/>
												<variableReferenceExpression name="code"/>
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<propertyReferenceExpression name="ClientSecret">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<methodInvokeExpression methodName="EscapeDataString">
													<target>
														<typeReferenceExpression type="Uri"/>
													</target>
													<parameters>
														<propertyReferenceExpression name="RedirectUri">
															<propertyReferenceExpression name="Config"/>
														</propertyReferenceExpression>
													</parameters>
												</methodInvokeExpression>
											</stringFormatExpression>
										</init>
									</variableDeclarationStatement>
									<variableDeclarationStatement type="System.Byte[]" name="bodyBytes">
										<init>
											<methodInvokeExpression methodName="GetBytes">
												<target>
													<propertyReferenceExpression name="UTF8">
														<typeReferenceExpression type="Encoding"/>
													</propertyReferenceExpression>
												</target>
												<parameters>
													<variableReferenceExpression name="body"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentType">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<primitiveExpression value="application/x-www-form-urlencoded"/>
									</assignStatement>
									<assignStatement>
										<propertyReferenceExpression name="ContentLength">
											<variableReferenceExpression name="request"/>
										</propertyReferenceExpression>
										<propertyReferenceExpression name="Length">
											<variableReferenceExpression name="bodyBytes"/>
										</propertyReferenceExpression>
									</assignStatement>
									<usingStatement>
										<variable type="Stream" name="stream">
											<init>
												<methodInvokeExpression methodName="GetRequestStream">
													<target>
														<variableReferenceExpression name="request"/>
													</target>
												</methodInvokeExpression>
											</init>
										</variable>
										<statements>
											<methodInvokeExpression methodName="Write">
												<target>
													<variableReferenceExpression name="stream"/>
												</target>
												<parameters>
													<variableReferenceExpression name="bodyBytes"/>
													<primitiveExpression value="0"/>
													<propertyReferenceExpression name="Length">
														<variableReferenceExpression name="bodyBytes"/>
													</propertyReferenceExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</usingStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetQueryRequest(string, string)-->
							<memberMethod returnType="WebRequest" name="GetQueryRequest">
								<attributes family="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="method"/>
									<parameter type="System.String" name="token"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="WebRequest" name="request">
										<init>
											<methodInvokeExpression methodName="Create">
												<target>
													<typeReferenceExpression type="WebRequest"/>
												</target>
												<parameters>
													<binaryOperatorExpression operator="Add">
														<propertyReferenceExpression name="ClientUri"/>
														<binaryOperatorExpression operator="Add">
															<primitiveExpression value="?method="/>
															<variableReferenceExpression name="method"/>
														</binaryOperatorExpression>
													</binaryOperatorExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<assignStatement>
										<arrayIndexerExpression>
											<target>
												<propertyReferenceExpression name="Headers">
													<variableReferenceExpression name="request"/>
												</propertyReferenceExpression>
											</target>
											<indices>
												<propertyReferenceExpression name="Authorization">
													<typeReferenceExpression type="HttpRequestHeader"/>
												</propertyReferenceExpression>
											</indices>
										</arrayIndexerExpression>
										<binaryOperatorExpression operator="Add">
											<primitiveExpression value="Bearer "/>
											<variableReferenceExpression name="token"/>
										</binaryOperatorExpression>
									</assignStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="request"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetState()-->
							<memberMethod returnType="System.String" name="GetState">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<binaryOperatorExpression operator="Add">
											<methodInvokeExpression methodName="GetState">
												<target>
													<baseReferenceExpression />
												</target>
											</methodInvokeExpression>
											<binaryOperatorExpression operator="Add">
												<primitiveExpression value="|showNavigation="/>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<propertyReferenceExpression name="Request">
																<propertyReferenceExpression name="Current">
																	<typeReferenceExpression type="HttpContext"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="showNavigation"/>
													</indices>
												</arrayIndexerExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- field _showNavigation-->
							<memberField type="System.String" name="showNavigation"/>
							<!-- method SetState(string)-->
							<memberMethod name="SetState">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="System.String" name="state"/>
								</parameters>
								<statements>
									<methodInvokeExpression methodName="SetState">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<variableReferenceExpression name="state"/>
										</parameters>
									</methodInvokeExpression>
									<foreachStatement>
										<variable type="System.String" name="part"/>
										<target>
											<methodInvokeExpression methodName="Split">
												<target>
													<variableReferenceExpression name="state"/>
												</target>
												<parameters>
													<primitiveExpression value="|" convertTo="Char"/>
												</parameters>
											</methodInvokeExpression>
										</target>
										<statements>
											<variableDeclarationStatement type="System.String[]" name="ps">
												<init>
													<methodInvokeExpression methodName="Split">
														<target>
															<variableReferenceExpression name="part"/>
														</target>
														<parameters>
															<primitiveExpression value="=" convertTo="Char"/>
														</parameters>
													</methodInvokeExpression>
												</init>
											</variableDeclarationStatement>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="ValueEquality">
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="ps"/>
															</target>
															<indices>
																<primitiveExpression value="0"/>
															</indices>
														</arrayIndexerExpression>
														<primitiveExpression value="showNavigation"/>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<assignStatement>
														<fieldReferenceExpression name="showNavigation"/>
														<arrayIndexerExpression>
															<target>
																<variableReferenceExpression name="ps"/>
															</target>
															<indices>
																<primitiveExpression value="1"/>
															</indices>
														</arrayIndexerExpression>
													</assignStatement>
												</trueStatements>
											</conditionStatement>
										</statements>
									</foreachStatement>
								</statements>
							</memberMethod>
							<!-- method RestoreSession(HttpContext)-->
							<memberMethod name="RestoreSession">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="HttpContext" name="context"/>
								</parameters>
								<statements>
									<conditionStatement>
										<condition>
											<unaryOperatorExpression operator="IsNullOrEmpty">
												<fieldReferenceExpression name="showNavigation"/>
											</unaryOperatorExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<fieldReferenceExpression name="showNavigation"/>
												<arrayIndexerExpression>
													<target>
														<propertyReferenceExpression name="QueryString">
															<propertyReferenceExpression name="Request">
																<variableReferenceExpression name="context"/>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</target>
													<indices>
														<primitiveExpression value="showNavigation"/>
													</indices>
												</arrayIndexerExpression>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<variableDeclarationStatement type="System.String" name="session">
										<init>
											<arrayIndexerExpression>
												<target>
													<propertyReferenceExpression name="QueryString">
														<propertyReferenceExpression name="Request">
															<variableReferenceExpression name="context"/>
														</propertyReferenceExpression>
													</propertyReferenceExpression>
												</target>
												<indices>
													<primitiveExpression value="session"/>
												</indices>
											</arrayIndexerExpression>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<binaryOperatorExpression operator="BooleanAnd">
												<unaryOperatorExpression operator="IsNotNullOrEmpty">
													<variableReferenceExpression name="session"/>
												</unaryOperatorExpression>
												<binaryOperatorExpression operator="ValueEquality">
													<variableReferenceExpression name="session"/>
													<primitiveExpression value="new"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</condition>
										<trueStatements>
											<methodInvokeExpression methodName="UserLogout">
												<target>
													<propertyReferenceExpression name="Current">
														<typeReferenceExpression type="ApplicationServices"/>
													</propertyReferenceExpression>
												</target>
											</methodInvokeExpression>
										</trueStatements>
										<falseStatements>
											<methodInvokeExpression methodName="RestoreSession">
												<target>
													<baseReferenceExpression/>
												</target>
												<parameters>
													<variableReferenceExpression name="context"/>
												</parameters>
											</methodInvokeExpression>
											<conditionStatement>
												<condition>
													<binaryOperatorExpression operator="BooleanAnd">
														<unaryOperatorExpression operator="Not">
															<propertyReferenceExpression name="StoreToken"/>
														</unaryOperatorExpression>
														<propertyReferenceExpression name="IsAuthenticated">
															<propertyReferenceExpression name="Identity">
																<propertyReferenceExpression name="User">
																	<variableReferenceExpression name="context"/>
																</propertyReferenceExpression>
															</propertyReferenceExpression>
														</propertyReferenceExpression>
													</binaryOperatorExpression>
												</condition>
												<trueStatements>
													<methodInvokeExpression methodName="RedirectToStartPage">
														<parameters>
															<variableReferenceExpression name="context"/>
														</parameters>
													</methodInvokeExpression>
												</trueStatements>
											</conditionStatement>
										</falseStatements>
									</conditionStatement>
								</statements>
							</memberMethod>
							<!-- method RedirectToStartPage(HttpContext)-->
							<memberMethod name="RedirectToStartPage">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="HttpContext" name="context"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="System.String" name="connector">
										<init>
											<primitiveExpression value="?"/>
										</init>
									</variableDeclarationStatement>
									<conditionStatement>
										<condition>
											<methodInvokeExpression methodName="Contains">
												<target>
													<propertyReferenceExpression name="StartPage"/>
												</target>
												<parameters>
													<primitiveExpression value="?"/>
												</parameters>
											</methodInvokeExpression>
										</condition>
										<trueStatements>
											<assignStatement>
												<variableReferenceExpression name="connector"/>
												<primitiveExpression value="&amp;"/>
											</assignStatement>
										</trueStatements>
									</conditionStatement>
									<assignStatement>
										<propertyReferenceExpression name="StartPage"/>
										<binaryOperatorExpression operator="Add">
											<propertyReferenceExpression name="StartPage"/>
											<binaryOperatorExpression operator="Add">
												<variableReferenceExpression name="connector"/>
												<binaryOperatorExpression operator="Add">
													<primitiveExpression value="_showNavigation="/>
													<fieldReferenceExpression name="showNavigation"/>
												</binaryOperatorExpression>
											</binaryOperatorExpression>
										</binaryOperatorExpression>
									</assignStatement>
									<methodInvokeExpression methodName="RedirectToStartPage">
										<target>
											<baseReferenceExpression/>
										</target>
										<parameters>
											<variableReferenceExpression name="context"/>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
							<!-- field userInfo-->
							<memberField type="JObject" name="userInfo"/>
							<!-- method GetUserName()-->
							<memberMethod returnType="System.String" name="GetUserName">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<fieldReferenceExpression name="userInfo"/>
												</target>
												<indices>
													<primitiveExpression value="UserName"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserName()-->
							<memberMethod returnType="System.String" name="GetUserEmail">
								<attributes public="true" override="true"/>
								<statements>
									<methodReturnStatement>
										<castExpression targetType="System.String">
											<arrayIndexerExpression>
												<target>
													<fieldReferenceExpression name="userInfo"/>
												</target>
												<indices>
													<primitiveExpression value="UserEmail"/>
												</indices>
											</arrayIndexerExpression>
										</castExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserRoles(MembershipUser)-->
							<memberMethod returnType="List" name="GetUserRoles">
								<typeArguments>
									<typeReference type="System.String"/>
								</typeArguments>
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<variableDeclarationStatement type="List" name="roles">
										<typeArguments>
											<typeReference type="System.String"/>
										</typeArguments>
										<init>
											<methodInvokeExpression methodName="GetUserRoles">
												<target>
													<baseReferenceExpression/>
												</target>
												<parameters>
													<variableReferenceExpression name="user"/>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<foreachStatement>
										<variable type="JToken" name="r"/>
										<target>
											<methodInvokeExpression methodName="Value">
												<typeArguments>
													<typeReference type="JArray"/>
												</typeArguments>
												<target>
													<fieldReferenceExpression name="userInfo"/>
												</target>
												<parameters>
													<primitiveExpression value="Roles"/>
												</parameters>
											</methodInvokeExpression>
										</target>
										<statements>
											<methodInvokeExpression methodName="Add">
												<target>
													<variableReferenceExpression name="roles"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="ToString">
														<target>
															<variableReferenceExpression name="r"/>
														</target>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</statements>
									</foreachStatement>
									<methodReturnStatement>
										<variableReferenceExpression name="roles"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method SyncUser-->
							<memberMethod returnType="MembershipUser" name="SyncUser">
								<attributes public="true" override="true"/>
								<statements>
									<assignStatement>
										<fieldReferenceExpression name="userInfo"/>
										<methodInvokeExpression methodName="Query">
											<parameters>
												<primitiveExpression value="me"/>
												<primitiveExpression value="false"/>
											</parameters>
										</methodInvokeExpression>
									</assignStatement>
									<variableDeclarationStatement type="MembershipUser" name="user">
										<init>
											<methodInvokeExpression methodName="SyncUser">
												<target>
													<baseReferenceExpression/>
												</target>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="WriteJson">
										<target>
											<typeReferenceExpression type="SiteContentFile"/>
										</target>
										<parameters>
											<stringFormatExpression format="sys/users/{{0}}.json">
												<propertyReferenceExpression name="UserName">
													<variableReferenceExpression name="user"/>
												</propertyReferenceExpression>
											</stringFormatExpression>
											<castExpression targetType="JObject">
												<arrayIndexerExpression>
													<target>
														<fieldReferenceExpression name="userInfo"/>
													</target>
													<indices>
														<primitiveExpression value="Tokens"/>
													</indices>
												</arrayIndexerExpression>
											</castExpression>
										</parameters>
									</methodInvokeExpression>
									<methodReturnStatement>
										<variableReferenceExpression name="user"/>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method GetUserImageUrl-->
							<memberMethod returnType="System.String" name="GetUserImageUrl">
								<attributes public="true" override="true"/>
								<parameters>
									<parameter type="MembershipUser" name="user"/>
								</parameters>
								<statements>
									<methodReturnStatement>
										<stringFormatExpression format="{{0}}/DnnImageHandler.ashx?mode=profilepic&amp;userId={{1}}&amp;h=80&amp;w=80">
											<propertyReferenceExpression name="ClientUri"/>
											<convertExpression to="Int32">
												<arrayIndexerExpression>
													<target>
														<fieldReferenceExpression name="userInfo"/>
													</target>
													<indices>
														<primitiveExpression value="UserID"/>
													</indices>
												</arrayIndexerExpression>
											</convertExpression>
										</stringFormatExpression>
									</methodReturnStatement>
								</statements>
							</memberMethod>
							<!-- method SignOut()-->
							<memberMethod name="SignOut">
								<attributes public="true" override="true"/>
								<statements>
									<variableDeclarationStatement type="System.String" name="url">
										<init>
											<methodInvokeExpression methodName="ResolveClientUrl">
												<target>
													<typeReferenceExpression type="ApplicationServices"/>
												</target>
												<parameters>
													<methodInvokeExpression methodName="UserHomePageUrl">
														<target>
															<propertyReferenceExpression name="Current">
																<typeReferenceExpression type="ApplicationServices"/>
															</propertyReferenceExpression>
														</target>
													</methodInvokeExpression>
												</parameters>
											</methodInvokeExpression>
										</init>
									</variableDeclarationStatement>
									<methodInvokeExpression methodName="Redirect">
										<target>
											<typeReferenceExpression type="ServiceRequestHandler"/>
										</target>
										<parameters>
											<stringFormatExpression format="{{0}}?_logout=true&amp;client_id={{1}}&amp;redirect_uri={{2}}">
												<propertyReferenceExpression name="ClientUri"/>
												<propertyReferenceExpression name="ClientId">
													<propertyReferenceExpression name="Config"/>
												</propertyReferenceExpression>
												<variableReferenceExpression name="url"/>
											</stringFormatExpression>
										</parameters>
									</methodInvokeExpression>
								</statements>
							</memberMethod>
						</members>
					</typeDeclaration>
				</xsl:if>
			</types>
		</compileUnit>
	</xsl:template>
</xsl:stylesheet>
