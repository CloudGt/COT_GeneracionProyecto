<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:ontime="urn:schemas-codeontime-com:xslt"
 	  exclude-result-prefixes="msxsl a ontime"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="IsPremium"/>
  <xsl:param name="Namespace"/>
  <xsl:param name="ProjectPath"/>
  <xsl:param name="MembershipEnabled" select="'false'"/>
  <xsl:param name="CustomSecurity" select="'false'"/>
  <xsl:param name="WindowsAuthentication" select="'false'"/>
  <xsl:param name="ActiveDirectory" select="'false'"/>
  <xsl:param name="Theme" select="'Aquarium'"/>
  <xsl:param name="TargetFramework"/>
  <xsl:param name="Globalization_SupportedCultures"/>
  <xsl:param name="ScriptOnly" select="'false'"/>
  <xsl:param name="Mobile"/>

  <msxsl:script language="CSharp" implements-prefix="ontime">
    <![CDATA[
        public string ReplaceThemeProjectName(string projectPath, string projectNamespace)
        {
          string namespaceThemeFolder = System.IO.Path.Combine(projectPath, projectNamespace + "\\Theme");
          if (System.IO.Directory.Exists(namespaceThemeFolder)) {
					  foreach (string filename in System.IO.Directory.GetFiles(namespaceThemeFolder, "*.css"))
					  {
						  string theme = System.IO.File.ReadAllText(filename);
						  System.IO.File.WriteAllText(filename,
							  System.Text.RegularExpressions.Regex.Replace(theme, @"DAF\.", projectNamespace + "."));
				    }
          }
					return String.Empty;
        }
        
        public string Replace(string s1, string s2, string s3)
        {
          return s1.Replace(s2, s3);
        }
		]]>
  </msxsl:script>

  <xsl:variable name="Dummy" select="ontime:ReplaceThemeProjectName($ProjectPath, $Namespace)"/>

  <xsl:template match="fileSystem">
    <compileUnit>
      <imports>
        <namespaceImport name="System.Reflection"/>
        <!--<namespaceImport name="System.Runtime.CompilerServices"/>-->
        <namespaceImport name="System.Runtime.InteropServices"/>
        <namespaceImport name="System.Web.UI"/>
      </imports>
      <types>
        <!-- class SqlStatement -->
        <typeDeclaration name="Assembly">
          <customAttributes>
            <customAttribute type="AssemblyTitle">
              <arguments>
                <primitiveExpression value="{$Namespace}"/>
              </arguments>
            </customAttribute>
            <customAttribute type="AssemblyDescription">
              <arguments>
                <primitiveExpression value="Data Aquarium Framework application library"/>
              </arguments>
            </customAttribute>
            <customAttribute type="AssemblyCompany">
              <arguments>
                <primitiveExpression value="{$Namespace}"/>
              </arguments>
            </customAttribute>
            <customAttribute type="AssemblyProduct">
              <arguments>
                <primitiveExpression value="{$Namespace} Aquarium in the Box"/>
              </arguments>
            </customAttribute>
            <customAttribute type="AssemblyCopyright">
              <arguments>
                <primitiveExpression value="Copyright © {$Namespace} 2022"/>
              </arguments>
            </customAttribute>
            <customAttribute type="ComVisible">
              <arguments>
                <primitiveExpression value="false"/>
              </arguments>
            </customAttribute>
            <customAttribute type="AssemblyVersion">
              <arguments>
                <primitiveExpression value="1.0.*" convertTo="String"/>
              </arguments>
            </customAttribute>
            <customAttribute type="AssemblyFileVersion">
              <arguments>
                <primitiveExpression value="1.0.0.0" convertTo="String"/>
              </arguments>
            </customAttribute>
            <customAttribute type="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.js.sys._System.js"/>
                <primitiveExpression value="text/javascript"/>
              </arguments>
            </customAttribute>
            <customAttribute type="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.js.sys.bootstrap.min.js"/>
                <primitiveExpression value="text/javascript"/>
              </arguments>
            </customAttribute>
						<customAttribute type="WebResource">
							<arguments>
								<primitiveExpression value="{$Namespace}.js.sys.jquery-2.2.4.min.js"/>
								<primitiveExpression value="text/javascript"/>
							</arguments>
						</customAttribute>
						<customAttribute type="WebResource">
							<arguments>
								<primitiveExpression value="{$Namespace}.js.sys.jquery-3.6.0.min.js"/>
								<primitiveExpression value="text/javascript"/>
							</arguments>
						</customAttribute>
            <customAttribute type="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.js.daf.daf.min.js"/>
                <primitiveExpression value="text/javascript"/>
              </arguments>
            </customAttribute>
            <customAttribute type="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.js.sys.unicode.min.js"/>
                <primitiveExpression value="text/javascript"/>
              </arguments>
            </customAttribute>
            <customAttribute type="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.js.daf.daf-odp.min.js"/>
                <primitiveExpression value="text/javascript"/>
              </arguments>
            </customAttribute>
            <customAttribute type="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.js.daf.daf-ifttt.min.js"/>
                <primitiveExpression value="text/javascript"/>
              </arguments>
            </customAttribute>
						<customAttribute type="WebResource">
							<arguments>
								<primitiveExpression value="{$Namespace}.js.daf.touch-input.min.js"/>
								<primitiveExpression value="text/javascript"/>
							</arguments>
						</customAttribute>
						<customAttribute type="WebResource">
							<arguments>
								<primitiveExpression value="{$Namespace}.js.daf.input-blob.min.js"/>
								<primitiveExpression value="text/javascript"/>
							</arguments>
						</customAttribute>
						<customAttribute type="WebResource">
							<arguments>
								<primitiveExpression value="{$Namespace}.js.daf.touch-edit.min.js"/>
								<primitiveExpression value="text/javascript"/>
							</arguments>
						</customAttribute>
						<!--<customAttribute type="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.js.daf.touch-scroll.min.js"/>
                <primitiveExpression value="text/javascript"/>
              </arguments>
            </customAttribute>-->
            <!--<customAttribute type="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.js.daf.daf-resources.min.js"/>
                <primitiveExpression value="text/javascript"/>
              </arguments>
            </customAttribute>-->
            <xsl:call-template name="RenderLocalizedResource">
              <xsl:with-param name="Cultures" select="ontime:Replace($Globalization_SupportedCultures, ' ', '')"/>
              <xsl:with-param name="FileName" select="concat($Namespace, '.js.daf.daf-resources.min')"/>
              <xsl:with-param name="Extension" select="'js'"/>
            </xsl:call-template>
            <xsl:call-template name="RenderLocalizedCulture">
              <xsl:with-param name="Cultures" select="ontime:Replace($Globalization_SupportedCultures, ' ', '')"/>
              <xsl:with-param name="FileName" select="concat($Namespace, '.js.sys.culture')"/>
              <xsl:with-param name="Extension" select="'js'"/>
            </xsl:call-template>
            <xsl:if test="$IsPremium='true'">
              <customAttribute type="WebResource">
                <arguments>
                  <primitiveExpression value="{$Namespace}.js.daf.daf-extensions.min.js"/>
                  <primitiveExpression value="text/javascript"/>
                </arguments>
              </customAttribute>
            </xsl:if>
            <xsl:if test="$Mobile='true'">
              <customAttribute type="WebResource">
                <arguments>
                  <primitiveExpression value="{$Namespace}.js.daf.touch.min.js"/>
                  <primitiveExpression value="text/javascript"/>
                </arguments>
              </customAttribute>
              <customAttribute type="WebResource">
                <arguments>
                  <primitiveExpression value="{$Namespace}.js.daf.touch-charts.min.js"/>
                  <primitiveExpression value="text/javascript"/>
                </arguments>
              </customAttribute>
            </xsl:if>
            <customAttribute type="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.js.daf.daf-menu.min.js"/>
                <primitiveExpression value="text/javascript"/>
              </arguments>
            </customAttribute>
            <customAttribute type="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.js.sys.MicrosoftAjax.min.js"/>
                <primitiveExpression value="text/javascript"/>
              </arguments>
            </customAttribute>
            <customAttribute type="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.js.sys.MicrosoftAjaxWebForms.min.js"/>
                <primitiveExpression value="text/javascript"/>
              </arguments>
            </customAttribute>
            <xsl:if test="$ScriptOnly='true'">
              <customAttribute type="WebResource">
                <arguments>
                  <primitiveExpression value="{$Namespace}.js.sys.AjaxControlToolkit.min.js"/>
                  <primitiveExpression value="text/javascript"/>
                </arguments>
              </customAttribute>
            </xsl:if>
            <xsl:if test="$MembershipEnabled='true' or $WindowsAuthentication='true' or $CustomSecurity='true' or $ActiveDirectory='true'">
              <xsl:if test="$TargetFramework='3.5'">
                <customAttribute type="WebResource">
                  <arguments>
                    <primitiveExpression value="{$Namespace}.js.sys.MicrosoftAjaxApplicationServices.min.js"/>
                    <primitiveExpression value="text/javascript"/>
                  </arguments>
                </customAttribute>
              </xsl:if>
              <!--<customAttribute type="WebResource">
                <arguments>
                  <primitiveExpression value="{$Namespace}.Scripts.Web.MembershipResources.js"/>
                  <primitiveExpression value="text/javascript"/>
                </arguments>
              </customAttribute>-->
              <!--<xsl:call-template name="RenderLocalizedResource">
                <xsl:with-param name="Cultures" select="ontime:Replace($Globalization_SupportedCultures, ' ', '')"/>
                <xsl:with-param name="FileName" select="concat($Namespace, '.Scripts.Web.MembershipResources')"/>
                <xsl:with-param name="Extension" select="'js'"/>
              </xsl:call-template>-->
              <customAttribute type="WebResource">
                <arguments>
                  <primitiveExpression value="{$Namespace}.js.daf.daf-membership.min.js"/>
                  <primitiveExpression value="text/javascript"/>
                </arguments>
              </customAttribute>
              <!--<customAttribute type="WebResource">
                <arguments>
                  <primitiveExpression value="{$Namespace}.Scripts.Web.MembershipManager.js"/>
                  <primitiveExpression value="text/javascript"/>
                </arguments>
              </customAttribute>-->
              <!--<customAttribute name="WebResource">
								<arguments>
									<primitiveExpression value="{$Namespace}.Theme.Membership.css"/>
									<primitiveExpression value="text/css"/>
									<attributeArgument name="PerformSubstitution">
										<primitiveExpression value="true"/>
									</attributeArgument>
								</arguments>
							</customAttribute>-->
            </xsl:if>
            <!--<xsl:if test="$CustomSecurity='true' or $WindowsAuthentication='true' or $ActiveDirectory='true'">
              <customAttribute type="WebResource">
                <arguments>
                  <primitiveExpression value="{$Namespace}.Scripts.Web.MembershipResources.js"/>
                  <primitiveExpression value="text/javascript"/>
                </arguments>
              </customAttribute>
              <customAttribute type="WebResource">
                <arguments>
                  <primitiveExpression value="{$Namespace}.Scripts.Web.Membership.js"/>
                  <primitiveExpression value="text/javascript"/>
                </arguments>
              </customAttribute>
            </xsl:if>-->
            <customAttribute name="WebResource">
              <arguments>
                <primitiveExpression value="{$Namespace}.Theme.{$Theme}.css"/>
                <primitiveExpression value="text/css"/>
                <attributeArgument name="PerformSubstitution">
                  <primitiveExpression value="true"/>
                </attributeArgument>
              </arguments>
            </customAttribute>
            <xsl:for-each select="file[not(contains(@name, '.css'))]">
              <customAttribute name="WebResource">
                <arguments>
                  <primitiveExpression value="{$Namespace}.Theme.{@name}"/>
                  <primitiveExpression value="image/{substring-after(@name,'.')}"/>
                </arguments>
              </customAttribute>
            </xsl:for-each>
          </customAttributes>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>

  <xsl:template name="RenderLocalizedResource">
    <xsl:param name="Cultures"/>
    <xsl:param name="FileName"/>
    <xsl:param name="Extension"/>
    <xsl:variable name="Culture" select="substring-after(substring-before($Cultures, ';'), ',')"/>
    <xsl:if test="string-length($Culture)>0">
      <xsl:variable name="CultureInfo">
        <xsl:choose>
          <xsl:when test="contains($Culture, '-')">
            <xsl:value-of select="ontime:Replace($Culture, '-', '_')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$Culture"/>
            <xsl:text>_</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <customAttribute type="WebResource">
        <arguments>
          <primitiveExpression value="{$FileName}.{$CultureInfo}.{$Extension}"/>
          <primitiveExpression value="text/javascript"/>
        </arguments>
      </customAttribute>
      <xsl:call-template name="RenderLocalizedResource">
        <xsl:with-param name="Cultures" select="substring-after($Cultures, ';')"/>
        <xsl:with-param name="FileName" select="$FileName"/>
        <xsl:with-param name="Extension" select="$Extension"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="RenderLocalizedCulture">
    <xsl:param name="Cultures"/>
    <xsl:param name="FileName"/>
    <xsl:param name="Extension"/>
    <xsl:variable name="Culture" select="substring-after(substring-before($Cultures, ';'), ',')"/>
    <xsl:if test="string-length($Culture)>0">
      <customAttribute type="WebResource">
        <arguments>
          <primitiveExpression value="{$FileName}.{$Culture}.{$Extension}"/>
          <primitiveExpression value="text/javascript"/>
        </arguments>
      </customAttribute>
      <xsl:call-template name="RenderLocalizedCulture">
        <xsl:with-param name="Cultures" select="substring-after($Cultures, ';')"/>
        <xsl:with-param name="FileName" select="$FileName"/>
        <xsl:with-param name="Extension" select="$Extension"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
