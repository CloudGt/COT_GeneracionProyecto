<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ontime="urn:codeontime:csharp" exclude-result-prefixes="msxsl ontime">
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="Keys"/>
  <xsl:param name="IncludeViews" select="'true'"/>
  <xsl:param name="DatabaseObjectFilter" select="''"/>

  <!-- GetSchema Documentation https://docs.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqldatareader.getschematable?redirectedfrom=MSDN&view=netframework-4.8#System_Data_SqlClient_SqlDataReader_GetSchemaTable-->

  <xsl:key name="SqlServerColumns" match="/MetaData[@Provider='System.Data.SqlClient']/Columns/DocumentElement/Columns" use="concat(TABLE_SCHEMA, '.', TABLE_NAME)"/>
  <xsl:key name="DataTypesKey" match="/MetaData/DataTypesCollection/DocumentElement/DataTypes" use="TypeName"/>
  <xsl:key name="SqlServerColumnsEx" match="/MetaData[@Provider='System.Data.SqlClient']/TableSchemas/Table/DocumentElement/Column" use="concat(parent::DocumentElement/parent::Table/@Schema, '.', parent::DocumentElement/parent::Table/@Name, '.', ColumnName)"/>
  <xsl:key name="SqlServerPrimaryKeyColumns" match="/MetaData[@Provider='System.Data.SqlClient']/PrimaryKeyColumns/DocumentElement/PrimaryKeyColumns" use="concat(TABLE_SCHEMA, '.', TABLE_NAME)"/>
  <xsl:key name="SqlServerForeignKeys" match="/MetaData[@Provider='System.Data.SqlClient']/ForeignKeyReferences/DocumentElement/ForeignKeyReferences" use="concat(TABLE_SCHEMA, '.', TABLE_NAME)"/>
  <xsl:key name="SqlServerForeignKeyColumns" match="/MetaData[@Provider='System.Data.SqlClient']/ForeignKeyColumns/DocumentElement/ForeignKeyColumns" use="concat(TABLE_SCHEMA, '.', TABLE_NAME, '.', CONSTRAINT_NAME)"/>
  <xsl:key name="OraColumnsKey" match="/MetaData[@Provider='System.Data.OracleClient' or @Provider='Oracle.DataAccess.Client' or @Provider='Oracle.ManagedDataAccess.Client']/ColumnsCollection/DocumentElement/Columns" use="concat(OWNER, '.', TABLE_NAME, '.', COLUMN_NAME)"/>
  <xsl:key name="MySqlColumnsKey" match="/MetaData[@Provider='MySql.Data.MySqlClient']/ColumnsCollection/DocumentElement/Columns" use="concat(TABLE_SCHEMA, '.', TABLE_NAME, '.', COLUMN_NAME)"/>
  <xsl:variable name="DataSourceInformation" select="/MetaData/DataSourceInformationCollection/DocumentElement/DataSourceInformation"/>

  <!-- SqlAnyWhere -->
  <xsl:key name="SqlAnyWherePrimaryKeyIndexes" match="/MetaData[@Provider='iAnywhere.Data.SQLAnywhere']/IndexesCollection/DocumentElement/Indexes[PRIMARY_KEY='Y']" use="TABLE_NAME"/>
  <xsl:key name="SqlAnyWherePrimaryKeyColumns" match="/MetaData[@Provider='iAnywhere.Data.SQLAnywhere']/IndexColumnsCollection/DocumentElement/IndexColumns" use="INDEX_NAME"/>

  <!--Access2007-->
  <xsl:key name="OleDbDataTypesKey" match="/MetaData/DataTypesCollection/DocumentElement/DataTypes" use="NativeDataType"/>

  <!--DB2-->
  <xsl:key name="DB2DataTypesKey" match="/MetaData/DataTypesCollection/DocumentElement/DataTypes" use="SQL_TYPE_NAME"/>
  <xsl:key name="DB2ColumnsKey" match="/MetaData[@Provider='IBM.Data.DB2']/ColumnsCollection/DocumentElement/Columns" use="COLUMN_NAME"/>

  <!--Postgre-->
  <xsl:key name="NpgsqlColumnsKey" match="/MetaData[@Provider='Npgsql']/ColumnsCollection/DocumentElement/Columns" use="column_name"/>

  <!--Firebird-->
  <xsl:key name="FirebirdColumnsKey" match="/MetaData[@Provider='FirebirdSql.Data.FirebirdClient']/ColumnsCollection/DocumentElement/Columns" use="COLUMN_NAME"/>

  <!--
		Sample relationships:

		foreign key dbo.Products(SupplierID) 
		references dbo.Suppliers(SupplierID)

		foreign key dbo.Orders(CustomerID)
		references dbo.Customers(CustomerID)

		foreign key dbo.Order Details(OrderID)
		references dbo.Orders(OrderID)

		foreign key dbo.Order Details(ProductID)
		references dbo.Products(ProductID)


		<foreignKey parentTableSchema="dbo" parentTableName="CustomerDemographics">
			<foreignKeyColumn columnName="customerTypeID" parentColumnName="CustomerTypeID" />
		</foreignKey>
		<foreignKey parentTableSchema="dbo" parentTableName="Customers">
			<foreignKeyColumn columnName="CustomerID" parentColumnName="CustomerID" />
		</foreignKey>
