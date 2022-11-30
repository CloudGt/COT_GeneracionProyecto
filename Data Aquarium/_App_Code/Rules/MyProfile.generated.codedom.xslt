<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:c="urn:schemas-codeontime-com:data-aquarium"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:csharp="urn:codeontime-customcode"
    exclude-result-prefixes="msxsl a c csharp"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="Namespace" select="a:project/a:namespace"/>
  <xsl:param name="ProviderName"/>
  <xsl:param name="IsPremium"/>
  <xsl:param name="IsUnlimited"/>
  <xsl:param name="SharedBusinessRules"/>
  <xsl:param name="SiteContentTableName"/>
  <xsl:param name="ActiveDirectory"/>
  <xsl:param name="MembershipDisplayRememberMe" />
  <xsl:param name="MembershipRememberMeSet" />

  <xsl:template match="c:dataController">
    <compileUnit namespace="{$Namespace}.Rules">
      <types>
        <!-- MyProfileBusinessRules -->
        <typeDeclaration name="MyProfileBusinessRules" isPartial="true">
          <baseTypes>
            <typeReference type="MyProfileBusinessRulesBase"/>
          </baseTypes>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
