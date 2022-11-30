<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"
    xmlns:codeontime="urn:codeontime-com:web.config.xslt"
    exclude-result-prefixes="msxsl a app codeontime"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="Namespace"/>
  <xsl:param name="IsClassLibrary" select="'false'"/>
  <xsl:param name="ReportsEnabled" select="'false'"/>
  <xsl:param name="MembershipEnabled" select="'false'"/>
  <xsl:param name="SupportAllFeatures" select="'true'" />
  <xsl:param name="ApplicationPath" select="''"/>
  <xsl:param name="AnnotationsPath" select="''"/>
  <xsl:param name="TargetFramework" select="/a:project/@targetFramework"/>
	<xsl:param name="TargetFramework45Plus"/>
  <xsl:param name="UI" select="/a:project/@userInterface"/>
  <xsl:param name="FrameworkIsAssembly" select="'false'"/>
  <xsl:param name="LoginUrl"/>
  <xsl:param name="ProviderFactories"/>
  <xsl:param name="ProjectName"/>
  <xsl:param name="ScriptOnly" select="'false'"/>
  <xsl:param name="BlobAdapterConfigs"/>
  <xsl:param name="Host"/>
  <xsl:param name="IsUnlimited"/>
  <xsl:param name="ReportsVersion"/>

  <xsl:variable name="PageImplementation" select="/a:project/@pageImplementation"/>



  <msxsl:script implements-prefix="codeontime" language="C#">
    <![CDATA[
    public string GetProvider(string invariantName, string version, string providerFactories) 
    {
        Match m = Regex.Match(providerFactories, String.Format(@"{0}\.{1}=(.+?);", Regex.Escape(invariantName), Regex.Escape(version)));
        return m.Groups[1].Value;
    }
    public string ReadFromFile(string path, string pattern) {
      if (!System.IO.File.Exists(path)) return String.Empty;
      string text = System.IO.File.ReadAllText(path);
      Match m = Regex.Match(text, pattern);
      return m.Value;
    }
    public string ReadXmlFromFile(string path, string xpath) {
      if (!System.IO.File.Exists(path)) return String.Empty;
      XPathNavigator nav = new XPathDocument(path).CreateNavigator();
      XPathNavigator node = nav.SelectSingleNode(xpath);
      if (node != null)
        return node.OuterXml;
      return String.Empty;
      
    } 
    public string MembershipOptionValue(string map, string optionName, string defaultValue) { 
        map = "\r\n" + map;
        Match m = Regex.Match(map, @"$\s*option\s+(?'Name'.+?)\s*=\s*(?'Value'.+?)\s*(?:$)", RegexOptions.IgnoreCase | RegexOptions.Multiline);
        while (m.Success) {
           string name = Regex.Replace(m.Groups["Name"].Value, @"\s+", String.Empty);
           if (name.Equals(optionName, StringComparison.CurrentCultureIgnoreCase))
              return m.Groups["Value"].Value;
           m = m.NextMatch();
        }
        return defaultValue;
    } 
    public string ADOptionValue(string map, string optionName, string defaultValue) { 
        map = "\r\n" + map;
        Match m = Regex.Match(map, @"$\s*(?'Name'.+?)\s*=\s*(?'Value'.+?)\s*(?:$)", RegexOptions.IgnoreCase | RegexOptions.Multiline);
        while (m.Success) {
           string name = Regex.Replace(m.Groups["Name"].Value, @"\s+", String.Empty);
           if (name.Equals(optionName, StringComparison.CurrentCultureIgnoreCase))
              return m.Groups["Value"].Value;
           m = m.NextMatch();
        }
        return defaultValue;
    } 
    
    public XPathNodeIterator BlobAdapterAppSettings(string blobAdapterConfigs) {
        XmlDocument doc = new XmlDocument();
        StringBuilder sb = new StringBuilder("<list>");
        if (!String.IsNullOrEmpty(blobAdapterConfigs)) {
            sb.Append("<setting>BlobStorageKey</setting>");
            string[] lines = blobAdapterConfigs.Split(new char[] {'\r', '\n'}, StringSplitOptions.RemoveEmptyEntries);
            bool addedAzureKey = false, 
                addedS3Key = false;
            string controller = String.Empty;
            foreach (string line in lines) {
                string[] args = line.Split(new char[] {':', '=' }, 2, StringSplitOptions.None);
                if (args.Length == 2) {
                    string prop = args[0].Trim().ToLower();
                    string val = args[1].Trim();
                    if (prop == "controller")
                      controller = val;
                    else if (prop == "field")
                      sb.AppendFormat("<setting>{0}{1}BlobAdapter</setting>", controller, val);
                    //else if (prop == "storage-system") {
                    //  if (!addedAzureKey && val.ToLower() == "azure")
                    //    sb.AppendFormat("<setting>AzureBlobStorageKey</setting>");
                    //  if (!addedS3Key && val.ToLower() == "s3")
                    //    sb.AppendFormat("<setting>AmazonS3StorageKey</setting>");
                    //}
                    
                    if (val.StartsWith("$"))
                      sb.AppendFormat("<setting>{0}</setting>", val.Substring(1));
                }
            }
        }
        sb.Append("</list>");
        doc.LoadXml(sb.ToString());
        return doc.CreateNavigator().Select("/list/setting");
    }
    ]]>
  </msxsl:script>

  <xsl:variable name="AuthenticationType">
    <xsl:choose>
      <xsl:when test="$MembershipEnabled='true'">
        <xsl:text>Forms</xsl:text>
      </xsl:when>
      <xsl:when test="/a:project/a:membership/@windowsAuthentication='true'">
        <xsl:text>Windows</xsl:text>
      </xsl:when>
      <xsl:when test="/a:project/a:membership/@customSecurity='true'">
        <xsl:text>Custom</xsl:text>
      </xsl:when>
      <xsl:when test="/a:project/a:membership/@activeDirectory='true'">
        <xsl:text>AD</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>None</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="ConnectionStringName">
    <xsl:choose>
      <xsl:when test="/a:project/a:connectionString/@hostDatabaseSharing='true'">
        <xsl:text>SiteSqlServer</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="/a:project/a:namespace"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="MembershipProvider" select="/a:project/a:membership/@providerName"/>
  <xsl:variable name="MembershipConnectionStringName">
    <xsl:choose>
      <xsl:when test="/a:project/a:membership/@connectionString='' or /a:project/a:membership/@connectionString = /a:project/a:connectionString or $AuthenticationType='Custom'">
        <xsl:value-of select="$ConnectionStringName"/>
      </xsl:when>
      <xsl:when test="contains($MembershipProvider, 'Oracle')">
        <xsl:text>LocalOracleServer</xsl:text>
      </xsl:when>
      <xsl:when test="contains($MembershipProvider, 'MySql')">
        <xsl:text>LocalMySqlServer</xsl:text>
      </xsl:when>
      <xsl:when test="contains($MembershipProvider, 'SQLAnywhere')">
        <xsl:text>ApplicationServices</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>LocalSqlServer</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="ADConfig" select="/a:project/a:membership/a:adConfig"/>

  <xsl:template match="/">
    <xsl:comment xml:space="preserve">
      <![CDATA[Note: As an alternative to hand editing this file you can use the
      web admin tool to configure settings for your application. Use
      the Website->Asp.Net Configuration option in Visual Studio.
      A full list of settings and comments can be found in
      machine.config.comments usually located in
      \Windows\Microsoft.Net\Framework\v2.x\Config]]>
    </xsl:comment>
    <configuration>
      <xsl:if test="$TargetFramework='3.5'">
        <configSections>
          <sectionGroup name="system.web.extensions" type="System.Web.Configuration.SystemWebExtensionsSectionGroup, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35">
            <sectionGroup name="scripting" type="System.Web.Configuration.ScriptingSectionGroup, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35">
              <section name="scriptResourceHandler" type="System.Web.Configuration.ScriptingScriptResourceHandlerSection, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" requirePermission="false" allowDefinition="MachineToApplication" />
              <sectionGroup name="webServices" type="System.Web.Configuration.ScriptingWebServicesSectionGroup, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35">
                <section name="jsonSerialization" type="System.Web.Configuration.ScriptingJsonSerializationSection, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" requirePermission="false" allowDefinition="Everywhere" />
                <section name="profileService" type="System.Web.Configuration.ScriptingProfileServiceSection, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" requirePermission="false" allowDefinition="MachineToApplication" />
                <!--<xsl:if test="$AuthenticationType='Forms' or $AuthenticationType='Custom' or $AuthenticationType='AD'">
                  <section name="authenticationService" type="System.Web.Configuration.ScriptingAuthenticationServiceSection, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" requirePermission="false" allowDefinition="MachineToApplication" />
                </xsl:if>-->
                <section name="roleService" type="System.Web.Configuration.ScriptingRoleServiceSection, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" requirePermission="false" allowDefinition="MachineToApplication" />
              </sectionGroup>
            </sectionGroup>
          </sectionGroup>
        </configSections>
      </xsl:if>
      <xsl:if test="ProjectName='WebRole1'">
        <system.diagnostics>
          <trace>
            <listeners>
              <add type="Microsoft.WindowsAzure.Diagnostics.DiagnosticMonitorTraceListener, Microsoft.WindowsAzure.Diagnostics, Version=1.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
                name="AzureDiagnostics">
                <filter type="" />
              </add>
            </listeners>
          </trace>
        </system.diagnostics>
      </xsl:if>
      <appSettings>
        <xsl:if test="string-length($AnnotationsPath)&gt;0">
          <add key="AnnotationsPath" value="{$AnnotationsPath}"/>
        </xsl:if>
        <xsl:if test="$TargetFramework!='3.5' and $UI != 'TouchUI'">
          <add key="ChartImageHandler" value="storage=file;timeout=20;dir=c:\TempImageFiles\;" />
        </xsl:if>
        <xsl:if test="$AuthenticationType='Custom'">
          <add key="MembershipProviderValidationKey" value="{/a:project/a:membership/@validationKey}"/>
        </xsl:if>
        <xsl:variable name="MapsApiIdentifier" select="a:project/a:features/a:touch/@mapApiIdentifier"/>
        <xsl:if test="$MapsApiIdentifier!=''">
          <add key="MapsApiIdentifier" value="{$MapsApiIdentifier}"/>
        </xsl:if>
        <xsl:variable name="MapsApiIdentifierMobile" select="a:project/a:features/a:touch/@mapApiIdentifierMobile"/>
        <xsl:if test="$MapsApiIdentifierMobile!=''">
          <add key="MapsApiIdentifierMobile" value="{$MapsApiIdentifierMobile}"/>
        </xsl:if>
        <xsl:if test="$BlobAdapterConfigs!=''">
          <xsl:for-each select="codeontime:BlobAdapterAppSettings($BlobAdapterConfigs)">
            <add>
              <xsl:attribute name="key">
                <xsl:value-of select="current()"/>
              </xsl:attribute>
              <xsl:attribute name="value"/>
            </add>
          </xsl:for-each>
        </xsl:if>
      </appSettings>
      <connectionStrings>
        <xsl:if test="$AuthenticationType!='None'">
          <clear/>
        </xsl:if>
        <xsl:if test="$MembershipConnectionStringName!=$ConnectionStringName">
          <add name="{$MembershipConnectionStringName}" connectionString="{a:project/a:membership/@connectionString}" providerName="{$MembershipProvider}"/>
        </xsl:if>
        <xsl:if test="/a:project/a:host/@path!='' and /a:project/a:connectionString/@hostDatabaseSharing!='true'">
          <xsl:value-of select="codeontime:ReadXmlFromFile(concat(/a:project/a:host/@path, '\web.config'), '/configuration/connectionStrings/add[@name=&quot;SiteSqlServer&quot;]')" disable-output-escaping="yes"/>
        </xsl:if>
        <add name="{$ConnectionStringName}" connectionString="{/a:project/a:connectionString}" providerName="{/a:project/a:providerName}"/>
        <xsl:if test="$AuthenticationType = 'AD'">
          <add name="{$Namespace}ADConnectionString" connectionString="{codeontime:ADOptionValue($ADConfig, 'ConnectionString', 'null')}"/>
        </xsl:if>
      </connectionStrings>
      <system.web>
        <xsl:if test="$MembershipEnabled='true' and contains($MembershipProvider, 'SQLAnywhere')">
          <machineKey validation="SHA1"/>
        </xsl:if>
        <xsl:variable name="Globalization" select="/a:project/a:globalization"/>
        <globalization>
          <xsl:attribute name="culture">
            <xsl:choose>
              <xsl:when test="$Globalization[@culture='*' or @enableClientBasedCulture='true']">
                <xsl:text>auto</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$Globalization/@culture"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:attribute name="uiCulture">
            <xsl:choose>
              <xsl:when test="$Globalization[@uiCulture='*' or @enableClientBasedCulture='true']">
                <xsl:text>auto</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$Globalization/@uiCulture"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:if test="$Globalization/@enableClientBasedCulture='true'">
            <xsl:attribute name="enableClientBasedCulture">
              <xsl:text>true</xsl:text>
            </xsl:attribute>
          </xsl:if>
          <xsl:attribute name="fileEncoding">
            <xsl:text>utf-8</xsl:text>
          </xsl:attribute>
        </globalization>
        <xsl:comment xml:space="preserve">
        <![CDATA[Set compilation debug="true" to insert debugging
        symbols into the compiled page. Because this
        affects performance, set this value to true only
        during development.]]>
        </xsl:comment>
        <compilation debug="false">
          <xsl:if test="$TargetFramework!='3.5'">
            <xsl:attribute name="targetFramework">
              <xsl:value-of select="$TargetFramework"/>
            </xsl:attribute>
          </xsl:if>
          <assemblies>
            <xsl:choose>
              <xsl:when test="$TargetFramework45Plus='true'">
                <add assembly="System.Web.Extensions.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/>
                <add assembly="System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A"/>
                <add assembly="System.Transactions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
              </xsl:when>
              <xsl:when test="$TargetFramework='4.0'">
                <add assembly="System.Web.Extensions.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/>
                <add assembly="System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A"/>
                <add assembly="System.Transactions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
              </xsl:when>
              <xsl:otherwise>
                <add assembly="System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
                <add assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/>
                <add assembly="System.Data.DataSetExtensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
                <add assembly="System.Xml.Linq, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
                <add assembly="System.Web.Extensions.Design, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/>
                <add assembly="System.Design, Version=2.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A"/>
                <add assembly="System.Transactions, Version=2.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="$MembershipEnabled='true' and contains($MembershipProvider, 'MySql')">
              <xsl:choose>
                <xsl:when test="$TargetFramework='3.5'">
                  <add assembly="{codeontime:GetProvider('MySql.Data.MySqlClient', 'v2.0', $ProviderFactories)}"/>
                  <add assembly="{codeontime:GetProvider('MySQLMembershipProvider', 'v2.0', $ProviderFactories)}"/>
                </xsl:when>
                <xsl:otherwise>
                  <add assembly="{codeontime:GetProvider('MySql.Data.MySqlClient', 'v4.0', $ProviderFactories)}"/>
                  <add assembly="{codeontime:GetProvider('MySQLMembershipProvider', 'v4.0', $ProviderFactories)}"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
            <xsl:if test="/a:project/a:providerName='System.Data.OracleClient'">
              <xsl:choose>
                <xsl:when test="$TargetFramework='3.5'">
                  <add assembly="System.Data.OracleClient, Version=2.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
                </xsl:when>
                <xsl:otherwise>
                  <add assembly="System.Data.OracleClient, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
            <xsl:if test="/a:project/a:providerName='Oracle.DataAccess.Client'">
              <xsl:choose>
                <xsl:when test="$TargetFramework='3.5'">
                  <add assembly="{codeontime:GetProvider('Oracle.DataAccess.Client', 'v2.0', $ProviderFactories)}"/>
                </xsl:when>
                <xsl:otherwise>
                  <add assembly="{codeontime:GetProvider('Oracle.DataAccess.Client', 'v4.0', $ProviderFactories)}"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
            <xsl:if test="/a:project/a:providerName='Oracle.ManagedDataAccess.Client'">
              <xsl:choose>
                <xsl:when test="$TargetFramework='3.5'">
                  <add assembly="{codeontime:GetProvider('Oracle.ManagedDataAccess.Client', 'v2.0', $ProviderFactories)}"/>
                </xsl:when>
                <xsl:otherwise>
                  <add assembly="{codeontime:GetProvider('Oracle.ManagedDataAccess.Client', 'v4.0', $ProviderFactories)}"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
            <xsl:if test="$ReportsEnabled='true'">
              <xsl:choose>
                <xsl:when test="$ReportsVersion='15'">
                  <add assembly="Microsoft.SqlServer.Types, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"/>
                  <add assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"/>
                </xsl:when>
                <xsl:when test="$ReportsVersion='14'">
                  <add assembly="Microsoft.SqlServer.Types, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"/>
                  <add assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"/>
                </xsl:when>
                <xsl:when test="$ReportsVersion='12'">
                  <add assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"/>
                </xsl:when>
                <xsl:when test="$ReportsVersion='11'">
                  <add assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"/>
                </xsl:when>
                <xsl:when test="$ReportsVersion='10'">
                  <add assembly="Microsoft.ReportViewer.Common, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"/>
                  <add assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"/>
                </xsl:when>
                <xsl:otherwise>
                  <add assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A" />
                  <add assembly="Microsoft.ReportViewer.Common, Version=9.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A" />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
            <xsl:if test="$TargetFramework='4.0'">
              <add assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/>
            </xsl:if>
            <xsl:if test="$TargetFramework45Plus='true'">
              <add assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/>
            </xsl:if>
            <xsl:if test="$AuthenticationType = 'AD'">
              <xsl:choose>
                <xsl:when test="$TargetFramework='3.5'">
                  <add assembly="System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A"/>
                  <add assembly="System.DirectoryServices.AccountManagement, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
                </xsl:when>
                <xsl:otherwise>
                  <add assembly="System.DirectoryServices, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A"/>
                  <add assembly="System.DirectoryServices.AccountManagement, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </assemblies>
          <xsl:if test="$ReportsEnabled='true'">
            <buildProviders>
              <xsl:choose>
                <xsl:when test="$ReportsVersion='15'">
                  <add extension=".rdlc" type="Microsoft.Reporting.RdlBuildProvider, Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" />
                </xsl:when>
                <xsl:when test="$ReportsVersion='14'">
                  <add extension=".rdlc" type="Microsoft.Reporting.RdlBuildProvider, Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" />
                </xsl:when>
                <xsl:when test="$ReportsVersion='12'">
                  <add extension=".rdlc" type="Microsoft.Reporting.RdlBuildProvider, Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" />
                </xsl:when>
                <xsl:when test="$ReportsVersion='11'">
                  <add extension=".rdlc" type="Microsoft.Reporting.RdlBuildProvider, Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" />
                </xsl:when>
                <xsl:when test="$ReportsVersion='10'">
                  <add extension=".rdlc" type="Microsoft.Reporting.RdlBuildProvider, Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
                </xsl:when>
                <xsl:otherwise>
                  <add extension=".rdlc" type="Microsoft.Reporting.RdlBuildProvider, Microsoft.ReportViewer.Common, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
                </xsl:otherwise>
              </xsl:choose>
            </buildProviders>
          </xsl:if>
        </compilation>
        <xsl:if test="$MembershipEnabled='true'">
          <xsl:choose>
            <xsl:when test="contains($MembershipProvider, 'Oracle')">
              <membership defaultProvider="OracleMembershipProvider">
                <providers>
                  <clear />
                  <add name="OracleMembershipProvider" type="{$Namespace}.Security.OracleMembershipProvider" connectionStringName="{$MembershipConnectionStringName}" applicationName="/" />
                </providers>
              </membership>
            </xsl:when>
            <xsl:when test="contains($MembershipProvider, 'MySql')">
              <membership defaultProvider="MySQLMembershipProvider">
                <providers>
                  <clear />
                  <add name="MySQLMembershipProvider" autogenerateschema="true" type="MySql.Web.Security.MySQLMembershipProvider" connectionStringName="{$MembershipConnectionStringName}" applicationName="/" />
                </providers>
              </membership>
            </xsl:when>
            <xsl:when test="contains($MembershipProvider, 'SQLAnywhere')">
              <membership defaultProvider="SAMembershipProvider">
                <providers>
                  <clear />
                  <add name="SAMembershipProvider" type="iAnywhere.Web.Security.SAMembershipProvider"
                       connectionStringName="{$MembershipConnectionStringName}" passwordFormat="hashed" applicationName="/"/>
                </providers>
              </membership>
            </xsl:when>
            <xsl:otherwise>
              <membership>
                <providers>
                  <clear />
                  <add name="AspNetSqlMembershipProvider"
                       type="System.Web.Security.SqlMembershipProvider"
                       connectionStringName="{$MembershipConnectionStringName}"
                       applicationName="/" />
                </providers>
              </membership>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:comment xml:space="preserve">
        <![CDATA[The <authentication> section enables configuration 
        of the security authentication mode used by 
        ASP.NET to identify an incoming user. ]]>
        </xsl:comment>
        <xsl:choose>
          <xsl:when test="/a:project/a:host/@path!=''">
            <authentication mode="Forms">
              <forms loginUrl="~/Login.aspx">
                <xsl:if test="/a:project/a:membership/@idleUserDetectionTimeout>0">
                  <xsl:attribute name="timeout">
                    <xsl:value-of select="/a:project/a:membership/@idleUserDetectionTimeout+5"/>
                  </xsl:attribute>
                </xsl:if>
              </forms>
            </authentication>
            <xsl:choose>
              <xsl:when test="$Host='DotNetNuke'">
                <authorization>
                  <allow users="?" />
                </authorization>
              </xsl:when>
              <xsl:otherwise>
                <authorization>
                  <deny users="?" />
                </authorization>
              </xsl:otherwise>
            </xsl:choose>
            <roleManager enabled="true"/>
            <xsl:value-of select="codeontime:ReadFromFile(concat(/a:project/a:host/@path, '\web.config'), '&lt;machineKey [\s\S]+?/>')" disable-output-escaping="yes"/>
            <xsl:value-of select="codeontime:ReadFromFile(concat(/a:project/a:host/@path, '\web.config'), '&lt;membership [\s\S]+?&lt;/membership>')" disable-output-escaping="yes"/>
          </xsl:when>
          <xsl:when test="$AuthenticationType='Forms' or $AuthenticationType='Custom' or $AuthenticationType = 'AD'">
            <authentication mode="Forms">
              <forms>
                <xsl:attribute name="loginUrl">
                  <xsl:choose>
                    <xsl:when test="$LoginUrl">
                      <xsl:value-of select="$LoginUrl"/>
                    </xsl:when>
                    <xsl:when test="/a:project/a:membership/@dedicatedLogin='true'">
                      <xsl:choose>
                        <xsl:when test="$PageImplementation='html'">
                          <xsl:text>~/login</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>~/Login.aspx</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$ApplicationPath!=''">
                      <xsl:choose>
                        <xsl:when test="$PageImplementation='html'">
                          <xsl:text>~/pages/home</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>~/Pages/Home.aspx</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:choose>
                        <xsl:when test="$PageImplementation='html'">
                          <xsl:text>~</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>~/Default.aspx</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:if test="/a:project/a:membership/@idleUserDetectionTimeout>0">
                  <xsl:attribute name="timeout">
                    <xsl:value-of select="/a:project/a:membership/@idleUserDetectionTimeout + 5"/>
                  </xsl:attribute>
                </xsl:if>
              </forms>
            </authentication>
            <authorization>
              <allow users="?" />
            </authorization>
            <xsl:choose>
              <xsl:when test="$AuthenticationType='Custom'">
                <xsl:variable name="Config" select="/a:project/a:membership/a:config"/>
                <roleManager enabled="true" defaultProvider="{$Namespace}ApplicationRoleProvider">
                  <providers>
                    <clear/>
                    <add name="{$Namespace}ApplicationRoleProvider" type="{$Namespace}.Security.ApplicationRoleProvider" connectionStringName="{$Namespace}">
                      <!-- writeExceptionsToEventLog -->
                      <xsl:variable name="WriteExceptionsToEventLog" select="codeontime:MembershipOptionValue($Config, 'WriteExceptionsToEventLog', 'false')"/>
                      <xsl:if test="$WriteExceptionsToEventLog != 'false'">
                        <xsl:attribute name="writeExceptionsToEventLog">
                          <xsl:value-of select="$WriteExceptionsToEventLog"/>
                        </xsl:attribute>
                      </xsl:if>
                    </add>
                  </providers>
                </roleManager>
                <membership defaultProvider="{$Namespace}ApplicationMembershipProvider">
                  <providers>
                    <clear/>
                    <add name="{$Namespace}ApplicationMembershipProvider" type="{$Namespace}.Security.ApplicationMembershipProvider" connectionStringName="{$Namespace}">
                      <!-- passwordFormat -->
                      <xsl:variable name="PasswordFormat" select="codeontime:MembershipOptionValue($Config, 'PasswordFormat', 'Hashed')"/>
                      <xsl:if test="$PasswordFormat != 'Hashed'">
                        <xsl:attribute name="passwordFormat">
                          <xsl:value-of select="$PasswordFormat"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- writeExceptionsToEventLog -->
                      <xsl:variable name="WriteExceptionsToEventLog" select="codeontime:MembershipOptionValue($Config, 'WriteExceptionsToEventLog', 'false')"/>
                      <xsl:if test="$WriteExceptionsToEventLog != 'false'">
                        <xsl:attribute name="writeExceptionsToEventLog">
                          <xsl:value-of select="$WriteExceptionsToEventLog"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- maxInvalidPasswordAttempts -->
                      <xsl:variable name="MaxInvalidPasswordAttempts" select="codeontime:MembershipOptionValue($Config, 'MaxInvalidPasswordAttempts', '5')"/>
                      <xsl:if test="$MaxInvalidPasswordAttempts != '5'">
                        <xsl:attribute name="maxInvalidPasswordAttempts">
                          <xsl:value-of select="$MaxInvalidPasswordAttempts"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- passwordAttemptWindow -->
                      <xsl:variable name="PasswordAttemptWindow" select="codeontime:MembershipOptionValue($Config, 'PasswordAttemptWindow', '10')"/>
                      <xsl:if test="$PasswordAttemptWindow != '10'">
                        <xsl:attribute name="passwordAttemptWindow">
                          <xsl:value-of select="$PasswordAttemptWindow"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- minRequiredNonAlphanumericCharacters -->
                      <xsl:variable name="MinRequiredNonAlphanumericCharacters" select="codeontime:MembershipOptionValue($Config, 'MinRequiredNonAlphanumericCharacters', '1')"/>
                      <xsl:if test="$MinRequiredNonAlphanumericCharacters != '1'">
                        <xsl:attribute name="minRequiredNonAlphanumericCharacters">
                          <xsl:value-of select="$MinRequiredNonAlphanumericCharacters"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- minRequiredPasswordLength -->
                      <xsl:variable name="MinRequiredPasswordLength" select="codeontime:MembershipOptionValue($Config, 'MinRequiredPasswordLength', '7')"/>
                      <xsl:if test="$MinRequiredPasswordLength != '7'">
                        <xsl:attribute name="minRequiredPasswordLength">
                          <xsl:value-of select="$MinRequiredPasswordLength"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- passwordStrengthRegularExpression -->
                      <xsl:variable name="PasswordStrengthRegularExpression" select="codeontime:MembershipOptionValue($Config, 'PasswordStrengthRegularExpression', '')"/>
                      <xsl:if test="$PasswordStrengthRegularExpression != ''">
                        <xsl:attribute name="passwordStrengthRegularExpression">
                          <xsl:value-of select="$PasswordStrengthRegularExpression"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- enablePasswordReset -->
                      <xsl:variable name="EnablePasswordReset" select="codeontime:MembershipOptionValue($Config, 'EnablePasswordReset', 'true')"/>
                      <xsl:if test="$EnablePasswordReset != 'true'">
                        <xsl:attribute name="enablePasswordReset">
                          <xsl:value-of select="$EnablePasswordReset"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- enablePasswordRetrieval -->
                      <xsl:variable name="EnablePasswordRetrieval" select="codeontime:MembershipOptionValue($Config, 'EnablePasswordRetrieval', 'true')"/>
                      <xsl:if test="$EnablePasswordRetrieval != 'true'">
                        <xsl:attribute name="enablePasswordRetrieval">
                          <xsl:value-of select="$EnablePasswordRetrieval"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- requiresQuestionAndAnswer -->
                      <xsl:variable name="RequiresQuestionAndAnswer" select="codeontime:MembershipOptionValue($Config, 'RequiresQuestionAndAnswer', 'false')"/>
                      <xsl:if test="$RequiresQuestionAndAnswer != 'false'">
                        <xsl:attribute name="requiresQuestionAndAnswer">
                          <xsl:value-of select="$RequiresQuestionAndAnswer"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- requiresUniqueEmail -->
                      <xsl:variable name="RequiresUniqueEmail" select="codeontime:MembershipOptionValue($Config, 'RequiresUniqueEmail', 'true')"/>
                      <xsl:if test="$RequiresUniqueEmail != 'true'">
                        <xsl:attribute name="requiresUniqueEmail">
                          <xsl:value-of select="$RequiresUniqueEmail"/>
                        </xsl:attribute>
                      </xsl:if>
                    </add>
                  </providers>
                </membership>
              </xsl:when>
              <xsl:when test="$AuthenticationType = 'AD'">
                <membership defaultProvider="{$Namespace}MembershipProvider">
                  <providers>
                    <clear/>
                    <add name="{$Namespace}MembershipProvider">
                      <xsl:attribute name="type">
                        <xsl:choose>
                          <xsl:when test="$TargetFramework45Plus='true' or $TargetFramework='4.0'">
                            <xsl:text>System.Web.Security.ActiveDirectoryMembershipProvider, System.Web, Version=4.0.0.0,Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a</xsl:text>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:text>System.Web.Security.ActiveDirectoryMembershipProvider, System.Web, Version=2.0.0.0,Culture=neutral, PublicKeyToken=b03f5f7f11d50a3</xsl:text>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                      <!-- connectionStringName -->
                      <xsl:attribute name="connectionStringName">
                        <xsl:value-of select="$Namespace"/>
                        <xsl:text>ADConnectionString</xsl:text>
                      </xsl:attribute>
                      <!-- userName -->
                      <xsl:variable name="ADConnectionUserName" select="codeontime:ADOptionValue($ADConfig, 'ConnectionUserName', '')"/>
                      <xsl:if test="$ADConnectionUserName != ''">
                        <xsl:attribute name="connectionUsername">
                          <xsl:value-of select="$ADConnectionUserName"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- password-->
                      <xsl:variable name="ADConnectionPassword" select="codeontime:ADOptionValue($ADConfig, 'ConnectionPassword', '')"/>
                      <xsl:if test="$ADConnectionPassword != ''">
                        <xsl:attribute name="connectionPassword">
                          <xsl:value-of select="$ADConnectionPassword"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- connection protection-->
                      <xsl:variable name="ADConnectionProtection" select="codeontime:ADOptionValue($ADConfig, 'ConnectionProtection', '')"/>
                      <xsl:if test="$ADConnectionProtection != ''">
                        <xsl:attribute name="connectionProtection">
                          <xsl:value-of select="$ADConnectionProtection"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- enable password reset-->
                      <xsl:variable name="ADEnablePasswordReset" select="codeontime:ADOptionValue($ADConfig, 'EnablePasswordReset', '')"/>
                      <xsl:if test="$ADEnablePasswordReset != ''">
                        <xsl:attribute name="enablePasswordReset">
                          <xsl:value-of select="$ADEnablePasswordReset"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- enable search methods-->
                      <xsl:variable name="ADEnableSeachMethods" select="codeontime:ADOptionValue($ADConfig, 'EnableSearchMethods', '')"/>
                      <xsl:if test="$ADEnableSeachMethods != ''">
                        <xsl:attribute name="enableSearchMethods">
                          <xsl:value-of select="$ADEnableSeachMethods"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- RequiresQuestionAndAnswer-->
                      <xsl:variable name="ADRequiresQuestionAndAnswer" select="codeontime:ADOptionValue($ADConfig, 'RequiresQuestionAndAnswer', '')"/>
                      <xsl:if test="$ADRequiresQuestionAndAnswer != ''">
                        <xsl:attribute name="requiresQuestionAndAnswer">
                          <xsl:value-of select="$ADRequiresQuestionAndAnswer"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- applicationName-->
                      <xsl:variable name="ADApplicationName" select="codeontime:ADOptionValue($ADConfig, 'ApplicationName', '')"/>
                      <xsl:if test="$ADApplicationName != ''">
                        <xsl:attribute name="applicationName">
                          <xsl:value-of select="$ADApplicationName"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- Description-->
                      <xsl:variable name="ADDescription" select="codeontime:ADOptionValue($ADConfig, 'Description', '')"/>
                      <xsl:if test="$ADDescription != ''">
                        <xsl:attribute name="description">
                          <xsl:value-of select="$ADDescription"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- requiresUniqueEmail-->
                      <xsl:variable name="ADRequiresUniqueEmail" select="codeontime:ADOptionValue($ADConfig, 'RequiresUniqueEmail', '')"/>
                      <xsl:if test="$ADRequiresUniqueEmail != ''">
                        <xsl:attribute name="requiresUniqueEmail">
                          <xsl:value-of select="$ADRequiresUniqueEmail"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- clientSearchTimeout-->
                      <xsl:variable name="ADClientSearchTimeout" select="codeontime:ADOptionValue($ADConfig, 'ClientSearchTimeout', '')"/>
                      <xsl:if test="$ADClientSearchTimeout != ''">
                        <xsl:attribute name="clientSearchTimeout">
                          <xsl:value-of select="$ADClientSearchTimeout"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- ServerSearchTimeout-->
                      <xsl:variable name="ADServerSearchTimeout" select="codeontime:ADOptionValue($ADConfig, 'ServerSearchTimeout', '')"/>
                      <xsl:if test="$ADServerSearchTimeout != ''">
                        <xsl:attribute name="serverSearchTimeout">
                          <xsl:value-of select="$ADServerSearchTimeout"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- attributeMapPasswordQuestion-->
                      <xsl:variable name="ADAttributeMapPasswordQuestion" select="codeontime:ADOptionValue($ADConfig, 'AttributeMapPasswordQuestion', '')"/>
                      <xsl:if test="$ADAttributeMapPasswordQuestion != ''">
                        <xsl:attribute name="attributeMapPasswordQuestion">
                          <xsl:value-of select="$ADAttributeMapPasswordQuestion"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- attributeMapPasswordAnswer-->
                      <xsl:variable name="ADAttributeMapPasswordAnswer" select="codeontime:ADOptionValue($ADConfig, 'AttributeMapPasswordAnswer', '')"/>
                      <xsl:if test="$ADAttributeMapPasswordAnswer != ''">
                        <xsl:attribute name="attributeMapPasswordAnswer">
                          <xsl:value-of select="$ADAttributeMapPasswordAnswer"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- attributeMapFailedPasswordAnswerCount-->
                      <xsl:variable name="ADAttributeMapFailedPasswordAnswerCount" select="codeontime:ADOptionValue($ADConfig, 'AttributeMapFailedPasswordAnswerCount', '')"/>
                      <xsl:if test="$ADAttributeMapFailedPasswordAnswerCount != ''">
                        <xsl:attribute name="attributeMapFailedPasswordAnswerCount">
                          <xsl:value-of select="$ADAttributeMapFailedPasswordAnswerCount"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- attributeMapFailedPasswordAnswerTime-->
                      <xsl:variable name="ADAttributeMapFailedPasswordAnswerTime" select="codeontime:ADOptionValue($ADConfig, 'AttributeMapFailedPasswordAnswerTime', '')"/>
                      <xsl:if test="$ADAttributeMapFailedPasswordAnswerTime != ''">
                        <xsl:attribute name="attributeMapFailedPasswordAnswerTime">
                          <xsl:value-of select="$ADAttributeMapFailedPasswordAnswerTime"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- attributeMapFailedPasswordAnswerLockoutTime-->
                      <xsl:variable name="ADAttributeMapFailedPasswordAnswerLockoutTime" select="codeontime:ADOptionValue($ADConfig, 'AttributeMapFailedPasswordAnswerLockoutTime', '')"/>
                      <xsl:if test="$ADAttributeMapFailedPasswordAnswerLockoutTime != ''">
                        <xsl:attribute name="attributeMapFailedPasswordAnswerLockoutTime">
                          <xsl:value-of select="$ADAttributeMapFailedPasswordAnswerLockoutTime"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- attributeMapEmail -->
                      <xsl:variable name="ADAttributeMapEmail" select="codeontime:ADOptionValue($ADConfig, 'AttributeMapEmail', '')"/>
                      <xsl:if test="$ADAttributeMapEmail != ''">
                        <xsl:attribute name="attributeMapEmail">
                          <xsl:value-of select="$ADAttributeMapEmail"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- attributeMapUsername  -->
                      <xsl:variable name="ADAttributeMapUsername" select="codeontime:ADOptionValue($ADConfig, 'AttributeMapUsername', '')"/>
                      <xsl:if test="$ADAttributeMapUsername != ''">
                        <xsl:attribute name="attributeMapUsername">
                          <xsl:value-of select="$ADAttributeMapUsername"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- maxInvalidPasswordAttempts   -->
                      <xsl:variable name="ADMaxInvalidPasswordAttempts" select="codeontime:ADOptionValue($ADConfig, 'MaxInvalidPasswordAttempts', '')"/>
                      <xsl:if test="$ADMaxInvalidPasswordAttempts != ''">
                        <xsl:attribute name="maxInvalidPasswordAttempts">
                          <xsl:value-of select="$ADMaxInvalidPasswordAttempts"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- passwordAttemptWindow-->
                      <xsl:variable name="ADPasswordAttemptWindow" select="codeontime:ADOptionValue($ADConfig, 'PasswordAttemptWindow', '')"/>
                      <xsl:if test="$ADPasswordAttemptWindow != ''">
                        <xsl:attribute name="passwordAttemptWindow">
                          <xsl:value-of select="$ADPasswordAttemptWindow"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- passwordAnswerAttemptLockoutDuration -->
                      <xsl:variable name="ADPasswordAnswerAttemptLockoutDuration" select="codeontime:ADOptionValue($ADConfig, 'PasswordAnswerAttemptLockoutDuration', '')"/>
                      <xsl:if test="$ADPasswordAnswerAttemptLockoutDuration != ''">
                        <xsl:attribute name="passwordAnswerAttemptLockoutDuration">
                          <xsl:value-of select="$ADPasswordAnswerAttemptLockoutDuration"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- minRequiredPasswordLength -->
                      <xsl:variable name="ADMinRequiredPasswordLength" select="codeontime:ADOptionValue($ADConfig, 'MinRequiredPasswordLength', '')"/>
                      <xsl:if test="$ADMinRequiredPasswordLength != ''">
                        <xsl:attribute name="minRequiredPasswordLength">
                          <xsl:value-of select="$ADMinRequiredPasswordLength"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- minRequiredNonalphanumericCharacters -->
                      <xsl:variable name="ADMinRequiredNonalphanumericCharacters" select="codeontime:ADOptionValue($ADConfig, 'MinRequiredNonalphanumericCharacters', '')"/>
                      <xsl:if test="$ADMinRequiredNonalphanumericCharacters != ''">
                        <xsl:attribute name="minRequiredNonalphanumericCharacters">
                          <xsl:value-of select="$ADMinRequiredNonalphanumericCharacters"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- passwordStrengthRegularExpression -->
                      <xsl:variable name="ADPasswordStrengthRegularExpression" select="codeontime:ADOptionValue($ADConfig, 'PasswordStrengthRegularExpression', '')"/>
                      <xsl:if test="$ADPasswordStrengthRegularExpression != ''">
                        <xsl:attribute name="passwordStrengthRegularExpression">
                          <xsl:value-of select="$ADPasswordStrengthRegularExpression"/>
                        </xsl:attribute>
                      </xsl:if>
                    </add>
                  </providers>
                </membership>
                <roleManager enabled="true" defaultProvider="{$Namespace}ApplicationRoleProvider">
                  <providers>
                    <clear/>
                    <add name="{$Namespace}ApplicationRoleProvider" type="{$Namespace}.Security.ApplicationRoleProvider" activeDirectoryConnectionString="{$Namespace}ADConnectionString">
                      <!-- enableCache -->
                      <xsl:variable name="EnableCache" select="codeontime:ADOptionValue($ADConfig, 'EnableCache', 'True')"/>
                      <xsl:attribute name="enableCache">
                        <xsl:value-of select="$EnableCache"/>
                      </xsl:attribute>
                      <!-- roleWhiteList-->
                      <xsl:variable name="RoleWhiteList" select="codeontime:ADOptionValue($ADConfig, 'RoleWhitelist', '')"/>
                      <xsl:if test="$RoleWhiteList != ''">
                        <xsl:attribute name="roleWhitelist">
                          <xsl:value-of select="$RoleWhiteList"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- roleBlackList-->
                      <xsl:variable name="RoleBlackList" select="codeontime:ADOptionValue($ADConfig, 'RoleBlacklist', '')"/>
                      <xsl:if test="$RoleBlackList != ''">
                        <xsl:attribute name="roleBlacklist">
                          <xsl:value-of select="$RoleBlackList"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- userBlackList-->
                      <xsl:variable name="UserBlackList" select="codeontime:ADOptionValue($ADConfig, 'UserBlacklist', '')"/>
                      <xsl:if test="$UserBlackList != ''">
                        <xsl:attribute name="userBlacklist">
                          <xsl:value-of select="$UserBlackList"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- cacheTimeInMinutes-->
                      <xsl:variable name="CacheTimeInMinutes" select="codeontime:ADOptionValue($ADConfig, 'CacheTimeInMinutes', '10')"/>
                      <xsl:if test="$CacheTimeInMinutes != '10'">
                        <xsl:attribute name="cacheTimeInMinutes">
                          <xsl:value-of select="$CacheTimeInMinutes"/>
                        </xsl:attribute>
                      </xsl:if>
                      <!-- contextType-->
                      <xsl:variable name="ContextType" select="codeontime:ADOptionValue($ADConfig, 'ContextType', '')"/>
                      <xsl:if test="$ContextType != '10'">
                        <xsl:attribute name="contextType">
                          <xsl:value-of select="$ContextType"/>
                        </xsl:attribute>
                      </xsl:if>
                    </add>
                  </providers>
                </roleManager>
              </xsl:when>
              <xsl:otherwise>
                <roleManager enabled="true">
                  <xsl:choose>
                    <xsl:when test="contains($MembershipProvider,'Oracle')">
                      <xsl:attribute name="defaultProvider">
                        <xsl:text>OracleRoleProvider</xsl:text>
                      </xsl:attribute>
                      <providers>
                        <!--<remove name="OracleRoleProvider"/>-->
                        <clear/>
                        <add name="OracleRoleProvider" type="{$Namespace}.Security.OracleRoleProvider" connectionStringName="{$MembershipConnectionStringName}" applicationName="/" />
                      </providers>
                    </xsl:when>
                    <xsl:when test="contains($MembershipProvider,'MySql')">
                      <xsl:attribute name="defaultProvider">
                        <xsl:text>MySQLRoleProvider</xsl:text>
                      </xsl:attribute>
                      <providers>
                        <clear />
                        <add name="MySQLRoleProvider" type="MySql.Web.Security.MySQLRoleProvider" connectionStringName="{$MembershipConnectionStringName}" applicationName="/" />
                      </providers>
                    </xsl:when>
                    <xsl:when test="contains($MembershipProvider,'SQLAnywhere')">
                      <xsl:attribute name="defaultProvider">
                        <xsl:text>SARoleProvider</xsl:text>
                      </xsl:attribute>
                      <providers>
                        <clear />
                        <add name="SARoleProvider" type="iAnywhere.Web.Security.SARoleProvider" connectionStringName="{$MembershipConnectionStringName}" applicationName="/"/>
                      </providers>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="defaultProvider">
                        <xsl:text>AspNetSqlRoleProvider</xsl:text>
                      </xsl:attribute>
                      <providers>
                        <clear />
                        <add name="AspNetSqlRoleProvider" type="System.Web.Security.SqlRoleProvider" connectionStringName="{$MembershipConnectionStringName}" applicationName="/" />
                      </providers>
                    </xsl:otherwise>
                  </xsl:choose>
                </roleManager>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="$AuthenticationType='Windows'">
            <authentication mode="Windows"/>
            <authorization>
              <allow users="?" />
            </authorization>
            <roleManager enabled="true" defaultProvider="AspNetWindowsTokenRoleProvider" >
              <providers>
                <clear/>
                <add name="AspNetWindowsTokenRoleProvider" applicationName="/" type="System.Web.Security.WindowsTokenRoleProvider"/>
              </providers>
            </roleManager>
          </xsl:when>
          <xsl:otherwise>
            <authentication mode="None"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="a:project/a:connectionString/@sessionStateMode='Custom'">
            <sessionState regenerateExpiredSessionId="true" mode="Custom" customProvider="ApplicationSessionState">
              <providers>
                <add name="ApplicationSessionState">
                  <xsl:attribute name="type">
                    <xsl:value-of select="$Namespace"/>
                    <xsl:text>.Services.ApplicationSessionState</xsl:text>
                  </xsl:attribute>
                </add>
              </providers>
            </sessionState>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="$ProjectName='WebRole1'">
              <sessionState  mode="SQLServer" cookieless="false" timeout="30" allowCustomSqlDatabase="true" sqlConnectionString="{/a:project/a:connectionString}" />
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:variable name="SiteMapProvider">
          <xsl:choose>
            <xsl:when test="$Host=''">
              <xsl:value-of select="$Namespace"/>
              <xsl:text>.Services.ApplicationSiteMapProvider</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>System.Web.XmlSiteMapProvider</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <siteMap defaultProvider="XmlSiteMapProvider" enabled="true">
          <providers>
            <clear />
            <add name="XmlSiteMapProvider"
							type="{$SiteMapProvider}"
							siteMapFile="Web.sitemap"
							securityTrimmingEnabled="true" />
          </providers>
        </siteMap>
        <xsl:comment xml:space="preserve">
        <![CDATA[The <customErrors> section enables configuration 
        of what to do if/when an unhandled error occurs 
        during the execution of a request. Specifically, 
        it enables developers to configure html error pages 
        to be displayed in place of a error stack trace.

        <customErrors mode="RemoteOnly" defaultRedirect="GenericErrorPage.htm">
            <error statusCode="403" redirect="NoAccess.htm" />
            <error statusCode="404" redirect="FileNotFound.htm" />
        </customErrors>]]>
        </xsl:comment>
        <pages>
          <xsl:if test="$IsClassLibrary='false' or $FrameworkIsAssembly='true'">
            <xsl:if test="$UI='Desktop' or $UI='Both'">
              <xsl:attribute name="theme">
                <xsl:value-of select="$Namespace"/>
              </xsl:attribute>
            </xsl:if>
          </xsl:if>
          <xsl:if test="$TargetFramework!='3.5'">
            <xsl:attribute name="controlRenderingCompatibilityVersion">
              <xsl:text>3.5</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="clientIDMode">
              <xsl:text>AutoID</xsl:text>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="$ProjectName='Sandbox'">
            <xsl:attribute name="pageBaseType">
              <xsl:value-of select="$Namespace"/>
              <xsl:text>.Web.PageBase</xsl:text>
            </xsl:attribute>
          </xsl:if>
          <controls>
            <xsl:if test="$TargetFramework='3.5'">
              <add tagPrefix="asp" namespace="System.Web.UI" assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" />
              <add tagPrefix="asp" namespace="System.Web.UI.WebControls" assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" />
            </xsl:if>
            <xsl:comment>Data Aquarium Framework and AjaxControlToolkit references</xsl:comment>
            <xsl:if test="$ScriptOnly='false'">
              <add tagPrefix="act" namespace="AjaxControlToolkit" assembly="AjaxControlToolkit"/>
              <add tagPrefix="act" namespace="AjaxControlToolkit.HTMLEditor" assembly="AjaxControlToolkit"/>
            </xsl:if>
            <add tagPrefix="aquarium" namespace="{$Namespace}.Web">
              <xsl:if test="$IsClassLibrary='true'">
                <xsl:attribute name="assembly">
                  <xsl:value-of select="$Namespace"/>
                </xsl:attribute>
              </xsl:if>
            </add>
            <xsl:if test="$TargetFramework='4.0'">
              <add tagPrefix="asp" namespace="System.Web.UI.DataVisualization.Charting" assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" />
            </xsl:if>
            <xsl:if test="$TargetFramework45Plus='true'">
              <add tagPrefix="asp" namespace="System.Web.UI.DataVisualization.Charting" assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" />
            </xsl:if>
          </controls>
        </pages>
        <httpHandlers>
          <xsl:if test="$TargetFramework='3.5'">
            <remove verb="*" path="*.asmx" />
            <add verb="*" path="*.asmx" validate="false" type="System.Web.Script.Services.ScriptHandlerFactory, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" />
            <add verb="*" path="*_AppService.axd" validate="false" type="System.Web.Script.Services.ScriptHandlerFactory, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" />
            <add verb="GET,HEAD" path="ScriptResource.axd" type="System.Web.Handlers.ScriptResourceHandler, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" validate="false" />
          </xsl:if>
          <add verb="*" path="*.xml" type="System.Web.HttpForbiddenHandler"/>
          <xsl:if test="$PageImplementation!='html'">
            <add verb="*" path="*.json" type="System.Web.HttpForbiddenHandler"/>
          </xsl:if>

          <xsl:if test="$ReportsEnabled='true'">
            <xsl:choose>
              <xsl:when test="$ReportsVersion='15'">
                <add path="Reserved.ReportViewerWebControl.axd" verb="*" type="Microsoft.Reporting.WebForms.HttpHandler, Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" validate="false" />
              </xsl:when>
              <xsl:when test="$ReportsVersion='14'">
                <add path="Reserved.ReportViewerWebControl.axd" verb="*" type="Microsoft.Reporting.WebForms.HttpHandler, Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" validate="false" />
              </xsl:when>
              <xsl:when test="$ReportsVersion='12'">
                <add path="Reserved.ReportViewerWebControl.axd" verb="*" type="Microsoft.Reporting.WebForms.HttpHandler, Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" validate="false" />
              </xsl:when>
              <xsl:when test="$ReportsVersion='11'">
                <add path="Reserved.ReportViewerWebControl.axd" verb="*" type="Microsoft.Reporting.WebForms.HttpHandler, Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" validate="false" />
              </xsl:when>
              <xsl:when test="$ReportsVersion='10'">
                <add path="Reserved.ReportViewerWebControl.axd" verb="*" type="Microsoft.Reporting.WebForms.HttpHandler, Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" validate="false" />
              </xsl:when>
              <xsl:otherwise>
                <add path="Reserved.ReportViewerWebControl.axd" verb="*" type="Microsoft.Reporting.WebForms.HttpHandler, Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" validate="false" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <!--<xsl:if test="$IsClassLibrary='true'">-->
          <xsl:comment>Data Aquarium Framework handlers</xsl:comment>
          <xsl:if test="$SupportAllFeatures='true'">
            <add verb="*" path="Blob.ashx" validate="false" type="{$Namespace}.Handlers.Blob"/>
          </xsl:if>
          <add verb="*" path="Theme.ashx" validate="false" type="{$Namespace}.Handlers.Theme"/>
          <add verb="*" path="Export.ashx" validate="false" type="{$Namespace}.Handlers.Export"/>
          <add verb="*" path="Import.ashx" validate="false" type="{$Namespace}.Handlers.Import"/>
          <xsl:if test="$ReportsEnabled='true'">
            <add verb="*" path="Report.ashx" validate="false" type="{$Namespace}.Handlers.Report"/>
          </xsl:if>
          <add verb="*" path="ControlHost.aspx" validate="false" type="{$Namespace}.Web.ControlHost"/>
          <xsl:if test="$UI != 'TouchUI'">
            <add verb="*" path="ChartHost.aspx" validate="false" type="{$Namespace}.Web.ChartHost"/>
            <xsl:if test="$TargetFramework='4.0' or $TargetFramework45Plus='true'">
              <add path="ChartImg.axd" verb="GET,HEAD,POST" type="System.Web.UI.DataVisualization.Charting.ChartHttpHandler, System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
               validate="false" />
            </xsl:if>
          </xsl:if>
        </httpHandlers>
        <xsl:if test="$ScriptOnly='true' and $IsUnlimited='true'">
          <httpRuntime maxUrlLength="10999" maxQueryStringLength="2097151" maxRequestLength="2097151" requestValidationMode="2.0" enableVersionHeader="false" />
        </xsl:if>
        <httpModules>
          <xsl:if test="$TargetFramework='3.5'">
            <add name="ScriptModule" type="System.Web.Handlers.ScriptModule, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" />
          </xsl:if>
          <xsl:if test="$AuthenticationType='Forms' or $AuthenticationType='Custom' or $AuthenticationType='AD'">
            <remove name="FormsAuthentication"/>
            <add name="ExportAuthentication" type="{$Namespace}.Security.ExportAuthenticationModule"/>
            <add name="FormsAuthenticationModule" type="System.Web.Security.FormsAuthenticationModule"/>
          </xsl:if>
        </httpModules>
        <webServices>
          <protocols>
            <remove name="Documentation"/>
          </protocols>
        </webServices>
        <xsl:if test="$TargetFramework!='3.5' and $TargetFramework!='4.0' and $Host=''and $ScriptOnly='true' and $ReportsEnabled='true' and $IsClassLibrary != 'true'">
          <trust level="Full">
            <xsl:attribute name="legacyCasModel">true</xsl:attribute>
            <xsl:if test="$ReportsVersion='15' or $ReportsVersion='14'">
              <xsl:attribute name="originUrl">.*</xsl:attribute>
            </xsl:if>
          </trust>
        </xsl:if>
			<xsl:if test="$TargetFramework45Plus = 'true'">
					<httpCookies sameSite="Strict"/>
			</xsl:if>
      </system.web>
      <xsl:if test="(/a:project/a:features/a:smtp/@deliveryMethod='Network' and /a:project/a:features/a:smtp/@host!='')">
        <system.net>
          <mailSettings>
            <smtp deliveryMethod="Network">
              <xsl:if test="/a:project/a:features/a:smtp/@deliveryFormat!=''">
                <xsl:attribute name="deliveryFormat">
                  <xsl:value-of select="/a:project/a:features/a:smtp/@deliveryFormat"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:if test="/a:project/a:features/a:smtp/@from!=''">
                <xsl:attribute name="from">
                  <xsl:value-of select="/a:project/a:features/a:smtp/@from"/>
                </xsl:attribute>
              </xsl:if>
              <network>
                <xsl:if test="/a:project/a:features/a:smtp/@clientDomain!=''">
                  <xsl:attribute name="clientDomain">
                    <xsl:value-of select="/a:project/a:features/a:smtp/@clientDomain"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:features/a:smtp/@defaultCredentials='true'">
                  <xsl:attribute name="defaultCredentials">
                    <xsl:value-of select="'true'"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:features/a:smtp/@enableSsl='true'">
                  <xsl:attribute name="enableSsl">
                    <xsl:value-of select="'true'"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:attribute name="host">
                  <xsl:value-of select="/a:project/a:features/a:smtp/@host"/>
                </xsl:attribute>
                <xsl:if test="/a:project/a:features/a:smtp/@password!=''">
                  <xsl:attribute name="password">
                    <xsl:value-of select="/a:project/a:features/a:smtp/@password"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:features/a:smtp/@port!=''">
                  <xsl:attribute name="port">
                    <xsl:value-of select="/a:project/a:features/a:smtp/@port"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:features/a:smtp/@targetName!=''">
                  <xsl:attribute name="targetName">
                    <xsl:value-of select="/a:project/a:features/a:smtp/@targetName"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="/a:project/a:features/a:smtp/@username!=''">
                  <xsl:attribute name="userName">
                    <xsl:value-of select="/a:project/a:features/a:smtp/@username"/>
                  </xsl:attribute>
                </xsl:if>
              </network>
            </smtp>
          </mailSettings>
        </system.net>
      </xsl:if>
      <xsl:if test="(/a:project/a:features/a:smtp/@deliveryMethod='SpecifiedPickupDirectory' and /a:project/a:features/a:smtp/@pickupDirectoryLocation!='')">
        <system.net>
          <mailSettings>
            <smtp deliveryMethod='SpecifiedPickupDirectory'>
              <xsl:if test="/a:project/a:features/a:smtp/@deliveryFormat!=''">
                <xsl:attribute name="deliveryFormat">
                  <xsl:value-of select="/a:project/a:features/a:smtp/@deliveryFormat"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:if test="/a:project/a:features/a:smtp/@from!=''">
                <xsl:attribute name="from">
                  <xsl:value-of select="/a:project/a:features/a:smtp/@from"/>
                </xsl:attribute>
              </xsl:if>
              <specifiedPickupDirectory pickupDirectoryLocation="{/a:project/a:features/a:smtp/@pickupDirectoryLocation}" />
            </smtp>
          </mailSettings>
        </system.net>
      </xsl:if>
      <xsl:if test="(/a:project/a:features/a:smtp/@deliveryMethod='PickupDirectoryFromIis')">
        <system.net>
          <mailSettings>
            <smtp deliveryMethod="PickupDirectoryFromIis">
              <xsl:if test="/a:project/a:features/a:smtp/@deliveryFormat!=''">
                <xsl:attribute name="deliveryFormat">
                  <xsl:value-of select="/a:project/a:features/a:smtp/@deliveryFormat"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:if test="/a:project/a:features/a:smtp/@from!=''">
                <xsl:attribute name="from">
                  <xsl:value-of select="/a:project/a:features/a:smtp/@from"/>
                </xsl:attribute>
              </xsl:if>
            </smtp>
          </mailSettings>
        </system.net>
      </xsl:if>
      <xsl:if test="$TargetFramework='3.5'">
        <system.codedom>
          <compilers>
            <compiler language="c#;cs;csharp" extension=".cs" warningLevel="4" type="Microsoft.CSharp.CSharpCodeProvider, System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089">
              <providerOption name="CompilerVersion" value="v3.5" />
              <providerOption name="WarnAsError" value="false" />
            </compiler>
            <compiler language="vb;vbs;visualbasic;vbscript" extension=".vb" warningLevel="4" type="Microsoft.VisualBasic.VBCodeProvider, System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089">
              <providerOption name="CompilerVersion" value="v3.5" />
              <providerOption name="OptionInfer" value="true" />
              <providerOption name="WarnAsError" value="false" />
            </compiler>
          </compilers>
        </system.codedom>
      </xsl:if>
      <xsl:comment xml:space="preserve">
        <![CDATA[The system.webServer section is required for running ASP.NET AJAX under Internet
        Information Services 7.x.  It is not necessary for previous version of IIS.]]>
      </xsl:comment>
      <system.webServer>
        <xsl:if test="$ScriptOnly='true' and $IsUnlimited='true'">
          <security>
            <requestFiltering removeServerHeader="true">
              <requestLimits maxUrl="10999" maxQueryString="9999" />
            </requestFiltering>
          </security>
        </xsl:if>
        <validation validateIntegratedModeConfiguration="false" />
        <xsl:if test="$TargetFramework!='3.5'">
          <modules runAllManagedModulesForAllRequests="true">
            <xsl:if test="$AuthenticationType='Forms' or $AuthenticationType='Custom' or $AuthenticationType='AD'">
              <remove name="FormsAuthentication"/>
              <add name="ExportAuthentication" type="{$Namespace}.Security.ExportAuthenticationModule"/>
              <add name="FormsAuthenticationModule" type="System.Web.Security.FormsAuthenticationModule"/>
            </xsl:if>
          </modules>
          <handlers>
            <add name="All_XML" verb="*" path="*.xml" type="System.Web.HttpForbiddenHandler" resourceType="Unspecified"/>
            <xsl:if test="$PageImplementation!='html'">
              <add name="All_JSON" verb="*" path="*.json" type="System.Web.HttpForbiddenHandler" resourceType="Unspecified"/>
            </xsl:if>
            <xsl:if test="$ReportsEnabled='true'">
              <xsl:choose>
                <xsl:when test="$ReportsVersion='15'">
                  <add name="Reserved_ReportViewerWebControl_axd" path="Reserved.ReportViewerWebControl.axd" verb="*" type="Microsoft.Reporting.WebForms.HttpHandler, Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" resourceType="Unspecified"/>
                </xsl:when>
                <xsl:when test="$ReportsVersion='14'">
                  <add name="Reserved_ReportViewerWebControl_axd" path="Reserved.ReportViewerWebControl.axd" verb="*" type="Microsoft.Reporting.WebForms.HttpHandler, Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" resourceType="Unspecified"/>
                </xsl:when>
                <xsl:when test="$ReportsVersion='12'">
                  <add name="Reserved_ReportViewerWebControl_axd" path="Reserved.ReportViewerWebControl.axd" verb="*" type="Microsoft.Reporting.WebForms.HttpHandler, Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" resourceType="Unspecified"/>
                </xsl:when>
                <xsl:when test="$ReportsVersion='11'">
                  <add name="Reserved_ReportViewerWebControl_axd" path="Reserved.ReportViewerWebControl.axd" verb="*" type="Microsoft.Reporting.WebForms.HttpHandler, Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" resourceType="Unspecified"/>
                </xsl:when>
                <xsl:when test="$ReportsVersion='10'">
                  <add name="Reserved_ReportViewerWebControl_axd" path="Reserved.ReportViewerWebControl.axd" verb="*" type="Microsoft.Reporting.WebForms.HttpHandler, Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" resourceType="Unspecified"/>
                </xsl:when>
              </xsl:choose>
            </xsl:if>
            <!--<xsl:if test="$IsClassLibrary='true'">-->
            <xsl:comment>Data Aquarium Framework handlers</xsl:comment>
            <xsl:if test="$SupportAllFeatures='true'">
              <add name="Blob_ashx" verb="*" path="Blob.ashx" type="{$Namespace}.Handlers.Blob" resourceType="Unspecified"/>
            </xsl:if>
            <add name="Theme_ashx" verb="*" path="Theme.ashx" type="{$Namespace}.Handlers.Theme" resourceType="Unspecified"/>
            <add name="Export_ashx" verb="*" path="Export.ashx" type="{$Namespace}.Handlers.Export" resourceType="Unspecified"/>
            <add name="Import_ashx" verb="*" path="Import.ashx" type="{$Namespace}.Handlers.Import" resourceType="Unspecified"/>
            <!--<xsl:if test="$SupportAllFeatures='true'">
                <add name="Details_aspx" verb="*" path="Details.aspx" type="{$Namespace}.Handlers.Details" resourceType="Unspecified"/>
              </xsl:if>-->
            <xsl:if test="$ReportsEnabled='true'">
              <add name="Report_ashx" verb="*" path="Report.ashx" type="{$Namespace}.Handlers.Report" resourceType="Unspecified"/>
            </xsl:if>
            <add name="ControlHost_ashx" verb="*" path="ControlHost.aspx" type="{$Namespace}.Web.ControlHost" resourceType="Unspecified"/>
            <xsl:if test="$TargetFramework!='3.5' and $UI != 'TouchUI'">
              <add name="ChartHost_ashx" verb="*" path="ChartHost.aspx" type="{$Namespace}.Web.ChartHost" resourceType="Unspecified"/>
            </xsl:if>
            <!--</xsl:if>-->
            <xsl:if test="$TargetFramework='4.0' and $UI != 'TouchUI'">
              <remove name="ChartImageHandler" />
              <add name="ChartImageHandler" preCondition="integratedMode" verb="GET,HEAD,POST" path="ChartImg.axd" type="System.Web.UI.DataVisualization.Charting.ChartHttpHandler, System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"/>
            </xsl:if>
            <xsl:if test="$TargetFramework45Plus='true' and $UI != 'TouchUI'">
              <remove name="ChartImageHandler" />
              <add name="ChartImageHandler" preCondition="integratedMode" verb="GET,HEAD,POST" path="ChartImg.axd" type="System.Web.UI.DataVisualization.Charting.ChartHttpHandler, System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"/>
            </xsl:if>
          </handlers>
        </xsl:if>
        <xsl:if test="$TargetFramework='3.5'">
          <modules>
            <remove name="ScriptModule" />
            <add name="ScriptModule" preCondition="managedHandler" type="System.Web.Handlers.ScriptModule, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" />
          </modules>
          <handlers>
            <remove name="WebServiceHandlerFactory-Integrated" />
            <remove name="ScriptHandlerFactory" />
            <remove name="ScriptHandlerFactoryAppServices" />
            <remove name="ScriptResource" />
            <add name="ScriptHandlerFactory" verb="*" path="*.asmx" preCondition="integratedMode" type="System.Web.Script.Services.ScriptHandlerFactory, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" />
            <add name="ScriptHandlerFactoryAppServices" verb="*" path="*_AppService.axd" preCondition="integratedMode" type="System.Web.Script.Services.ScriptHandlerFactory, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" />
            <add name="ScriptResource" preCondition="integratedMode" verb="GET,HEAD" path="ScriptResource.axd" type="System.Web.Handlers.ScriptResourceHandler, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" />
            <xsl:if test="$IsClassLibrary='true'">
              <xsl:comment>Data Aquarium Framework handlers</xsl:comment>
              <xsl:if test="$SupportAllFeatures='true'">
                <add name="Blob_ashx" verb="*" path="Blob.ashx" type="{$Namespace}.Handlers.Blob" resourceType="Unspecified"/>
              </xsl:if>
              <add name="Theme_ashx" verb="*" path="Theme.ashx" type="{$Namespace}.Handlers.Theme" resourceType="Unspecified"/>
              <add name="Export_ashx" verb="*" path="Export.ashx" type="{$Namespace}.Handlers.Export" resourceType="Unspecified"/>
              <add name="Import_ashx" verb="*" path="Import.ashx" type="{$Namespace}.Handlers.Import" resourceType="Unspecified"/>
              <!--<xsl:if test="$SupportAllFeatures='true'">
                <add name="Details_aspx" verb="*" path="Details.aspx" type="{$Namespace}.Handlers.Details" resourceType="Unspecified"/>
              </xsl:if>-->
              <xsl:if test="$ReportsEnabled='true'">
                <add name="Report_ashx" verb="*" path="Report.ashx" type="{$Namespace}.Handlers.Report" resourceType="Unspecified"/>
              </xsl:if>
              <add name="ControlHost_ashx" verb="*" path="ControlHost.aspx" type="{$Namespace}.Web.ControlHost" resourceType="Unspecified"/>
            </xsl:if>
          </handlers>
        </xsl:if>
        <staticContent>
          <remove fileExtension=".woff" />
          <mimeMap fileExtension=".woff" mimeType="application/font-woff" />
          <remove fileExtension=".woff2" />
          <mimeMap fileExtension=".woff2" mimeType="font/woff2" />
        </staticContent>
				<httpProtocol>
					<customHeaders>
						<remove name="X-Powered-By" />
						<remove name="Server" />
					</customHeaders>
				</httpProtocol>
			</system.webServer>
      <system.web.extensions>
        <scripting>
          <webServices>
            <!--<xsl:if test="$MembershipEnabled='true' or $AuthenticationType='Custom' or $AuthenticationType='AD'">
              <authenticationService enabled="true"/>
            </xsl:if>-->
            <jsonSerialization maxJsonLength="524288" />
          </webServices>
        </scripting>
      </system.web.extensions>
      <xsl:if test="$TargetFramework='3.5'">
        <runtime>
          <assemblyBinding xmlns="urn:schemas-microsoft-com:asm.v1">
            <dependentAssembly>
              <assemblyIdentity name="System.Web.Extensions" publicKeyToken="31bf3856ad364e35" />
              <bindingRedirect oldVersion="1.0.0.0-1.1.0.0" newVersion="3.5.0.0" />
            </dependentAssembly>
            <dependentAssembly>
              <assemblyIdentity name="System.Web.Extensions.Design" publicKeyToken="31bf3856ad364e35" />
              <bindingRedirect oldVersion="1.0.0.0-1.1.0.0" newVersion="3.5.0.0" />
            </dependentAssembly>
          </assemblyBinding>
        </runtime>
      </xsl:if>
      <xsl:if test="$SupportAllFeatures='true' and $PageImplementation!='html'">
        <xsl:choose>
          <xsl:when test="$ApplicationPath=''">
            <location path="Membership.aspx">
              <system.web>
                <authorization>
                  <allow roles="Administrators" />
                  <deny users="*"/>
                </authorization>
              </system.web>
            </location>
          </xsl:when>
          <xsl:when test="$MembershipEnabled='true' or $AuthenticationType='Custom' or $AuthenticationType='Windows' or $AuthenticationType='AD'">
            <location path="Pages">
              <system.web>
                <authorization>
                  <deny users="?"/>
                </authorization>
              </system.web>
            </location>
            <location path="Views">
              <system.web>
                <authorization>
                  <deny users="*"/>
                </authorization>
              </system.web>
            </location>
            <xsl:if test="not(/a:project/a:membership[@dedicatedLogin='true'])">
              <location path="Pages/Home.aspx">
                <system.web>
                  <authorization>
                    <allow users="?"/>
                  </authorization>
                </system.web>
              </location>
            </xsl:if>
            <xsl:if test="/a:project/a:host/@path=''">
              <xsl:variable name="Application" select="document($ApplicationPath)"/>
              <xsl:for-each select="$Application//app:pages/app:page[@roles!='' and not(@url!='') and @roles!='*']">
                <location path="Pages/{@name}.aspx">
                  <system.web>
                    <authorization>
                      <xsl:choose>
                        <xsl:when test="@roles='?'">
                          <allow users="?"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <allow roles="{@roles}"/>
                          <deny users="*"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </authorization>
                  </system.web>
                </location>
              </xsl:for-each>
            </xsl:if>
          </xsl:when>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$Host='DotNetNuke'">
        <location path="start.aspx">
          <system.web>
            <authorization>
              <deny users="?"/>
            </authorization>
          </system.web>
        </location>
      </xsl:if>
    </configuration>
  </xsl:template>
</xsl:stylesheet>
