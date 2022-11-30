<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="ontime msxsl bo"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="urn:schemas-codeontime-com:business-objects"
    xmlns:dm="urn:schemas-codeontime-com:data-model"
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
	<xsl:param name="DataModelPath" select="'C:\Users\bodro\Source\Repos\Master_Detail\app\controllers'"/>
	<xsl:param name="DataModel" select="'required'"/>
	<xsl:param name="DataModelSample" select="''"/>
	<xsl:param name="SiteContentEnabled" select="false"/>
	<xsl:param name="MembershipEnabled" select="'false'"/>
	<xsl:param name="MembershipDisplaySignUp" select="'true'"/>
	<xsl:param name="MembershipDisplayPasswordRecovery" select="'true'"/>
	<xsl:param name="CustomSecurity" select="'false'"/>
	<xsl:param name="ActiveDirectory" select="'false'"/>

	<xsl:variable name="IgnoreFieldNames" select="concat(';', ontime:RegexReplace($FieldsToIgnore, '(\s+)', ';'), ';')"/>
	<xsl:variable name="HideFieldNames" select="concat(';', ontime:RegexReplace($FieldsToHide, '(\s+)', ';'), ';')"/>
	<xsl:variable name="CustomLabelMap" select="concat(';', ontime:RegexReplace($CustomLabels, '(\s*?\n+\s*)', ';'), ';')"/>

	<xsl:output indent="yes" method="xml" cdata-section-elements="bo:text bo:data bo:formula"/>

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
    private string dataModel = "";
    private System.Collections.Generic.SortedDictionary<string, System.Collections.Generic.List<Tuple<string, XPathNavigator>>> _modelDictionary = 
        new System.Collections.Generic.SortedDictionary<string, System.Collections.Generic.List<Tuple<string, XPathNavigator>>>();
				
    public string ResolveFilterFields(XPathNodeIterator iterator, XPathNavigator dataModel) 
	  {
		    System.Text.StringBuilder sb = new System.Text.StringBuilder();
				
			  XmlNamespaceManager m = new XmlNamespaceManager(dataModel.NameTable);
        m.AddNamespace("dm", "urn:schemas-codeontime-com:data-model");
				
				if (iterator.MoveNext()) 
				{
				    foreach(var columnName in System.Text.RegularExpressions.Regex.Split(iterator.Current.Value, ",")) 
						{
						    if (sb.Length > 0)
								    sb.Append(",");
                var nav = dataModel.SelectSingleNode("/dm:dataModel/dm:columns/dm:column[@name='" + columnName + "']/@fieldName", m);
								if (nav != null)
						      sb.Append(nav.Value);
								else
								  sb.Append("Column not found in the model: " + columnName);
						}
				}
				return sb.ToString();
	  }
        
    public string InitializeVariables(XPathNodeIterator iterator, string dataModelMode, string dataModelPath)
    {
        dataModel = dataModelMode;
        if (dataModel == "required" || dataModel == "suggestedrequired") 
          _nameMaxLength = Int32.MaxValue;
        else if (iterator.MoveNext())
        {
            _nameMaxLength = Convert.ToInt32(iterator.Current.Evaluate("number(/dataModel/@nameMaxLength)"));
        }
          
        // load models  
        if (!dataModel.Contains("suggested")) {
          if (System.IO.Directory.Exists(dataModelPath))
          {
              foreach (string fileName in System.IO.Directory.GetFiles(dataModelPath))
                if (fileName.EndsWith(".model.xml"))
                {
                    
                    try
                    {
                        XPathDocument doc = new XPathDocument(fileName);
                        XPathNavigator nav = doc.CreateNavigator();

                        if (nav.MoveToFirstChild() && nav.LocalName == "dataModel")
                        {
                            string controllerName = System.IO.Path.GetFileNameWithoutExtension(fileName).Replace(".model", "");
                            string name = nav.GetAttribute("baseSchema", "") + "." + nav.GetAttribute("baseTable", "");
                            if (!_modelDictionary.ContainsKey(name))
                                _modelDictionary.Add(name, new System.Collections.Generic.List<Tuple<string, XPathNavigator>>());
                            
                            _modelDictionary[name].Add(new Tuple<string, XPathNavigator>(controllerName, nav));
                              
                        }
                    }
                    catch (Exception )
                    {
                    }
                }
          }
          
        }
        return "ok";
    }
    
    public int GetModelCount(string schema, string table)
    {
        string name = schema + "." + table;
        if (_modelDictionary.ContainsKey(name))
          return _modelDictionary[name].Count;
        else
          return 0;
    }
    public XPathNavigator GetModel(string schema, string table, int count)
    {
        string name = schema + "." + table;
        return _modelDictionary[name][count].Item2;
    }
    
    public string GetModelName(string schema, string table, int count)
    {
        string name = schema + "." + table;
        if (_modelDictionary.ContainsKey(name)) {
            System.Collections.Generic.List<Tuple<string, XPathNavigator>> models = _modelDictionary[name];
            
            if (models.Count > count)
                return models[count].Item1;
        }
        return "";
    }
    
    public XPathNavigator GetModelIfExists(string schema, string table, int count)
    {
        string name = schema + "." + table;
        if (_modelDictionary.ContainsKey(name)) {
            System.Collections.Generic.List<Tuple<string, XPathNavigator>> models = _modelDictionary[name];
            
            if (models.Count > count)
                return models[count].Item2;
        }
        return new XmlDocument().CreateNavigator();
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
							string alias = iterator.Current.Value;
              if (dataModel.Contains("suggested"))
              {
                  System.Collections.Generic.List<string> newParts = new System.Collections.Generic.List<string>();
                  bool containsUnderscore = alias.Contains("_");
                  string[] parts = alias.Split('_');
                  foreach (string part in parts)
                    newParts.Add(System.Text.RegularExpressions.Regex.Replace(part, @"(\w)[AEIOUYEaeiouy]", "$1", RegexOptions.Compiled));
                  alias = String.Join(containsUnderscore ? "_" : "", newParts);
              }
              else 
              {
                  alias = alias.Replace("_", "");
							    if (alias.Length > maxLength)
									    alias = System.Text.RegularExpressions.Regex.Replace(iterator.Current.Value, @"[AEIOUYEaeiouy]", "", RegexOptions.Compiled);
              }
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
				return StringReplace(iterator.Current.Value, pattern, result);
		  }
			return "Replace-Error";
		}
    
    public string StringReplace(string input, string pattern, string result)
    {
      return System.Text.RegularExpressions.Regex.Replace(input, pattern, result, System.Text.RegularExpressions.RegexOptions.IgnoreCase | RegexOptions.Compiled);
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
        string value = iterator.Current.Value;
				string s = System.Text.RegularExpressions.Regex.Replace(value, @"[^_a-zA-Z0-9]", "");
				double n;
				if (s.Length == 0 || Double.TryParse(s, out n)) {
          if (s.Length == 0)
              s = (_nextGenericNameIndex++).ToString();
					return "n" + s;
        }
				return s;
		  }
			return "CleanIdentifier-Error";
		}
    
    public string EnsureFirstUpperCaseLetter(string prefix, XPathNodeIterator iterator) {
        var name = CleanIdentifier(iterator);
        if (!string.IsNullOrEmpty(prefix) && System.Text.RegularExpressions.Regex.IsMatch(prefix, @"\p{L}"))
            name = Char.ToUpper(name[0]) + name.Substring(1);
        return name;        
    }
    
    public string EnsureFirstUpperCaseLetterInLabel(string prefix, XPathNodeIterator iterator, string formatExpression) {
        var name = FormatAsLabel(iterator, formatExpression);
        if (!string.IsNullOrEmpty(prefix) && System.Text.RegularExpressions.Regex.IsMatch(prefix, @"\p{L}"))
            name = Char.ToUpper(name[0]) + name.Substring(1);
        return name;        
    }


    public string DoReplaceFormatExpression(System.Text.RegularExpressions.Match m) {
		    return m.Groups["Text"].Value;
		}
    
		public string FormatAsLabel(XPathNodeIterator iterator, string formatExpression)
		{
			if (iterator.MoveNext()) {
          var s = iterator.Current.Value;
          if (System.Text.RegularExpressions.Regex.IsMatch(s, @"\W"))
            return s;
          return InternalFormatAsLabel(s, formatExpression);
      }
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
                label +=  w;
            }
        }
        else if (words.Count == 1)
          label = words[0];

        if (label == null) return text;
        
        if (dataModel != "required" && dataModel != "suggestedrequired")
            if (label.EndsWith(" Id", StringComparison.OrdinalIgnoreCase))
                label = label.Substring(0, label.Length - 3) + "#";
                
        return label;
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
			Match m = Regex.Match(labelMap, String.Format(@";{0}=(.+?);", Regex.Escape(label))/*, RegexOptions.Compiled*/);
			if (m.Success)
					return m.Groups[1].Value;
			return label;
    }
    private System.Collections.Generic.SortedDictionary<string, string> _fieldMap = new System.Collections.Generic.SortedDictionary<string, string>();
        
    private System.Collections.Generic.SortedDictionary<string, string> _oneToOne = new System.Collections.Generic.SortedDictionary<string, string>();
    
    private System.Collections.Generic.SortedDictionary<string, string> _usedObjects = new System.Collections.Generic.SortedDictionary<string, string>();
    
    private int _nextGenericNameIndex = 1;
    
   public bool AllowObject(string objectName) {
      var result = _usedObjects.ContainsKey(objectName);
      if (objectName == "") {
          _usedObjects.Clear();
          _nextGenericNameIndex = 1;
      }
      else if (!result)
        _usedObjects[objectName] = objectName;
      return !result;
   }
    
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
        
    public XPathNodeIterator useRightIf(string useRight, XPathNodeIterator left, XPathNodeIterator right) {
      return useRight == "true" ? right : left;
    }
        
    System.Collections.Generic.List<string> _leftJoins = new System.Collections.Generic.List<string>();
        
    public bool hasLeftJoin(XPathNodeIterator foreignKey) 
    {
      if (foreignKey.MoveNext()) {
        string parentTableName = foreignKey.Current.GetAttribute("parentTableName", String.Empty);
        string parentTableSchema = foreignKey.Current.GetAttribute("parentTableSchema", String.Empty);
        string baseForeignKeyID = foreignKey.Current.GetAttribute("baseForeignKey", String.Empty);
        string key = baseForeignKeyID + "," + parentTableSchema + "." + parentTableName;
        if (_leftJoins.Contains(key)) 
          return true;
        else
          _leftJoins.Add(key);
      }
        return false;
    }
    
    System.Collections.Generic.List<string> _froms = new System.Collections.Generic.List<string>();
    
    public bool hasFrom(XPathNodeIterator table,XPathNodeIterator foreignKey)
    {
      if (foreignKey.MoveNext() && table.MoveNext()) {
        string columnName = foreignKey.Current.GetAttribute("columnName", String.Empty);
        string parentColumnName = foreignKey.Current.GetAttribute("parentColumnName", String.Empty);
        string foreignTable = table.Current.GetAttribute("name", String.Empty);
        string foreignSchema = table.Current.GetAttribute("schema", String.Empty);
        
        string key = String.Format("{0}=>{1}.{2}.{3}", columnName, foreignSchema, foreignTable, parentColumnName);
        if (_froms.Contains(key))
          return true;
        else
          _froms.Add(key);
      }
      return false;
    }
        
    private System.Collections.Generic.SortedDictionary<string, string> _prefixes = new System.Collections.Generic.SortedDictionary<string, string>();
        
    public string getPrefix(XPathNodeIterator foreignKey) 
    {
      if (foreignKey.MoveNext()) 
      {
        XPathNavigator nav = foreignKey.Current;
        string foreignKeyID = nav.GetAttribute("id", String.Empty);
        if (_prefixes.ContainsKey(foreignKeyID))
          return _prefixes[foreignKeyID];
        else
        {
          XmlNamespaceManager manager = new XmlNamespaceManager(nav.NameTable);
          manager.AddNamespace("dm", "urn:schemas-codeontime-com:data-model");
          
          // construct the prefix
          System.Collections.Generic.List<string> prefixes = new System.Collections.Generic.List<string>();
          
          string prefixID = nav.GetAttribute("id", "");
          if (!String.IsNullOrEmpty(prefixID))
            prefixes.Add(prefixID);
          else
            foreach (XPathNavigator fKeyNav in nav.Select("./dm:foreignKeyColumn", manager))
              prefixes.Add(StringReplace(StringReplace(fKeyNav.GetAttribute("columnName", ""), "^(.+?)(ID|CODE|NO)$", "$1"), @"\s+", ""));
            
          
          // traverse the keys
          string baseForeignKeyID = nav.GetAttribute("baseForeignKey", String.Empty);
          nav.MoveToParent();
          while (baseForeignKeyID != "") 
          {
            XPathNodeIterator nextKey = nav.Select("./dm:foreignKey[@id='" + baseForeignKeyID + "']", manager);
                
            if (nextKey.MoveNext()) 
            {
              foreach (XPathNavigator fKeyCNav in nextKey.Current.Select("./dm:foreignKeyColumn", manager))
                prefixes.Add(StringReplace(StringReplace(fKeyCNav.GetAttribute("columnName", ""), "^(.+?)(ID|CODE|NO)$", "$1"), @"\s+", ""));
            
              baseForeignKeyID = nextKey.Current.GetAttribute("baseForeignKey", String.Empty);
            }
            else
              break;
          }
          prefixes.Reverse();
          string prefix = String.Join("", prefixes);
          _prefixes.Add(foreignKeyID, prefix);
          return prefix;
        }
      }
      return "";
    }
    
    public XPathNodeIterator loadDocumentIfExists(string path, XPathNodeIterator otherwise)
    {
      if (System.IO.File.Exists(path))
      {
        XPathDocument doc = new XPathDocument(path);
        return doc.CreateNavigator().Select(".");
      }
      else
        return otherwise;
    }
    
    public XPathNavigator navFromString(string xml)
    {
      return (new XPathDocument(new System.IO.StringReader(xml))).CreateNavigator();
    }
    
    public bool notInList(string list, string name)
    {
      string[] aList = list.Split(',');
      return Array.IndexOf(aList, name) == -1;
    }
    
    public XPathNodeIterator getFROMColumns(XPathNavigator dataModel) 
    {
      XmlNamespaceManager m = new XmlNamespaceManager(dataModel.NameTable);
      m.AddNamespace("dm", "urn:schemas-codeontime-com:data-model");
      
      StringBuilder sb = new StringBuilder("<columns  xmlns=\"urn:schemas-codeontime-com:data-model\">");
      
      XPathNavigator fromColumn = dataModel.SelectSingleNode("./dm:columns/dm:column[not(@foreignKey)]", m);
      sb.Append(fromColumn.OuterXml);
      
      foreach (XPathNavigator baseForeignKey in dataModel.Select("./dm:foreignKeys/dm:foreignKey[not(@baseForeignKey)]", m))
      {
        getFROMColumnsFK(sb, dataModel, m, baseForeignKey);
      }
      
      sb.Append("</columns>");
      string columns = sb.ToString();
      XmlDocument doc = new XmlDocument();
      doc.LoadXml(columns);
      XPathNavigator columnNav = doc.CreateNavigator();
      
      return columnNav.Select("dm:columns/dm:column", m);
    }
    
    public void getFROMColumnsFK(StringBuilder sb, XPathNavigator dataModel, XmlNamespaceManager m, XPathNavigator fKey) 
    {
      string id = fKey.GetAttribute("id", "");
      
      XPathNavigator fKeyColumnModel = dataModel.SelectSingleNode("./dm:columns/dm:column[@foreignKey='" + id + "']", m);
      if (fKeyColumnModel == null)
      {
      }
      sb.Append(fKeyColumnModel.OuterXml);
      
      foreach (XPathNavigator dependentFKey in dataModel.Select("dm:foreignKeys/dm:foreignKey[@baseForeignKey = '" + id + "']", m))
      {
        getFROMColumnsFK(sb, dataModel, m, dependentFKey);
      }
    }
    
    public bool StringEquals(string s1, string s2) {
        return String.Compare(s1, s2, true) == 0;
    }
		]]>
	</msxsl:script>
	<xsl:variable name="Dummy1" select="ontime:InitializeVariables(., $DataModel, $DataModelPath)"/>
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
		<businessObjectCollection parameterMarker="{/dataModel/@parameterMarker}" provider="{/dataModel/@provider}" >
			<xsl:choose>
				<xsl:when test="$DataModelSample!=''">
					<xsl:variable name="DataModelFile" select="ontime:navFromString($DataModelSample)"/>
					<xsl:variable name="Model" select="$DataModelFile/dm:dataModel[1]"/>
					<xsl:if test="$Model">
						<xsl:for-each select="/dataModel/table[@name=$Model/@baseTable and ($Model/@baseSchema='' and not(@schema) or @schema=$Model/@baseSchema)]">
							<xsl:call-template name="Main">
								<xsl:with-param name="Schema" select="@schema"/>
								<xsl:with-param name="Name" select="@name"/>
								<xsl:with-param name="Model" select="$DataModelFile/dm:dataModel"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$Schema='' and $Name=''">
					<xsl:for-each select="/dataModel/table">
						<xsl:variable name="Name" select="@name"/>
						<xsl:variable name="Schema" select="@schema"/>
						<xsl:variable name="ModelCount" select="ontime:GetModelCount($Schema, $Name)"/>
						<xsl:if test="$ModelCount=0 and ($DataModel!='required' or ($SiteContentEnabled and (contains($Name,'SiteContent') or contains($Name,'site_content') or contains($Name,'SITE_CONTENT'))))">
							<xsl:call-template name="Main">
								<xsl:with-param name="Schema" select="$Schema"/>
								<xsl:with-param name="Name" select="$Name"/>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="$ModelCount&gt;0">
							<xsl:call-template name="DataModelLoop">
								<xsl:with-param name="Max" select="$ModelCount"/>
								<xsl:with-param name="Name" select="$Name"/>
								<xsl:with-param name="Schema" select="$Schema"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:for-each>
					<!-- add MyProfile controller -->
					<xsl:if test="$MembershipEnabled = 'true' or $CustomSecurity = 'true' or $ActiveDirectory = 'true'">
						<dataController name="MyProfile" conflictDetection="overwriteChanges" label="My Profile" handler="MyProfileBusinessRules">
							<commands />
							<fields>
								<field name="UserName" type="String" allowNulls="false" label="^UserName^User Name^UserName^" />
								<field name="RememberMe" type="Boolean" allowNulls="false" default="0" label="^RememberMe^Remember me next time^RememberMe^">
									<items style="CheckBox" />
								</field>
								<field name="Password" type="String" allowNulls="false" label="^Password^Password^Password^" />
								<field name="ConfirmPassword" type="String" allowNulls="false" label="^ConfirmPassword^Confirm Password^ConfirmPassword^" />
								<field name="OldPassword" type="String" allowNulls="false" label="^OldPassword^Old Password^OldPassword^" />
								<field name="Email" type="String" label="^Email^Email^Email^" allowNulls="false" />
								<field name="PasswordQuestion" type="String" label="^PasswordQuestion^Password Question^PasswordQuestion^" allowNulls="false" />
								<field name="PasswordAnswer" type="String" label="^PasswordAnswer^Password Answer^PasswordAnswer^" allowNulls="false" />
								<field name="DisplayRememberMe" type="Boolean"/>
								<field name="OAuthEnabled" type="Boolean"/>
								<field name="OAuthProvider" type="String" allowNulls="false" label="^Account^Account^Account^">
									<items style="RadioButtonList">
										<item value="facebook" text="Facebook"/>
										<item value="google" text="Google"/>
										<item value="msgraph" text="Microsoft"/>
										<item value="linkedin" text="LinkedIn"/>
										<item value="windowslive" text="Windows Live"/>
										<item value="sharepoint" text="SharePoint"/>
										<item value="dnn" text="DotNetNuke"/>
										<item value="identityserver" text="Identity Server"/>
										<item value="cloudidentity" text="Cloud Identity"/>
										<item value="other" text="Other"/>
									</items>
								</field>
							</fields>
							<views>
								<view id="loginForm" type="Form" access="Public" label="^LoginLink^Login^LoginLink^"  tags="modal-fit-content modal-auto-grow modal-max-xs material-icon-lock-outline discard-changes-prompt-none">
									<categories>
										<category id="c1" headerText="" flow="NewColumn">
											<dataFields>
												<dataField fieldName="OAuthEnabled" hidden="true"/>
												<dataField fieldName="OAuthProvider" hidden="true" tag="lookup-auto-advance" columns="1"/>
												<dataField fieldName="UserName" />
												<dataField fieldName="Password" textMode="Password">
													<visibility>
														<expression test="$app.touch.settings('membership.disableLoginPassword') != true"/>
													</visibility>
												</dataField>
												<dataField fieldName="RememberMe" >
													<visibility>
														<expression test="$row.DisplayRememberMe != false"/>
													</visibility>
												</dataField>
												<dataField fieldName="DisplayRememberMe" hidden="true"/>
											</dataFields>
										</category>
									</categories>
								</view>
								<xsl:if test="$ActiveDirectory != 'true'">
									<view id="signUpForm" type="Form" commandId="command1" access="Public" label="^SignUpViewLabel^Account Sign Up^SignUpViewLabel^" tags="material-icon-person-add">
										<headerText>^SignUpViewHeaderText^Please fill this form and click OK button to sign up for an account. Click Cancel to return to the previous screen.^SignUpViewHeaderText^</headerText>
										<categories>
											<category id="c1" headerText="^SignUpViewNewUserInfoCategoryHeaderText^New User Information^SignUpViewNewUserInfoCategoryHeaderText^" flow="NewColumn">
												<description><![CDATA[^SignUpViewNewUserInfoCategoryDescription^Please enter user name and password. Note that password must be at least 7 characters long and include one non-alphanumeric character. Only approved users will be able to login into the website.^SignUpViewNewUserInfoCategoryDescription^]]></description>
												<dataFields>
													<dataField fieldName="UserName" columns="20" />
													<dataField fieldName="Password" columns="20" textMode="Password" />
													<dataField fieldName="ConfirmPassword" columns="20" textMode="Password" />
												</dataFields>
											</category>
											<category id="c2" headerText="^SignUpViewPasswordRecoveryCategoryHeaderText^Password Recovery^SignUpViewPasswordRecoveryCategoryHeaderText^">
												<description>
													<![CDATA[
                        ^SignUpViewPasswordRecoveryCategoryDescription^These fields are required to help you to recover a forgotten password. During the recovery process you will be asked to enter a user name. 
						If a user account exists then a security question is requested to be answered. A correct answer will trigger an email with a temporary password send to the registered email.^SignUpViewPasswordRecoveryCategoryDescription^
                      ]]>
												</description>
												<dataFields>
													<dataField fieldName="Email" />
													<dataField fieldName="PasswordQuestion" />
													<dataField fieldName="PasswordAnswer" textMode="Password"/>
												</dataFields>
											</category>
										</categories>
									</view>
									<view id="passwordRequestForm" type="Form" commandId="command1" access="Public" label="^PasswordRequestViewLabel^Password Recovery: Step 1 of 2^PasswordRequestViewLabel^" tags="material-icon-lock discard-changes-prompt-none">
										<headerText>^PasswordRequestViewHeaderText^Please fill this form and click Continue button to recover the forgotten password. Click Cancel to return to the previous screen.^PasswordRequestViewHeaderText^</headerText>
										<categories>
											<category id="c1" headerText="^PasswordRequestViewForgotPasswordCategoryHeaderText^Forgot your password?^PasswordRequestViewForgotPasswordCategoryHeaderText^" flow="NewColumn">
												<description><![CDATA[^PasswordRequestViewForgotPasswordCategoryDescription^Please enter a user name. <br/><br/><br/>^PasswordRequestViewForgotPasswordCategoryDescription^]]></description>
												<dataFields>
													<dataField fieldName="UserName" columns="20" />
												</dataFields>
											</category>
										</categories>
									</view>
									<view id="identityConfirmationForm" type="Form" commandId="command1" access="Public" label="^IdentityConfirmViewLabel^Password Recovery: Step 2 of 2^IdentityConfirmViewLabel^" tags="material-icon-lock-open discard-changes-prompt-none">
										<headerText>^IdentityConfirmViewHeaderText^Please fill this form and click Submit button to recover the forgotten password. Click Cancel to return to the previous screen.^IdentityConfirmViewHeaderText^</headerText>
										<categories>
											<category id="c1" headerText="^IdentityConfirmationViewIdentityConfirmCategoryHeaderText^Identity Confirmation^IdentityConfirmationViewIdentityConfirmCategoryHeaderText^" flow="NewColumn">
												<description><![CDATA[^IdentityConfirmationViewIdentityConfirmCategoryDescription^Answer the following question to receive your password. <br/><br/><br/>^IdentityConfirmationViewIdentityConfirmCategoryDescription^]]></description>
												<dataFields>
													<dataField fieldName="UserName" columns="20" readOnly="true" />
													<dataField fieldName="PasswordQuestion" readOnly="true" />
													<dataField fieldName="PasswordAnswer" textMode="Password" />
												</dataFields>
											</category>
										</categories>
									</view>
									<view id="myAccountForm" type="Form" commandId="command1" label="^MyAccountViewLabel^My Account^MyAccountViewLabel^" tags="material-icon-perm-identity discard-changes-prompt-none">
										<headerText>^MyAccountViewHeaderText^Please review your membership information below. Click Update My Account to change this record, or click Cancel to return back.^MyAccountViewHeaderText^</headerText>
										<categories>
											<category id="c1" headerText="^MyAccountViewCurrentPasswordCategoryHeaderText^1. Current Password^MyAccountViewCurrentPasswordCategoryHeaderText^" flow="NewColumn">
												<description><![CDATA[^MyAccountViewCurrentPasswordCategoryDescription^Please enter your current password to create new password, update your email address, or change password recovery question and answer.^MyAccountViewCurrentPasswordCategoryDescription^]]></description>
												<dataFields>
													<dataField fieldName="UserName" readOnly="true" />
													<dataField fieldName="OldPassword" columns="20" textMode="Password">
														<headerText>^Password^Password^Password^</headerText>
													</dataField>
												</dataFields>
											</category>
											<category id="c2" headerText="^MyAccountViewNewPasswordCategoryHeaderText^2. New Password (Optional)^MyAccountViewNewPasswordCategoryHeaderText^">
												<description><![CDATA[^MyAccountViewNewPasswordCategoryDescription^Please enter new password. Note that password must be at least 7 characters long and include one non-alphanumeric character.^MyAccountViewNewPasswordCategoryDescription^]]></description>
												<dataFields>
													<dataField fieldName="Password" columns="20" textMode="Password">
														<headerText>^NewPassword^New Password^NewPassword^</headerText>
													</dataField>
													<dataField fieldName="ConfirmPassword" columns="20" textMode="Password">
														<headerText>^ConfirmNewPassword^Confirm New Password^ConfirmNewPassword^</headerText>
													</dataField>
												</dataFields>
											</category>
											<category id="c3" headerText="^MyAccountViewPasswordRecoveryCategoryHeaderText^3. Email &amp; Password Recovery (Optional)^MyAccountViewPasswordRecoveryCategoryHeaderText^">
												<description>
													<![CDATA[
                        ^MyAccountViewPasswordRecoveryCategoryDescription^During the recovery of a forgotten password you will be asked to enter your user name. 
						If a user account exists then a password question must be answered. A correct answer will trigger an email with a temporary password send to you.^MyAccountViewPasswordRecoveryCategoryDescription^
                      ]]>
												</description>
												<dataFields>
													<dataField fieldName="Email" />
													<dataField fieldName="PasswordQuestion" />
													<dataField fieldName="PasswordAnswer" textMode="Password">
														<headerText>^MaskedPasswordAnswer^Password Answer (not displayed for your protection)^MaskedPasswordAnswer^</headerText>
													</dataField>
												</dataFields>
											</category>
										</categories>
									</view>
								</xsl:if>
							</views>
							<actions>
								<actionGroup id="ag1" scope="Form">
									<action id="a1" whenLastCommandName="New" whenLastCommandArgument="signUpForm" commandName="Insert" commandArgument="SignUp" headerText="^SignUp^Sign Up^SignUp^" />
									<action id="a2" whenLastCommandName="New" whenLastCommandArgument="signUpForm" commandName="Cancel" />
									<action id="a3" whenLastCommandName="Insert" whenLastCommandArgument="SignUp" commandName="Cancel" />
									<action id="a4" whenLastCommandName="New" whenLastCommandArgument="passwordRequestForm" commandName="Cancel" />
									<action id="a5" whenLastCommandName="New" whenLastCommandArgument="passwordRequestForm" commandName="Custom" commandArgument="RequestPassword" headerText="^RequestPasswordActionHeaderText^Next^RequestPasswordActionHeaderText^" cssClass="material-icon-arrow-forward"/>
									<action id="a6" whenLastCommandName="Edit" whenLastCommandArgument="identityConfirmationForm" commandName="Custom" commandArgument="BackToRequestPassword" headerText="^BackToRequestPasswordActionHeaderText^Back^BackToRequestPasswordActionHeaderText^" causesValidation="false" />
									<action id="a7" whenLastCommandName="Edit" whenLastCommandArgument="identityConfirmationForm" commandName="Custom" commandArgument="ConfirmIdentity" headerText="^ConfirmIdentityActionHeaderText^Finish^ConfirmIdentityActionHeaderText^" cssClass="material-icon-check" />
									<action id="a8" whenLastCommandName="Edit" whenLastCommandArgument="myAccountForm" commandName="Update" headerText="^UpdateMyAccountActionHeaderText^Update My Account^UpdateMyAccountActionHeaderText^" causesValidation="false" />
									<action id="a9" whenLastCommandName="Edit" whenLastCommandArgument="myAccountForm" commandName="Cancel" />
									<action id="a10" commandName="Custom" headerText="^LoginButton^Login^LoginButton^" commandArgument="Login" whenLastCommandName="New" whenLastCommandArgument="loginForm" causesValidation="true" key="Enter" cssClass="material-icon-arrow-forward"/>
									<xsl:if test="$ActiveDirectory != 'true'">
										<xsl:if test="$MembershipDisplaySignUp='true'">
											<action id="a11" commandName="Custom" headerText="^SignUpNow^Sign up now^SignUpNow^" commandArgument="SignUp" whenLastCommandName="New" whenLastCommandArgument="loginForm" causesValidation="false"/>
										</xsl:if>
										<xsl:if test="$MembershipDisplayPasswordRecovery='true'">
											<action id="a12" commandName="Custom" headerText="^ForgotYourPassword^Forgot your password?^ForgotYourPassword^" commandArgument="ForgotPassword" whenLastCommandName="New" whenLastCommandArgument="loginForm" causesValidation="false" />
										</xsl:if>
									</xsl:if>
								</actionGroup>
								<!--<xsl:if test="$ActiveDirectory != 'true'">
                  <actionGroup id="agAuth" scope="Custom">
                    <action id="aFacebook" commandName="Navigate" commandArgument="~/appservices/saas/facebook" headerText="^LoginWithFacebook^Login With Facebook^LoginWithFacebook^" whenLastCommandName="New" whenLastCommandArgument="loginForm" whenTag="show-facebook-login"/>
                    <action id="aGoogle" commandName="Navigate" commandArgument="~/appservices/saas/google" headerText="^LoginWithGoogle^Login With Google^LoginWithGoogle^" whenLastCommandName="New" whenLastCommandArgument="loginForm" whenTag="show-google-login"/>
                    <action id="aMsGraph" commandName="Navigate" commandArgument="~/appservices/saas/msgraph" headerText="^LoginWithMicrosoft^Login With Microsoft^LoginWithMicrosoft^" whenLastCommandName="New" whenLastCommandArgument="loginForm" whenTag="show-msgraph-login"/>
                    <action id="aLinkedIn" commandName="Navigate" commandArgument="~/appservices/saas/linkedin" headerText="^LoginWithLinkedIn^Login With LinkedIn^LoginWithLinkedIn^" whenLastCommandName="New" whenLastCommandArgument="loginForm" whenTag="show-linkedin-login"/>
                    <action id="aWindowsLive" commandName="Navigate" commandArgument="~/appservices/saas/windowslive" headerText="^LoginWithWindowsLive^Login With Windows Live^LoginWithWindowsLive^" whenLastCommandName="New" whenLastCommandArgument="loginForm" whenTag="show-windows-live-login"/>
                    <action id="aSharePoint" commandName="Navigate" commandArgument="~/appservices/saas/sharepoint" headerText="^LoginWithSharePoint^Login With SharePoint^LoginWithSharePoint^" whenLastCommandName="New" whenLastCommandArgument="loginForm" whenTag="show-sharepoint-login"/>
                    <action id="aDnn" commandName="Navigate" commandArgument="~/appservices/saas/dnn" headerText="^LoginWithDNN^Login With DotNetNuke^LoginWithDNN^" whenLastCommandName="New" whenLastCommandArgument="loginForm" whenTag="show-dnn-login"/>
                    <action id="aCloudIdentity" commandName="Navigate" commandArgument="~/appservices/saas/cloudidentity" headerText="^LoginWithCloudIdentity^Login With Cloud Identity^LoginWithCloudIdentity^" whenLastCommandName="New" whenLastCommandArgument="loginForm" whenTag="show-cloudidentity-login"/>
                  </actionGroup>
                </xsl:if>-->
							</actions>
							<businessRules>
								<rule id="r100" commandName="Custom" commandArgument="Login" type="JavaScript" phase="Execute">
									<![CDATA[
this.preventDefault();
var resources = Web.MembershipResources.Messages,
    oauthProvider = $row.OAuthProvider;
if (oauthProvider && oauthProvider != 'other')
    window.location = $app.resolveClientUrl('~/appservices/saas/' + oauthProvider);
else
    $app.login($row.UserName, $row.Password, $row.RememberMe==true,
      function () {
        setTimeout(function() {
          $app._navigated = true;
          window.location.replace($app.touch.returnUrl() || __baseUrl);
        });
      },
      function () {
        $app.alert(resources.InvalidUserNameAndPassword, function() {$app.input.focus({fieldName:'UserName'})});
      });
]]>
								</rule>
								<xsl:if test="$ActiveDirectory != 'true'">
									<rule id="r101" commandName="Custom" commandArgument="SignUp" type="JavaScript" phase="Execute">
										<![CDATA[
this.preventDefault();
$app.touch.show({
  controller: 'MyProfile',
  startCommand: 'New',
  startArgument: 'signUpForm'
});
]]>
									</rule>
									<rule id="r102" commandName="Custom" commandArgument="ForgotPassword" type="JavaScript" phase="Execute">
										<![CDATA[
this.preventDefault();
$app.touch.show({
  controller: 'MyProfile',
  startCommand: 'New',
  startArgument: 'passwordRequestForm'
});
]]>
									</rule>
								</xsl:if>
							</businessRules>
						</dataController>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="Main">
						<xsl:with-param name="Schema" select="$Schema"/>
						<xsl:with-param name="Name" select="$Name"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</businessObjectCollection>
	</xsl:template>

	<xsl:template name="DataModelLoop">
		<xsl:param name="i" select="0"/>
		<xsl:param name="Max" />
		<xsl:param name="Schema"/>
		<xsl:param name="Name"/>

		<xsl:call-template name="Main">
			<xsl:with-param name="Schema" select="$Schema"/>
			<xsl:with-param name="Name" select="$Name"/>
			<xsl:with-param name="Model" select="ontime:GetModel($Schema, $Name, $i)"/>
			<xsl:with-param name="ControllerName" select="ontime:GetModelName($Schema, $Name, $i)"/>
		</xsl:call-template>

		<xsl:if test="($i + 1) &lt; $Max">
			<xsl:call-template name="DataModelLoop">
				<xsl:with-param name="Max" select="$Max"/>
				<xsl:with-param name="i" select="$i + 1"/>
				<xsl:with-param name="Name" select="$Name"/>
				<xsl:with-param name="Schema" select="$Schema"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="Main">
		<xsl:param name="Schema"/>
		<xsl:param name="Name"/>
		<xsl:param name="Model" select="/.."/>
		<xsl:param name="ControllerName"/>
		<xsl:variable name="Table" select="key('TablesKey', concat($Schema, '.', $Name)) | /dataModel/table[@name=$Name and $Schema='__ignore__' and @schema='dbo']"/>
		<xsl:variable name="ModelDetected" select="count($Model) &gt; 0"/>
		<!--<xsl:if test="$DataModel!='required' or $ModelDetected or $Name = $SiteContentTableName">-->
		<xsl:variable name="FieldList">
			<xsl:call-template name="RenderInMode">
				<xsl:with-param name="Table" select="$Table"/>
				<xsl:with-param name="Mode" select="'Field'"/>
				<xsl:with-param name="Model" select="$Model"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="ProviderName" select="/dataModel/@provider"/>
		<xsl:variable name="FieldListNodeSet" select="msxsl:node-set($FieldList)"/>
		<xsl:variable name="FieldListWOAliases">
			<xsl:if test="$Model">
				<xsl:for-each select="$FieldListNodeSet/*">
					<xsl:variable name="FieldName" select="@name"/>
					<xsl:variable name="FieldModel" select="$Model/dm:columns/dm:column[@fieldName=$FieldName]"/>
					<xsl:variable name="AliasForeignKey" select="$FieldModel/@foreignKey"/>
					<xsl:variable name="AliasOf" select="$Model/dm:columns/dm:column[@aliasColumnName=$FieldModel/@name and @aliasForeignKey=$FieldModel/@foreignKey]"/>
					<xsl:variable name="IsAutoPrimaryKey" select="@isBase='true' and @isPrimaryKey='true' and ((contains(@type,'Int') and (@readOnly='true' or contains($ProviderName, 'Oracle'))) or (@type='Guid' and @default!='') or (@type='String' and contains($ProviderName, 'MySql') and @length='36'))"/>
					<xsl:if test="not($AliasOf) and (@isForeignKey='true' or not($IsAutoPrimaryKey))">
						<xsl:copy-of select="."/>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="FilteredFieldList" select="ontime:useRightIf($ModelDetected, $FieldListNodeSet, msxsl:node-set($FieldListWOAliases))"/>
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
		<xsl:variable name="BOName">
			<xsl:choose>
				<xsl:when test="$ModelDetected and $ControllerName != ''">
					<xsl:value-of select="$ControllerName"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$ControllerSchema"/>
					<xsl:value-of select="$Table/@name"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ViewLabel">
			<xsl:variable name="Label">
				<!--<xsl:if test="$Table/@schema != 'dbo' and $SchemaCount>1">
          <xsl:value-of select="ontime:CustomizeLabel($Table/@schema, $CustomLabelMap)"/>
          <xsl:text> </xsl:text>
        </xsl:if>-->
				<xsl:value-of select="ontime:CustomizeLabel($BOName, $CustomLabelMap)"/>
			</xsl:variable>
			<xsl:value-of select="ontime:FormatAsLabel($Label,$LabelFormatExpression)"/>
		</xsl:variable>
		<xsl:variable name="BaseFieldSet" select="$FilteredFieldList/*[@isBase='true' and not(@isPrimaryKey='true' and not((@type='String' and not(contains($ProviderName, 'MySql') and @length='36')) or @type='DateTime' or @isForeignKey='true') or ((@onDemand='true' or (@type='Byte[]' and not(@onDemand='true'))) and $AllowBlobSupport='false') or @type='Guid' and @default='' or contains(ontime:ToLower(@name), 'password')) and not(contains($IgnoreFieldNames,concat(';',@name,';')))]"/>
		<xsl:variable name="AdditionalFieldSet" select="$FilteredFieldList/*[not(@isBase='true' or preceding-sibling::*[1][@isBase='true' and @isForeignKey='true'] or contains(ontime:ToLower(@name), 'password'))]"/>
		<xsl:variable name="EditFieldSet" select="$FilteredFieldList/*[@isBase='true' and not(@isPrimaryKey='true' and not((@type='String' and not(contains($ProviderName, 'MySql') and @length='36')) or @type='DateTime' or @isForeignKey='true') or ((@onDemand='true' or (@type='Byte[]' and not(@onDemand='true'))) and $AllowBlobSupport='false') or (@type='Guid' and @default!='')) and not(contains($IgnoreFieldNames,concat(';',@name,';')))]"/>
		<xsl:variable name="InsertFieldSet" select="$FilteredFieldList/*[@isBase='true' and not(@readOnly='true' or  ($AllowBlobUploadOnInsert != 'true' and (@onDemand='true' or @type='Byte[]')) or (@type='Guid' and @default!='')) and not(contains($IgnoreFieldNames,concat(';',@name,';')))]"/>
		<xsl:variable name="InsertFieldSet2" select="$FilteredFieldList/*[@isBase='true' and not(@readOnly='true' or ($AllowBlobUploadOnInsert != 'true' and (@onDemand='true' or @type='Byte[]')) or (@type='Guid' and @default!='')) and (contains($IgnoreFieldNames,concat(';',@name,';'))) and not(@default)]"/>
		<xsl:variable name="FirstRequiredField" select="$BaseFieldSet[@allowNulls='false'][1]/@name"/>

		<businessObject name="{ontime:CleanIdentifier($BOName)}" conflictDetection="overwriteChanges"
        label="{ontime:FormatAsLabel(ontime:CustomizeLabel($BOName, $CustomLabelMap), $LabelFormatExpression)}"
        nativeSchema="{$Table/@schema}"
        nativeTableName="{$Table/@name}"
        nativeSchemaLabel="{ontime:FormatAsLabel(ontime:CustomizeLabel($Table/@schema, $CustomLabelMap),'')}"
        surrogateSchema="{ontime:GetSchema($Table/@name, $Table/@schema, $DetectUnderscoreSeparatedSchema)}"
        surrogateSchemaLabel="{ontime:FormatAsLabel(ontime:CustomizeLabel(ontime:GetSchema($Table/@name, $Table/@schema, $DetectUnderscoreSeparatedSchema), $CustomLabelMap),'')}">
			<xsl:if test="$ModelDetected and $Model/@created">
				<xsl:attribute name="created">
					<xsl:value-of select="$Model/@created"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:variable name="SQL">
				<xsl:variable name="_resetSQL" select="ontime:AllowObject('')"/>
				<xsl:call-template name="RenderInMode">
					<xsl:with-param name="Table" select="$Table"/>
					<xsl:with-param name="Mode" select="'SELECT'"/>
					<xsl:with-param name="Model" select="$Model"/>
				</xsl:call-template>
				<xsl:variable name="_resetFROM" select="ontime:AllowObject('')"/>
				<xsl:call-template name="RenderInMode">
					<xsl:with-param name="Table" select="$Table"/>
					<xsl:with-param name="Mode" select="'FROM'"/>
					<xsl:with-param name="Model" select="$Model"/>
				</xsl:call-template>
			</xsl:variable>
			<commands>
				<command id="command1" type="Text">
					<text>
						<xsl:value-of select="$SQL"/>
					</text>
				</command>
				<xsl:if test="$DataModelSample = ''">
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
								<fieldOutput>
									<xsl:attribute name="fieldName">
										<xsl:call-template name="LookUpModelFieldName">
											<xsl:with-param name="Model" select="$Model"/>
											<xsl:with-param name="FieldName" select="@name"/>
										</xsl:call-template>
									</xsl:attribute>
								</fieldOutput>
							</output>
						</command>
					</xsl:for-each>
					<xsl:for-each select="$Table/columns/column[@type='uniqueidentifier' and @name=$Table/primaryKey/primaryKeyColumn/@columnName and not(@name=$Table/foreignKeys/foreignKey/foreignKeyColumn/@columnName)]">
						<command id="{@name}UniqueIdentifierCommand" type="Text" event="Inserting">
							<text>select newid()</text>
							<output>
								<fieldOutput>
									<xsl:attribute name="fieldName">
										<xsl:call-template name="LookUpModelFieldName">
											<xsl:with-param name="Model" select="$Model"/>
											<xsl:with-param name="FieldName" select="@name"/>
										</xsl:call-template>
									</xsl:attribute>
								</fieldOutput>
							</output>
						</command>
					</xsl:for-each>
					<xsl:for-each select="$Table/columns/column[@type='RAW' and @length=16 and @name=$Table/primaryKey/primaryKeyColumn/@columnName and not(@name=$Table/foreignKeys/foreignKey/foreignKeyColumn/@columnName)]">
						<command id="{@name}UniqueIdentifierCommand" type="Text" event="Inserting">
							<text>select sys_guid() from dual</text>
							<output>
								<fieldOutput>
									<xsl:attribute name="fieldName">
										<xsl:call-template name="LookUpModelFieldName">
											<xsl:with-param name="Model" select="$Model"/>
											<xsl:with-param name="FieldName" select="@name"/>
										</xsl:call-template>
									</xsl:attribute>
								</fieldOutput>
							</output>
						</command>
					</xsl:for-each>
				</xsl:if>
			</commands>
			<xsl:variable name="Details" select="$Model/dm:details/dm:detail"/>
			<xsl:if test="$DataModelSample = ''">
				<fields>
					<xsl:variable name="SummaryFields" select="$BaseFieldSet[position()&lt;=5]"/>
					<xsl:for-each select="$FieldListNodeSet/*">
						<field>
							<xsl:for-each select="attribute::*">
								<xsl:if test="not(name()='isBase' or name()='isForeignKey' or name()='isMoney' or name()='multiLine' or (name()='length' and (.>=65535 or parent::*/@type!='String' and parent::*/@type!='TimeSpan')))">
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
					<xsl:for-each select="$Details">
						<field name="{@fieldName}" type="DataView">
							<xsl:attribute name="label">
								<xsl:choose>
									<xsl:when test="@label!=''">
										<xsl:value-of select="@label"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="ontime:FormatAsLabel(@fieldName, $LabelFormatExpression)"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<dataView controller="{@model}" view="grid1">
								<xsl:attribute name="filterFields">
									<xsl:value-of select="ontime:ResolveFilterFields(@filterFields, $Model)"/>
								</xsl:attribute>
							</dataView>
						</field>
					</xsl:for-each>
				</fields>
				<views>
					<xsl:variable name="SortColumns" select="$Model/dm:columns/dm:column[@sortOrder!='']"/>
					<!-- grid view -->
					<view id="grid1" type="Grid" commandId="command1">
						<xsl:attribute name="label">
							<xsl:value-of select="ontime:FormatAsLabel(ontime:CustomizeLabel($BOName, $CustomLabelMap), $LabelFormatExpression)"/>
						</xsl:attribute>
						<xsl:choose>
							<xsl:when test="$SortColumns">
								<xsl:attribute name="sortExpression">
									<xsl:for-each select="$SortColumns">
										<xsl:sort select="@sortOrder" data-type="number" order="ascending"/>
										<xsl:if test="position()>1">
											<xsl:text>, </xsl:text>
										</xsl:if>
										<xsl:value-of select="@fieldName"/>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="@sortType='Ascending'">
												<xsl:text>asc</xsl:text>
											</xsl:when>
											<xsl:otherwise>desc</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</xsl:attribute>
							</xsl:when>
							<xsl:when test="$SiteContentEnabled and (contains($BOName,'SiteContent') or contains($BOName,'site_content') or contains($BOName,'SITE_CONTENT'))">
								<xsl:attribute name="sortExpression">
									<xsl:text>Path, FileName</xsl:text>
								</xsl:attribute>
							</xsl:when>
						</xsl:choose>
						<headerText>
							<xsl:text>$DefaultGridViewDescription</xsl:text>
						</headerText>
						<dataFields>
							<xsl:choose>
								<xsl:when test="$ModelDetected">
									<xsl:call-template name="RenderDataFields">
										<xsl:with-param name="FieldList" select="$FilteredFieldList/*"/>
										<xsl:with-param name="Count" select="$MaxNumberOfDataFieldsInGridView"/>
										<xsl:with-param name="Model" select="$Model"/>
									</xsl:call-template>
									<xsl:for-each select="$Details[@list='true']">
										<dataField fieldName="{@fieldName}">
											<xsl:if test="@pageSize!=''">
												<dataView pageSize="{@pageSize}"/>
											</xsl:if>
										</dataField>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="RenderDataFields">
										<xsl:with-param name="FieldList" select="$BaseFieldSet[@name=$FirstRequiredField]"/>
										<xsl:with-param name="Count" select="count($FirstRequiredField)"/>
										<xsl:with-param name="Model" select="$Model"/>
									</xsl:call-template>
									<xsl:call-template name="RenderDataFields">
										<xsl:with-param name="FieldList" select="$BaseFieldSet[not(@name=$FirstRequiredField)]"/>
										<xsl:with-param name="Count" select="$MaxNumberOfDataFieldsInGridView - count($FirstRequiredField)"/>
										<xsl:with-param name="Model" select="$Model"/>
									</xsl:call-template>
									<xsl:call-template name="RenderDataFields">
										<xsl:with-param name="FieldList" select="$AdditionalFieldSet"/>
										<xsl:with-param name="Count" select="$MaxNumberOfDataFieldsInGridView - count($BaseFieldSet)"/>
										<xsl:with-param name="Model" select="$Model"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
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
							<xsl:choose>
								<xsl:when test="$ModelDetected">
									<category id="c1" headerText="{$ViewLabel}">
										<description>
											<xsl:text>$DefaultEditDescription</xsl:text>
											<!--<xsl:text>These are the fields of the </xsl:text>
								<xsl:value-of select="ontime:ToLower($ViewLabel)"/>
								<xsl:text> record that can be edited.</xsl:text>-->
										</description>
										<dataFields>
											<xsl:call-template name="RenderDataFields">
												<xsl:with-param name="FieldList" select="$FilteredFieldList/*"/>
												<xsl:with-param name="Count" select="count($FilteredFieldList/*)"/>
												<xsl:with-param name="Model" select="$Model"/>
											</xsl:call-template>
										</dataFields>
									</category>
									<xsl:for-each select="$Details[@edit='true']">
										<category id="d{position()}">
											<xsl:if test="@tab!=''">
												<xsl:attribute name="tab">
													<xsl:value-of select="@tab"/>
												</xsl:attribute>
											</xsl:if>
											<xsl:if test="@flow='row'">
												<xsl:attribute name="flow">
													<xsl:text>NewRow</xsl:text>
												</xsl:attribute>
											</xsl:if>
											<dataFields>
												<dataField fieldName="{@fieldName}">
													<xsl:if test="@pageSize!=''">
														<dataView pageSize="{@pageSize}"/>
													</xsl:if>
												</dataField>
											</dataFields>
										</category>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
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
								</xsl:otherwise>
							</xsl:choose>
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
							<category id="c1">
								<description>
									<xsl:text>$DefaultNewDescription</xsl:text>
									<!--<xsl:text>Complete the form. Make sure to enter all required fields.</xsl:text>-->
								</description>
								<dataFields>
									<xsl:choose>
										<xsl:when test="$ModelDetected">
											<xsl:call-template name="RenderDataFields">
												<xsl:with-param name="FieldList" select="$FilteredFieldList/*"/>
												<xsl:with-param name="Count" select="count($FilteredFieldList/*)"/>
												<xsl:with-param name="Model" select="$Model"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="RenderDataFields">
												<xsl:with-param name="FieldList" select="$InsertFieldSet"/>
												<xsl:with-param name="Count" select="count($InsertFieldSet)"/>
												<xsl:with-param name="Model" select="$Model"/>
												<xsl:with-param name="AllFields" select="$FieldListNodeSet/*"/>
											</xsl:call-template>
											<xsl:call-template name="RenderDataFields">
												<xsl:with-param name="FieldList" select="$InsertFieldSet2"/>
												<xsl:with-param name="Count" select="count($InsertFieldSet2)"/>
												<xsl:with-param name="Model" select="$Model"/>
												<xsl:with-param name="AllFields" select="$FieldListNodeSet/*"/>
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</dataFields>
							</category>
							<xsl:for-each select="$Details[@create='true']">
								<category id="d{position()}">
									<xsl:if test="@tab!=''">
										<xsl:attribute name="tab">
											<xsl:value-of select="@tab"/>
										</xsl:attribute>
									</xsl:if>
									<xsl:if test="@flow='row'">
										<xsl:attribute name="flow">
											<xsl:text>NewRow</xsl:text>
										</xsl:attribute>
									</xsl:if>
									<dataFields>
										<dataField fieldName="{@fieldName}">
											<xsl:if test="@pageSize!=''">
												<dataView pageSize="{@pageSize}"/>
											</xsl:if>
										</dataField>
									</dataFields>
								</category>
							</xsl:for-each>
						</categories>
					</view>
				</views>
			</xsl:if>
		</businessObject>
		<!--</xsl:if>-->
	</xsl:template>

	<xsl:template name="RenderDataFields">
		<xsl:param name="FieldList"/>
		<xsl:param name="Count"/>
		<xsl:param name="AllFields"/>
		<xsl:param name="Model" select="/.."/>
		<xsl:for-each select="$FieldList[position()&lt;=$Count]">
			<xsl:variable name="Name" select="@name"/>
			<xsl:variable name="FieldModel" select="$Model/dm:columns/dm:column[@fieldName = $Name]"/>
			<xsl:if test="$Model or count(ancestor::dataFields/dataField[@aliasFieldName=$Name]) = 0">
				<dataField fieldName="{@name}">
					<xsl:variable name="Self" select="."/>
					<xsl:if test="$FieldModel/@name != '' and contains($HideFieldNames,concat(';',$FieldModel/@name,';'))">
						<xsl:attribute name="hidden">
							<xsl:text>true</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="@textMode != ''">
						<xsl:copy-of select="@textMode"/>
					</xsl:if>
					<xsl:if test="not($Model)">
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
					</xsl:if>
					<xsl:choose>
						<xsl:when test="(not($Model) and @isForeignKey='true') or $FieldModel/@aliasColumnName">
							<xsl:if test="$Model or $DiscoveryDepth>0">

								<xsl:variable name="AliasFieldName">
									<xsl:choose>
										<xsl:when test="$FieldModel and $FieldModel/@aliasColumnName">
											<xsl:variable name="AliasColumn" select="$FieldModel/@aliasColumnName"/>
											<xsl:variable name="AliasForeignKey" select="$FieldModel/@aliasForeignKey"/>
											<xsl:variable name="AliasColumnModel" select="$Model/dm:columns/dm:column[@name=$AliasColumn and @foreignKey=$AliasForeignKey]"/>
											<xsl:variable name="ForeignKeyModel" select="$Model/dm:foreignKeys/dm:foreignKey[@id=$AliasColumnModel/@foreignKey]"/>

											<xsl:choose>
												<xsl:when test="$AliasColumnModel/@fieldName">
													<xsl:value-of select="ontime:CleanIdentifier($AliasColumnModel/@fieldName)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="ontime:CleanIdentifier($AliasColumnModel/@name)"/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:when test="$AllFields">
											<xsl:variable name="NextField" select="$AllFields[@name=$Self/@name]/following-sibling::*[1]"/>
											<xsl:variable name="BusinessObjectName" select="./bo:items/@businessObject"/>
											<xsl:if test="$NextField/@sourceBusinessObject = $BusinessObjectName">
												<xsl:value-of select="$NextField/@name"/>
											</xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<xsl:variable name="NextField" select="following::*[1]"/>
											<xsl:variable name="BusinessObjectName" select="./bo:items/@businessObject"/>
											<xsl:if test="$NextField/@sourceBusinessObject = $BusinessObjectName">
												<xsl:value-of select="$NextField/@name"/>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>

								<xsl:if test="$AliasFieldName!=''">
									<xsl:attribute name="aliasFieldName">
										<xsl:value-of select="$AliasFieldName"/>
									</xsl:attribute>
								</xsl:if>
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
										<xsl:choose>
											<xsl:when test="not(@dataFormatString) or @dataFormatString='d' or @dataFormatString='D' or @dataFormatString='m' or @dataFormatString='M' or @dataFormatString='t' or @dataFormatString='T' or @dataFormatString='y' or @dataFormatString='Y'">
												<xsl:text>10</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>20</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
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
				</dataField>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="RenderInMode">
		<xsl:param name="Table"/>
		<xsl:param name="Mode"/>
		<xsl:param name="Model"/>
		<xsl:choose>
			<xsl:when test="$Model">
				<xsl:choose>
					<xsl:when test="$Mode = 'FROM'">
						<xsl:call-template name="RenderFROMExpression">
							<xsl:with-param name="Model" select="$Model"/>
							<xsl:with-param name="Table" select="$Table"/>
						</xsl:call-template>
						<xsl:if test=" $Model/dm:where">
							<xsl:text>where </xsl:text>
							<xsl:value-of select="$Model/dm:where"/>
							<xsl:text>
