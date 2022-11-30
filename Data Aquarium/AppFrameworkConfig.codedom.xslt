<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:codeontime="urn:schemas-codeontime-com:ease"  exclude-result-prefixes="msxsl a codeontime"
>

  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="TargetFramework" select="a:project/@targetFramework"/>
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

  <xsl:variable name="Theme" select="a:project/a:theme/@name"/>
  <xsl:variable name="MembershipEnabled" select="a:project/a:membership/@enabled"/>
  <xsl:variable name="CustomSecurity" select="a:project/a:membership/@customSecurity"/>
  <xsl:variable name="Namespace" select="a:project/a:namespace"/>
  <xsl:variable name="PageHeader" select="a:project/a:features/@pageHeader"/>

  <xsl:template match="/">
    <compileUnit namespace="{$Namespace}.Services">
      <imports>
        <namespaceImport name="{$Namespace}.Handlers"/>
      </imports>
      <types>
        <!-- class AppFrameworkConfig -->
        <typeDeclaration name="AppFrameworkConfig" isPartial="true">
          <attributes public="true"/>
          <members>
            <!-- method Initialize()-->
            <memberMethod name="Initialize">
              <attributes public="true" static="true"/>
              <statements>
                <methodInvokeExpression methodName="Initialize">
                  <target>
                    <typeReferenceExpression type="BlobFactoryConfig"/>
                  </target>
                </methodInvokeExpression>
                <xsl:if test="$SiteContentTableName!=''">
                  <assignStatement>
                    <propertyReferenceExpression name="DefaultSiteContentControllerName">
                      <typeReferenceExpression type="ApplicationServices"/>
                    </propertyReferenceExpression>
                    <primitiveExpression value="{$SiteContentTableName}"/>
                  </assignStatement>
                </xsl:if>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