-->
  <msxsl:script language="C#" implements-prefix="ontime">
    <![CDATA[
		private System.Collections.Generic.SortedDictionary<string, System.Collections.Generic.List<string>> _foreignKeys = new System.Collections.Generic.SortedDictionary<string, System.Collections.Generic.List<string>>();
		
		private System.Collections.Generic.SortedDictionary<string, string> _databaseObjectFilter = new System.Collections.Generic.SortedDictionary<string, string>();
		
		public bool ParseKeys(string keys) {
			Match fk = Regex.Match(keys, @"foreign\s+key\s+(?'ChildSchema'.+?)\.(?'ChildTable'.+?)\s*\((?'ChildFields'.+?)\)\s+references\s+(?'ParentSchema'.+?)\.(?'ParentTable'.+?)\s*\((?'ParentFields'.+?)\)", RegexOptions.IgnoreCase);
			while (fk.Success) {
					string childSchema = fk.Groups["ChildSchema"].Value;    
					string childTable = fk.Groups["ChildTable"].Value;    
					string[] childFields = fk.Groups["ChildFields"].Value.Split(',');
					string parentSchema = fk.Groups["ParentSchema"].Value;
					string parentTable = fk.Groups["ParentTable"].Value;
					string[] parentFields = fk.Groups["ParentFields"].Value.Split(',');
					
					if (childFields.Length == parentFields.Length) {
							StringBuilder sb = new StringBuilder();
							XmlWriter writer = XmlWriter.Create(sb);
							writer.WriteStartElement("foreignKey");
							writer.WriteAttributeString("parentTableSchema", parentSchema.Trim());
							writer.WriteAttributeString("parentTableName", parentTable.Trim());
							writer.WriteAttributeString("force", "true");
							for (int i = 0; i < childFields.Length; i++) {
								writer.WriteStartElement("foreignKeyColumn");
								writer.WriteAttributeString("columnName", childFields[i].Trim());
								writer.WriteAttributeString("parentColumnName", parentFields[i].Trim());
								writer.WriteEndElement();
							}
							writer.WriteEndElement(); // foreignKey
							writer.Close();
							
							string childTableName = childSchema + "." + childTable;
							System.Collections.Generic.List<string> foreignKeys = null;
							
							if (!_foreignKeys.TryGetValue(childTableName, out foreignKeys)) {
									foreignKeys = new System.Collections.Generic.List<string>();
									_foreignKeys.Add(childTableName, foreignKeys);
							}
							string s = sb.ToString();
							foreignKeys.Add(s.Substring(s.IndexOf("<foreignKey")));
					}
					
					fk = fk.NextMatch();
			}
			
			return true;
		}
		
		public XPathNavigator GetForeignKeys(string table){
			StringBuilder key = new StringBuilder("<foreignKeys>");
			System.Collections.Generic.List<string> foreignKeys = new System.Collections.Generic.List<string>();
			if (_foreignKeys.TryGetValue(table, out foreignKeys)) {
				foreach (string s in foreignKeys)
					key.Append(s);
			}
			key.Append("</foreignKeys>");
			XPathDocument doc = new XPathDocument(new System.IO.StringReader(key.ToString()));
			return doc.CreateNavigator();
		}
		
		public string ToUpper(string s) {
			return s.ToUpper();
		}
		
		public bool AllowDatabaseObject(string schema, string name)
		{
		  if (_databaseObjectFilter.Count == 0) return true;
      return _databaseObjectFilter.ContainsKey(String.Format("{0}.{1}", schema, name));
		}
    
		public bool AllowDatabaseObject(string name)
		{
		  if (_databaseObjectFilter.Count == 0) 
        return true;
        
      return _databaseObjectFilter.ContainsKey(name);
		}
    
    public bool InitializeDatabaseObjectFilter(string filter)
		{
		  if (filter == null) filter = String.Empty;
      string[] items = filter.Split(';');
      foreach (string item in items)
        if (!String.IsNullOrEmpty(item) && !_databaseObjectFilter.ContainsKey(item))
          _databaseObjectFilter.Add(item, item);
      return true;
		}
    
    public bool IsBitSet(long x, int bit)
    {
      Int64 power = Convert.ToInt64(Math.Pow(2.0, Convert.ToDouble(bit)));
      return (x & power) == power;
    }
	]]>
  </msxsl:script>

  <xsl:variable name="Dummy01" select="ontime:ParseKeys($Keys)"/>
  <xsl:variable name="Dummy02" select="ontime:InitializeDatabaseObjectFilter($DatabaseObjectFilter)"/>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Empty Project -->
  <xsl:template match="MetaData[@Provider='CodeOnTime.CustomDataProvider']">
    <dataModel nameMaxLength="1024" parameterMarker="@" quote="&quot;"/>
  </xsl:template>

  <!-- SQL Server -->

  <xsl:template match="MetaData[@Provider='System.Data.SqlClient']">
    <dataModel nameMaxLength="{$DataSourceInformation/ParameterNameMaxLength}" parameterMarker="{substring($DataSourceInformation/ParameterMarkerPattern, 1, 1)}" quote="&quot;">
      <xsl:apply-templates select="Tables/DocumentElement/Tables[(TABLE_TYPE='BASE TABLE' or TABLE_TYPE='VIEW' and $IncludeViews='true') and ontime:AllowDatabaseObject(TABLE_SCHEMA, TABLE_NAME)]">
        <xsl:sort select="concat(TABLE_SCHEMA, '.', TABLE_NAME)"/>
      </xsl:apply-templates>
    </dataModel>
  </xsl:template>

  <xsl:template match="Tables[TABLE_TYPE='BASE TABLE']">
    <xsl:variable name="TableKey" select="concat(TABLE_SCHEMA, '.', TABLE_NAME)"/>
    <table name="{TABLE_NAME}"  schema="{TABLE_SCHEMA}" >
      <columns>
        <xsl:apply-templates select="key('SqlServerColumns', $TableKey)">
          <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
        </xsl:apply-templates>
      </columns>
      <primaryKey>
        <xsl:apply-templates select="key('SqlServerPrimaryKeyColumns', $TableKey)">
          <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
        </xsl:apply-templates>
        <!--<xsl:if test="not(key('SqlServerPrimaryKeyColumns', $TableKey))">
          <primaryKeyColumn columnName="{key('SqlServerColumns', $TableKey)[1]/COLUMN_NAME}"/>
        </xsl:if>-->
      </primaryKey>
      <xsl:variable name="FK" select="ontime:GetForeignKeys($TableKey)"/>
      <xsl:if test="key('SqlServerForeignKeys', $TableKey) or $FK">
        <foreignKeys>
          <xsl:apply-templates select="key('SqlServerForeignKeys', $TableKey)">
            <xsl:with-param name="ExplicitForeignKeys" select="$FK"/>
          </xsl:apply-templates>
          <xsl:for-each select="$FK/foreignKeys/foreignKey">
            <xsl:copy-of select="."/>
          </xsl:for-each>
        </foreignKeys>
      </xsl:if>
    </table>
  </xsl:template>

  <xsl:template match="Tables[TABLE_TYPE='VIEW']">
    <xsl:variable name="TableKey" select="concat(TABLE_SCHEMA, '.', TABLE_NAME)"/>
    <table name="{TABLE_NAME}"  schema="{TABLE_SCHEMA}" >
      <columns>
        <xsl:apply-templates select="key('SqlServerColumns', $TableKey)">
          <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
        </xsl:apply-templates>
      </columns>
    </table>
  </xsl:template>

  <xsl:template match="Columns">
    <column name="{COLUMN_NAME}" type="{DATA_TYPE}">
      <xsl:if test="CHARACTER_MAXIMUM_LENGTH and CHARACTER_MAXIMUM_LENGTH != '-1'">
        <xsl:attribute name="length">
          <xsl:value-of select="CHARACTER_MAXIMUM_LENGTH"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="DATA_TYPE='time' and DATETIME_PRECISION">
        <xsl:attribute name="length">
          <xsl:value-of select="DATETIME_PRECISION"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="IS_NULLABLE='NO'">
        <xsl:attribute name="allowNulls">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="COLUMN_DEFAULT">
        <xsl:attribute name="default">
          <xsl:value-of select="COLUMN_DEFAULT"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:variable name="Column" select="key('SqlServerColumnsEx', concat(TABLE_SCHEMA, '.', TABLE_NAME, '.', COLUMN_NAME))"/>
      <xsl:if test="$Column/IsIdentity='true'">
        <xsl:attribute name="identity">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$Column/IsReadOnly='true'">
        <xsl:attribute name="readOnly">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$Column/IsExpression='true'">
        <xsl:attribute name="computed">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:variable name="DataType" select="key('DataTypesKey', DATA_TYPE)"/>
      <xsl:if test="($DataType/IsLong='true' or ($DataType/ColumnSize and number($DataType/ColumnSize)>4000)) and (not(CHARACTER_MAXIMUM_LENGTH and CHARACTER_MAXIMUM_LENGTH &lt; 2000) or CHARACTER_MAXIMUM_LENGTH=-1)">
        <xsl:attribute name="onDemand">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$DataType/IsSearchable='false' or DATA_TYPE='hierarchyid' or DATA_TYPE='geography' or DATA_TYPE='timestamp'">
        <xsl:attribute name="allowQBE">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <!--<xsl:if test="$DataType/IsSearchableWithLike='false'">
				<xsl:attribute name="allowQuery">
					<xsl:text>false</xsl:text>
				</xsl:attribute>
			</xsl:if>-->
      <xsl:if test="DATA_TYPE='geography'">
        <xsl:attribute name="allowSorting">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="dataType">
        <xsl:choose>
          <xsl:when test="DATA_TYPE='hierarchyid'">
            <xsl:text>String</xsl:text>
          </xsl:when>
          <xsl:when test="DATA_TYPE='geography'">
            <xsl:text>String</xsl:text>
          </xsl:when>
          <xsl:when test="DATA_TYPE='tinyint'">
            <xsl:text>Byte</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring-after($DataType/DataType, '.')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </column>
  </xsl:template>

  <xsl:template match="PrimaryKeyColumns">
    <primaryKeyColumn columnName="{COLUMN_NAME}"/>
  </xsl:template>

  <xsl:template match="ForeignKeyReferences">
    <xsl:param name="ExplicitForeignKeys"/>
    <xsl:if test="not($ExplicitForeignKeys/foreignKeys/foreignKey[@parentTableSchema=current()/REFERENCED_TABLE_SCHEMA and @parentTableName=current()/REFERENCED_TABLE_NAME]) and ontime:AllowDatabaseObject(REFERENCED_TABLE_SCHEMA, REFERENCED_TABLE_NAME)">
      <foreignKey parentTableSchema="{REFERENCED_TABLE_SCHEMA}" parentTableName="{REFERENCED_TABLE_NAME}">
        <xsl:variable name="PrimaryKeyColumns" select="key('SqlServerPrimaryKeyColumns', concat(REFERENCED_TABLE_SCHEMA, '.', REFERENCED_TABLE_NAME))"/>
        <xsl:for-each select="key('SqlServerForeignKeyColumns', concat(TABLE_SCHEMA, '.', TABLE_NAME, '.', CONSTRAINT_NAME))">
          <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
          <xsl:variable name="ColumnIndex" select="position()"/>
          <foreignKeyColumn columnName="{COLUMN_NAME}" parentColumnName="{$PrimaryKeyColumns[$ColumnIndex=number(ORDINAL_POSITION)]/COLUMN_NAME}"/>
        </xsl:for-each>
      </foreignKey>
    </xsl:if>
  </xsl:template>

  <!-- ORA -->

  <xsl:template match="MetaData[@Provider='System.Data.OracleClient' or @Provider='Oracle.DataAccess.Client' or @Provider='Oracle.ManagedDataAccess.Client']">
    <dataModel nameMaxLength="{$DataSourceInformation/ParameterNameMaxLength}" parameterMarker="{substring($DataSourceInformation/ParameterMarkerPattern, 1, 1)}" quote="&quot;" provider="{@Provider}">
      <xsl:apply-templates select="TableSchemas/Table[ontime:AllowDatabaseObject(@Schema, @Name)]" mode="Oracle">
        <xsl:sort select="concat(Schema, '.', Name)"/>
      </xsl:apply-templates>
    </dataModel>
  </xsl:template>

  <xsl:template match="Table" mode="Oracle">
    <xsl:variable name="Table" select="."/>
    <xsl:variable name="TableKey" select="concat(@Schema, '.', @Name)"/>
    <table name="{@Name}" schema="{@Schema}">
      <columns>
        <xsl:for-each select="DocumentElement/Column">
          <xsl:sort select="ColumnOrdinal" data-type="number"/>
          <xsl:variable name="Column" select="key('OraColumnsKey', concat($TableKey, '.', ColumnName))"/>
          <xsl:variable name="DataType" select="key('DataTypesKey', $Column/DATATYPE)"/>
          <column name="{ColumnName}" type="{$Column/DATATYPE}">
            <xsl:if test="$DataType/IsFixedLength='false' and ColumnSize">
              <xsl:attribute name="length">
                <xsl:value-of select="ColumnSize"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="AllowDBNull='false'">
              <xsl:attribute name="allowNulls">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="IsExpression='true'">
              <xsl:attribute name="computed">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="dataType">
              <xsl:choose>
                <xsl:when test="$Column/DATATYPE = 'RAW' and $Column/LENGTH=16">
                  <xsl:text>Guid</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="substring-after(substring-before(DataType, ','), '.')"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:if test="($DataType/IsLong='true' or $DataType/ColumnSize and number($DataType/ColumnSize)>4000) and not(ColumnSize and ColumnSize &lt; 2000)">
              <xsl:attribute name="onDemand">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="$DataType/IsSearchable='false'">
              <xsl:attribute name="allowQBE">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
          </column>
        </xsl:for-each>
      </columns>

      <xsl:variable name="PkIndexName" select="/MetaData/PrimaryKeysCollection/DocumentElement/PrimaryKeys[OWNER=$Table/@Schema and TABLE_NAME=$Table/@Name]/INDEX_NAME"/>
      <xsl:variable name="PrimaryKeyColumns" select="/MetaData/IndexColumnsCollection/DocumentElement/IndexColumns[TABLE_OWNER=$Table/@Schema and TABLE_NAME=$Table/@Name and INDEX_NAME=$PkIndexName]"/>
      <xsl:if test="$PrimaryKeyColumns">
        <primaryKey>
          <xsl:for-each select="$PrimaryKeyColumns">
            <primaryKeyColumn columnName="{COLUMN_NAME}"/>
          </xsl:for-each>
        </primaryKey>
      </xsl:if>
      <foreignKeys>
        <xsl:for-each select="/MetaData/ForeignKeysCollection/DocumentElement/ForeignKeys[FOREIGN_KEY_OWNER=$Table/@Schema and FOREIGN_KEY_TABLE_NAME=$Table/@Name]">
          <xsl:variable name="ForeignKey" select="."/>
          <xsl:if test="ontime:AllowDatabaseObject(PRIMARY_KEY_OWNER, PRIMARY_KEY_TABLE_NAME)">
            <foreignKey parentTableSchema="{PRIMARY_KEY_OWNER}" parentTableName="{PRIMARY_KEY_TABLE_NAME}">
              <xsl:variable name="IndexName" select="/MetaData/PrimaryKeysCollection/DocumentElement/PrimaryKeys[OWNER=$ForeignKey/PRIMARY_KEY_OWNER and TABLE_NAME=$ForeignKey/PRIMARY_KEY_TABLE_NAME]/INDEX_NAME"/>
              <xsl:variable name="PrimaryKeyIndexColumns" select="/MetaData/IndexColumnsCollection/DocumentElement/IndexColumns[TABLE_OWNER=$ForeignKey/PRIMARY_KEY_OWNER and TABLE_NAME=$ForeignKey/PRIMARY_KEY_TABLE_NAME and INDEX_NAME=$IndexName]"/>
              <xsl:for-each select="/MetaData/ForeignKeyColumnsCollection/DocumentElement/ForeignKeyColumns[OWNER=$ForeignKey/FOREIGN_KEY_OWNER and CONSTRAINT_NAME=$ForeignKey/FOREIGN_KEY_CONSTRAINT_NAME]">
                <xsl:sort select="POSITION" data-type="number"/>
                <xsl:variable name="ColumnIndex" select="position()"/>
                <foreignKeyColumn columnName="{COLUMN_NAME}" parentColumnName="{$PrimaryKeyIndexColumns[$ColumnIndex]/COLUMN_NAME}"/>
              </xsl:for-each>
            </foreignKey>
          </xsl:if>
        </xsl:for-each>
        <xsl:variable name="FK" select="ontime:GetForeignKeys($TableKey)"/>
        <xsl:for-each select="$FK/foreignKeys/foreignKey">
          <xsl:copy-of select="."/>
        </xsl:for-each>
      </foreignKeys>
    </table>
  </xsl:template>

  <!-- DB2 -->

  <xsl:template match="MetaData[@Provider='IBM.Data.DB2']">
    <dataModel nameMaxLength="{$DataSourceInformation/ParameterNameMaxLength}" parameterMarker="{substring($DataSourceInformation/ParameterMarkerPattern, 1, 1)}" quote="&quot;" provider="{@Provider}">
      <xsl:variable name="Tables" select="/MetaData/TablesCollection/DocumentElement/Tables[TABLE_TYPE='TABLE' or TABLE_TYPE='VIEW' and not(starts-with(TABLE_SCHEMA, 'SYS'))]"/>
      <!--<xsl:apply-templates select="TableSchemas/Table[ontime:AllowDatabaseObject(@Schema, @Name) and not(starts-with(@Schema, 'SYS')) and $Tables[TABLE_SCHEMA=current()/@Schema and TABLE_NAME=current()/@Name]]" mode="DB2">
        <xsl:sort select="concat(Schema, '.', Name)"/>
      </xsl:apply-templates>-->
      <xsl:for-each select="TableSchemas/Table[ontime:AllowDatabaseObject(@Schema, @Name) and not(starts-with(@Schema, 'SYS'))]">
        <xsl:sort select="concat(Schema, '.', Name)"/>
        <xsl:if test="$Tables[TABLE_SCHEMA=current()/@Schema and TABLE_NAME=current()/@Name]">
          <xsl:apply-templates select="." mode="DB2"/>
        </xsl:if>
      </xsl:for-each>
    </dataModel>
  </xsl:template>

  <xsl:template match="Table" mode="DB2">
    <xsl:variable name="Table" select="."/>
    <xsl:variable name="TableKey" select="concat(@Schema, '.', @Name)"/>
    <table name="{@Name}" schema="{@Schema}">
      <columns>
        <xsl:for-each select="DocumentElement/Column">
          <xsl:sort select="ColumnOrdinal" data-type="number"/>
          <xsl:variable name="Column" select="key('DB2ColumnsKey', ColumnName)"/>
          <xsl:variable name="DataType" select="key('DB2DataTypesKey', $Column/DATA_TYPE_NAME)"/>
          <column name="{ColumnName}" type="{$Column/DATA_TYPE_NAME}">
            <xsl:if test="ColumnSize">
              <xsl:attribute name="length">
                <xsl:value-of select="ColumnSize"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="AllowDBNull='false'">
              <xsl:attribute name="allowNulls">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="IsAutoIncrement='true'">
              <xsl:attribute name="identity">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="IsReadOnly='true' or IsAutoIncrement='true'">
              <xsl:attribute name="readOnly">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="IsExpression='true'">
              <xsl:attribute name="computed">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="dataType">
              <xsl:choose>
                <xsl:when test="$Column/DATA_TYPE_NAME = 'RAW' and $Column/COLUMN_SIZE=16">
                  <xsl:text>Guid</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="substring-after(substring-before(DataType, ','), '.')"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:if test="(IsLong='true' or $DataType/COLUMN_SIZE and number($DataType/COLUMN_SIZE)>4000) and not(ColumnSize and ColumnSize &lt; 2000)">
              <xsl:attribute name="onDemand">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="$DataType/SEARCHABLE=0">
              <xsl:attribute name="allowQBE">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
          </column>
        </xsl:for-each>
      </columns>

      <xsl:variable name="PkIndexName" select="/MetaData/PrimaryKeysCollection/DocumentElement/PrimaryKeys[TABLE_SCHEMA=$Table/@Schema and TABLE_NAME=$Table/@Name]/INDEX_NAME"/>
      <xsl:variable name="PrimaryKeyColumns" select="/MetaData/IndexesCollection/DocumentElement/Indexes[TABLE_SCHEMA=$Table/@Schema and TABLE_NAME=$Table/@Name and INDEX_NAME=$PkIndexName]"/>

      <primaryKey>
        <xsl:for-each select="DocumentElement/Column[IsKey='true']">
          <primaryKeyColumn columnName="{ColumnName}"/>
        </xsl:for-each>
      </primaryKey>

      <foreignKeys>
        <xsl:for-each select="/MetaData/ForeignKeysCollection/DocumentElement/ForeignKeys[FKTABLE_SCHEMA=$Table/@Schema and FKTABLE_NAME=$Table/@Name]">
          <!--makes duplicates?-->
          <xsl:variable name="ForeignKey" select="."/>
          <xsl:variable name="Tables" select="/MetaData/TablesCollection/DocumentElement/Tables[TABLE_TYPE='TABLE' or TABLE_TYPE='VIEW' and not(starts-with(TABLE_SCHEMA, 'SYS'))]"/>
          <xsl:if test="ontime:AllowDatabaseObject(PKTABLE_SCHEMA, PKTABLE_NAME) and $Tables[TABLE_SCHEMA=$ForeignKey/PKTABLE_SCHEMA and TABLE_NAME=$ForeignKey/PKTABLE_NAME]">
            <foreignKey parentTableSchema="{PKTABLE_SCHEMA}" parentTableName="{PKTABLE_NAME}">
              <xsl:for-each select="/MetaData/ForeignKeysCollection/DocumentElement/ForeignKeys[FKTABLE_SCHEMA=$ForeignKey/FKTABLE_SCHEMA and FKTABLE_NAME=$ForeignKey/FKTABLE_NAME and FKCOLUMN_NAME=$ForeignKey/FKCOLUMN_NAME and PKTABLE_NAME=$ForeignKey/PKTABLE_NAME]">
                <!--PK_NAME=current()/PK_NAME old filter   This is finding duplicate foreign keys-->
                <xsl:sort select="KEY_SEQ" data-type="number"/>
                <foreignKeyColumn columnName="{FKCOLUMN_NAME}" parentColumnName="{PKCOLUMN_NAME}"/>
              </xsl:for-each>
            </foreignKey>
          </xsl:if>
        </xsl:for-each>
        <!--<xsl:variable name="FK" select="ontime:GetForeignKeys($TableKey)"/>            <== what is this for?
        <xsl:for-each select="$FK/foreignKeys/foreignKey">
          <xsl:copy-of select="."/>
        </xsl:for-each>-->
      </foreignKeys>
    </table>
  </xsl:template>

  <!-- PostgreSQL -->

  <xsl:template match="MetaData[@Provider='Npgsql']">
    <dataModel nameMaxLength="{$DataSourceInformation/ParameterNameMaxLength}" parameterMarker="{substring($DataSourceInformation/ParameterMarkerPattern, 1, 1)}" quote="&quot;" provider="{@Provider}">
      <xsl:variable name="Tables" select="/MetaData/TablesCollection/DocumentElement/Tables[table_type='BASE TABLE' or table_type='VIEW'] | /MetaData/ViewsCollection/DocumentElement/Views[table_schema!='dbo']"/>
      <!--<xsl:apply-templates select="TableSchemas/Table[ontime:AllowDatabaseObject(@Schema, @Name) and not(starts-with(@Schema, 'SYS')) and $Tables[TABLE_SCHEMA=current()/@Schema and TABLE_NAME=current()/@Name]]" mode="Npgsql">
        <xsl:sort select="concat(Schema, '.', Name)"/>
      </xsl:apply-templates>-->
      <xsl:for-each select="TableSchemas/Table[ontime:AllowDatabaseObject(@Schema, @Name) and not(starts-with(@Schema, 'pg_catalog'))]">
        <xsl:sort select="concat(@Schema, '.', @Name)"/>
        <xsl:if test="$Tables[table_schema=current()/@Schema and table_name=current()/@Name]">
          <xsl:apply-templates select="." mode="Npgsql"/>
        </xsl:if>
      </xsl:for-each>
    </dataModel>
  </xsl:template>

  <xsl:template match="Table" mode="Npgsql">
    <xsl:variable name="Table" select="."/>
    <xsl:variable name="TableKey" select="concat(@Schema, '.', @Name)"/>
    <table name="{@Name}" schema="{@Schema}">
      <columns>
        <xsl:for-each select="DocumentElement/Column">
          <xsl:sort select="ColumnOrdinal" data-type="number"/>
          <xsl:variable name="Column" select="key('NpgsqlColumnsKey', ColumnName)"/>
          <xsl:variable name="DataType" select="$Column/data_type"/>
          <column name="{ColumnName}" type="{$Column/data_type}">
            <xsl:choose>
              <xsl:when test="ColumnSize &gt; 0">
                <xsl:attribute name="length">
                  <xsl:value-of select="ColumnSize"/>
                </xsl:attribute>
              </xsl:when>
              <xsl:when test="$Column/character_maximum_length">
                <xsl:attribute name="length">
                  <xsl:value-of select="$Column/character_maximum_length"/>
                </xsl:attribute>
              </xsl:when>
              <xsl:when test="$Column/character_octet_length">
                <xsl:attribute name="length">
                  <xsl:value-of select="$Column/character_octet_length"/>
                </xsl:attribute>
              </xsl:when>
            </xsl:choose>

            <xsl:if test="AllowDBNull='false'">
              <xsl:attribute name="allowNulls">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="IsAutoIncrement='true'">
              <xsl:attribute name="identity">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="IsReadOnly='true' or IsAutoIncrement='true'">
              <xsl:attribute name="readOnly">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <!--<xsl:if test="IsExpression='true'">
              <xsl:attribute name="computed">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>-->
            <xsl:attribute name="dataType">
              <xsl:choose>
                <xsl:when test="$Column/data_type = 'RAW' and $Column/column_size=16">
                  <xsl:text>Guid</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="substring-after(substring-before(DataType, ','), '.')"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:if test="IsLong='true' or $Column/data_type='text'">
              <xsl:attribute name="onDemand">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="allowQBE">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
          </column>
        </xsl:for-each>
      </columns>

      <xsl:variable name="PkIndexName" select="/MetaData/PrimaryKeysCollection/DocumentElement/PrimaryKeys[TABLE_SCHEMA=$Table/@Schema and TABLE_NAME=$Table/@Name]/INDEX_NAME"/>
      <xsl:variable name="PrimaryKeyColumns" select="/MetaData/IndexesCollection/DocumentElement/Indexes[TABLE_SCHEMA=$Table/@Schema and TABLE_NAME=$Table/@Name and INDEX_NAME=$PkIndexName]"/>

      <primaryKey>
        <xsl:for-each select="DocumentElement/Column[IsKey='true']">
          <primaryKeyColumn columnName="{ColumnName}"/>
        </xsl:for-each>
      </primaryKey>

      <foreignKeys>
        <xsl:variable name="Tables" select="/MetaData/TablesCollection/DocumentElement/Tables[(table_type='BASE TABLE' or table_type='VIEW') and not(starts-with(table_schema, 'pg_'))]"/>
        <xsl:for-each select="/MetaData/ForeignKeysCollection/DocumentElement/ForeignKeys[TABLE_SCHEMA=$Table/@Schema and TABLE_NAME=$Table/@Name]">
          <xsl:variable name="ForeignKey" select="."/>
          <xsl:if test="ontime:AllowDatabaseObject(TABLE_SCHEMA, TABLE_NAME) and $Tables[table_schema=$ForeignKey/TABLE_SCHEMA and table_name=$ForeignKey/TABLE_NAME]">
            <xsl:variable name="ForeignKeyColumn" select="/MetaData/ForeignKeyColumns/DocumentElement/ForeignKeyColumns[constraint_catalog=$ForeignKey/CONSTRAINT_CATALOG and constraint_schema=$ForeignKey/CONSTRAINT_SCHEMA and constraint_name=$ForeignKey/CONSTRAINT_NAME]"/>
            <xsl:variable name="ParentPrimaryKeyColumns" select="/MetaData/TableSchemas/Table[@Name=$ForeignKeyColumn/pk_table_name]/DocumentElement/Column[IsKey='true']"/>
            <foreignKey parentTableSchema="{$ForeignKeyColumn/pk_table_schema}" parentTableName="{$ForeignKeyColumn/pk_table_name}">
              <xsl:for-each select="$ForeignKeyColumn[constraint_catalog=$ForeignKey/CONSTRAINT_CATALOG and constraint_schema=$ForeignKey/CONSTRAINT_SCHEMA and constraint_name=$ForeignKey/CONSTRAINT_NAME]">
                <xsl:sort select="ordinal_position" data-type="number"/>
                <xsl:variable name="ColumnIndex" select="position()"/>
                <foreignKeyColumn columnName="{$ForeignKeyColumn/column_name}" parentColumnName="{$ParentPrimaryKeyColumns[$ColumnIndex]/ColumnName}"/>
              </xsl:for-each>
            </foreignKey>
          </xsl:if>
        </xsl:for-each>
      </foreignKeys>
    </table>
  </xsl:template>

  <!-- MySql -->

  <xsl:template match="MetaData[@Provider='MySql.Data.MySqlClient']">
    <dataModel nameMaxLength="{$DataSourceInformation/ParameterNameMaxLength}" parameterMarker="@" quote="`" provider="{@Provider}">
      <xsl:apply-templates select="TableSchemas/Table[ontime:AllowDatabaseObject(@Schema, @Name)]" mode="MySql">
        <xsl:sort select="concat(Schema, '.', Name)"/>
      </xsl:apply-templates>
    </dataModel>
  </xsl:template>

  <xsl:template match="Table" mode="MySql">
    <xsl:variable name="Table" select="."/>
    <xsl:variable name="TableKey" select="concat(@Schema, '.', @Name)"/>
    <table name="{@Name}" schema="{@Schema}">
      <columns>
        <xsl:for-each select="DocumentElement/Column">
          <xsl:sort select="ORDINAL_POSITION"/>
          <xsl:variable name="Column" select="key('MySqlColumnsKey', concat($TableKey, '.', ColumnName))"/>
          <xsl:variable name="DataType" select="key('DataTypesKey', ontime:ToUpper($Column/DATA_TYPE))"/>
          <column name="{ColumnName}" type="{$DataType/TypeName}">
            <xsl:if test="$DataType/IsFixedLength='false' and ColumnSize">
              <xsl:attribute name="length">
                <xsl:value-of select="ColumnSize"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="AllowDBNull='false'">
              <xsl:attribute name="allowNulls">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="IsAutoIncrement='true'">
              <xsl:attribute name="identity">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="IsReadOnly='true' or IsAutoIncrement='true' or (IsKey='true' and ColumnSize=36)">
              <xsl:attribute name="readOnly">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <!--<xsl:if test="IsExpression='true'">
							<xsl:attribute name="computed">
								<xsl:text>true</xsl:text>
							</xsl:attribute>
						</xsl:if>-->
            <xsl:attribute name="dataType">
              <xsl:value-of select="substring-after(substring-before(DataType, ','), '.')"/>
            </xsl:attribute>
            <xsl:if test="($DataType/IsLong='true' or ($DataType/ColumnSize and number(ColumnSize)>4000) and not(ColumnSize and ColumnSize &lt; 2000))">
              <xsl:attribute name="onDemand">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="$DataType/IsSearchable='false'">
              <xsl:attribute name="allowQBE">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
          </column>
        </xsl:for-each>
      </columns>
      <primaryKey>
        <xsl:for-each select="DocumentElement/Column[IsKey='true']">
          <primaryKeyColumn columnName="{ColumnName}"/>
        </xsl:for-each>
      </primaryKey>
      <foreignKeys>
        <xsl:for-each select="/MetaData/ForeignKeysCollection/DocumentElement/ForeignKeys[table_schema=$Table/@Schema and table_name=$Table/@Name or TABLE_SCHEMA=$Table/@Schema and TABLE_NAME=$Table/@Name or table_schema=$Table/@Schema and TABLE_NAME=$Table/@Name or TABLE_SCHEMA=$Table/@Schema and table_name=$Table/@Name]">
          <xsl:variable name="ForeignKey" select="."/>
          <xsl:variable name="ReferencedTableSchema" select="referenced_table_schema | REFERENCED_TABLE_SCHEMA"/>
          <xsl:variable name="ReferencedTableName" select="referenced_table_name | REFERENCED_TABLE_NAME"/>
          <xsl:if test="ontime:AllowDatabaseObject($ReferencedTableSchema, $ReferencedTableName)">
            <foreignKey parentTableSchema="{$ReferencedTableSchema}" parentTableName="{$ReferencedTableName}">

              <xsl:for-each select="/MetaData/ForeignKeyColumnsCollection/DocumentElement/ForeignKeyColumns[CONSTRAINT_NAME=current()/constraint_name or CONSTRAINT_NAME=current()/CONSTRAINT_NAME]">
                <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
                <foreignKeyColumn columnName="{COLUMN_NAME}" parentColumnName="{REFERENCED_COLUMN_NAME}"/>
              </xsl:for-each>
            </foreignKey>
          </xsl:if>
        </xsl:for-each>
        <xsl:variable name="FK" select="ontime:GetForeignKeys($TableKey)"/>
        <xsl:for-each select="$FK/foreignKeys/foreignKey">
          <xsl:copy-of select="."/>
        </xsl:for-each>
      </foreignKeys>
    </table>
  </xsl:template>

  <!-- Firebird -->

  <xsl:template match="MetaData[@Provider='FirebirdSql.Data.FirebirdClient']">
    <dataModel nameMaxLength="{$DataSourceInformation/ParameterNameMaxLength}" parameterMarker="{substring($DataSourceInformation/ParameterMarkerPattern, 1, 1)}" quote="&quot;" provider="{@Provider}">
      <xsl:apply-templates select="TablesCollection/DocumentElement/Tables[ontime:AllowDatabaseObject(TABLE_NAME) and (TABLE_TYPE='TABLE' or (TABLE_TYPE='VIEW' and $IncludeViews='true'))]" mode="Firebird">
        <xsl:sort select="concat(OWNER_NAME, '.', TABLE_NAME)"/>
      </xsl:apply-templates>
    </dataModel>
  </xsl:template>

  <xsl:template match="Tables" mode="Firebird">
    <xsl:variable name="Table" select="."/>
    <xsl:variable name="TableKey" select="TABLE_NAME"/>
    <xsl:variable name="Columns" select="/MetaData/ColumnsCollection/DocumentElement/Columns"/>
    <xsl:variable name="PrimaryKeys" select="/MetaData/PrimaryKeysCollection/DocumentElement/PrimaryKeys"/>
    <table name="{TABLE_NAME}">
      <columns>
        <xsl:apply-templates select="$Columns[TABLE_NAME=$Table/TABLE_NAME]" mode="Firebird">
          <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
          <xsl:with-param name="TableKey" select="TABLE_NAME"/>
        </xsl:apply-templates>
      </columns>
      <primaryKey>
        <xsl:for-each select="$PrimaryKeys[TABLE_NAME=$TableKey]">
          <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
          <primaryKeyColumn columnName="{COLUMN_NAME}">
            <xsl:variable name="pkGenerator" select="/MetaData/GeneratorsCollection/DocumentElement/Generators[starts-with(GENERATOR_NAME, concat(current()/COLUMN_NAME, '_')) or starts-with(GENERATOR_NAME, concat($TableKey, '_'))]" />
            <xsl:if test="$pkGenerator">
              <xsl:attribute name="generator">
                <xsl:value-of select="$pkGenerator/GENERATOR_NAME"/>
              </xsl:attribute>
            </xsl:if>
          </primaryKeyColumn>
        </xsl:for-each>
      </primaryKey>
      <foreignKeys>
        <xsl:for-each select="/MetaData/ForeignKeysCollection/DocumentElement/ForeignKeys[TABLE_NAME=$TableKey]">
          <xsl:variable name="ForeignKey" select="."/>
          <xsl:if test="ontime:AllowDatabaseObject(referenced_table_schema | REFERENCED_TABLE_SCHEMA, referenced_table_name | REFERENCED_TABLE_NAME)">
            <foreignKey parentTableName="{referenced_table_name | REFERENCED_TABLE_NAME}">
              <xsl:for-each select="/MetaData/ForeignKeyColumnsCollection/DocumentElement/ForeignKeyColumns[CONSTRAINT_NAME=current()/CONSTRAINT_NAME]">
                <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
                <foreignKeyColumn columnName="{COLUMN_NAME}" parentColumnName="{REFERENCED_COLUMN_NAME}"/>
              </xsl:for-each>
            </foreignKey>
          </xsl:if>
        </xsl:for-each>
        <xsl:variable name="FK" select="ontime:GetForeignKeys($TableKey)"/>
        <xsl:for-each select="$FK/foreignKeys/foreignKey">
          <xsl:copy-of select="."/>
        </xsl:for-each>
      </foreignKeys>
    </table>
  </xsl:template>

  <xsl:template match="Columns" mode="Firebird">
    <xsl:variable name="TableKey"/>
    <!--<xsl:variable name="Column" select="key('FirebirdColumnsKey', concat($TableKey, '.', ColumnName))"/>-->
    <xsl:variable name="DataType" select="key('DataTypesKey', COLUMN_DATA_TYPE)"/>
    <column name="{COLUMN_NAME}" type="{$DataType/TypeName}">
      <xsl:if test="$DataType/IsFixedLength='false' and COLUMN_SIZE">
        <xsl:attribute name="length">
          <xsl:value-of select="COLUMN_SIZE"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="IS_NULLABLE='false'">
        <xsl:attribute name="allowNulls">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <!--<xsl:if test="IsAutoIncrement='true'">
        <xsl:attribute name="identity">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>-->
      <xsl:if test="IS_READONLY='true' or COMPUTED_SOURCE!=''">
        <xsl:attribute name="readOnly">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="COMPUTED_SOURCE!=''">
        <xsl:attribute name="computed">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="dataType">
        <xsl:value-of select="substring-after($DataType/DataType, '.')"/>
      </xsl:attribute>
      <xsl:if test="($DataType/IsLong='true' or $DataType/COLUMN_SIZE and number(COLUMN_SIZE)>4000) and not(COLUMN_SIZE and COLUMN_SIZE &lt; 2000)">
        <xsl:attribute name="onDemand">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$DataType/IsSearchable='false'">
        <xsl:attribute name="allowQBE">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
    </column>
  </xsl:template>

  <!-- SqlAnywhere -->
  <xsl:template match="MetaData[@Provider='iAnywhere.Data.SQLAnywhere']">
    <dataModel nameMaxLength="{$DataSourceInformation/ParameterNameMaxLength}" parameterMarker="@" quote="&quot;">
      <xsl:apply-templates select="TablesCollection/DocumentElement/Tables[ontime:AllowDatabaseObject(TABLE_SCHEMA, TABLE_NAME) and (TABLE_TYPE='BASE' or (TABLE_TYPE='VIEW' and $IncludeViews='true'))]" mode="SqlAnyWhere">
        <xsl:sort select="concat(TABLE_SCHEMA, '.', TABLE_NAME)"/>
      </xsl:apply-templates>
    </dataModel>
  </xsl:template>

  <!-- Tables -->
  <xsl:template match="Tables[TABLE_TYPE='BASE']" mode="SqlAnyWhere">
    <xsl:variable name="Table" select="."/>
    <xsl:variable name="Columns" select="/MetaData/ColumnsCollection/DocumentElement/Columns"/>

    <table name="{TABLE_NAME}" schema="{TABLE_SCHEMA}">
      <columns>
        <xsl:apply-templates select="$Columns[TABLE_NAME=$Table/TABLE_NAME and TABLE_SCHEMA=$Table/TABLE_SCHEMA]" mode="SqlAnyWhere">
          <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
        </xsl:apply-templates>
      </columns>
      <primaryKey>
        <!-- get indexes marked as primary key -->
        <xsl:apply-templates select="key('SqlAnyWherePrimaryKeyIndexes', TABLE_NAME)[TABLE_SCHEMA=$Table/TABLE_SCHEMA]" mode="SqlAnyWhere">
        </xsl:apply-templates>
      </primaryKey>
      <foreignKeys>
        <xsl:for-each select="/MetaData[@Provider='iAnywhere.Data.SQLAnywhere']/ForeignKeysCollection/DocumentElement/ForeignKeysCollection[ForeignTableName=$Table/TABLE_NAME]">
          <xsl:variable name="ForeignKey" select="."/>
          <foreignKey>
            <xsl:attribute name="parentTableSchema">
              <xsl:value-of select="/MetaData[@Provider='iAnywhere.Data.SQLAnywhere']/TablesCollection/DocumentElement/Tables[TABLE_NAME=current()/PrimaryTableName]/TABLE_SCHEMA"/>
            </xsl:attribute>
            <xsl:attribute name="parentTableName">
              <xsl:value-of select="current()/PrimaryTableName"/>
            </xsl:attribute>
            <xsl:for-each select="/MetaData[@Provider='iAnywhere.Data.SQLAnywhere']/ForeignKeysColumnsCollection/DocumentElement/ForeignKeysColumnsCollection[ForeignTableName=$Table/TABLE_NAME and ForeignKeyId=$ForeignKey/ForeignKeyId]">
              <foreignKeyColumn>
                <xsl:attribute name="columnName">
                  <xsl:value-of select="current()/ForeignColumn"/>
                </xsl:attribute>
                <xsl:attribute name="parentColumnName">
                  <xsl:value-of select="current()/PrimaryColumn"/>
                </xsl:attribute>
              </foreignKeyColumn>
            </xsl:for-each>
          </foreignKey>
        </xsl:for-each>
      </foreignKeys>
    </table>
  </xsl:template>

  <!-- Views -->
  <xsl:template match="Tables[TABLE_TYPE='VIEW']" mode="SqlAnyWhere">
    <xsl:variable name="Table" select="."/>
    <xsl:variable name="Columns" select="/MetaData/ColumnsCollection/DocumentElement/Columns"/>

    <table name="{TABLE_NAME}" schema="{TABLE_SCHEMA}">
      <columns>
        <xsl:apply-templates select="$Columns[TABLE_NAME=$Table/TABLE_NAME and TABLE_SCHEMA=$Table/TABLE_SCHEMA]" mode="SqlAnyWhere">
          <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
        </xsl:apply-templates>
      </columns>
    </table>
  </xsl:template>

  <!-- get PK columns out of all known index columns -->
  <xsl:template match="Indexes" mode="SqlAnyWhere">
    <xsl:apply-templates select="key('SqlAnyWherePrimaryKeyColumns', current()/INDEX_NAME)[TABLE_SCHEMA=current()/TABLE_SCHEMA and TABLE_NAME=current()/TABLE_NAME]" mode="SqlAnyWhere">
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="IndexColumns" mode="SqlAnyWhere">
    <primaryKeyColumn>
      <xsl:attribute name="columnName">
        <xsl:value-of select="COLUMN_NAME"/>
      </xsl:attribute>
    </primaryKeyColumn>
  </xsl:template>

  <!-- Columns tamplate -->
  <xsl:template match="Columns" mode="SqlAnyWhere">
    <xsl:variable name="DataType" select="key('DataTypesKey', DATA_TYPE)"/>
    <column name="{COLUMN_NAME}" type="{DATA_TYPE}">
      <xsl:if test="IS_NULLABLE='N'">
        <xsl:attribute name="allowNulls">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="dataType">
        <xsl:value-of select="substring-after($DataType/DataType, '.')"/>
      </xsl:attribute>
      <xsl:if test="CHARACTER_MAXIMUM_LENGTH">
        <xsl:attribute name="length">
          <xsl:value-of select="CHARACTER_MAXIMUM_LENGTH"></xsl:value-of>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="COLUMN_DEFAULT = 'autoincrement'">
        <xsl:attribute name="identity">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="readOnly">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <!-- TODO: This rule is not clear -->
      <xsl:if test="($DataType/IsLong='true' or ($DataType/ColumnSize and number($DataType/ColumnSize) &gt; 4000)) and not(CHARACTER_MAXIMUM_LENGTH and CHARACTER_MAXIMUM_LENGTH &lt; 2000)">
        <xsl:attribute name="onDemand">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$DataType/IsSearchable='false'">
        <xsl:attribute name="allowQBE">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
    </column>
  </xsl:template>

  <!-- Access2007 -->
  <xsl:template match="MetaData[dataModel]">
    <xsl:copy-of select="dataModel"/>
  </xsl:template>

  <!--<xsl:template match="MetaData[@Provider='System.Data.OleDb']">
    <dataModel nameMaxLength="{$DataSourceInformation/ParameterNameMaxLength}" parameterMarker="@" quote="'">
      <xsl:apply-templates select="TablesCollection/DocumentElement/Tables[ontime:AllowDatabaseObject(TABLE_NAME) and (TABLE_TYPE='TABLE' or (TABLE_TYPE='VIEW' and $IncludeViews='true'))]" mode="Access2007">
        <xsl:sort select="TABLE_NAME"/>
      </xsl:apply-templates>
    </dataModel>
  </xsl:template>-->

  <!-- Tables -->
  <!--
  <xsl:template match="Tables[TABLE_TYPE='TABLE']"  mode="Access2007">
    <xsl:variable name="Table" select="."/>
    <xsl:variable name="Columns" select="/MetaData/ColumnsCollection/DocumentElement/Columns"/>
    <xsl:variable name="Indexes" select="/MetaData/IndexesCollection/DocumentElement/Indexes"/>

    <table name="{TABLE_NAME}" schema="">
      <columns>
        <xsl:apply-templates select="$Columns[TABLE_NAME=$Table/TABLE_NAME]" mode="Access2007">
          <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
        </xsl:apply-templates>
      </columns>
      <primaryKey>
        <xsl:apply-templates select="$Indexes[TABLE_NAME=$Table/TABLE_NAME and PRIMARY_KEY='true']" mode="Access2007">
        </xsl:apply-templates>
      </primaryKey>
      <foreignKeys>
        <xsl:for-each select="/MetaData/ForeignKeysCollection/DocumentElement/ForeignKeys[FK_TABLE_NAME=$Table/TABLE_NAME]">
          <xsl:variable name="ForeignKey" select="."/>
          <foreignKey>
            <xsl:attribute name="parentTableSchema">
              <xsl:text></xsl:text>
            </xsl:attribute>
            <xsl:attribute name="parentTableName">
              <xsl:value-of select="$ForeignKey/FK_TABLE_NAME"/>
            </xsl:attribute>
            <xsl:for-each select="/MetaData/ForeignKeysColumnsCollection/DocumentElement/ForeignKeysColumns[FK_TABLE_NAME=$Table/TABLE_NAME and FK_NAME=$ForeignKey/FK_NAME]">
              <foreignKeyColumn>
                <xsl:attribute name="columnName">
                  <xsl:value-of select="FK_COLUMN_NAME"/>
                </xsl:attribute>
                <xsl:attribute name="parentColumnName">
                  <xsl:value-of select="PK_COLUMN_NAME"/>
                </xsl:attribute>
              </foreignKeyColumn>
            </xsl:for-each>
          </foreignKey>
        </xsl:for-each>
      </foreignKeys>

    </table>
  </xsl:template>

  -->
  <!-- Views -->
  <!--
  <xsl:template match="Tables[TABLE_TYPE='VIEW']"  mode="Access2007">
    <xsl:variable name="Table" select="."/>
    <xsl:variable name="Columns" select="/MetaData/ColumnsCollection/DocumentElement/Columns"/>

    <table name="{TABLE_NAME}" schema="">
      <columns>
        <xsl:apply-templates select="$Columns[TABLE_NAME=$Table/TABLE_NAME]" mode="Access2007">
          <xsl:sort select="ORDINAL_POSITION" data-type="number"/>
        </xsl:apply-templates>
      </columns>
    </table>
  </xsl:template>

  -->
  <!-- Columns -->
  <!--
  <xsl:template match="Columns" mode="Access2007">
    <xsl:variable name="DataType" select="key('OleDbDataTypesKey', DATA_TYPE)"/>
    <column name="{COLUMN_NAME}">
      <xsl:if test="IS_NULLABLE='true'">
        <xsl:attribute name="allowNulls">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="type">
        <xsl:value-of select="$DataType/TypeName"/>
      </xsl:attribute>
      <xsl:attribute name="dataType">
        <xsl:value-of select="substring-after($DataType/DataType, '.')"/>
      </xsl:attribute>
      <xsl:if test="CHARACTER_MAXIMUM_LENGTH and CHARACTER_MAXIMUM_LENGTH > 0">
        <xsl:attribute name="length">
          <xsl:value-of select="CHARACTER_MAXIMUM_LENGTH"></xsl:value-of>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$DataType/IsSearchableWithLike='false'">
        <xsl:attribute name="allowQBE">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="ontime:IsBitSet(COLUMN_FLAGS, 5) = false()">
        <xsl:attribute name="identity">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="readOnly">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="($DataType/IsLong='true' or ($DataType/ColumnSize and number($DataType/ColumnSize) &gt; 4000)) and not(CHARACTER_MAXIMUM_LENGTH and CHARACTER_MAXIMUM_LENGTH &lt; 2000)">
        <xsl:attribute name="onDemand">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$DataType/IsSearchable='false'">
        <xsl:attribute name="allowQBE">
          <xsl:text>false</xsl:text>
        </xsl:attribute>
      </xsl:if>
    </column>
  </xsl:template>

  -->
  <!-- Columne name -->
  <!--
  <xsl:template match="Indexes" mode="Access2007">
    <primaryKeyColumn>
      <xsl:attribute name="columnName">
        <xsl:value-of select="COLUMN_NAME"/>
      </xsl:attribute>
    </primaryKeyColumn>

  </xsl:template>-->

</xsl:stylesheet>