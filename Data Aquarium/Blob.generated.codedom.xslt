<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:da="urn:schemas-codeontime-com:data-aquarium" xmlns:ontime="urn:schemas-codeontime-com:extensions"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a da ontime"
    xmlns:dm="urn:schemas-codeontime-com:data-model"
>
  <xsl:param name="Namespace"/>
  <xsl:param name="ProviderName"/>
  <xsl:param name="Host"/>
  <xsl:param name="DataModelPath" select="''"/>

  <xsl:output method="xml" indent="yes"/>

  <msxsl:script language="C#" implements-prefix="ontime">
    <![CDATA[
    public XPathNavigator GetModelIfExists(string path, string controller)
    {
        string fileName = path + "\\" + controller + ".model.xml";
        if (System.IO.File.Exists(fileName)) {
            try
            {
                XPathDocument doc = new XPathDocument(fileName);
                return doc.CreateNavigator();
            }
            catch (Exception )
            {
            }
        }
        return new XmlDocument().CreateNavigator();
    }
  ]]>
  </msxsl:script>

  <xsl:variable name="Quote">
    <xsl:choose>
      <xsl:when test="contains($ProviderName,'MySql')">
        <xsl:text>`</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>"</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">

    <compileUnit>
      <xsl:attribute name="namespace">
        <xsl:value-of select="$Namespace"/>
        <xsl:if test="$Host='SharePoint'">
          <xsl:text>.WebParts</xsl:text>
        </xsl:if>
        <xsl:text>.Handlers</xsl:text>
      </xsl:attribute>
      <imports>
      </imports>
      <types>
        <!-- class  BlobFactory -->
        <typeDeclaration name="BlobFactoryConfig" isPartial="true">
          <baseTypes>
            <typeReference type="BlobFactory"/>
          </baseTypes>
          <members>
            <!-- method Initialize()-->
            <memberMethod name="Initialize">
              <attributes public="true" static="true"/>
              <statements>
                <comment>register blob handlers</comment>
                <xsl:variable name="OnDemandFields" select="//da:field[@onDemand='true']"/>
                <!-- previous condition in for-each: not(@onDemandHandler = preceding::da:field/@onDemandHandler)-->
                <xsl:for-each select="$OnDemandFields[not(@readOnly='true') and @onDemandHandler != '' and not(@onDemandHandler = preceding::da:field[not(@readOnly='true')]/@onDemandHandler)]">
                  <xsl:variable name="Object" select="parent::da:fields/parent::da:dataController"/>
                  <xsl:variable name="OnDemandControllers" select="//da:dataController[da:field/@onDemandHandler=current()/@onDemandHandler]"/>
                  <xsl:variable name="Model" select="ontime:GetModelIfExists($DataModelPath, $Object/@name)"/>
                  <methodInvokeExpression methodName="RegisterHandler">
                    <parameters>
                      <primitiveExpression value="{@onDemandHandler}"/>
                      <xsl:choose>
                        <xsl:when test="$Object/@nativeSchema != ''">
                          <primitiveExpression value="{$Quote}{$Object/@nativeSchema}{$Quote}.{$Quote}{$Object/@nativeTableName}{$Quote}"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <primitiveExpression value="{$Quote}{$Object/@nativeTableName}{$Quote}"/>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:variable name="BlobFieldName" select="@name"/>
                      <xsl:variable name="BlobColumn" select="$Model/dm:dataModel/dm:columns/dm:column[@fieldName=$BlobFieldName]/@name"/>
                      <xsl:variable name="BlobExpression">
                        <xsl:choose>
                          <xsl:when test="$BlobColumn!=''">
                            <xsl:value-of select="$BlobColumn"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="@name"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:variable>
                      <primitiveExpression value="{$Quote}{$BlobExpression}{$Quote}"/>
                      <arrayCreateExpression>
                        <createType type="System.String"/>
                        <initializers>
                          <xsl:for-each select="$Object/da:fields/da:field[@isPrimaryKey='true']">
                            <xsl:variable name="PKName" select="@name"/>
                            <xsl:variable name="FieldModel" select="$Model/dm:dataModel/dm:columns/dm:column[@fieldName=$PKName]"/>
                            <xsl:choose>
                              <xsl:when test="$FieldModel">
                                <primitiveExpression value="{$Quote}{$FieldModel/@name}{$Quote}"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <primitiveExpression value="{$Quote}{$PKName}{$Quote}"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:for-each>
                        </initializers>
                      </arrayCreateExpression>
                      <primitiveExpression value="{$Object/@label} {@label}"/>
                      <primitiveExpression value="{$Object/@name}"/>
                      <primitiveExpression value="{@name}"/>
                    </parameters>
                  </methodInvokeExpression>
                </xsl:for-each>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