</xsl:text>
						</xsl:if>
						<xsl:variable name="SortColumns" select="$Model/dm:columns/dm:column[@sortOrder!='']"/>
						<xsl:if test="count($SortColumns)>0">
							<xsl:text>order by </xsl:text>
							<xsl:for-each select="$SortColumns">
								<xsl:sort select="@sortOrder" data-type="number"/>
								<xsl:if test="position() > 1">
									<xsl:text>, </xsl:text>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="dm:formula">
										<xsl:text>(</xsl:text>
										<xsl:value-of select="dm:formula"/>
										<xsl:text>)</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$Quote"/>
										<xsl:choose>
											<xsl:when test="@foreignKey">
												<xsl:value-of select="@foreignKey"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$Model/@alias"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:value-of select="$Quote"/>
										<xsl:text>.</xsl:text>
										<xsl:value-of select="$Quote"/>
										<xsl:value-of select="@name"/>
										<xsl:value-of select="$Quote"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text> </xsl:text>
								<xsl:choose>
									<xsl:when test="@sortType='Descending'">
										<xsl:text>desc</xsl:text>
									</xsl:when>
									<xsl:otherwise>asc</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="$Model/dm:columns/dm:column">
							<xsl:variable name="Name" select="@name"/>
							<xsl:variable name="FieldModel" select="."/>
							<xsl:variable name="First">
								<xsl:if test="position()=1">
									<xsl:value-of select="'true'"/>
								</xsl:if>
							</xsl:variable>
							<xsl:variable name="ForeignKeyID" select="@foreignKey"/>
							<xsl:variable name="ForeignKeys" select="$Model/dm:foreignKeys/dm:foreignKey[@id=$ForeignKeyID]/dm:foreignKeyColumn"/>
							<xsl:variable name="IsForeign">
								<xsl:choose>
									<xsl:when test="$ForeignKeyID != ''">
										<xsl:value-of select="'true'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="'false'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:variable name="IsCalculated" select="$FieldModel and $FieldModel/dm:formula"/>
							<xsl:variable name="Depth">
								<xsl:choose>
									<xsl:when test="$IsForeign = 'true'">
										<xsl:value-of select="1"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="0"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:variable name="Prefix">
								<xsl:if test="$IsForeign = 'true'">
									<xsl:value-of select="$ForeignKeys/../@id"/>
								</xsl:if>
							</xsl:variable>
							<xsl:variable name="Column" select="$Table/columns/column[@name = $Name]"/>
							<xsl:variable name="ForeignKey" select="$Model/dm:foreignKeys/dm:foreignKey[@id=$ForeignKeyID]"/>
							<xsl:variable name="ForeignColumn" select="$Table/../table[@name = $ForeignKey/@parentTableName][@schema = $ForeignKey/@parentTableSchema]/columns/column[@name=$Name]"/>
							<xsl:variable name="FieldToRender" select="ontime:useRightIf($IsForeign, ontime:useRightIf(not(not($IsCalculated)) and ($Mode != 'SELECT' or $DataModelSample != ''), $Column, $FieldModel), $ForeignColumn)"/>
							<xsl:for-each select="$FieldToRender">
								<xsl:call-template name="RenderField">
									<xsl:with-param name="Mode" select="$Mode"/>
									<xsl:with-param name="Depth" select="$Depth"/>
									<xsl:with-param name="Model" select="$Model"/>
									<xsl:with-param name="FieldModel" select="$FieldModel"/>
									<xsl:with-param name="First" select="$First"/>
									<xsl:with-param name="ReadOnly" select="$IsForeign"/>
									<xsl:with-param name="ChildForeignKey" select="$ForeignKeys"/>
									<xsl:with-param name="Prefix" select="$Prefix"/>
									<xsl:with-param name="OneToOne" select="$ForeignKey/@type='1-to-1'"/>
								</xsl:call-template>
							</xsl:for-each>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$Table/columns/column">
					<xsl:call-template name="RenderField">
						<xsl:with-param name="Mode" select="$Mode"/>
						<xsl:with-param name="Depth" select="0"/>
						<xsl:with-param name="First" select="position()=1"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="RenderFROMExpression">
		<xsl:param name="Model"/>
		<xsl:param name="Table"/>
		<xsl:param name="ForeignKey"/>
		<xsl:param name="ChildTableAlias">
			<xsl:if test="$ForeignKey">
				<xsl:value-of select="$ForeignKey/@id"/>
			</xsl:if>
		</xsl:param>
		<xsl:variable name="TableName">
			<xsl:choose>
				<xsl:when test="$ForeignKey">
					<xsl:value-of select="$ForeignKey/@parentTableName"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$Table/@name"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TableSchema">
			<xsl:choose>
				<xsl:when test="$ForeignKey">
					<xsl:value-of select="$ForeignKey/@parentTableSchema"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$Table/@schema"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TableAlias">
			<xsl:choose>
				<xsl:when test="$Model/@alias != ''">
					<xsl:value-of select="$Model/@alias"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ontime:ValidateName(ontime:CleanIdentifier($TableName))"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="not($ForeignKey)">
				<!--<xsl:text>from "schema"."table" "alias"</xsl:text>-->
				<xsl:text>from </xsl:text>
				<xsl:if test="$TableSchema!=''">
					<xsl:value-of select="$Quote"/>
					<xsl:value-of select="$TableSchema"/>
					<xsl:value-of select="$Quote2"/>
					<xsl:text>.</xsl:text>
				</xsl:if>
				<xsl:value-of select="$Quote"/>
				<xsl:value-of select="$TableName"/>
				<xsl:value-of select="$Quote2"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$Quote"/>
				<xsl:value-of select="$TableAlias"/>
				<xsl:value-of select="$Quote2"/>
				<xsl:text>&#13;&#10;</xsl:text>

				<xsl:for-each select="$Model/dm:foreignKeys/dm:foreignKey[not(@baseForeignKey)]">
					<xsl:call-template name="RenderFROMExpression">
						<xsl:with-param name="Model" select="$Model"/>
						<xsl:with-param name="Table" select="$Table"/>
						<xsl:with-param name="ForeignKey" select="."/>
						<xsl:with-param name="ChildTableAlias" select="ontime:ValidateName(ontime:CleanIdentifier($TableAlias))"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="ForeignKeyID" select="$ForeignKey/@id"/>
				<xsl:variable name="Prefix" select="$ForeignKey/@id"/>
				<xsl:variable name="ChildForeignKey" select="$ForeignKey/dm:foreignKeyColumn"/>
				<xsl:variable name="DependentFKs" select="$Model/dm:foreignKeys/dm:foreignKey[@baseForeignKey = $ForeignKeyID]"/>

				<xsl:variable name="LeftJoinDef">
					<xsl:text>&#9;left join </xsl:text>
					<xsl:if test="$TableSchema!=''">
						<xsl:value-of select="$Quote"/>
						<xsl:value-of select="$TableSchema"/>
						<!--<xsl:text>"."</xsl:text>-->
						<xsl:value-of select="$Quote2"/>
						<xsl:text>.</xsl:text>
					</xsl:if>
					<xsl:value-of select="$Quote"/>
					<xsl:value-of select="$TableName"/>
					<!--<xsl:text>" "</xsl:text>-->
					<xsl:value-of select="$Quote2"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$Quote"/>
					<xsl:value-of select="ontime:ValidateName($Prefix)"/>
					<!--<xsl:text>" on </xsl:text>-->
					<xsl:value-of select="$Quote2"/>
					<xsl:text> on </xsl:text>
					<xsl:for-each select="$ChildForeignKey">
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
						<xsl:text>&#13;&#10;</xsl:text>
					</xsl:for-each>
				</xsl:variable>
				<xsl:if test="ontime:AllowObject($LeftJoinDef)">
					<xsl:value-of select="$LeftJoinDef"/>
				</xsl:if>

				<xsl:for-each select="$DependentFKs">
					<xsl:call-template name="RenderFROMExpression">
						<xsl:with-param name="Model" select="$Model"/>
						<xsl:with-param name="Table" select="$Table"/>
						<xsl:with-param name="ForeignKey" select="."/>
						<xsl:with-param name="ChildTableAlias" select="$Prefix"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="RenderField">
		<xsl:param name="Mode" select="'Field'"/>
		<xsl:param name="Prefix" select="''"/>
		<xsl:param name="ReadOnly" select="'false'"/>
		<xsl:param name="TableIDList"/>
		<xsl:param name="Model" select="/.."/>
		<xsl:param name="FieldModel"/>
		<xsl:param name="ChildTableAlias">
			<xsl:choose>
				<xsl:when test="$Model and $Model/@alias">
					<xsl:value-of select="$Model/@alias"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ontime:CleanIdentifier(ancestor::table[1]/@name)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="ChildForeignKey"/>
		<xsl:param name="Depth"/>
		<xsl:param name="OneToOne"/>
		<xsl:param name="First" select="'false'"/>

		<xsl:if test="not($Model) and $OneToOne">
			<xsl:call-template name="EnumerateParentColumns">
				<xsl:with-param name="Depth" select="$Depth"/>
				<xsl:with-param  name="ReadOnly" select="$ReadOnly"/>
				<xsl:with-param  name="TableIDList" select="$TableIDList"/>
				<xsl:with-param  name="OneToOne" select="$OneToOne"/>
				<xsl:with-param  name="Prefix" select="$Prefix"/>
				<xsl:with-param  name="ChildTableAlias" select="$ChildTableAlias"/>
				<xsl:with-param  name="Mode" select="$Mode"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$Mode='Field'">
				<xsl:variable name="Table" select="ancestor::table[1]"/>
				<xsl:variable name="Self" select="."/>
				<xsl:variable name="FieldName">
					<xsl:choose>
						<xsl:when test="$FieldModel and $FieldModel/@fieldName != ''">
							<xsl:value-of select="$FieldModel/@fieldName"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="ontime:ValidateName(concat(ontime:ValidateName($Prefix), ontime:EnsureFirstUpperCaseLetter($Prefix, ontime:CleanIdentifier(@name))))"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="DataType">
					<xsl:choose>
						<xsl:when test="$FieldModel and $FieldModel/@dataType">
							<xsl:value-of select="$FieldModel/@dataType"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="@dataType"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="ForeignKey2">
					<xsl:choose>
						<xsl:when test="$DataModel='required' or $FieldModel">
							<xsl:if test="$FieldModel and not($FieldModel/@*[name()='foreignKey'])">
								<xsl:copy-of select="$Model/dm:foreignKeys/dm:foreignKey[dm:foreignKeyColumn/@columnName=$Self/@name and not(@baseForeignKey)]"/>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="$Table/foreignKeys/foreignKey[foreignKeyColumn/@columnName=$Self/@name]"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="ForeignKey" select="ontime:useRightIf($DataModel='required' or $FieldModel,  msxsl:node-set($ForeignKey2)/foreignKey, msxsl:node-set($ForeignKey2)/dm:foreignKey)"/>
				<xsl:variable name="ForeignSchema" select="$ForeignKey/@parentTableSchema"/>
				<xsl:variable name="ForeignName" select="$ForeignKey/@parentTableName"/>
				<xsl:variable name="ForeignTable" select="/dataModel/table[@name=$ForeignName and @schema = $ForeignSchema]"/>
				<xsl:variable name="ForeignModel" select="ontime:GetModelIfExists($ForeignSchema, $ForeignName, 0)"/>
				<xsl:variable name="ForeignModelName" select="ontime:GetModelName($ForeignSchema, $ForeignName, 0)"/>
				<xsl:variable name="IsCalculated" select="$FieldModel and $FieldModel/dm:formula"/>
				<xsl:variable name="LoweredName" select="ontime:ToLower(@name)"/>
				<xsl:if test="not($Depth &gt; 0 and ($ForeignKey and $Table))">
					<field name="{$FieldName}" type="{$DataType}">
						<xsl:if test="($ReadOnly='false' or $OneToOne) and @allowNulls='false'">
							<xsl:attribute name="allowNulls">
								<xsl:text>false</xsl:text>
							</xsl:attribute>
						</xsl:if>
						<xsl:if test="$Depth = 0 and ($Table/primaryKey/primaryKeyColumn/@columnName=@name or ($FieldModel and $FieldModel/@primaryKey='true'))">
							<xsl:attribute name="isPrimaryKey">
								<xsl:text>true</xsl:text>
							</xsl:attribute>
							<xsl:if test="$Table/primaryKey/primaryKeyColumn/@generator">
								<xsl:attribute name="generator">
									<xsl:value-of select="$Table/primaryKey/primaryKeyColumn/@generator"/>
								</xsl:attribute>
							</xsl:if>
						</xsl:if>
						<xsl:if test="@readOnly='true' or ($ReadOnly='true' and not($OneToOne)) or $IsCalculated">
							<xsl:attribute name="readOnly">
								<xsl:text>true</xsl:text>
							</xsl:attribute>
						</xsl:if>
						<xsl:if test="$OneToOne" >
							<!--<xsl:attribute name="oneToOne">
                <xsl:value-of select="ontime:ValidateName(ontime:CleanIdentifier(@name))"/>
              </xsl:attribute>-->
							<xsl:attribute name="isVirtual">
								<xsl:text>true</xsl:text>
							</xsl:attribute>
						</xsl:if>
						<xsl:if test="$FieldModel and $FieldModel/@format">
							<xsl:attribute name="dataFormatString">
								<xsl:value-of select="$FieldModel/@format"/>
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
						<xsl:if test="@onDemand='true' and ($DataType!='String' or @type='xml')">
							<xsl:attribute name="onDemand">
								<xsl:text>true</xsl:text>
							</xsl:attribute>
							<xsl:if test="$AllowBlobSupport='true'">
								<xsl:attribute name="sourceFields">
									<xsl:choose>
										<xsl:when test="$FieldModel and $FieldModel/@foreignKey">
											<xsl:for-each select="$Model/dm:foreignKeys/dm:foreignKey[@id=$FieldModel/@foreignKey]/dm:foreignKeyColumn">
												<xsl:variable name="ForeignKeyColumn" select="."/>
												<xsl:if test="position()>1">
													<xsl:text>,</xsl:text>
												</xsl:if>
												<xsl:value-of select="$Model/dm:columns/dm:column[@name=$ForeignKeyColumn/@columnName]/@fieldName"/>
											</xsl:for-each>
										</xsl:when>
										<xsl:otherwise>
											<xsl:for-each select="$Table/primaryKey/primaryKeyColumn">
												<xsl:if test="position()>1">
													<xsl:text>,</xsl:text>
												</xsl:if>
												<xsl:variable name="PKName" select="@columnName"/>
												<xsl:choose>
													<xsl:when test="$Model and $Model/dm:columns/dm:column[@name=$PKName]">
														<xsl:value-of select="$Model/dm:columns/dm:column[@name=$PKName]/@fieldName"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="@columnName"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:for-each>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
								<xsl:attribute name="onDemandHandler">
									<xsl:choose>
										<xsl:when test="$FieldModel and $FieldModel/@foreignKey">
											<xsl:variable name="FieldForeignKey" select="$Model/dm:foreignKeys/dm:foreignKey[@id=$FieldModel/@foreignKey]"/>
											<xsl:variable name="FieldForeignKeyModel" select="ontime:GetModelIfExists($FieldForeignKey/@parentTableSchema, $FieldForeignKey/@parentTableName, 0)"/>
											<xsl:value-of select="concat(ontime:CleanIdentifier($FieldForeignKey/@parentTableName), $FieldForeignKeyModel/dm:columns/dm:column[@name=$FieldModel/@name]/@fieldName)"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="concat(ontime:CleanIdentifier($Table/@name), $FieldName)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
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
						<xsl:if test="@onDemand='true' and $DataType='String'">
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
							<xsl:choose>
								<xsl:when test="$FieldModel and $FieldModel/@label != ''">
									<xsl:value-of select="$FieldModel/@label"/>
								</xsl:when>
								<xsl:when test="$FieldModel and $FieldModel/@fieldName != ''">
									<xsl:value-of select="ontime:FormatAsLabel($FieldModel/@fieldName, $CustomLabelMap)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="ontime:FormatAsLabel(ontime:CustomizeLabel(concat(ontime:EnsureFirstUpperCaseLetterInLabel(string.Empty, $Prefix, $LabelFormatExpression), ontime:EnsureFirstUpperCaseLetterInLabel($Prefix, @name, $LabelFormatExpression)), $CustomLabelMap), $LabelFormatExpression)"/>
								</xsl:otherwise>
							</xsl:choose>
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
						<xsl:if test="$ReadOnly='true'">
							<xsl:attribute name="sourceBusinessObject">
								<xsl:value-of select="./ancestor::table/@name"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:if test="($DataModel='required' and $ForeignModelName) or ($DataModel!='required' and $ForeignTable)">
							<xsl:variable name="ForeignKeyColumns" select="ontime:useRightIf($DataModel='required' or $FieldModel, $ForeignKey/foreignKeyColumn, $ForeignKey/dm:foreignKeyColumn)"/>
							<xsl:variable name="ForeignKeyCount" select="count($ForeignKeyColumns)"/>
							<xsl:variable name="FirstForeignKey" select="(not(not($FieldModel)) and $ForeignKeyColumns[1]/@columnName = $FieldModel/@name) or (not($FieldModel) and $ForeignKeyColumns[1]/@columnName = @name)"/>
							<xsl:choose>
								<xsl:when test="$ForeignKeyCount = 1 or $FirstForeignKey">
									<!-- only create first FK field as lookup and define copy-->
									<xsl:variable name="ItemsStyle">
										<xsl:choose>
											<xsl:when test="$Model/dm:foreignKeys/dm:foreignKey[ontime:StringEquals(@id,$ForeignModelName)]/@type='1-to-1'">
												<xsl:text>OneToOne</xsl:text>
											</xsl:when>
											<xsl:otherwise>Lookup</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<items style="{$ItemsStyle}">
										<xsl:attribute name="businessObject">
											<xsl:choose>
												<xsl:when test="$ForeignModelName">
													<xsl:value-of select="$ForeignModelName"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:if test="($ForeignKey/@parentTableSchema!='dbo' and $ForeignKey/@parentTableSchema!='') and $SchemaCount>1">
														<xsl:value-of select="ontime:CleanIdentifier($ForeignKey/@parentTableSchema)"/>
														<xsl:text>_</xsl:text>
													</xsl:if>
													<xsl:value-of select="ontime:CleanIdentifier($ForeignKey/@parentTableName)"/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>

										<xsl:if test="$ForeignKeyCount>1 or $ForeignModel">
											<xsl:variable name="DataValueField">
												<xsl:variable name="DataValueFKs" select="ontime:useRightIf($DataModel='', $ForeignKeyColumns[1], $ForeignKeyColumns)"/>
												<xsl:for-each select="$DataValueFKs">
													<xsl:if test="position()>1">
														<xsl:text>,</xsl:text>
													</xsl:if>
													<xsl:variable name="ParentColumnName" select="@parentColumnName"/>
													<xsl:choose>
														<xsl:when test="$ForeignModel and $ForeignModel/dm:columns/dm:column[@name=$ParentColumnName]/@fieldName">
															<xsl:value-of select="$ForeignModel/dm:columns/dm:column[@name=$ParentColumnName]/@fieldName"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="$ParentColumnName"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
											</xsl:variable>
											<xsl:attribute name="dataValueField">
												<xsl:value-of select="$DataValueField"/>
											</xsl:attribute>

											<xsl:variable name="DataTextField">
												<xsl:choose>
													<xsl:when test="$FieldModel and $ForeignModelName">
														<xsl:choose>
															<xsl:when test="$FieldModel/@aliasColumnName">
																<xsl:value-of select="$ForeignModel/dm:columns/dm:column[@name=$FieldModel/@aliasColumnName]/@fieldName"/>
																<!--<xsl:value-of select="/dataModel/table[@name=$ForeignModel/@baseTable and @schema=$ForeignModel/@baseSchema]/columns/column[@name=$FieldModel/@aliasColumnName]/@name"/>-->
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="$DataValueField"/>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:when>
													<xsl:when test="$ForeignModelName">
														<xsl:variable name="ForeignPrimaryKeys" select="$ForeignTable/primaryKey/primaryKeyColumn"/>
														<xsl:value-of select="$ForeignModel/dm:columns/dm:column[not($ForeignPrimaryKeys/@columnName=./@name) and not(@foreignKey)][1]/@fieldName"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:variable name="ForeignPrimaryKeys" select="$ForeignTable/primaryKey/primaryKeyColumn"/>
														<xsl:value-of select="$ForeignTable/columns/column[not($ForeignPrimaryKeys/@columnName=./@name)][1]/@name"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<xsl:if test="$DataTextField!='' and $ItemsStyle!='OneToOne'">
												<xsl:attribute name="dataTextField">
													<xsl:value-of select="$DataTextField"/>
												</xsl:attribute>
											</xsl:if>
										</xsl:if>

										<xsl:if test="$FirstForeignKey">
											<xsl:variable name="OtherFKColumns" select="$ForeignKeyColumns[@columnName!=$Self/@name]"/>
											<xsl:variable name="DependentForeignKeys">
												<xsl:if test="$ForeignModel">
													<xsl:text>,</xsl:text>
													<xsl:value-of select="$ForeignKey/@id"/>
													<xsl:text>,</xsl:text>
													<xsl:call-template name="FindDependentForeignKeys">
														<xsl:with-param name="Model" select="$Model"/>
														<xsl:with-param name="ForeignKeyID" select="$ForeignKey/@id"/>
													</xsl:call-template>
												</xsl:if>
											</xsl:variable>
											<xsl:variable name="OtherBorrowedColumns" select="$Model/dm:columns/dm:column[@foreignKey!='' and contains($DependentForeignKeys, concat(',', @foreignKey, ',')) and not(@name=$FieldModel/@aliasColumnName and @foreignKey=$FieldModel/@aliasForeignKey)]"/>
											<xsl:if test="count($OtherFKColumns) > 0 or count($OtherBorrowedColumns) > 0">
												<xsl:attribute name="copy">
													<!-- copy secondary FKs-->
													<xsl:for-each select="$OtherFKColumns">
														<xsl:variable name="FKColumn" select="."/>
														<xsl:choose>
															<xsl:when test="$Model and $Model/dm:columns/dm:column[@name=$FKColumn/@columnName]">
																<xsl:value-of select="$Model/dm:columns/dm:column[@name=$FKColumn/@columnName]/@fieldName"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="$FKColumn/@columnName"/>
															</xsl:otherwise>
														</xsl:choose>
														<xsl:text>=</xsl:text>
														<xsl:choose>
															<xsl:when test="$ForeignModel and $ForeignModel/dm:columns/dm:column[@name=$FKColumn/@parentColumnName]">
																<xsl:value-of select="$ForeignModel/dm:columns/dm:column[@name=$FKColumn/@parentColumnName]/@fieldName"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="$FKColumn/@columnName"/>
															</xsl:otherwise>
														</xsl:choose>
														<xsl:if test="position() != $ForeignKeyCount - 1">
															<xsl:text>, </xsl:text>
														</xsl:if>
													</xsl:for-each>
													<!-- copy 'borrowed' fields-->
													<xsl:if test="$ForeignModel and count($OtherBorrowedColumns) > 0">
														<xsl:if test="count($OtherFKColumns) > 0">
															<xsl:text>, </xsl:text>
														</xsl:if>
														<xsl:for-each select="$OtherBorrowedColumns">
															<xsl:variable name="BorrowedColumn" select="."/>
															<xsl:variable name="LocalForeignKey" select="$Model/dm:foreignKeys/dm:foreignKey[@id=$BorrowedColumn/@foreignKey]"/>
															<xsl:variable name="BorrowedForeignKey" select="$ForeignModel/dm:foreignKeys/dm:foreignKey[@parentTableSchema=$LocalForeignKey/@parentTableSchema and @parentTableName=$LocalForeignKey/@parentTableName and dm:foreignKeyColumn/@columnName=$LocalForeignKey/dm:foreignKeyColumn/@columnName and not(@parentTableSchema=$Model/@baseSchema and @parentTableName=$Model/@baseTable)]"/>
															<xsl:variable name="BorrowedColumnSourceList"
                                select="
                                    $ForeignModel/dm:columns/dm:column[@name=$BorrowedColumn/@name and @foreignKey=$BorrowedForeignKey/@id] |
                                    $ForeignModel/dm:columns/dm:column[@name=$BorrowedColumn/@name and not($BorrowedForeignKey) ]"/>

															<xsl:choose>
																<xsl:when test="$LocalForeignKey/@type='1-to-1'">
																	<xsl:variable name="BorrowedColumnSource1to1" select="$BorrowedColumnSourceList[last()]"/>
																	<!--borrowed column with equivalent relationship-->
																	<xsl:if test="$BorrowedColumn and $BorrowedColumnSource1to1">
																		<xsl:value-of select="$BorrowedColumn/@fieldName"/>
																		<xsl:text>=</xsl:text>
																		<xsl:value-of select="$BorrowedColumnSource1to1/@fieldName"/>
																		<xsl:if test="position() != count($OtherBorrowedColumns)">
																			<xsl:text>, </xsl:text>
																		</xsl:if>
																	</xsl:if>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:variable name="BorrowedColumnSource" select="$BorrowedColumnSourceList[1]"/>
																	<!--borrowed column with equivalent relationship-->
																	<xsl:if test="$BorrowedColumn and $BorrowedColumnSource">
																		<xsl:value-of select="$BorrowedColumn/@fieldName"/>
																		<xsl:text>=</xsl:text>
																		<xsl:value-of select="$BorrowedColumnSource/@fieldName"/>
																		<xsl:if test="position() != count($OtherBorrowedColumns)">
																			<xsl:text>, </xsl:text>
																		</xsl:if>
																	</xsl:if>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>
													</xsl:if>
												</xsl:attribute>
											</xsl:if>
										</xsl:if>
									</items>
								</xsl:when>
								<xsl:when test="$ForeignKeyCount > 1 and not($FirstForeignKey)">
									<xsl:attribute name="textMode">
										<xsl:text>Static</xsl:text>
									</xsl:attribute>
								</xsl:when>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="$IsCalculated">
							<xsl:attribute name="computed">
								<xsl:text>true</xsl:text>
							</xsl:attribute>
							<formula>
								<xsl:value-of select="$FieldModel/dm:formula/text()"/>
							</formula>
						</xsl:if>
						<xsl:if test="$LoweredName='password' or $LoweredName='pwd'">
							<xsl:attribute name="textMode">
								<xsl:text>Password</xsl:text>
							</xsl:attribute>
						</xsl:if>
					</field>
				</xsl:if>
			</xsl:when>
			<!-- Render SELECT expression -->
			<xsl:when test="$Mode='SELECT'">
				<xsl:choose>
					<xsl:when test="$First='true'">
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>select&#13;&#10;&#9;</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>&#9;,</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="$FieldModel and $FieldModel/dm:formula">
						<xsl:text>(</xsl:text>
						<xsl:copy-of select="$FieldModel/dm:formula/text()"/>
						<xsl:text>) </xsl:text>
						<xsl:value-of select="$Quote"/>
						<xsl:value-of select="$FieldModel/@fieldName"/>
						<xsl:value-of select="$Quote2"/>
						<xsl:text>
