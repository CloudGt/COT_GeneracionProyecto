<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns="urn:schemas-codeontime-com:data-aquarium"
    xmlns:bo="urn:schemas-codeontime-com:business-objects"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    exclude-result-prefixes="msxsl bo a"
>
  <xsl:output method="xml" indent="yes" cdata-section-elements="bo:text text" />
  <xsl:param name="ReportsEnabled" select="'false'"/>
  <xsl:param name="FactoryEnabled" select="'false'"/>
  <xsl:param name="BatchEditEnabled" select="'false'"/>
  <xsl:param name="IsPremium"/>
  <xsl:param name="RelationshipExplorer"/>
  <!--<xsl:param name="EnableTransactions" select="'false'"/>-->
  <xsl:param name="UseSaveAndNew" select="'false'"/>
  <xsl:param name="SearchOnStartInLookups" select="'false'"/>
  <xsl:param name="TargetFramework"/>
  <xsl:param name="AzureFactory"/>
  <xsl:param name="SharePointFactory"/>
  <xsl:param name="ActionColumn" />
  <xsl:param name="PageImplementation"/>

  <xsl:variable name="RequiresNextSequence">
    <xsl:choose>
      <xsl:when test="contains(/bo:businessObjectCollection/@provider, 'Oracle')">
        <xsl:text>true</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>false</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="RequiresNextGenerator">
    <xsl:choose>
      <xsl:when test="contains(/bo:businessObjectCollection/@provider, 'Firebird')">
        <xsl:text>true</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>false</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="bo:businessObjectCollection">
    <dataControllerCollection>
      <xsl:apply-templates select="node() | text()"/>
    </dataControllerCollection>
  </xsl:template>

  <xsl:template match="bo:businessObject">
    <xsl:variable name="ReadOnlyObject" select="not(bo:fields/bo:field[@isPrimaryKey='true'])"/>
    <dataController>
      <xsl:apply-templates select="@*[name()='name' or name()='conflictDetection' or name()='text' or name()='label' or name()='nativeSchema' or name()='nativeTableName']"/>
      <xsl:apply-templates select="bo:commands | bo:fields | bo:views | text()"/>
      <xsl:element name="actions">
        <actionGroup id="ag1" scope="Grid">
          <!--<xsl:choose>
            <xsl:when test="$EnableTransactions='true'">
              <action id="a13" commandName="Select" commandArgument="editForm1" whenClientScript="!this.hasDetails() &amp;&amp; this.get_inTransaction() || !this.get_usesTransaction()"/>
              <action id="a14" commandName="Edit" whenClientScript="!this.hasDetails() &amp;&amp; this.get_inTransaction() || !this.get_usesTransaction()"/>
              <action id="a15" commandName="Navigate" cssClass="EditIcon" headerText="Edit" whenClientScript="this.hasDetails() &amp;&amp; this.get_usesTransaction()">
                <xsl:attribute name="commandArgument">
                  <xsl:text>?</xsl:text>
                  <xsl:for-each select="bo:fields/bo:field[@isPrimaryKey='true']">
                    <xsl:if test="position()>1">
                      <xsl:text>&amp;</xsl:text>
                    </xsl:if>
                    <xsl:value-of select="@name"/>
                    <xsl:text>={</xsl:text>
                    <xsl:value-of select="@name"/>
                    <xsl:text>}</xsl:text>
                  </xsl:for-each>
                  <xsl:text>&amp;_controller=</xsl:text>
                  <xsl:value-of select="@name"/>
                  <xsl:text>&amp;_commandName=Edit&amp;_commandArgument=editForm1&amp;_transaction=true</xsl:text>
                </xsl:attribute>
              </action>
              <action id="a16" commandName="Select" whenClientScript="this.hasDetails() &amp;&amp; this.get_usesTransaction()"/>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
          </xsl:choose>-->
          <action id="a1" commandName="Select" commandArgument="editForm1" />
          <action id="a2" commandName="Edit" />
          <action id="a3" commandName="Delete"/>
          <!-- Actions a4 and a5 are legacy grid actions that are automatically attached to the first column in selected row in edit mode -->
          <!--
					<action id="a4" whenLastCommandName="Edit" commandName="Update" headerText="Save"/>
					<action id="a5" whenLastCommandName="Edit" commandName="Cancel" />
					-->
          <!--Enable this actions when mutliple selection is requested-->
          <!--<xsl:choose>
            <xsl:when test="$EnableTransactions='true'">
              <action id="a17" whenClientScript="!this.hasDetails() &amp;&amp; this.get_inTransaction()"/>
              <action id="a18" commandName="New" commandArgument="grid1" whenClientScript="!this.hasDetails() &amp;&amp; this.get_inTransaction()"/>
              <action id="a19" commandName="Duplicate" commandArgument="createForm1" whenClientScript="!this.hasDetails() &amp;&amp; this.get_inTransaction()"/>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
          </xsl:choose>-->
          <action id="a6"/>
          <action id="a7" commandName="New" commandArgument="grid1"/>
          <action id="a8" commandName="Duplicate" commandArgument="createForm1"/>
          <xsl:if test="$BatchEditEnabled='true'">
            <action id="a9"/>
            <action id="a10" commandName="BatchEdit" commandArgument="editForm1" />
          </xsl:if>
        </actionGroup>
        <actionGroup  id="ag2" scope="Form">
          <xsl:choose>
            <xsl:when test="$UseSaveAndNew='true'">
              <action id="a1" commandName="Edit"/>
              <action id="a2" commandName="Delete"/>
              <action id="a3" commandName="Cancel"/>
              <action id="a4" whenLastCommandName="Edit" commandName="Update" commandArgument="Save" />
              <action id="a5" whenLastCommandName="Edit" commandName="Cancel" />
              <action id="a6" whenLastCommandName="New" commandName="Insert" commandArgument="Save" />
              <action id="a7" whenLastCommandName="New" commandName="Insert" commandArgument="SaveAndNew" />
              <action id="a8" whenLastCommandName="New" commandName="Cancel" />
              <action id="a9" whenLastCommandName="Duplicate" commandName="Insert" />
              <action id="a10" whenLastCommandName="Duplicate" commandName="Cancel" />
              <action id="a13" whenLastCommandName="Insert" whenLastCommandArgument="Save" whenView="createForm1" commandName="Select" commandArgument="editForm1" whenClientScript="this.hasDetails()"/>
              <action id="a14" whenLastCommandName="Insert" whenLastCommandArgument="SaveAndNew" commandName="New" commandArgument="createForm1"/>
            </xsl:when>
            <xsl:otherwise>
              <action id="a1" commandName="Edit"/>
              <action id="a2" commandName="Delete"/>
              <action id="a3" commandName="Cancel"/>
              <action id="a4" whenLastCommandName="Edit" commandName="Update" />
              <action id="a5" whenLastCommandName="Edit" commandName="Delete" />
              <action id="a6" whenLastCommandName="Edit" commandName="Cancel" />
              <action id="a7" whenLastCommandName="New" commandName="Insert" />
              <action id="a8" whenLastCommandName="New" commandName="Cancel" />
              <action id="a9" whenLastCommandName="Duplicate" commandName="Insert" />
              <action id="a10" whenLastCommandName="Duplicate" commandName="Cancel" />
              <action id="a13" whenLastCommandName="Insert" whenView="createForm1" commandName="Select" commandArgument="editForm1" whenKeySelected="true" whenClientScript="this.hasDetails()"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="@name='SiteContent'">
            <action id="a15" commandName="Navigate" commandArgument="~/appservices/saas/{{FileName}}?storeToken=true&amp;start=%2Fpages%2Fsite-content" whenClientScript="$row.Path=='sys/saas'" />
          </xsl:if>
        </actionGroup>
        <actionGroup  id="ag3" scope="ActionBar" headerText="New" flat="true">
          <!--<xsl:choose>
            <xsl:when test="$EnableTransactions='true'">
              <action id="a1" commandName="New" commandArgument="createForm1" cssClass="NewIcon" whenClientScript="!this.hasDetails() &amp;&amp; this.get_inTransaction() || !this.get_usesTransaction()"/>
              <action id="a2" commandName="Navigate" cssClass="NewIcon" headerText="New" whenClientScript="this.hasDetails() &amp;&amp; this.get_usesTransaction()">
                <xsl:attribute name="commandArgument">
                  <xsl:text>?_controller=</xsl:text>
                  <xsl:value-of select="@name"/>
                  <xsl:text>&amp;_commandName=New&amp;_commandArgument=createForm1&amp;_transaction=true</xsl:text>
                </xsl:attribute>
              </action>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
          </xsl:choose>-->
          <action id="a1" commandName="New" commandArgument="createForm1" cssClass="NewIcon"/>
        </actionGroup>
        <actionGroup id="ag4" scope="ActionBar" headerText="Edit/Delete" flat="true">
          <!--<xsl:choose>
            <xsl:when test="$EnableTransactions='true'">
              <action id="a1" whenKeySelected="true" commandName="Edit" commandArgument="editForm1" cssClass="EditIcon" whenView="grid1" whenClientScript="!this.get_usesTransaction()"/>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
          </xsl:choose>-->
          <action id="a1" whenKeySelected="true" commandName="Edit" commandArgument="editForm1" cssClass="EditIcon" whenView="grid1"/>
          <action id="a2" whenKeySelected="true" commandName="Delete" cssClass="DeleteIcon" whenView="grid1"/>
        </actionGroup>
        <actionGroup  id="ag5" scope="ActionBar" headerText="Actions">
          <action id="a1" commandName="ExportCsv" />
          <action id="a2" />
          <action id="a3" commandName="ExportRowset" />
          <action id="a4" commandName="ExportRss" />
          <!--<xsl:if test="$FactoryEnabled='false'">
            <action id="a5" />
            <action id="a6" commandName="Custom" commandArgument="MyCommand" headerText="My Command" description="Execute my custom command" />
          </xsl:if>-->
          <xsl:if test="$IsPremium='true' and not($ReadOnlyObject='true')">
            <action id="a5"/>
            <!--<xsl:if test="not($AzureFactory='true' or $SharePointFactory='true')">-->
            <action id="a6" commandName="Import" commandArgument="createForm1"/>
            <!--</xsl:if>-->
          </xsl:if>
          <xsl:if test="$IsPremium='true'">
            <action id="a7" commandName="DataSheet"/>
            <action id="a8" commandName="Grid"/>
          </xsl:if>
        </actionGroup>
        <actionGroup  id="ag6" scope="ActionBar" headerText="Record">
          <action id="a1" whenLastCommandName="Edit" commandName="Update" />
          <action id="a2" whenLastCommandName="Edit" commandName="Cancel" />
          <action id="a3" whenLastCommandName="New" commandName="Insert" />
          <action id="a4" whenLastCommandName="New" commandName="Cancel"  />
        </actionGroup>
        <xsl:if test="$ReportsEnabled='true'">
          <actionGroup id="ag7" scope="ActionBar" headerText="Report">
            <action id="a1" commandName="ReportAsPdf"/>
            <action id="a2" commandName="ReportAsImage"/>
            <action id="a3" commandName="ReportAsExcel"/>
            <xsl:if test="$TargetFramework!='3.5'">
              <action id="a4" commandName="ReportAsWord"/>
            </xsl:if>
            <!--<xsl:if test="$FactoryEnabled='false'">
              <action id="a4" />
              <action id="a5" commandName="Report"/>
            </xsl:if>-->
          </actionGroup>
        </xsl:if>
        <actionGroup id="ag8" scope="Row">
          <action id="a4" whenLastCommandName="Edit" commandName="Update" />
          <action id="a5" whenLastCommandName="Edit" commandName="Cancel" />
          <action id="a6" whenLastCommandName="New" commandName="Insert"/>
          <action id="a7" whenLastCommandName="New" commandName="Cancel"/>
        </actionGroup>
        <xsl:if test="$ActionColumn='true'">
          <actionGroup id="ag9" scope="ActionColumn">
            <action id="a1" commandName="Edit" commandArgument="editForm1"/>
            <action id="a2" commandName="Delete"/>
          </actionGroup>
        </xsl:if>
      </xsl:element>
      <xsl:if test="@name='SiteContent'">
        <businessRules>
          <rule id="r100" commandName="New" type="JavaScript" phase="Execute">
            <![CDATA[
$app.cms.new();
this.preventDefault()
    ]]>
          </rule>
          <rule id="r101" commandName="Edit|Select" type="JavaScript" phase="Before" view="grid1" commandArgument="editForm1">
            <![CDATA[
if ($app.cms.edit($row))
    this.preventDefault();
]]>
          </rule>
        </businessRules>
      </xsl:if>
    </dataController>
  </xsl:template>

  <xsl:template match="bo:field">
    <field>
      <xsl:apply-templates select="@*[name()!='nativeDataType' and name()!='sourceBusinessObject' and name()!='textMode']"/>
      <xsl:if test="@isPrimaryKey='true' and starts-with(@type, 'Int')">
        <xsl:if test="$RequiresNextSequence='true'">
          <xsl:attribute name="calculated">
            <xsl:text>true</xsl:text>
          </xsl:attribute>
          <codeDefault>
            <xsl:text>SqlText.NextSequenceValue("</xsl:text>
            <xsl:value-of select="ancestor::bo:businessObject/@nativeTableName"/>
            <xsl:text>_SEQ")</xsl:text>
          </codeDefault>
        </xsl:if>
        <xsl:if test="$RequiresNextGenerator='true' and @generator">
          <xsl:attribute name="calculated">
            <xsl:text>true</xsl:text>
          </xsl:attribute>
          <codeDefault>
            <xsl:text>SqlText.NextGeneratorValue("</xsl:text>
            <xsl:value-of select="@generator"/>
            <xsl:text>")</xsl:text>
          </codeDefault>
        </xsl:if>
      </xsl:if>
      <xsl:if test="@computed='true'">
        <formula>
          <xsl:copy-of select="bo:formula/text()"/>
        </formula>
      </xsl:if>
      <xsl:apply-templates select="bo:*[name()!='formula']"/>
    </field>
  </xsl:template>

  <xsl:template match="bo:dataField">
    <!--
~/Pages/Suppliers.aspx?SupplierID={SupplierID}&amp;_controller=Suppliers&amp;_commandName=Select&amp;_commandArgument=editForm1	-->
    <dataField>
      <xsl:apply-templates select="@*"/>
      <xsl:variable name="Field" select="ancestor::bo:businessObject[1]/bo:fields/bo:field[@name=current()/@fieldName]"/>
      <xsl:if test="$Field[@isPrimaryKey='true' and ($RequiresNextSequence='true' or $RequiresNextGenerator='true') and starts-with(@type, 'Int') or bo:items/@style='OneToOne']">
        <xsl:attribute name="hidden">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$IsPremium='true' and $RelationshipExplorer='true'">
        <xsl:variable name="View" select="ancestor::bo:view[1]"/>
        <xsl:if test="@aliasFieldName and ($View/@id != 'grid1' or position()>1)">
          <xsl:variable name="MasterObject" select="//bo:businessObject[@name=$Field/bo:items/@businessObject]"/>
          <xsl:if test="$Field[bo:items/@style='Lookup'] and not($View/@id='createForm1')">
            <xsl:attribute name="hyperlinkFormatString">
              <xsl:choose>
                <xsl:when test="$PageImplementation='html'">
                  <xsl:text>~/pages/</xsl:text>
                  <xsl:value-of select="$MasterObject/@name"/>
                  <xsl:text>?</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>~/Pages/</xsl:text>
                  <xsl:value-of select="$MasterObject/@name"/>
                  <xsl:text>.aspx?</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:for-each select="$MasterObject/bo:fields/bo:field[@isPrimaryKey='true']">
                <xsl:if test="position()>1">
                  <xsl:text>&amp;</xsl:text>
                </xsl:if>
                <xsl:value-of select="@name"/>
                <xsl:text>={</xsl:text>
                <xsl:choose>
                  <xsl:when test="position()=1">
                    <xsl:value-of select="$Field/@name"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="@name"/>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text>}</xsl:text>
              </xsl:for-each>
              <xsl:text>&amp;_controller=</xsl:text>
              <xsl:value-of select="$MasterObject/@name"/>
              <xsl:text>&amp;_command=Select&amp;_argument=editForm1</xsl:text>
            </xsl:attribute>
          </xsl:if>
        </xsl:if>
      </xsl:if>
      <xsl:apply-templates select="bo:*"/>
    </dataField>
  </xsl:template>

  <xsl:template match="@businessObject">
    <xsl:attribute name="dataController">
      <xsl:value-of select="."/>
    </xsl:attribute>
    <xsl:if test="parent::*/@style!='OneToOne'">
      <xsl:attribute name="newDataView">
        <xsl:text>createForm1</xsl:text>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="$SearchOnStartInLookups='true'">
      <xsl:attribute name="searchOnStart">
        <xsl:text>true</xsl:text>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="node()">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@* | node() | text()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="text()[parent::bo:text or parent::bo:headerText or parent::bo:description or parent::bo:rule]">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>
