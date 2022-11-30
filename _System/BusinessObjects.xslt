<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="ontime msxsl bo"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="urn:schemas-codeontime-com:business-objects"
    xmlns:bo="urn:schemas-codeontime-com:business-objects"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:ontime="urn:schemas-codeontime-com:xslt"
   >
  <xsl:param name="AllowBlobSupport" select="'false'"/>
  <xsl:param name="DiscoveryDepth" select="3"/>
  <xsl:param name="LabelFormatExpression"/>
  <xsl:param name="FieldsToIgnore"/>
  <xsl:param name="FieldsToHide"/>
  <xsl:param name="CustomLabels"/>
  <xsl:param name="FieldMap"/>
  <xsl:param name="DetectUnderscoreSeparatedSchema" select="'false'"/>
  <xsl:param name="AllowBlobUploadOnInsert" select="'false'"/>


  <xsl:variable name="IgnoreFieldNames" select="concat(';', ontime:RegexReplace($FieldsToIgnore, '(\s+)', ';'), ';')"/>
  <xsl:variable name="HideFieldNames" select="concat(';', ontime:RegexReplace($FieldsToHide, '(\s+)', ';'), ';')"/>
  <xsl:variable name="CustomLabelMap" select="concat(';', ontime:RegexReplace($CustomLabels, '(\s*?\n+\s*)', ';'), ';')"/>

  <xsl:output indent="yes" method="xml" cdata-section-elements="bo:text bo:data"/>

  <!--
  <xsl:param name="Context" select="/dataModel/table[@name='Resolutions']"/>
  <xsl:param name="Schema" select="$Context/@schema"/>
  <xsl:param name="Name" select="$Context/@name"/>
  -->
  <xsl:param name="Context" select="/dataModel/table"/>
  <xsl:param name="Schema" select="''"/>
  <xsl:param name="Name" select="''"/>

  <xsl:param name="MaxNumberOfDataFieldsInGridView" select="10"/>

  <msxsl:script language="CSharp" implements-prefix="ontime">
    <![CDATA[
        private System.Collections.Generic.SortedDictionary<string, string> _nameDictionary = new System.Collections.Generic.SortedDictionary<string, string>();
        private int _nameMaxLength = -1;
        
        public string InitializeVariables(XPathNodeIterator iterator)
        {
            if (iterator.MoveNext())
            {
               _nameMaxLength = Convert.ToInt32(iterator.Current.Evaluate("number(/dataModel/@nameMaxLength)"));
            }
            return "ok";
        }
                
        public string ValidateName(XPathNodeIterator iterator)
        {
            string name = ValidateName(iterator, _nameMaxLength);
            //if (name.StartsWith("_"))
            //  name = "n" + name;
            if (name.Length > 0 && !Char.IsLetter(name[0]))
              name =  "n" + name;
            return name;
        }
        
        public string ValidateName(XPathNodeIterator iterator, int maxLength)
        {
					if (iterator.MoveNext())
							if (iterator.Current.Value.Length > maxLength)
							{
									if (_nameDictionary.ContainsKey(iterator.Current.Value)) return (string)_nameDictionary[iterator.Current.Value];
									string alias = iterator.Current.Value.Replace("_", "");
									if (alias.Length > maxLength)
											alias = System.Text.RegularExpressions.Regex.Replace(iterator.Current.Value, @"[AEIOUYEaeiouy]", "", RegexOptions.Compiled);
									if (alias.Length > maxLength)
											alias = "n" + _nameDictionary.Count.ToString() + "_";
                  try {
									  _nameDictionary.Add(iterator.Current.Value, alias);
                  }
                  catch (Exception) {
                  }
									return alias;
							}
							else
									return iterator.Current.Value;
					return "ValidateName_Error";
        }
        
		public string Replace(XPathNodeIterator iterator, string pattern, string result)
		{
 			if (iterator.MoveNext()) {
				//return System.Text.RegularExpressions.Regex.Match(iterator.Current.Value, pattern, System.Text.RegularExpressions.RegexOptions.IgnoreCase | RegexOptions.Compiled).Result(result);
				return System.Text.RegularExpressions.Regex.Replace(iterator.Current.Value, pattern, result, System.Text.RegularExpressions.RegexOptions.IgnoreCase | RegexOptions.Compiled);
		  }
			return "Replace-Error";
		}
		public string RegexReplace(XPathNodeIterator iterator, string pattern, string result){
			if (iterator.MoveNext())
				return System.Text.RegularExpressions.Regex.Replace(iterator.Current.Value, pattern, result, System.Text.RegularExpressions.RegexOptions.IgnoreCase | RegexOptions.Compiled);
			return "Replace-Error";
		}
		public bool IsMatch(XPathNodeIterator iterator, string pattern)
		{
			if (iterator.MoveNext())
				return System.Text.RegularExpressions.Regex.IsMatch(iterator.Current.Value, pattern);
			return false;
		}
		public string CleanIdentifier(XPathNodeIterator iterator)
		{
			if (iterator.MoveNext()) {
				string s = System.Text.RegularExpressions.Regex.Replace(iterator.Current.Value, @"[^\w]", "");
				double n;
				if (Double.TryParse(s, out n))
					return "n" + s;
				return s;
		  }
			return "CleanIdentifier-Error";
		}
		public string DoReplaceFormatExpression(System.Text.RegularExpressions.Match m) {
		    return m.Groups["Text"].Value;
		}
		public string FormatAsLabel(XPathNodeIterator iterator, string formatExpression)
		{
			if (iterator.MoveNext())
          return InternalFormatAsLabel(iterator.Current.Value, formatExpression);
			return "FormatAsLabel-Error";
		}
    
        private string InternalFormatAsLabel(string labelText, string formatExpression)
        {
            string label = null;
            //string lastMatch = null;
            string text = labelText;
            if (!String.IsNullOrEmpty(formatExpression))
            {
                try
                {
                    text = System.Text.RegularExpressions.Regex.Replace(text, formatExpression, DoReplaceFormatExpression, RegexOptions.Compiled | RegexOptions.IgnoreCase);
                }
                catch (Exception)
                {
                }
            }
            bool isCamel = System.Text.RegularExpressions.Regex.IsMatch(text, @"[a-z]") && System.Text.RegularExpressions.Regex.IsMatch(text, @"[A-Z]", RegexOptions.Compiled);
            System.Text.RegularExpressions.Match m = System.Text.RegularExpressions.Regex.Match(text, @"_*((([\p{Lu}\d]+)(?![\p{Ll}]))|[\p{Ll}\d]+|([\p{Lu}][\p{Ll}\d]+))", RegexOptions.Compiled);
            System.Collections.Generic.List<string> words = new System.Collections.Generic.List<string>();
            while (m.Success)
            {
                string word = m.Groups[1].Value;
                if (!isCamel && System.Text.RegularExpressions.Regex.IsMatch(word, @"^([\p{Lu}\d]+|[\p{Ll}\d]+)$$", RegexOptions.Compiled)) word = Char.ToUpper(word[0]) + word.Substring(1).ToLower();
                //if (word != lastMatch) label += (label != null ? " " : "") + word;
                //lastMatch = word;
                if (word != "The" || words.Count > 0)
                    words.Add(word);
                m = m.NextMatch();
            }
            if (words.Count > 1)
            {
                int offset = 0;
                while (offset < words.Count)
                {
                    int currentCount = words.Count;
                    Simplify(words, offset);
                    if (words.Count == currentCount)
                        offset++;
                }
                label = String.Empty;
                foreach (string w in words)
                {
                    if (label.Length > 0)
                        label += " ";
                    label += w;
                }
            }
            else if (words.Count == 1)
              label = words[0];

            if (label == null) return text;
            return label.EndsWith(" Id", StringComparison.OrdinalIgnoreCase) ? label.Substring(0, label.Length - 3) + "#" : label;
        }

        public bool CanSimplify(System.Collections.Generic.List<string> words, int count, int offset)
        {
            bool success = false;
            int index = 0;
            for (int c = 0; c < count; c++)
            {
                int index1 = offset + index + c;
                int index2 = offset + index + count + c;
                if (index2 >= words.Count)
                    break;
                if (words[index1] != words[index2])
                    break;
                if (c == count - 1)
                {
                    success = true;
                    break;
                }
            }
            return success;
        }

        public void Simplify(System.Collections.Generic.List<string> words, int offset)
        {
            if (CanSimplify(words, 4, offset))
                words.RemoveRange(offset, 4);
            else if (CanSimplify(words, 3, offset))
                words.RemoveRange(offset, 3);
            else if (CanSimplify(words, 2, offset))
                words.RemoveRange(offset, 2);
            else if (CanSimplify(words, 1, offset))
                words.RemoveRange(offset, 1);
        }        
        
		    public string ToLower(XPathNodeIterator iterator)
		    {
			    if (iterator.MoveNext())
			        return iterator.Current.Value.ToLower();
			    return "ToLower-Error";
		    }
		    private int _count;
		    public bool ResetIndex() {
			    _count = 1;
			    return true;
		    }
		    public int NextIndex() {
			    return _count++;
		    }
		
        public string GetSchema(string name, string nativeSchema, string detectUnderscoreSeparatedSchema)
        {
					if (nativeSchema != "dbo")
						return nativeSchema;
          if (detectUnderscoreSeparatedSchema != "true")
            return nativeSchema;
					Match m = Regex.Match(name, @"^(\w+?)_", RegexOptions.Compiled);
					if (m.Success) {
						return m.Groups[1].Value;
					}
					else 
						return nativeSchema;
        }
		
        public string GetSchemaAlias(string name, string nativeSchema, string aliases)
        {
					if (nativeSchema == "dbo") {
						Match m = Regex.Match(name, @"^(\w+?)_", RegexOptions.Compiled);
						if (m.Success)
							nativeSchema = m.Groups[1].Value;
					}
					Match m2 = Regex.Match(aliases, String.Format(@";{0}=(.+?);", nativeSchema), RegexOptions.Compiled);
					if (m2.Success)
							return m2.Groups[1].Value;
					return nativeSchema;
        }
        
        public string CustomizeLabel(string label, string labelMap)
        {
         label = label.Trim().Replace(" ", String.Empty);
					Match m = Regex.Match(labelMap, String.Format(@";{0}=(.+?);", Regex.Escape(label)), RegexOptions.Compiled);
					if (m.Success)
							return m.Groups[1].Value;
					return label;
        }
        private System.Collections.Generic.SortedDictionary<string, string> _fieldMap = new System.Collections.Generic.SortedDictionary<string, string>();
        
        private System.Collections.Generic.SortedDictionary<string, string> _oneToOne = new System.Collections.Generic.SortedDictionary<string, string>();
        
				public bool ParseFieldMap(string fieldMap)
				{
					Match m = Regex.Match(fieldMap + "\r\n", @"(((?'ChildSchema'\w+)\.(?'ChildName'.+?)\s*(?'Relationship'=|-)>\s*(?'ParentSchema'\w+).(?'ParentName'.+?)\s*?\n)(?'Fields'(([\w_ ]+?|\*)\s*(\n|$))+))", RegexOptions.Compiled);
					while (m.Success) {
							string relationship = m.Groups["Relationship"].Value;
              if (relationship == "-")
                _oneToOne[String.Format("{0}.{1}->{2}.{3}", m.Groups["ChildSchema"].Value, m.Groups["ChildName"].Value, m.Groups["ParentSchema"].Value, m.Groups["ParentName"].Value)] = String.Empty;
							Match f = Regex.Match(m.Groups["Fields"].Value, @"\s*(.+?)\s*(\n|$)", RegexOptions.Compiled);
							while (f.Success) {
                string fieldList = f.Groups[1].Value;
								string key = String.Format("{0}.{1}=>{2}.{3}:{4}", m.Groups["ChildSchema"].Value, m.Groups["ChildName"].Value, m.Groups["ParentSchema"].Value, m.Groups["ParentName"].Value, fieldList);
                if (fieldList.StartsWith("/*"))
                  continue;
                _fieldMap[key] = String.Empty;
                if (fieldList == "*")
                  break;
								f = f.NextMatch();
							}
							m = m.NextMatch();
					}
					//_fieldMap.Add("dbo.Products=>dbo.Suppliers:CompanyName", String.Empty);
					return false;
				}
        
				public bool AllowParentColumn(XPathNodeIterator column, XPathNodeIterator child/*, double depth*/) {
					if (_fieldMap.Count == 0) return false;
					if (child.MoveNext() && column.MoveNext()) {
						string childName = child.Current.GetAttribute("name", String.Empty);
						string childSchema = child.Current.GetAttribute("schema", String.Empty);
						
						XPathNavigator parent = column.Current.SelectSingleNode("ancestor::table[1]");
						
						string columnName = column.Current.GetAttribute("name", String.Empty);
						string parentName = parent.GetAttribute("name", String.Empty);
						string parentSchema = parent.GetAttribute("schema", String.Empty);
						
						string key = String.Format("{0}.{1}=>{2}.{3}:{4}", childSchema, childName, parentSchema, parentName, columnName);
            if (_fieldMap.ContainsKey(key))
              return true;
            string wildcardKey = String.Format("{0}.{1}=>{2}.{3}:*", childSchema, childName, parentSchema, parentName);
            if (_fieldMap.ContainsKey(wildcardKey)) {
                if (parent.SelectSingleNode(String.Format("primaryKey/primaryKeyColumn[@columnName='{0}']", columnName)) != null/* && depth == 0*/) 
                   return false;
                return true;
            }
					}
					return false;
				}
        
		]]>
  </msxsl:script>
  <xsl:variable name="Dummy1" select="ontime:InitializeVariables(.)"/>
  <xsl:variable name="Dummy2" select="ontime:ParseFieldMap($FieldMap)"/>
  <xsl:key name="TablesKey" match="/dataModel/table" use="concat(@schema,'.',@name)"/>
  <xsl:variable name="SchemaCount" select="count(/dataModel/table[not(preceding-sibling::table/@schema=@schema)])"/>
  <xsl:variable name="Quote" >
    <xsl:choose>
      <xsl:when test="not(contains(/dataModel/@quote, ','))">
        <xsl:value-of select="/dataModel/@quote"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring-before(/dataModel/@quote, ',')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="Quote2">
    <xsl:choose>
      <xsl:when test="not(contains(/dataModel/@quote, ','))">
        <xsl:value-of select="/dataModel/@quote"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring-after(/dataModel/@quote, ',')" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="$Schema='' or $Name=''">
        <businessObjectCollection parameterMarker="{/dataModel/@parameterMarker}" provider="{/dataModel/@provider}">
          <xsl:for-each select="/dataModel/table">
            <xsl:call-template name="Main">
              <xsl:with-param name="Schema" select="@schema"/>
              <xsl:with-param name="Name" select="@name"/>
            </xsl:call-template>
          </xsl:for-each>
        </businessObjectCollection>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="Main">
          <xsl:with-param name="Schema" select="$Schema"/>
          <xsl:with-param name="Name" select="$Name"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="Main">
    <xsl:param name="Schema"/>
    <xsl:param name="Name"/>
    <xsl:variable name="Table" select="key('TablesKey', concat($Schema, '.', $Name))"/>
    <xsl:variable name="FieldList">
      <xsl:call-template name="RenderInMode">
        <xsl:with-param name="Table" select="$Table"/>
        <xsl:with-param name="Mode" select="'Field'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="FieldListNodeSet" select="msxsl:node-set($FieldList)"/>
    <xsl:variable name="ViewName">
      <xsl:if test="$Table/@schema != 'dbo'">
        <xsl:value-of select="$Table/@schema"/>
      </xsl:if>
      <xsl:value-of select="$Table/@name"/>
    </xsl:variable>
    <xsl:variable name="ViewLabel">
      <xsl:variable name="Label">
        <xsl:if test="$Table/@schema != 'dbo' and $SchemaCount>1">
          <xsl:value-of select="ontime:CustomizeLabel($Table/@schema, $CustomLabelMap)"/>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="ontime:CustomizeLabel($Table/@name, $CustomLabelMap)"/>
      </xsl:variable>
      <xsl:value-of select="ontime:FormatAsLabel($Label,$LabelFormatExpression)"/>
    </xsl:variable>
    <xsl:variable name="ProviderName" select="/dataModel/@provider"/>
    <xsl:variable name="BaseFieldSet" select="$FieldListNodeSet/*[@isBase='true' and not(@isPrimaryKey='true' and not((@type='String' and not(contains($ProviderName, 'MySql') and @length='36')) or @type='DateTime' or @isForeignKey='true') or ((@onDemand='true' or (@type='Byte[]' and not(@onDemand='true'))) and $AllowBlobSupport='false') or @type='Guid' and @default='' or contains(ontime:ToLower(@name), 'password')) and not(contains($IgnoreFieldNames,concat(';',@name,';')))]"/>
    <xsl:variable name="AdditionalFieldSet" select="$FieldListNodeSet/*[not(@isBase='true' or preceding-sibling::*[1][@isBase='true' and @isForeignKey='true'] or contains(ontime:ToLower(@name), 'password'))]"/>
    <xsl:variable name="EditFieldSet" select="$FieldListNodeSet/*[@isBase='true' and not(@isPrimaryKey='true' and not((@type='String' and not(contains($ProviderName, 'MySql') and @length='36')) or @type='DateTime' or @isForeignKey='true') or ((@onDemand='true' or (@type='Byte[]' and not(@onDemand='true'))) and $AllowBlobSupport='false') or (@type='Guid' and @default!='')) and not(contains($IgnoreFieldNames,concat(';',@name,';')))]"/>
    <xsl:variable name="InsertFieldSet" select="$FieldListNodeSet/*[@isBase='true' and not(@readOnly='true' or  ($AllowBlobUploadOnInsert != 'true' and (@onDemand='true' or @type='Byte[]')) or (@type='Guid' and @default!='')) and not(contains($IgnoreFieldNames,concat(';',@name,';')))]"/>
    <xsl:variable name="InsertFieldSet2" select="$FieldListNodeSet/*[@isBase='true' and not(@readOnly='true' or ($AllowBlobUploadOnInsert != 'true' and (@onDemand='true' or @type='Byte[]')) or (@type='Guid' and @default!='')) and (contains($IgnoreFieldNames,concat(';',@name,';'))) and not(@default)]"/>
    <xsl:variable name="FirstRequiredField" select="$BaseFieldSet[@allowNulls='false'][1]/@name"/>
    <xsl:variable name="ControllerSchema">
      <xsl:choose>
        <xsl:when test="$Table/@schema='dbo' or $SchemaCount&lt;=1 or not($Table/@schema)">
          <xsl:text></xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="ontime:CleanIdentifier($Table/@schema)"/>
          <xsl:text>_</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <businessObject name="{$ControllerSchema}{ontime:CleanIdentifier($Table/@name)}" conflictDetection="overwriteChanges"
				label="{ontime:FormatAsLabel(ontime:CustomizeLabel($Table/@name, $CustomLabelMap), $LabelFormatExpression)}"
				nativeSchema="{$Table/@schema}"
				nativeTableName="{$Table/@name}"
				nativeSchemaLabel="{ontime:FormatAsLabel(ontime:CustomizeLabel($Table/@schema, $CustomLabelMap),'')}"
				surrogateSchema="{ontime:GetSchema($Table/@name, $Table/@schema, $DetectUnderscoreSeparatedSchema)}"
				surrogateSchemaLabel="{ontime:FormatAsLabel(ontime:CustomizeLabel(ontime:GetSchema($Table/@name, $Table/@schema, $DetectUnderscoreSeparatedSchema), $CustomLabelMap),'')}">
      <xsl:variable name="SQL">
        <xsl:call-template name="RenderInMode">
          <xsl:with-param name="Table" select="$Table"/>
          <xsl:with-param name="Mode" select="'SELECT'"/>
        </xsl:call-template>
        <xsl:call-template name="RenderInMode">
          <xsl:with-param name="Table" select="$Table"/>
          <xsl:with-param name="Mode" select="'FROM'"/>
        </xsl:call-template>
      </xsl:variable>
      <commands>
        <command id="command1" type="Text">
          <text>
            <xsl:value-of select="$SQL"/>
          </text>
        </command>
        <xsl:for-each select="$Table/columns/column[@identity='true']">
          <command id="{@name}IdentityCommand" type="Text" event="Inserted">
            <xsl:choose>
              <xsl:when test="/dataModel[contains(@provider, 'DB2')]">
                <text>SELECT IDENTITY_VAL_LOCAL() FROM SYSIBM.SYSDUMMY1</text>
              </xsl:when>
              <xsl:when test="/dataModel[contains(@provider, 'Npgsql')]">
                <text>select lastval()</text>
              </xsl:when>
              <xsl:otherwise>
                <text>select @@identity</text>
              </xsl:otherwise>
            </xsl:choose>
            <output>
              <fieldOutput fieldName="{@name}"/>
            </output>
          </command>
        </xsl:for-each>
        <xsl:for-each select="$Table/columns/column[@type='uniqueidentifier' and @name=$Table/primaryKey/primaryKeyColumn/@columnName and not(@name=$Table/foreignKeys/foreignKey/foreignKeyColumn/@columnName)]">
          <command id="{@name}UniqueIdentifierCommand" type="Text" event="Inserting">
            <text>select newid()</text>
            <output>
              <fieldOutput fieldName="{@name}"/>
            </output>
          </command>
        </xsl:for-each>
        <xsl:for-each select="$Table/columns/column[@type='RAW' and @length=16 and @name=$Table/primaryKey/primaryKeyColumn/@columnName and not(@name=$Table/foreignKeys/foreignKey/foreignKeyColumn/@columnName)]">
          <command id="{@name}UniqueIdentifierCommand" type="Text" event="Inserting">
            <text>select sys_guid() from dual</text>
            <output>
              <fieldOutput fieldName="{@name}"/>
            </output>
          </command>
        </xsl:for-each>
      </commands>
      <fields>
        <xsl:variable name="SummaryFields" select="$BaseFieldSet[position()&lt;=5]"/>
        <xsl:for-each select="$FieldListNodeSet/*">
          <field>
            <xsl:for-each select="attribute::*">
              <xsl:if test="not(name()='isBase' or name()='isForeignKey' or name()='isMoney' or name()='multiLine' or (name()='length' and (.>=65535 or parent::*/@type!='String')))">
                <xsl:copy-of select="."/>
              </xsl:if>
            </xsl:for-each>
            <xsl:if test="$SummaryFields/@name=@name">
              <xsl:attribute name="showInSummary">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="child::*"/>
          </field>
        </xsl:for-each>
      </fields>
      <views>
        <!-- grid view -->
        <view id="grid1" type="Grid" commandId="command1">
          <xsl:attribute name="label">
            <xsl:value-of select="ontime:FormatAsLabel(ontime:CustomizeLabel($Table/@name, $CustomLabelMap), $LabelFormatExpression)"/>
          </xsl:attribute>
          <headerText>
            <xsl:text>$DefaultGridViewDescription</xsl:text>
            <!--<xsl:text>This is a list of </xsl:text>
						<xsl:value-of select="ontime:ToLower($ViewLabel)"/>
						<xsl:if test="not(ontime:IsMatch($ViewName,'s$')) or ontime:IsMatch($ViewName, 'ss$')">
							<xsl:text> records</xsl:text>
						</xsl:if>
						<xsl:text>. </xsl:text>-->
          </headerText>
          <dataFields>
            <xsl:call-template name="RenderDataFields">
              <xsl:with-param name="FieldList" select="$BaseFieldSet[@name=$FirstRequiredField]"/>
              <xsl:with-param name="Count" select="count($FirstRequiredField)"/>
            </xsl:call-template>
            <xsl:call-template name="RenderDataFields">
              <xsl:with-param name="FieldList" select="$BaseFieldSet[not(@name=$FirstRequiredField)]"/>
              <xsl:with-param name="Count" select="$MaxNumberOfDataFieldsInGridView - count($FirstRequiredField)"/>
            </xsl:call-template>
            <xsl:call-template name="RenderDataFields">
              <xsl:with-param name="FieldList" select="$AdditionalFieldSet"/>
              <xsl:with-param name="Count" select="$MaxNumberOfDataFieldsInGridView - count($BaseFieldSet)"/>
            </xsl:call-template>
          </dataFields>
        </view>
        <!-- "edit" form view -->
        <view id="createForm1" type="Form" commandId="command1" label="Modificar {$ViewLabel}">
          <headerText>
            <xsl:text>$DefaultEditViewDescription</xsl:text>
            <!--<xsl:text>Please review </xsl:text>
						<xsl:value-of select="ontime:ToLower($ViewLabel)"/>
						<xsl:text> information below. Click Edit to change this record, click Delete to delete the record, or click Cancel/Close to return back.</xsl:text>-->
          </headerText>
          <categories>
            <category id="c1" headerText="{$ViewLabel}">
              <description>
                <xsl:text>$DefaultEditDescription</xsl:text>
                <!--<xsl:text>These are the fields of the </xsl:text>
								<xsl:value-of select="ontime:ToLower($ViewLabel)"/>
								<xsl:text> record that can be edited.</xsl:text>-->
              </description>
              <dataFields>
                <xsl:call-template name="RenderDataFields">
                  <xsl:with-param name="FieldList" select="$EditFieldSet"/>
                  <xsl:with-param name="Count" select="count($EditFieldSet)"/>
                  <xsl:with-param name="Table" select="$Table"/>
                  <xsl:with-param name="AllFields" select="$FieldListNodeSet/*"/>
                </xsl:call-template>
              </dataFields>
            </category>
            <xsl:if test="$AdditionalFieldSet">
              <category id="c2" headerText="Reference Information">
                <description>
                  <xsl:text>$DefaultReferenceDescription</xsl:text>
                  <!--<xsl:text>Additional details about </xsl:text>
									<xsl:value-of select="ontime:ToLower($ViewLabel)"/>
									<xsl:text> are provided in the reference information section.</xsl:text>-->
                </description>
                <dataFields>
                  <xsl:call-template name="RenderDataFields">
                    <xsl:with-param name="FieldList" select="$AdditionalFieldSet"/>
                    <xsl:with-param name="Count" select="count($AdditionalFieldSet)"/>
                  </xsl:call-template>
                </dataFields>
              </category>
            </xsl:if>
          </categories>
        </view>
        <view id="createForm1" type="Form" commandId="command1" label="Crear {$ViewLabel}">
          <headerText>
            <xsl:text>$DefaultCreateViewDescription</xsl:text>
            <!--<xsl:text>Please fill this form and click OK button to create a new </xsl:text>
						<xsl:value-of select="ontime:ToLower($ViewLabel)"/>
						<xsl:text> record. Click Cancel to return to the previous screen.</xsl:text>-->
          </headerText>
          <categories>
            <category id="c1" headerText="New {$ViewLabel}">
              <description>
                <xsl:text>$DefaultNewDescription</xsl:text>
                <!--<xsl:text>Complete the form. Make sure to enter all required fields.</xsl:text>-->
              </description>
              <dataFields>
                <xsl:call-template name="RenderDataFields">
                  <xsl:with-param name="FieldList" select="$InsertFieldSet"/>
                  <xsl:with-param name="Count" select="count($InsertFieldSet)"/>
                  <xsl:with-param name="Table" select="$Table"/>
                  <xsl:with-param name="AllFields" select="$FieldListNodeSet/*"/>
                </xsl:call-template>
                <xsl:call-template name="RenderDataFields">
                  <xsl:with-param name="FieldList" select="$InsertFieldSet2"/>
                  <xsl:with-param name="Count" select="count($InsertFieldSet2)"/>
                  <xsl:with-param name="Table" select="$Table"/>
                  <xsl:with-param name="AllFields" select="$FieldListNodeSet/*"/>
                </xsl:call-template>
              </dataFields>
            </category>
          </categories>
        </view>
      </views>
    </businessObject>
  </xsl:template>

  <xsl:template name="RenderDataFields">
    <xsl:param name="FieldList"/>
    <xsl:param name="Count"/>
    <xsl:param name="Table"/>
    <xsl:param name="AllFields"/>
    <xsl:for-each select="$FieldList[position()&lt;=$Count]">
      <dataField fieldName="{@name}">
        <xsl:if test="contains($HideFieldNames,concat(';',@name,';'))">
          <xsl:attribute name="hidden">
            <xsl:text>true</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@isMoney='true'">
          <xsl:attribute name="dataFormatString">
            <xsl:text>c</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@type='DateTime' and contains(ontime:ToLower(@name), 'time')">
          <xsl:attribute name="dataFormatString">
            <xsl:text>t</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="@isForeignKey='true'">
            <xsl:if test="$DiscoveryDepth>0">
              <xsl:attribute name="aliasFieldName">
                <xsl:value-of select="following::*[1]/@name"/>
              </xsl:attribute>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="@type='String'">
                <xsl:if test="@length&lt;=50 and not(@multiLine='true')">
                  <xsl:attribute name="columns">
                    <xsl:value-of select="@length"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="@multiLine='true'">
                  <xsl:attribute name="rows">
                    <xsl:text>5</xsl:text>
                  </xsl:attribute>
                </xsl:if>
              </xsl:when>
              <xsl:when test="@type='DateTime'">
                <xsl:attribute name="columns">
                  <xsl:text>10</xsl:text>
                </xsl:attribute>
              </xsl:when>
              <xsl:when test="@type='Boolean'"></xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="columns">
                  <xsl:text>15</xsl:text>
                </xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:variable name="Self" select="."/>
        <xsl:if test="@isForeignKey='true' and $AllFields">
          <xsl:if test="$DiscoveryDepth>0">
            <xsl:attribute name="aliasFieldName">
              <xsl:value-of select="$AllFields[@name=$Self/@name]/following-sibling::*[1]/@name"/>
            </xsl:attribute>
          </xsl:if>
        </xsl:if>
        <xsl:if test="@isForeignKey='true' and $Table">
          <xsl:variable name="ForeignKey" select="$Table/foreignKeys/foreignKey[foreignKeyColumn/@columnName=$Self/@name]"/>
        </xsl:if>
      </dataField>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="RenderInMode">
    <xsl:param name="Table"/>
    <xsl:param name="Mode"/>
    <xsl:for-each select="$Table/columns/column">
      <xsl:call-template name="RenderField">
        <xsl:with-param name="Mode" select="$Mode"/>
        <xsl:with-param name="Depth" select="0"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="RenderField">
    <xsl:param name="Mode" select="'Field'"/>
    <xsl:param name="Prefix" select="''"/>
    <xsl:param name="ReadOnly" select="'false'"/>
    <xsl:param name="TableIDList"/>
    <xsl:param name="ChildTableAlias" select="ontime:CleanIdentifier(ancestor::table[1]/@name)"/>
    <xsl:param name="ChildForeignKey"/>
    <xsl:param name="Depth"/>
    <xsl:param name="OneToOne"/>
    <xsl:choose>
      <xsl:when test="$Mode='Field'">
        <xsl:variable name="Table" select="ancestor::table[1]"/>
        <xsl:variable name="Self" select="."/>
        <xsl:variable name="FieldName" select="ontime:ValidateName(concat(ontime:ValidateName($Prefix), ontime:CleanIdentifier(@name)))"/>
        <xsl:variable name="ForeignKey" select="$Table/foreignKeys/foreignKey[foreignKeyColumn/@columnName=$Self/@name]"/>
        <xsl:if test="not($Depth &gt; 0 and ($ForeignKey and $Table) and $OneToOne)">
          <field name="{$FieldName}" type="{@dataType}">
            <xsl:if test="$ReadOnly='false' and @allowNulls='false'">
              <xsl:attribute name="allowNulls">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="$Depth = 0 and $Table/primaryKey/primaryKeyColumn/@columnName=@name">
              <xsl:attribute name="isPrimaryKey">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
              <xsl:if test="$Table/primaryKey/primaryKeyColumn/@generator">
                <xsl:attribute name="generator">
                  <xsl:value-of select="$Table/primaryKey/primaryKeyColumn/@generator"/>
                </xsl:attribute>
              </xsl:if>
            </xsl:if>
            <xsl:if test="(@readOnly='true' or $ReadOnly='true')">
              <xsl:attribute name="readOnly">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="$OneToOne" >
              <xsl:attribute name="oneToOne">
                <xsl:value-of select="ontime:ValidateName(ontime:CleanIdentifier(@name))"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:choose>
              <!-- special processing for Oracle unique identity columns defined as raw(16) -->
              <xsl:when test="@type='RAW' and @length=16 and not($Table/foreignKeys/foreignKey/foreignKeyColumn/@columnName=@name)">
                <xsl:attribute name="default">
                  <xsl:text>sys_guid()</xsl:text>
                </xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="$ReadOnly='false' and @default">
                  <xsl:attribute name="default">
                    <xsl:value-of select="@default"/>
                  </xsl:attribute>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="$ReadOnly='false'">
              <xsl:attribute name="isBase">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="$ForeignKey">
              <xsl:attribute name="isForeignKey">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@onDemand='true' and (@dataType!='String' or @type='xml')">
              <xsl:attribute name="onDemand">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
              <xsl:if test="$AllowBlobSupport='true'">
                <xsl:attribute name="sourceFields">
                  <xsl:for-each select="$Table/primaryKey/primaryKeyColumn">
                    <xsl:if test="position()>1">
                      <xsl:text>,</xsl:text>
                    </xsl:if>
                    <xsl:value-of select="@columnName"/>
                  </xsl:for-each>
                </xsl:attribute>
                <xsl:attribute name="onDemandHandler">
                  <xsl:value-of select="concat(ontime:CleanIdentifier($Table/@name), $FieldName)"/>
                </xsl:attribute>
                <xsl:variable name="LoweredName" select="ontime:ToLower(@name)"/>
                <xsl:attribute name="onDemandStyle">
                  <xsl:choose>
                    <xsl:when test="contains($LoweredName, 'photo') or contains($LoweredName,'image') or contains($LoweredName, 'picture') or @type='image' or (@type='varbinary' and not(@length)) or contains(@type, 'BLOB')">
                      <xsl:text>Thumbnail</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>Link</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
              </xsl:if>
            </xsl:if>
            <xsl:if test="@onDemand='true' and @dataType='String'">
              <xsl:attribute name="multiLine">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@onDemand='true' or @allowQBE='false'">
              <xsl:attribute name="allowQBE">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@onDemand='true' or @allowSorting='false'">
              <xsl:attribute name="allowSorting">
                <xsl:text>false</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="label">
              <xsl:value-of select="ontime:FormatAsLabel(ontime:CustomizeLabel(concat($Prefix,' ', @name), $CustomLabelMap), $LabelFormatExpression)"/>
            </xsl:attribute>
            <xsl:if test="@type='money'">
              <xsl:attribute name="isMoney">
                <xsl:text>true</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="@readOnly"/>
            <xsl:copy-of select="@length"/>
            <xsl:attribute name="nativeDataType">
              <xsl:value-of select="@type"/>
              <xsl:if test="@length&lt;100000 and @length>0">
                <xsl:text>(</xsl:text>
                <xsl:value-of select="@length"/>
                <xsl:text>)</xsl:text>
              </xsl:if>
            </xsl:attribute>
            <xsl:if test="$ForeignKey and $Table">
              <items>
                <xsl:attribute name="style">
                  <xsl:choose>
                    <xsl:when test="$OneToOne">
                      <xsl:text>OneToOne</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>Lookup</xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="businessObject">
                  <xsl:if test="($ForeignKey/@parentTableSchema!='dbo' and $ForeignKey/@parentTableSchema!='') and $SchemaCount>1">
                    <xsl:value-of select="ontime:CleanIdentifier($ForeignKey/@parentTableSchema)"/>
                    <xsl:text>_</xsl:text>
                  </xsl:if>
                  <xsl:value-of select="ontime:CleanIdentifier($ForeignKey/@parentTableName)"/>
                </xsl:attribute>
                <xsl:if test="count($ForeignKey/foreignKeyColumn)>1">
                  <xsl:attribute name="dataValueField">
                    <xsl:for-each select="$ForeignKey/foreignKeyColumn">
                      <xsl:if test="position()>1">
                        <xsl:text>,</xsl:text>
                      </xsl:if>
                      <xsl:value-of select="@parentColumnName"/>
                    </xsl:for-each>
                  </xsl:attribute>
                </xsl:if>
              </items>
            </xsl:if>
          </field>
        </xsl:if>
      </xsl:when>
      <!-- Render SELECT expression -->
      <xsl:when test="$Mode='SELECT'">
        <xsl:if test="position()=1 and $ReadOnly='false'">
          <xsl:text>&#13;&#10;</xsl:text>
          <xsl:text>select&#13;&#10;</xsl:text>
        </xsl:if>
        <xsl:text>&#9;</xsl:text>
        <xsl:if test="not(position()=1 and $ReadOnly='false')">
          <xsl:text>,</xsl:text>
        </xsl:if>
        <!--<xsl:text>"</xsl:text>-->
        <xsl:value-of select="$Quote"/>
        <xsl:choose>
          <xsl:when test="$Prefix=''">
            <xsl:value-of select="ontime:ValidateName($ChildTableAlias)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="ontime:ValidateName($Prefix)"/>
          </xsl:otherwise>
        </xsl:choose>
        <!--<xsl:text>"."</xsl:text>-->
        <xsl:value-of select="$Quote2"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$Quote"/>
        <xsl:value-of select="@name"/>
        <!--<xsl:text>" "</xsl:text>-->
        <xsl:value-of select="$Quote2"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$Quote"/>
        <xsl:variable name="OutputPrefix" select="ontime:ValidateName($Prefix)"/>
        <xsl:value-of select="ontime:ValidateName(concat($OutputPrefix, ontime:CleanIdentifier(@name)))"/>
        <!--<xsl:text>"</xsl:text>-->
        <xsl:value-of select="$Quote2"/>
        <xsl:text>&#13;&#10;</xsl:text>
      </xsl:when>
      <!-- Render FROM expression -->
      <xsl:when test="$Mode='FROM'">
        <xsl:if test="position()=1">
          <xsl:variable name="Table" select="ancestor::table[1]"/>
          <xsl:choose>
            <xsl:when test="$ReadOnly='false'">
              <!--<xsl:text>from "</xsl:text>-->
              <xsl:text>from </xsl:text>
              <xsl:if test="$Table/@schema!=''">
                <xsl:value-of select="$Quote"/>
                <xsl:value-of select="$Table/@schema"/>
                <!--<xsl:text>"."</xsl:text>-->
                <xsl:value-of select="$Quote2"/>
                <xsl:text>.</xsl:text>
              </xsl:if>
              <xsl:value-of select="$Quote"/>
              <xsl:value-of select="$Table/@name"/>
              <!--<xsl:text>" "</xsl:text>-->
              <xsl:value-of select="$Quote2"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="$Quote"/>
              <xsl:value-of select="ontime:ValidateName($ChildTableAlias)"/>
              <!--<xsl:text>"&#13;&#10;</xsl:text>-->
              <xsl:value-of select="$Quote2"/>
              <xsl:text>&#13;&#10;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <!--<xsl:text>&#9;left join "</xsl:text>-->
              <xsl:text>&#9;left join </xsl:text>
              <xsl:if test="$Table/@schema!=''">
                <xsl:value-of select="$Quote"/>
                <xsl:value-of select="$Table/@schema"/>
                <!--<xsl:text>"."</xsl:text>-->
                <xsl:value-of select="$Quote2"/>
                <xsl:text>.</xsl:text>
              </xsl:if>
              <xsl:value-of select="$Quote"/>
              <xsl:value-of select="$Table/@name"/>
              <!--<xsl:text>" "</xsl:text>-->
              <xsl:value-of select="$Quote2"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="$Quote"/>
              <xsl:value-of select="ontime:ValidateName($Prefix)"/>
              <!--<xsl:text>" on </xsl:text>-->
              <xsl:value-of select="$Quote2"/>
              <xsl:text> on </xsl:text>
              <xsl:for-each select="$ChildForeignKey/foreignKeyColumn">
                <xsl:if test="position() > 1">
                  <xsl:text> and </xsl:text>
                </xsl:if>
                <!--<xsl:text>"</xsl:text>-->
                <xsl:value-of select="$Quote"/>
                <xsl:value-of select="ontime:ValidateName($ChildTableAlias)"/>
                <!--<xsl:text>"."</xsl:text>-->
                <xsl:value-of select="$Quote2"/>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$Quote"/>
                <xsl:value-of select="@columnName"/>
                <!--<xsl:text>" = "</xsl:text>-->
                <xsl:value-of select="$Quote2"/>
                <xsl:text> = </xsl:text>
                <xsl:value-of select="$Quote"/>
                <xsl:value-of select="ontime:ValidateName($Prefix)"/>
                <!--<xsl:text>"."</xsl:text>-->
                <xsl:value-of select="$Quote2"/>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$Quote"/>
                <xsl:value-of select="@parentColumnName"/>
                <!--<xsl:text>"</xsl:text>-->
                <xsl:value-of select="$Quote2"/>
              </xsl:for-each>
              <xsl:text>&#13;&#10;</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:when>
    </xsl:choose>
    <xsl:variable name="Self" select="self::column"/>
    <xsl:variable name="ParentTable" select="ancestor::table[1]"/>
    <xsl:variable name="ForeignKeys" select="
			ancestor::table[1]/foreignKeys/foreignKey[foreignKeyColumn[1]/@columnName=$Self/@name and ($Depth!=1000 and ($Depth&lt;$DiscoveryDepth or @force='true'))] | 
			ancestor::table[1]/foreignKeys/foreignKey[foreignKeyColumn[1]/@columnName!=$Self/@name and $ReadOnly='true' and ($Depth!=1000 and ($Depth&lt;$DiscoveryDepth or @force='true'))]"/>
    <xsl:for-each select="$ForeignKeys">
      <xsl:variable name="ForeignKey" select="self::foreignKey"/>
      <xsl:variable name="Table" select="key('TablesKey', concat($ForeignKey/@parentTableSchema, '.', $ForeignKey/@parentTableName))"/>
      <xsl:if test="not(contains($TableIDList, generate-id($Table)))">
        <xsl:variable name="Columns" select="$Table/columns/column[not(contains($IgnoreFieldNames,concat(';',@name,';')))]"/>
        <!-- variable "OneToOneColumn" defines a collection of primary key columns only if there are no other non-primary-key fields -->
        <xsl:variable name="OneToOneColumn" select="$Columns[count($Table/primaryKey/primaryKeyColumn) = 1 and @name=$Table/primaryKey/primaryKeyColumn/@columnName and @name=$Table/foreignKeys/foreignKey/foreignKeyColumn/@columnName][1]"/>
        <xsl:variable name="FirstRequiredColumn" select="$Columns[not(@name=$Table/primaryKey/primaryKeyColumn/@columnName)and @allowNulls='false' and @dataType='String' and not(@onDemand='true' and (@dataType!='String' or @type='xml')) and not($OneToOneColumn)][1]"/>
        <xsl:variable name="FirstStringNullableColumn" select="$Columns[not(@name=$Table/primaryKey/primaryKeyColumn/@columnName)and not(@allowNulls='false') and @dataType='String' and not(@onDemand='true' and (@dataType!='String' or @type='xml'))and not($OneToOneColumn) and not($FirstRequiredColumn)][1]"/>
        <xsl:variable name="FirstOtherNullableColumn" select="$Columns[not(@name=$Table/primaryKey/primaryKeyColumn/@columnName)and not(@allowNulls='false') and  not(@onDemand='true')and not($OneToOneColumn) and not($FirstRequiredColumn) and not($FirstStringNullableColumn)][1]"/>
        <xsl:variable name="ControllerFields" select="$OneToOneColumn| $FirstRequiredColumn | $FirstStringNullableColumn | $FirstOtherNullableColumn"/>
        <xsl:for-each select="$ControllerFields | $Columns[ontime:AllowParentColumn(., $ParentTable)]">
          <xsl:call-template name="RenderField">
            <xsl:with-param name="Depth">
              <xsl:choose>
                <xsl:when test="$ControllerFields/@name=current()/@name">
                  <xsl:value-of select="$Depth + 1"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="1000"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="Prefix">
              <xsl:variable name="ParentPrefix">
                <xsl:value-of select="$Prefix"/>
                <xsl:for-each select="$ForeignKey/foreignKeyColumn">
                  <xsl:value-of select="ontime:Replace(ontime:Replace(@columnName, '^(.+?)(ID|CODE|NO)$', '$1'), '\s+', '')"/>
                </xsl:for-each>
              </xsl:variable>
              <xsl:if test="$ParentPrefix=$ChildTableAlias or $ParentTable/@name!=$Table/@name and $Table/primaryKey/primaryKeyColumn[@columnName = $ParentPrefix]">
                <xsl:text>The</xsl:text>
              </xsl:if>
              <xsl:value-of select="$ParentPrefix"/>
            </xsl:with-param>
            <xsl:with-param name="ReadOnly" select="'true'"/>
            <xsl:with-param name="TableIDList" select="concat($TableIDList, generate-id($Table), ';')"/>
            <xsl:with-param name="Mode" select="$Mode"/>
            <xsl:with-param name="ChildTableAlias">
              <xsl:variable name="Alias">
                <xsl:choose>
                  <xsl:when test="$Prefix=''">
                    <xsl:value-of select="$Self/ancestor::table[1]/@name"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$Prefix"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:value-of select="ontime:CleanIdentifier($Alias)"/>
            </xsl:with-param>
            <xsl:with-param name="ChildForeignKey" select="$ForeignKey"/>
            <xsl:with-param name="OneToOne" select="$ParentTable/primaryKey/primaryKeyColumn/@columnName = $ParentTable/foreignKeys/foreignKey/foreignKeyColumn/@columnName and count($ParentTable/primaryKey/primaryKeyColumn) = 1"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
