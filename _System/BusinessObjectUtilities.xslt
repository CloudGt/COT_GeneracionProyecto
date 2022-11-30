<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="ontime msxsl bo"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:ontime="urn:schemas-codeontime-com:xslt"
    xmlns:bo="urn:schemas-codeontime-com:business-objects"
   >
  <msxsl:script language="CSharp" implements-prefix="ontime">
    <![CDATA[
    public string LookupExpressionByFieldName(string text, string fieldName)
    {
        return LookupFieldInfoByFieldName(text, fieldName, "Expression");
    }
    public string LookupFieldByFieldName(string text, string fieldName)
    {
        return LookupFieldInfoByFieldName(text, fieldName, "Field");
    }
    public string LookupFieldInfoByFieldName(string text, string fieldName, string partName)
    {
        System.Text.RegularExpressions.Match m = System.Text.RegularExpressions.Regex.Match(text, String.Format(@"(?'Expression'""[\w\s_]+"".(?'Field'""[\w\s_]+""))\s+""{0}""", fieldName), System.Text.RegularExpressions.RegexOptions.Compiled);
        if (m.Success)
            return m.Groups[partName].Value;
        else
            return String.Format("{0}_Not_Found", fieldName);
    }
    public string LookupTableName(string text)
    {
        System.Text.RegularExpressions.Match m = System.Text.RegularExpressions.Regex.Match(text, @"from\s+(""[\s\S]+?""\.""[\s\S]+?"")[\s\S]+?\s*\r\n", System.Text.RegularExpressions.RegexOptions.Compiled);
        if (m.Success)
            return m.Groups[1].Value;
        else
            return "LookupTableName_Error";
    }
		public string ToLower(XPathNodeIterator iterator)
		{
			if (iterator.MoveNext())
			    return iterator.Current.Value.ToLower();
			return "ToLower-Error";
		}
		]]>
  </msxsl:script>


  <xsl:template name="SqlHelper_GenerateSelect">
    <xsl:param name="BusinessObject" select="current()"/>
    <xsl:param name="PrimaryKeyFilter" select="false()"/>
    <xsl:param name="ForeignKeyFilter" select="false()"/>
    <xsl:variable name="SelectCommand" select="$BusinessObject/bo:commands/bo:command[1]/bo:text"/>
    <xsl:variable name="Fields" select="$BusinessObject/bo:fields/bo:field"/>
    <xsl:variable name="ParameterMarker" select="$BusinessObject/parent::bo:businessObjectCollection/@parameterMarker"/>
    <xsl:value-of select="$SelectCommand"/>
    <xsl:if test="$PrimaryKeyFilter = true()">
      <xsl:text>where&#13;&#10;</xsl:text>
    </xsl:if>
    <xsl:if test="$PrimaryKeyFilter = true()">
      <xsl:for-each select="$Fields[@isPrimaryKey='true']">
        <xsl:text>&#9;</xsl:text>
        <xsl:if test="position()>1">
          <xsl:text>&#13;&#10;&#9;and </xsl:text>
        </xsl:if>
        <xsl:value-of select="ontime:LookupExpressionByFieldName($SelectCommand, @name)"/>
        <xsl:text>=</xsl:text>
        <xsl:value-of select="$ParameterMarker"/>
        <xsl:value-of select="@name"/>
      </xsl:for-each>
    </xsl:if>
    <xsl:variable name="ForeignKeyFields" select="$Fields[bo:items/@businessObject!='']"/>
    <xsl:if test="$ForeignKeyFilter=true()">
      <xsl:for-each select="$ForeignKeyFields">
        <xsl:if test="position()=1">
          <xsl:text>where&#13;&#10;</xsl:text>
        </xsl:if>
        <xsl:text>&#9;</xsl:text>
        <xsl:if test="position()>1">
          <xsl:text>&#13;&#10;&#9;and </xsl:text>
        </xsl:if>
        <xsl:text>(</xsl:text>
        <xsl:value-of select="concat($ParameterMarker, @name)"/>
        <xsl:text> is null or </xsl:text>
        <xsl:value-of select="ontime:LookupExpressionByFieldName($SelectCommand, @name)"/>
        <xsl:text>=</xsl:text>
        <xsl:value-of select="$ParameterMarker"/>
        <xsl:value-of select="@name"/>
        <xsl:text>)</xsl:text>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="$PrimaryKeyFilter=false()">
      <xsl:if test="$ForeignKeyFields">
        <xsl:text>&#13;&#10;</xsl:text>
      </xsl:if>
      <xsl:text>order by </xsl:text>
      <xsl:value-of select="ontime:LookupExpressionByFieldName($SelectCommand, $BusinessObject/bo:views/bo:view[@type='Grid']//bo:dataField[1]/@fieldName)"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="SqlHelper_GenerateUpdate">
    <xsl:param name="BusinessObject" select="current()"/>
    <xsl:param name="ProviderName"/>
    <xsl:variable name="SelectCommand" select="$BusinessObject/bo:commands/bo:command[1]/bo:text"/>
    <xsl:variable name="Fields" select="$BusinessObject/bo:fields/bo:field"/>
    <xsl:variable name="ParameterMarker" select="$BusinessObject/parent::bo:businessObjectCollection/@parameterMarker"/>
    <xsl:text>update </xsl:text>
    <xsl:value-of select="ontime:LookupTableName($SelectCommand)"/>
    <xsl:text>&#13;&#10;set</xsl:text>
    <xsl:for-each select="$Fields[not(@readOnly='true') and not(@onDemand='true')]">
      <xsl:text>&#13;&#10;&#9;</xsl:text>
      <xsl:if test="position()>1">
        <xsl:text>,</xsl:text>
      </xsl:if>
      <xsl:value-of select="ontime:LookupFieldByFieldName($SelectCommand, @name)"/>
      <xsl:text>=</xsl:text>
      <xsl:choose>
        <xsl:when test="@default!='' and $ProviderName='System.Data.SqlClient'">
          <xsl:value-of select="concat('IsNull(', $ParameterMarker, @name, ', ', @default, ')')"/>
        </xsl:when>
        <xsl:when test="@default!='' and $ProviderName='System.Data.OracleClient'">
          <xsl:value-of select="concat('nvl(', $ParameterMarker, @name, ', ', @default, ')')"/>
        </xsl:when>
        <xsl:when test="@default!='' and ($ProviderName='Oracle.DataAccess.Client' or $ProviderName='Oracle.ManagedDataAccess.Client' )">
          <xsl:value-of select="concat('nvl(', $ParameterMarker, @name, ', ', @default, ')')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat($ParameterMarker, @name)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:text>&#13;&#10;where&#13;&#10;</xsl:text>
    <xsl:for-each select="$Fields[@isPrimaryKey='true']">
      <xsl:text>&#9;</xsl:text>
      <xsl:if test="position()>1">
        <xsl:text>&#13;&#10;&#9;and </xsl:text>
      </xsl:if>
      <xsl:value-of select="ontime:LookupFieldByFieldName($SelectCommand, @name)"/>
      <xsl:text>=</xsl:text>
      <xsl:value-of select="concat($ParameterMarker, @name)"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="SqlHelper_GenerateDelete">
    <xsl:param name="BusinessObject" select="current()"/>
    <xsl:variable name="SelectCommand" select="$BusinessObject/bo:commands/bo:command[1]/bo:text"/>
    <xsl:variable name="Fields" select="$BusinessObject/bo:fields/bo:field"/>
    <xsl:variable name="ParameterMarker" select="$BusinessObject/parent::bo:businessObjectCollection/@parameterMarker"/>
    <xsl:text>delete from </xsl:text>
    <xsl:value-of select="ontime:LookupTableName($SelectCommand)"/>
    <xsl:text>&#13;&#10;where&#13;&#10;</xsl:text>
    <xsl:for-each select="$Fields[@isPrimaryKey='true']">
      <xsl:text>&#9;</xsl:text>
      <xsl:if test="position()>1">
        <xsl:text>&#13;&#10;&#9;and </xsl:text>
      </xsl:if>
      <xsl:value-of select="ontime:LookupFieldByFieldName($SelectCommand, @name)"/>
      <xsl:text>=</xsl:text>
      <xsl:value-of select="$ParameterMarker"/>
      <xsl:value-of select="@name"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="SqlHelper_GenerateInsert">
    <xsl:param name="BusinessObject" select="current()"/>
    <xsl:param name="ProviderName"/>
    <xsl:variable name="SelectCommand" select="$BusinessObject/bo:commands/bo:command[1]/bo:text"/>
    <xsl:variable name="Fields" select="$BusinessObject/bo:fields/bo:field"/>
    <xsl:variable name="ParameterMarker" select="$BusinessObject/parent::bo:businessObjectCollection/@parameterMarker"/>
    <xsl:text>insert into </xsl:text>
    <xsl:value-of select="ontime:LookupTableName($SelectCommand)"/>
    <xsl:text>(</xsl:text>
    <xsl:for-each select="$Fields[not(@readOnly='true') and not(@onDemand='true')]">
      <xsl:text>&#13;&#10;&#9;</xsl:text>
      <xsl:if test="position()>1">
        <xsl:text>,</xsl:text>
      </xsl:if>
      <xsl:value-of select="ontime:LookupFieldByFieldName($SelectCommand, @name)"/>
    </xsl:for-each>
    <xsl:text>)&#13;&#10;values (</xsl:text>
    <xsl:for-each select="$Fields[not(@readOnly='true') and not(@onDemand='true')]">
      <xsl:text>&#13;&#10;&#9;</xsl:text>
      <xsl:if test="position()>1">
        <xsl:text>,</xsl:text>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="@default!='' and $ProviderName='System.Data.SqlClient'">
          <xsl:value-of select="concat('IsNull(', $ParameterMarker, @name, ', ', @default, ')')"/>
        </xsl:when>
        <xsl:when test="@default!='' and $ProviderName='System.Data.OracleClient'">
          <xsl:value-of select="concat('nvl(', $ParameterMarker, @name, ', ', @default, ')')"/>
        </xsl:when>
        <xsl:when test="@default!='' and ($ProviderName='Oracle.DataAccess.Client' or $ProviderName='Oracle.ManagedDataAccess.Client')">
          <xsl:value-of select="concat('nvl(', $ParameterMarker, @name, ', ', @default, ')')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat($ParameterMarker, @name)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:text>)</xsl:text>
  </xsl:template>

</xsl:stylesheet>
