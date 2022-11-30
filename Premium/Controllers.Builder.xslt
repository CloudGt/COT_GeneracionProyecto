<?xml version="1.0" encoding="utf-8"?>

<!-- 

(1) Action groups in data controllers still have HeaderText attribute

(2) Remove category template from the Schema. Make sure to preserve category in the log.


-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl "
    xmlns="urn:schemas-codeontime-com:data-aquarium" xmlns:a="urn:schemas-codeontime-com:data-aquarium"
    
    
>
	<xsl:output method="xml" indent="yes" cdata-section-elements="a:text"/>

	<xsl:param name="ControllersPath" />

	<xsl:variable name="Controllers" select="document($ControllersPath)/a:dataControllerCollection/a:dataController"/>

	<xsl:template match="/">
		<dataControllerCollection>
			<xsl:apply-templates select="DataAquariumSchema/Controllers">
			</xsl:apply-templates>
		</dataControllerCollection>
	</xsl:template>

	<xsl:template match="Controllers">
		<xsl:variable name="CurrentController" select="$Controllers[@name=current()/Controller]"/>
		<dataController name="{Controller}" conflictDetection="{ConflictDetection}" label="{$CurrentController/@label}" >
			<xsl:if test="Handler!=''">
				<xsl:attribute name="handler">
					<xsl:value-of select="Handler"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="Annotations='yes'">
				<xsl:attribute name="allowAnnotations">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="ConnectionStringName!=''">
				<xsl:attribute name="connectionStringName">
					<xsl:value-of select="ConnectionStringName"/>
				</xsl:attribute>
			</xsl:if>
			<commands>
				<xsl:copy-of select="$CurrentController/a:commands/a:command"/>
			</commands>
			<xsl:variable name="Fields" select="/DataAquariumSchema/Fields[Controller=current()/Controller]"/>
			<fields>
				<xsl:apply-templates select="$Fields"/>
			</fields>
			<xsl:variable name="Views" select="/DataAquariumSchema/Views[Controller=current()/Controller]"/>
			<xsl:variable name="Categories" select="/DataAquariumSchema/Categories[Controller=current()/Controller]"/>
			<xsl:variable name="DataFields" select="/DataAquariumSchema/DataFields[Controller=current()/Controller]"/>
			<views>
				<xsl:apply-templates select="$Views">
					<xsl:with-param name="Categories" select="$Categories"/>
					<xsl:with-param name="DataFields" select="$DataFields"/>
				</xsl:apply-templates>
			</views>
			<actions>
				<xsl:copy-of select="$CurrentController/a:actions/a:actionGroup"/>
			</actions>
		</dataController>
	</xsl:template>

	<xsl:template match="Fields">
		<field name="{FieldName}" type="{Type}">
			<!-- "field" attributes -->
			<xsl:if test="AllowNulls='no'">
				<xsl:attribute name="allowNulls">
					<xsl:text>false</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="IsPrimaryKey='yes'">
				<xsl:attribute name="isPrimaryKey">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="ServerDefault!=''">
				<xsl:attribute name="default">
					<xsl:value-of select="ServerDefault"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="Computed='yes'">
				<xsl:attribute name="computed">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="ReadOnly='yes'">
				<xsl:attribute name="readOnly">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="Label!=''">
				<xsl:attribute name="label">
					<xsl:value-of select="Label"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="ShowInSummary='yes'">
				<xsl:attribute name="showInSummary">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="HtmlEncoding='yes'">
				<xsl:attribute name="htmlEncoding">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="FormatOnClient='yes'">
				<xsl:attribute name="formatOnClient">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="DataFormatString">
				<xsl:attribute name="dataFormatString">
					<xsl:value-of select="DataFormatString"/>
				</xsl:attribute>
			</xsl:if>
      <xsl:if test="LEV='yes'">
        <xsl:attribute name="allowLEV">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="Calculated='yes'">
        <xsl:attribute name="calculated">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="CausesCalculate='yes'">
        <xsl:attribute name="causesCalculate">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="IsVirtual='yes'">
        <xsl:attribute name="isVirtual">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="ContextFields">
				<xsl:attribute name="contextFields">
					<xsl:value-of select="ContextFields"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="AllowQBE='no'">
				<xsl:attribute name="allowQBE">
					<xsl:text>false</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="AllowSorting='no'">
				<xsl:attribute name="allowSorting">
					<xsl:text>false</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="Mask">
				<xsl:attribute name="mask">
					<xsl:value-of select="Mask"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="MaskType">
				<xsl:attribute name="maskType">
					<xsl:value-of select="MaskType"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="ReadRoles">
				<xsl:attribute name="roles">
					<xsl:value-of select="ReadRoles"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="WriteRoles">
				<xsl:attribute name="writeRoles">
					<xsl:value-of select="WriteRoles"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="OnDemand='yes'">
				<xsl:attribute name="onDemand">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="onDemandHandler">
					<xsl:value-of select="OnDemandHandler"/>
				</xsl:attribute>
				<xsl:attribute name="onDemandStyle">
					<xsl:value-of select="OnDemandStyle"/>
				</xsl:attribute>
				<xsl:attribute name="sourceFields">
					<xsl:value-of select="SourceFields"/>
				</xsl:attribute>
			</xsl:if>
			<!-- "field" elements -->
			<xsl:if test="ItemsStyle!=''">
				<items style="{ItemsStyle}">
          <xsl:if test="ItemsDataController">
            <xsl:attribute name="dataController">
              <xsl:value-of select="ItemsDataController"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="ItemsDataView">
            <xsl:attribute name="dataController">
              <xsl:value-of select="ItemsDataView"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="ItemsDataValueField">
						<xsl:attribute name="dataValueField">
							<xsl:value-of select="ItemsDataValueField"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="ItemsDataTextField">
						<xsl:attribute name="dataTextField">
							<xsl:value-of select="ItemsDataTextField"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="ItemsNewDataView">
						<xsl:attribute name="newDataView">
							<xsl:value-of select="ItemsNewDataView"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="ItemsTargetDataController">
						<xsl:attribute name="targetController">
							<xsl:value-of select="ItemsTargetDataController"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="ItemsCopy">
						<xsl:attribute name="copy">
							<xsl:value-of select="ItemsCopy"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:for-each select="a:item">
						<xsl:copy-of select="."/>
					</xsl:for-each>
				</items>
			</xsl:if>
			<xsl:if test="Computed='yes'">
				<xsl:element name="formula">
					<xsl:value-of select="SQLFormula"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="Calculated='yes'">
				<xsl:element name="codeFormula">
					<xsl:value-of select="CodeFormula"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="CodeDefault">
				<xsl:element name="codeDefault">
					<xsl:value-of select="CodeDefault"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="DynamicConfiguration">
				<xsl:element name="configuration">
					<xsl:value-of select="DynamicConfiguration"/>
				</xsl:element>
			</xsl:if>
		</field>
	</xsl:template>

	<xsl:template match="Views">
		<xsl:param name="Categories"/>
		<xsl:param name="DataFields"/>
		<view id="{View}" type="{Type}" commandId="{CommandId}" label="{Label}">
			<xsl:if test="FilterExpression!=''">
				<xsl:attribute name="filter">
					<xsl:value-of select="FilterExpression"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="SortExpression!=''">
				<xsl:attribute name="sortExpression">
					<xsl:value-of select="SortExpression"/>
				</xsl:attribute>
			</xsl:if>
      <xsl:if test="VirtualViewId!=''">
        <xsl:attribute name="virtualViewId">
          <xsl:value-of select="VirtualViewId"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="BaseViewId!=''">
        <xsl:attribute name="baseViewId">
          <xsl:value-of select="BaseViewId"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="Layout!=''">
        <layout>
          <xsl:value-of select="layout"/>
        </layout>
      </xsl:if>
      <xsl:if test="OverrideWhen!=''">
        <overrideWhen>
          <xsl:value-of select="OverrideWhen"/>
        </overrideWhen>
      </xsl:if>
      <headerText>
				<xsl:value-of select="HeaderText"/>
			</headerText>
			<xsl:choose>
				<xsl:when test="Type='Grid'">
					<dataFields>
						<xsl:apply-templates select="$DataFields[View=current()/View]"/>
					</dataFields>
				</xsl:when>
				<xsl:otherwise>
					<categories>
						<xsl:apply-templates select="$Categories[View=current()/View]">
							<xsl:with-param name="DataFields" select="$DataFields"/>
						</xsl:apply-templates>
					</categories>
				</xsl:otherwise>
			</xsl:choose>
		</view>
	</xsl:template>

	<xsl:template match="Categories">
		<xsl:param name="DataFields" />
		<category headerText="{Category}">
			<xsl:if test="Flow!=''">
				<xsl:attribute name="flow">
          <xsl:value-of select="Flow"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="Floating='yes'">
				<xsl:attribute name="floating">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
			</xsl:if>
      <xsl:if test="Wrap='yes'">
        <xsl:attribute name="wrap">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="Tab">
				<xsl:attribute name="tab">
					<xsl:value-of select="Tab"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="Description">
				<description>
					<xsl:value-of select="Description"/>
				</description>
			</xsl:if>
      <xsl:if test="Layout!=''">
        <layout>
          <xsl:value-of select="layout"/>
        </layout>
      </xsl:if>
			<dataFields>
				<xsl:apply-templates select="$DataFields[Category=current()/Category and View=current()/View]"/>
			</dataFields>
		</category>
	</xsl:template>

	<xsl:template match="DataFields">
		<dataField fieldName="{FieldName}">
			<!-- "data field" attributes -->
			<xsl:if test="Hidden='yes'">
				<xsl:attribute name="hidden">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="ReadOnly='yes'">
				<xsl:attribute name="readOnly">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="DataFormatString">
				<xsl:attribute name="dataFormatString">
					<xsl:value-of select="DataFormatString"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="FormatOnClient='yes'">
				<xsl:attribute name="formatOnClient">
					<xsl:text>true</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="Columns!=''">
				<xsl:attribute name="columns">
					<xsl:value-of select="Columns"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="Rows!=''">
				<xsl:attribute name="rows">
					<xsl:value-of select="Rows"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="AliasFieldName!=''">
				<xsl:attribute name="aliasFieldName">
					<xsl:value-of select="AliasFieldName"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="HyperlinkFormatString!=''">
				<xsl:attribute name="hyperlinkFormatString">
					<xsl:value-of select="HyperlinkFormatString"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="AutoComplete!=''">
				<xsl:attribute name="autoCompletePrefixLength">
					<xsl:value-of select="AutoComplete"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="AggregateFunction!=''">
				<xsl:attribute name="aggregate">
					<xsl:value-of select="aggregate"/>
				</xsl:attribute>
			</xsl:if>
			<!-- "data field" elements -->
			<xsl:if test="HeaderText">
				<headerText>
					<xsl:value-of select="HeaderText"/>
				</headerText>
			</xsl:if>
			<xsl:if test="FooterText">
				<footerText>
					<xsl:value-of select="FooterText"/>
				</footerText>
			</xsl:if>
			<xsl:if test="CodeFilter!=''">
				<codeFilter operator="{FilterOperator}">
					<xsl:value-of select="CodeFilter"/>
				</codeFilter>
			</xsl:if>
		</dataField>
	</xsl:template>
</xsl:stylesheet>
