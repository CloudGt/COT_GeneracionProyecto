<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:cm="urn:schema-codeontime-com:culture-manager"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:codeontime="urn:schemas-codeontime-com:ease"  exclude-result-prefixes="msxsl a codeontime cm"
>

  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="SiteContentTableName" select="''"/>
  <xsl:param name="AppVersion"/>
  <xsl:param name="jQueryMobileVersion"/>
  <xsl:param name="SupportedCultures"/>

  <xsl:param name="IsUnlimited"/>
  <xsl:param name="IsFreeTrial"/>

  <xsl:variable name="Namespace" select="a:project/a:namespace"/>
  <xsl:variable name="PageHeader" select="a:project/a:features/@pageHeader"/>
  <xsl:variable name="MembershipEnabled" select="a:project/a:membership[@enabled='true' or @windowsAuthentication='true' or @activeDirectory='true' or @customSecurity='true']"/>

  <xsl:template match="/">
    <compileUnit namespace="{$Namespace}.Services">
      <imports>
        <namespaceImport name="{$Namespace}.Handlers"/>
        <xsl:if test="$IsFreeTrial='true'">
          <namespaceImport name="{$Namespace}.Data"/>
        </xsl:if>
        <xsl:if test="$IsUnlimited ='true'">
          <namespaceImport name="{$Namespace}.Web"/>
          <namespaceImport name="System.Web.Configuration"/>
        </xsl:if>
      </imports>
      <types>
        <!-- class AppFrameworkConfig -->
        <typeDeclaration name="AppFrameworkConfig" >
          <members>
            <!-- method Initialize() -->
            <memberMethod name="Initialize">
              <attributes public="true"/>
              <statements>
                <assignStatement>
                  <propertyReferenceExpression name="FrameworkAppName">
                    <typeReferenceExpression type="ApplicationServices"/>
                  </propertyReferenceExpression>
                  <primitiveExpression convertTo="String">
                    <xsl:attribute name="value">
                      <xsl:choose>
                        <xsl:when test="string-length($PageHeader)=0">
                          <xsl:choose>
                            <xsl:when test="/a:project/@displayName!=''">
                              <xsl:value-of select="/a:project/@displayName"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="/a:project/@prettyName"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$PageHeader"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:attribute>
                  </primitiveExpression>
                </assignStatement>
                <xsl:if test="$SiteContentTableName != ''">
                  <assignStatement>
                    <propertyReferenceExpression name="FrameworkSiteContentControllerName">
                      <typeReferenceExpression type="ApplicationServices"/>
                    </propertyReferenceExpression>
                    <primitiveExpression value="{$SiteContentTableName}"/>
                  </assignStatement>
                </xsl:if>
                <assignStatement>
                  <propertyReferenceExpression name="Version">
                    <typeReferenceExpression type="ApplicationServices"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="{$AppVersion}" convertTo="String"/>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="HostVersion">
                    <typeReferenceExpression type="ApplicationServices"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="1.2.5.0" convertTo="String"/>
                </assignStatement>
                <xsl:if test="$IsUnlimited ='true'">
                  <xsl:choose>
                    <xsl:when test="$IsFreeTrial='true'">
                      <variableDeclarationStatement type="System.Boolean" name="releaseMode">
                        <init>
                          <primitiveExpression value="true"/>
                        </init>
                      </variableDeclarationStatement>
                    </xsl:when>
                    <xsl:otherwise>
                      <variableDeclarationStatement type="CompilationSection" name="compilation">
                        <init>
                          <castExpression targetType="CompilationSection">
                            <methodInvokeExpression methodName="GetSection">
                              <target>
                                <typeReferenceExpression type="WebConfigurationManager"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="system.web/compilation"/>
                              </parameters>
                            </methodInvokeExpression>
                          </castExpression>
                        </init>
                      </variableDeclarationStatement>
                      <variableDeclarationStatement type="System.Boolean" name="releaseMode">
                        <init>
                          <unaryOperatorExpression operator="Not">
                            <propertyReferenceExpression name="Debug">
                              <variableReferenceExpression name="compilation"/>
                            </propertyReferenceExpression>
                          </unaryOperatorExpression>
                        </init>
                      </variableDeclarationStatement>
                    </xsl:otherwise>
                  </xsl:choose>
                  <assignStatement>
                    <propertyReferenceExpression name="EnableMinifiedScript">
                      <typeReferenceExpression type="AquariumExtenderBase"/>
                    </propertyReferenceExpression>
                    <variableReferenceExpression name="releaseMode"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="EnableCombinedScript">
                      <typeReferenceExpression type="AquariumExtenderBase"/>
                    </propertyReferenceExpression>
                    <variableReferenceExpression name="releaseMode"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="EnableMinifiedCss">
                      <typeReferenceExpression type="ApplicationServices"/>
                    </propertyReferenceExpression>
                    <variableReferenceExpression name="releaseMode"/>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="EnableCombinedCss">
                      <typeReferenceExpression type="ApplicationServices"/>
                    </propertyReferenceExpression>
                    <variableReferenceExpression name="releaseMode"/>
                  </assignStatement>
                  <xsl:if test="$IsFreeTrial='true'">
                    <assignStatement>
                      <propertyReferenceExpression name="SupportedCultures">
                        <typeReferenceExpression type="CultureManager"/>
                      </propertyReferenceExpression>
                      <arrayCreateExpression>
                        <createType type="System.String"/>
                        <initializers>
                          <xsl:call-template name="ListCulture"/>
                        </initializers>
                      </arrayCreateExpression>
                    </assignStatement>
                  </xsl:if>
                </xsl:if>
                <xsl:if test="not($MembershipEnabled)">
                  <assignStatement>
                    <propertyReferenceExpression name="AuthorizationIsSupported">
                      <typeReferenceExpression type="ApplicationServicesBase"/>
                    </propertyReferenceExpression>
                    <primitiveExpression value="false"/>
                  </assignStatement>
                </xsl:if>
                <methodInvokeExpression methodName="Initialize">
                  <target>
                    <typeReferenceExpression type="BlobFactoryConfig"/>
                  </target>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>

  <msxsl:script language="C#" implements-prefix="cm">
    <![CDATA[
   public string Trim(string s) {
    return s.Trim();
   }
  ]]>
  </msxsl:script>

  <xsl:template name="ListCulture">
    <xsl:param name="List" select="$SupportedCultures"/>
    <xsl:variable name="Head" select="substring-before($List, ';')"/>
    <xsl:variable name="Tail" select="substring-after($List, ';')"/>
    <primitiveExpression value="{cm:Trim($Head)}"/>
    <xsl:if test="$Head!=$Tail and contains($Tail, ';')">
      <xsl:call-template name="ListCulture">
        <xsl:with-param name="List" select="$Tail"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
