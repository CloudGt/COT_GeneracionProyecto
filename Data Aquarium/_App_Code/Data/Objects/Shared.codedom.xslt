<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:c="urn:schemas-codeontime-com:data-aquarium"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
    xmlns:csharp="urn:codeontime-customcode"
    exclude-result-prefixes="msxsl a c csharp"
>

  <msxsl:script language="C#" implements-prefix="csharp">
    public string ExtractNamespace(string name){
    return Regex.Match(name, @"^(.+)(\.\w+)$", RegexOptions.Compiled).Groups[1].Value;
    }
    public string ExtractClassName(string name) {
    return Regex.Match(name, @".(\w+)$", RegexOptions.Compiled).Groups[1].Value;
    }
  </msxsl:script>
  
	<xsl:template name="RenderFieldType">
		<xsl:variable name="IsReferenceType">
			<xsl:call-template name="GetIsReferenceType"/>
		</xsl:variable>
		<xsl:variable name="Type">
			<xsl:choose>
				<xsl:when test="@type='Currency'">
					<xsl:text>Decimal</xsl:text>
				</xsl:when>
				<xsl:when test="@type='Date' or @type='Time' or @type='DateTime2'">
					<xsl:text>DateTime</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@type"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:attribute name="type">
			<xsl:choose>
				<xsl:when test="$IsReferenceType='true'">
					<xsl:text>System.</xsl:text>
					<xsl:value-of select="$Type"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Nullable</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:if test="$IsReferenceType='false'">
			<typeArguments>
				<typeReference>
					<xsl:attribute name="type">
						<xsl:if test="not($Type='DateTime')">
							<xsl:text>System.</xsl:text>
						</xsl:if>
						<xsl:value-of select="$Type"/>
					</xsl:attribute>
				</typeReference>
			</typeArguments>
		</xsl:if>
	</xsl:template>

	<xsl:template name="GetIsReferenceType">
		<xsl:choose>
			<xsl:when test="@type='String' or @type='Byte[]' or @type='Object'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>false</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="GetAllowFilter">
		<xsl:choose>
			<xsl:when test="not(@type='Byte[]' or @type='DataView' or @onDemand='true' or @allowQBE='false' or @type='Object')">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>false</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="RenderFilterParameters">
		<xsl:for-each select="c:fields/c:field">
			<xsl:variable name="AllowFilter">
				<xsl:call-template name="GetAllowFilter"/>
			</xsl:variable>
			<xsl:if test="$AllowFilter='true'">
				<parameter name="{@name}">
					<xsl:call-template name="RenderFieldType"/>
				</parameter>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

  <xsl:template name="RenderRuleParameters">
    <xsl:for-each select="c:fields/c:field">
      <xsl:if test="not(@type='Byte[]' or @onDemand='true' or @type='Object' or @type='DataView')">
        <parameter name="{@name}">
          <xsl:call-template name="RenderFieldType"/>
        </parameter>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

	<xsl:template name="RenderFilterArguments">
		<xsl:param name="Container" />
		<xsl:for-each select="c:fields/c:field">
			<xsl:variable name="AllowFilter">
				<xsl:call-template name="GetAllowFilter"/>
			</xsl:variable>
			<xsl:if test="$AllowFilter='true'">
				<xsl:choose>
					<xsl:when test="$Container">
						<propertyReferenceExpression>
							<xsl:attribute name="name">
								<xsl:call-template name="GeneratePropertyName"/>
							</xsl:attribute>
							<argumentReferenceExpression name="{$Container}"/>
						</propertyReferenceExpression>
					</xsl:when>
					<xsl:otherwise>
						<argumentReferenceExpression name="{@name}"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="GeneratePropertyName">
		<xsl:param name="ObjectName" select="ancestor::c:dataController[1]/@name"/>
		<xsl:param name="PropertyName" select="@name"/>
		<xsl:value-of select="$PropertyName"/>
		<xsl:if test="$PropertyName=$ObjectName">
			<xsl:text>_</xsl:text>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
