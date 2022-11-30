<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
		xmlns="http://schemas.microsoft.com/developer/msbuild/2003"
    xmlns:ontime="urn:schemas-codeontime-com:xslt"
	  exclude-result-prefixes="msxsl ontime"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="ProjectGuid"/>
	<xsl:param name="ProjectName"/>
	<xsl:param name="ProjectExtension"/>
	<xsl:param name="CodedomProviderName"/>
	<xsl:param name="Reference1"/>
	<xsl:param name="Reference1Guid"/>
	<xsl:param name="ReportsEnabled" select="'false'"/>
	<xsl:param name="ReportsVersion"/>
	<xsl:param name="TargetFramework"/>
	<xsl:param name="IsClassLibrary" select="'false'"/>
	<xsl:param name="IsPremium"/>
	<xsl:param name="MembershipProviderName"/>
	<xsl:param name="VisualStudio2012"/>
	<xsl:param name="VisualStudio2013"/>
	<xsl:param name="VisualStudio2015"/>
	<xsl:param name="VisualStudio2017"/>
	<xsl:param name="VisualStudio2019"/>
	<xsl:param name="VisualStudio2022"/>
	<xsl:param name="ScriptOnly" select="'false'"/>
	<xsl:param name="ActiveDirectory" select="'false'"/>
	<xsl:param name="WebServerPort"/>
	<xsl:param name="AppFolder"/>
	<msxsl:script language="CSharp" implements-prefix="ontime">
		<![CDATA[
        public string Guid()
        {
					return System.Guid.NewGuid().ToString().ToUpper();
        }
        public bool EndsWith(string s, string ending){
          return s.EndsWith(ending);
        }
        public string TrimExtension(string s){
          return s.Substring(0, s.LastIndexOf("."));
        }
		]]>
	</msxsl:script>


	<xsl:template match="fileSystem">
		<Project>
			<xsl:attribute name="ToolsVersion">
				<xsl:choose>
					<xsl:when test="$TargetFramework = '3.5'">
						<xsl:text>3.5</xsl:text>
					</xsl:when>
					<xsl:when test="$VisualStudio2022!=''">
						<xsl:text>17.0</xsl:text>
					</xsl:when>
					<xsl:when test="$VisualStudio2019!=''">
						<xsl:text>16.0</xsl:text>
					</xsl:when>
					<xsl:when test="$VisualStudio2017!=''">
						<xsl:text>15.0</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>4.0</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="DefaultTargets">
				<xsl:text>Build</xsl:text>
			</xsl:attribute>
			<xsl:if test="$VisualStudio2012!='' or $VisualStudio2013!='' or $VisualStudio2015!='' or $VisualStudio2017!='' or $VisualStudio2019!='' or $VisualStudio2022!=''">
				<Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')" />
			</xsl:if>
			<PropertyGroup>
				<Configuration Condition=" '$(Configuration)' == '' ">Debug</Configuration>
				<Platform Condition=" '$(Platform)' == '' ">AnyCPU</Platform>
				<ProductVersion>9.0.30729</ProductVersion>
				<SchemaVersion>2.0</SchemaVersion>
				<ProjectGuid>
					<xsl:choose>
						<xsl:when test="$ProjectGuid!=''">
							<xsl:value-of select="$ProjectGuid"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat('{', ontime:Guid(), '}')"/>
						</xsl:otherwise>
					</xsl:choose>
				</ProjectGuid>
				<xsl:if test="$Reference1">
					<xsl:choose>
						<xsl:when test="$CodedomProviderName='CSharp'">
							<ProjectTypeGuids>{349c5851-65df-11da-9384-00065b846f21};{fae04ec0-301f-11d3-bf4b-00c04f79efbc}</ProjectTypeGuids>
						</xsl:when>
						<xsl:otherwise>
							<ProjectTypeGuids>{349c5851-65df-11da-9384-00065b846f21};{F184B08F-C81C-45F6-A57F-5ABD9991F28F}</ProjectTypeGuids>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<OutputType>Library</OutputType>
				<xsl:if test="$CodedomProviderName='CSharp'">
					<AppDesignerFolder>Properties</AppDesignerFolder>
				</xsl:if>
				<RootNamespace>
					<xsl:value-of select="$ProjectName"/>
				</RootNamespace>
				<AssemblyName>
					<xsl:value-of select="$ProjectName"/>
				</AssemblyName>
				<TargetFrameworkVersion>
					<xsl:text>v</xsl:text>
					<xsl:value-of select="$TargetFramework"/>
				</TargetFrameworkVersion>
				<FileAlignment>512</FileAlignment>
				<xsl:if test="$CodedomProviderName='VisualBasic'">
					<OptionExplicit>On</OptionExplicit>
					<OptionCompare>Binary</OptionCompare>
					<OptionStrict>Off</OptionStrict>
					<OptionInfer>On</OptionInfer>
				</xsl:if>
				<xsl:if test="file[@extension='.vspscc']">
					<SccProjectName>SAK</SccProjectName>
					<SccLocalPath>SAK</SccLocalPath>
					<SccAuxPath>SAK</SccAuxPath>
					<SccProvider>SAK</SccProvider>
				</xsl:if>
				<xsl:if test="$VisualStudio2022!='' or $VisualStudio2019!='' or $VisualStudio2017!='' or $VisualStudio2015!=''">
					<UseIISExpress>true</UseIISExpress>
					<IISExpressSSLPort />
					<IISExpressAnonymousAuthentication />
					<IISExpressWindowsAuthentication />
					<IISExpressUseClassicPipelineMode />
					<UseGlobalApplicationHostFile />
				</xsl:if>
			</PropertyGroup>
			<xsl:choose>
				<xsl:when test="$CodedomProviderName='VisualBasic'">
					<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' ">
						<DebugSymbols>true</DebugSymbols>
						<DebugType>full</DebugType>
						<DefineDebug>true</DefineDebug>
						<DefineTrace>true</DefineTrace>
						<OutputPath>
							<xsl:choose>
								<xsl:when test="$Reference1">
									<xsl:text>bin\</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>bin\Debug</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</OutputPath>
						<NoWarn>42016,41999,42017,42018,42019,42032,42036,42020,42021,42022</NoWarn>
					</PropertyGroup>
					<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' ">
						<DebugType>pdbonly</DebugType>
						<DefineDebug>false</DefineDebug>
						<DefineTrace>true</DefineTrace>
						<Optimize>true</Optimize>
						<OutputPath>
							<xsl:choose>
								<xsl:when test="$Reference1">
									<xsl:text>bin\</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>bin\release</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</OutputPath>
						<NoWarn>42016,41999,42017,42018,42019,42032,42036,42020,42021,42022</NoWarn>
					</PropertyGroup>
					<ItemGroup>
						<Import Include="Microsoft.VisualBasic" />
						<Import Include="System" />
						<Import Include="System.Collections" />
						<Import Include="System.Collections.Generic" />
						<Import Include="System.Diagnostics" />
						<Import Include="System.Web" />
						<Import Include="System.Web.UI" />
						<Import Include="System.Web.UI.WebControls" />
						<Import Include="System.Web.UI.WebControls.WebParts" />
						<Import Include="System.Web.UI.HtmlControls" />
						<Import Include="System.Linq" />
						<Import Include="System.Xml.Linq" />
					</ItemGroup>
				</xsl:when>
				<xsl:otherwise>
					<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' ">
						<DebugSymbols>true</DebugSymbols>
						<DebugType>full</DebugType>
						<Optimize>false</Optimize>
						<OutputPath>
							<xsl:choose>
								<xsl:when test="$Reference1">
									<xsl:text>bin\</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>bin\Debug</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</OutputPath>
						<DefineConstants>DEBUG;TRACE</DefineConstants>
						<ErrorReport>prompt</ErrorReport>
						<WarningLevel>4</WarningLevel>
					</PropertyGroup>
					<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' ">
						<DebugType>pdbonly</DebugType>
						<Optimize>true</Optimize>
						<OutputPath>
							<xsl:choose>
								<xsl:when test="$Reference1">
									<xsl:text>bin\</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>bin\Debug</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</OutputPath>
						<DefineConstants>TRACE</DefineConstants>
						<ErrorReport>prompt</ErrorReport>
						<WarningLevel>4</WarningLevel>
					</PropertyGroup>
				</xsl:otherwise>
			</xsl:choose>
			<ItemGroup>
				<!--<Reference Include="AjaxControlToolkit, Version=3.0.30930.28736, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e, processorArchitecture=MSIL">
          <SpecificVersion>False</SpecificVersion>
          <HintPath>..\AjaxControlToolkit\AjaxControlToolkit.dll</HintPath>
        </Reference>-->
				<xsl:if test="$ScriptOnly='false'">
					<Reference Include="AjaxControlToolkit">
						<HintPath>..\AjaxControlToolkit\AjaxControlToolkit.dll</HintPath>
					</Reference>
				</xsl:if>
				<xsl:if test="contains($MembershipProviderName,'SQLAnywhere')">
					<Reference Include="iAnywhere.Web.Security, Version=12.0.1.3152, Culture=neutral, processorArchitecture=MSIL">
						<SpecificVersion>False</SpecificVersion>
					</Reference>
				</xsl:if>
				<xsl:if test="$ActiveDirectory='true'">
					<Reference Include="System.DirectoryServices"/>
					<Reference Include="System.DirectoryServices.AccountManagement"/>
				</xsl:if>
				<xsl:if test="$ReportsEnabled='true'">
					<xsl:variable name="ReportBinaryPath">
						<xsl:choose>
							<xsl:when test="$IsClassLibrary='true'">
								<xsl:text>..\</xsl:text>
								<xsl:value-of select="$AppFolder"/>
								<xsl:text>\bin\</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>.\bin\</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:choose xml:space="preserve">
						<xsl:when test="$ReportsVersion='15'">
							<Reference Include="Microsoft.ReportViewer.Common, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
								<Private>True</Private>
								<HintPath><xsl:value-of select="$ReportBinaryPath"/>Microsoft.ReportViewer.Common.dll</HintPath>
							</Reference>
							<Reference Include="Microsoft.ReportViewer.ProcessingObjectModel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
								<Private>True</Private>
								<HintPath><xsl:value-of select="$ReportBinaryPath"/>Microsoft.ReportViewer.ProcessingObjectModel.dll</HintPath>
							</Reference>
							<Reference Include="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
								<Private>True</Private>
								<HintPath><xsl:value-of select="$ReportBinaryPath"/>Microsoft.ReportViewer.WebForms.dll</HintPath>
							</Reference>
							<Reference Include="Microsoft.SqlServer.Types, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91, processorArchitecture=MSIL">
								<Private>True</Private>
								<HintPath><xsl:value-of select="$ReportBinaryPath"/>Microsoft.SqlServer.Types.dll</HintPath>
							</Reference>
						</xsl:when>
						<xsl:when test="$ReportsVersion='14'">
							<Reference Include="Microsoft.ReportViewer.Common, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
								<xsl:if test="$ProjectName='WebApp'">
									<Private>True</Private>
								</xsl:if>
								<HintPath><xsl:value-of select="$ReportBinaryPath"/>Microsoft.ReportViewer.Common.dll</HintPath>
							</Reference>
							<Reference Include="Microsoft.ReportViewer.ProcessingObjectModel, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
								<Private>True</Private>
								<HintPath><xsl:value-of select="$ReportBinaryPath"/>Microsoft.ReportViewer.ProcessingObjectModel.dll</HintPath>
							</Reference>
							<Reference Include="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
								<Private>True</Private>
								<HintPath><xsl:value-of select="$ReportBinaryPath"/>Microsoft.ReportViewer.WebForms.dll</HintPath>
							</Reference>
							<Reference Include="Microsoft.SqlServer.Types, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91, processorArchitecture=MSIL">
								<Private>True</Private>
								<HintPath><xsl:value-of select="$ReportBinaryPath"/>Microsoft.SqlServer.Types.dll</HintPath>
							</Reference>
						</xsl:when>
						<xsl:when test="$ReportsVersion='12'">
							<Reference Include="Microsoft.ReportViewer.Common, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
								<xsl:if test="$ProjectName='WebApp'">
									<Private>True</Private>
								</xsl:if>
							</Reference>
							<xsl:if test="$ProjectName='WebApp'">
								<Reference Include="Microsoft.ReportViewer.DataVisualization, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
									<Private>True</Private>
								</Reference>
								<Reference Include="Microsoft.ReportViewer.ProcessingObjectModel, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
									<Private>True</Private>
								</Reference>
							</xsl:if>
							<Reference Include="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
								<Private>True</Private>
							</Reference>
							<Reference Include="Microsoft.SqlServer.Types, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91, processorArchitecture=MSIL">
								<Private>True</Private>
							</Reference>
						</xsl:when>
						<xsl:when test="$ReportsVersion='11'">
							<Reference Include="Microsoft.ReportViewer.Common, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
								<xsl:if test="$ProjectName='WebApp'">
									<Private>True</Private>
								</xsl:if>
							</Reference>
							<xsl:if test="$ProjectName='WebApp'">
								<Reference Include="Microsoft.ReportViewer.DataVisualization, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
									<Private>True</Private>
								</Reference>
								<Reference Include="Microsoft.ReportViewer.ProcessingObjectModel, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
									<Private>True</Private>
								</Reference>
							</xsl:if>
							<Reference Include="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91, processorArchitecture=MSIL">
								<Private>True</Private>
							</Reference>
							<Reference Include="Microsoft.SqlServer.Types, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91, processorArchitecture=MSIL">
								<Private>True</Private>
							</Reference>
						</xsl:when>
						<xsl:otherwise>
							<Reference Include="Microsoft.ReportViewer.Common, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a, processorArchitecture=MSIL">
								<xsl:if test="$ProjectName='WebRole1'">
									<Private>True</Private>
								</xsl:if>
							</Reference>
							<xsl:if test="$ProjectName='WebApp'">
								<Reference Include="Microsoft.ReportViewer.DataVisualization, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a, processorArchitecture=MSIL">
									<Private>True</Private>
								</Reference>
								<Reference Include="Microsoft.ReportViewer.ProcessingObjectModel, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a, processorArchitecture=MSIL">
									<Private>True</Private>
								</Reference>
							</xsl:if>
							<Reference Include="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a, processorArchitecture=MSIL">
								<xsl:if test="$ProjectName='WebApp'">
									<Private>True</Private>
								</xsl:if>
							</Reference>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$TargetFramework='3.5'">
						<Reference Include="System" />
						<Reference Include="System.configuration" />
						<Reference Include="System.Core">
							<RequiredTargetFramework>3.5</RequiredTargetFramework>
						</Reference>
						<Reference Include="System.Data" />
						<Reference Include="System.Data.DataSetExtensions">
							<RequiredTargetFramework>3.5</RequiredTargetFramework>
						</Reference>
						<Reference Include="System.Design" />
						<Reference Include="System.Web.Extensions">
							<RequiredTargetFramework>3.5</RequiredTargetFramework>
						</Reference>
						<Reference Include="System.Transactions" />
						<Reference Include="System.Web.Services" />
						<Reference Include="System.XML" />
						<Reference Include="System.Xml.Linq">
							<RequiredTargetFramework>3.5</RequiredTargetFramework>
						</Reference>
						<Reference Include="System.Drawing" />
						<Reference Include="System.Web" />
					</xsl:when>
					<xsl:otherwise>
						<Reference Include="System" />
						<Reference Include="System.configuration" />
						<Reference Include="System.Core" />
						<Reference Include="System.Data" />
						<Reference Include="System.Data.DataSetExtensions" />
						<Reference Include="System.Design" />
						<Reference Include="System.Web.ApplicationServices" />
						<Reference Include="System.Web.Extensions" />
						<Reference Include="System.Transactions" />
						<Reference Include="System.Web.Services" />
						<Reference Include="System.XML" />
						<Reference Include="System.Xml.Linq" />
						<Reference Include="System.Drawing" />
						<Reference Include="System.Web" />
						<Reference Include="System.Web.DataVisualization" />
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="$IsClassLibrary='true'">
					<Reference Include="Newtonsoft.Json">
						<HintPath>bin\Newtonsoft.Json.dll</HintPath>
					</Reference>
					<Reference Include="YamlDotNet">
						<HintPath>bin\YamlDotNet.dll</HintPath>
					</Reference>
				</xsl:if>
			</ItemGroup>
			<xsl:if test="$Reference1">
				<ItemGroup>
					<ProjectReference Include="..\{$Reference1}\{$Reference1}.{$ProjectExtension}">
						<Project>
							<xsl:value-of select="$Reference1Guid"/>
						</Project>
						<Name>
							<xsl:value-of select="$Reference1"/>
						</Name>
					</ProjectReference>
				</ItemGroup>
			</xsl:if>
			<xsl:if test="$IsClassLibrary!='true'">
				<xsl:variable name="ContentFiles" select="//file[(contains(@name, '.asmx') or contains(@name, '.aspx') or contains(@name, '.config') or contains(@name, '.json') or contains(@name, '.asax') or contains(@name, '.master') or contains(@name, '.ascx') or contains(@name, '.txt') or contains(@name, '.html') or starts-with(@path, 'images\') or starts-with(@path, 'fonts\') or starts-with(@path, 'css\') or starts-with(@path, 'js\')) and not(starts-with(@path, 'bin\') or starts-with(@path,'obj\'))]"/>
				<xsl:if test="$ContentFiles">
					<ItemGroup>
						<xsl:for-each select="$ContentFiles[not(ontime:EndsWith(@name, '.vb') or ontime:EndsWith(@name, '.cs'))]">
							<xsl:choose>
								<xsl:when test="@extension = '.config' and $TargetFramework != '3.5'">
									<xsl:choose>
										<xsl:when test="@loweredName = 'web.config'">
											<Content Include="web.config" />
										</xsl:when>
										<xsl:when test="contains(@loweredName, '.debug.')">
											<None Include="{@name}">
												<DependentUpon>web.config</DependentUpon>
											</None>
										</xsl:when>
										<xsl:when test="contains(@loweredName, '.release.')">
											<None Include="{@name}">
												<DependentUpon>web.config</DependentUpon>
											</None>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<Content Include="{@path}">
										<!--<xsl:if test="@extension = '.txt'">
                      <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
                    </xsl:if>-->
									</Content>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</ItemGroup>
					<ItemGroup>
						<xsl:for-each select="$ContentFiles[ontime:EndsWith(@name, '.vb') or ontime:EndsWith(@name, '.cs')]">
							<xsl:variable name="DependentUpon" select="ontime:TrimExtension(@name)"/>
							<Compile Include="{@path}">
								<DependentUpon>
									<xsl:choose>
										<xsl:when test="ontime:EndsWith($DependentUpon, '.designer')">
											<xsl:value-of select="ontime:TrimExtension($DependentUpon)"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$DependentUpon"/>
										</xsl:otherwise>
									</xsl:choose>
								</DependentUpon>
								<SubType>ASPXCodebehind</SubType>
							</Compile>
						</xsl:for-each>
					</ItemGroup>
				</xsl:if>
			</xsl:if>
			<xsl:variable name="CustomFiles" select="folder[@name='custom']//file"/>
			<xsl:if test="$CustomFiles">
				<ItemGroup>
					<xsl:for-each select="$CustomFiles">
						<Compile Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="DataFiles" select="folder[@name='Data']//file"/>
			<xsl:if test="$DataFiles">
				<ItemGroup>
					<xsl:for-each select="$DataFiles">
						<Compile Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="RulesFiles" select="folder[@name='Rules']//file"/>
			<xsl:if test="$RulesFiles">
				<ItemGroup>
					<xsl:for-each select="$RulesFiles">
						<Compile Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="ModelFiles" select="folder[@name='Models']//file"/>
			<xsl:if test="$ModelFiles">
				<ItemGroup>
					<xsl:for-each select="$ModelFiles">
						<Compile Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="WebFiles" select="folder[@name='Web']/file"/>
			<xsl:if test="$WebFiles">
				<ItemGroup>
					<xsl:for-each select="$WebFiles">
						<Compile Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="SecurityFiles" select="folder[@name='Security']/file"/>
			<xsl:if test="$SecurityFiles">
				<ItemGroup>
					<xsl:for-each select="$SecurityFiles">
						<Compile Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="ServicesFiles" select="folder[@name='Services']/file"/>
			<xsl:if test="$ServicesFiles">
				<ItemGroup>
					<xsl:for-each select="$ServicesFiles">
						<Compile Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="AssemblyInfoFiles" select="//file[contains(@name, 'AssemblyInfo') and not(contains(@name,'codedom.xml'))]"/>
			<xsl:if test="$AssemblyInfoFiles">
				<ItemGroup>
					<xsl:for-each select="$AssemblyInfoFiles">
						<Compile Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="XsdFiles" select="//file[contains(@name, '.xsd')]"/>
			<xsl:variable name="ControllerFiles" select="folder[@loweredName='controllers']/file[not(contains(@name, '.xsd'))]"/>
			<xsl:if test="$XsdFiles or $ControllerFiles">
				<ItemGroup>
					<xsl:for-each select="$XsdFiles">
						<None Include="{@path}" />
					</xsl:for-each>
					<xsl:for-each select="$ControllerFiles">
						<EmbeddedResource Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="HandlersFiles" select="folder[@name='Handlers']/file"/>
			<xsl:if test="$HandlersFiles">
				<ItemGroup>
					<xsl:for-each select="$HandlersFiles">
						<Compile Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:if test="$IsClassLibrary='true'">
				<xsl:variable name="ScriptsFiles" select="folder[@name='js']//file"/>
				<xsl:if test="$ScriptsFiles">
					<ItemGroup>
						<xsl:for-each select="$ScriptsFiles">
							<EmbeddedResource Include="{@path}" />
						</xsl:for-each>
					</ItemGroup>
				</xsl:if>
				<xsl:variable name="MobileFiles" select="folder[@name='css']//file"/>
				<xsl:if test="$MobileFiles">
					<ItemGroup>
						<xsl:for-each select="$MobileFiles">
							<Content Include="{@path}"/>
						</xsl:for-each>
					</ItemGroup>
				</xsl:if>
			</xsl:if>
			<xsl:variable name="ThemeFiles" select="folder[@name='Theme']/file"/>
			<xsl:if test="$ThemeFiles">
				<ItemGroup>
					<xsl:for-each select="$ThemeFiles">
						<EmbeddedResource Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="AppThemesFiles" select="//folder[@name='App_Themes']//file"/>
			<xsl:if test="$AppThemesFiles">
				<ItemGroup>
					<xsl:for-each select="$AppThemesFiles">
						<Content Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:if test="$ReportsEnabled='true'">
				<ItemGroup>
					<!--<EmbeddedResource Include="Reports\Template.xslt" />-->
					<xsl:for-each select="folder[@loweredName='reports']/file">
						<EmbeddedResource Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="SiteMapFiles" select="//file[@name='Web.Sitemap']"/>
			<xsl:if test="$SiteMapFiles">
				<ItemGroup>
					<Content Include="Web.Sitemap" />
				</ItemGroup>
			</xsl:if>
			<xsl:variable name="ResourcesLocalizationFiles" select="file[starts-with(@name, 'Resources.')]"/>
			<xsl:if test="$ResourcesLocalizationFiles">
				<ItemGroup>
					<xsl:for-each select="$ResourcesLocalizationFiles">
						<EmbeddedResource Include="{@path}" />
					</xsl:for-each>
				</ItemGroup>
			</xsl:if>
			<Import Project="$(MSBuildBinPath)\Microsoft.{$CodedomProviderName}.targets" />
			<xsl:if test="$IsClassLibrary='false'">
				<xsl:choose>
					<xsl:when test="$TargetFramework!='3.5'">
						<xsl:choose>
							<xsl:when test="$VisualStudio2022!='' or $VisualStudio2019!='' or $VisualStudio2017!='' or $VisualStudio2015!='' or $VisualStudio2013!='' or $VisualStudio2012!=''">
								<PropertyGroup>
									<VisualStudioVersion Condition="'$(VisualStudioVersion)' == ''">10.0</VisualStudioVersion>
									<VSToolsPath Condition="'$(VSToolsPath)' == ''">$(MSBuildExtensionsPath32)\Microsoft\VisualStudio\v$(VisualStudioVersion)</VSToolsPath>
								</PropertyGroup>
								<Import Project="$(VSToolsPath)\WebApplications\Microsoft.WebApplication.targets" Condition="'$(VSToolsPath)' != ''" />
							</xsl:when>
							<xsl:otherwise>
								<Import Project="$(MSBuildExtensionsPath32)\Microsoft\VisualStudio\v10.0\WebApplications\Microsoft.WebApplication.targets" />
							</xsl:otherwise>
						</xsl:choose>
						<ProjectExtensions>
							<VisualStudio>
								<FlavorProperties GUID="{{349c5851-65df-11da-9384-00065b846f21}}">
									<WebProjectProperties>
										<xsl:choose>
											<xsl:when test="$VisualStudio2013 != '' or $VisualStudio2015 != '' or $VisualStudio2017 != '' or $VisualStudio2019 != '' or $VisualStudio2022 != ''">
												<UseIIS>True</UseIIS>
											</xsl:when>
											<xsl:otherwise>
												<UseIIS>False</UseIIS>
											</xsl:otherwise>
										</xsl:choose>
										<AutoAssignPort>True</AutoAssignPort>
										<DevelopmentServerVPath>/</DevelopmentServerVPath>
										<NTLMAuthentication>False</NTLMAuthentication>
										<UseCustomServer>False</UseCustomServer>
										<CustomServerUrl>
										</CustomServerUrl>
										<SaveServerSettingsInUserFile>False</SaveServerSettingsInUserFile>
									</WebProjectProperties>
								</FlavorProperties>
							</VisualStudio>
						</ProjectExtensions>
					</xsl:when>
					<xsl:otherwise>
						<Import Project="$(MSBuildExtensionsPath32)\Microsoft\VisualStudio\v9.0\WebApplications\Microsoft.WebApplication.targets" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:comment>
				<![CDATA[To modify your build process, add your task inside one of the targets below and uncomment it. 
       Other similar extension points exist, see Microsoft.Common.targets.
  <Target Name="BeforeBuild">
  </Target>
  <Target Name="AfterBuild">
  </Target>
  ]]>
			</xsl:comment>
		</Project>
	</xsl:template>
</xsl:stylesheet>
