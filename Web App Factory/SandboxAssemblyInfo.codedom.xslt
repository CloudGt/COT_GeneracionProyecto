<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:ontime="urn:schemas-codeontime-com:xslt"
 	  exclude-result-prefixes="msxsl a ontime"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="Namespace"/>

  <xsl:template match="/">
    <compileUnit>
      <imports>
        <namespaceImport name="System.Reflection"/>
        <namespaceImport name="System.Runtime.CompilerServices"/>
        <namespaceImport name="System.Runtime.InteropServices"/>
        <namespaceImport name="System.Web.UI"/>
      </imports>
      <types>
        <!-- class SqlStatement -->
        <typeDeclaration name="Assembly">
          <customAttributes>
            <customAttribute type="AssemblyTitle">
              <arguments>
                <primitiveExpression value="Sandbox"/>
              </arguments>
            </customAttribute>
            <customAttribute type="AssemblyDescription">
              <arguments>
                <primitiveExpression value="Data Aquarium Sandbox application"/>
              </arguments>
            </customAttribute>
            <customAttribute type="AssemblyCompany">
              <arguments>
                <primitiveExpression value="{$Namespace}"/>
              </arguments>
            </customAttribute>
            <customAttribute type="AssemblyProduct">
              <arguments>
                <primitiveExpression value="{$Namespace} Sandbox"/>
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
           </customAttributes>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>

 </xsl:stylesheet>