</xsl:text>
					</xsl:when>
					<xsl:otherwise>
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
						<xsl:choose>
							<xsl:when test="$FieldModel and $FieldModel/@fieldName != ''">
								<xsl:value-of select="$FieldModel/@fieldName"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:variable name="OutputPrefix" select="ontime:ValidateName($Prefix)"/>
								<xsl:value-of select="ontime:ValidateName(concat($OutputPrefix, ontime:EnsureFirstUpperCaseLetter($OutputPrefix, ontime:CleanIdentifier(@name))))"/>
							</xsl:otherwise>
						</xsl:choose>
						<!--<xsl:text>"</xsl:text>-->
						<xsl:value-of select="$Quote2"/>
						<xsl:text>&#13;&#10;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- Render FROM expression -->
			<xsl:when test="$Mode='FROM'">
				<xsl:variable name="Table" select="ancestor::table[1]"/>
				<xsl:choose>
					<xsl:when test="$First='true'">
						<xsl:variable name="TableName" select="$Table/@name"/>
						<xsl:variable name="TableSchema" select="$Table/@schema"/>
						<!--<xsl:text>from "</xsl:text>-->
						<xsl:text>from </xsl:text>
						<xsl:if test="$TableSchema!=''">
							<xsl:value-of select="$Quote"/>
							<xsl:value-of select="$TableSchema"/>
							<!--<xsl:text>"."</xsl:text>-->
							<xsl:value-of select="$Quote2"/>
							<xsl:text>.</xsl:text>
						</xsl:if>
						<xsl:value-of select="$Quote"/>
						<xsl:value-of select="$TableName"/>
						<!--<xsl:text>" "</xsl:text>-->
						<xsl:value-of select="$Quote2"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="$Quote"/>
						<xsl:value-of select="ontime:ValidateName($ChildTableAlias)"/>
						<!--<xsl:text>"&#13;&#10;</xsl:text>-->
						<xsl:value-of select="$Quote2"/>
						<xsl:text>&#13;&#10;</xsl:text>
					</xsl:when>
					<xsl:when test="$ReadOnly='true'">
						<!--and ($DataModel!='suggested' or not(ontime:hasFrom($Table, $ChildForeignKey)))-->
						<!--<xsl:text>&#9;left join "</xsl:text>-->
						<xsl:variable name="LeftJoin">
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
							<xsl:for-each select="$ChildForeignKey">
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
						</xsl:variable>
						<xsl:if test="ontime:AllowObject($LeftJoin)">
							<xsl:value-of select="$LeftJoin"/>
						</xsl:if>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="not($Model)">
			<xsl:call-template name="EnumerateParentColumns">
				<xsl:with-param name="Depth" select="$Depth"/>
				<xsl:with-param  name="ReadOnly" select="$ReadOnly"/>
				<xsl:with-param  name="TableIDList" select="$TableIDList"/>
				<xsl:with-param  name="OneToOne" select="$OneToOne"/>
				<xsl:with-param  name="Prefix" select="$Prefix"/>
				<xsl:with-param  name="ChildTableAlias" select="$ChildTableAlias"/>
				<xsl:with-param  name="Mode" select="$Mode"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="EnumerateParentColumns">
		<xsl:param name="Depth"/>
		<xsl:param name="ReadOnly"/>
		<xsl:param name="TableIDList"/>
		<xsl:param name="OneToOne"/>
		<xsl:param name="Prefix"/>
		<xsl:param name="ChildTableAlias"/>
		<xsl:param name="Mode"/>

		<xsl:variable name="Self" select="self::column"/>
		<xsl:variable name="ParentTable" select="ancestor::table[1]"/>
		<xsl:variable name="ForeignKeys" select="
			    $ParentTable/foreignKeys/foreignKey[foreignKeyColumn[1]/@columnName=$Self/@name and ($Depth!=1000 and ($Depth&lt;$DiscoveryDepth or @force='true'))] | 
			    $ParentTable/foreignKeys/foreignKey[foreignKeyColumn[1]/@columnName!=$Self/@name and $ReadOnly='true' and ($Depth!=1000 and ($Depth&lt;$DiscoveryDepth or @force='true'))]"/>
		<xsl:for-each select="$ForeignKeys">
			<xsl:variable name="ForeignKey" select="self::foreignKey"/>
			<xsl:variable name="Table" select="key('TablesKey', concat($ForeignKey/@parentTableSchema, '.', $ForeignKey/@parentTableName))"/>
			<xsl:if test="not(contains($TableIDList, generate-id($Table)))">
				<xsl:variable name="Columns" select="$Table/columns/column[not(contains($IgnoreFieldNames,concat(';',@name,';')))]"/>
				<xsl:variable name="IsOneToOneRelationship" select="$ParentTable/primaryKey/primaryKeyColumn/@columnName =$ForeignKey/foreignKeyColumn/@columnName and count($ParentTable/primaryKey/primaryKeyColumn)=1"/>
				<xsl:variable name="IsOneToOneTable" select="$Table/primaryKey/primaryKeyColumn/@columnName =$Table/foreignKeys/foreignKey/foreignKeyColumn/@columnName and count($Table/primaryKey/primaryKeyColumn)=1"/>
				<xsl:variable name="IsOneToOne" select="($Depth = 0 or $OneToOne) and $IsOneToOneRelationship"/>
				<xsl:variable name="FieldPrefix">
					<xsl:variable name="ParentPrefix">
						<xsl:choose>
							<xsl:when test="$IsOneToOneTable or $IsOneToOneRelationship">
								<!--<xsl:text>Xyz</xsl:text>-->
								<xsl:if test="not($OneToOne)">
									<!--<xsl:text>Abc</xsl:text>-->
									<xsl:value-of select="$Prefix"/>
								</xsl:if>
								<xsl:value-of select="$ForeignKey/@parentTableName"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$Prefix"/>
								<xsl:for-each select="$ForeignKey/foreignKeyColumn">
									<xsl:value-of select="ontime:Replace(ontime:Replace(@columnName, '^(.+?)(ID|CODE|NO)$', '$1'), '\s+', '')"/>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:if test="$ParentPrefix=$ChildTableAlias or $ParentTable/@name!=$Table/@name and $Table/primaryKey/primaryKeyColumn[@columnName = $ParentPrefix]">
						<xsl:text>The</xsl:text>
					</xsl:if>
					<xsl:value-of select="$ParentPrefix"/>
				</xsl:variable>
				<xsl:variable name="FirstRequiredColumn" select="$Columns[not($IsOneToOne) and not(@name=$Table/primaryKey/primaryKeyColumn/@columnName)and @allowNulls='false' and @dataType='String' and not(@onDemand='true' and (@dataType!='String' or @type='xml'))][1]"/>
				<xsl:variable name="FirstStringNullableColumn" select="$Columns[not($IsOneToOne) and not(@name=$Table/primaryKey/primaryKeyColumn/@columnName)and not(@allowNulls='false') and @dataType='String' and not(@onDemand='true' and (@dataType!='String' or @type='xml')) and not($FirstRequiredColumn)][1]"/>
				<xsl:variable name="FirstOtherNullableColumn" select="$Columns[not($IsOneToOne) and not(@name=$Table/primaryKey/primaryKeyColumn/@columnName)and not(@allowNulls='false') and  not(@onDemand='true') and not($FirstRequiredColumn) and not($FirstStringNullableColumn)][1]"/>
				<xsl:variable name="OneToOneColumns" select="$Columns[$IsOneToOne and not($ParentTable/primaryKey/primaryKeyColumn/@columnName = @name)]"/>
				<xsl:variable name="ControllerFields" select="$FirstRequiredColumn | $FirstStringNullableColumn | $FirstOtherNullableColumn | $OneToOneColumns"/>
				<xsl:for-each select="($ControllerFields | $Columns[ontime:AllowParentColumn(., $ParentTable)])[ontime:AllowObject(concat($FieldPrefix,@name))]">
					<xsl:call-template name="RenderField">
						<xsl:with-param name="Depth">
							<xsl:choose>
								<xsl:when test="$IsOneToOne and $Self/@name = $ParentTable/primaryKey/primaryKeyColumn/@columnName">
									<xsl:value-of select="$Depth"/>
								</xsl:when>
								<xsl:when test="$ControllerFields/@name=current()/@name">
									<xsl:value-of select="$Depth + 1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="1000"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="Prefix" select="$FieldPrefix" />
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
						<xsl:with-param name="ChildForeignKey" select="$ForeignKey/foreignKeyColumn"/>
						<xsl:with-param name="OneToOne" select="$IsOneToOne"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="FindDependentForeignKeys">
		<xsl:param name="Model"/>
		<xsl:param name="ForeignKeyID" select="'none'"/>
		<xsl:for-each select="$Model/dm:foreignKeys/dm:foreignKey[@baseForeignKey=$ForeignKeyID]">
			<xsl:value-of select="@id"/>
			<xsl:text>,</xsl:text>
			<xsl:call-template name="FindDependentForeignKeys">
				<xsl:with-param name="Model" select="$Model"/>
				<xsl:with-param name="ForeignKeyID" select="@id"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="LookUpModelFieldName">
		<xsl:param name="Model"/>
		<xsl:param name="FieldName"/>
		<xsl:choose>
			<xsl:when test="count($Model) &gt; 0">
				<xsl:value-of select="$Model/dm:columns/dm:column[@name = $FieldName]/@fieldName"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$FieldName"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
